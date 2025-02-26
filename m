Return-Path: <linux-kernel+bounces-533040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E7A45510
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91B617A84E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C3267B13;
	Wed, 26 Feb 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrrDmmf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456A25E45B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548985; cv=none; b=LllWC8JXVyVGBJ9dWJz37FExZ0ZJoUFHcJhFYxPRlRkc3VcA9El26ZDiS64q7h8u6diVXje/FXvYhpRazBxjQE/50jLatvro4uKKeZzDcNkOVr9+3igzkTJSW7viOb+CbzVZCJGK3xKh8mIUs+Icxrx2ql91o8gbETQwDOyNG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548985; c=relaxed/simple;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9e8QSICdruUkvI8Sfz2mELciBehjadkZBvuWBd21QVQAbk2izMbexx2tqsde2J1qsq9GGzvF7XH0rZEcIqP8QKOkrpgMdEHxuwHASDSEb6IzOrIMCgZZhmKDOnnUv88apm9iJ/DaPOgchEvSpLnoIJaWcOsoBlx6zbJoY9rpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsrrDmmf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	b=SsrrDmmfTXsIEORcLfhag9L7C3kdEbLDTVh2+AkRR+kShSzyUUOmNLN7xQErKyQw79aRot
	0XAfBeqi2DqwtE902EBkEDqVRMQAiiVUzFIvLHJR9KZh+lrGRWaq8y1LqIj61g3h6qSVvM
	I/J+OBEIFrJ5KyV1mdQAAW7s+Dr4PBA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-xW_nt_16M3OZdiegg1ILyQ-1; Wed, 26 Feb 2025 00:49:39 -0500
X-MC-Unique: xW_nt_16M3OZdiegg1ILyQ-1
X-Mimecast-MFC-AGG-ID: xW_nt_16M3OZdiegg1ILyQ_1740548978
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc46431885so21107856a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548978; x=1741153778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
        b=VMJlGY88wx7LfoHOkERsWw02ygSAW0ti8lzCVWsXbJHTaw9svYkl/u3x9YGQ2+t96M
         9VCSpMTT+MPmbTdIIwgQ9iPmpR8d045Gn1KBIZIdk9Ojy4B1w7BSTqR7HlneyypX+EuA
         vTiyDefMYLU4MJwmIRnwkuAYjnG55PpL+9o4WGhij34W6bA1BwEfviM6ibn4AtcQofFU
         78lft67cxbJNMz8sbHHoX09UcMk0I8i11TCs0PJJzG+qFyyoGNxVdp0skInUSxJ+vlqZ
         z1uZtVizXZbNtxvsQPz85sJ0SzQNMTUrgYeOgr6RW1B67ruz6dKn7HV1aNZtKPlw/LUk
         sL+g==
X-Forwarded-Encrypted: i=1; AJvYcCV2sWNHQ3H5X2vZf9pg+lPVQvpzNLqy2U9mb8+lzQT5bR+yAOGTscXsh7M+Kwh9P8SWfrQaoFovjrmtROY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+9coiQqItRPLytQwblGLltkSf18ELTdjolJt88DpAYXhYK/x
	dgn54x6eUmD4d9ChothXAaPvlhCm4QS0kzDaylqrl2nlQKLcXoTv/9/EZxtX4odwfw6w8nX5mRj
	gefj0EGR9H3D+fMQnbZROutChZl8LY04zXIbi/JkY74Vhn9YimQ32T5iZPYE4PEJCnxAXSHOD1v
	RDbi4PyMGE/ANd8nLm1aqHiKS+EBBNFcnQpeWe
X-Gm-Gg: ASbGncvLakKfgh9c9NGyQHfC6+VYvK+EoatOoHObZA/qOdTbK39CRdOWNGt5b0RceUI
	Gsoxf9hG1/A7U8ZXZtT6Uw2c2uFHEqOM20D8deBiwQ6hcUEM52O9skZVYZAiM1+4+2VVlOo9liQ
	==
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id 98e67ed59e1d1-2fce8724390mr34443313a91.24.1740548978081;
        Tue, 25 Feb 2025 21:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOC9QXoxJuOHEjlx+qZRYQH6fSlrUiM3+fVaJpf6dIZ4d2WAtWScZFMkzacVSmHtSzRdR+wj6Eo8xT/JNNSFc=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2fce8724390mr34443288a91.24.1740548977777; Tue, 25 Feb 2025
 21:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-3-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-3-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:49:25 +0800
X-Gm-Features: AWEUYZmvhQtj62SIihRDJMGEYtSPUe20LIQv6rcQ21elME2iuLu9IMnansJ-eGg
Message-ID: <CACGkMEsfSqE30m1oq14h_=VNavf+OVHmqW5aptEGBNumf4ALjA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] virtio-net: Refactor napi_disable paths
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
> to take a struct send_queue.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


