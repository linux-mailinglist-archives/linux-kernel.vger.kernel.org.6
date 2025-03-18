Return-Path: <linux-kernel+bounces-566184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7547A6746D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE25B7A9EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4120CCD0;
	Tue, 18 Mar 2025 12:58:24 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3B171A7;
	Tue, 18 Mar 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302703; cv=none; b=C3qSU1f3S6G41HX+reR82BGLE4JXKIGgS//DQ6k1BLoxsUUZRg4wEJ3D6aAcqovA1BER7Gcpr1NUVm2ov76/kyvL49E8A2z8axi1JaDblLiYSUzdvN5JW+iGnCq40LNpONouIdvkW5u+vbiZkvdNQsnSl56jc3obC1HPw5Q9sFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302703; c=relaxed/simple;
	bh=/X2GSPw6uV1Uob+CS+/GKYLyLZOg+hVrd6jS482AiBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm6qYC9oZhKnVwbGAxZQljCJ6rOb3SfI43FvTpeXHHWpKhrgFB3sf0IppnfY+YJ9M9WWAKhfmexXRIbRwz1TDd57eaT5nc0a0mroloL+jDD3wajOKtfx87BECvpwseZLysqqrUqO6tXoRaWwrpnO9Nabk2mUpsrj01wsL5LvlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15C0B43420;
	Tue, 18 Mar 2025 12:58:10 +0000 (UTC)
Message-ID: <d7a04d06-766b-4b43-8c42-2b681629c35d@ghiti.fr>
Date: Tue, 18 Mar 2025 13:58:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 charlie@rivosinc.com, cleger@rivosinc.com,
 Anup Patel <apatel@ventanamicro.com>, corbet@lwn.net
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
 <c5e174e4-4fce-4c7f-821a-cf3781becab4@ghiti.fr>
 <20250318-18b96818299ef211ef8ca620@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250318-18b96818299ef211ef8ca620@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemtggrvdehmeeifhdtkeemiegtfegsmeehtgeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemtggrvdehmeeifhdtkeemiegtfegsmeehtgeftddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemtggrvdehmeeifhdtkeemiegtfegsmeehtgeftdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggur
 dhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

On 18/03/2025 13:45, Andrew Jones wrote:
> On Tue, Mar 18, 2025 at 01:13:18PM +0100, Alexandre Ghiti wrote:
>> On 18/03/2025 09:48, Andrew Jones wrote:
>>> On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
>>>> Hi Drew,
>>>>
>>>> On 04/03/2025 13:00, Andrew Jones wrote:
>>>>> Allow skipping scalar and vector unaligned access speed tests. This
>>>>> is useful for testing alternative code paths and to skip the tests in
>>>>> environments where they run too slowly. All CPUs must have the same
>>>>> unaligned access speed.
>>>> I'm not a big fan of the command line parameter, this is not where we should
>>>> push uarch decisions because there could be many other in the future, the
>>>> best solution to me should be in DT/ACPI and since the DT folks, according
>>>> to Palmer, shut down this solution, it remains using an extension.
>>>>
>>>> I have been reading a bit about unaligned accesses. Zicclsm was described as
>>>> "Even though mandated, misaligned loads and stores might execute extremely
>>>> slowly. Standard software distributions should assume their existence only
>>>> for correctness, not for performance." in rva20/22 but *not* in rva23. So
>>>> what about using this "hole" and consider that a platform that *advertises*
>>>> Zicclsm means its unaligned accesses are fast? After internal discussion, It
>>>> actually does not make sense to advertise Zicclsm if the platform accesses
>>>> are slow right?
>>> This topic pops up every so often, including in yesterday's server
>>> platform TG call. In that call, and, afaict, every other time it has
>>> popped up, the result is to reiterate that ISA extensions never say
>>> anything about performance. So, Zicclsm will never mean fast and we
>>> won't likely be able to add any extension that does.
>>
>> Ok, I should not say "fast". Usually, when an extension is advertised by a
>> platform, we don't question its speed (zicboz, zicbom...etc), we simply use
>> it and it's up to the vendor to benchmark its implementation and act
>> accordingly (i.e. do not set it in the isa string).
>>
>>
>>>> arm64 for example considers that armv8 has fast unaligned accesses and can
>>>> then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
>>>> uarchs are slow. Distros will very likely use rva23 as baseline so they will
>>>> enable Zicclsm which would allow us to take advantage of this too, without
>>>> this, we lose a lot of perf improvement in the kernel, see
>>>> https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
>>>>
>>>> Or we could have a new named feature for this, even though it's weird to
>>>> have a named feature which would basically  mean "Zicclsm is fast". We don't
>>>> have, for example, a named feature to say "Zicboz is fast" but given the
>>>> vague wording in the profile spec, maybe we can ask for one in that case?
>>>>
>>>> Sorry for the late review and for triggering this debate...
>>> No problem, let's try to pick the best option. I'll try listing all the
>>> options and there pros/cons.
>>>
>>> 1. Leave as is, which is to always probe
>>>      pro: Nothing to do
>>>      con: Not ideal in all environments
>>>
>>> 2. New DT/ACPI description
>>>      pro: Describing whether or not misaligned accesses are implemented in
>>>           HW (which presumably means fast) is something that should be done
>>> 	in HW descriptions
>>>      con: We'll need to live with probing until we can get the descriptions
>>>           defined, which may be never if there's too much opposition
>>>
>>> 3. Command line
>>>      pro: Easy and serves its purpose, which is to skip probing in the
>>>           environments where probing is not desired
>>>      con: Yet another command line option (which we may want to deprecate
>>>           someday)
>>>
>>> 4. New ISA extension
>>>      pro: Easy to add to HW descriptions
>>>      con: Not likely to get it through ratification
>>>
>>> 5. New SBI FWFT feature
>>>      pro: Probably easier to get through ratification than an ISA extension
>>>      con: Instead of probing, kernel would have to ask SBI -- would that
>>>           even be faster? Will all the environments that want to skip
>>> 	probing even have a complete SBI?
>>>
>>> 6. ??
>>
>> So what about:
>>
>> 7. New enum value describing the performance as "FORCED" or "HW" (or
>> anything better)
>>      pro: We only use the existing Zicclsm
>>      con: It's not clear that the accesses are fast but it basically says to
>> SW "don't think too much, I'm telling you that you can use it", up to us to
>> describe this correctly for users to understand.
> But Zicclsm doesn't mean misaligned accesses are in HW, it just means
> they're not going to explode.


They never explode since if they are not supported by the HW, we rely on 
S-mode emulation already.


> We'd still need the probing to find out
> if the accesses are emulated (slow) or hw (fast). We at least want to
> know the answer to that question because we advertise it to userspace
> through hwprobe.
>
> (BTW, another pro of the command line is that it can be used to test
> both slow and fast paths without recompiling.)
>
> Thanks,
> drew

