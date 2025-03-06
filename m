Return-Path: <linux-kernel+bounces-548034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455DDA53F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700CF3AF62A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58360B652;
	Thu,  6 Mar 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WZcVsfI7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE342114;
	Thu,  6 Mar 2025 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220678; cv=none; b=oEV8SWP6X0Biwxk5Faa3Pw9ySAUOXul4uxxhtOzew/933UmfSCziOvmqPIiYHiQQBoFYuxLlmF16kPxH5U4MzHMFPNemZxTty1HDGTkRjCfwXTjlR1PLt0IXxNXW7V+IxwPStx0VrgBSSyBFYxtX1OuTYtl7bwqOHApBf2FqKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220678; c=relaxed/simple;
	bh=3m2U1+pYS7QGJklmtySx4p//o0xoYGLDj/EIKv/pkkE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdYBs3Va/dKLOmSQdm/52AkvzNiL3y4jixVjIgeXLxdnaUo8l3f3i/IlSQNRF99lonkVBYkByauPQ8hhz+mI+CbA7VE2WHqvnEyoosjef3k2B7SgBsZ+FmRDMYDoEDfYU1RAlI7GhmYTUdAyP5dCXy5QqC+dmFiBYLby5MFoYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WZcVsfI7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7i7nfeayubfi5gqgovqg3wpoeq.protonmail; t=1741220667; x=1741479867;
	bh=zM6T0I1UDmm6pK0qaYYW60tPdabgjnBTsVC6Y/zI8KY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=WZcVsfI7qYj4WAZOGHfQb7lCbP1yZ1/lSOuNILHMFYSHa4/uZtr2x6VVCKmX2VSRu
	 4XBLKSpZrd6O0S6t4dQWmMS4vzSqk8KfEBjBYNy+xrMRPHvbTHk+FY+DlSEhAFhw8S
	 tnH8nfLTD3rXiSwAX+wQlw8xWBDJhUHJygGMCZVtsfDp3c7R9+t4xemK2xGtKISEsU
	 ROPXFdpVUwKYFvQ3PpSr3mbXIZ3En3zvogFQRAFbw9PF01jBFml22Ig0KbnsXZaVol
	 7+q8vjZJ3x9hAN+PzETkNgnZ3lVMOW/IqD7r5Qb5t2EKG1xZTL7ZJ1isqLqAzIX63o
	 JyTa0JnlpcsEw==
Date: Thu, 06 Mar 2025 00:24:21 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce `firmware::ModInfoBuilder`
Message-ID: <D88R7HI1Z6GG.ZOQ9A1VQOR28@proton.me>
In-Reply-To: <Z8jk3qs6nCIJz-39@pollux>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-3-dakr@kernel.org> <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me> <Z8jSV5CpZDcXrviY@pollux> <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me> <Z8jk3qs6nCIJz-39@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: da2143f6321c35ea1a493628d2ba460ec60f7fa3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 6, 2025 at 12:57 AM CET, Danilo Krummrich wrote:
> On Wed, Mar 05, 2025 at 11:36:54PM +0000, Benno Lossin wrote:
>> On Wed Mar 5, 2025 at 11:38 PM CET, Danilo Krummrich wrote:
>> > On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
>> >> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
>> >> > +    /// Push an additional path component.
>> >> > +    ///
>> >> > +    /// After a new [`ModInfoBuilder`] instance has been created, =
[`ModInfoBuilder::prepare`] must
>> >> > +    /// be called before adding path components.
>> >> > +    pub const fn push(self, s: &str) -> Self {
>> >> > +        if N !=3D 0 && self.n =3D=3D 0 {
>> >> > +            crate::build_error!("Must call prepare() before push()=
.");
>> >>
>> >> This will only prevent the first `prepare` call being missed, right?
>> >
>> > Correct, unfortunately there's no way to detect subsequent ones.
>>
>> Does it make sense to do that one in the constructor?
>>
>> (After looking at the example below) Ah maybe you can't do that, since
>> then you would have two `prepare()` calls for the example below...?
>
> Exactly.
>
>> >> If you always have to call this before `push`, why not inline it ther=
e?
>> >
>> > You can push() multiple times to compose the firmware path string (whi=
ch is the
>> > whole purpose :).
>>
>> Ah I see, I only looked at the example you have in the next patch. All
>> in all, I think this patch could use some better documentation, since I
>> had to read a lot of the code to understand what everything is supposed
>> to do...
>
> I can expand the example in module_firmware! to make things a bit more ob=
vious.
>
> Otherwise, what information do you think is missing?

Abstractly: what `ModInfoBuilder` *does*, concretely:
- why the generic constant `N` exists,
- what `prepare()` does,
- what happens with the `module_name` parameter of `new`
- answer the question "I want that the builder outputs the string `???`
  can it do that? If yes, how do I do it?"

>> It might also make sense to make this more generic, since one probably
>> also needs this in other places? Or do you think this will only be
>> required for modinfo?
>
> Currently, I don't think there's any more need for a generic const string
> builder. For now, I think we're good. Let's factor it out, once we have a=
ctual
> need for that.

Sounds good.

---
Cheers,
Benno


