Return-Path: <linux-kernel+bounces-410069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D659C962D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4F3B23677
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DD1B3932;
	Thu, 14 Nov 2024 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA6xtPEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854B1B21A0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627222; cv=none; b=dRV72PwHCJxIO8iDjkXD9jokF/ZXj/qeFy0iS4NCKsFrw/rfW9ASM30j/61PN6k/R8BAh4HFSuPoy/cA9Qi0VxGwe9MzdDYsvcTqgdoLMKA6cktD6WZHZvEhARACSkqSbzvDCdvrC0nsuIrGEsTlSZAAaqxlRafi0O4+xQrL2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627222; c=relaxed/simple;
	bh=omCc79bYybABmdBBhsGTaxHeJgXTvBT839jQBuzKSWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGRp5cviVynsSLqGMPag3T127pazQAw2XMyT9vDWshRk7zb9LW2jXFRifFW85/I6c/dKqewGxkxXaItBUB66yaotN3xHYaReP+c1hCecvFYx9N6J7pvsy7ZupyXt7fb3mjCkkCeZpCg40HSQH1ChIEpNPXD64kZ/xAZjgnZ7ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA6xtPEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814B3C4CECD;
	Thu, 14 Nov 2024 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731627221;
	bh=omCc79bYybABmdBBhsGTaxHeJgXTvBT839jQBuzKSWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA6xtPEdox2Ywj5Ow+ceVgAFAtHd4+CGFlIYZ1QgAPEn/TRhqSgZ9S8ZfJH7U6Dn+
	 Eue315HA6Wt5jrGhg1d0BxkgTdo4gWJgAF5mKQgSUv3ISnG4PZ45fm/0aVd1ddEiv6
	 VQBEzrhuqFvPtmAAL9jwnj1YtaoeGgVkN+l/70GoNPccbMSpfXNnQyrtJkcrWbdApo
	 0pKjzrFm0DKHkN/nUENMeWqiFzb9kdKAhlVWiT8TTdKelEhIRW+XR3P0Alh7iRXSTa
	 ZfK8yXXGXHFOyex2nmkcudkSALpjLoaVgfNVJ30FRIcYjtiOCASlaeUhe3xSKE5knH
	 NLMQhgE4Kjgcg==
Date: Thu, 14 Nov 2024 15:33:39 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Message-ID: <20241114233339.ouzvp7pjvlgrnezs@jpoimboe>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114161958.GIZzYjLgooyYCECCl0@fat_crate.local>
 <LV3PR12MB92653BF71C474E72CB2C81DB945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92653BF71C474E72CB2C81DB945B2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Nov 14, 2024 at 04:45:37PM +0000, Kaplan, David wrote:
> 1) the CPU is not vulnerable (it doesn't have the bug)
> 2) the CPU is vulnerable but mitigations=off was passed
> 3) the CPU is vulnerable but the bug-specific mitigation was disabled (e.g., retbleed=off)
> 4) the CPU is vulnerable, mitigations were not disabled, but no mitigation is available (perhaps it wasn't compiled in)
> 
> We absolutely should not print a message in case #1, because the CPU isn't vulnerable.  And we should probably always print a message in case 4 to warn the user.  Question is really about cases 2 and 3.
> 
> Today, some bugs print a message saying the CPU is vulnerable in case 2 and 3 (e.g., gds)
> Some bugs don't print a message in case 2, but do in case 3 (e.g., spectre_v1)
> Some don't print a message in case 2 or 3 (e.g., retbleed)
> 
> Case 4 is things like where you need SRSO mitigation but CONFIG_MITIGATION_SRSO was disabled.
> 
> So which do we want?  It would be nice to be consistent and I can do that while reworking these functions.
> 
> If we're going to argue that command line options mean the user knows
> what they're doing, that's probably an argument for saying do not
> print anything in cases 2 and 3 (since both relate to explicit command
> line options).  I'm not sure if it really makes sense to differentiate
> these cases.

IMO, mitigations=off shouldn't show any bug-specific messages, as user
doesn't care about the specifics, they just want everything off.

That said, they still might want to see some kind of "all mitigations
disabled" message to indicate the option actually worked.

For similar reasons I'd argue the bug-specific toggle should show a
bug-specific vulnerable message.

-- 
Josh

