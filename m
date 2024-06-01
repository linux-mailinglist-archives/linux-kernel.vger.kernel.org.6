Return-Path: <linux-kernel+bounces-197807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E1F8D6F77
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57451F22488
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0D84DEC;
	Sat,  1 Jun 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="0SiD5IoE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F76FB9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717240562; cv=none; b=CA6LfKRJmmZJsErv8nyjz8fKLsOqXDkwlj5dJnfOPdSiZR0p6Tc2SiOEPUNC9xIRvvlSjQRu9x/8FR0EclFibdR8L+gKFDmb3DnpAOynrU7OKWpC5jfSQDZnzjiRhzNTl8l1S/5K9sRIAJQDD0g10rUPHvNCA4ltXSk8jzew3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717240562; c=relaxed/simple;
	bh=/PJ2GjT7/rLhw5D4POjI70oJckkLJy4s/NNLOSXov2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrfDgRPp0pz6ukHb1Xgx9Y/17IfPzsuiLVZ569wlHpmU71OnDFJMNHthAiUJSI7mObzYXxmSG1UZKLFSaot+/wD2OYMdyLKk4u039I5P5ePVkwCO/I9CB/z0Db0HS7LuqSqHovpwXCTZEss9HmxAepVxrG+pS5l+qgnnuVbCAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=0SiD5IoE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so2808665a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717240558; x=1717845358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCryFmGVnMLpUEOQA4poMI+wOTAgkfQR64/zK6nQuRw=;
        b=0SiD5IoEXllMOqSknxxjRIoG55IRlLx9cyqV56ztzj3YuwI6pRLFbnppaFZ+8euC7M
         h7guB5Lyx4AjZqahRM0NHZ8qCVFWz4Vp1fOYY1zTDcER5rZqik7X2Lm6NT3KxnIDkhC3
         j97scRkElNwztko78UTYF5MqlHeyEnF1yDTQOZ5YA0d9fMROAwacpYHsXxqkdEazUC7Q
         n351qelNhX0xI0ugorV77H8VOLz2LOR0zXPfi9/wbUepCFBQfUUcDTgls6IudMhwRja3
         0QTuC6DzjzHD90XevQVoXmYCy6ZLkAxoJTWs0B8w1GukEec1B3ewhIKuOIPiBLEVZcf+
         Zkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717240558; x=1717845358;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCryFmGVnMLpUEOQA4poMI+wOTAgkfQR64/zK6nQuRw=;
        b=Upj6XgyIX63hEkhZ5eR+wjtBUBDnBIBdNfU2vyfXI4xGUl11hGRPgNZnrZLcCphMmF
         K539ia8s+IX/NSlagN2yhEGgPQkQTMNU+6p7e/new2N0Mq4Hyspa3ejQi+6K4IJ++lI3
         tCJqd5MtklhrfCea7SLKJUfzkOPekzTiE/nUurPDXV5RmUDEZFd7Y2DWfQrFHJLjgR/q
         50oITcceZmq0LvDwRib0hjya145phSNuA1XPRcl3rX4YGXLYv3oedrkkucLb7KR9yMcJ
         YB99kWLQvSO8MOvA4DbH2/M8AHvjF6ZykZVL4X7z1biI72YFf/nJfsawSc4eewxrSylz
         GnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXtOFPUAC449UjKcnHqyP52BLt32wv445asPXCj/t1/HZ/UMIR03b6GBDecmCROCLZVHt+jxeD43eny4TYA8fAWJDrLzbOQlMlu/8h1
X-Gm-Message-State: AOJu0YxVpcoprUoJ7vtAj9hahYQ7JstgyDz6aaqEWmOu6ZwOy5U8eyPa
	CLL8Zd5kPVX+9XuB4aVOh0WsoVU3603L9KHRmh0Keedz9nnkK9jL07gtDPXSPaA=
X-Google-Smtp-Source: AGHT+IEZYXud4tM6JcqUgo1hgqJr7fdgasI9zD5M8BqVsUWiC8vI1fGU/UfvXbZpBl4UPndv1yXtNA==
X-Received: by 2002:a17:906:4f8d:b0:a59:a83b:d438 with SMTP id a640c23a62f3a-a682022d0bemr309841966b.23.1717240558265;
        Sat, 01 Jun 2024 04:15:58 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb344426sm185893866b.215.2024.06.01.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 04:15:57 -0700 (PDT)
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
Subject: Re: [PATCH v3 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <2021ea8f-a3df-46c6-8fdf-61b1df231773@proton.me> (Benno Lossin's
	message of "Sat, 01 Jun 2024 09:15:59 +0000")
References: <20240601081806.531954-1-nmi@metaspace.dk>
	<20240601081806.531954-3-nmi@metaspace.dk>
	<2021ea8f-a3df-46c6-8fdf-61b1df231773@proton.me>
Date: Sat, 01 Jun 2024 13:15:54 +0200
Message-ID: <87ed9goqvp.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

>> +impl kernel::Module for NullBlkModule {
>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>> +        pr_info!("Rust null_blk loaded\n");
>> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), flags:=
:GFP_KERNEL)?;
>> +
>> +        let disk =3D {
>> +            let block_size: u16 =3D 4096;
>> +            if block_size % 512 !=3D 0 || !(512..=3D4096).contains(&blo=
ck_size) {
>> +                return Err(kernel::error::code::EINVAL);
>> +            }
>> +
>> +            let mut disk =3D gen_disk::GenDisk::try_new(tagset)?;
>> +            disk.set_name(format_args!("rnullb{}", 0))?;
>> +            disk.set_capacity_sectors(4096 << 11);
>> +            disk.set_queue_logical_block_size(block_size.into());
>> +            disk.set_queue_physical_block_size(block_size.into());
>> +            disk.set_rotational(false);
>> +            disk.add()
>> +        }?;
>
> Personally, I would prefer to put the `?` into the line above.

I have no strong opinion here.

>
>> +
>> +        let disk =3D Box::pin_init(new_mutex!(disk, "nullb:disk"), flag=
s::GFP_KERNEL)?;
>> +
>> +        Ok(Self { _disk: disk })
>> +    }
>> +}
>> +
>> +struct NullBlkDevice;
>> +
>> +#[vtable]
>> +impl Operations for NullBlkDevice {
>> +    #[inline(always)]
>> +    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
>> +        mq::Request::end_ok(rq)
>> +            .map_err(|_e| kernel::error::code::EIO)
>> +            .expect("Fatal error - expected to be able to end request");
>
> I expected something more along the lines of: "expected to be able to
> end request, since `NullBlkDevice` never takes refcounts on Requests and
> as such the ARef must be unique, but `end_ok` only fails if that is not
> the case". But maybe that would fit better in a comment, what do you
> think?

I can add a comment =F0=9F=91=8D

BR Andreas

