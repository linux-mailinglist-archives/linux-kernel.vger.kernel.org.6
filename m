Return-Path: <linux-kernel+bounces-326783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CA976CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A571C23CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3091B9825;
	Thu, 12 Sep 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5s1dntL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22B1AD256
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153223; cv=none; b=GPBg2kHf00wqyR+Bm3uPzXgxqM+F21k+2fhc4zcahrdAknFSHhZ8+YCTuC9zil+4/obYWlp8lfktr5QYTjXBINqJtXkdoj3gves3SgtNVrRTXDLQsgcXtkuPyZOfz8lCFd+F1M0K1oieSX7kNYPttMcPpWzdFI2SGLsk5RVQzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153223; c=relaxed/simple;
	bh=d/ybhfMCTjKkGzaWZGoxnvqsofzvGS/CDRPky/HKZhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWyeudJZ7HTDJZLMj4mCXFwtBZ8dRJKW0jbGo29Wck7mknMYryM5GG0XsXRIBueJdaicORMF4xT3+xr4qlcaCUo5hvGP2i3sOdpzwqf70ChIFg2Wv4f60Q60PsQTBsI8eBypGtHQIOMc9i00eNc0Y8AC1HThFLvNJ85o0K8tXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5s1dntL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726153220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ra9RxWd2COyh/WhxNBLiqQRi/qW7TAIIfLxS3bjnOlA=;
	b=X5s1dntLx1pfboprtLgn9vMVu/Te7ATyzggaj7O48epC0ba8m4422DtutyOAuJyut6ShYk
	KKLTGYGsUZuQ3zmFbQH86/o1MvKuiC2iQA+n85ee82F9897cvOrjqbcAjgk9ghZf53wygy
	aXeFNW6Ant7w8K5LjLxypcy8YRQ5SNU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-fPisRPBuNY-Z28-Nkmt_sA-1; Thu, 12 Sep 2024 11:00:19 -0400
X-MC-Unique: fPisRPBuNY-Z28-Nkmt_sA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3756212a589so784047f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153218; x=1726758018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra9RxWd2COyh/WhxNBLiqQRi/qW7TAIIfLxS3bjnOlA=;
        b=ed9As0dFViiLBNhRjBmCgVN0cNyJChYowere7Uu2uftSpciZbtlDLEy1Z5jlOn+ntP
         qt+6b1qO8vRb1Up9po/EdArIMlvTRzwBOSvcEHtwLbuLoLG9gtB0234QpQFjl69EAVuO
         n5Bl0A9/mplWGqNycol7k9PMpCJP6J/ae7koMM2GKiCfMvq9uXoECu9NtcRWQ9JFfMeC
         zPbjD0wyYKW9ZOi4gyJnWHFgl0cyqg30N3CBZu5akx14rcs/kZzhfpUEwzm4gEnjF9YY
         7i3ny9nnFJUVrRAPRTAn8XEKHve6xYftWlvPvPjWmgA/2FPoDzvBtnKeqMacO9vTyjK3
         3zrw==
X-Forwarded-Encrypted: i=1; AJvYcCVepo7j1UjIcptNGWvvRiIo/xpJxhAobUX3jHEXJkl4lSjPbHQ/0mkjB5gsl8hNiSzYrfH8rCV5vtwax/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgYeYRyW3QVzPUa/rVJDjF21HA4KeEWTCnzEPk/wVl3tTwNuB
	WDcO1iUzF02jpIBkI9qdyl3iOm7L/kTEwYyW1p+eD3Of31F/WHqsnyuVrR1IB42RJ5YYE4ClT66
	g/QC5vWl5Sk5l7i0vjO7+NW39zWAXc75SzkOZP7dKM1vpPaVoCS98yKLSOvkOVw==
X-Received: by 2002:adf:ab14:0:b0:374:c90e:990c with SMTP id ffacd0b85a97d-378c2d037bcmr2522938f8f.33.1726153218544;
        Thu, 12 Sep 2024 08:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxC8R60skHAL/96hW1EQTBaRWn8ysR/Kh/DHj4LgpPdkftzu4AWByhVXHEE71gqTbmjOTGA==
X-Received: by 2002:adf:ab14:0:b0:374:c90e:990c with SMTP id ffacd0b85a97d-378c2d037bcmr2522900f8f.33.1726153217904;
        Thu, 12 Sep 2024 08:00:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649b88sm14689128f8f.6.2024.09.12.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:00:17 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:00:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912105002-mutt-send-email-mst@kernel.org>
References: <000000000000e2058e0621e7a637@google.com>
 <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
 <20240912103017-mutt-send-email-mst@kernel.org>
 <CANpmjNOGpVXXdi61vFJDPB4CHsd3ksotjdQHO6WiVXV2m-aABg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOGpVXXdi61vFJDPB4CHsd3ksotjdQHO6WiVXV2m-aABg@mail.gmail.com>

On Thu, Sep 12, 2024 at 04:46:28PM +0200, Marco Elver wrote:
> On Thu, 12 Sept 2024 at 16:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> > > On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > > > >
> > > > > ==================================================================
> > > > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > > > >
> > > > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > > > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> > > >
> > > >
> > > > Yes, it's racy!
> > > >
> > > > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > > > 2590:        if (vq->event)
> > > > 2591:            vq->event_triggered = true;
> > > >
> > > >
> > > > Question: is there a way to annotate code to tell syzbot it's ok?
> > >
> > > In this case, "if (data_race(vq->event))" might be the right choice.
> >
> > No, vq->event is not racy.
> 
> Oops - yes.
> 
> > The race is between a write and a read of event_triggered.
> > I think data_race tags a read, it can not tag a write, correct?
> 
> data_race() takes an expression, so either read or write can be
> enclosed - e.g. "data_race(vq->event_triggered = true);" works as
> well.

Ah, good to know. Yes, I see it is basically __kcsan_disable_current +
__kcsan_enable_current.  Will do.



-- 
MST


