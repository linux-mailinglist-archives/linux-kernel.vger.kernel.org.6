Return-Path: <linux-kernel+bounces-539708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29CA4A7A2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B51316C7F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A53595A;
	Sat,  1 Mar 2025 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b0NGipAu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EA35942
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793344; cv=none; b=NUkKvDX8lBffOfNSGA/4pIFzw8s/2F6Kb1kJnJo+//17fSmL/Rzr6LvdUbbtvchZAQoHxzAZZ1MbV+iADTXsB2rfVO2rpnZdewQjFEp716onHlQI6ipH96ID0TW56Rnwn2iFhAiapR3ZpgBKwr01W4tZ8g8jyhavMQhxJS4UIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793344; c=relaxed/simple;
	bh=VAzuMq1SPRjyoldnXde+s+9Rp1P0nDMAYp/ojV8Rxc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0TXY879uffxtPjz9wa6iWwkZnnH8sRqbEkNaBjBrzK093x8dIkBeOGJEti3xo0ye/5fzE33hhNsTz3bRd7MixZfAZpF/RL7VG4Gy4wOCm2u15ECJ69GLmdMS+4h0jAaKoxm1xzv6G5s8P6Epu7fvB31/qz1rjWBEi+Ds5wOT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b0NGipAu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22378b3a465so2735795ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740793342; x=1741398142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74uaVyaOSVBrK4gUrHFd0M9UxA7zU4hXqBqpVw5WXpk=;
        b=b0NGipAuno0vNQGpALklJYUrRYmryLrtUifk4mpIv6raHhJ4RfAodRUBJDJJzcLIOZ
         i/1UvKxPCPmpRYCsoawdmKqt/jUhZRDPTecbFnXBkOMJ+o7WhKX4dWM4gx5ozOHFQ7bW
         Q2vyCU3K1UthKMeoSEtLbd8zI8pC627k0MMEdttpE5gkhNORzyp1jr/cl5rEWR9qfknk
         KzJir8c72OnrCID1vG7ClWCizElhh/DyC808S/8/LowSKAJ9wFtQxzsQlAPtbZKRapBc
         tpG5vqPL/3wSvtwpfSD1BiKBalWixhIlBUBBtvOe8QaN3o5CiKPLwhoQAHx3W+4e9P7u
         Z4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740793342; x=1741398142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74uaVyaOSVBrK4gUrHFd0M9UxA7zU4hXqBqpVw5WXpk=;
        b=Y/GJA727YpWe/cnw5ZPk4GJMVTTdN1xnkfCNezHjYXVP+hV3g9HMB/eskwIh17SoQU
         x/0oJLLWaJtuyOHjZSWcTUM6csPBOT6+NeK4inrLMb1klIGqFzXOPV3AbH7vcJKESfrV
         zauMKmUxwdfjns7FOUkUHAd0Z8VBRR1Z+GeUhJc20kmZIEMtJcMo7DhtRa9iScAiEU70
         s61gRoYh34TJnHpEeaAGMF8r0uyFCnGYgypFE/SmmsRwvJVPuCQM90OyqcX6B0PU6tjZ
         Qu8Tu2WrNj7D26W4Q2bAyqhE7fe8GLEUt2S2Y2hmlZv84dnD9oPed9HZLiIlmLPfphyj
         lSMg==
X-Forwarded-Encrypted: i=1; AJvYcCUYjCqm3IpENU6J7kSWEH6cpcs1FAiEHcJJx+CO7m+0quOT/TKOuVzawP7DIfTSrRSELKMtIDeeKwX5VNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bUiTeJYxxdNNGdnlMCbrex6+gw7itXpS8bQFKzwIHUpMvqvr
	k8aBnZ4ni4JqA9bySYiyR9FXOU2fCfF3oX0GoZkR5st7NlyNGfJcpsL5NplRYHNopf0CYlw7cyP
	zw3quxfSWyclG1Da9teKUbRkdwITfr4/ldMOLiGhwF1BuH7m1k0k=
X-Gm-Gg: ASbGncuPrRnqfm0IYv6Mc9c9gexVFkx2Y3vexF8hlT3D2EZY+tJTtuC1Bk+bBVk+4kM
	V5Mqb8W8TVAuBVg6WWElvvmGHRy/Li7FuTris5PD7AeccmNX9vyq2yBurYwShlRrZX8dwvEnWRY
	nATTRvOLM7XsfIpWIIkYvKQrgm
X-Google-Smtp-Source: AGHT+IEAtn4ng06+iBZXjhmClYZvydtClSNiTwqIhpfZuR+T41xP/35RMQgG4DOrnNTX2o7FSqR5dbDbzlaC7G1dWuE=
X-Received: by 2002:a17:902:ecd0:b0:215:9a73:6c4f with SMTP id
 d9443c01a7336-22368f76e6bmr32961005ad.6.1740793341694; Fri, 28 Feb 2025
 17:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228223057.615284-1-csander@purestorage.com> <6272ce74-cd1e-4386-ac84-2ca7df5dab33@gmail.com>
In-Reply-To: <6272ce74-cd1e-4386-ac84-2ca7df5dab33@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Feb 2025 17:42:10 -0800
X-Gm-Features: AQ5f1Jo10AbYOywMpLOwf2-W01i8JH0UAgg3J7GDhKn__uCMLxZsp8qb_zri38A
Message-ID: <CADUfDZpmnj8wCjaQcDTTT_rNhsegs0NFk6w393e+JsTg4MN+bQ@mail.gmail.com>
Subject: Re: [PATCH] io_uring/rsrc: use rq_data_dir() to compute bvec dir
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:23=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/28/25 22:30, Caleb Sander Mateos wrote:
> > The macro rq_data_dir() already computes a request's data direction.
> > Use it in place of the if-else to set imu->dir.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >   io_uring/rsrc.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index 45bfb37bca1e..3107a03d56b8 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -957,15 +957,11 @@ int io_buffer_register_bvec(struct io_uring_cmd *=
cmd, struct request *rq,
> >       imu->nr_bvecs =3D nr_bvecs;
> >       refcount_set(&imu->refs, 1);
> >       imu->release =3D release;
> >       imu->priv =3D rq;
> >       imu->is_kbuf =3D true;
> > -
> > -     if (op_is_write(req_op(rq)))
> > -             imu->dir =3D IO_IMU_SOURCE;
> > -     else
> > -             imu->dir =3D IO_IMU_DEST;
> > +     imu->dir =3D 1 << rq_data_dir(rq);
>
> rq_data_dir returns READ/WRITE, which should be fine, but it'd
> be nicer to be more explicit unless it's already enforced
> somewhere else
>
> BUILD_BUG_ON(WRITE =3D=3D  ITER_SOURCE);
> ditto for READ

The definitions of ITER_SOURCE and ITER_DEST seem pretty clear that
they are aliases for WRITE/READ:
#define ITER_SOURCE 1 // =3D=3D WRITE
#define ITER_DEST 0 // =3D=3D READ

So I assume other code is already relying on this equivalence.

Best,
Caleb

