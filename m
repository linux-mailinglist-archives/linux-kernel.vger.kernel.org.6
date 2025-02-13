Return-Path: <linux-kernel+bounces-512978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00AA33FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D487165EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417FF23F41C;
	Thu, 13 Feb 2025 13:12:31 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D6C23F40B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452350; cv=none; b=nbcdXeLutreQtNDtKWk3ahxCSFYJpgi8IYS93qcBr+98wHF651LUYwNxyXsA7ChAFHAEtNDf1QyDWXf/hoD1d4Gdqw5EExG97pGC/4MyncmVFCZCcM2se6y8Y2YTnHUZ0DE6bMxRsSm++ZdEal0ycNeJzYM+RUcMzHIFQFkWtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452350; c=relaxed/simple;
	bh=FhrHHMtLFmbBN8/65Z4I0XPGXxIQ/8ARVV5MqM9sGuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6liyFgfFeaPXPZr5MQVEkplpnPNz1HYdswbYbjWEr/sMDzIf6zah0bgL4vqFxpI8zkuZyP68JcaFv52cgMZFEV/kufiNllg75Ylz1xJl5Sp/lDdMOeIuyTPGR5l4QTaCyYgdltrV/H8LHAaLAYNKfTg3wTbH6mnLZRqBrZSnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4F9544405;
	Thu, 13 Feb 2025 13:12:18 +0000 (UTC)
Message-ID: <1dc6fc96-1a3e-46fa-84be-ef6952d4fc35@ghiti.fr>
Date: Thu, 13 Feb 2025 14:12:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] riscv: Fix check_unaligned_access_all_cpus
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 jesse@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20250207161939.46139-11-ajones@ventanamicro.com>
 <20250207161939.46139-14-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250207161939.46139-14-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjvghsshgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr

On 07/02/2025 17:19, Andrew Jones wrote:
> check_vector_unaligned_access_emulated_all_cpus(), like its name
> suggests, will return true when all cpus emulate unaligned vector
> accesses. If the function returned false it may have been because
> vector isn't supported at all (!has_vector()) or because at least
> one cpu doesn't emulate unaligned vector accesses. Since false may
> be returned for two cases, checking for it isn't sufficient when
> attempting to determine if we should proceed with the vector speed
> check. Move the !has_vector() functionality to
> check_unaligned_access_all_cpus() in order for
> check_vector_unaligned_access_emulated_all_cpus() to return false
> for a single case.
>
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/traps_misaligned.c       |  6 ------
>   arch/riscv/kernel/unaligned_access_speed.c | 11 +++++++----
>   2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index aacbd9d7196e..4354c87c0376 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -609,12 +609,6 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>   {
>   	int cpu;
>   
> -	if (!has_vector()) {
> -		for_each_online_cpu(cpu)
> -			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> -		return false;
> -	}
> -
>   	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>   
>   	for_each_online_cpu(cpu)
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 161964cf2abc..02b485dc4bc4 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -403,13 +403,16 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
>   
>   static int __init check_unaligned_access_all_cpus(void)
>   {
> -	bool all_cpus_emulated, all_cpus_vec_unsupported;
> +	bool all_cpus_emulated;
> +	int cpu;
>   
>   	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> -	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
>   
> -	if (!all_cpus_vec_unsupported &&
> -	    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> +	if (!has_vector()) {
> +		for_each_online_cpu(cpu)
> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> +	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
> +		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
>   		kthread_run(vec_check_unaligned_access_speed_all_cpus,
>   			    NULL, "vec_check_unaligned_access_speed_all_cpus");
>   	}

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


