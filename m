Return-Path: <linux-kernel+bounces-304715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60CC9623E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3C1F251BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E3647;
	Wed, 28 Aug 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O22BtjIp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368691667C7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838474; cv=none; b=lbCWHxz88zgzgtAQk40A/ztSwR/N44Co3HCibrp/Dt+vWQbn63A+SkhBo+6epvZrp2aUegkbqov3ebSWSW5UAyEr5VJuavpZ/reNEBtySVbgJQbanHrJffAM1a8hgprRqCc8eyJfs2JVj0YGttHiAocHOZAKALskZm4ZuoDYH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838474; c=relaxed/simple;
	bh=WSTh+zu0TJIXe1FY/vQjpVJQQl5HhtJegSsKhpz2Guk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8RdVAW3GoYPc4dJGQsNpEtsErdiYSol7HqLr61i0vv+uUKrpFcv/SUrcR9Dmqgy1WhS/L4B+ubdFKI1JbfIazmB6bDk3ixo+xYu/sBzulELe9r2W7UsOhJkD8dJY48Zr231ai6gIbWbXSfqtBbPo7iQm6WDDC2VnR60qn3S9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O22BtjIp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L20WswXzsoqqavVlvJi0Y93AkFoGYOXnB8BArl5SMxg=;
	b=O22BtjIpbAjTLi9Y/dJ7K9aiG0B/KTQUBWs5XrgNJwMOq3RTHKqBUxx/GwXVtk46ylRo+z
	5omRNsrozS9fYEyJvPsQqXFzl7ClCSgjLZ6d0lnckyiQ4+kG044lXQtGjN9Y8TrKCMqScN
	fbJBU4/v/o2ZQH0VWkqypOCIokch6tE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-nRyZNzWxOwSwBvGQHf1TvQ-1; Wed, 28 Aug 2024 05:47:50 -0400
X-MC-Unique: nRyZNzWxOwSwBvGQHf1TvQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bec6d21e36so5234565a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838469; x=1725443269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L20WswXzsoqqavVlvJi0Y93AkFoGYOXnB8BArl5SMxg=;
        b=kktkRSjm298QdU2+JrM34ba+wRz71Jj4Uzz4oPL514WEPhXPxzXlzABx320N6rjNwh
         H8Sy6xB7MyHPBloxUMMLc0ks2jVS+nGDamKsD8vUEnuFB1A3fxtpsyUI5mwbSs2WMoKh
         jb7PAq+fitKz/ijQkRbhp1GTR63KV8ICAu6/o/DbfnJr5I+LLda+/APv6VthCWoMcuMl
         7BvWFApa2WLakkAnfQuqDOlw7BLhOG9Od6rijx3zILdzumyWnIgRuNkgdSvo8Hzokzl/
         53t46NJVoYPXPC4NpreHtLpJSE1xXct/aFUI6B0grfcesrDafpUthgjS5NHnrAOafhrI
         iMtw==
X-Forwarded-Encrypted: i=1; AJvYcCWhIDHBPzUbAXU9MIh7V3oyD01tT0igVl0Iy+/fmpyx/iLyG7OFEAcOlHxElkOCbBj6uVLhbAGws+4bego=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GasB1sXB0COdfFvA4oa36TXGZFyrzO6RzzUQnyTLDw1hApDc
	67F8bDfQzHvZh1Nn/1HCAB2p81lTEiNHZcGQqa6XNmHW+g9xv58KlgHtKHaj4T338plxbdrLOE0
	NOs19jKDyvNysxlEcGrWcwx9eJrFyohQqpoSuxVf3Y53OUI98V3nlsvU8MfWiLQI5Ow1dDfuFOu
	Dl6g9Au8w1lupJ6tnnRbLXQmlodtWROyZFR50L
X-Received: by 2002:a05:6402:3709:b0:5be:fc44:d159 with SMTP id 4fb4d7f45d1cf-5c214c2bdbdmr1080609a12.22.1724838469602;
        Wed, 28 Aug 2024 02:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARCAiUO0ACG/lOR6SUELzwUh4s+3RcakuKgtH/kGxLckkd6Kcn8CcSKr46OrOkcpwrz3n+Rma//SmX/+ECUo=
X-Received: by 2002:a05:6402:3709:b0:5be:fc44:d159 with SMTP id
 4fb4d7f45d1cf-5c214c2bdbdmr1080599a12.22.1724838469216; Wed, 28 Aug 2024
 02:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
In-Reply-To: <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:47:12 +0800
Message-ID: <CACLfguXn2xDaowNYVxOg=L2ch=UudQAD-atxkW1J1XyWLL+AaA@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost: Add support of kthread API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:35, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > vhost removed the support for the kthread API. However, there are
> > still situations where there is a request to use kthread.
>
> I think we need some tweak here. For example, we need to mention that
> the introduction of the vhost_taks introduce userspace noticeable
> changes as the worker inherit attributes from the owner instead of the
> kthreadd etc.
>
> > In this RFC, the support of kthread is added back. Additionally,
> > a module_param is added to identify which mode we are using,
>
> It's probably not identified, it's more about if we need to "enforce"
> the old behaviour.
>
sure, will fix this
Thanks
cindy
> > and
> > a new UAPI is introduced to allow the userspace app to set the
> > mode they want to use.
> >
> > Cindy Lu (7):
> >   vhost: Add a new module_param for enable kthread
> >   vhost: Add kthread support in function vhost_worker_queue()
> >   vhost: Add kthread support in function vhost_workers_free()
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add kthread support in function vhost_worker_create
> >   vhost: Add new UAPI to support changing Kthread mode
> >
> >  drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h      |   1 +
> >  include/uapi/linux/vhost.h |   2 +
> >  3 files changed, 235 insertions(+), 9 deletions(-)
> >
> > --
> > 2.45.0
> >
>


