Return-Path: <linux-kernel+bounces-409323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA29C8B48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F041F24D14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AE1FA851;
	Thu, 14 Nov 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OTACQh96"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE61F8900
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589122; cv=none; b=KZvwLuTRI3qupEYgTzQnL2YUx1zQxOrFBXaG7Xk9/bUBoU4tasLdrPf9gs8KuQJId/hpLeaIvKLlGyJX6k+O7vdtDUhX7tTlX3h3TVwYyPPJQyc4G27sst1XMk2d3GdGsCSY3dsKIOsfVbXHOMoEc+LArfPnOQhFEGDTzPN/Avw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589122; c=relaxed/simple;
	bh=xWQWMy/jdFMJaTh4AOC32fDnuGBgd4vNcEibca7nWT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKq/y2N1C/FPKY/wQKt+7gQEe7sA0cSNxtoNNij5RNecrRABSPj/YnZx29skPYE4/LnDznA/aAup5XE/CwIN1xUDK69TTpfXSiJCSRPvFOUdVIkKWVdIsOSBivCyoPFk/Qa7H736xKVRJ7g5IwVlco4tCLbySO8rIRTXb/5cacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OTACQh96; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2B9F40E0286;
	Thu, 14 Nov 2024 12:58:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5BlOkF5UHrcN; Thu, 14 Nov 2024 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731589111; bh=2/AlNgW6u7yIa6lOaXbDTi3Mq1hJf06A6eBH8f8bSJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTACQh96dk8K0SEzOD21FlLumOYDkSRoHaNlEh0DZsC+nFmoHytb8pF/3f6uZBA/2
	 itsgv3X1t/Am51VqNgsX67f5+/jnDvUCeSF2OXe3tOPlGINTo0lVHtI8h5R809tPE5
	 VrVvBzg68G1FfZT0ldRGB4+j8dM4vy2WoVAi/a7YrZ7qzkQqctldcDiq+oU2Ymtl83
	 J3zkHvFUmO9opxbd/12hjebwb69oW+PuZI+jWgxkne0Uq+b/k3/Sq32mrzJkh4grrH
	 2Ih5dR1MRlTCRW+pJGorfTpYirMPTnOtL6LR4w4hT1oh37vb7JhltTw0LBdKDbK0UA
	 DiQDwfXz6DCy6br0XZGX4jjPBAOj/OieCiIbqyvRNvlR85zI+xfTfa6iqvGo7tN3+V
	 2cK0hNKRY+1zaRvxYdpoHmd/wXDoxkzXlyE0cjg3Dt1VmNHQKFB3ZXQx5TJb3teitn
	 dNvvYY1WkydyEqOTRSH9Wha8S/n2ZKxQXOtZLBVMxw6oLjfnUVN81N9WKSyCHoTjNF
	 lXNxB+qWwC1r8/AnB9cK8B6xhsskwxFWnwafJz/gUxj3xvS+QSMcZPLBb5Wpl4vlCC
	 HDqX09pugzpP4K9G/A99zzDt/IsMPf+/t8Tuk6BTXPDeFl8CsTHnlWonPYu8XqC0g3
	 XYueF1SAOmJalDo/bYzxH7cs=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 854B540E015E;
	Thu, 14 Nov 2024 12:58:28 +0000 (UTC)
Date: Thu, 14 Nov 2024 13:58:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
Message-ID: <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018155151.702350-3-nik.borisov@suse.com>

On Fri, Oct 18, 2024 at 06:51:50PM +0300, Nikolay Borisov wrote:
> The result of that function is in essence boolean, so simplify to return
> the result of the relevant expression. It also makes it follow the
> convetion used by __verify_patch_section(). No functional changes.

convetion used by __verify_patch_section(). No functional changes.
Unknown word [convetion] in commit message.
Suggestions: ['convection', 'convention', 'conversion', 'confection', 'conviction', 'connection', 'confession']

You need a spellchecker. :)

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 9986cb85c951..37a428b109a2 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -282,7 +282,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
>   * exceed the per-family maximum). @sh_psize is the size read from the section
>   * header.
>   */
> -static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
> +static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
>  {
>  	u8 family = x86_family(bsp_cpuid_1_eax);
>  	u32 max_size;

You missed a spot here for the >= 0x15 families. And I think this is more
readable and more precise what is supposed to be checked here:

---
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8bd79ad63437..0211c62bc4c4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -289,7 +289,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
 	u32 max_size;
 
 	if (family >= 0x15)
-		return min_t(u32, sh_psize, buf_size);
+		return sh_psize == min_t(u32, sh_psize, buf_size);
 
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
@@ -306,7 +306,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
 		return 0;
 	}
 
-	return sh_psize <= min_t(u32, buf_size, max_size);
+	return sh_psize == min_t(u32, buf_size, max_size);
 }
 
 /*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

