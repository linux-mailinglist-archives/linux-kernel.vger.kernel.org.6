Return-Path: <linux-kernel+bounces-533429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F7A45A14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96363189C461
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26753224251;
	Wed, 26 Feb 2025 09:28:07 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BA2135C8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562086; cv=none; b=jxCdS4v30D8lgNqL/V0wWlh1o5OSrwmCjqVmu/R80DwWAHDP7IJKE0F2l1t3E2jW61ExXOvqPTee6h7yYu1e6XgFuTcneWCOYlHYBjg/sg7ZaiQQ5e52aaov4XD35zujq735Q21A4CPr1/tGvTSiZYIIp2zhsLxYRqN13GlJgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562086; c=relaxed/simple;
	bh=dJPCxbdNAiNlrZRyQQhDnRk4XKlVsJHtvWrBLTapGMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMuITGxTAS2g5T3MlNl0VulixDHDnaZ05JS6myjX+yZl42efqxRYFrqvgCUWnUR/CTgNbH0ICuThnmtM7xYQmwzzOGDEQ/BPiNbUggLkNSzsF7vrsRboGIM7wngK14gKqUfVHXCJt60e3Zvv2pE/5YGIvUtXfRU+omakSeXP65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2557243403;
	Wed, 26 Feb 2025 09:27:58 +0000 (UTC)
Message-ID: <c6974bec-851e-4fdf-8af3-23cfdc9dd50f@ghiti.fr>
Date: Wed, 26 Feb 2025 10:27:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add riscv_force_qspinlock for early_param
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
Cc: conor@kernel.org, alexghiti@rivosinc.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com,
 leobras@redhat.com, peterz@infradead.org, parri.andrea@gmail.com,
 longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de, will@kernel.org,
 corbet@lwn.net, Guo Ren <guoren@linux.alibaba.com>
References: <20241214043510.3795984-1-guoren@kernel.org>
 <330c7596-cd93-4ae5-b00d-789c72a944aa@ghiti.fr>
 <CAJF2gTRt0c78jPGN8ZX-u3dJKBrOkoV7VZQW2A+rVpuVOzdvLg@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJF2gTRt0c78jPGN8ZX-u3dJKBrOkoV7VZQW2A+rVpuVOzdvLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhop
 ehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepsghjohhrnhesrhhivhhoshhinhgtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

First sorry I did not follow up on this patch.

On 22/12/2024 05:03, Guo Ren wrote:
> On Mon, Dec 16, 2024 at 5:15 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Guo,
>>
>> On 14/12/2024 05:35, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit qspinlock
>>> force enabled. See the Kconfig entry for RISCV_COMBO_SPINLOCKS.
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>>    arch/riscv/kernel/setup.c                       | 13 ++++++++++++-
>>>    2 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 3872bc6ec49d..43d0df2922b2 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -5887,6 +5887,11 @@
>>>                        [KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>>>                        CPUs.
>>>
>>> +     riscv_force_qspinlock [RISCV, EARLY]
>>> +                     When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit
>>> +                     qspinlock force enabled. See the Kconfig entry for
>>> +                     RISCV_COMBO_SPINLOCKS.
>>> +
>>>        riscv_isa_fallback [RISCV,EARLY]
>>>                        When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
>>>                        falling back to detecting extension support by parsing
>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> index 45010e71df86..74b13bc64c9c 100644
>>> --- a/arch/riscv/kernel/setup.c
>>> +++ b/arch/riscv/kernel/setup.c
>>> @@ -247,6 +247,15 @@ static void __init parse_dtb(void)
>>>    #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
>>>    DEFINE_STATIC_KEY_TRUE(qspinlock_key);
>>>    EXPORT_SYMBOL(qspinlock_key);
>>> +
>>> +static bool force_qspinlock;
>>> +
>>> +static int __init riscv_force_qspinlock(char *p)
>>> +{
>>> +     force_qspinlock = true;
>>> +     return 0;
>>> +}
>>> +early_param("riscv_force_qspinlock", riscv_force_qspinlock);
>>>    #endif
>>>
>>>    static void __init riscv_spinlock_init(void)
>>> @@ -267,7 +276,9 @@ static void __init riscv_spinlock_init(void)
>>>                using_ext = "using Ziccrse";
>>>        }
>>>    #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
>>> -     else {
>>> +     else if (force_qspinlock) {
>>> +             using_ext = "force";
>>> +     } else {
>>>                static_branch_disable(&qspinlock_key);
>>>                pr_info("Ticket spinlock: enabled\n");
>>>                return;
>>
>> What's the use case for this early param? To me that implies that a
>> platform may have another extension which would allow the usage of
> We want to use it for sg2042 & th1520. No new extension was
> introduced, and some micro-architecture could give LR/SC
> implementation a forward progress guarantee more than the spec
> required.


But then those platforms support Ziccrse which is enough to use 
qspinlocks right?

Thanks,

Alex


>
>> qspinlock, so why not listing it in riscv_spinlock_init() instead?
> List all platforms in riscv_spinlock_init is noisy, maybe give a
> qspinlock param in cmdline, and they could put it in their boot args.
>
>> Thanks,
>>
>> Alex
>>
>

