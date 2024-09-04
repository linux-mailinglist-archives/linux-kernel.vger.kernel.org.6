Return-Path: <linux-kernel+bounces-314801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A396B8EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363C8B229B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94031CF5F5;
	Wed,  4 Sep 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g/gpBgqS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87E1482E1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446872; cv=none; b=gIcqUga0lRfJp5VbdYCSzZXQEGXYALT950kXIYSdlsOD44SpICkX5nV3CvZkmfB9ppbbpV1na5/YoiuIIeCdiGzTPkxuoHptxRgnsTFO3e1eX6zdEw4FTtDBrqQloDdhfW7tz5s4CZkz6cdHIJwScsZ+BXDClvVLmZzmEbFaUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446872; c=relaxed/simple;
	bh=B5OVeoqi0NnkvOqpxKgtOWIUB/Oylnn08PSh0Tl3nb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDdMERK5m6+v0y+XH96feU/BHgfg3y3sH/PiJKFMUhAjwv4oyCoFSIDeNrmqfCVI5Wbkgl005NM/LrOxe9QT3XwayD/DQcB/cMZhTY76rVGncRzby0vPnIj77oKbONq5yEwbjt3+pe3DC73AzST1JiD/QcSWf4OkDOMtt4vcK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g/gpBgqS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FF6C40E0198;
	Wed,  4 Sep 2024 10:47:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VTmnK6Kc6qDf; Wed,  4 Sep 2024 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725446862; bh=yo2QHSDYPbCvakwiEIi0T0uCFhXzAGwYYiIKKy/otAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/gpBgqS1SVkKHdgi0pZozcLcXIBjQGWPjT58ZN9xTc/7nmF7TiF1X7GG1DL4+2rQ
	 a81NerZgG91RCipv3XE2yK6RDx/dTk733labL3CAYqJZiGH2sjeuG5itOzs18u0zRc
	 4wiji8xvP4X5eSIkhcru2z2CBIp+ehjtsgvz5iOl0pEELu5Qdr7Y48qTcUjgXDzlcr
	 o+MFzjwsHG53J96MmSreWfzXTeduQo3S7KO2jfTqGIv752yTz3CRUsEidlVHDu9yp+
	 c9lkN43QD0ErSWhUR5glJ7eIMQs7qOi8b8W/WFsM0+Yjfm9/JB34sXTXF6mNhMei79
	 ovUAlmRApWBv51/Z8jAE8afFAKqLx4q45G0u4cBh4tyeXT4Kfdr7fqO9aSfCu47ei1
	 qB7kWxj5X+qCJsTfopMdxo358tvspd0MI+Xl/Rh3ll2QikRd55NesRcqjz4Mclo1gk
	 A1oZ4/h3SuZL+ibwlImxxErEkSMDh50XPWpfG9x0F2sc1pHx/k+ETONFck3xAy/ORN
	 GInzOeqa3Mzl6LgDMyfqwLnuI4CFEfBKP7+dPfwLz83lHs6PXWTpt+QTCutY7Pdh2/
	 v48m+/PEqaHYEG6G4lgKTX9ZDea4H5Mj+lPoxMCV40Bvw0dG41vfRuRd+agkEade5U
	 0tKmRk1LC56bAq+IO6BCQfcU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D5E940E0191;
	Wed,  4 Sep 2024 10:47:34 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:47:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 1/7] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20240904104728.GBZtg6wIgihDlsIgIS@fat_crate.local>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
 <310650b1c5a7936f1ebb0c14579ed23f825c0be3.1722368407.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <310650b1c5a7936f1ebb0c14579ed23f825c0be3.1722368407.git.thomas.lendacky@amd.com>

On Tue, Jul 30, 2024 at 02:40:01PM -0500, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP entry. This is the preferred method for examining RMP entries.
> 
> In preparation for using the RMPREAD instruction, convert the existing
> code that directly accesses the RMP to map the raw RMP information into
> the architecture defined format.
> 
> RMPREAD output returns a status bit for the 2MB region status. If the
> input page address is 2MB aligned and any other pages within the 2MB
> region are assigned, then 2MB region status will be set to 1. Otherwise,
> the 2MB region status will be set to 0. For systems that do not support
> RMPREAD, calculating this value would require looping over all of the RMP
> table entries within that range until one is found with the assigned bit
> set. Since this bit is not defined in the current format, and so not used
> today, do not incur the overhead associated with calculating it.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
>  1 file changed, 98 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 0ce17766c0e5..103a2dd6e81d 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -30,11 +30,27 @@
>  #include <asm/cmdline.h>
>  #include <asm/iommu.h>
>  
> +/*
> + * The RMP entry format as returned by the RMPREAD instruction.

I'm guessing this is the architectural variant...

> + */
> +struct rmpentry {
> +	u64 gpa;
> +	u8  assigned		:1,
> +	    rsvd1		:7;
> +	u8  pagesize		:1,
> +	    hpage_region_status	:1,
> +	    rsvd2		:6;
> +	u8  immutable		:1,
> +	    rsvd3		:7;
> +	u8  rsvd4;
> +	u32 asid;
> +} __packed;
> +
>  /*
>   * The RMP entry format is not architectural. The format is defined in PPR
>   * Family 19h Model 01h, Rev B1 processor.

... considering this thing?

>   */
> -struct rmpentry {
> +struct rmpentry_raw {

"raw"? Hm.

So what is the goal here?

Use rmpentry_raw for the kernel's representation and convert the format that
gets returned by RMPREAD into rmpentry_raw?

Because if so, the _raw thing is what comes from RMPREAD.

Because as it is now, it is begging to confuse people.

Because if you call the *new* entry differently, it won't cause any of the
churn you have to do below...

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

