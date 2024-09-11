Return-Path: <linux-kernel+bounces-324685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF07974FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B881C22591
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF818593F;
	Wed, 11 Sep 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/W91uy3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95375177992
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050536; cv=none; b=RhXCM02CzrtNCM2NsVEU4E0VdYwo03HeUDvmXIjlf8wJE1pEhPrTBZ/lqQtJL/jQ/anNP22AodSY2tEBdHwQ3zaFavs431bUOv/WB5CbyCWrpRBoZrVu0e8oQwMbx4msa2JjQ74AfSUgNCrux98PNTrE8fNrR//lLdURfObSq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050536; c=relaxed/simple;
	bh=2SzCZbund/8+O5h+eegsBrUTgDD+fcadIowoFowp6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvzAcMpL3maNaMb5Wrv5Wd89Z3pzTwzJDfYM7szkdpHc9bmKtejmW2UuEcws0ZuAOGiXFCyeBwXGnenXE38T6mHLywsdCsJML3wVVK4oSMl5ExS5QUClKg5p1FGg1/inmr0VZf/G2yZQta0ntfBtdJL+q7apj0nMsQ22J61zoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/W91uy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726050533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ungg+nmZJyrc06QTgx8FJetOw+81QXiJdZ2W9hPPJE8=;
	b=d/W91uy3H/X8qXuMfHB1d/NvYDiaV0Ww5ZwQ4O7WUBRvWy+k9k4+fmxPbBla+w1xTAe5Jr
	AoX990pfLKlRy72DqCVWdhi513zOUOKsa8VkdnKcUbT1kD/8gHKlrZfebXNtJ4uQfNkPnb
	2z6G2jxUCGIkpa7Adxd8DBb9CU11Fcs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-09acjcP7OHqy2Nouv_Gkgw-1; Wed, 11 Sep 2024 06:28:50 -0400
X-MC-Unique: 09acjcP7OHqy2Nouv_Gkgw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a7463c3d0so417858366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050529; x=1726655329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ungg+nmZJyrc06QTgx8FJetOw+81QXiJdZ2W9hPPJE8=;
        b=gwUnsTTbDlAmP2mj0Aj4zKmIc7f0VJ9smgxXfgM9w3wc4cAVrG8s7GD+UWy6d9GvT2
         JgFCGP8IVTUMFbf1TphHtmKqP5U8VYeCVG+X02Lod1CmAbqrEUr3A1vQC+zRcupYI6Oz
         tpyREmxGURLskPAqmsuznEHf4mBMIck+6iOf9N+cX7jUHfuKfxzgwZp8vuMiyXmRYtA0
         5WKlTL726+cSlkcJUrWbPsUcmI+HtG1NPE6zZmuLc5Ryd7VkwvKHWy7n6oVRGNnXw8hY
         R7Bz0iVFh/5WZex0G6+VHWShe00lPp7ULCRriKbW40+c00SHWQxfb13WXvjd/+w5AvrS
         gaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv0LYRGVVDVayYxHwmVi6q8kIn8Du56nq32TUWe1We4H2lMaUMIqNFBWhT4gx0GiokIb4nHlxON6bHoCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2iboYjVrUJ71NP71QGO+VowTc89X2iwIRjcC9Jfg8WN+YvmY
	4sW8k43AX5W6bR5L+A+vAsaZ//iyvEm0AkE0KjK8zn8ehPj/ntcxqVlvR/OGvtFCxjdkRzxHhXd
	BAL4URLT3d5yR3avDw186Lsm0O8nFZkVQvM6KObq7c8fstS1C6b23xVNoFxlhSQ==
X-Received: by 2002:a17:907:6088:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a8ffaa97ad0mr405395366b.5.1726050529237;
        Wed, 11 Sep 2024 03:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWhWOZU7QkzTME7FbxXasitdSQaPrXkBs6SATTiPZutMleWrLvta0s5wcF0PEmNDJ7LftVQ==
X-Received: by 2002:a17:907:6088:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a8ffaa97ad0mr405392566b.5.1726050528519;
        Wed, 11 Sep 2024 03:28:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a09e21sm597513166b.84.2024.09.11.03.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:28:47 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:28:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240911062741-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
 <20240910044139-mutt-send-email-mst@kernel.org>
 <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>

On Wed, Sep 11, 2024 at 11:45:33AM +0800, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 4:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> > > On Tue, Sep 10, 2024 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > > > > vhost removed the support for the kthread API. However, there are
> > > > > still situations where there is a request to use kthread.
> > > > > In this PATCH, the support of kthread is added back. Additionally,
> > > > > a module_param is added to enforce which mode we are using, and
> > > > > a new UAPI is introduced to allow the userspace app to set the
> > > > > mode they want to use.
> > > > >
> > > > > Tested the user application with QEMU.
> > > >
> > > > Cindy, the APIs do not make sense, security does not make sense,
> > > > and you are not describing the issue and the fix.
> > > >
> > > >
> > > > The name should reflect what this does from userspace POV, not from
> > > > kernel API POV.  kthread and task mode is not something that any users
> > > > have any business even to consider.
> > > >
> > > >
> > > > To help you out, some ideas:
> > > >
> > > > I think the issue is something like "vhost is now a child of the
> > > > owner thread. While this makes sense from containerization
> > > > POV, some old userspace is confused, as previously vhost not
> > > > and so was allowed to steal cpu resources from outside the container."
> > > >
> > > > Now, what can be done? Given we already released a secure kernel,
> > > > I am not inclined to revert it back to be insecure by default.
> > >
> > > It depends on how we define "secure". There's plenty of users of
> > > kthread and if I was not wrong, mike may still need to fix some bugs.
> > >
> >
> > which bugs?
> 
> https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com/T/

Isn't this exactly what Cindy is trying to address?
You made it sound like there is something else.

> >
> > > > But I'm fine with a modparam to allow userspace to get insecure
> > > > behaviour.
> > > >
> > > >
> > > > Now, a modparam is annoying in that it affects all userspace,
> > > > and people might be running a mix of old and new userspace.
> > > > So if we do that, we also want a flag that will get
> > > > safe behaviour even if unsafe one is allowed.
> > >
> > > I am not sure this can help. My understanding is that the flag is
> > > sufficient. Otherwise the layered product needs to know if there's old
> > > user space or new which seems to be a challenge.
> > >
> > > Thanks
> >
> > this will be up to userspace to resolve.
> 
> I actually mean the module parameter. It would be very hard for the
> layered product to decide the value for that.
> 
> Thanks

We can make it writeable, if that helps.


> >
> >
> > > >
> > > >
> > > > Is this clear enough, or do I need to elaborate more?
> > > >
> > > > Thanks!
> > > >
> > > > > Cindy Lu (7):
> > > > >   vhost: Add a new module_param for enable kthread
> > > > >   vhost: Add kthread support in function vhost_worker_queue()
> > > > >   vhost: Add kthread support in function vhost_workers_free()
> > > > >   vhost: Add the vhost_worker to support kthread
> > > > >   vhost: Add the cgroup related function
> > > > >   vhost: Add kthread support in function vhost_worker_create
> > > > >   vhost: Add new UAPI to support change to task mode
> > > > >
> > > > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> > > > >  drivers/vhost/vhost.h      |   1 +
> > > > >  include/uapi/linux/vhost.h |   2 +
> > > > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > > > >
> > > > > --
> > > > > 2.45.0
> > > >
> >


