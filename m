Return-Path: <linux-kernel+bounces-409093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433A9C87CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D1EB25BED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E81FBF65;
	Thu, 14 Nov 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VuM1hS3b"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED471FBF51
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579437; cv=none; b=swHRA39hnWMdZpE8TRG+tHX5LvmRjiZETFg2asLdg48PbtvLZrUlXLUj9KxSW+SuC9+iXjrV8P8BmClSNFEult7WUJAk6qFfH2Do5SJNolzuCJqOO+7qO07CKF+MiM3z96UxmbddXn0aAADIGl2ZmjWzV3T5/7iIWdh88tn6mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579437; c=relaxed/simple;
	bh=bbRSxCXwI8x4Rlo+zAX5DpYAkJBhneKuu+Tk5Pc+c7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omDMyVwRWh6fjFsuI55uzI+6hHGTXiGZX4w/LWqTnRsGDuaaJo9MkxLKtHCISrQ/jm43OmeMhq/apO163j0JAVBWumIKvFH4n2phmRyHeUsrIJ2GeaXv4G0FlUfZwvfPQhc1GYPxtubJJdI0jxUIuhSf6pa4+Jg/aLd7kNtWObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VuM1hS3b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B0B940E0286;
	Thu, 14 Nov 2024 10:17:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pCvRB5mzujel; Thu, 14 Nov 2024 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731579426; bh=kx+WcAxx0Lv5K6sGx4aODBrfJEzcQuxrEL03+dqgWlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuM1hS3b+Sz4wNqCVdQ/Xj7WvICZJ/IG04Ml6zRORcAwWvwLvFmD0rhHZbYEwwUSD
	 cpkWsGcrTSRX26iI1JuJJrIETYNSnuZkCcLczVOsfMS1fScko1TTtrMbcBQ/zveCUa
	 36qggvrfpodYXA2LR3iEVNFfopJz+Gr+nXuJihdHwgqGsAOAfjL16/afmOSnhPeelR
	 8H3PtNEydRPebJH9Loa1/mNAmPmdQwiPykdsgC79Gp/R+pMcRFC8I10ipLicKbjrCl
	 wtoCr+JAC1u5iWLi3xJZtFt0GNBmQrfHB5Xou2L1fL7titLCEpEnzXqpjxVN+herj8
	 osLLN5gU4uv+mlPkQM7l4H22HFgGKZzV1Yypuu+wVuIxjyyNg2OoAJ+Z70Jz3inDNy
	 PM+3qhXoqzBIGGbsu0E9lPpYKJJKvGJ4mi2sHcowEEOLlyaLRqutiJ9vy90+npy5s7
	 lxFo47gfKP6paYjR5g1VAKpMJWoa8OMooPzDLgxt7T/YsLdrZGAEp4xIBv+0AGiy31
	 r/AfIbgV9Hxg3rvPAEiMLjfA4+jYH+30wAM3HTJ8sbH0mG10M1gO6yKxnK+MxECO83
	 HxQr2FRkU2xjFbXkr8eHNdjJy7BGvplOJgycxhp/9K/QJA6ctd4DkMNgChswPLeG31
	 /J9PlB2ESW9HpZZzO92+DCHk=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D5CB40E0220;
	Thu, 14 Nov 2024 10:17:03 +0000 (UTC)
Date: Thu, 14 Nov 2024 11:16:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/microcode/AMD: Return bool from
 find_blobs_in_containers()
Message-ID: <20241114101655.GEZzXOFwoVyizZUNx6@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018155151.702350-2-nik.borisov@suse.com>

On Fri, Oct 18, 2024 at 06:51:49PM +0300, Nikolay Borisov wrote:
> @@ -562,6 +562,7 @@ static void __init find_blobs_in_containers(struct cpio_data *ret)
>  		cp = find_microcode_in_initrd(ucode_path);
>  
>  	*ret = cp;
> +	return cp.data && cp.size;

I guess we want this here ontop:

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 41b6f8a9e7e6..dfad4b26a662 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -561,12 +561,16 @@ static bool get_builtin_microcode(struct cpio_data *cp)
 static bool __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
+	bool found;
 
 	if (!get_builtin_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	*ret = cp;
-	return cp.data && cp.size;
+	found = cp.data && cp.size;
+	if (found)
+		*ret = cp;
+
+	return found;
 }
 
 void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

