Return-Path: <linux-kernel+bounces-440701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D863D9EC311
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F550166882
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65420B7E7;
	Wed, 11 Dec 2024 03:18:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161A3B784
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887097; cv=none; b=kqkw4XnwA5NfMZNPP7YqxgF7i60Ucsrkl3wFoKle3QdIZo8s5C0T07OrZiFApb3o/gfntFHxYzBEQRUowRPFgh73XSEYhT0IRXzsDlG5BYDJpKYi1qrNFLEJH/GcJt0ZbyvKvT56z1XtUIFOqWL/w4LoY7/7chdjIz1e9gF4KMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887097; c=relaxed/simple;
	bh=QkSTW9F3qFcRzjMa6X68P/M1552IlmY/hA/8rDBZq/g=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fhto5cIK5tjkFpJ4JyPKlGyPVCD7fXtOleAGgeTdf2vj1GQWtJrgLYaN+n9xFaoDTqKZfZUIKbZhrRs4Eg1wC25svcvNRUk++pbgEEdw0zX/d4BGWxupHffyGmnz2lXWbEw3bQOuOSgVr5DRnp5a9ci0gIgDwsVJl649KXGbwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxeeB1BFlnglVVAA--.34552S3;
	Wed, 11 Dec 2024 11:18:13 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCx60ZzBFlnsSV_AA--.9359S3;
	Wed, 11 Dec 2024 11:18:11 +0800 (CST)
Subject: Re: [PATCH v5 05/10] objtool/LoongArch: Add support for switch table
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-6-yangtiezhu@loongson.cn>
 <20241209203932.a55zmvjehc27hqjy@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8747e7fb-f2e5-f3d1-c3c4-1fdd05120bda@loongson.cn>
Date: Wed, 11 Dec 2024 11:18:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209203932.a55zmvjehc27hqjy@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCx60ZzBFlnsSV_AA--.9359S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW5KFWDArWUAw4fKw13Cr45Arc_yoWxGFc_W3
	4qgrWDCayqqwnYyayUCw1YgF9rKrWjvw15XryFqw1Dtw1kJ395AFZ2gr93A34kXayfGFWk
	Wa1kZ3yfWry2gosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EeHDUUUUU==

On 12/10/2024 04:39 AM, Josh Poimboeuf wrote:
> On Sat, Dec 07, 2024 at 09:59:10AM +0800, Tiezhu Yang wrote:
>>  struct reloc *arch_find_switch_table(struct objtool_file *file,
>>  				     struct instruction *insn,
>>  				     unsigned long *table_size)
>>  {
>
> This seems to be a partial implementation as it doesn't set
> 'table_size', resulting in undefined behavior when the size gets used by
> objtool later.   I suppose this patch should be squashed with the next
> one?

OK, makes sense, I will squash them into one single patch.

Let me wait for some days, if no more comments, I will send v6
in the next week.

Thanks,
Tiezhu


