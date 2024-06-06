Return-Path: <linux-kernel+bounces-204306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8318FE6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F292E1C22247
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FA195F06;
	Thu,  6 Jun 2024 12:58:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F4195B36
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678717; cv=none; b=JmXw1ILXwlVYNJAomtStfL/yly+J6AIFvRePP31lOzeo64yRWjLxeKlOM7pwNZBljjx7yBsGg51OPT3RyVkUyk3yrg+mkZh61BLD7VPj+0SJ4h8oTEXnLW0pdV7LvwnXkJepyf7XiwcA5EDpibCypTsjfNAnMHtvAtsIhoDuWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678717; c=relaxed/simple;
	bh=yoys+3JRRN2n5ze9L4pWq5Mtn0CwRaad6toh+QE8ngM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U7lvgqHQLROSA5m8avU4GvnCABMlZjNnNmhNkxeeYJi8rt19VwjLKzDH8icy945mOErRiRm3xsbegeJcB8wNtL7o5keUsUDJKp8GtVksjAg61K9AeEyiD9lXgU1Eg3abKofMN7LySrBmTdLYw0vpvWkuBnYNGqTl4U2Xlh9klW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8Bx3+t4smFmszwEAA--.2052S3;
	Thu, 06 Jun 2024 20:58:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLMdxsmFmi+0WAA--.57439S3;
	Thu, 06 Jun 2024 20:58:27 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongson-eiointc: Add extioi virt extension
 support
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn
References: <20240605070229.2569875-1-gaosong@loongson.cn>
 <87a5jz47hc.ffs@tglx>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d5efc13a-f719-bc77-1adb-feb73a8155b4@loongson.cn>
Date: Thu, 6 Jun 2024 20:58:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5jz47hc.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8CxLMdxsmFmi+0WAA--.57439S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XrW5Zry3tF17uFyktFy7urX_yoW3tr47pF
	W0kFZxtrWjqFWSg3yvqFs5JFyayr93GrWDtF43Gayrta4F9r109F1vgrnxuF1xCrWkCFWa
	v343X34Uuw1qy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
	sDUUUUU==

Hi Thomas,

Thanks for your comments

在 2024/6/6 上午1:36, Thomas Gleixner 写道:
> On Wed, Jun 05 2024 at 15:02, Song Gao wrote:
>> Currently IRQs can be routed to only 4 vcpus with one Hw extioi.
> Can you please use proper words instead of acronyms?
>
> Interrupts can be routed to maximal four virtual CPUs with one external
> hardware interrupt.
Yes,  I will correct it.
>> This patch adds the extioi virt extension support so that IRQs can
> git grep 'This patch' Documentation/process/
>
>> be routed to 256 vcpus on hypervior mode.
>>
>> Now IRQs is emulated in userspace, so the extioi virt device emulation
>> is implemented in userspace firstly.
> I'm failing to understand what this means and how this and the link are
> relevant to the change log and the change itself.
I will clean it.
>> See:
>>    https://patchew.org/QEMU/20240528083855.1912757-1-gaosong@loongson.cn/
>>   
>> +#define EXTIOI_VIRT_FEATURES           0x40000000
>> +#define  EXTIOI_HAS_VIRT_EXTENSION     0
>> +#define  EXTIOI_HAS_ENABLE_OPTION      1
>> +#define  EXTIOI_HAS_INT_ENCODE         2
>> +#define  EXTIOI_HAS_CPU_ENCODE         3
>> +#define EXTIOI_VIRT_CONFIG             0x40000004
>> +#define  EXTIOI_ENABLE                 1
>> +#define  EXTIOI_ENABLE_INT_ENCODE      2
>> +#define  EXTIOI_ENABLE_CPU_ENCODE      3
> These are clearly bits. So why not define them as BIT(0), so you can
> spare that at the usage site?
Got it.
> Also why defining all of this when there are only two defines used?
BIT(1) and BIT(2) correspond to Bit Fields 48 and 49 of Table 28 in 
Section 4.13 of Manual [1].
These are present in the physical hardware, just not yet used in the 
software logic.

[1] 
https://github.com/loongson/LoongArch-Documentation/releases/download/2023.04.20/Loongson-3A5000-usermanual-v1.03-EN.pdf

>> +
>>   #define VEC_REG_COUNT		4
>>   #define VEC_COUNT_PER_REG	64
>>   #define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
>> @@ -41,6 +51,7 @@ struct eiointc_priv {
>>   	cpumask_t		cpuspan_map;
>>   	struct fwnode_handle	*domain_handle;
>>   	struct irq_domain	*eiointc_domain;
>> +	bool			cpu_encoded;
>>   };
>>   
>>   static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
>> @@ -56,7 +67,9 @@ static void eiointc_enable(void)
>>   
>>   static int cpu_to_eio_node(int cpu)
>>   {
>> -	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
>> +	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
> Pointless brackets.
Got it.
>> +
>> +	return cpu_logical_map(cpu) / cores;
>>   }
>>   
>>   #ifdef CONFIG_SMP
>> @@ -88,6 +101,20 @@ static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode,
>>   
>>   static DEFINE_RAW_SPINLOCK(affinity_lock);
>>   
>> +static void virt_extioi_set_irq_route(int irq, unsigned int cpu)
> unsigned int irq;
>
> But this is about vectors not interrupts. So please name it
> accordingly. 'irq' is just confusing. I had to look up the call site to
> figure out what this is about.
Thanks for your suggestion.
>> +{
>> +        int data;
> This represents a hardware register value, so the data type wants to be
> u32, no?
I will correct it.
>> +        /*
>> +         * get irq route info for continuous 4 vectors
>> +         * and set affinity for specified vector
>> +         */
>> +        data = iocsr_read32(EIOINTC_REG_ROUTE + (irq & ~3));
>> +        data &=  ~(0xff << ((irq & 3) * 8));
>> +        data |= cpu_logical_map(cpu) << ((irq & 3) * 8);
>> +        iocsr_write32(data, EIOINTC_REG_ROUTE + (irq & ~3));
> This all consists of undocumented magic numeric constants '3', '0xff',
> 8. Documentation clearly tells not to do so.
>
> /*
>   * Routing registers contain four vectors and have an offset of four to
>   * the base. The routing information is 8 bit wide.
>   */
> #define EIOINTC_REG_ROUTE(vector)			\
> 	(0x1c00 + (vector & ~0x03)
>
> #define EIOINTC_REG_ROUTE_SHIFT(vector)			\
> 	((vector & 0x03) << 3)
>
> #define EIOINTC_REG_ROUTE_MASK(vector)			\
> 	(0xff << EIOINTC_REG_ROUTE_SHIFT(vector))
>
> Those can be used to simplify the existing code pretty much in a
> preparatory patch and then the above becomes:
>
>       unsigned long reg = EIOINTC_REG_ROUTE(vector);
>       u32 data = iocsr_read32(reg);
>
>       data &= EIOINTC_REG_ROUTE_MASK(vector);
>       data |= cpu_logical_map(cpu) << EIOINTC_REG_ROUTE_SHIFT(vector);
>       iocsr_write32(reg, data);
>
> See how this makes the code suddenly comprehensible?
Yes, the code is very concise, thanks for the example.
>>   static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
>>   {
>>   	unsigned int cpu;
>> @@ -106,16 +133,22 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>>   	vector = d->hwirq;
>>   	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
>>   
>> -	/* Mask target vector */
>> -	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
>> -			0x0, priv->node * CORES_PER_EIO_NODE);
>> -
>> -	/* Set route for target vector */
>> -	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
>> -
>> -	/* Unmask target vector */
>> -	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
>> -			0x0, priv->node * CORES_PER_EIO_NODE);
>> +	if (priv->cpu_encoded) {
>> +		iocsr_write32(EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F), regaddr);
> There exists BIT_MASK() and please get rid of these numeric constants.
How about this:

   #define EIOINTC_ALL_ENABLE     0xffffffff
+#define EIOINTC_ALL_ENABLE_MASK(vector)        \
+           (EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F))
+#define EIOINTC_REG_ENABLE(vector)                 \
+           (EIOINTC_REG_ENABLE + (vector >> 5) << 2)

>> +		virt_extioi_set_irq_route(vector, cpu);
>> +		iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
>> +	} else {
>> +		/* Mask target vector */
>> +		csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
>> +				0x0, priv->node * CORES_PER_EIO_NODE);
>> +
>> +		/* Set route for target vector */
>> +		eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
>> +
>> +		/* Unmask target vector */
>> +		csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
>> +				0x0, priv->node * CORES_PER_EIO_NODE);
> Please follow the documented tip tree coding style for line breaks.
OK.
>> +	}
>>   
>>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   
>> @@ -143,13 +176,14 @@ static int eiointc_router_init(unsigned int cpu)
>>   	uint32_t data;
>>   	uint32_t node = cpu_to_eio_node(cpu);
>>   	int index = eiointc_index(node);
>> +	int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
> Sigh. Please use the documented ordering of variable declaration
> ordering.

Sorry, I didn't find the information in document [1].

[1]: https://www.kernel.org/doc/html/next/process/coding-style.html


How about this:

  static int eiointc_router_init(unsigned int cpu)
  {
-       int i, bit;
-       uint32_t data;
-       uint32_t node = cpu_to_eio_node(cpu);
-       int index = eiointc_index(node);
-       int cores = (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE);
+       int i, bit, cores, index;
+       uint32_t data, node;
+
+       node = cpu_to_eio_node(cpu);
+       index = eiointc_index(node);
  
         if (index < 0) {
                 pr_err("Error: invalid nodemap!\n");
                 return -1;
         }
  
+       cores = cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE;
+
         if ((cpu_logical_map(cpu) % cores) == 0) {

>>   	if (index < 0) {
>>   		pr_err("Error: invalid nodemap!\n");
>>   		return -1;
> What is -1? Error codes exist for a reason.
I will use -EINVAL.
>>   static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
>>   			       u64 node_map)
>>   {
>> -	int i;
>> +	int i, val;
> again u32 ...
Got it .

Thanks again for your comments.

Thanks
Song Gao
>    
>>   	node_map = node_map ? node_map : -1ULL;
>>   	for_each_possible_cpu(i) {
>> @@ -389,6 +425,17 @@ static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
>>   		return -ENOMEM;
>>   	}
>>   
>> +	if (cpu_has_hypervisor) {
>> +		val = iocsr_read32(EXTIOI_VIRT_FEATURES);
>> +		if (val & BIT(EXTIOI_HAS_CPU_ENCODE)) {
>> +			val = iocsr_read32(EXTIOI_VIRT_CONFIG);
>> +			val |= BIT(EXTIOI_ENABLE_CPU_ENCODE);
>> +			iocsr_write32(val, EXTIOI_VIRT_CONFIG);
>> +			priv->cpu_encoded = true;
>> +			pr_info("loongson-extioi: enable cpu encodig \n");
>> +		}
> Thanks,
>
>          tglx


