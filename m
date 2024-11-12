Return-Path: <linux-kernel+bounces-406327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD409C5D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91E91F22221
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27A206E6E;
	Tue, 12 Nov 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dOWdH7Ot"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239A206972
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429496; cv=none; b=NJ0hCkYTP7gUrV9D5VvBn2ywM7dVMqee33fqToj6q3QsIvU13F1nQmtoUFxYMJirm3324mS3klqLDc59YzmKsS6bxgZq2xf5ZOmUKr6koSs2S1m71wH+gDS5gW8npLceldJHtZMHj4mT5tFxScCiiXrTFaoZ4yatXzc8act8i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429496; c=relaxed/simple;
	bh=8WBgyMeYHgvEhtU9GzLxGVFWkhAn8EufhAFbO2fRa7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGmWYZXMw/bt0c4UUVj50djbeWPVCqDn4rppAM1LsfbArPLHxnz+W8o7LVz2X3ohPtDD6+U+l6XP0ZV8NDeCZfbjkU9LXYikZIphf6LP/AW77UEI3lGTIpoGwEHDauaS+e8PQ5V4s69QyhI4F3GEe/ULLlhViQ7uzuOyZiWDUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dOWdH7Ot; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4c303206eso21754505ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1731429493; x=1732034293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QahbWCS8hTGwqMrLrcuosaa/aqoxJrXN4Zy2WrZ7yI=;
        b=dOWdH7OtLheHyA8pbDg01GTSpxR6LMy8DVEabgzbwbqpyIzkrBsM3Lyd8qcNnqCweA
         SjxJNxY6sKJddRfygh4tvzRV+PfL099vCP2wxtSUpRZuadPCzE68i3LhkGrtoZn4qKum
         mqUn1tGaUmKHFQk3Fi9cCKQPwObbxYJ0S3AOzWRhMIokfLttvw2b7FN59bRuvc92XjSB
         Idl4ud+tZQAxY64Da1VOmX98BxU6b6mRROvMTkSQ9i8CeTcwA/qN0GxDX7yae5+HaoAY
         ufav2NZjR8dP5elfespBjgKpa2EBJsWfhLlom/cRMaf0odbtL+cf5iljwpUX8R5UudQE
         2pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429493; x=1732034293;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QahbWCS8hTGwqMrLrcuosaa/aqoxJrXN4Zy2WrZ7yI=;
        b=BUYopcQ0uP7bU6N9uDYtAfN4VNmaQPEwd8yuPE/bmf2exeJX2OX3w/zhBLHzlk4yZK
         BSa5gNBSf9BKVupgbszgrrvMFCXASMTOYmKXG8E9aLWKZFqOJZMB0JVEmuW2pXTXQk/2
         ubrr9tpiB3MivZot8E+QVcbaEUoxaEjZvxXRgqcapUFpp+HgWvda/DC2RWBYxtQ0mRON
         z7WHn7i9M+dYVCxPxULSkDEdVilZauPdS2EtICPp7HaHlwYkA/kpBj4MtCM4gmCxGx5B
         c5gTLVroxB01drU5R3OI6gZzyM86QWActnyWyqqPE9sn9V+FU/U4FzW7Lm2YeQmm8FxN
         N9tg==
X-Forwarded-Encrypted: i=1; AJvYcCUeiWuhAhr7tDD/osuoP6g+6DUUC9QB8VucExoQc8jwZcPsoIThWkM4vIlQqVzHiqb40WMGy+iczagcLP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWBtglTQp0RqJVdvNat3rtK+lvhqE7Rg4z6QI/jMGNRcsEEZc
	7OUMBdB3nGKJCqXvxBXZG0H99rWFA8WqTQNuxcISJC+MRYqid2E3p1H4mvWTPJA=
X-Google-Smtp-Source: AGHT+IEPZhlfK7Hi/4/C4KwHmgKsIykg4Irr6nbun1DGbSR/22naNCY+Y0aibSThLAOZQc43u005DQ==
X-Received: by 2002:a05:6e02:1f03:b0:3a5:e532:799d with SMTP id e9e14a558f8ab-3a6f19e86dcmr169417395ab.3.1731429493390;
        Tue, 12 Nov 2024 08:38:13 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787414a1sm2152236173.45.2024.11.12.08.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:38:13 -0800 (PST)
Message-ID: <338c06d8-627e-4ca9-b5d0-6ce87b5cc83c@sifive.com>
Date: Tue, 12 Nov 2024 10:38:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: THEAD_C901_ACLINT_SSWI should depend on
 ARCH_THEAD
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1097d054ed4c67f714679de1253e45a034e647a0.1731425416.git.geert+renesas@glider.be>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <1097d054ed4c67f714679de1253e45a034e647a0.1731425416.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 2024-11-12 9:31 AM, Geert Uytterhoeven wrote:
> The T-HEAD ACLINT S-mode IPI Interrupt Controller is only present on
> T-HEAD SoCs.  Hence add a dependency on ARCH_THEAD, to prevent asking

This is not correct. This interrupt controller is part of the T-HEAD CPU IP, so
it is included in SoCs from other vendors (Allwinner, Sophgo, etc.) that use
T-HEAD CPUs as well.

Regards,
Samuel

> the user about this driver when configuring a kernel without T-HEAD SoC
> support.
> 
> Fixes: 25caea955cc95050 ("irqchip: Add T-HEAD C900 ACLINT SSWI driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/irqchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 28c19bde55206847..3f4cfcbecc5a4041 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -617,6 +617,7 @@ config THEAD_C900_ACLINT_SSWI
>  	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
>  	depends on RISCV
>  	depends on SMP
> +	depends on ARCH_THEAD || COMPILE_TEST
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_IRQ_IPI_MUX
>  	help


