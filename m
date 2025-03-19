Return-Path: <linux-kernel+bounces-567172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D546A682D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07353BFF04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0624EABE;
	Wed, 19 Mar 2025 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfdktLqD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082724EF6B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348606; cv=none; b=uoU4+B7Xc6Vm6/SLr7qfLkurvA+uKCDXc7ZaN+v6PqtdMGkFNhFCPjxx5LXlAtGGew0qD5fofVFDyt1jlGgYWrZHuIj7naNWjfoqSrCkHP1WQM8a9k4us9Qe5Z9++uAF1Am2ZgfrtI7/CiBYOWwKwQif0EoTOamCfsfagYYumOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348606; c=relaxed/simple;
	bh=vMQ1NxGAapHE6NnLtNfhVr4o56PmQKO6ToRg9ogrVb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrVYBB6HuOf1P5/7LfhRmXr0TJ2tF4qTUCGMGHuiHuRTfacghxxQ1NsXqv8x5t2AVbc5AwQekPhWmzYUxUuYk7gisZxC7HKXYCGR/03vDBa9SyEaTTaLyZ1UsCmt0+y+RSiIiNESPRnTh12CK/H6llK/FrYLJRA+z7euJ1FpqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfdktLqD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
	b=JfdktLqDrSRI/5asH9v5Al0duVuB1FV21MF07iyMZqA+hJG7qpvpr5OFEh+ZL3+PCiUsV+
	FNFpZ3L5zd+vQzPKXedR91+HcZgJHmnJwIXBnp9Sr1SqUi09mNNmPzeytQ17skYd5xY2CJ
	QPp5qAzkpg3XMotBzyKu4kGcwzvRVI4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-XvU840_QMYC5pID3F5jp7g-1; Tue, 18 Mar 2025 21:43:22 -0400
X-MC-Unique: XvU840_QMYC5pID3F5jp7g-1
X-Mimecast-MFC-AGG-ID: XvU840_QMYC5pID3F5jp7g_1742348601
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so4309116a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348601; x=1742953401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
        b=wMJrG7o34l7JEAzQZtRIIxgETcekH7fT45DXy4+Tuw/TM7l5BtscL/iQH48zjOVekF
         9nGdYIwMurvWnaZXnLIEHQDhILqtMjU0Jjj3nacTpBiKAFu3oe8IPzr6FDafEqKvfAUa
         wJ/KHF/H2BITBUGmb9i1VU7080YAPu0Zm6EDXpWSh44KVrhHzKJq12SsGcDpDYJd+cfn
         qomwAqZyc+knzH7562yLcG1Ga/job0PlIx00UqaPxAGEBtsYqq4OucTD8CKZQsq0DdU2
         fhc832rFJxpkXN5i3nHumgQfiYioPpVwuPFSCB8uCAofufeRBVpeNHktFdd2ODJD96Cy
         Zw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBup34y+Ryi2lpaGU3aUwBDBdgZ2xwCrqE/J5ZR4ARWG0WXh930xqRjCTSV/Xbx01uVArGp38pBEdkpGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wyZEHVGDoLktg1ga6UWRHktcHP9vDZm8WjA8Rzg6jFH6dYLo
	ussk12tJJ7yNbEnUG8cXTS4T2urHpKhYBuTrU0hdbVDTv9OOeApoqum9fY27Gaf8OM09hmfLdJq
	Rs1n6w8XiEknE+ydbo7RBw00z3w452sEgZTw3v0jFXlJG5PK8jvPVG5fGqvLFsJY//GKBxVtPgh
	QK14hkwDstYSanLfnhKmaqhC3mltoIHm9wM4L4
X-Gm-Gg: ASbGncvQPCUwWfP8zMeaRsvYG73jyWmSk8PRWgXXrOpUDrtc6yitRthERuD/WXhhER2
	Eb7YRujJC0gbPyME9xBBYwqvaWG+KluBSj2dlUzJX9s/vdNn5s7wmurdGZgnNQKMHBU9b454N
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-301be206e87mr990216a91.34.1742348601137;
        Tue, 18 Mar 2025 18:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0++cP7CuHsJuA4ykUqEhaO0hgo1XA+wkh7+TJ3CNVMbX8Xf+ByWZl4BacAg74fMOEy0eBKEoJ6izk1WeYfSI=
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id
 98e67ed59e1d1-301be206e87mr990190a91.34.1742348600818; Tue, 18 Mar 2025
 18:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-4-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:07 +0800
X-Gm-Features: AQ5f1JpzmBMSEro2nh12X2DCr43bIWbmp32ijo_MawALr8QoNkwJtaJ_yge_7wo
Message-ID: <CACGkMEvt5A00kvw6=O5Q2qW2vbbzAnFBpUmcBVwSPJr0i9xmpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtnet_probe() lacks the code to free rss_hdr in its error path.
> Allocate rss_hdr with devres so that it will be automatically freed.
>
> Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table s=
ize")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


