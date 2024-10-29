Return-Path: <linux-kernel+bounces-386687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B569B46F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E7A283811
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59C2038D9;
	Tue, 29 Oct 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BMiymmGt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75588839E4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198026; cv=none; b=dz9FbIlQifz7QTmD/axFH3PFyyQf0frdiuE/5dh8IPNmTNqiNALPG+dAkZftVIst7K/r1rzUHzrhoTDdm7zUc8ND/lw+0yaxyHslewtep5xm7Zw/z9QOPTb19xwRlaqzE9ZBjA5oy6ACMdoHW1ycgfq3Q4R/LohHwk17ZTKx5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198026; c=relaxed/simple;
	bh=it7J2Bob8irKPIjKYAEc7Q2aE/YpuABi+6JVIsAQo5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYv41OT+rykZR8VbDUYM6xy5RsVF91f+6FgmWgrJV3T/o+x4IXWTy0JTeEq9lJqVhv0C88hDY0pVV8V5AlUakOCNwNji/Mq+j1Mbz/wHyNzpjopLQps4qgYtscUsqDXbh3X+m14EYMFaFB3z0l/LqTVaMxDnXxyuT/WmlTIcS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BMiymmGt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2062440E0192;
	Tue, 29 Oct 2024 10:33:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u74dP7gO3n1K; Tue, 29 Oct 2024 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730198016; bh=EoakwJJz9aJ0gsbJCEXWk7/6Dol69LY/LJRw1MqJfQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMiymmGtoJfWM9V2wPabtoll/HuIOcM4VPx+gHHAt2SXMrNAQq1REsQC+NRV5DQSS
	 O9fSMLTPQiy/78sNZ5amNXqHec7bB44taIS2terYMR8ONzZgbUMw1JrGjQYQ+tAFKs
	 7DFZMG8VGf9eYJkFUgGQjZYWkqttlkaq8yD0C2Mp44ovBdSAY5+SA/YViMGW+q+oMv
	 DoWKSVf5O6Vj19azz2+gS6H9c73MbS43W8boFC4ifdvvrDQeytVS5he0s4cpv+A7ih
	 E1mmCCI6LGTw3j1x0A5+3wAeCrjH9Wi/fqkX1alhr8+f3Lokdr1XcbxHMdMGFBQz93
	 ce8C9ItCGg3TtbmqA+cY8yHJN/zXg+q0m1R8pU7uw+ShA7+WRxq67ZgF3ImsBy7lsK
	 JPCLwJ3Yi08zhJr3S4uJgwpQ3nPruiHRrKieqYJ4z7UgXjkCZOp0HBPyaLCMic12dz
	 89PSyX0Z+U/zSuo4mPHcUuAXpjwoUdjjE6MJhllJk/FR8qR8042Jha2JGsIGio8Eip
	 rIBtUpwgAlq0rFDiS4/RyMUHqST+gsTcRe908biV8anIm4wp9RE1P9xKlRwpICFeOD
	 Dq340RjZBmlbGGfSiDFM181miE+z5P3WIS1jIk4+M71Kxr8hSvnayxfCQfmvkq0krg
	 0NgGChB5R5mGA/107WmR0oGM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C834340E0191;
	Tue, 29 Oct 2024 10:33:21 +0000 (UTC)
Date: Tue, 29 Oct 2024 11:33:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
Message-ID: <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029092329.3857004-1-arnd@kernel.org>

On Tue, Oct 29, 2024 at 09:23:20AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> node_to_amd_nb() is defined to NULL in non-AMD configs:
> 
> drivers/platform/x86/amd/hsmp/plat.c: In function 'init_platform_device':
> drivers/platform/x86/amd/hsmp/plat.c:165:68: error: dereferencing 'void *' pointer [-Werror]
>   165 |                 sock->root                      = node_to_amd_nb(i)->root;
>       |                                                                    ^~
> drivers/platform/x86/amd/hsmp/plat.c:165:68: error: request for member 'root' in something not a structure or union
> 
> Change the definition to something that builds. This does introduce a
> NULL pointer dereference but the code is never called since the driver
> won't probe successfully.
> 
> Fixes: 7d3135d16356 ("platform/x86/amd/hsmp: Create separate ACPI, plat and common drivers")
         ^^^^^^^^^^^^

I'm guessing this is queued for 6.13...

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/amd_nb.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 6f3b6aef47ba..d0caac26533f 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
>  
>  #define amd_nb_num(x)		0
>  #define amd_nb_has_feature(x)	false
> -#define node_to_amd_nb(x)	NULL
> +static inline struct amd_northbridge *node_to_amd_nb(int node)
> +{
> +	return NULL;
> +}
>  #define amd_gart_present(x)	false

... so this fix should go to Linus now so that build testing doesn't break?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

