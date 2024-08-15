Return-Path: <linux-kernel+bounces-287840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1A952D11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37E284138
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C71AC89B;
	Thu, 15 Aug 2024 10:57:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB41AC885;
	Thu, 15 Aug 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719473; cv=none; b=qvSVcMFTh+HfmDu4l51N2ZYpOG+ceAsvD+t5o1he0+FLIEZFu0XMyrQGfV3rOxygeEHYe2ivsi7wgdCAekGURxN9FSHTUNLe60tf2MWlYCXRZYs43yYU6JtB3Qn6PUmhkGjOeGBJ+UwA4QVV3OjFV8d+yV+SjhbEl6v8pR/g75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719473; c=relaxed/simple;
	bh=3lRPdEGgoE3CNo1PJ94+XF+At1dlGGEbdpA8jE5l3jo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JpcZUjquq8jUg1dXJNRsZIXEctANPI+8Gr1565s0ZWuBXeLFoLOaRCr5i0ka0dYYggQGP8YekKPF+LKROw0tx+VMPZZ1FIsHfnfuhwnmY1PECiyud6vkjzLOGMOC8tclKZnXrhevKH4RJ/X8kP1ZoBIYK7N+jjD3O1urFzDtHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8DxCeos371mdsEUAA--.49189S3;
	Thu, 15 Aug 2024 18:57:48 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMDxG2cp371mkjQVAA--.2535S3;
	Thu, 15 Aug 2024 18:57:47 +0800 (CST)
Subject: Re: [PATCH Loongarch-avec support V9 1/2] irqchip/loongson-pch-msi:
 Switch to MSI parent domains
To: Xi Ruoyao <xry111@xry111.site>, Thomas Gleixner <tglx@linutronix.de>,
 corbet@lwn.net, alexs@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, yijun@loongson.cn, mhocko@suse.com,
 akpm@linux-foundation.org, dianders@chromium.org, maobibo@loongson.cn,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240813085415.20035-1-zhangtianyang@loongson.cn>
 <875xs3petd.ffs@tglx> <6495631f-ec9c-c86a-39d2-1ada793b8098@loongson.cn>
 <8734n6np4a.ffs@tglx> <d5c5fdc8-abd5-685f-b952-f36b9e0bd908@loongson.cn>
 <25d8b51db163c01d62518bd02449d5f5e8748fde.camel@xry111.site>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <c452d88a-1ff7-4d8b-2bf2-c334821a87ea@loongson.cn>
Date: Thu, 15 Aug 2024 18:57:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <25d8b51db163c01d62518bd02449d5f5e8748fde.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxG2cp371mkjQVAA--.2535S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur1DZrW7Xw47KF4kCw4kGrX_yoWDXFgE9a
	srZr1DCr1DGFs7KFsrtrsIqrnFyFyDK3yrtw4jyr4Yv39Yqr98Xan8W34kXFn8Jan7Xr9I
	vF90q3ZxXrnruosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUU
	UU=


在 2024/8/15 下午6:51, Xi Ruoyao 写道:
> On Thu, 2024-08-15 at 18:43 +0800, Tianyang Zhang wrote:
>> Hi, Thomas
>>
>> 在 2024/8/15 下午4:53, Thomas Gleixner 写道:
>>> On Thu, Aug 15 2024 at 09:13, Tianyang Zhang wrote:
>>>> https://lore.kernel.org/all/20240813085427.20194-1-zhangtianyang@loongson.cn/
>>>>
>>>> 在 2024/8/14 下午6:41, Thomas Gleixner 写道:
>>>>> On Tue, Aug 13 2024 at 16:54, Tianyang Zhang wrote:
>>>>>
>>>>> Where is patch 2/2 ?
>>> Can you please thread your submissions properly and not send them
>>> separately?
>>>
>>> Thanks,
>>>
>>>           tglx
>> I relearned the series of patches in the kernel submission guide. Now I
>> know how to generate the series-cover.
>>
>> Can I resend all patches directly with a correct cover now?
> Just version it v10.  Using "resend" in the subject can sometimes cause
> confusion, and there's no harm to bump the version number anyway even
> without real code change.
OK, I got it , thank you


