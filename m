Return-Path: <linux-kernel+bounces-250051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8AC92F37B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA442839F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761616FB0;
	Fri, 12 Jul 2024 01:32:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733C9460;
	Fri, 12 Jul 2024 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747955; cv=none; b=XpSGR+AD5Vo3wBM783koGXCNfvkTkW83ErJktsxzw9+YOdO7IraJufgyqmU3E11CHq1ghl3WC9RBq4KhoxGbPPqmA84gHmNr5s8WLowTPwLA06cFvgZ9F9VEAebDOQTgvTXit8XZ+QTXmH6pRjbh7V+uCDYoC+rAJGZmGumRMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747955; c=relaxed/simple;
	bh=rJ3vx6DcRyTyvUbMooZUPFlcyNAKa33aLGT5HMoHFDM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PNheTVsVyY9RlMVvYgkybV5dLwzN+C+v9q0Dcsh5zGKb6mGfdDySjjmSvpuxkS0jKc3s//RNKz4cd9b0ZQZfzrYi3fIPi2uFRFQooG6GVhgcsR3Th8oZG9Wu5tWl3DSIFFY4tD8+hH6df5tTCpxmRK8ba5ivGhR9FTA8NlF+JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Bx7vCmh5Bm4IIDAA--.10619S3;
	Fri, 12 Jul 2024 09:32:22 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxosSih5BmMiFFAA--.16317S3;
	Fri, 12 Jul 2024 09:32:21 +0800 (CST)
Subject: Re: [PATCH V4][RESEND] LoongArch: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net, alexs@kernel.org,
 siyanteng@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
 jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, yijun@loongson.cn, mhocko@suse.com,
 akpm@linux-foundation.org, dianders@chromium.org, maobibo@loongson.cn,
 xry111@xry111.site, zhaotianrui@loongson.cn, nathan@kernel.org,
 yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710043859.13053-1-zhangtianyang@loongson.cn>
 <87zfqpus3h.ffs@tglx> <245cd3c4-fdcd-768a-1c7c-e7abd1086864@loongson.cn>
 <87wmlst23w.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <70c3ae84-2dba-d965-950d-fdb770fe669f@loongson.cn>
Date: Fri, 12 Jul 2024 09:32:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmlst23w.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8CxosSih5BmMiFFAA--.16317S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrGr47Jw47AryfAry3XF4rtFc_yoWxGwbEgw
	17G3W7C3W2y3WIkayUJr13JFWxCa429r4rtr1DXr4Yqw1kXrWkX3Z2vr92vw15Jan7WFn8
	JryrtryUCF9FgosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=


在 2024/7/11 下午10:49, Thomas Gleixner 写道:
> On Thu, Jul 11 2024 at 09:40, Tianyang Zhang wrote:
>> 在 2024/7/11 上午12:30, Thomas Gleixner 写道:
>> I have reviewed the kernel submission documentation and found that the
>> usage of RESEND is inappropriate. The next time there is a modification
>> issue, I will update the version and resubmit it
> Please address the review feedback of the original V4 and send a V5 with
> a proper documentation of changes from V4 to V5.
>
> Thanks,
>
>          tglx

Ok, I will compile all the collected opinions and submit the V5 version 
based on the original V4 patch


Tianyang


