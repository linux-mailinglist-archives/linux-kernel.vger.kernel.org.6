Return-Path: <linux-kernel+bounces-430488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E149E3189
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E21682A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684813A409;
	Wed,  4 Dec 2024 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVyMHb86"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42411537E5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280309; cv=none; b=kYV4zRWXUBmgWO4yoCvjA5OOlark1/Nu/omfobskaVV273B9YMm6gdRJNajZudlQ9Khs/QeadboxsBVezJKRiqOACaQJrfskc9tFZqJJdrGjWm0eOuWSIKuGtw0xvyeElVcwUNuvl2sfFvu8lDW/j+Alt3KTp5r4Qh/pC9DcYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280309; c=relaxed/simple;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJanI4t3F8xlbisj33M0y+7daoFBHEkBIBx9ES9FpGJYNszVA2Dz3dhHnibRfRu2WqyKJXymJd96zLLpdRnrr8orMyMSdYnqpG3B5NG63fEw7XwhBhZUIIY2R4bd4cpJJG3jIcqX7o5dfiXhRsjVe0uClx9xqMMlgLJoUJC5GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVyMHb86; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
	b=bVyMHb86puUYx2QRKQAD5W6hVOmByQITnkJsMbt820NT9xMwRO3g1OhdhxgyCqvpRV4GAF
	iUqYLwJQ3Q26noP7MLH9J8qpsquNS9XX3L7WQi39DJX/GiVRAY1VJ62oTbwDZxNk/8eScP
	3hdoqj5NjfSaM9116ilGD9dWYXbd61w=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-O2aVT0VKOeKyq9El8-GVrw-1; Tue, 03 Dec 2024 21:45:04 -0500
X-MC-Unique: O2aVT0VKOeKyq9El8-GVrw-1
X-Mimecast-MFC-AGG-ID: O2aVT0VKOeKyq9El8-GVrw
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-85bac636b2eso549001241.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280303; x=1733885103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbnQOq3MesemtOcTeCYxeKP2DW43Br9wh3sOMpJ7Mmo=;
        b=KWTygFVoCt+QkXXsZXAItcTgkbDrdvgcMzlijY7nwwT8r7ldVPoUVGGpeGMy27L9FG
         ObPN52oB47r4QjifGpx4GSSx7Aumvar7sHVeAF+5B606j7/HjvDcQgY/l5TTY6j2hW0/
         ItK7FiS7BpEUlA0h6E+uMnEjwVMYEzjz1bESJCA4HKewrRN8ud1PZxy3iNzLlkkSauLC
         VH3/DUZR20+vneexRsqWNNFqdMmfJoRTGx/Xbo/j5AcslGvdmV29Wgl17y3bpNXQqs3K
         GOw26j3/hPtbPpB4GLF5j1eOCt47zab4eZtd6iBBL7C1KC4tbV9y3KmObYMNrK3p/+Fa
         wpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+L+fkG9X/vulDs311FGvLrCpHndoXO1FYflAVJhw9asAZ5yfpZ6m8/n2YVyZhHYMJJSIvaafNuBSUucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYBXO23JK8CbYkycZaDrUb9UKPqbeDCUS25HCJ/6Pa990/Lb0
	nv8n90i8qyfyQ0Q5MpRvQo14hGhFfRk/+kxlLKO2ucJ68JhFGlhpwxGXPOJv9WvnQRXzq5/f95e
	3iT29TLplnwluuCZb3BxCT2YrBAwWZOitB7pqHoXb+s0/ajyP/8r1ztr89PqLD/25nOJGIoZEId
	LDRMHpFPPzAzRTt43lsPNT4RURvWv2N168wpbf
X-Gm-Gg: ASbGncsriqnokvAJwiF7+RQkqpq6KMvo4zrJEddI+huLHntBbUawX/sK9fP5mJmR6dR
	WF0h2inFZRgnnJbfPXOPnHRbS0rPjAANS
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id ada2fe7eead31-4afaaa51842mr2184615137.10.1733280303454;
        Tue, 03 Dec 2024 18:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnv582pmJNRSCddpQRIMLUIrhRF1VM316y4CUO+jOhzMa7TrksbE6s7FhVZ/bBvYjjr0SiWjodQSlPoQUf1dM=
X-Received: by 2002:a05:6102:5489:b0:4af:aaa4:dd9a with SMTP id
 ada2fe7eead31-4afaaa51842mr2184605137.10.1733280303130; Tue, 03 Dec 2024
 18:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-3-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:44:50 +0800
Message-ID: <CACGkMEu=zjbnyLGLESsSUx_J_KkcKHYo2dBDuQ_evvkOuJ=bEw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


