Return-Path: <linux-kernel+bounces-197839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862A8D6FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A7928374E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81114F9E8;
	Sat,  1 Jun 2024 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="D95O8gAU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF214F11D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246308; cv=none; b=a86K4+itPTNImXIhJFNvNfthsHKw5YfPbWubUq3+PMThdplVZAc8z0biWWhP65GKGPUbdAofFIPkJAJyGE0P03+aPEKT6MNB3f6xAcmTUDk4d33ZRmnfstEVIub0vYpJzbP9qBmU2iYNxlr6DqoWLehUKiLrMUYGpprsJ3NY03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246308; c=relaxed/simple;
	bh=R1YHDbBaxFe/Hs3ahw8yOS7ZW/+iOPdOOQSS6kDAz14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmXeeieDdA/3wBucBBWhMfsuMgTQkcRwXNpqaoh5aAxgvDvMUOR1CyijwVeDOtNPM/N1yI4WzYIAnYnR5LBqwjbNzgOmcU+J6FAModdL/dzzk1kuvVKHMvRErcPqPQBE0YpaNsVQwbIFy/3p1h+dUM5khaTPa05qHk+nCZFFA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=D95O8gAU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so33371266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717246305; x=1717851105; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8m5Sx5bPSHuqSciP5UrM5/Jt+7QH5gxMJXauGBuy/c=;
        b=D95O8gAUW6K6xgJFk1q7c2joqsHTxUP1uNUc2V/g8Xgci5D1XjIOuizmErIIjueik4
         qbQHqRxWaLexzvwE/RK+FjsYdFb987JYY8EbC0aXzJI/XnN+tYKjcFCXjdkRBACYPHTc
         YfFm//L5BYV3owt8e+kU3wYQnTuUjeS9uBFqbnf5Iw6jTWo2xp0nmhbKInKvcOyHYbky
         qmVY9bpYYgu5CwLy3qTTJthLu6d59JgynM5i0jSBVKn4KIZziqmJSg+9v81XeoIrfvcO
         qVhZEPlbnsz6FJWUsqulrhRVADD/IXMOWDHqMMOh83gZgeIvbSwHRqlmL6CjwiBYOUQX
         hGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717246305; x=1717851105;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8m5Sx5bPSHuqSciP5UrM5/Jt+7QH5gxMJXauGBuy/c=;
        b=LVmSeKEslbgJNRSfsrguqrjxL1mUyBysit5UbxnWyUx05Lapi4l+xKQYNyB/9whinl
         2D909jwGtt9pULJN5Zujm/yUGVoacc92K38I9M/xt0Ts6r9YG1QGAhgi2Wpoe+v02ao3
         ZPqJkV82A3RxxStyMZK4uk0Kukp8ze88qTx5GenP2ucFMpSTomTWomSi5LP9mgNcR1hH
         mVGM2/hYosKYqPD0t8s3RlLLA/ltJXtTEpW0TeqJlNFhLVdJYRILEYTs2KeAYyLBvUk2
         9ZtP7CBfHQkvfRTZe5cUpSJ+2rEU+ooyq5NS+57HvoafK/w/fvXrKiUDqsICug+C3WmH
         wiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvj4d25kIvZIpCkAtkXnmghgtTPFj33J6NFS7RIdkerzoX7ehgEpysiCSNXNXl94ho5/rdJ5liRvpqCs6Ql4JVaSLgSLuludxsK4F9
X-Gm-Message-State: AOJu0YyyBo2frcJRqw7xEHM/dqqBCP0otqJrr5FnIH7hBvOsRLPDQEcx
	/sA0cAkuyE2d0kR0tol5MfU7fhh8wK6XcOVlpfi/bZ48VrIt9xEx2tJDAhVTfCo=
X-Google-Smtp-Source: AGHT+IFs2+LAaH95PVDpW8OdGc8G4CRUkQWQVg7/mYluqrKLWvhLrN0s1sZC70ZkBOUUB3D7YRsglw==
X-Received: by 2002:a17:906:2b4e:b0:a62:8116:cb59 with SMTP id a640c23a62f3a-a682022f707mr281662066b.30.1717246304550;
        Sat, 01 Jun 2024 05:51:44 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a687cc4e903sm159492366b.216.2024.06.01.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:51:44 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,  Bart Van
 Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v3 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <696d50c4-a2b0-4c72-890e-be27f48f0fb3@proton.me> (Benno Lossin's
	message of "Sat, 01 Jun 2024 12:05:10 +0000")
References: <20240601081806.531954-1-nmi@metaspace.dk>
	<20240601081806.531954-2-nmi@metaspace.dk>
	<47a8ce04-3901-49ae-abac-a7d85901f980@proton.me>
	<87ikysor3q.fsf@metaspace.dk>
	<696d50c4-a2b0-4c72-890e-be27f48f0fb3@proton.me>
Date: Sat, 01 Jun 2024 14:51:38 +0200
Message-ID: <87a5k4omg5.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 01.06.24 13:11, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> On 01.06.24 10:18, Andreas Hindborg wrote:
>>>> +    /// This function is called by the C kernel. A pointer to this function is
>>>> +    /// installed in the `blk_mq_ops` vtable for the driver.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// This function may only be called by blk-mq C infrastructure.
>>>> +    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
>>>> +        T::commit_rqs()
>>>> +    }
>>>> +
>>>> +    /// This function is called by the C kernel. It is not currently
>>>> +    /// implemented, and there is no way to exercise this code path.
>>>
>>> Is it also possible to completely remove it? ie use `None` in the
>>> VTABLE, or will the C side error?
>> 
>> No, this pointer is not allowed to be null. It must be a callable
>> function, hence the stub. It will be populated soon enough when I send
>> patches for the remote completion logic.
>
> Makes sense.
>
> [...]
>
>>>> +impl<T: Operations> TagSet<T> {
>>>> +    /// Try to create a new tag set
>>>> +    pub fn try_new(
>>>> +        nr_hw_queues: u32,
>>>> +        num_tags: u32,
>>>> +        num_maps: u32,
>>>> +    ) -> impl PinInit<Self, error::Error> {
>>>> +        try_pin_init!( TagSet {
>>>> +            // INVARIANT: We initialize `inner` here and it is valid after the
>>>> +            // initializer has run.
>>>> +            inner <- unsafe {kernel::init::pin_init_from_closure(move |place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
>>>> +                let place = place.cast::<bindings::blk_mq_tag_set>();
>>>> +
>>>> +                // SAFETY: pin_init_from_closure promises that `place` is writable, and
>>>> +                // zeroes is a valid bit pattern for this structure.
>>>> +                core::ptr::write_bytes(place, 0, 1);
>>>> +
>>>> +                /// For a raw pointer to a struct, write a struct field without
>>>> +                /// creating a reference to the field
>>>> +                macro_rules! write_ptr_field {
>>>> +                    ($target:ident, $field:ident, $value:expr) => {
>>>> +                        ::core::ptr::write(::core::ptr::addr_of_mut!((*$target).$field), $value)
>>>> +                    };
>>>> +                }
>>>> +
>>>> +                // SAFETY: pin_init_from_closure promises that `place` is writable
>>>> +                    write_ptr_field!(place, ops, OperationsVTable::<T>::build());
>>>> +                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues);
>>>> +                    write_ptr_field!(place, timeout , 0); // 0 means default which is 30 * HZ in C
>>>> +                    write_ptr_field!(place, numa_node , bindings::NUMA_NO_NODE);
>>>> +                    write_ptr_field!(place, queue_depth , num_tags);
>>>> +                    write_ptr_field!(place, cmd_size , core::mem::size_of::<RequestDataWrapper>().try_into()?);
>>>> +                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_SHOULD_MERGE);
>>>> +                    write_ptr_field!(place, driver_data , core::ptr::null_mut::<core::ffi::c_void>());
>>>> +                    write_ptr_field!(place, nr_maps , num_maps);
>>>
>>> Did something not work with my suggestion?
>> 
>> I did not want to change it if we are rewriting it to `Opaque::init`
>> in a cycle or two, which I think is a better solution.
>
> Ah I was suggesting to do it now, but emulate the `Opaque::init`
> function (I should have been clearer about that).
> I tried to do exactly that, but failed to easily implement it, since the
> fields of `blk_mq_tag_set` include some structs, which of course do not
> implement `Zeroable`.
>
> Instead I came up with the following solution, which I find a lot nicer:
>
>     pub fn try_new(
>         nr_hw_queues: u32,
>         num_tags: u32,
>         num_maps: u32,
>     ) -> impl PinInit<Self, error::Error> {
>         // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which all are allowed to be 0.
>         let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
>         let tag_set = bindings::blk_mq_tag_set {
>             ops: OperationsVTable::<T>::build(),
>             nr_hw_queues,
>             timeout: 0, // 0 means default which is 30Hz in C
>             numa_node: bindings::NUMA_NO_NODE,
>             queue_depth: num_tags,
>             cmd_size: core::mem::size_of::<RequestDataWrapper>().try_into()?,
>             flags: bindings::BLK_MQ_F_SHOULD_MERGE,
>             driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
>             nr_maps: num_maps,
>             ..tag_set
>         };
>         try_pin_init!(TagSet {
>             inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set), |tag_set| {
>                 // SAFETY: we do not move out of `tag_set`.
>                 let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
>                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
>                 error::to_result(unsafe { bindings::blk_mq_alloc_tag_set(tag_set) })
>             }),
>             _p: PhantomData,
>         })
>     }
>
> I haven't tested it though, let me know if you have any problems.

I'll give it a try!

BR Andreas

