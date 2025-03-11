Return-Path: <linux-kernel+bounces-556206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656DA5C26F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71D71886B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17F1D86C3;
	Tue, 11 Mar 2025 13:20:38 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252A1C3C1D;
	Tue, 11 Mar 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699238; cv=none; b=Jqx/cNAEINZqKP2wEM+x8Y6R5w9T7yTrupIKPmJMRuqIvSKeh9oDT/3VuXoFgxHD4qlVn5J23DifAeXzREAjDqa3hYEve1c4ErkBbxjnAjLVykR4eiRTQ6peYu4P9lmQUWzlCGYNHXCvTMXwt46WroA4sHxhq4FLSuBPrwODq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699238; c=relaxed/simple;
	bh=LgaESzjXcHruS6lQJ+Jxj1MSO0SOrxhe+KCt3X1WprE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iV81W0OO+/Ca0enJvFYBfG54mL06HUoy2wpUO9Gbg4OES27h0yG17O2JvKdU4fw84G/52vhbsBEgFr6iPvqlCr2Puam4GXs8PeSIHSeNJ2fAgqH7bis7KqWqX0AgjwjoSrxgmhnWM1qFbLAfwVlhXgdBbJVeJ8a221senKxhZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE2D0444F4;
	Tue, 11 Mar 2025 13:20:22 +0000 (UTC)
Message-ID: <e72db46d-53b2-47f6-814f-9653d783e745@ghiti.fr>
Date: Tue, 11 Mar 2025 14:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] riscv: Add bfloat16 instruction support
Content-Language: en-US
To: Inochi Amaoto <inochiama@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20250213003849.147358-1-inochiama@gmail.com>
 <d6t25jmcf57sqpjqwykhdf3ju6v3wwpyaiumll4x6bjfhcohl5@oikmnpusjn6u>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <d6t25jmcf57sqpjqwykhdf3ju6v3wwpyaiumll4x6bjfhcohl5@oikmnpusjn6u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeuffefvdelteelteejhfejhedujeetteevtddvvddthfeiteffledvffeggfeiieenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepfedurdefvddrkedurddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdefvddrkedurddukeejpdhhvghloheplgduledvrdduieekrddvuddrvdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehinhhotghhihgrmhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehro
 hgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Inochi,

On 11/03/2025 13:34, Inochi Amaoto wrote:
> On Thu, Feb 13, 2025 at 08:38:44AM +0800, Inochi Amaoto wrote:
>> Add description for the BFloat16 precision Floating-Point ISA extension,
>> (Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
>> ("Added Chapter title to BF16") of the riscv-isa-manual.
>>
>> Changed from v3:
>> 1. rebase for v6.14-rc1
>> 2. patch2: add validate for zfbfmin, zvfbfmin, zvfbfwma
>> 3. patch2: apply Clément's tag
>>
>> Changed from v2:
>> 1. rebase for v6.13-rc1
>>
>> Changed from v1:
>> 1. patch3: add missing code in sys_hwprobe.c
>>
>> Inochi Amaoto (3):
>>    dt-bindings: riscv: add bfloat16 ISA extension description
>>    riscv: add ISA extension parsing for bfloat16 ISA extension
>>    riscv: hwprobe: export bfloat16 ISA extension
>>
>>   Documentation/arch/riscv/hwprobe.rst          | 12 +++++
>>   .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
>>   arch/riscv/include/asm/hwcap.h                |  3 ++
>>   arch/riscv/include/uapi/asm/hwprobe.h         |  3 ++
>>   arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++
>>   arch/riscv/kernel/sys_hwprobe.c               |  3 ++
>>   6 files changed, 101 insertions(+)
>>
>> --
>> 2.48.1
>>
> I wonder whether this patch could get merged? So I can
> submit the SG2044 board dts without this as dependency.


It is on my list for for-next so it *should* be merged in 6.15.

Thanks,

Alex


>
> Regards,
> Inochi
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

