Return-Path: <linux-kernel+bounces-421771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07139D9003
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA86B23CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F2DDC3;
	Tue, 26 Nov 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hot8eh+8"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE676125
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585034; cv=none; b=qXfGf3wjH84b78vwQiai5kQ8WmlK912d7cF7IVATJlxfbo7wvcOVkNjjW/Es5HCr5/2mQTCk0R8cloTYUoKGjr1hgyC+VQ4p8rYn+S9RWvK6lNXP9sJQrHVUSOzMWxtriPo7o5fD7meNuNAwwfIwnhGSMHeDSbqHDDEW7Opx710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585034; c=relaxed/simple;
	bh=tCYSZSRxi+7C53edvKVUlthPBvV7N/B+KQYy/4ufv98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPEn7edmBoZr/v8T0fvxegMBe3eLnfN78NdH2h1Z8OYYwffy2VbMs7rwg4z03Na9ZTi0EU2Hnw4qFSmrUJqNo7ZLrYzyTpKY4QXwrVVjsXDJcg/F91DnKDwptsB5lktFAI/utL4EHFUzuHAfsIOVdRBW+TOIRsZ9i7k9lNhDc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hot8eh+8; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ee7a400647so54041197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732585031; x=1733189831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdjL6zUjj2z/LYq4V/LFmBNcTXQqiOxOfUuvMmMBGKc=;
        b=Hot8eh+8rUOhaFt8ScRbfa0SJyxv9WSxRZ9iGf3kCkO/XGGoowYJV2d5exDNE4qGyV
         dlCJSj91VMeUGaMKuu9N5OdyPl9v6zHk7/rIGtr107VyxUMqdZsfSoB4lGg8/rZX0Or6
         Z/iPesB1rKdsj6oA1CjsgzvtEzEzSIhVoGepjPWMN90Bh23ynpdfCVOtXvBMXJlrN1kp
         Pqr7Ngr42EnTZ73Jjm1uAuRm5Epdt9CVwQHgFKNQlPa8iY0EJsrwKI7MePIdhQWn2dUR
         /wMfMp4tQruCtQqLC6IFSQQE/bmDTXCjBuwRKiHxVqit41pkuV0sF5TeXak5lh45FaBI
         qhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585031; x=1733189831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdjL6zUjj2z/LYq4V/LFmBNcTXQqiOxOfUuvMmMBGKc=;
        b=fpOA7UQY9SFsA4VC4Fe6NUN4dQGzms4AbtKCwR7NdynbazIUFS6Tr6nzAX5crcCYzM
         vdjKZNsQqWRdl44vxj+BPd8nCdt25TS3D3ZZ8IC9/XL83PcedMdN1wO6XQXrCWC/YCd8
         OmmJofBLkvApzyQFESu9yNNJBE9y+hjs54XI7F3gAywBiuCFKAX63dhHT6EzulY9KeL2
         8Nqeat4M0enezIqaIW2FGLFnE3EdzNVWt54hzPkkr1t/mcg1oSkPiD3FWRxxZUtz4ptO
         +DODMLlRD5yKzcAavMKVznWbLRL1s7cUrPGgdmhqnw3WsG5CwzqxHyIzTNhrXC4bKwqI
         Iuqw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8H+j9H+pJF3cPwQ4hiZeQGNW3Eg6nusMlkQrM+76kaO1RZO/HDERZyPlC6Q1LAusQfczsnAN9p87vXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6xEIrpmr+7n23ymy+DCUHOXEi45qtjh1uJso8CfT28bxuHkD
	87oXNkopVn+zIo4q6SmkdOj4Y+VYILhhyhoBNZvZNwfj3hbay6fjUcbJU2k5C36x5ZungpzZIYk
	xQdWrl2DMO5ToMDkRunUXutMc5dHRuzFz+yJfPg==
X-Gm-Gg: ASbGncujcHNdnQWX2416b4z30zPaQufgOGgXmzOMQGPDFh+SoLN6exvbfFmRsO2UOOj
	nDLcOjnaiSKSOxGcXjzPlkUhqcnYv934=
X-Google-Smtp-Source: AGHT+IHyAm521vhyAlEkTFZiSAXUWeUNoBTSz6Vwajou6E+EBUOBcOw0y6/xJsa+g+nihPuDKwmDkBpKLfuUmPaBiA0=
X-Received: by 2002:a05:690c:2504:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6eee0779a6dmr165221367b3.0.1732585031470; Mon, 25 Nov 2024
 17:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de> <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
 <20241125073658.GA15834@lst.de>
In-Reply-To: <20241125073658.GA15834@lst.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 25 Nov 2024 19:37:00 -0600
Message-ID: <CAPLW+4=kuHze3=+g80CsY6OkLno5gyjRfMWLXTFHu3N_=XcmqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, Nov 25, 2024 at 1:37=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Nov 22, 2024 at 03:55:23PM -0600, Sam Protsenko wrote:
> > It's an Exynos based board with eMMC, so it uses DW MMC driver, with
> > Exynos glue layer on top of it, so:
> >
> >     drivers/mmc/host/dw_mmc.c
> >     drivers/mmc/host/dw_mmc-exynos.c
> >
> > I'm using the regular ARM64 defconfig. Nothing fancy about this setup
> > neither, the device tree with eMMC definition (mmc_0) is here:
> >
> >     arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
>
> Thanks.  eMMC itself never looks at the ioprio field.
>
> > FWIW, I was able to narrow down the issue to dd_insert_request()
> > function. With this hack the freeze is gone:
>
> Sounds like it isn't the driver that matters here, but the scheduler.
>
> >
> > 8<-------------------------------------------------------------------->=
8
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index acdc28756d9d..83d272b66e71 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -676,7 +676,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx
> > *hctx, struct request *rq,
> >         struct request_queue *q =3D hctx->queue;
> >         struct deadline_data *dd =3D q->elevator->elevator_data;
> >         const enum dd_data_dir data_dir =3D rq_data_dir(rq);
> > -       u16 ioprio =3D req_get_ioprio(rq);
> > +       u16 ioprio =3D 0; /* the same as old req->ioprio */
> >         u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
> >         struct dd_per_prio *per_prio;
> >         enum dd_prio prio;
> > 8<-------------------------------------------------------------------->=
8
> >
> > Does it tell you anything about where the possible issue can be?
>
> Can you dump the ioprities you see here with and without the reverted
> patch?
>

Collected the logs for you:
  - with patch reverted (ioprio is always 0): [1]
  - with patch present: [2]

This code was added for printing the traces:

8<---------------------------------------------------------------------->8
 static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *=
rq,
                               blk_insert_t flags, struct list_head *free)
 {
+#define IOPRIO_N_LIMIT 100
+       static int ioprio_prev =3D 0, ioprio_n =3D 0;
        struct request_queue *q =3D hctx->queue;
        struct deadline_data *dd =3D q->elevator->elevator_data;
        const enum dd_data_dir data_dir =3D rq_data_dir(rq);
        u16 ioprio =3D req_get_ioprio(rq);
        u8 ioprio_class =3D IOPRIO_PRIO_CLASS(ioprio);
        struct dd_per_prio *per_prio;
        enum dd_prio prio;

+       ioprio_n++;
+       if (ioprio !=3D ioprio_prev || ioprio_n =3D=3D IOPRIO_N_LIMIT) {
+               pr_err("### %-20d : %d times\n", ioprio_prev, ioprio_n);
+               ioprio_n =3D 0;
+       }
+       ioprio_prev =3D ioprio;
+
        lockdep_assert_held(&dd->lock);
8<---------------------------------------------------------------------->8

Specifically I'd pay attention to the next two places in [2], where
the delays were introduced:

1. Starting getty service (5 second delay):

8<---------------------------------------------------------------------->8
[   14.875199] ### 24580                : 1 times
...
[  OK  ] Started getty@tty1.service - Getty on tty1.
[  OK  ] Started serial-getty@ttySA=C3=A2ice - Serial Getty on ttySAC0.
[  OK  ] Reached target getty.target - Login Prompts.
[   19.425354] ### 0                    : 100 times
...
8<---------------------------------------------------------------------->8

2. Login (more than 60 seconds delay):

8<---------------------------------------------------------------------->8
runner-vwmj3eza-project-40964107-concurrent-0 login: root
...
[   22.827432] ### 0                    : 100 times
...
[  100.100402] ### 24580                : 1 times
#
8<---------------------------------------------------------------------->8

I guess the results look similar to the logs from the neighboring
thread [3]. Not sure if those tools (getty service and login tool) are
running ioprio_set() internally, or it's just I/O scheduler acting up,
but the freeze is happening consistently in those two places. Please
let me know if I can help you debug that further. Not a block layer
expert by any means, but that looks like a regression, at least on
E850-96 board. Wonder if it's possible to reproduce that on other
platforms.

Thanks!

[1] https://termbin.com/aus7
[2] https://termbin.com/za3t
[3] https://lore.kernel.org/all/CAP-bSRab1C-_aaATfrgWjt9w0fcYUCQCG7u+TCb1FS=
PSd6CEaA@mail.gmail.com/

