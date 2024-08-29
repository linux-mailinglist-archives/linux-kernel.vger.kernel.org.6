Return-Path: <linux-kernel+bounces-306050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E5963878
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C411F23FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4043154;
	Thu, 29 Aug 2024 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajJRqNZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50758146A63
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899913; cv=none; b=NzEK3ydkzHBAEooC3+5+reJpqFS+VZx7OC5RurM7Pzs8hHnAgcUtYYDg1QRfN8EtdKflI7AZLzXARtovtdmXdQLmQA1B6FzTlP6wyL+ov7y1omMoTt8mpUoHachrKv4NL4UrMUDO0ZFrWu3No7aWFJgtL9eHRmIXsNMTg/ABNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899913; c=relaxed/simple;
	bh=5eH319rL3ljbFSk7F9xxud1+f6rGBTTAhosJkOfbG5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT7Mz+Pyd0R/tNAbdkKjPcfE6H52eA+GgdFdYCjWXctRhMAEWtg0AELDkLzFyIpNOBZVVtjfxR56A77oNcULI6xAx9Rc2V7mkNzEmHWq+oGMVJRBT1MP79GMNin6UDv0gyArDKZ3IS9jSeCCq47zskdSf23yv/S/ZxoKoCIC0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajJRqNZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724899910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y5X/HAwi8YQWAeolryJhZ/So/sg9D9zgxA+LGf3kZ4=;
	b=ajJRqNZKDL86MNwmHjZ8r4x72UXgNp+iISagyRMyVW4HdhozRuVLAshHPiuA7txRKBZx2A
	djEE9RbGn3t2mTa5KqbwPPoC6ia4de6+RaFmnxnzdLjn4PMuEqJpWFMQdQEM+6huEJo8Ct
	7hs9Ll+OxN6TbN94SVmde0uzqWSm9uw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-cOvOgeMBNLGFs9BJ-saQ8A-1; Wed, 28 Aug 2024 22:51:48 -0400
X-MC-Unique: cOvOgeMBNLGFs9BJ-saQ8A-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84308d9197fso94884241.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899908; x=1725504708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y5X/HAwi8YQWAeolryJhZ/So/sg9D9zgxA+LGf3kZ4=;
        b=MbytP0jXWebgPzOnFb30qR78s7zYQ+lVuNMgXElnqGDisY4PkdCsgTrp9iHTqchgXk
         MNzT4OD1MNdms+qvLkt3hn9N/cD1gZbyRsPncRt0qn/zj2pY6aDlW+wdRUsH6kRaWRkl
         hWQgDMJ7j7hb0vEdX0xrI08HLlIEQjDqSTfq+JVQWCtj5L0E177HoUQNe4VQlCX7aOAN
         6UraRivI4+N2kSpDYFu0LvMFakSeGeaVRjoBRFDqnSLcqFIJBwTm54wq8nEEVBspLu2F
         8R9CH6Q25tiZJJv1d9X1aZKLU5vCQ0feFXuDpBLZk8QEtGUPOfc+oSYwPa+DAPklBPLV
         5tCw==
X-Forwarded-Encrypted: i=1; AJvYcCU8A03pDTfjqyW1OLHZYTRCvU7QIZe59JGCaNu5/exO8qPdtUQRGOD5Eoiek0EXgzSj+L+W0WtwQ32Dzvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsI4Cc6yS2DW/zPvudne4By0UAVJsN63/ZKjZviXeZN/3OxyC
	O9jtBmQ+OnFRXI7X/4Sj8cRVK+7WH7oZs3Dtz+Z+0fbsVOHG6OhSL/dBSpF3bmLxJNYNreohCv2
	yX/4rGskJioaygmyK7jV48uLHbqq0Im4W2AHmwGGDlEjpbcqnYi+ChOZ67yd1bg3eN0NbxHqXnX
	9rohAMQFEQwVZW99JNOgiTCV+Va5rUsJYp9VbU
X-Received: by 2002:a05:6102:3907:b0:498:dd44:32c with SMTP id ada2fe7eead31-49a5af81969mr2061392137.28.1724899907927;
        Wed, 28 Aug 2024 19:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMCwdJWqQ7UGqEm2eD2QZkKdrnPhDXz9a+VFDGRXzvmXdVehEBkxYt8vxSUIGJFAXz0GgrUNUZJFb+iSlI/mw=
X-Received: by 2002:a05:6102:3907:b0:498:dd44:32c with SMTP id
 ada2fe7eead31-49a5af81969mr2061377137.28.1724899907529; Wed, 28 Aug 2024
 19:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
 <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev> <ZsxI6uCbGpQh1XrF@fedora>
 <1929CA74-3770-4B5D-B0A5-759911E97815@linux.dev> <D53C1E55-80A4-4F71-B93D-D357F424D2FF@linux.dev>
In-Reply-To: <D53C1E55-80A4-4F71-B93D-D357F424D2FF@linux.dev>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 29 Aug 2024 10:51:36 +0800
Message-ID: <CAFj5m9KmQZM8+nMORaQOJC-tzM0AOMz+kUyDa1r8V0NTcOVXtg@mail.gmail.com>
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:17=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Aug 27, 2024, at 15:24, Muchun Song <muchun.song@linux.dev> wrote:
> >
> >
> >
> >> On Aug 26, 2024, at 17:20, Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> On Mon, Aug 26, 2024 at 03:33:18PM +0800, Muchun Song wrote:
> >>>
> >>>
> >>>> On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> wr=
ote:
> >>>>
> >>>> On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei <ming.lei@redhat.co=
m> wrote:
> >>>>>
> >>>>> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
> >>>>>> Supposing the following scenario.
> >>>>>>
> >>>>>> CPU0                                                              =
  CPU1
> >>>>>>
> >>>>>> blk_mq_request_issue_directly()                                   =
  blk_mq_unquiesce_queue()
> >>>>>>  if (blk_queue_quiesced())                                        =
   blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
> >>>>>>      blk_mq_insert_request()                                      =
   blk_mq_run_hw_queues()
> >>>>>>          /*                                                       =
       blk_mq_run_hw_queue()
> >>>>>>           * Add request to dispatch list or set bitmap of         =
           if (!blk_mq_hctx_has_pending())     4) load
> >>>>>>           * software queue.                  1) store             =
               return
> >>>>>>           */
> >>>>>>      blk_mq_run_hw_queue()
> >>>>>>          if (blk_queue_quiesced())           2) load
> >>>>>>              return
> >>>>>>          blk_mq_sched_dispatch_requests()
> >>>>>>
> >>>>>> The full memory barrier should be inserted between 1) and 2), as w=
ell as
> >>>>>> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QU=
IESCED is
> >>>>>> cleared or CPU1 sees dispatch list or setting of bitmap of softwar=
e queue.
> >>>>>> Otherwise, either CPU will not re-run the hardware queue causing s=
tarvation.
> >>>>>
> >>>>> Memory barrier shouldn't serve as bug fix for two slow code paths.
> >>>>>
> >>>>> One simple fix is to add helper of blk_queue_quiesced_lock(), and
> >>>>> call the following check on CPU0:
> >>>>>
> >>>>>      if (blk_queue_quiesced_lock())
> >>>>>       blk_mq_run_hw_queue();
> >>>>
> >>>> This only fixes blk_mq_request_issue_directly(), I think anywhere th=
at
> >>>> matching this
> >>>> pattern (inserting a request to dispatch list and then running the
> >>>> hardware queue)
> >>>> should be fixed. And I think there are many places which match this
> >>>> pattern (E.g.
> >>>> blk_mq_submit_bio()). The above graph should be adjusted to the foll=
owing.
> >>>>
> >>>> CPU0                                        CPU1
> >>>>
> >>>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> >>>> blk_mq_run_hw_queue()
> >>>> blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
> >>>>  if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >>>>      return                                      blk_mq_run_hw_queue=
()
> >>>>  blk_mq_sched_dispatch_requests()                    if
> >>>> (!blk_mq_hctx_has_pending())     4) load
> >>>>                                                          return
> >>>
> >>> Sorry. There is something wrong with my email client. Resend the grap=
h.
> >>>
> >>> CPU0                                        CPU1
> >>>
> >>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> >>> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEU=
E_FLAG_QUIESCED)       3) store
> >>>   if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
> >>>       return                                      blk_mq_run_hw_queue=
()
> >>>   blk_mq_sched_dispatch_requests()                    if (!blk_mq_hct=
x_has_pending())     4) load
> >>>                                                           return
> >>
> >> OK.
> >>
> >> The issue shouldn't exist if blk_queue_quiesced() return false in
> >> blk_mq_run_hw_queue(), so it is still one race in two slow paths?
> >>
> >> I guess the barrier-less approach should work too, such as:
> >>
> >
> > If we prefer barrier-less approach, I think the following solution
> > will work as well, I'll use it in v2. Thanks.
> >
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index e3c3c0c21b55..632261982a77 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -2202,6 +2202,12 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw=
_ctx *hctx, unsigned long msecs)
> >> }
> >> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
> >>
> >> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hct=
x)
> >> +{
> >> +    return !blk_queue_quiesced(hctx->queue) &&
> >> +            blk_mq_hctx_has_pending(hctx);
> >> +}
> >> +
> >> /**
> >> * blk_mq_run_hw_queue - Start to run a hardware queue.
> >> * @hctx: Pointer to the hardware queue to run.
> >> @@ -2231,11 +2237,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx =
*hctx, bool async)
> >> * quiesced.
> >> */
> >>      __blk_mq_run_dispatch_ops(hctx->queue, false,
> >> -            need_run =3D !blk_queue_quiesced(hctx->queue) &&
> >> -            blk_mq_hctx_has_pending(hctx));
> >> +            need_run =3D blk_mq_hw_queue_need_run(hctx));
> >>
> >> -    if (!need_run)
> >> -            return;
> >> +    if (!need_run) {
> >> +            unsigned long flags;
> >> +
> >> +            /* sync with unquiesce */
> >> +            spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>
> After some time thought, I think here we need a big comment to explain
> why we need to sync. Because there are other caller of blk_queue_quiesced=
()
> which do not need to hold ->queue_lock to sync. Then, I am thinking
> is ->queue_lock really easier to be maintained than mb? For developers,
> we still need to care about this, right? I don't see any obvious benefit.
> And the mb approach seems more efficient than spinlock. Something like:
>
>         if (!need_run) {
>                 /* Add a comment here to explain what's going on here. */
>                 smp_mb();
>                 need_run =3D blk_mq_hw_queue_need_run(hctx);
>                 if (!need_run)
>                         return;
>         }
>
> I am not objecting to your approach, I want to know if you insist on
> barrier-less approach here. If yes, I'm fine with this approach. I can
> use it in v2.

Yes, as I mentioned, the race only exists on two slow code paths,
we seldom use barrier in slow paths, in which traditional lock
can provide a simpler & more readable solution.  Anytime,
READ/WRITE dependency implied in any barrier is hard to follow.

Thanks,


