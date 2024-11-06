Return-Path: <linux-kernel+bounces-397600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF499BDDDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE51F21789
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD619049D;
	Wed,  6 Nov 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azUXEiCy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881E24B26
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865548; cv=none; b=HR8sk3ps2s5E8PAOWy+8ptWfVI1TlRFzFOMUgSCdDN7fABrAmnW2s/eXjtQHPjZpWkAOgXE62IOHpAE+jFTHTkH4DnBP3L0r3nYEMfRTNH3xKoAqqj/Q9KLyY3Ew7MESPe+wuQKKRihrYmybnFPQBOBHiH2qbK0hDmmJo1HNTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865548; c=relaxed/simple;
	bh=vFCeH5tfdMdof6SDEGDwKvjPbG4ibsF9Q2P6V1oGb+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHow8VTQQCOTxYf2jRR+0pUdi0ENwsIrEJBaZ20pOj0g5B8VbvZ2ZAYdUe9gWndm3IZ4jFuj/q4vv2uMuNQ68LOxH0GrNrs8AE+WmXi2wyqGeojwGvdRFyITpE9Q3MBCZs+YChUxcS5qfWVZ1/zUd1gqYXqOIM/8CF5ALn7Y9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azUXEiCy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730865544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i65ggtVhllfw2lstHxf4sn7duXOoTxNKDcpH0B3r5sw=;
	b=azUXEiCyHm/BZuk3Y8HHAz+C3cprqJnaVGJGr+1gD7qcuDoTe+AG+rUpddarQerao3J59o
	038gjTedAe6TKlbRJG3v1n3eDuLgNjCUV9Nyr9exz8qsycQJtGcSP4PizkqUjOqHF6/ghx
	57d5FpHfNvgqZPhoH+LZB8Ply2kJqMs=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-8IGteh41MS27TGU894oP5g-1; Tue, 05 Nov 2024 22:59:03 -0500
X-MC-Unique: 8IGteh41MS27TGU894oP5g-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84ff378cd5fso2282699241.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865543; x=1731470343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i65ggtVhllfw2lstHxf4sn7duXOoTxNKDcpH0B3r5sw=;
        b=NWKywqFFtr3QIXFg4rVu+SSPxFfBaodkmW1NDdJ0vRE4q/b2fUxNU4ptjIKnjBErsa
         ctoSub9HSNIJcRmAX/HTMKGuj1VIp28njCbgWUhGALnPY9PXdR1EdPtyqLYyW8ezkuL1
         GfuW0Y/3dIUTQuOkanKwlLESydJLkGC+M08fQbGXA57WYZwwEkGKGU72EP/qwbd9z69f
         JrXhgJ2bIbmolQ4Bi2yRWV1S/psUF+kKXBOgUjOalYEKIjpwpbtpMH1b0S3ccmGxw3xG
         cr9ABXqXejyHOB0aqggbq5bKQhnazYGezRZ46IHEjDxlVFt1JlC7Q8g1IVzBVh44SRw4
         50hg==
X-Forwarded-Encrypted: i=1; AJvYcCUp8R6sBHFZbu/UutgsG4GyfE6yfV+IdT83OTwTanx5fP8Hbfh/oB96gquXqA/vWhS/+OmpddJVKkdlVyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzmHfnTUOr0U2whhmbZENh1bqVKvx6SEAzr1fhZDKvQfvsbiZ
	MOQbt4V9bH4RWurklw8JX6ejvC9hTlkpqadyRRHVsbZpYvJGYMs/6lJ45qe4tF5tyvBKQfU9Xn1
	LfESq+S+6p7RcrhUM9u6B6K6uv+aN294TaOu8VbN3EPzke/7LMN0O4BZqzvvzvYgdUxe0v+MUH0
	VYtkZqu2VKC32ih4K6emS6hWN7YcCa9mp31R0b
X-Received: by 2002:a05:6102:1890:b0:4a9:61c1:4e56 with SMTP id ada2fe7eead31-4a961c14ea1mr13520279137.13.1730865543143;
        Tue, 05 Nov 2024 19:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECBVLcWw1pYcwoMcH67wqdE4G3+IcTNY6jd52ByUeJU203rRh/lyfP09mI+hsxi+bJD59NH/ZmftJiYRlQ/e8=
X-Received: by 2002:a05:6102:1890:b0:4a9:61c1:4e56 with SMTP id
 ada2fe7eead31-4a961c14ea1mr13520272137.13.1730865542878; Tue, 05 Nov 2024
 19:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org> <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
 <ZyreVTWn2no-WCC3@fedora> <43ed2c81-7e86-a106-3592-7f1944ce0f25@huaweicloud.com>
 <ZyrkTB0-SKjrQaiZ@fedora> <78c19006-e4c1-ef19-e930-9d5dc1cb295d@huaweicloud.com>
In-Reply-To: <78c19006-e4c1-ef19-e930-9d5dc1cb295d@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 11:58:52 +0800
Message-ID: <CAFj5m9Jvw=3KPGYyChJu5nxraxwKm04kpMak5Ns+pjkHepsN-Q@mail.gmail.com>
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:52=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/11/06 11:36, Ming Lei =E5=86=99=E9=81=93:
> > On Wed, Nov 06, 2024 at 11:25:07AM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> =E5=9C=A8 2024/11/06 11:11, Ming Lei =E5=86=99=E9=81=93:
> >>> On Wed, Nov 06, 2024 at 10:58:40AM +0800, Yu Kuai wrote:
> >>>> Hi,Ming and Christoph
> >>>>
> >>>> =E5=9C=A8 2024/11/05 19:19, Christoph Hellwig =E5=86=99=E9=81=93:
> >>>>> On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
> >>>>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>>>
> >>>>>> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, b=
y
> >>>>>> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is c=
leared
> >>>>>> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counte=
r in
> >>>>>> atomic mode after del_gendisk"), hence for disk like scsi, followi=
ng
> >>>>>> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as=
 well,
> >>>>>> cause following uaf that is found by our syzkaller for v6.6:
> >>>>>
> >>>>> Which means we leave the flush request lingering after del_gendisk,
> >>>>> which sounds like the real bug.  I suspect we just need to move the
> >>>>> call to blk_mq_clear_flush_rq_mapping so that it is called from
> >>>>> del_gendisk and doesn't leave the flush tag lingering around.
> >>>>>
> >>>>
> >>>> This remind me that del_gendisk is still too late to do that. Noted =
that
> >>>> flush_rq can acquire different tags, so if the multiple flush_rq is =
done
> >>>> and those tags are not reused, the flush_rq can exist in multiple
> >>>> entries in tags->rqs[]. The consequence I can think of is that itera=
ting
> >>>> tags can found the same flush_rq multiple times, and the flush_rq ca=
n be
> >>>> inflight.
> >>>
> >>> How can that be one problem?
> >>>
> >>> Please look at
> >>>
> >>> commit 364b61818f65 ("blk-mq: clearing flush request reference in tag=
s->rqs[]")
> >>> commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] befor=
e freeing one request pool")
> >>>
> >>> and understand the motivation.
> >>>
> >>> That also means it is just fine to delay blk_mq_clear_flush_rq_mappin=
g()
> >>> after disk is deleted.
> >>
> >> I do understand what you mean. Let's see if you want this to be avoide=
d,
> >> for example(no disk is deleted):
> >
> > It is definitely another issue, and not supposed to be covered by
> > blk_mq_clear_flush_rq_mapping().
> >
> >>
> >> 1) issue a flush, and tag 0 is used, after the flush is done,
> >> tags->rqs[0] =3D flush_rq
> >> 2) issue another flush, and tag 1 is used, after the flush is done,
> >> tags->rqs[1] =3D flush_rq
> >> 3) issue a flush again, and tag 2 is used, and the flush_rq is
> >> dispatched to disk;
> >
> > Yes, this kind of thing exists since blk-mq begins, and you can't expec=
t
> > blk_mq_in_flight_rw() to get accurate inflight requests.
> >
> >> 4) Then in this case, blk_mq_in_flight_rw() will found the same flush_=
rq
> >> 3 times and think there are 3 inflight request, same for
> >> hctx_busy_show()...
> >
> > But we have tried to avoid it, such as in blk_mq_find_and_get_req()
> > req->tag is checked against the current 'bitnr' of sbitmap when walking
> > over tags. Then the same flush_rq won't be counted 3 times.
>
> Yes, I missed that req->tag is checked. Looks like there is no porblem
> now. :)
>
> Just to make sure, we're still on the same page for this patch, right?

Yeah, my reviewed-by still stands, and it is fine to delay to clear flush r=
eq
wrt. the original motivation, what matters is that it is cleared before the
flush req is freed.

Thanks,


