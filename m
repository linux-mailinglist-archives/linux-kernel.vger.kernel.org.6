Return-Path: <linux-kernel+bounces-538510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4CA49983
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C81744FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89A26B2D5;
	Fri, 28 Feb 2025 12:38:23 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9626AABB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746303; cv=none; b=fMXuFNfwhKrcenB01E94be7hZoErMv4zwooQFH2TVUD7VnRumlQhGUtqZQpq4xi8VJ224ePt5qaWJCFUV7ZnW8MkqEDOUuOgfZ2/PaRDRO7ybSy365X0o/16d7eDZ8DGO8B3H9NwKzl5+uATXOy374sj/W98vU8omhwxgbLq354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746303; c=relaxed/simple;
	bh=EIcRVasJC025o6/4mA0xKPrn2lm35JhJ8GCsnKR0nIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9MTYHWDzwE8aIAx0NDwZAGcFC3FXIV9tdqM79Gd8x9DZKt+k4xK4Z+1vE6zJKxM/lWdev8b4AGKYJzrzIcz0teaidFcEuKlMgWvmm05a5ik8mQZC8nnksstu0Tu/kjvneDe34Zf0Z7adxsWSbvHWnUBTdx7QOjw2/4tXsAl0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BE0220578;
	Fri, 28 Feb 2025 12:38:09 +0000 (UTC)
Message-ID: <99529247-b489-4e10-afc8-3abe6fbd777e@ghiti.fr>
Date: Fri, 28 Feb 2025 13:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mm: Don't use %pK through printk
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250217-restricted-pointers-riscv-v1-1-72a078076a76@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250217-restricted-pointers-riscv-v1-1-72a078076a76@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepjeeiuedujeeikeevuedtgeeuhfekudeludegveehffefjedugeegudffgfeluefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeegrggvsgemugeifegumedvsgekheemvggttdgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeegrggvsgemugeifegumedvsgekheemvggttdgupdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeegrggvsgemugeifegumedvsgekheemvggttdgungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrt
 ghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Thomas,

On 17/02/2025 08:37, Thomas Weißschuh wrote:
> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
>
> Use regular pointer formatting instead.
>
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/riscv/mm/physaddr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> index 18706f457da7ecf84591510ea26789f7ae3e9abf..559d291fac5c62271a0e793321c97b87bf4e1b3c 100644
> --- a/arch/riscv/mm/physaddr.c
> +++ b/arch/riscv/mm/physaddr.c
> @@ -12,7 +12,7 @@ phys_addr_t __virt_to_phys(unsigned long x)
>   	 * Boundary checking aginst the kernel linear mapping space.
>   	 */
>   	WARN(!is_linear_mapping(x) && !is_kernel_mapping(x),
> -	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> +	     "virt_to_phys used for non-linear address: %p (%pS)\n",
>   	     (void *)x, (void *)x);
>   
>   	return __va_to_pa_nodebug(x);
>
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250217-restricted-pointers-riscv-62ca6d5fbf14
>
> Best regards,


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


