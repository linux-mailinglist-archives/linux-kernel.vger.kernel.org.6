Return-Path: <linux-kernel+bounces-291393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FE95617F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59221F217F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478D1804E;
	Mon, 19 Aug 2024 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gPMcoojd"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF71CA8D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039412; cv=none; b=uh43PvZSsTz4o1qQVWYehHH8Wlq9i66LBUDL+cOC0TuU8VQcTkrEoN8z+jkxDcKoGXktSaydl0vXedvWzwaVho3w8DeYpLKezeGMADP+eqTFobcbvsy3bvKCT6Fe7dVwJTbXZ3Mv3kKxvEzQsDL9Afyh912qw38PMHUA+oV2krs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039412; c=relaxed/simple;
	bh=vj/nCK/rrnT92avMqYHiiN0EBuWCrYe+FPk2q3HVSdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egoPI/om+eYOMUe8BXGAz/SZtvjGVQpW/5Zl7+qy7snP2hFyiq+9GrWVq1qn8TaTiVzoU1MKkAmU33L3I3/cmyMsda0Nkk6C/0FGwILXxROZE9ySsgW4bImnRrf8To9JzPmhR5A2VipEIBBBPwJS3fCgDoUx2etbFhrNHgYjlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gPMcoojd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371aa511609so943427f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724039409; x=1724644209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akq/Bfulw+ZSro2Wdo4sH7ibDxXjrZD92qudwT0kTAQ=;
        b=gPMcoojdD/UAuC6IfKLpWCMW18KXRygBSXWj8CJZPwkiGSZrvjOxU+qWrned3e8LTv
         p+ihry9TpaaeHcK5IvFy51S7E94XEDCM+L8DUdD3y5pqCtbDMcO2Ji9yHTpf5Jq82Pa1
         rpqQab28DotyuiaHluaktccXnaYn7hYRjkUq4bY/6SpIlCCKDA1BdedOyUqFMU2MDz5r
         E7qiQVmG6CtAmMBsjNG9gj4CNaH4svHChGhkQ1XWlfJi19SStz+u8Fqz0Jzzwo0DCrn5
         EG+xMAIujRMB9nfeCICug6Wr2nVyLhQCgFN414B6l5uBk1GRTf+ZQTZ5spiQe+D2sbxC
         uxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039409; x=1724644209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akq/Bfulw+ZSro2Wdo4sH7ibDxXjrZD92qudwT0kTAQ=;
        b=lX7H1WbsKX5VvASfFW5FJjqbemnyVmWdY9DIbHoeon/FFHoGbfDd3MBkvlWB+CX9S7
         328/kh2OOAnhhb+TtPt+lNc+75jquT4iWbNYOBWse5BFiLU3LmVxMPFYsxeLojPtbSYz
         6+cb3bLKGc/zHWK5vzDweFQisgWPXpP9rZ9Ap6YRYNjf/HXjxHbMNFw2lJf0gYczFg7u
         RqpHjg2gJ4wWixam78fqZlqeU4FsmZvZbKlJFExJgEHua/4tymZn7kWPosm01ZfylB4/
         R7RH/P+OH1gPHKPwB3TL555UlSbO4i1SVYtMSLXWjABbyRRhuPiua8PhT/VwRBVqmcwK
         y8KA==
X-Forwarded-Encrypted: i=1; AJvYcCU3w/pQf/LDh7XPYIZ7aQjkiSBAe8TdeByTDPQX4hqIAQA0+jE+54UN4YKFxfZ4Y+z21W47LlFw+8SNTyDlt8+lmcBrg/toKKA7U5oS
X-Gm-Message-State: AOJu0Yx+F0waX4Yazm6pQt9xgOu/VofcQFG4+BxZLkcSqj1+iOhsStcS
	VUayns/IusPptFNwNFBQMV7h18kvGhhdfLazGq4ntC8vJE0BEgMfIZN9e1Ueq+31tseVbNRG4Jb
	xRHH2cCTDl7Lpe8FXLuBbIMBeevT8ab/9VawZY/kYcnaD86hw+0EavQ==
X-Google-Smtp-Source: AGHT+IGP1r1vsd3FsMXgp+EG96vUOBK1F6/+3vOV0WXKU9/Rj0bDYdy6rXTS+Ytqvn2/2eeWwZC7z7VALGjKfXwS+lA=
X-Received: by 2002:a5d:5e0f:0:b0:367:4d9d:56a5 with SMTP id
 ffacd0b85a97d-371983d5ea0mr4456524f8f.44.1724039408991; Sun, 18 Aug 2024
 20:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com> <ZsKtllxojkTe3mpY@fedora>
In-Reply-To: <ZsKtllxojkTe3mpY@fedora>
From: Muchun Song <songmuchun@bytedance.com>
Date: Mon, 19 Aug 2024 11:49:32 +0800
Message-ID: <CAMZfGtWxE9z4GgmpEBXzwsy_HAyOOZ85+2HUyqE-9+n1f2aPJA@mail.gmail.com>
Subject: Re: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED
 and adding requests to hctx->dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:28=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Muchun,
>
> On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
> > Supposing the following scenario with a virtio_blk driver.
> >
> > CPU0                                                                CPU=
1
> >
> > blk_mq_try_issue_directly()
> >     __blk_mq_issue_directly()
> >         q->mq_ops->queue_rq()
> >             virtio_queue_rq()
> >                 blk_mq_stop_hw_queue()
> >                                                                     vir=
tblk_done()
> >     blk_mq_request_bypass_insert()                                     =
 blk_mq_start_stopped_hw_queues()
> >         /* Add IO request to dispatch list */   1) store               =
     blk_mq_start_stopped_hw_queue()
> >                                                                        =
         clear_bit(BLK_MQ_S_STOPPED)                 3) store
> >     blk_mq_run_hw_queue()                                              =
         blk_mq_run_hw_queue()
> >         if (!blk_mq_hctx_has_pending())                                =
             if (!blk_mq_hctx_has_pending())         4) load
> >             return                                                     =
                 return
> >         blk_mq_sched_dispatch_requests()                               =
             blk_mq_sched_dispatch_requests()
> >             if (blk_mq_hctx_stopped())          2) load                =
                 if (blk_mq_hctx_stopped())
> >                 return                                                 =
                     return
> >             __blk_mq_sched_dispatch_requests()                         =
                 __blk_mq_sched_dispatch_requests()
> >
> > The full memory barrier should be inserted between 1) and 2), as well a=
s between
> > 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleare=
d or CPU1
> > sees dispatch list or setting of bitmap of software queue. Otherwise, e=
ither CPU
> > will not re-run the hardware queue causing starvation.
>
> Yeah, it is one kind of race which is triggered when adding request into
> ->dispatch list after returning STS_RESOURCE. We were troubled by lots of
> such kind of race.

Yes. I saw the similar fix for BLK_MQ_S_SCHED_RESTART.

>
> stopping queue is used in very less drivers, and its only purpose should
> be for throttling hw queue in case that low level queue is busy. There se=
ems
> more uses of blk_mq_stop_hw_queues(), but most of them should be replaced
> with blk_mq_quiesce_queue().
>
> IMO, fixing this kind of issue via memory barrier is too tricky to
> maintain cause WRITE/READ dependency is very hard to follow. I'd suggest =
to
> make memory barrier solution as the last resort, and we can try to figure
> out other easier & more reliable way first.

I do agree it is hard to maintain the dependencies in the future. We should
propose an easy-maintainable solution. But I thought it is a long-term issu=
e
throughout different stable linux distros. Adding a mb is the easy way to f=
ix
the problem (the code footprint is really small), so it will be very
easy for others
to backport those bug fixes to different stable linux distros. Therefore, m=
b
should be an interim solution. Then, we could improve it based on the solut=
ion
you've proposed below. What do you think?

Thanks,
Muchun.

>
> One idea I thought of is to call blk_mq_request_bypass_insert()(or rename
> & export it) before calling blk_mq_stop_hw_queue() in driver, then
> return new status code STS_STOP_DISPATCH for notifying blk-mq to stop
> dispatch simply.
>
>
> thanks,
> Ming
>

