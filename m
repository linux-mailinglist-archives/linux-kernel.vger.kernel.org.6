Return-Path: <linux-kernel+bounces-573860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C52A6DD43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A25E16ABD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04F25FA1D;
	Mon, 24 Mar 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxymWdE5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A125D910
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827444; cv=none; b=nDzMJzdJuU3tFhcLIqdUufYZnRj5pv4mlfndCN8uOQzjsa92cj32AfS9dwq9rJAey+uaaxXWs0IGuujco97ZWdaztnmlFxD3N9jAkDiECz3b/mbCvNTwhk3mZfPr/iDUFauKinYPjHrbLXjaB4tiwQMzllpcDe7O9Y8Bwo+Ymfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827444; c=relaxed/simple;
	bh=kWGmO5Fe9n1QZBql/9XX3gMxWfQD39pTNi6RUSi7VkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjhPSzlApJu21gvVIZJ5CXxHGUuz9gBqh41KbcVVqyVw5cDKZ6lBiEUtiblUz4v40rcgknMWi428bxaqZXpZTqNNXvAx81wZkXpDeD0bJijgBvs8/6cZe+jvwLyFdfb3FvrBPgRVZYWxxp3rXOtRsFKqBs3Z8AZJ0LFJEovDkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxymWdE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKtNS87VKI3qBZ7UZtNdNXHh6kQ26WV+OsLcli3oRo0=;
	b=OxymWdE5WcdyaLTDP0ktVpL6YbqR6U6hPCU8if3Kyki/6KTz0d3CZTB288ZVPD8/U7Y1su
	s2IoSrhOQTwCHkgHkGSbHpxOTeA/xPu881WqygbAb/9F6lccDnHePYszYPItzbxJZJQbzP
	3Id5ymF64uFXBvLTd791N+3xsQZj05w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-puyiZAEqNTeBU3JlbTy6Bg-1; Mon, 24 Mar 2025 10:44:00 -0400
X-MC-Unique: puyiZAEqNTeBU3JlbTy6Bg-1
X-Mimecast-MFC-AGG-ID: puyiZAEqNTeBU3JlbTy6Bg_1742827439
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso344749066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827438; x=1743432238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKtNS87VKI3qBZ7UZtNdNXHh6kQ26WV+OsLcli3oRo0=;
        b=nlhi7q+9uLCNLVPF/mu1EjbkfXHCx5+qQDs3nB5ZcxQU4nVZ3CB3Rzm5wqjvVuXxyv
         CRl8JgRKc9NhuKaQbrmGTRsNdCAQHoB6NeiQslBwzY+nTnd46FSIJ2AZEC0FDHB7kWoN
         nj+s2feajNUJlXNXxCaExcrFHzaAAccdvzfL+9EW972bHlDME9CQ16arvAG35/jxpja0
         kZ/U24wZLToYHjYjkdqcSQxut7aV0ht1oB25wjEyRDKV/TdWiO2yZK4GDF/OEz0WH3L0
         XTI79Z3bdzcXM+MVc+tuceKVtQLcSLRQTC52q2wUiFIA++JGLa9/Xs6WFpz6rJZoX6c0
         HBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/CbyeSGa/XcR8Fiw1H+iX/w/97xcrS0wQdKk4EhnjUBHx5jW5Mxn0dor3F763NqyTu82nDzA1mfOZ2TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/RVtwzf2dk78zmuVGuc0M3OriwwQYq9nSaaoFt7KDHDmBKi5
	Gen1PEWcODO5MmwxJFUD2hZo6jjJ0AU6fEouC0FWc1Ue5H+WqmeMKUNOtjbXKwy2wGA6qLQo3Ja
	BKTykYpW92cp8vvcNkVcTOiuNiWTWB0+rijLVj5MjEtjiRxgbgwcVUzG62XT1VgAwSuQtrEj5ZQ
	qKkQvgWPhy040jXqggBvt7WcrdlKbprAzCL5se0d2D+2z8qyAmcw==
X-Gm-Gg: ASbGnctyst5zrynJlu+gDYvFXh01mLeUsg7DymNSqamyzvT0TiWPuyH+dW3JoJxVgRS
	yc6zRdvvee3XB15QVE5q3Q5O82KMquVoou3IqEvYDOauwJl/jbGi9GxY5PEKIY367kGgGN6YZrw
	==
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id a640c23a62f3a-ac3f20d30dbmr1419332466b.8.1742827438444;
        Mon, 24 Mar 2025 07:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZAeQO5AXXjuoyLKgLAtV81kTmhy/K3XnGUy84KHZoby/SQototvIvcST30HTNJ8fj33AYAC+idf9EUDSDIY8=
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac3f20d30dbmr1419328866b.8.1742827438007; Mon, 24 Mar 2025
 07:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:43:20 +0800
X-Gm-Features: AQ5f1JrXfkHTzuma5AqSaSU6COxpwVpHkbBrjXnrgtbUVryJALh0TzOw4CmentQ
Message-ID: <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implmeented on top.
>
> Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> host.
>
> Please review.
>
> Thanks
>
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: move next_avail_idx to vring_virtqueue
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
>  1 file changed, 653 insertions(+), 203 deletions(-)
>
> --
> 2.42.0
>
>


