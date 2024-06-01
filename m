Return-Path: <linux-kernel+bounces-197757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3988D6EBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C461F22D9D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647161CD18;
	Sat,  1 Jun 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="JJ0LLPgU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD0EC5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717228964; cv=none; b=nvyjOMzhtaBxil0ACA/fjPRqmy1XnWllsH40eSs+xlqrz3htQ2t7YyMo8MSwuFxkinaippF1WS15O3QsHs/cKHb+3asq/OSaF8UWyGsOeit+m+x4xcOJUkK12RFtcHF9YIl9WYGmoPtyqT0jC6zyq4GKV40VMR7lAxqOQpCmBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717228964; c=relaxed/simple;
	bh=LV+nTfQrNm9JuD6so9+tLXvK1RfIWRBBjx/RtEMXrxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emo4mMYV0AB9qCttzEMupn+mAbl4rKBIxQyCdjJMuUc5Lkei7wwsS2CRqm09jWT4mHEslV5zHR/sAv6WKJYreLZVveZxuIUIDEGaVMoHqQOm1A0087OBJCew3MksOLMV7OUk5uzfiiV7oBIiZD9ZE00OG1uGaCOCLx+21ZYUqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=JJ0LLPgU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68a4a9946cso41988266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717228960; x=1717833760; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=69q8BOA2HtuqUsGk+xcfSWLfLYw1EbLotBQHq1Zf46U=;
        b=JJ0LLPgUDAbwvxN2tkE+RP8cZkFuJt8shRYe/gGkSiTGookwfZRRcONLCH/ktqCVaL
         0OnIgBSeQkBQ5BLZLb/o+5LtJ6L/MXXFUSnt7hGAfvQVltca7rsrMRgL4QqApY761fSS
         nCkzPIwBNjfFF+BeGMlKKzdo0nlQivuTVA42iS5Yqd2rht0nWaM8vq5VkcgFX3O53L3y
         VQ5l9LaVI/SyzHcLg0aqBZce9/5BPA+6zPicIMnaScupIXkBqhSOKEbyTSrkvbda2Vfn
         POcnMunhx2bqwKH84XciUZ1CfDEOs3kxCIkqY2RmOLZiTOMMCKKEe5+uIPnILZJM2HrK
         T5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717228960; x=1717833760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69q8BOA2HtuqUsGk+xcfSWLfLYw1EbLotBQHq1Zf46U=;
        b=DF/KSBPESgQMJBPIj1Z5YzL51SMDahH4QwmwIKU8gN3Lg1HN+K9gXwi+ECzoS+g503
         HQh71eeMODmJyMxiEcoj2VCTsnOvuFFP+upk2lvPH5W5wkVmDnj60S86qa1GTPLH2+Pj
         YVq4RowX4g1DZNAzrUla4PH9vTYw2+dqR9V4MQ5GVxD29a+bMhxNFgyaSTKguIJNsOpZ
         0X1O5NNyMmMVElCiE0JEcZMQeX62uWNP7/e7LcvTZF10J1GtzEt7Hts/9S3q0T6OVhx+
         kgiOKL1E4AZSni9wtCcnLeOBOU/IoAp55Vrla84yTxhOoqPvmJnT5BpWneC3f2oSbLDA
         jLRg==
X-Forwarded-Encrypted: i=1; AJvYcCULejydk+BExHNHbQ/01QunbROheW6KEUm1uZyLkfFlGCTH8Y/ixz6Htfw+5ELeCgloan9GMxMRVr9QRnQrFdE6uABbOea5m/T785vf
X-Gm-Message-State: AOJu0YwySdlgQgUxJR3LMLNI8KIaolL+e1k4t+Crb/pfVgHiwMtSG5lj
	VhY56ZwMt/LOdRrAJRiSD2EGj6YkgcKcbe/q4W0I55NM2knrzDAQMj6OPmwsCEM=
X-Google-Smtp-Source: AGHT+IFoXsR9lLS5Un7iKX1TAD1qWCPnuSF+dNJROCxvnLguZhaQZ+Aey5jmXTHa2lQfpMw/Xrhe2Q==
X-Received: by 2002:a17:906:3bc1:b0:a58:a0b8:2a64 with SMTP id a640c23a62f3a-a681fc5caf7mr289071666b.5.1717228959921;
        Sat, 01 Jun 2024 01:02:39 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea67b67fsm172376866b.109.2024.06.01.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:02:39 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <dlemoal@kernel.org>,  Bart Van
 Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,  Ming Lei
 <ming.lei@redhat.com>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
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
Subject: Re: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <8ae158cd-d2ee-4698-8034-9fe1e31c7ca5@proton.me> (Benno Lossin's
	message of "Wed, 29 May 2024 18:18:30 +0000")
References: <20240521140323.2960069-1-nmi@metaspace.dk>
	<20240521140323.2960069-3-nmi@metaspace.dk>
	<d7b963f0-060f-44c0-8358-fb8dbd064575@proton.me>
	<87o78orcvz.fsf@metaspace.dk>
	<8ae158cd-d2ee-4698-8034-9fe1e31c7ca5@proton.me>
Date: Sat, 01 Jun 2024 10:02:26 +0200
Message-ID: <87r0dhnl9p.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

[...]

>>>> +
>>>> +fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice, gen_disk::Added>> {
>>>
>>> Any reason that this is its own function and not in the
>>> `NullBlkModule::init` function?
>> 
>> Would you embed it inside the `init` function? To what end? I don't
>> think that would read well.
>
> I just found it strange that you have this extracted into its own
> function, since I just expected it to be present in the init function.
> Does this look really that bad?:
>
>     impl kernel::Module for NullBlkModule {
>         fn init(_module: &'static ThisModule) -> Result<Self> {
>             pr_info!("Rust null_blk loaded\n");
>             let block_size: u16 = 4096;
>             if block_size % 512 != 0 ||
> !(512..=4096).contains(&block_size) {
>                 return Err(kernel::error::code::EINVAL);
>             }
>
>             let disk = {
>                 let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1),
> flags::GFP_KERNEL)?;
>                 let mut disk = gen_disk::try_new(tagset)?;
>                 disk.set_name(format_args!("rnullb{}", 0))?;
>                 disk.set_capacity_sectors(4096 << 11);
>                 disk.set_queue_logical_block_size(block_size.into());
>                 disk.set_queue_physical_block_size(block_size.into());
>                 disk.set_rotational(false);
>                 disk.add()
>             };
>             let disk = Box::pin_init(
>                 new_mutex!(disk, "nullb:disk"),
>                 flags::GFP_KERNEL,
>             )?;
>
>             Ok(Self { _disk: disk })
>         }
>     }

I don't mind either way. I guess we could combine it.

[...]

>>>> +#[vtable]
>>>> +impl Operations for NullBlkDevice {
>>>> +    #[inline(always)]
>>>> +    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>>>> +        mq::Request::end_ok(rq)
>>>> +            .map_err(|_e| kernel::error::code::EIO)
>>>> +            .expect("Failed to complete request");
>>>
>>> This error would only happen if `rq` is not the only ARef to that
>>> request, right?
>> 
>> Yes, it should never happen. If it happens, something is seriously
>> broken and panic is adequate.
>> 
>> Other drivers might want to retry later or something, but in this case
>> it should just work.
>
> In that case, I think the error message should reflect that and not just
> be a generic "failed to complete request" error.

Right, that is a good point.


Best regards,
Andreas

