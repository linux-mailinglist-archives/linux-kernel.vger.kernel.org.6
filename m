Return-Path: <linux-kernel+bounces-524793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFBA3E731
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C12219C283D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070F1F03C4;
	Thu, 20 Feb 2025 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtmlIgx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1913AF2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089083; cv=none; b=K6L+bXaBn3P/U0cAGT7zdkCTVfmbqfyrYBClxSS+NvTAPCofotVK8vi0NHR5Icxst24BxIsNUAHMvesrRvedv6V0i5iX2QadA88f8xBZ68cmdGmPdd1PjGO9Sd8mnaMXsB47ZU5+00JkofcuAox/vNEnwjpDDAmmvAGYDR6olxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089083; c=relaxed/simple;
	bh=nPwHR3TbphPjuIADN9syT9I6nCusCt8NXwDMo8LbmfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPMdk9CRFumh66XP/1p1keAR9moXchuyV4YPTm0syleQGKcDGxPeekQG+GkPMWILQMmK2Bx5pz51bpQhWvN+SNP59b4YhFw8qTRZj++mYkCFC5NNuIzemkDNM5tBhGZHyyUrQFWBjpVgLtSAAjJP7AJVgWAI0WAIu/vjgCfAQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtmlIgx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B1C4CED1;
	Thu, 20 Feb 2025 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740089082;
	bh=nPwHR3TbphPjuIADN9syT9I6nCusCt8NXwDMo8LbmfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtmlIgx+s9ui6bO+FtD4t9vYwA2GkDDkmnEj98or9IvGSlgL3hiRgAsefhgYNrmiD
	 5BLQeW3wyeuR9CKzGrHlM/k952GKJW7Wlj2Li1Y9J8EfIxWG6jlTNtEsj1rxxwiJKy
	 XubrX+iTJyozGKk1cMSBkfmgGsLLBmgnr/Xf3uROR14sVCjP8eyBs47aoPLhozyWEy
	 rjwFmUCDR8qMeIYzi8QYFqm9rex6qpPQrF7q5eD8PJkKWpmfarVyamsUvfN6mELkTl
	 o+NzfGZX/cKqmzeW843csOs61jF6Yh48FYrBt61dJzE+J2QMpk4Amwx1Okx6ztzoMp
	 ZLW5imzquQfmw==
Date: Thu, 20 Feb 2025 14:04:40 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250220220440.ma5yfebhiovkqojt@jpoimboe>
References: <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>

On Tue, Feb 18, 2025 at 09:52:03AM +0100, Borislav Petkov wrote:
> On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> > IMO, make them generic from the start, then there's less churn and it's
> > easy to port the other arches.
> > 
> > If we went with putting everything in "mitigations=", making them
> > generic would be the obvious way to go anyway.
> 
> Just to make sure we're all on the same page: we obviously cannot enable
> and test and support a mitigaion on another arch like, say, arm64, or so.
> 
> This needs to come from the respective arch maintainers themselves and they'll
> have to say, yes, pls, enable it and we'll support it. We should not go "oh,
> this would be a good idea to do on all arches" without hearing from them
> first, even if it is a good idea on its face.
> 
> That's why those are x86-only as they should be initially.

I wasn't suggesting that this patch set should *enable* it on all
arches.  Of course that would need to be reviewed by the respective arch
maintainers.

But looking ahead, this *will* be needed for the other arches, for the
same reason we have a generic mitigations=off.  It's a user problem, not
an arch-specific one.  Users need a simple interface that works
everywhere.  That's why I suggested integrating it into "mitigations=".

-- 
Josh

