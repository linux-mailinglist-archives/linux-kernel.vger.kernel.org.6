Return-Path: <linux-kernel+bounces-534228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE1A46460
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3861D189C92C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0102222C6;
	Wed, 26 Feb 2025 15:16:59 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBF221DA1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583018; cv=none; b=JBLyWB2hb6Kv7IhXyfxHxzKYQzu8gX+ViwrLU2LqOoTCzaSVah99Vj1W1khTqgdlnlckqQZ2SN9WHZImdk0V4YkZYnS+9prsRSoyzlz1wUp0jiO1Ptjembsr2aCFoKv2ZzAjvo775vwknyydAcwQUoiWLW3ouZcoXI2JnQI2fxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583018; c=relaxed/simple;
	bh=gZftN9vnHWTjKMNbj6QirIP3uS4HfPaol0o2029dF4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYL5oD5EhNppNSs02D1d1EZDsJMx+8sYBWUSbIp9roykj7VMyi0gr2wrRrnxFkbLY03+ZjXPhpv5L9XV5ZvGk1vCcYSxCihO1zeTWyYTtXN6iGYFZxNothz+wZnbeK3r7zJFFP1PChQ/3pYUGEwHfuIFsn0spgAlpLicHHnAi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4798F2047A;
	Wed, 26 Feb 2025 15:16:47 +0000 (UTC)
Message-ID: <ed90f97a-35b4-4514-94d1-a699d673163c@ghiti.fr>
Date: Wed, 26 Feb 2025 16:16:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: remove redundant CMDLINE_FORCE check
Content-Language: en-US
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250114-rebund-v1-1-5632b2d54d6c@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250114-rebund-v1-1-5632b2d54d6c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehshigtrghmohhrvghmohhonhefjeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtr
 dgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Zixian,

On 13/01/2025 17:30, Zixian Zeng wrote:
> Drop redundant CMDLINE_FORCE check as it's already done in
> function early_init_dt_scan_chosen().
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
> ---
>   arch/riscv/kernel/setup.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 45010e71df86ce40f99fabf03103a49ad1041f3d..a08a8409aab01d504d3ad975fbf9c66c02992713 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -237,11 +237,6 @@ static void __init parse_dtb(void)
>   	} else {
>   		pr_err("No DTB passed to the kernel\n");
>   	}
> -
> -#ifdef CONFIG_CMDLINE_FORCE
> -	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> -	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
> -#endif
>   }
>   
>   #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
>
> ---
> base-commit: fa47906ff358a5865b7be2356a5a1d1e58dd17d8
> change-id: 20250113-rebund-25d469c1c4d5
>
> Best regards,


We lose the pr_info() but to me that's not a problem, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


