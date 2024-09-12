Return-Path: <linux-kernel+bounces-326725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83957976C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA13284D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD761B9829;
	Thu, 12 Sep 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfr/OEnM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD81B9821
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151668; cv=none; b=baflwe4FWz6LUS6FuVZoFJZDFXWO32IFOekNRDS6GKlZTc6St3PhEKDqhL2xQ6NyP0EBzhxdBQO/YmU1ngnqnMnizDK/AJgUL9vMusEBjxPVFTo5ScxFtEwe3JDCUDh2I2bKfJAE43wbUPEaGXqhqiRjItuOxyAzZG57VGpjwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151668; c=relaxed/simple;
	bh=s5SCUSV2N13cBuqs2/CZcBicuYyGC/7ZlO7Z3j50H1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhbkbf73rMHwnKBztJ2L5Cm9+PvsQa/igA2A7AJ4LuUswBhXzdeho3y1EJwbe3cF0E2q5ZNc4cGGg/cV7lHcvjeNGzQEx9rFKtzHpR+vbowEVGhSNZhW+V4YBmYm99y39JT6JKLRakzeF1ZDepVCMQ1kH6fFr/otEJfTDbtiU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfr/OEnM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726151666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxGa2WKqdhEIp/ToTEe+Od8jgzABw24Ex9DEEyXHNoU=;
	b=Dfr/OEnMSkmzI5+epszZxoflY/6RIZ+uSFImnmWlp1qSFqlHseM1fwHKZiOaMgMFuLCjNo
	j5cwg7Ejlq0rnUNbuNWoDFc5Ku8Mc8HRanH+uUMppMI4aPXpKdKD/NueWEMBD+FZHNdW/Y
	cVtRMnyZczxinPjlh3hajjVJGH22d/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-zJ66XlNRMSSsjiT57AOKKQ-1; Thu, 12 Sep 2024 10:34:20 -0400
X-MC-Unique: zJ66XlNRMSSsjiT57AOKKQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso6579455e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151659; x=1726756459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxGa2WKqdhEIp/ToTEe+Od8jgzABw24Ex9DEEyXHNoU=;
        b=jdD76La1PbVC4cg4+cfWsQM1TPUaFDVT6c5wN9E9g/hans/XBBHr26ynoyLE/z84mc
         ZNWvJtqCBBST9MLJ2YER3sLL8rbvbzwi8/1OTlBXH6wD/c8rcbDT3iMPxMPvvVWQk78v
         zh9oy7olDqZVV8pLNduGQ017sI3LQohn9Roh8WduaxiJCXDtI23IdXWbyyHnEQIk/N5r
         tWpa6wzWqWyowA5yaiNufpfB0KL06lMi6UllP2lb8BlBIL27xioOZs2lHaR5LiDbrYRQ
         a0Pf4KVQ8ZOkiGVeVMgv48eA9e7tn3lr97KDx0qiBgemFldguhRn/5hwluzqu9pijHXU
         vgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBj56+S1YxeQ4U920g/mDupD+7Yj4ZJ/KBjmT+nsIYcgUXf1Y3QXkMznBSGxb7Yeq02ravR23jE5HMqTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy41fDPKgJOqoRlnZPqkH0X9sYOUGRJ36vhIB6bmNlAp4Cw6q6
	8EwmhL3A+IlXNXaOnjAcTY4fd3mWmFLcaEIm4oh1jMkgNiQYOq/pd+kK7w3B32/S+hCA7rfJwq2
	KBOJFYhM53vfxGaflPr0IX1cB1YCaBrrsRkgJCSp0dLtIBBv4zi78bvt40Pzr/w==
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42cdb5721eamr25202315e9.31.1726151659453;
        Thu, 12 Sep 2024 07:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMaYXhiXR8hK+VHBPqK9k4lvOVvTspIgsm7eb/P3KRMgSGoGIwmwzRxkM+fUsPQ5bB9VbKew==
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42cdb5721eamr25202025e9.31.1726151658499;
        Thu, 12 Sep 2024 07:34:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm91335385e9.1.2024.09.12.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:34:18 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:34:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912103017-mutt-send-email-mst@kernel.org>
References: <000000000000e2058e0621e7a637@google.com>
 <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>

On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > >
> > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> >
> >
> > Yes, it's racy!
> >
> > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > 2590:        if (vq->event)
> > 2591:            vq->event_triggered = true;
> >
> >
> > Question: is there a way to annotate code to tell syzbot it's ok?
> 
> In this case, "if (data_race(vq->event))" might be the right choice.

No, vq->event is not racy.

The race is between a write and a read of event_triggered.
I think data_race tags a read, it can not tag a write, correct?



> This is a quick guide on which access primitive to use in concurrent
> code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks,
> -- Marco


