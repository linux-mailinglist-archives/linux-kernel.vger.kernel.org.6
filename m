Return-Path: <linux-kernel+bounces-429809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72149E2593
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FA287EAA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8341F76D9;
	Tue,  3 Dec 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g0oLlUba"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5714A088
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241732; cv=none; b=XgmT5mVURGw6AY7RVNSMMV8UXawsu+5Nuys4m1svNYVo7OpcqXfIxS5bk2QoR5hSWKxlliDR4Qd1vXNIz1s45ymYfodGSaZw/XdiZARBs7snZ856dBOXE0e25hPcRHGYa85wLUXtGCd2wOwAYu0DJKm+DK6UljAgAwBgI/ZGBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241732; c=relaxed/simple;
	bh=+4mrmWyTZWE7aCCuD7WX0ogXyiBhmTYam64FyTss/OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joyWKb0vivxexiSEvGQXCaicxeQ/syWV/zgKzPxtBAWVwPk+56fPxEwn1MhAJ+bulhWbYKjzI2I1GD3t1/BB082D+LGgDth1UnOW6lSIZY+Q/G0VOAie9oLfJss0dfDXHhQoKjup+FzYSRX4vhi4CiQiIMXpYWhgA5PsxCVkudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g0oLlUba; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3649C40E0269;
	Tue,  3 Dec 2024 16:02:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qi4ltd9liB1p; Tue,  3 Dec 2024 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733241722; bh=Da8ztEBd6tGjshSL+53XVwoH2c/TWIrC04L/xA+dUgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0oLlUbaqNLUnuo3ZNjSyxsQVC9stpguSVBqOpeQs5YROxl88pHuNKjbqtKII2119
	 x78XVnLQJ4QbrKLAn5LF9NDQwsg+8MeyPz7ppd1cYI2qw62WWDUQrlGxs964+HwuVs
	 A2CTbLAmFVdtDL78fPkf6zmYD4TZ53Be4jmO77fdMjkufHUGxPfEviXIRt2VJdxOiF
	 KouD5UD1Vxq4lGK+WuCj4gVqFCQJh4lrMcDDMoyWbqHOrmV1udFLt4skRt88uVyyPL
	 XvLIcV8Y5wecay7zkeKQNU25eStQ5JRrYT/pO4eVMR5/F8I2SzMKKzt/o0ZS54yaNZ
	 asQXq+BWar2W2DBJVpdfw6T3uPf/jQm99dT3iqMmvx++A/VHxOmMkrttn/KngEdnzO
	 fMer96uY+bheqQpDeJ3qfqYWJ2ofbTWOIm7G8i9pH8Gr/aUR6o9346p2f8VbjabxBi
	 BSF50Kl7SM391pHQyMmgPWmPD4C96Y96v1H5xQBCk78G9tYUg+IA/QmO4yvgZVFERF
	 SLcuQ6K34GJbxQFcF+QAinzBKaKSdFzXl8pG7e6AVxUQE5WyL+/pgi5F5y3DIxf9Ri
	 gm+kQRJlDAJxdmK40ZuIyoIDD4EQVjCPK3QZHBmxG7V/sesWxsxIJzAYfrwA991hrS
	 WfTGDUiaSOXfkhFTbGw5dgfw=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A161F40E0163;
	Tue,  3 Dec 2024 16:01:52 +0000 (UTC)
Date: Tue, 3 Dec 2024 17:01:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 1/8] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20241203160146.GDZ08rahZMYc3vyoxq@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com>

On Mon, Dec 02, 2024 at 02:50:46PM -0600, Tom Lendacky wrote:
> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *e, int *level)
> +{
> +	struct rmpentry e_large;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))

Btw, just a side note: this is AMD-specific and x86 code so we probably should
use:

	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))

For another series.

> +		return -ENODEV;
> +
> +	ret = get_rmpentry(pfn, e);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
>  	 * RMP entry or a special large RMP entry that is authoritative for a
>  	 * whole 2M area.
>  	 */
> -	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
> -	if (IS_ERR(large_entry))
> -		return large_entry;
> +	ret = get_rmpentry(pfn & PFN_PMD_MASK, &e_large);
> +	if (ret)
> +		return ret;
>  
> -	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
> +	*level = RMP_TO_PG_LEVEL(e_large.pagesize);
>  
> -	return entry;
> +	return 0;
>  }

...

>  static void dump_rmpentry(u64 pfn)
>  {
> +	struct rmpentry_raw *e_raw;
>  	u64 pfn_i, pfn_end;
> -	struct rmpentry *e;
> -	int level;
> +	struct rmpentry e;
> +	int level, ret;
>  
> -	e = __snp_lookup_rmpentry(pfn, &level);
> -	if (IS_ERR(e)) {
> -		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
> -		       pfn, PTR_ERR(e));
> +	ret = __snp_lookup_rmpentry(pfn, &e, &level);
> +	if (ret) {
> +		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
> +		       pfn, ret);
>  		return;
>  	}
>  
> -	if (e->assigned) {
> +	if (e.assigned) {
> +		e_raw = get_raw_rmpentry(pfn);
> +		if (IS_ERR(e_raw)) {
> +			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
> +			       pfn, PTR_ERR(e_raw));
> +			return;
> +		}
> +
>  		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
> -			pfn, e->lo, e->hi);
> +			pfn, e_raw->lo, e_raw->hi);
>  		return;
>  	}

Do I see it correctly that we don't really need to call that
get_raw_rmpentry() again for that @pfn because __snp_lookup_rmpentry()
returned the whole thing in @e already?

IOW:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index cf64e9384ea0..2e1833426b08 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -387,15 +387,8 @@ static void dump_rmpentry(u64 pfn)
 	}
 
 	if (e.assigned) {
-		e_raw = get_raw_rmpentry(pfn);
-		if (IS_ERR(e_raw)) {
-			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
-			       pfn, PTR_ERR(e_raw));
-			return;
-		}
-
-		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
-			pfn, e_raw->lo, e_raw->hi);
+		pr_info("PFN 0x%llx, RMP entry: [ASID: 0x%x, pagesize: 0x%x, immutable: %d]\n",
+			e.gpa, e.asid, e.pagesize, e.immutable);
 		return;
 	}
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

