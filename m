Return-Path: <linux-kernel+bounces-405830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C859C57AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B81F21EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465791F7799;
	Tue, 12 Nov 2024 12:27:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A062309BE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414428; cv=none; b=ZuqXsc0n2HDZfoPqW7ij4Z2MNiA2NOODAbcL3RSnyrfQ8aXuNXPXHIaacxTFiDP1BVifzSwsYoWaX3XOXnEVYfAWe+RU8bw0Zx8WmfeG7dLG7KKIseN7/s06iGY4Q3WZ7kn2W9OAIeJjjp7+2Qi7lfYQQ6ISN5aP0exVCfK9sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414428; c=relaxed/simple;
	bh=SzoTBuPP8/BKqz/GBTYRShwJP2WYiSoVU+Qpxi08EB4=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DK5C0PY8tAg2GcXtcLluUBho1gUcShr77ghKzB0kwFML56VUiqdrdlzsoJMhZkMEl7Kq7IgosADETaaj7vknwDnD4JNB0PGdNE02MRQ1HscGm4NprynhCFFY/7rsUi3wq4pWcb2xWKXFaih8YXduG+UEImOH/8WLnlbNBJEDhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxDeORSTNnlPw7AA--.51715S3;
	Tue, 12 Nov 2024 20:26:57 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxbUeQSTNn07BSAA--.12703S3;
	Tue, 12 Nov 2024 20:26:56 +0800 (CST)
Subject: Re: [PATCH v2 5/5] LoongArch: Enable jump table with GCC for objtool
To: Xi Ruoyao <xry111@xry111.site>, Peter Zijlstra <peterz@infradead.org>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn>
 <20241105141530.GE10375@noisy.programming.kicks-ass.net>
 <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
 <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7e8adb0b-e681-72ae-40d8-740dc3f9480b@loongson.cn>
Date: Tue, 12 Nov 2024 20:26:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxbUeQSTNn07BSAA--.12703S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtryktF15CFyfJr48ZFy8tFc_yoWkWrg_Ww
	18ur1kC3y5Aa97J3WDWr4F93y7GF4UJw48Jw1DJrW3tr15XF98GFn3uasav3W3JFWDXFnx
	WF4DXasxCFyUuosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
	pUUUUUU==

On 11/12/2024 11:15 AM, Xi Ruoyao wrote:
> On Wed, 2024-11-06 at 13:03 +0800, Tiezhu Yang wrote:
>> On 11/05/2024 10:15 PM, Peter Zijlstra wrote:
>>> On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
>>>> For now, it is time to remove the compiler option -fno-jump-tables
>>>> to enable jump table for objtool if the compiler is GCC and it has
>>>> the compiler option -mannotate-tablejump, otherwise still keep the
>>>> compiler option -fno-jump-tables to maintain compatibility with the
>>>> older compilers.

...

>> ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
>> KBUILD_CFLAGS                   += $(call cc-option,-mannotate-tablejump)
>> else
>> KBUILD_CFLAGS                   += -fno-jump-tables
>> endif
>
> Has -mannotate-tablejump been added to Clang?

Yes.

> IMO it's better to add it
> to Clang first, and add Clang & GCC support at once into objtool.

Looks reasonable, the fact is that there are some corner issues
compiled with Clang due to different compiler behaviors, most of
the issues have been addressed and I need to do more test, I will
send v3 with about 10 patches after the coming merge window.

Thanks,
Tiezhu


