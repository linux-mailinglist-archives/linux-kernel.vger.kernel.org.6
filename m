Return-Path: <linux-kernel+bounces-550678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46AA562D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981D7170262
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE51E1DEA;
	Fri,  7 Mar 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djpc60WN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33E1C861C;
	Fri,  7 Mar 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337037; cv=none; b=qTF1+0Kv+OWyUsgk/LB0Xcue9C9pt+Ezvcs5U5HKv+5s9UA0rDbUGjP33UFER/KLuDewA0tVQ7u+9I9wX8nz0o37wF8ne6OONMkIniNWZOVwmszIJ176j55gP3Km7ULwprh+HXMCtBFGZulV6tW4qQusNc0bkH2RoY3Kjz8T/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337037; c=relaxed/simple;
	bh=WcIPsud+/UeAJLAwbqQqP5bSvYxrFp1JApjAuuMLvBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfycIyIQhTlFHuXwXt2MV1rFnIlL42cUr35kN8SnIZsuO8d1d0q/conZj7s0zvPzzrcBQ5wQQee4eCp7sp0pvRDWUQC292wzIw8R4yFsqrtqUf74C9M5qYaFZU1fXPi6JdsVRks/WIE7TdcMlRkof+5tagdtPBcEAmGw9hjZfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djpc60WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A47C4CED1;
	Fri,  7 Mar 2025 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337037;
	bh=WcIPsud+/UeAJLAwbqQqP5bSvYxrFp1JApjAuuMLvBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Djpc60WNtcCDAgBW6fAFzRxWnnLVQTD60WFqtBpUQpTTqUYSWtPUuVc4/0JOR1qud
	 QDmsq3fwoTFHVQm6zRQQwGTE+HHe3raXaQix2tYp7YRaW0loKLs4lUHkZwsXEb1Nzx
	 g/hs+59KQQW8GVBjeUDdlgAFmfNyJILCHbPYM9ZQbOKwQ8Qagszuw8qYq3oBnDu8Im
	 FFkL9v50tNaO82qwUlgBwhRU5lzoCPTSABUcR+aCEMPDtJS0NPc6ToTFFRghhERE3R
	 HSMv8EdJQWWD4sjOg9XAir+VafiuJCPKdetb+TPy5gGT103bgOLIKwpK/Ap5+CWaAe
	 UN0OqLV/wRMKg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Ralf Jung" <post@ralfj.de>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "comex" <comexk@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <dakr@kernel.org>,
  <robin.murphy@arm.com>,  <rust-for-linux@vger.kernel.org>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Valentin Obst"
 <kernel@valentinobst.de>,  <linux-kernel@vger.kernel.org>,  "Christoph
 Hellwig" <hch@lst.de>,  "Marek Szyprowski" <m.szyprowski@samsung.com>,
  <airlied@redhat.com>,  <iommu@lists.linux.dev>,  <lkmm@lists.linux.dev>
Subject: Re: Allow data races on some read/write operations
In-Reply-To: <580cfb1a-3619-410f-8b03-61ee984c1b1f@ralfj.de> (Ralf Jung's
	message of "Wed, 05 Mar 2025 22:53:39 +0100")
References: <87bjuil15w.fsf@kernel.org> <87ikoqjg1n.fsf@kernel.org>
	<KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
	<CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
	<87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
	<ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
	<88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
	<hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
	<25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
	<CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
	<18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
	<3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> <87eczb71xs.fsf@kernel.org>
	<M_YejDCAOZ7AX0l8ZZ7Z5EesJicUgsjYJUTm0SzLkhYTAYyXRJFTr4QYZMagG4KX6YdHoT-IPhf8ygjircrs0A==@protonmail.internalid>
	<915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de> <87tt875fu8.fsf@kernel.org>
	<-_bKVxONywzmy2K6TPj5TT6swM4PhCN6ulfel4V8yTlJi3MzAGbIiKIVQ0TQzoVJ7wRfM8Ie5Jh5MSv9yf-sKg==@protonmail.internalid>
	<580cfb1a-3619-410f-8b03-61ee984c1b1f@ralfj.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 09:43:44 +0100
Message-ID: <87frjp5iyn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ralf Jung" <post@ralfj.de> writes:

> Hi all,
>
> On 05.03.25 22:26, Andreas Hindborg wrote:
>> "Ralf Jung" <post@ralfj.de> writes:
>>
>>> Hi all,
>>>
>>>>>> For some kinds of hardware, we might not want to trust the hardware.
>>>>>> I.e., there is no race under normal operation, but the hardware could
>>>>>> have a bug or be malicious and we might not want that to result in U=
B.
>>>>>> This is pretty similar to syscalls that take a pointer into userspace
>>>>>> memory and read it - userspace shouldn't modify that memory during t=
he
>>>>>> syscall, but it can and if it does, that should be well-defined.
>>>>>> (Though in the case of userspace, the copy happens in asm since it
>>>>>> also needs to deal with virtual memory and so on.)
>>>>>
>>>>> Wow you are really doing your best to combine all the hard problems a=
t the same
>>>>> time. ;)
>>>>> Sharing memory with untrusted parties is another tricky issue, and ev=
en leaving
>>>>> aside all the theoretical trouble, practically speaking you'll want to
>>>>> exclusively use atomic accesses to interact with such memory. So doin=
g this
>>>>> properly requires atomic memcpy. I don't know what that is blocked on=
, but it is
>>>>> good to know that it would help the kernel.
>>>>
>>>> I am sort of baffled by this, since the C kernel has no such thing and
>>>> has worked fine for a few years. Is it a property of Rust that causes =
us
>>>> to need atomic memcpy, or is what the C kernel is doing potentially da=
ngerous?
>>>
>>> It's the same in C: a memcpy is a non-atomic access. If something else
>>> concurrently mutates the memory you are copying from, or something else
>>> concurrently reads/writes the memory you are copying two, that is UB.
>>> This is not specific to memcpy; it's the same for regular pointer loads=
/stores.
>>> That's why you need READ_ONCE and WRITE_ONCE to specifically indicate t=
o the
>>> compiler that these are special accesses that need to be treated differ=
ently.
>>> Something similar is needed for memcpy.
>>
>> I'm not a compiler engineer, so I might be wrong about this, but. If I
>> do a C `memcpy` from place A to place B where A is experiencing racy
>> writes, if I don't interpret the data at place B after the copy
>> operation, the rest of my C program is fine and will work as expected.
>
> The program has UB in that case. A program that has UB may work as expect=
ed
> today, but that changes nothing about it having UB.
> The C standard is abundantly clear here:
> "The execution of a program contains a data race if it contains two confl=
icting
> actions in different threads, at least one of which is not atomic, and ne=
ither
> happens before the other. Any such data race results in undefined behavio=
r."
> (C23, =C2=A75.1.2.4)
>
> You are describing a hypothetical language that treats data races in a di=
fferent
> way. Is such a language *possible*? Definitely. For the specific case you
> describe here, one "just" has to declare read-write races to be not UB, b=
ut to
> return "poison data" on the read side (poison data is a bit like uninitia=
lized
> memory or padding), which the memcpy would then store on the target side.=
 Any
> future interpretation of the target memory would be UB ("poison data" is =
not the
> same as "random data"). Such a model has actually been studied [1], thoug=
h no a
> lot, and not as a proposal for a semantics of a user-facing language. (Ra=
ther,
> that was a proposal for an internal compiler IR.) The extra complications
> incurred by this choice are significant -- there is no free lunch here.
>
> [1]: https://sf.snu.ac.kr/publications/promising-ir-full.pdf
>
> However, C is not that language, and neither is Rust. Defining a concurre=
ncy
> memory model is extremely non-trivial (there's literally hundreds of pape=
rs
> proposing various different models, and there are still some unsolved pro=
blems).
> The route the C++ model took was to strictly rule out all data races, and=
 since
> they were the first to actually undertake the effort of defining a model =
at this
> level of rigor (for a language not willing to pay the cost that would be
> incurred by the Java concurrency memory model), that has been the standar=
d ever
> since. There's a lot of subtle trade-offs here, and I am far from an expe=
rt on
> the exact consequences each different choice would have. I just want to c=
aution
> against the obvious reaction of "why don't they just". :)
>

Thanks for the elaborate explanation.

>
>> I
>> may even later copy the data at place B to place C where C might have
>> concurrent reads and/or writes, and the kernel will not experience UB
>> because of this. The data may be garbage, but that is fine. I am not
>> interpreting the data, or making control flow decisions based on it. I
>> am just moving the data.
>>
>> My understand is: In Rust, this program would be illegal and might
>> experience UB in unpredictable ways, not limited to just the data that
>> is being moved.
>
> That is correct. C and Rust behave the same here.

Is there a difference between formal models of the languages and
practical implementations of the languages here? I'm asking this because
C kernel developers seem to be writing these programs that are illegal
under the formal spec of the C language, but work well in practice.
Could it be the same in Rust?

That is, can I do this copy and get away with it in practice under the
circumstances outlined earlier?

>
>> One option I have explored is just calling C memcpy directly, but
>> because of LTO, that is no different than doing the operation in Rust.
>>
>> I don't think I need atomic memcpy, I just need my program not to
>> explode if I move some data to or from a place that is experiencing
>> concurrent writes without synchronization. Not in general, but for some
>> special cases where I promise not to look at the data outside of moving
>> it.
>
> I'm afraid I do not know of a language, other than assembly, that can pro=
vide this.
>
> Atomic memcpy, however, should be able to cover your use-case, so it seem=
s like
> a reasonable solution to me? Marking things as atomic is literally how yo=
u tell
> the compiler "don't blow up if there are concurrent accesses".

If atomic memcpy is what we really need to write these kinds of programs in
Rust, what would be the next steps to get this in the language?

Also, would there be a performance price to pay for this?


Best regards,
Andreas Hindborg




