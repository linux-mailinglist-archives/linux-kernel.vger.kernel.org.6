Return-Path: <linux-kernel+bounces-531715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1300A4440C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EC63ABE59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65F26B095;
	Tue, 25 Feb 2025 15:10:34 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84B2571D3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496233; cv=none; b=muNhJEEsPWEsLUmDGTxkc2tH9nH37lWZVB6AT3TciiOjElz5QRP5GD4oOzkI5lJXlsfdrBUEQq2vTdSVmEBpa2upRBvQGM7EchkLfTee7b43vm+sID5StCupD53pGMwixUZPYsviKqOGXOyiqATb4Sk8pWfj2mhrsaEUJAUzkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496233; c=relaxed/simple;
	bh=BP/XHoToHe93F5T5VSSCBn4rLzyVdI7Oe9EzFBptkiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp/M6Z0Vch07Nko1VBYxhg8b+Wz/xo8TB9RxOSVd25tQSIGGLOVmpLQ+qmKF3BVVPCqwNNAnMLIl2xuZ5IKOjSRKfPYMsGYYZ4BGuG4vGFkn7maEWiqEHmkq4RjOUXodcSHVbDIfShxVcn4n9t7YTlxmwR+ioQkDw9Egdag18G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 100A244286;
	Tue, 25 Feb 2025 15:10:27 +0000 (UTC)
Message-ID: <4c7393a5-ad1a-4740-b454-a9b85682a78f@ghiti.fr>
Date: Tue, 25 Feb 2025 16:10:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] riscv/irq: use seq_put_decimal_ull_width() for
 decimal values
Content-Language: en-US
To: David Wang <00107082@163.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20241108162503.9914-1-00107082@163.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241108162503.9914-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvuddrvdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheptddtuddtjedtkedvseduieefrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi David,

On 08/11/2024 17:25, David Wang wrote:
> Performance improvement for reading /proc/interrupts on arch riscv
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>   arch/riscv/kernel/smp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index c180a647a30e..f1e9c3db094c 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -226,7 +226,8 @@ void show_ipi_stats(struct seq_file *p, int prec)
>   		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>   			   prec >= 4 ? " " : "");
>   		for_each_online_cpu(cpu)
> -			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
> +			seq_put_decimal_ull_width(p, " ",
> +						  irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
>   		seq_printf(p, " %s\n", ipi_names[i]);
>   	}
>   }


Very late answer sorry!

I don't have the same output before and after your patch because 
seq_put_decimal_ull_width() second argument is placed *before* the 
number, not after as it was before.

The following diff fixes the issue:

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c index 
f1e9c3db094c3..4b80ee4e5b2c0 100644 --- a/arch/riscv/kernel/smp.c +++ 
b/arch/riscv/kernel/smp.c @@ -225,9 +225,11 @@ void 
show_ipi_stats(struct seq_file *p, int prec) for (i = 0; i < IPI_MAX; 
i++) { seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : 
""); - for_each_online_cpu(cpu) - seq_put_decimal_ull_width(p, " ", + 
for_each_online_cpu(cpu) { + seq_put_decimal_ull_width(p, NULL, 
irq_desc_kstat_cpu(ipi_desc[i], cpu), 10); + seq_putc(p, ' '); + } 
seq_printf(p, " %s\n", ipi_names[i]); } }

Will you respin a new version?

Thanks,

Alex


