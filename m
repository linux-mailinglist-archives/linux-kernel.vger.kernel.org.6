Return-Path: <linux-kernel+bounces-538022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE159A493AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D018867A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED5253337;
	Fri, 28 Feb 2025 08:35:05 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB32512C1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731704; cv=none; b=Z/0MQlxv+LDDAktz+mpdBHvvKgv923YO7rCTghFy1si8aAshjMKv/7r4xU/4vDecfPPBhHztd5kTBPpcbaZnib5dlJEOnF/tDhCx5xG7dyHgNzr0SZ5foeYvlWhdbTRkhliEW4l1oCcsX1bCMa/x+fkVsKqJAEjLM/5jHiXHMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731704; c=relaxed/simple;
	bh=VgltBu1F5zEb6t5exCgm9lZAdDJU1K6nT4UfPrfzLt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx2NeCC6gNv3/Cl8uENJuiK8/4ozySPSFPP9AKVEtVjx6PyiVv/zeCHTnj6MksGPVSC4p6IjKChX81Q6yHLcSm4vruf4rp0MDOOXzFklbpADaeUjthMAJDp1Be6tf73v78Dp60TLBwIeHOZyES2ZcgVnc7EP9PpUAiKktBpby5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBBF941C7D;
	Fri, 28 Feb 2025 08:34:50 +0000 (UTC)
Message-ID: <45d7bf9c-58fe-4808-9454-ff1167ead9ab@ghiti.fr>
Date: Fri, 28 Feb 2025 09:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the __riscv_copy_vec_words_unaligned implementation
To: Tingbo Liao <tingbo.liao@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250227072721.5889-1-tingbo.liao@starfivetech.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250227072721.5889-1-tingbo.liao@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuddtheegjeeviedvtdfgffekiedvgeefieffhfeiieetudelveduteegtdeiuddtnecuffhomhgrihhnpehvvggtqdgtohhphidquhhnrghlihhgnhgvugdrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtugdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtuggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehtihhnghgsohdrlhhirghosehsthgrrhhfihhvvghtvggthhdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihs
 ehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Tingbo,

On 27/02/2025 08:27, Tingbo Liao wrote:
> Correct the VEC_S macro definition to fix the implementation
> of vector words copy in the case of unalignment in RISC-V.
>
> Signed-off-by: Tingbo Liao <tingbo.liao@starfivetech.com>
> ---
>   arch/riscv/kernel/vec-copy-unaligned.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
> index d16f19f1b3b6..7ce4de6f6e69 100644
> --- a/arch/riscv/kernel/vec-copy-unaligned.S
> +++ b/arch/riscv/kernel/vec-copy-unaligned.S
> @@ -11,7 +11,7 @@
>   
>   #define WORD_SEW CONCATENATE(e, WORD_EEW)
>   #define VEC_L CONCATENATE(vle, WORD_EEW).v
> -#define VEC_S CONCATENATE(vle, WORD_EEW).v
> +#define VEC_S CONCATENATE(vse, WORD_EEW).v
>   
>   /* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
>   /* Performs a memcpy without aligning buffers, using word loads and stores. */


That's a good catch, thanks.

However, your patch title should be prefixed with "riscv:" :

"[PATCH] riscv: Fix the __riscv_copy_vec_words_unaligned implementation"

And you miss the following Fixes tag:

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")

And then you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Can you respin a v2 with all those modifications please?

Thanks,

Alex




