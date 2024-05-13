Return-Path: <linux-kernel+bounces-177574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B618C40F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE74281100
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9F9145B18;
	Mon, 13 May 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="BLYwykK3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27014F9C9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604403; cv=none; b=ucFwHoCBgT+psDD7gK72y960oB8FPw6N9EXb52523G+nGv+Z/Fl58wumunR7ANfaCn1TYMZjoEIknzLobqDJISD6b6sBZRV3HpM9yNGvW1vGvYqJS7nDArpLCtQ69NY5/+1x10hWLrP7s8z3AQeIz0Avab1bLQqWZBEQfcnxC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604403; c=relaxed/simple;
	bh=Org2FJgLfm0/aZY9b01qFaQVn7Zkl5ZHw8/lH4xw97w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdbkDYCUEcVSxZ2MK0ch8MYav/0qg8rf8fv6k1EjCvCSQHfnAObqdurqWGt7NZuKJ2wsoDUY1ReR/9hcbH0NpibWqTR2VzI5E3HhBxkwL4eWTVWLaLTnrB0q8cWNkNfxE0H/S1NASQ9U6CCxOpL0Y43OQ+AnLE9IUkxdn/pfzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=BLYwykK3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso1310113b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1715604400; x=1716209200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55W1fvphJjC21Z8InY3mGUMzMSfqk5dLM7shx8mdxtw=;
        b=BLYwykK3NWRtCtcROiTyhL7QI+tCuUq1m+8HtLZiK/Gz+Ot5bA+uB/cdfkl8XiIAHw
         P+vSR1HSNLkiU5ZcKqS3Ju3oEuB1UJf5gkLzilw7rpw3Wu5MQTVcc1LM9NXjB6xiBUcD
         EdNNtEW2p8jaep6d4We1TBorEutnrNPIRPsn7ivSjS6zy0BKNAXhNRnC2mgeTLf5lRRh
         KGkM7UwMTmVrx4w1VtmITd6wfCUIgzkzvCvhW5oJzZtRviNV9a9FA6tsUjfQhwz0dLUh
         stqG3DFeEVZv3flVXLUPIxatV0IyfZ2aMgLNzE61lx2sLZwU+GspSxbkv4X80R9FdunL
         78PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715604400; x=1716209200;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55W1fvphJjC21Z8InY3mGUMzMSfqk5dLM7shx8mdxtw=;
        b=LHWQHGjgUCAYi8L8zDlTsN1zOD2sRNN+/AXLsOQ1j9nrsWgNSnumC2xcibrZ9D9QGB
         07D4UZT8d2C6stsXfLf9TYeAiaHS1HvDD9FJ3hA/ciNphxV0gU0ayNhhtZ84xTg9QeNw
         dxM2xb6sPYW5oI6btlCeof5aHxqcJCvNfs4373thBlvakQkEtoNU5ebEsGQBYSUIC7oR
         Mb2KwtsYTMvGPL8RvBOA6iZmlG1VWmnO3RXmIIN84qZFNSW+Zb5w8KAUokr36ZCYwEzS
         DJKZmaXS/gc8zi/fVwJ5+2Xdn0fCSrqSYTFSGvokIQUWhB/R66NVW4/t7Gc1QVzm0B/Y
         0LdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoEzAZ32M2fcOnUqWAdYYeE2ikMOQPdRMOhmRypOJNZfaIr1Yvpff4CvwkWuB0Fsm9HUaIjwchSxqKjY/UC/bRfUnVfR/zX1hIxg/5
X-Gm-Message-State: AOJu0YyJr9j077dwDCYkUpoqjpi7Bxa0aE7AkZqJ2foix74VVa3o7476
	wMGyxbIqwYR2DAQvgHqSxigPh7k5GEp3/I9ZdhUWu9H2cKdM4sk8JGruYhiYPGk=
X-Google-Smtp-Source: AGHT+IFJVUA5v39CIxM2mlZS/97S02tS0y4Zn8AahDF18pyoIZeL1TPkTotSaHeHP2bSWdfWRitFog==
X-Received: by 2002:a05:6a21:c91:b0:1a7:590e:279e with SMTP id adf61e73a8af0-1afde07d798mr15082234637.5.1715604400009;
        Mon, 13 May 2024 05:46:40 -0700 (PDT)
Received: from localhost ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fb8bsm7275179b3a.209.2024.05.13.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 05:46:39 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,
  Hannes Reinecke <hare@suse.de>,  Ming Lei <ming.lei@redhat.com>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  Alice Ryhl
 <aliceryhl@google.com>,  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis
 Chamberlain <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,
  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
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
Subject: Re: [PATCH 1/3] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <1b618942-a0fe-45d9-90de-eede429e7284@acm.org> (Bart Van Assche's
	message of "Mon, 13 May 2024 06:22:31 -0600")
References: <20240512183950.1982353-1-nmi@metaspace.dk>
	<20240512183950.1982353-2-nmi@metaspace.dk>
	<1b618942-a0fe-45d9-90de-eede429e7284@acm.org>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Mon, 13 May 2024 06:48:18 -0600
Message-ID: <87r0e5j2st.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Bart,

Bart Van Assche <bvanassche@acm.org> writes:

> On 5/12/24 11:39, Andreas Hindborg wrote:
>> +    /// Set the logical block size of the device.
>> +    ///
>> +    /// This is the smallest unit the storage device can address. It is
>> +    /// typically 512 bytes.
>
> Hmm ... all block devices that I have encountered recently have a
> logical block size of 4096 bytes. Isn't this the preferred logical
> block size for SSDs and for SMR hard disks?

Yes, that is probably true. This text was lifted from the entry on the
sysfs attribute in `Documentation/ABI/stable/sysfs-block`, but maybe
that needs to be updated as well.

>
>> +    /// Set the physical block size of the device.
>> +    ///
>> +    /// This is the smallest unit a physical storage device can write
>> +    /// atomically. It is usually the same as the logical block size bu=
t may be
>> +    /// bigger. One example is SATA drives with 4KB sectors that expose=
 a
>> +    /// 512-byte logical block size to the operating system.
>
> Please be consistent and change "4 KB sectors" into "4 KB physical block
> size".

OK, I will. I can CC the changes to
`Documentation/ABI/stable/sysfs-block` then'

>
> I think that the physical block size can also be smaller than the
> logical block size. From the SCSI SBC standard:
>
> Table 91 =E2=80=94 LOGICAL BLOCKS PER PHYSICAL BLOCK EXPONENT field
> -----  ------------------------------------------------------------
> Code   Description
> -----  ------------------------------------------------------------
> 0      One or more physical blocks per logical block (the number of
>        physical blocks per logical block is not reported).
> n > 0  2**n logical blocks per physical block
> -----  ------------------------------------------------------------

How does that work? Would the drive do a read/modify/write internally?
Would that not make the physical block size as seen from the OS equal to
the smaller logical block size?

>
>> +impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
>> +    /// Call to tell the block layer the capacity of the device in sect=
ors (512B).
>
> Why to use any other unit than bytes in Rust block::mq APIs? sector_t
> was introduced before 64-bit CPUs became available to reduce the number
> of bytes required to represent offsets. I don't think that this is still
> a concern today. Hence my proposal to be consistent in the Rust block::mq=
 API
> and to use bytes as the unit in all APIs.

I think that is very good idea. How do others feel about this?

BR Andreas


