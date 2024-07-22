Return-Path: <linux-kernel+bounces-258956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46173938F22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E15281C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC16CD16;
	Mon, 22 Jul 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsE7SiAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0513A8D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651718; cv=none; b=AzL20Ibf175jzwDTibzcYUSNyLT/3dZwNZHNRshvVq8tEjZ0NDRyD6bKJPQxT9Ih+UWgpYVQlbTwuj+T6Qw9vtbmgGuRvBzqsDwvQLhalwahNXSsbct7ekFhJC9rFAgA0gx5bP+PS8gdooffVwNIIbVc2zWhEt4N87CnLzTmq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651718; c=relaxed/simple;
	bh=DcMhNvxHCz7/9X+74PuaSWFaJ9c+bNH5mM29uH1i718=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxmHCSn3XR9VP4pYktTlA82oeNXSyLMoF237xKwBPim/7kG9FFVTInMGuaORlYlY0xyT/HvNMg4fTqrfCKa78B/ocHL0hWvSt69YHphSmkqAzY+AEyBX6V7B3trpY36a0Sa3xhNvJ0MqsaoY8X2XMOW9ViAg+C/aSB/LO+yAyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsE7SiAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44279C116B1;
	Mon, 22 Jul 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721651718;
	bh=DcMhNvxHCz7/9X+74PuaSWFaJ9c+bNH5mM29uH1i718=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TsE7SiAPBYyvX/ppdAqRZ3bdjqR+a5HBNaCi0GvQr+ZrXKu81A7oCFwFGa/Am87Zo
	 gBHSznyjwhxKG0xHCG3lhrUf8o8uwcoT/+VntoNMDoqer54UrgJDniHUaUlpWJWOTK
	 2fP+ZLsyoF2gHBbepe+IupF3WQYVkzVnAnWrvBl9/fnVL4v6FGj/T4XMPQow8TLtWP
	 OUIZv89EzA040ysOkJP0/Zfi5vlcS9Hr4vggiHJOIuTtBRzbLPEjtr/sdbvTuglmDL
	 EBr36/uu3inYTZ+pBWCz69hkE1WjA7jRZj2QDjAeoAc8mKNkLC5gtXEY9MDJUiw7Sa
	 DLTk6fDGCjlwA==
Message-ID: <1c4a5ec3-cf51-49d6-a62b-53c081aacb1b@kernel.org>
Date: Mon, 22 Jul 2024 14:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 33/37] kvx: Add support for cpuinfo
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>,
 Clement Leger <clement@clement-leger.fr>,
 Guillaume Thouvenin <thouveng@gmail.com>, Jules Maselbas <jmaselbas@zdiv.net>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-34-ysionneau@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240722094226.21602-34-ysionneau@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add support for cpuinfo on kvx arch.
> 
> Co-developed-by: Clement Leger <clement@clement-leger.fr>
> Signed-off-by: Clement Leger <clement@clement-leger.fr>
> Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
> Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
> Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> V1 -> V2: No changes
> V2 -> V3:
> - add missing function declaration for setup_cpuinfo()
> - replace printk(KERN_WARNING... with pr_warn(...
> ---
>  arch/kvx/include/asm/cpuinfo.h |  7 +++
>  arch/kvx/kernel/cpuinfo.c      | 95 ++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 arch/kvx/include/asm/cpuinfo.h
>  create mode 100644 arch/kvx/kernel/cpuinfo.c
> 
> diff --git a/arch/kvx/include/asm/cpuinfo.h b/arch/kvx/include/asm/cpuinfo.h
> new file mode 100644
> index 0000000000000..ace9b85fbafaf
> --- /dev/null
> +++ b/arch/kvx/include/asm/cpuinfo.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_KVX_CPUINFO_H
> +#define __ASM_KVX_CPUINFO_H
> +
> +extern void setup_cpuinfo(void);
> +
> +#endif /* __ASM_KVX_CPUINFO_H */
> diff --git a/arch/kvx/kernel/cpuinfo.c b/arch/kvx/kernel/cpuinfo.c
> new file mode 100644
> index 0000000000000..6d46fd2a1bd93
> --- /dev/null
> +++ b/arch/kvx/kernel/cpuinfo.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + *            Guillaume Thouvenin
> + */
> +
> +#include <linux/seq_file.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/of.h>
> +
> +unsigned long elf_hwcap __read_mostly;
> +
> +static int show_cpuinfo(struct seq_file *m, void *v)
> +{
> +	int cpu_num = *(unsigned int *)v;
> +	struct cpuinfo_kvx *n = per_cpu_ptr(&cpu_info, cpu_num);
> +
> +	seq_printf(m, "processor\t: %d\nvendor_id\t: Kalray\n", cpu_num);
> +
> +	seq_printf(m,
> +		   "copro enabled\t: %s\n"
> +		   "arch revision\t: %d\n"
> +		   "uarch revision\t: %d\n",
> +		   n->copro_enable ? "yes" : "no",
> +		   n->arch_rev,
> +		   n->uarch_rev);
> +
> +	seq_printf(m,
> +		   "bogomips\t: %lu.%02lu\n"
> +		   "cpu MHz\t\t: %llu.%03llu\n\n",
> +		   (loops_per_jiffy * HZ) / 500000,
> +		   ((loops_per_jiffy * HZ) / 5000) % 100,
> +		   n->freq / 1000000, (n->freq / 10000) % 100);
> +
> +	return 0;
> +}
> +
> +static void *c_start(struct seq_file *m, loff_t *pos)
> +{
> +	if (*pos == 0)
> +		*pos = cpumask_first(cpu_online_mask);
> +	if (*pos >= num_online_cpus())
> +		return NULL;
> +
> +	return pos;
> +}
> +
> +static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	*pos = cpumask_next(*pos, cpu_online_mask);
> +
> +	return c_start(m, pos);
> +}
> +
> +static void c_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +const struct seq_operations cpuinfo_op = {

Where is this used?

> +	.start = c_start,
> +	.next = c_next,
> +	.stop = c_stop,
> +	.show = show_cpuinfo,
> +};
> +

Best regards,
Krzysztof


