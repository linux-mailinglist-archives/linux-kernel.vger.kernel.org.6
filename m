Return-Path: <linux-kernel+bounces-324176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBC9748E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A390A285A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACE3BBC5;
	Wed, 11 Sep 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2rsa9VI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADB38DE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026351; cv=none; b=ttmJw9rGPc9zShBe/iAHYcI1hRjaba6nDTaxiDrLjjBczFV2tM97rz+10uTG6rjrMQzFMMy9SD07Sz9YBWM9jbOd6AxF1FA9+9c/opjjdddH1+UDvfp+2L42LDlSlrWFEQNnlx9uJH67oD4PCmCJrEdkRZml/017OxVbXthBKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026351; c=relaxed/simple;
	bh=+Rqn0P9mB0La8B4Fje7p5aX1Sl7TbVmBDFgISlRF8pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCAVBBz00y06E2LvHj9vjNh/BuNTAo0vlLdXcMgpDpEGpO6PqNKbLMtY7w2tTLsq8PbDjh7vfcu8gsD3X/G5X+AH2+MIlNE0EryAmLO31m2HTKtzQO/XMVU/fqAmZCF3XWw7BFGgMBBUqhjwKN830S7/zpywvgr8PUyo+NL3cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2rsa9VI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpoA2K3FbuBcPt6tnw7KwvXi7Ya0b7H2b/GB31m+eoM=;
	b=V2rsa9VIdAN1UbdDt7OL4fXcoOT5+/yziUhvYQGqf9rzG+ngHTHvk5m5fWSahJlWonHLFx
	VIlfVCc+EYeG0RJtotgRNaUoYlkmfdgjY6/SSzpYKl7zpC9PZdVpVx3EZd4X6rz2d4Cg6o
	IogiVbg+3Enb3iL12Y3TiwKScbawUrc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-C640vVL_PpSalfgzP1i6Qw-1; Tue, 10 Sep 2024 23:45:47 -0400
X-MC-Unique: C640vVL_PpSalfgzP1i6Qw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2db470aa646so2657124a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026346; x=1726631146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpoA2K3FbuBcPt6tnw7KwvXi7Ya0b7H2b/GB31m+eoM=;
        b=iTsdmM7aduDRadBOGHafrzs7x+0oERaF2wDCu3cIfLcmlP0FxYSg0G39sPv2m3K2Ep
         EeS390OtlOGj3GySy9iPqkhjiuh7F2GNRXqKUvHD2I1JUStTaypf+OWjeyKKv0dKj7n1
         waHgZO0C851w5NQOt3oZnoloME9Mj3bH+ZDhgsI6co7cFHISwA//VFf1xR/7goB6oB4X
         rxYQPOcduL244dqi5ZCXOff9Z7Me+HHIGSE1BoOe5dlezz8Xj4E/fsQNRz/bnfi+ZvR7
         NAUKVT+Ao0CpDJhK/lu2OtCMUV2/RnYq59RuBFgbX6jS8klQp6NHpGj3+HbntijamQrr
         hN0A==
X-Forwarded-Encrypted: i=1; AJvYcCVTWzXbSjoOX2pBc14xqavkqFTxdq+ly5divMLqLPiUKbpzVuFNXBCr9hjcBgWGF8U3QPm3v9bqi946Xck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9Y7z7azlB51UyKv9CtssY0Xt198NAOfst4Her2RspcSeYNYs
	TrmySx1hTQSsaDSrTbkoo6Q8O/zrASGWFRcAyQBHTN8iVWigMFyUzSfzUgZ6Eosr5qfI1Hl5fpr
	vNXO6l5XsvmxkLCtOW/sa53DnoF/2xUxsQWNKhKDTx1yFx/txnFfPkySUsdP/a5WoPlvmuI7eTl
	8VTi0FwIRTrAH8NKkmXl1Z3ImAseRbEHaFpN51
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2dad4ef4a6amr18033877a91.12.1726026346126;
        Tue, 10 Sep 2024 20:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj9vZUExbOBNU4jOmP5eXmRYi/TEXq3HEgEg7kx8fYKg3PiXc3U9CsuxA3ZvSd76wvoTopUe5ybTKLYrtquv4=
X-Received: by 2002:a17:90a:ee8f:b0:2d3:c892:9607 with SMTP id
 98e67ed59e1d1-2dad4ef4a6amr18033853a91.12.1726026345640; Tue, 10 Sep 2024
 20:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com> <20240910044139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910044139-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:45:33 +0800
Message-ID: <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> > On Tue, Sep 10, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"=
),
> > > > vhost removed the support for the kthread API. However, there are
> > > > still situations where there is a request to use kthread.
> > > > In this PATCH, the support of kthread is added back. Additionally,
> > > > a module_param is added to enforce which mode we are using, and
> > > > a new UAPI is introduced to allow the userspace app to set the
> > > > mode they want to use.
> > > >
> > > > Tested the user application with QEMU.
> > >
> > > Cindy, the APIs do not make sense, security does not make sense,
> > > and you are not describing the issue and the fix.
> > >
> > >
> > > The name should reflect what this does from userspace POV, not from
> > > kernel API POV.  kthread and task mode is not something that any user=
s
> > > have any business even to consider.
> > >
> > >
> > > To help you out, some ideas:
> > >
> > > I think the issue is something like "vhost is now a child of the
> > > owner thread. While this makes sense from containerization
> > > POV, some old userspace is confused, as previously vhost not
> > > and so was allowed to steal cpu resources from outside the container.=
"
> > >
> > > Now, what can be done? Given we already released a secure kernel,
> > > I am not inclined to revert it back to be insecure by default.
> >
> > It depends on how we define "secure". There's plenty of users of
> > kthread and if I was not wrong, mike may still need to fix some bugs.
> >
>
> which bugs?

https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com=
/T/

>
> > > But I'm fine with a modparam to allow userspace to get insecure
> > > behaviour.
> > >
> > >
> > > Now, a modparam is annoying in that it affects all userspace,
> > > and people might be running a mix of old and new userspace.
> > > So if we do that, we also want a flag that will get
> > > safe behaviour even if unsafe one is allowed.
> >
> > I am not sure this can help. My understanding is that the flag is
> > sufficient. Otherwise the layered product needs to know if there's old
> > user space or new which seems to be a challenge.
> >
> > Thanks
>
> this will be up to userspace to resolve.

I actually mean the module parameter. It would be very hard for the
layered product to decide the value for that.

Thanks

>
>
> > >
> > >
> > > Is this clear enough, or do I need to elaborate more?
> > >
> > > Thanks!
> > >
> > > > Cindy Lu (7):
> > > >   vhost: Add a new module_param for enable kthread
> > > >   vhost: Add kthread support in function vhost_worker_queue()
> > > >   vhost: Add kthread support in function vhost_workers_free()
> > > >   vhost: Add the vhost_worker to support kthread
> > > >   vhost: Add the cgroup related function
> > > >   vhost: Add kthread support in function vhost_worker_create
> > > >   vhost: Add new UAPI to support change to task mode
> > > >
> > > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++=
++--
> > > >  drivers/vhost/vhost.h      |   1 +
> > > >  include/uapi/linux/vhost.h |   2 +
> > > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > > >
> > > > --
> > > > 2.45.0
> > >
>


