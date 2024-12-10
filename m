Return-Path: <linux-kernel+bounces-438682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC659EA453
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D2B281B79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA47082B;
	Tue, 10 Dec 2024 01:29:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A71524B0;
	Tue, 10 Dec 2024 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794175; cv=none; b=rn2Ac459OJH+ZEgQS/p9OPjkG5e3j7AiTgQEHxc5JPgOiH0laY9nhaohX/dMi3ZJpJyrLGxoZue2GOP6UCHHdnNRn0CBOd07X/TgbYKv8lbqaak9hvxoSCYxRioZf7tP6FOa4BBwyefGqsd85svzJMYOaT9mjgATRSZAoTe3Fgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794175; c=relaxed/simple;
	bh=5+mR+SHEvWJTFUO+AonvIcDDIN4i/UmrQn7zvqkR0n0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c5nv8C8cpGkeepo6yu7CcJoO/1t2WfQ9OnZ6P1r1gvZ4lxcpZlWbUDC26txi/awOy9O0l4jlParK/+jW8VPKzxQ5QJyHUhJzl1ozJO724uhf1E3H+Ki05ZowYN2T44gxKJqYy5jQBgEQBz4dZV/Orj7Pc8p0cmaAs7RsMVVjGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8BxYa97mVdn6ZtUAA--.33967S3;
	Tue, 10 Dec 2024 09:29:31 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMCx60Z6mVdnVo99AA--.7106S3;
	Tue, 10 Dec 2024 09:29:30 +0800 (CST)
Subject: Re: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241207033146.20938-1-zhangtianyang@loongson.cn>
 <CAAhV-H4VAyD+=Btt9S6HrN6-sVQJqe1_jeLPS13UR1kxXJ8S5w@mail.gmail.com>
 <8734iyq613.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <ca4b3c85-1df9-521b-012d-69d18fc06c98@loongson.cn>
Date: Tue, 10 Dec 2024 09:29:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8734iyq613.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCx60Z6mVdnVo99AA--.7106S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1xuw1fKFW7ZF48AFy7urX_yoW8XF1fpF
	yDGF1fKanrKrWFkws7t3y0vFWfuFZ3JFWDKF4DJw18X3sakF1YqryFkr1rKFya9rs29FyI
	vFWxta4Uuwn8JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07josjUUUUUU=

Hi, Thomas

在 2024/12/9 上午4:22, Thomas Gleixner 写道:
> On Sat, Dec 07 2024 at 17:11, Huacai Chen wrote:
>> On Sat, Dec 7, 2024 at 11:31 AM Tianyang Zhang
>> <zhangtianyang@loongson.cn> wrote:
>>> This patch enables the advanced interrupt controller function under
>>> multiple-node of 3C600. The topology of the advanced interrupt controller
>>> is consistent with NUMA node. We check the enable status of the node where
>>> each CPU is located once when it goes online, which may cause some
>>> additional operations, but it can ensure that the advanced interrupt
>>> controller can still be used in situations where some CPUs cannot start
>> The whole can be reworded:
>>
>> Currently we only enable one chip's advanced interrupt controller
>> (AVEC) in hardware, so multi-chip machines with Loongson-3C6000 don't
>> work. This patch enables it for every chip (In theory every chip needs
>> to be enabled only once, but for simplicity we enable it on every core
>> in the CPU online hooks).
> It want's to be reworded without 'we' and 'this patch':
>
>    avecintc_init() enables the Advanced Interrupt Controller (AVEC) of
>    the boot CPU node, but nothing enables the AVEC on secondary nodes.
>
>    Move the enablement to the CPU hotplug callback so that secondary
>    nodes get the AVEC enabled too. In theory enabling it once per node
>    would be sufficient, but redundant enabling does no hard, so keep the
>    code simple and do it unconditionally.
>
> Thanks,
>
>          tglx
Ok, I got it , thanks


