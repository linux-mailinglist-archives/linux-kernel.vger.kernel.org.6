Return-Path: <linux-kernel+bounces-302477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 464BB95FF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7668B21DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE46F9FE;
	Tue, 27 Aug 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgNTE95W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00670C133
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726142; cv=none; b=qevknPvj1ur/J6hdKF+4gvp2s9kf/4xy/3oJLceVZR6MTR1tt5+kCsEEUa54h5VU2OGkRTwmmJR+NlhbBJL7Bv6y+2eMBOG1HVpyvy6hEbZ/cInj1pgl3I3s+EnHyibLPeaJVNhZzqCBXQx8VEn35DQqGRs3zH9zIIrP6+36htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726142; c=relaxed/simple;
	bh=/x5LgCamELn3wH1QzCM/D9Nwp6D3CNGdJwAUbt0zpQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Td4oKJ9sjuT0ZXK4IKTLxZsbS9nnQhA2wWLv2pSKGORNEaNMSRNMydzhucF493oDUcz2sUCq4Ui8oovEmNV4ZfwDTp0AOVfYGLJZi9Hcrh2Q8g/BSnofENuxJH0hwx9OvJdtl+Xw4UpG3RlRSoqlJ7UhZ8xT75Gv5m8j+OFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgNTE95W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xdglMwBLWZ4kP9lr3xnFQZHeIzFDS9NqTN0/hvLSHM=;
	b=AgNTE95WHfKmHI+8QhImKGTM/87nv/VK0WjFIrxRPc2hgipsAVi9K4+c7UIC/zkINntLFx
	BtTGW5/71+vwAXXqJU+kziuq6furibX/o2ArlW7l/12uhXjFxCE0xQtAx3VXhLLf1PtuQO
	jgSE99K5NayWyjPUqKprLRr1X1Nj87I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-stM9ZvtiNtGqgjniJP_zlw-1; Mon, 26 Aug 2024 22:35:34 -0400
X-MC-Unique: stM9ZvtiNtGqgjniJP_zlw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d699beb78dso2539991a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726133; x=1725330933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xdglMwBLWZ4kP9lr3xnFQZHeIzFDS9NqTN0/hvLSHM=;
        b=mYZsdt0x/Y304TsUr6s0MFvyVR0ekrPI4NmETZdpkohpOH8bhiAtfdJyX/sj1mgnyj
         CXmrEAgBphMHOsuYAtareDX3FzmJS4vB/jxV4zyuiyhfIqzsLCxpfCjEVolGfkTtKFXH
         iH+Auv8tDDU1myGFnXMQDvuWOaOuoRMxZwEv2NnBMIEvRE5D1hAPG5Xr/taOHKNsrxRW
         YTUtRbl5mf7Kuvd5DUDu0Jm5I9tzfxHMMZprWxumv2dUS9VgDD57d+8fN7vmozHkgpdu
         iet76s9pwXY7EUt8aPYbQqCnYhHgNMuuZVyot7Kr/AKvQAnrpNKJu/N2+76yyxqVDwJf
         ZVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYSrP2XUFjzlfmoADTyIsINdaa8MMaNDRV86xuvlc6uoaJcYbnh+k+KPBZXJZxHtE43qWx7jOBIokwH9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IxZ0egJejA5WRWQff1K+nEYTkXqbjyGn9HgFJwcN3ZpfjObX
	YZ+ao7UAAyl4y1Aqczq4Nv97MPC8MLCqAc1NFSiTrsNS1IIsEOpuhaKK/O2Lq+68d8fOmDsajfX
	EJv1RbE7OFDe3KdzpQniiHQWyfjW3qZ9/2h/mRkU1fwF0X8LZUy4JzoCixiXRCjZF5mrygTW2Ug
	ZJK5j+RptPFtIcz2mhsubKcT1DqKmipn1kxOdwFfoF8YwyaUQmew==
X-Received: by 2002:a17:90a:db8a:b0:2cd:40ef:4764 with SMTP id 98e67ed59e1d1-2d8257f96d4mr1672253a91.17.1724726133155;
        Mon, 26 Aug 2024 19:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYF9StMo/SkY4g3hWHvXkzikeqB0QT1VCqIcA5eVMx6EG9JTEMeXtqvLAGtsuoCae1C6CIOLDyfGiu+eqWHeA=
X-Received: by 2002:a17:90a:db8a:b0:2cd:40ef:4764 with SMTP id
 98e67ed59e1d1-2d8257f96d4mr1672237a91.17.1724726132646; Mon, 26 Aug 2024
 19:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:35:19 +0800
Message-ID: <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> vhost removed the support for the kthread API. However, there are
> still situations where there is a request to use kthread.

I think we need some tweak here. For example, we need to mention that
the introduction of the vhost_taks introduce userspace noticeable
changes as the worker inherit attributes from the owner instead of the
kthreadd etc.

> In this RFC, the support of kthread is added back. Additionally,
> a module_param is added to identify which mode we are using,

It's probably not identified, it's more about if we need to "enforce"
the old behaviour.

> and
> a new UAPI is introduced to allow the userspace app to set the
> mode they want to use.
>
> Cindy Lu (7):
>   vhost: Add a new module_param for enable kthread
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_workers_free()
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add new UAPI to support changing Kthread mode
>
>  drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h      |   1 +
>  include/uapi/linux/vhost.h |   2 +
>  3 files changed, 235 insertions(+), 9 deletions(-)
>
> --
> 2.45.0
>


