Return-Path: <linux-kernel+bounces-326753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D6C976C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E70B236F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A71B9B46;
	Thu, 12 Sep 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiDV0nxz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA01B985A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152394; cv=none; b=eha4b40rXJ9c8YNYERd4WTUqoLxBEOvvo8D3AmleiJCy0IPh5Mg2Rc38a9pS2j2Ww6dPY3jGdt+vNuZbn3TsXQzl7TgWTH6zuQ+AVMG/yxnyc9B5wo3zdjWo0gjPkPIDQ3X7ScYs9hGzKhUe8bHBQEkGiFgpLiY5YHh470s1BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152394; c=relaxed/simple;
	bh=5gT9BRmXCO0TLfrvU31q0lPa6C7WuN7JAaAkfFi/zgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erAJDqqdLLOj6FE3B06UpgUHLsY40RbB73E/SVfyKj4BZkcSgqhgpk84teieU7rPNJo4LauXKXn+EwYrmf1Cf+s4/loFFefdwMab80FM2W1+eOOmuNQqLatt9ruwPNM7dr87qGxYV1h7JwkYiAO0RK4tyQvM25THtZ/4STOBfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiDV0nxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RkOgBhHe6/k/nE3HpsJCkCjdlY43j+z3h97RvGxFGJU=;
	b=IiDV0nxzMvkRS+YoCyrnceAj5jAxs7HFY4YcY35uSVec1gRA8nCh0/kN0ZEC7rgk/U2lJJ
	uRvZBRoJI0mSviOGJ6vGJuB+qddvyNAG67CV2Y280NubpmfBB4m3KWPmexbBHBXJ9Ua6GM
	ma2gkGxG9zE06qa6MF0FpI2jCw7Rz8c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-1SPAP9n1MiqEiS6-XZtxqQ-1; Thu, 12 Sep 2024 10:46:29 -0400
X-MC-Unique: 1SPAP9n1MiqEiS6-XZtxqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so11035725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152388; x=1726757188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkOgBhHe6/k/nE3HpsJCkCjdlY43j+z3h97RvGxFGJU=;
        b=KFEO17nlOopgiCjrllJtsSDsDYoM3PsOFKj2lAtk75He9QqaLPmkvlroNet+qUV6lZ
         lUE/vrJgGINOH57eJz0nYFFgygFGLRKecX8Nlfj+mq9iWzC1+tGtPgnPTP7OZsPcUOj1
         7noiBhij2SS41KYvKaWw983GqN4B06siLd5vdvrc30ke/X3ppV4Vn9VUQzJECLdiMs6y
         R7zrej2yTNdOQ9HW/wCBVQ7JI3z3cjTLPjkNQiE1vtdGsoswT35d9hbhpR8ZW0YMH5LP
         QJBjRsxGfr7Z1GTMGR1OVwKszaHg28jrZGl4ECRdnVri63MPPh0Iq8b/Ywk131gTbgSZ
         NpJg==
X-Forwarded-Encrypted: i=1; AJvYcCXCWvoGWeTpK9yxDLwZ5vqobCmOFBT3GfKipd1qoljxCAvQ139sGnArL7TQ2/wEnJwelqznoHm8zxyxT6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRdKawRMjufp7B2wTFo3igAmOM8pOjUMNb+6htcSmssmkUI3o
	9jp+1p0srwAAKXnVBXiEdLr7nnIA759YHV4wLIcLhgNfJo9tfRInQI5D7uYuPTjFJ8LwgDHDwhI
	xUKZmiNUbtfVzzqPi0KS898X7tWBSHo/sW4e40beY6lBYQFJq7gTdCGr5/8gz4A==
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr63152125e9.13.1726152388045;
        Thu, 12 Sep 2024 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEakTyhyWFWtQns98wQW2B5kqVZSDJcqennuilUm4CeDOT3jYZwL5+Fyv99b/FC+BW6JyB7/g==
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr63151815e9.13.1726152387097;
        Thu, 12 Sep 2024 07:46:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21b1bsm176676075e9.2.2024.09.12.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:46:26 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:46:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912104553-mutt-send-email-mst@kernel.org>
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
> 
> This is a quick guide on which access primitive to use in concurrent
> code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks,
> -- Marco

I sent a patch tagging this whole field as racy. Pls take a look.

-- 
MST


