Return-Path: <linux-kernel+bounces-284611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58F95030C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B36E1F237C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0C19CCF7;
	Tue, 13 Aug 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD0izNgr"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CE19AD8C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546465; cv=none; b=Dg3R0KCxKbQ5KPU+9YqcP/1BWDniMinQyHwTprzvJkQL6NOtUCeUwouxX0diKRsXth1UUF60LpzGyaC5AHhJEg0XAvJtNrtofy5XSowjfTGvRcwBY0+w2iTfG5bojfEPk1qVyyL31JUBhU0yVUC2Px1xeFgQIIDfD/wnKu3iCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546465; c=relaxed/simple;
	bh=IjU72L7huk0CG++H79xHKCa4VXME2LUoqqPFFDRzdxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6neXAEZ4gcYH4Zd1mRaa7KM06EOej9fAmhO2s29/BLoK5nFNnLl1PNLp0haYkd6p3YG5dMXRr1ecdUIruyEmgmsC3pA329NTfuc2Jm1jUYvImjZD7gTiDi7XqElYWUpYBDQCIaut43ANN6Zm+0JWj8+t9iS8G+VYgLCmmlqiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD0izNgr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530d0882370so5134820e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546462; x=1724151262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHuAK+5B6Ucx3MeUiy7KVaL0yt13yBDl/xARtyIBFV0=;
        b=GD0izNgrmtcCqBS1/YBrlFqCFkP0ydIH5fc0TEe8fl+bpE2yyoUqRPYaSTFNBe0Qxy
         H0K+bvHSxnIDEPc1d/GIC6qFoXHEZfBdbhssmYQM9Q3jsBRhnS9zaX/T/RVi+1y67XUA
         yR6RWVd+Duqew9uBPQXomLqrwNWUd4V3kLbz6C3SakEwMJLxC+q2uxZ0EqJwNVl6c6KM
         Bm6RO9TE+9TY1Re1EfeOZNl2q/XNva7sIxrdVPo5QXSgy0vJOizkYP3xh1rfGCa6Pcz5
         ENGB53KR+k3qLj3/l5qNM5jOT3jrL6BbzrdQQeCp90XgC5Y7DozSCE6Q8OC1UUxFJohB
         AGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546462; x=1724151262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHuAK+5B6Ucx3MeUiy7KVaL0yt13yBDl/xARtyIBFV0=;
        b=YIL7yKYXMqeOBNJ6e6hUuQac0Jkad0VDuW0AKURWUU4yC6Ye6ipdYOw5agLUpTIelE
         dGh0sSOMbBDDlEIV8KPczAeU0uS9lf1nVqIdwRggUR9IMBChGPkDaaprcPAda8y74j9n
         rxEN6GYvbggzl7P/OWJWiizxnX3keuHfTLV+vzLkO6ezSDhW6zULPPOHCA+9bvWnvh15
         vk833P9lo8KwnyrJzoCsMlLO/rN3Lca17Dil07XECDX8Rou5bEgnbfbG4Q6Zkwtarjdk
         WodiCu1O+CTnQWEmh3oiGszecKhPS8SdPW/ftwYNb2cz3babEEVJwsFL66le38B6A/Fn
         iJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYpot4JsGBJALuA3Ymyxjv8tRagtPBpqEZuuLc+q5vcNmIzh5baHrmsTfUYtx8WzqrWdjYKRAOtzHv57xcw5weTN8GmQnf+eq/+QWK
X-Gm-Message-State: AOJu0YyplLL64+8rLNaNtUX78nYAMZkeaQftgeIqLrsg7UBuOpT0H5vB
	86dHPW1vreEX2CLUk8GHPFl7Pztxmqc7sislu6NzDbcEzohGM344yVL19A==
X-Google-Smtp-Source: AGHT+IFXDaMSdl1Ok/mBjr/1eDJ+nvZXAY5OSyWCEzAfIobYZ27aWiZQ7JyDvOFv98NZQ18hbBg0cA==
X-Received: by 2002:a05:6512:3b27:b0:530:daee:cfae with SMTP id 2adb3069b0e04-532136a4aa1mr2111890e87.61.1723546461170;
        Tue, 13 Aug 2024 03:54:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200eb4e90sm947567e87.58.2024.08.13.03.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:54:20 -0700 (PDT)
Message-ID: <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>
Date: Tue, 13 Aug 2024 13:54:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] irqdomain: simplify simple and legacy domain
 creation
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com>
 <27033022-cdbe-40d9-8a97-cdc4d5c25dbe@flygoat.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <27033022-cdbe-40d9-8a97-cdc4d5c25dbe@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/24 13:19, Jiaxun Yang wrote:
> 
> 
> On 2024/8/8 13:34, Matti Vaittinen wrote:
>> Move a bit more logic in the generic __irq_domain_instantiate() from the
>> irq_domain_create_simple() and the irq_domain_create_legacy(). This does
>> simplify the irq_domain_create_simple() and irq_domain_create_legacy().
>> It will also ease the use of irq_domain_instantiate() instead of the
>> irq_domain_create_simple() or irq_domain_create_legacy() by allowing the
>> callers of irq_domain_instantiate() to omit the IRQ association and
>> irq_desc allocation code.
>>
>> Reduce code duplication by introducing the hwirq_base and virq_base
>> members in the irq_domain_info structure, creating helper function
>> for allocating irq_descs, and moving logic from the .._legacy() and
>> the .._simple() to the more generic irq_domain_instantiate().
> 
> Hi all,
> 
> This patch currently in next had caused regression on MIPS systems.
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:1008 
> __irq_set_handler+0x64/0xa8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
> 6.11.0-rc3-next-20240812 #10
> [    0.000000] Hardware name: img,boston
> [    0.000000] Stack : 0000000000000034 0000000000000000 
> 0000000000000018 ffffffff80cbba58
> [    0.000000]         ffffffff80cbba58 ffffffff80cbbb88 
> 0000000000000000 0000000000000000
> [    0.000000]         0000000000000000 0000000000000001 
> 0000000000000000 0000000000000000
> [    0.000000]         0000000000000000 0000000000000000 
> ffffffff80a7ed04 0000000000002000
> [    0.000000]         ffffffff80cbb824 0000000000000000 
> 0000000000000000 ffffffff80c35aa0
> [    0.000000]         ffffffff80ce0000 ffffffff80ce0000 
> 0000000000000000 0000000000000100
> [    0.000000]         ffffffff80ce0000 0000000000000000 
> ffffffffffffffff 0000000016200001
> [    0.000000]         ffffffffb6100088 ffffffff80cb8000 
> ffffffff80cbba50 ffffffff80c90000
> [    0.000000]         ffffffff801096d4 0000000000000000 
> 0000000000000000 0000000000000000
> [    0.000000]         0000000000000000 0000000000000000 
> ffffffff801096ec 0000000000000000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff801096ec>] show_stack+0x5c/0x150
> [    0.000000] [<ffffffff80a8e2e4>] dump_stack_lvl+0x6c/0xb4
> [    0.000000] [<ffffffff80a80e20>] __warn+0x9c/0xcc
> [    0.000000] [<ffffffff80135bd8>] warn_slowpath_fmt+0x158/0x1c0
> [    0.000000] [<ffffffff801a4d04>] __irq_set_handler+0x64/0xa8
> [    0.000000] [<ffffffff80dba50c>] gic_of_init+0x2a8/0x55c
> [    0.000000] [<ffffffff80dc4430>] of_irq_init+0x1c8/0x324
> [    0.000000] [<ffffffff80da092c>] init_IRQ+0x60/0x120
> [    0.000000] [<ffffffff80d9dbd4>] start_kernel+0x4dc/0x658
> [    0.000000]
> [    0.000000] ---[ end trace 0000000000000000 ]---
> 
> This might be caused by drivers/irqchip/irq-mips-cpu.c has 
> irq_domain_add_legacy() called with
> first_irq set to 0.
> 

Right. Thanks for the report! I do appreciate this testing!

first_irq gets assigned to the info->virq_base making it 0.

Later, in the __irq_domain_instantiate() we use the info->virq_base as a 
condition for
	if (info->virq_base > 0)
                 irq_domain_associate_many()
which was previously unconditionally called in the irq_domain_add_legacy().

> Do you have any idea on how should we fix it?
Maybe we could add a flag for domain association similar to the "bool 
cond_alloc_descs", but maybe Thomas has some better ideas...?


Yours,
	-- Matti
-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


