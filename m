Return-Path: <linux-kernel+bounces-322688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635E972C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372B02874B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D016918785D;
	Tue, 10 Sep 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLo/Krce"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98228186619
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957492; cv=none; b=j6iD+fvLNInBwsOcUgev5RGqUvn18IAfeTHTYP7+aFYFdolTzDeAsrw7iNN57aFfreEtnFl/NU16Imn7SowtuylH6SGvbzYtOiMu8cqVYsaxJzn/GE9dGi/4QOw6+50o/+l0nXKT10pGI2HAuFDhLGwiAHt6as1zfVESnkOb9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957492; c=relaxed/simple;
	bh=fnaF8gPEpYkpUTRGXvaULlGO8r2Crx4Q3msbEnNHPu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D60SYoHlkFOQQmJYm9pHlhEsyUPRqlOgFb+Sx6rHLMYDqkPQJiF/9jeEUcOYQQlvey9ZfjVd/ByJtPAeWRSZ10brza7VGj0TIr1caG20Ry5VNfWH0oslWjIiA/hk1F0IRXjbavHAobam9mTT8L9azUkstE8Ur+zM/pZw9/574gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLo/Krce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725957487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iJUAv5Ry381p8aMkXZK0fv3mb0B6nXI7NKnzuhOuSM=;
	b=YLo/KrceosjAOaXKsI1hY33ltGSMj2kvKSwoBHznek+yuoq45TUsU7/1yVY9GH8+3qnK04
	dSoqmnOyIFsgFO7qqNh33xSdJFjXI/7Oow1E0cb8tv9gy3S+dIxngJaKNDhmy9zcaVaKlE
	9NBtN7hOKRedyoL3Cqi0cB23lGcZq2A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-dtfDsGCMP8moDxrCuI7jaw-1; Tue, 10 Sep 2024 04:38:05 -0400
X-MC-Unique: dtfDsGCMP8moDxrCuI7jaw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-206d8c47496so63014515ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957485; x=1726562285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iJUAv5Ry381p8aMkXZK0fv3mb0B6nXI7NKnzuhOuSM=;
        b=HqpJH6RjByKSQxqI4REEJAB3x7GjCAv9KvChHtUFB/J8y68aKhq5K5aE+Qx9UkivSQ
         55gkTJVSxi2/7rr8saGTFnUOTK/ZqrLxSkDKFr89IoDVj43+A4IFp0QbEJfONeMDwGXa
         5azMq9lIf+6zyry7MB/0cI9sNtlmDa9zTXQjzvLF8lKMKbVluhE49sGq5H03nZSu2KAi
         oNKR+tCZ+c7639ECcxEM966bbLpXodRWYyzv82Dtydr+q27FvmVIdxgMRDaBV8FmB/2N
         2MrHYtCYBOnbqsK/K1qi3AR4/dAavUTv3zYu2U73bOAG9w3j/i62eCbxYAavNjTVYowQ
         hfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRlKW8KhZTUX9SUewXW60F6becQxpolSke7q0xbAuVzW0ia+VHTUf6mwnurNsKub5pR8NtetmWIWNbrac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXJAzQ55fEA2rXJqFxCCpeavkCNr/W3YSz76QDOQVTR8qumN8
	6F9QFSW9MiP6Arh8wQm+FgrvtWsPbNddQEeCQlzP4/yiambQ6stQs8puYuEJio3Hm9+/UedRlJx
	Q+oWxD9BhZ1H52rvHdoA8Z8eRC8/OoBXHGv15PmcgQhRHKCPdUdLYMYG4AS4EF886HhKtiwXJq8
	QHXAgu7tZDawyUtf/7A0Kv3BQZGxq9v9HpE9WT
X-Received: by 2002:a17:902:d2c4:b0:207:73f:59f3 with SMTP id d9443c01a7336-207073f5b2fmr92474845ad.32.1725957484830;
        Tue, 10 Sep 2024 01:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN+6s0zW2d5Bv2RAV9dPFLl3+KMxshNJUww5Fv/MtwPDNl+ZxD7CVDUqQYQDp11tZQ2myblNXEAnVEStNtMNs=
X-Received: by 2002:a17:902:d2c4:b0:207:73f:59f3 with SMTP id
 d9443c01a7336-207073f5b2fmr92474615ad.32.1725957484166; Tue, 10 Sep 2024
 01:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910032825-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 16:37:52 +0800
Message-ID: <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > vhost removed the support for the kthread API. However, there are
> > still situations where there is a request to use kthread.
> > In this PATCH, the support of kthread is added back. Additionally,
> > a module_param is added to enforce which mode we are using, and
> > a new UAPI is introduced to allow the userspace app to set the
> > mode they want to use.
> >
> > Tested the user application with QEMU.
>
> Cindy, the APIs do not make sense, security does not make sense,
> and you are not describing the issue and the fix.
>
>
> The name should reflect what this does from userspace POV, not from
> kernel API POV.  kthread and task mode is not something that any users
> have any business even to consider.
>
>
> To help you out, some ideas:
>
> I think the issue is something like "vhost is now a child of the
> owner thread. While this makes sense from containerization
> POV, some old userspace is confused, as previously vhost not
> and so was allowed to steal cpu resources from outside the container."
>
> Now, what can be done? Given we already released a secure kernel,
> I am not inclined to revert it back to be insecure by default.

It depends on how we define "secure". There's plenty of users of
kthread and if I was not wrong, mike may still need to fix some bugs.


> But I'm fine with a modparam to allow userspace to get insecure
> behaviour.
>
>
> Now, a modparam is annoying in that it affects all userspace,
> and people might be running a mix of old and new userspace.
> So if we do that, we also want a flag that will get
> safe behaviour even if unsafe one is allowed.

I am not sure this can help. My understanding is that the flag is
sufficient. Otherwise the layered product needs to know if there's old
user space or new which seems to be a challenge.

Thanks

>
>
> Is this clear enough, or do I need to elaborate more?
>
> Thanks!
>
> > Cindy Lu (7):
> >   vhost: Add a new module_param for enable kthread
> >   vhost: Add kthread support in function vhost_worker_queue()
> >   vhost: Add kthread support in function vhost_workers_free()
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add kthread support in function vhost_worker_create
> >   vhost: Add new UAPI to support change to task mode
> >
> >  drivers/vhost/vhost.c      | 246 +++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h      |   1 +
> >  include/uapi/linux/vhost.h |   2 +
> >  3 files changed, 240 insertions(+), 9 deletions(-)
> >
> > --
> > 2.45.0
>


