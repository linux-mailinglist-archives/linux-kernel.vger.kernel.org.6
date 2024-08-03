Return-Path: <linux-kernel+bounces-273363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A194683A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00C81F21637
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9214E14D44E;
	Sat,  3 Aug 2024 06:40:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B214D28F;
	Sat,  3 Aug 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722667234; cv=none; b=gB9IGxeioM6knTwVqwqO4dsyzfIlhkRhbPhuh7ZvFZBGFSBmDu7Aveis+VuMyaTj3j2ySCS6wqJyAgWrjicFkRfWVWxgGJqK0fi7tAj2MjTtvWMEZjX8PFNJv+NoCX702mjj2hAsSDtibIZFThL/KR2aMyi8kCCCxQeGZ3foOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722667234; c=relaxed/simple;
	bh=z3ZXGXsNwuDa56mQqzVBvXDgtN4maYAscG3wgNEp86s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ihh01KQH7j/MrkluTgSork49kxD3qp+6J1D5qCRTg5U0JsPMfJ6fA3r1oABqsumL9ttMz2d3p6K4IEcmciaeC1p68EmEzZuxtxRQ2s1Pzlp/WK9rHkAN5Kld/Rz49FUKaPHb+PuXr4XvRPXDsCAb4njchJ+zBBieneu1y8Zr5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8CxvOrb0K1mTfIGAA--.24311S3;
	Sat, 03 Aug 2024 14:40:27 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMCxA+LZ0K1msh4BAA--.6609S3;
	Sat, 03 Aug 2024 14:40:25 +0800 (CST)
Subject: Re: [PATCH V7] LoongArch: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn,
 loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240726102443.12471-1-zhangtianyang@loongson.cn>
 <87o76kuqza.ffs@tglx>
 <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
 <87r0bb6ru1.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <cff37371-0692-0db5-cb14-74c519eb1c56@loongson.cn>
Date: Sat, 3 Aug 2024 14:40:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87r0bb6ru1.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxA+LZ0K1msh4BAA--.6609S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFy8GF43XFW7Cr4kJr4DJrc_yoW8Ar15pF
	WUG3W5Ar4Dtry2ka97uw10qFnIyrnaqFW8Jw1rJ34UG3s8WFnaqry8JFWaka4xCrZxJryj
	vw12v3s0kas8JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Hi, Thomas

在 2024/7/30 下午7:29, Thomas Gleixner 写道:
> Huacai!
>
> On Tue, Jul 30 2024 at 16:51, Huacai Chen wrote:
>> On Fri, Jul 26, 2024 at 11:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>> +     while (true) {
>>>> +             vector = csr_read64(LOONGARCH_CSR_IRR);
>>>> +             if (vector & IRR_INVALID_MASK)
>>>> +                     break;
>>>> +
>>>> +             vector &= IRR_VECTOR_MASK;
>>>> +
>>>> +             d = this_cpu_read(irq_map[vector]);
>>>> +             if (d)
>>>> +                     generic_handle_irq_desc(d);
>>>> +             else {
>>> See bracket rules.
>> Do you mean even if there is only one statement in the if condition,
>> we still need to do like this?
>> if (xxx) {
>>      yyy;
>> } else {
>>      zzz;
>> }
> Yes. It's documented.
>
>>>> +     msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
>>>> +                                            &pch_msi_domain_info_v2, parent);
>>> Please don't do that. Convert this to use per device MSI domains.
>> OK, thanks. But it is better to split the conversion to another patch
>> (so we can convert both V1 and V2).
> Why adding it first?
>
> This can be done per interrupt chip. See the conversion series for
> ARM[64]:
>
>      https://lore.kernel.org/r/20240623142137.448898081@linutronix.de
>
> Thanks,
>
>          tglx

We consider that since the original extioi-msi is still using the 
legacy-MSI interrupt model at irq-loongson-pch-msi.c, if per-device-MSI 
is directly supported in the AVEC support patch, it will result in the 
simultaneous use of two MSI-interrupt-mode in irq-loongson-pch-msi.c, 
which may seem a bit strange. So we decided to split it into two 
patches, the first one using tlegace-MSI to support AVEC interrupt 
controllers, and the second one will be uniformly modified to use 
per-device-MSI

Tianyang


