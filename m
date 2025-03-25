Return-Path: <linux-kernel+bounces-574961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BCCA6EC04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368B13AD17C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D21D6DD4;
	Tue, 25 Mar 2025 08:58:45 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081C1A5B8B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893124; cv=none; b=IPKceIFtlrv/bxxzRAKauLIZ3t9E5zfQGfnd5AbAwxZ6bI+TobUPJX9ZG5WDfJn3QEWXCKQbnstC5VZF7xwzo63mKx6DxtOikUUuI/d32UNgql+7Ro4iwtwyh81ByxIl0lhI7TqucfrMP0kgYhcLoecaBpcveNJG3c5YOpePfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893124; c=relaxed/simple;
	bh=55PQBj5fv1Uc+oM6j1RQiORx3O0YAV8Gh9Wdp/7Eefk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdfK54WJKDqy6UbHBYZ7hUyuQCJoKINp9EKI91KZrfAK5Qtj8pufgqhlgmisP/lS1HqMJbdlbi5CR6RGsrptI+1lo7tOH+Q8RZIy1mLJ3MlWqMKZ2OEebCqeriVCSu8lPyrEUdOvzBSX8LXZVFt7pnYJ1W4+j2xBdP+6hOSEGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C0F3443CC;
	Tue, 25 Mar 2025 08:58:32 +0000 (UTC)
Message-ID: <29c9eeff-6146-4f3b-b1e1-e7ed20fa98a3@ghiti.fr>
Date: Tue, 25 Mar 2025 09:58:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Use Zalrsc extension to implement atomic
 functions
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 "samuel.holland@sifive.com" <samuel.holland@sifive.com>,
 Conor Dooley <conor@kernel.org>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "leobras@redhat.com" <leobras@redhat.com>,
 "guoren@kernel.org" <guoren@kernel.org>,
 "ericchancf@google.com" <ericchancf@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <17E9A830-AE5C-41F5-AC07-2BD9C70739BB@jrtc27.com>
 <mhng-50508e34-b5cc-4dad-b4d4-7d2bac5a74d8@palmer-ri-x1c9>
 <AM6PR09MB26808ACAD8DF14A7F63808D0F7FC2@AM6PR09MB2680.eurprd09.prod.outlook.com>
 <AS4PR09MB6518D0A168465DF5F0890B8EF7D92@AS4PR09MB6518.eurprd09.prod.outlook.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <AS4PR09MB6518D0A168465DF5F0890B8EF7D92@AS4PR09MB6518.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeefueeujeevfeduheduuefhveejvdevgfegieeuhffghfeuhfelffegkedtjeevffenucffohhmrghinhepmhhiphhsrdgtohhmpdgrkhgrrdhmshdpkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepffhjohhrughjvgdrvfhoughorhhovhhitgeshhhtvggtghhrohhuphdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehjrhhttgdvjeesjhhrthgtvdejrdgtohhmpdhrtghpthhtoheptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmp
 dhrtghpthhtohepshgrmhhuvghlrdhhohhllhgrnhgusehsihhfihhvvgdrtghomhdprhgtphhtthhopegtohhnohhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhikhgrlhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Djordje,

On 19/03/2025 13:28, Djordje Todorovic wrote:
> HTEC Public
>
> Hi everyone,
>
> Thank you a lot for your comments.
> I am wondering how we should proceed from here.


I read the previous comments and everyone seems to agree that an 
implementation using an alternative is the way to go, so can you come 
with a new version doing that?

Thanks,

Alex


>
> Best,
> Djordje
>
> ________________________________________
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> Sent: Wednesday, February 12, 2025 11:22 AM
> To: Palmer Dabbelt <palmer@dabbelt.com>; jrtc27@jrtc27.com <jrtc27@jrtc27.com>
> Cc: Charlie Jenkins <charlie@rivosinc.com>; samuel.holland@sifive.com <samuel.holland@sifive.com>; Conor Dooley <conor@kernel.org>; arikalo@gmail.com <arikalo@gmail.com>; linux-riscv@lists.infradead.org <linux-riscv@lists.infradead.org>; Paul Walmsley <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu <aou@eecs.berkeley.edu>; Will Deacon <will@kernel.org>; peterz@infradead.org <peterz@infradead.org>; boqun.feng@gmail.com <boqun.feng@gmail.com>; Mark Rutland <mark.rutland@arm.com>; yury.norov@gmail.com <yury.norov@gmail.com>; linux@rasmusvillemoes.dk <linux@rasmusvillemoes.dk>; parri.andrea@gmail.com <parri.andrea@gmail.com>; leobras@redhat.com <leobras@redhat.com>; guoren@kernel.org <guoren@kernel.org>; ericchancf@google.com <ericchancf@google.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2] riscv: Use Zalrsc extension to implement atomic functions
>
> Hi,
>
> The official product page is located here:
> https://mips.com/products/hardware/p8700
>
> The mechanism we use to handle AMO is described in:
> "7.3.10 MIPS Configuration 6 Register (mipsconfig6)"
>
> Best,
> Djordje
>
> ________________________________________
> From: Palmer Dabbelt <palmer@dabbelt.com>
> Sent: Wednesday, February 5, 2025 4:49 PM
> To: jrtc27@jrtc27.com <jrtc27@jrtc27.com>
> Cc: Charlie Jenkins <charlie@rivosinc.com>; samuel.holland@sifive.com <samuel.holland@sifive.com>; Conor Dooley <conor@kernel.org>; arikalo@gmail.com <arikalo@gmail.com>; linux-riscv@lists.infradead.org <linux-riscv@lists.infradead.org>; Paul Walmsley <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu <aou@eecs.berkeley.edu>; Will Deacon <will@kernel.org>; peterz@infradead.org <peterz@infradead.org>; boqun.feng@gmail.com <boqun.feng@gmail.com>; Mark Rutland <mark.rutland@arm.com>; yury.norov@gmail.com <yury.norov@gmail.com>; linux@rasmusvillemoes.dk <linux@rasmusvillemoes.dk>; parri.andrea@gmail.com <parri.andrea@gmail.com>; leobras@redhat.com <leobras@redhat.com>; guoren@kernel.org <guoren@kernel.org>; ericchancf@google.com <ericchancf@google.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Subject: Re: [PATCH v2] riscv: Use Zalrsc extension to implement atomic functions
>
> [You don't often get email from palmer@dabbelt.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, 03 Feb 2025 13:34:48 PST (-0800), jrtc27@jrtc27.com wrote:
>> On 3 Feb 2025, at 19:50, Charlie Jenkins <charlie@rivosinc.com> wrote:
>>> On Mon, Feb 03, 2025 at 01:30:48PM -0600, Samuel Holland wrote:
>>>> Hi Charlie,
>>>>
>>>> On 2025-02-03 1:12 PM, Charlie Jenkins wrote:
>>>>> On Sun, Feb 02, 2025 at 08:08:50PM +0000, Conor Dooley wrote:
>>>>>> On Sat, Feb 01, 2025 at 01:04:25PM +0100, Aleksandar Rikalo wrote:
>>>>>>> On Fri, Jan 10, 2025 at 4:23 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
>>>>>>>
>>>>>>>>> From: Chao-ying Fu <cfu@mips.com>
>>>>>>>>>
>>>>>>>>> Use only LR/SC instructions to implement atomic functions.
>>>>>>>> In the previous patch you mention that this is to support MIPS P8700. Can
>>>>>>>> you expand on why this change is required? The datasheet at [1] says:
>>>>>>>>
>>>>>>>> "The P8700 core is configured to support the RV64GCZba_Zbb (G = IMAFD)
>>>>>>>> Standard ISA. It includes the RV64I base ISA, Multiply (M), Atomic (A),
>>>>>>>> Single-Precision Floating Point (F), Double (D), Compressed (C) RISC-V
>>>>>>>> extensions, as well as the as well as the bit-manipulation extensions
>>>>>>>> (Zba) and (Zbb)"
>>>>>>>>
>>>>>>>> The "A" extension is a part of "G" which is mostly assumed to exist in
>>>>>>>> the kernel. Additionally, having this be a compilation flag will cause
>>>>>>>> traps on generic kernels. We generally try to push everything we can
>>>>>>>> into runtime feature detection since there are so many possible variants
>>>>>>>> of riscv.
>>>>>>>>
>>>>>>>> Expressing not being able to perform a feature like this is normally
>>>>>>>> better expressed as an errata. Then generic kernels will be able to
>>>>>>>> include this, and anybody who doesn't want to have the extra nops
>>>>>>>> introduced can disable the errata. A similar approach to what I pointed
>>>>>>>> out last time should work here too (but with more places to replace)
>>>>>>>> [2].
>>>>>>>>
>>>>>>>> [1] https://mips.com/wp-content/uploads/2024/11/P8700_Data_Sheet.pdf
>>>>>>>> [2] https://lore.kernel.org/lkml/Z2-UNfwcAQYZqVBU@ghost/T/
>>>>>>> So far we haven't found a way to do this using errata.
>>>>>> You mean using alternatives? Not implementing A, but instead
>>>>>> implementing Zalrsc, is not an erratum. It's a design decision.
>>>>> We could do the same thing we do with misaligned access detection and
>>>>> run some instructions to determine if these instructions are being
>>>>> emulated.  If they are being emulated, patch all of the places to use
>>>>> zalrsc.
>>>> Is the implication here that the riscv,isa-extensions list passed to the kernel
>>>> will contain "a", even though the hardware does not support it, because AMOs are
>>>> emulated in M-mode?
>>>>
>>>> If that is not the case, there is no need for runtime detection. The alternative
>>>> entry can check RISCV_ISA_EXT_ZAAMO (which would be implied by RISCV_ISA_EXT_a)
>>>> in the ISA bitmap like normal.
>>> That would be much better! I was under the assumption that the usecase
>>> for this patch was that they were passing in "a" and wanting to only get
>>> zalrsc. We should be able to check
>>> RISCV_ISA_EXT_ZAAMO/RISCV_ISA_EXT_ZALRSC to get the information without
>>> runtime detection.
>> In LLVM at least -mcpu=mips-p8700 enables the full A extension...
> So then I think we need some help from the HW vendor here.
> Specifically: do these systems implement A via M-mode traps (ie, with a
> performance penalty) or is there something functional erratum in the A
> implementation.
>
> If it's just a performance thing then we need some benchmark justifying
> the extra work, which means some hardware we can point at to run the
> benchmark.  Probably also best to shim this in via alternatives, so we
> can keep multi-vendor kernels working.
>
> If it's a funtional issue then we need to know what's actually broken.
>
> Either way this should be exposed to userspace.
>
>> Jess
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

