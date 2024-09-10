Return-Path: <linux-kernel+bounces-322694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2EF972C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7420728784C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E6418661B;
	Tue, 10 Sep 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHn+tIHI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE414A4C3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957785; cv=none; b=Kieyw1n/ZKQRUeHcAKT5s687Dz6JYnU7BHdRkxpghlPH34bUwXeQVYlTHh246+q2Wo/UvSlZtM/+Y/mFmXwIEldXrKv/drNb3Nb+251zot3dDTi2KFEw5nPrM+xBV7DckugRDCwOY9Ncxa0r+1MBIGZQt4/SQjHSwMiwcjeV6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957785; c=relaxed/simple;
	bh=ihGFXKSdNq1acfmeBeiDK3GKtbP9QbngzFbcDCCyUBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3W0AjbM4iYjq1R4ix3Z9XheZxD4n5QfzBaJrZYabQz0RGalgwOEAr/OyMApm2fhNhCuOzfb0eh92Wfm3S+h8YNNr71hRU5t54J41ckObrsNEDYN7qPewpri7/o7eFxmx5iB0T26tBlwLxOsB7hpnXT17ym50ZYncxrOmGCJhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHn+tIHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725957782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTFhbUrNZRNdJ67rXYj34xiYWTFaYUZHryTDusV4E/w=;
	b=EHn+tIHIFY8Hw2CY6KbMU9Zl7OjzfVfMaXG3ogkS2tNLgmewF9JihFoGYULNGG5/PEjtmB
	l/37bD63ZNhKZQAiNHYeS2GqPD+9YfT/Io2TKJ7gZnYEoR4gpAnXhVN0v0S+fmN65dGeQu
	wkLRtn66CyerwfUISY7YaGSYzeNLvB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-iMKILaccMNChzl_ZcbKxkQ-1; Tue, 10 Sep 2024 04:43:01 -0400
X-MC-Unique: iMKILaccMNChzl_ZcbKxkQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb22d396cso21147915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957780; x=1726562580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTFhbUrNZRNdJ67rXYj34xiYWTFaYUZHryTDusV4E/w=;
        b=VOAYAQW5wDPfb8Cz1+CK7QkCQtzu7V42edX3nICHiM1y+f0mJxYFKUDhEqQ/LpZGK9
         /UwYq58O+z8e+E6d/X0wwFfSHsKbUiluT7B9LSve9L1Y1Xod55iVS5yUyab0vM4t9cTH
         8B3fUYpJpYx3LqwWaUip48GlKRw7eEQmueZ2g6aopthjihToWSUDVuLEHr3qzffaMYUn
         Q3mokjjabYc6/oz8BZRDqenEmdZM7AcCVS+lIM6eKoU6gylvGvs+xaESoU2IYOi+MImm
         6KKd/eXiziYrW9lmmPFV2SzBp+2gufG0aHuuqYjhQ2cneez5Ca5bIsyLaELd99N4iXW4
         tISg==
X-Forwarded-Encrypted: i=1; AJvYcCXble1p9PZLvHfW8wt04KpABgP8p3M0wja/PdoxhC97u9pecvegioyEW7opcLy83+BLe8l2ciU445WWusA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJDdq0KvQbh36NFZ0jU/v99aUDqGVoN+2PnR887jlESOymRi2
	s6ChJ3hj2fdojqRrg/klRuume8OxKZokaM9RpmhTdbj8RQ3MJ0VsGhP6MP0uLd90m/tjO4vg1K9
	cQrLGyj1Rw7uU2H0FOjiGOwFn7+ePve5vtNgGdALghUS7Xucre0xemH8P/zaalsR1EJPE6Q==
X-Received: by 2002:a05:600c:1d8a:b0:42c:b0f9:9b28 with SMTP id 5b1f17b1804b1-42cb0f99c0amr67407155e9.28.1725957779663;
        Tue, 10 Sep 2024 01:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPns4vTGAdO8znaVJVGMHVa1kyeW8lXfvHZwGX/F3imSQLPTE0WFTpfxqcqz4Ud12xzFMAwg==
X-Received: by 2002:a05:600c:1d8a:b0:42c:b0f9:9b28 with SMTP id 5b1f17b1804b1-42cb0f99c0amr67406955e9.28.1725957779082;
        Tue, 10 Sep 2024 01:42:59 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca7cccd35sm121482885e9.18.2024.09.10.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:42:58 -0700 (PDT)
Date: Tue, 10 Sep 2024 04:42:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
Message-ID: <20240910044139-mutt-send-email-mst@kernel.org>
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>

On Tue, Sep 10, 2024 at 04:37:52PM +0800, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > > vhost removed the support for the kthread API. However, there are
> > > still situations where there is a request to use kthread.
> > > In this PATCH, the support of kthread is added back. Additionally,
> > > a module_param is added to enforce which mode we are using, and
> > > a new UAPI is introduced to allow the userspace app to set the
> > > mode they want to use.
> > >
> > > Tested the user application with QEMU.
> >
> > Cindy, the APIs do not make sense, security does not make sense,
> > and you are not describing the issue and the fix.
> >
> >
> > The name should reflect what this does from userspace POV, not from
> > kernel API POV.  kthread and task mode is not something that any users
> > have any business even to consider.
> >
> >
> > To help you out, some ideas:
> >
> > I think the issue is something like "vhost is now a child of the
> > owner thread. While this makes sense from containerization
> > POV, some old userspace is confused, as previously vhost not
> > and so was allowed to steal cpu resources from outside the container."
> >
> > Now, what can be done? Given we already released a secure kernel,
> > I am not inclined to revert it back to be insecure by default.
> 
> It depends on how we define "secure". There's plenty of users of
> kthread and if I was not wrong, mike may still need to fix some bugs.
> 

which bugs?

> > But I'm fine with a modparam to allow userspace to get insecure
> > behaviour.
> >
> >
> > Now, a modparam is annoying in that it affects all userspace,
> > and people might be running a mix of old and new userspace.
> > So if we do that, we also want a flag that will get
> > safe behaviour even if unsafe one is allowed.
> 
> I am not sure this can help. My understanding is that the flag is
> sufficient. Otherwise the layered product needs to know if there's old
> user space or new which seems to be a challenge.
> 
> Thanks

this will be up to userspace to resolve.


> >
> >
> > Is this clear enough, or do I need to elaborate more?
> >
> > Thanks!
> >
> > > Cindy Lu (7):
> > >   vhost: Add a new module_param for enable kthread
> > >   vhost: Add kthread support in function vhost_worker_queue()
> > >   vhost: Add kthread support in function vhost_workers_free()
> > >   vhost: Add the vhost_worker to support kthread
> > >   vhost: Add the cgroup related function
> > >   vhost: Add kthread support in function vhost_worker_create
> > >   vhost: Add new UAPI to support change to task mode
> > >
> > >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> > >  drivers/vhost/vhost.h      |   1 +
> > >  include/uapi/linux/vhost.h |   2 +
> > >  3 files changed, 240 insertions(+), 9 deletions(-)
> > >
> > > --
> > > 2.45.0
> >


