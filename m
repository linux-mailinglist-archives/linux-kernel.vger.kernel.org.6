Return-Path: <linux-kernel+bounces-548122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D2A54048
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F66B189145C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA218FDB2;
	Thu,  6 Mar 2025 02:07:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40F18DF65;
	Thu,  6 Mar 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226868; cv=none; b=JGfrqoUXPfMbYdGmLwQye3IAzE83DXY10wefEd6Z8IP5wt18+ol7yIrAzygDLil8DFW46mWXZdKX/sY6YVAfrLui7j5a7vgiGvBuXYODbDGDS2XLrRqT1fC8Uff/aLFeI5iMr9DFS9+v9tOMi3hWtTkBK9EhfTEzAiaw3XcrkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226868; c=relaxed/simple;
	bh=r3XLeRQQg726V6Q+Oj5puIPT226n87+nzy5u+0Cn+MM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NGN6zPsA9d1oI7As+wJr6nXjA6BQgMq2u9/jGP26Mfj4XfDVv9gBJuYh+juOqRqFtSEEqxnXV2Q+Q54LsMo60QN6TGI7mwL1ourEjocWsJeT9+y1V2aQZABnCXxAnqXGcoGeFpxgDvNvb6IwTktTHJMNSgClszwer2sRR0ZPv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8BxrOJwA8lnxceLAA--.2954S3;
	Thu, 06 Mar 2025 10:07:44 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMAxDcVrA8lnwZ04AA--.11318S3;
	Thu, 06 Mar 2025 10:07:40 +0800 (CST)
Subject: Re: [PATCH 2/2] irq/irq-loongarch-ir:Add Redirect irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
 si.yanteng@linux.dev, jiaxun.yang@flygoat.com, peterz@infradead.org,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, maobibo@loongson.cn,
 siyanteng@cqsoftware.com.cn, gaosong@loongson.cn, yangtiezhu@loongson.cn,
 loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250303101533.31462-1-zhangtianyang@loongson.cn>
 <20250303101533.31462-3-zhangtianyang@loongson.cn>
 <CAAhV-H4G2qk69LF41VFoFgd7ZBAqAFB=hA7PMkaxXdNVEX-WyA@mail.gmail.com>
 <87plixby85.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <da36f472-df93-5e67-359d-b3e5bc1a81d3@loongson.cn>
Date: Thu, 6 Mar 2025 10:07:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87plixby85.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxDcVrA8lnwZ04AA--.11318S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFykXFyfWF13trWxCrWDKFX_yoWfAwb_ur
	43tFs5GFyxCrWfGa1rAw4avas5W395JF98trykt3W2q34Fg3WkJr45Awn3Ca43JryxAr1a
	y3W5ZrW5Ar4jvosvyTuYvTs0mTUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wryl
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Hi, Thomas

在 2025/3/4 上午5:28, Thomas Gleixner 写道:
> On Mon, Mar 03 2025 at 22:34, Huacai Chen wrote:
>> On Mon, Mar 3, 2025 at 6:15 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>>> +static const struct irq_domain_ops loongarch_redirect_domain_ops = {
>>> +       .alloc = loongarch_irq_redirect_alloc,
>>> +       .free = loongarch_irq_redirect_free,
>>> +       .select = msi_lib_irq_domain_select,
>>> +};
>> For consistency, please use:
>> static const struct irq_domain_ops redirect_domain_ops = {
>>         .alloc          = redirect_domain_alloc,
>>         .free           = redirect_domain_free,
>>         .select         = msi_lib_irq_domain_select,
>> };
> This formatting requirement applies to all structures in this patch. See
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-style-notes
>
> for further information.
OK, I got it , thanks
> Thanks,
>
>          tglx


