Return-Path: <linux-kernel+bounces-556694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0558A5CD82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F203A6A58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708CC263883;
	Tue, 11 Mar 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfyX1trx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADF2627EC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716831; cv=none; b=XUecUbnQ9sIfkiJizwGgg00zKO2gvoGXW6cOkE3HemmfVXsaMVrtUUwSDS2XHgVLznovU0n+JqeCVaU4wgIU+warBdsWfzcbS4nXCMQv+P3yO1E6vo+ogMFKnbMfK2eNYOJTAt8C0fKj7Sy8veeixs1PirO4GOD9n+PqIdtOSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716831; c=relaxed/simple;
	bh=cXeEF19DxsIvhCU468MqIFBIEu8EdcfdGkQCRwLdTrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8l2YzAGuR1//6FMNEbfGod7Wt+/VU4onT97V2WHsPShoZZZQu7ggzTsO0kkKUhRuI8llR9L1Zzo3BakSg//tI8moVzSD1XpQ8Bsysw2oE6AFBP8OxqVsd4d1g9bNCcb1f8gGBWvxeRmMIQRypgJ6y3Trd5Ch+21Pebwoy4XskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfyX1trx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66198C4CEEA;
	Tue, 11 Mar 2025 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716831;
	bh=cXeEF19DxsIvhCU468MqIFBIEu8EdcfdGkQCRwLdTrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfyX1trx/EccwwLbzWdaAudGQXy5b9nMnw+QVquoCqaZSgfl6hVvvXIAY/rRAfwYr
	 WVLjquiD+w/wM2tfq/29PMsoqu2E8aK5cb+9NAl8eYwpigHu2JltVq1kmmxKtlUKhh
	 9qseAYJZJiqOOdPnJZhxGZv7VlB6fr58XuvpGlSIxyxRZewELmgTy9nqiCZ3g7gIsR
	 MBfPq6PXQGzaYDOOcaUMCQuYwHWtslr0xxkU/lYe/Gjt2LiZ7kV24m36xosNArmZzx
	 UphkzBNqCZ1Luzl4gLoGawpT/9Kv3iT0FQvSV2tPOytnT0gYHwMHYkga6ayCtFwqvZ
	 Ts2jHykra/H3g==
Date: Tue, 11 Mar 2025 19:13:45 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9B9WWwfsraBoU41@example.org>
References: <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9AFyG7798M4VNJQ@suse.de>

On Tue, Mar 11, 2025 at 10:43:36AM +0100, Joerg Roedel wrote:
> On Mon, Mar 10, 2025 at 04:43:59PM +0100, Alexey Gladkov wrote:
> > If in the /sys/hypervisor we have information for guest (for running under
> > a hypervisor), where do you propose to put the information for the
> > host-side (for running as a hypervisor) ?
> 
> Okay, so let's not mix things up too much here. The only (upstream) case
> where Linux _is_ the hypervisor is when running KVM guests. What
> information needs to be provided for this case in SYSFS that is not
> already provided elsewhere, e.g. by the KVM modules or, in case of SEV,
> by /dev/sev? What does Intel expose for TDX?

Right now tdx does not export any information to userspace (neither
host-side nor guest-side). I want to change that. I want to export
version, attributes and features, maybe something else.

> Back to the guest-side, I agree with introducing a new directory in
> SYSFS with sub-directories for each detected hypervisor. To maximise
> confusion, it can be called '/sys/hypervisors/', or just /sys/guest/ (as
> Boris suggested).
> 
> Regards,
> 
> -- 
> Jörg Rödel
> jroedel@suse.de
> 
> SUSE Software Solutions Germany GmbH
> Frankenstraße 146
> 90461 Nürnberg
> Germany
> https://www.suse.com/
> 
> Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
> (HRB 36809, AG Nürnberg)
> 

-- 
Rgrds, legion


