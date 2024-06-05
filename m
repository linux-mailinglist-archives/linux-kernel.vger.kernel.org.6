Return-Path: <linux-kernel+bounces-202979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222758FD432
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76A42825A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9913A86E;
	Wed,  5 Jun 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgcDAUXf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYbiPqY3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975823D7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608995; cv=none; b=Dam9ZAn+65hs6ybbgJI1TUI07tTZiICA9E5a0Neh4EgmJwo6T/9pP+0Hmw1KMizQsWY0qECl0BXi6dsJYD96tIjDHwFU0+rRqtiaCQY0uu1KAqyiCZZliKwlltHeOOCbSpqfNpgr2YXm3egx3/rCkACddtqJKO64pDf0fQC0nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608995; c=relaxed/simple;
	bh=Ci0z1YQ5l+yJ27ZYSv4+DWee4yRKLebHzeM5OlLjhbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ht0+BFmukwtrC1M/HbjxxNO8/7eiAtV1b5kCIsVaVc6wij8AwZYLdN/InxyzLCG7G1THPLVVmc0jQ+PmOHz1V/Qe/hIQGE49jxoLo/iRROVv2jF9JkpWcbtOf/jHYeBoz9/aHFQDBl44fo59xVheXPNBwNdplSGrDy5rXXMTdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgcDAUXf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYbiPqY3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717608992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKoRv3TINyuAibH34/gIAUpP/JPugdLQyB+Ykxib+fc=;
	b=WgcDAUXfgnRlnV4/Vj2xnNEDqedJIYxtexqn5GHQpUFO82zyTmqy6t/BjfyIb1kNAwVIzb
	bWWCSOF52C6J/UlsyLCp5u4h+0Na2BFf6+Djyeok8XdgptOKEPWgIehSLDVFMBDYOvSKhm
	719rFopWX8y2YnhI+5w3JrYic8/lwxrswoh8Wu2WQ+MRLOpimXGVhWqSIATGDQXA7RiTgv
	UPRO6GIJvp9I/tGgsvoNsUHF/3eMXQ85T99oBdQSd8LNty6HawUVOvSAU3Heic5N5VdTOG
	nx59VTXevgMLHhjoo6PvYaMh+sGg1CQzHof3CO2KYGhfGY5g2FF4Lu7bX8O+ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717608992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKoRv3TINyuAibH34/gIAUpP/JPugdLQyB+Ykxib+fc=;
	b=EYbiPqY3VuiD+rdxdRakHAkCtae7GouPV6P9LrU4ARfvG8lh7hUTV2vIqqFbh1sbunNIrP
	eK2mq+TJWtREjBCQ==
To: Song Gao <gaosong@loongson.cn>, linux-kernel@vger.kernel.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: Re: [PATCH] irqchip/loongson-eiointc: Add extioi virt extension
 support
In-Reply-To: <20240605070229.2569875-1-gaosong@loongson.cn>
References: <20240605070229.2569875-1-gaosong@loongson.cn>
Date: Wed, 05 Jun 2024 19:36:31 +0200
Message-ID: <87a5jz47hc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 05 2024 at 15:02, Song Gao wrote:
> Currently IRQs can be routed to only 4 vcpus with one Hw extioi.

Can you please use proper words instead of acronyms?

Interrupts can be routed to maximal four virtual CPUs with one external
hardware interrupt.

> This patch adds the extioi virt extension support so that IRQs can

git grep 'This patch' Documentation/process/

> be routed to 256 vcpus on hypervior mode.
>
> Now IRQs is emulated in userspace, so the extioi virt device emulation
> is implemented in userspace firstly.

I'm failing to understand what this means and how this and the link are
relevant to the change log and the change itself.

> See:
>   https://patchew.org/QEMU/20240528083855.1912757-1-gaosong@loongson.cn/
>  
> +#define EXTIOI_VIRT_FEATURES           0x40000000
> +#define  EXTIOI_HAS_VIRT_EXTENSION     0
> +#define  EXTIOI_HAS_ENABLE_OPTION      1
> +#define  EXTIOI_HAS_INT_ENCODE         2
> +#define  EXTIOI_HAS_CPU_ENCODE         3
> +#define EXTIOI_VIRT_CONFIG             0x40000004
> +#define  EXTIOI_ENABLE                 1
> +#define  EXTIOI_ENABLE_INT_ENCODE      2
> +#define  EXTIOI_ENABLE_CPU_ENCODE      3

These are clearly bits. So why not define them as BIT(0), so you can
spare that at the usage site?

Also why defining all of this when there are only two defines used?

> +
>  #define VEC_REG_COUNT		4
>  #define VEC_COUNT_PER_REG	64
>  #define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
> @@ -41,6 +51,7 @@ struct eiointc_priv {
>  	cpumask_t		cpuspan_map;
>  	struct fwnode_handle	*domain_handle;
>  	struct irq_domain	*eiointc_domain;
> +	bool			cpu_encoded;
>  };
>  
>  static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
> @@ -56,7 +67,9 @@ static void eiointc_enable(void)
>  
>  static int cpu_to_eio_node(int cpu)
>  {
> -	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
> +	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);

Pointless brackets.

> +
> +	return cpu_logical_map(cpu) / cores;
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -88,6 +101,20 @@ static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode,
>  
>  static DEFINE_RAW_SPINLOCK(affinity_lock);
>  
> +static void virt_extioi_set_irq_route(int irq, unsigned int cpu)

unsigned int irq;

But this is about vectors not interrupts. So please name it
accordingly. 'irq' is just confusing. I had to look up the call site to
figure out what this is about.

> +{
> +        int data;

This represents a hardware register value, so the data type wants to be
u32, no?

> +        /*
> +         * get irq route info for continuous 4 vectors
> +         * and set affinity for specified vector
> +         */
> +        data = iocsr_read32(EIOINTC_REG_ROUTE + (irq & ~3));
> +        data &=  ~(0xff << ((irq & 3) * 8));
> +        data |= cpu_logical_map(cpu) << ((irq & 3) * 8);
> +        iocsr_write32(data, EIOINTC_REG_ROUTE + (irq & ~3));

This all consists of undocumented magic numeric constants '3', '0xff',
8. Documentation clearly tells not to do so.

/*
 * Routing registers contain four vectors and have an offset of four to
 * the base. The routing information is 8 bit wide.
 */
#define EIOINTC_REG_ROUTE(vector)			\
	(0x1c00 + (vector & ~0x03)

#define EIOINTC_REG_ROUTE_SHIFT(vector)			\
	((vector & 0x03) << 3)

#define EIOINTC_REG_ROUTE_MASK(vector)			\
	(0xff << EIOINTC_REG_ROUTE_SHIFT(vector))

Those can be used to simplify the existing code pretty much in a
preparatory patch and then the above becomes:

     unsigned long reg = EIOINTC_REG_ROUTE(vector);
     u32 data = iocsr_read32(reg);

     data &= EIOINTC_REG_ROUTE_MASK(vector);
     data |= cpu_logical_map(cpu) << EIOINTC_REG_ROUTE_SHIFT(vector);
     iocsr_write32(reg, data);

See how this makes the code suddenly comprehensible?

>  static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
>  {
>  	unsigned int cpu;
> @@ -106,16 +133,22 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>  	vector = d->hwirq;
>  	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
>  
> -	/* Mask target vector */
> -	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
> -			0x0, priv->node * CORES_PER_EIO_NODE);
> -
> -	/* Set route for target vector */
> -	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
> -
> -	/* Unmask target vector */
> -	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
> -			0x0, priv->node * CORES_PER_EIO_NODE);
> +	if (priv->cpu_encoded) {
> +		iocsr_write32(EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F), regaddr);

There exists BIT_MASK() and please get rid of these numeric constants.

> +		virt_extioi_set_irq_route(vector, cpu);
> +		iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
> +	} else {
> +		/* Mask target vector */
> +		csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
> +				0x0, priv->node * CORES_PER_EIO_NODE);
> +
> +		/* Set route for target vector */
> +		eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
> +
> +		/* Unmask target vector */
> +		csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
> +				0x0, priv->node * CORES_PER_EIO_NODE);

Please follow the documented tip tree coding style for line breaks.

> +	}
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> @@ -143,13 +176,14 @@ static int eiointc_router_init(unsigned int cpu)
>  	uint32_t data;
>  	uint32_t node = cpu_to_eio_node(cpu);
>  	int index = eiointc_index(node);
> +	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);

Sigh. Please use the documented ordering of variable declaration
ordering.

>  	if (index < 0) {
>  		pr_err("Error: invalid nodemap!\n");
>  		return -1;

What is -1? Error codes exist for a reason.

>  static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
>  			       u64 node_map)
>  {
> -	int i;
> +	int i, val;

again u32 ...
  
>  	node_map = node_map ? node_map : -1ULL;
>  	for_each_possible_cpu(i) {
> @@ -389,6 +425,17 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
>  		return -ENOMEM;
>  	}
>  
> +	if (cpu_has_hypervisor) {
> +		val = iocsr_read32(EXTIOI_VIRT_FEATURES);
> +		if (val & BIT(EXTIOI_HAS_CPU_ENCODE)) {
> +			val = iocsr_read32(EXTIOI_VIRT_CONFIG);
> +			val |= BIT(EXTIOI_ENABLE_CPU_ENCODE);
> +			iocsr_write32(val, EXTIOI_VIRT_CONFIG);
> +			priv->cpu_encoded = true;
> +			pr_info("loongson-extioi: enable cpu encodig \n");
> +		}

Thanks,

        tglx

