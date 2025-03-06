Return-Path: <linux-kernel+bounces-548103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE3EA53FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D703188F884
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA418B464;
	Thu,  6 Mar 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="U6n9MltG"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D12F5A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224963; cv=none; b=Ch23oLnHgsgU9dRF/MOzUedtC/xt88baFTuAQZ3rhzKMk1r8rm+9LPwjszUuwKVUE3dLcF+LZrqqbhKTgYRy9XcN4Dd/iiCr2ri9PKwloDB69Bbbc8fAy0r4ySy88YSJYbmtEXNbkqpAE/pjvwoYZLD1s0JFWMytQD+5VmKUwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224963; c=relaxed/simple;
	bh=m7Yrmh0IoxcGUiuEpPifwUioJMqsqBdm2uaqhnC+GTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZj3K2jz0WBt6WEt+WgnMlTXLAPx1L9ogENlirFCs6OHbVOf8nBL6x4g5D1kT5XmfkFp76nRNCn2iWckTar7Ak7fIAqFCa1Cf692PsJZEXZs4JKub5FXjrd2vufD23JiLrEkA9vWuwzV6fbBcADbCD0Hiy98rokRC1Q21/DmgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=U6n9MltG; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741224958; x=1741484158;
	bh=ND+2J8eDESvWBePjwilBskO3freJ/kVq1V4PGxH5RG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=U6n9MltG2oZDw4oQnDzNAEbic41sfYzDMZC1Uhu+g+sqKlwtjZ+vzK0KBjxISWLXv
	 L3YP863L/T7Xcg/NyKZjSjNFg4mrI7ZKc1TpPUtNRv/yO6LFKxIs8DQLavVNsdEFGb
	 LMVHpFSOcJcRewSEepiPjtp86hGJO3dHJGWfTyDVdEEmsFN/WkHXTZcp9X5Xlbo3Ur
	 2eMV5wSUw14CdFOaa4oJxN9KEa2u9mQSflSh07KLR6eD8L9M6fhTGUO3XgYgtqHPPL
	 xB9FW4oTVbTc/Z0cBB21ewkQ4RIP8pbg806bhkcDRTA+fMkFVXP0n3ix7RbdpCRC0v
	 nOY9PqgWhKqjw==
Date: Thu, 06 Mar 2025 01:35:52 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce `firmware::ModInfoBuilder`
Message-ID: <D88SQ87X0OHX.1ZD8LM8LKUQ8J@proton.me>
In-Reply-To: <Z8j6ckpD6JVY4m-p@pollux>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-3-dakr@kernel.org> <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me> <Z8jSV5CpZDcXrviY@pollux> <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me> <Z8jk3qs6nCIJz-39@pollux> <D88R7HI1Z6GG.ZOQ9A1VQOR28@proton.me> <Z8j6ckpD6JVY4m-p@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e2e6315ff5a51d3333eb47ebe8d3305ce534f871
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 6, 2025 at 2:29 AM CET, Danilo Krummrich wrote:
> On Thu, Mar 06, 2025 at 12:24:21AM +0000, Benno Lossin wrote:
>> On Thu Mar 6, 2025 at 12:57 AM CET, Danilo Krummrich wrote:
>> > On Wed, Mar 05, 2025 at 11:36:54PM +0000, Benno Lossin wrote:
>> >> On Wed Mar 5, 2025 at 11:38 PM CET, Danilo Krummrich wrote:
>> >> > On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
>> >> >> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
>> >> >> > +    /// Push an additional path component.
>> >> >> > +    ///
>> >> >> > +    /// After a new [`ModInfoBuilder`] instance has been create=
d, [`ModInfoBuilder::prepare`] must
>> >> >> > +    /// be called before adding path components.
>> >> >> > +    pub const fn push(self, s: &str) -> Self {
>> >> >> > +        if N !=3D 0 && self.n =3D=3D 0 {
>> >> >> > +            crate::build_error!("Must call prepare() before pus=
h().");
>> >> >>
>> >> >> This will only prevent the first `prepare` call being missed, righ=
t?
>> >> >
>> >> > Correct, unfortunately there's no way to detect subsequent ones.
>> >>
>> >> Does it make sense to do that one in the constructor?
>> >>
>> >> (After looking at the example below) Ah maybe you can't do that, sinc=
e
>> >> then you would have two `prepare()` calls for the example below...?
>> >
>> > Exactly.
>> >
>> >> >> If you always have to call this before `push`, why not inline it t=
here?
>> >> >
>> >> > You can push() multiple times to compose the firmware path string (=
which is the
>> >> > whole purpose :).
>> >>
>> >> Ah I see, I only looked at the example you have in the next patch. Al=
l
>> >> in all, I think this patch could use some better documentation, since=
 I
>> >> had to read a lot of the code to understand what everything is suppos=
ed
>> >> to do...
>> >
>> > I can expand the example in module_firmware! to make things a bit more=
 obvious.
>> >
>> > Otherwise, what information do you think is missing?
>>
>> Abstractly: what `ModInfoBuilder` *does*, concretely:
>> - why the generic constant `N` exists,
>
> It doesn't really matter to the user, since the user never needs to suppl=
y it.
> That happens in the module_firmware! macro.
>
> I agree it not good to not mention anything about it at all, but I wouldn=
't want
> to bother the user with all implemention details.
>
> We can probably just mention that it's used internally and is supplied by
> module_firmware!. (That module_firmware! does that by doing a dry run of =
the
> builder itself, isn't necessary to know for the user I think.)
>
>> - what `prepare()` does,
>
> Same here, it's an implementation detail not relevant to the user. All th=
e user
> needs to know is that prepare() acts as a separator to be able to supply =
the
> next firmware path.

How about calling it `new_path`/`new_entry` or similar?

>> - what happens with the `module_name` parameter of `new`
>
> Should probably just mention it's supplied by module_firmware! and used
> internally.

IIUC, that's not the case, the `module_firmware!` macro will call the
`create` function with the name and you're supposed to just pass it onto
the builder.

>> - answer the question "I want that the builder outputs the string `???`
>>   can it do that? If yes, how do I do it?"
>
> All it does is concatenating multiple &str in const context, which I thou=
ght is
> clear since there are only push() and prepare() as public methods.
>
> May it be that your request is more about can we add more hints on the
> implementation details rather than user focused documentation?

I am not familiar with MODULE_FIRMWARE in C, and I'd think that someone
that uses this API would know what to put into the `.modinfo` section,
so like "foo\0bar\0\0baz" (no idea if that makes sense, but just add
`firmware` or whatever is needed to make it make sense). And then the
question would be how to translate that into the builder.

I wouldn't be able to piece it together without looking at the
implementation.

---
Cheers,
Benno


