Return-Path: <linux-kernel+bounces-432666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F89E4E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED7D1881B78
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0E1B2186;
	Thu,  5 Dec 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFZjeXB4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC35028C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383913; cv=none; b=aRqRZr0XLAlGC4zvUSaLrKdqXIHqb6ayGGAokZFioRro+AP/8ZhJ9r8rt/P2rg0gZF7ehKa/mxvdFjHGqHUHaYLvWuBMF8PM9OPsvpxszpLLgHcdB9XE8oRI14TmfWWWkb1EHR0fnzp5EveeLH+b5dXQF1oq8Xd4VNGKgS9Zjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383913; c=relaxed/simple;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYwvogM9K/ZTHuSx0H1KRHQr4V+j/QIgfXWxxqQ5IznRlbYN+O2TRdoz00ZOoP3xTaPnBOb9ZXhnmfO+VGtmTIvZACmuMX/aOCZC3MHinK1acu2haSzh32z4vA4i+sJT3ZctN/OVTEJrbV3kQPTVLBk4XHiHMaYOcWpcz9ygqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFZjeXB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	b=dFZjeXB4gYftJNRM2yFK9kmCKZBSfeKeOz8atk9TKmihyghO6h0cM6s2oRCLqtkiQNWTHX
	G9tsScV1UaLSfGxzsToHg+YbjXe0X97IL56QWGo9/fifoBMUPuPWXt4jR+iEiX1zB9O59y
	5sqIssxTP3Q9wZ1RbMePAb80OaJha00=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-BoPkscsfN2mkrjfCSpSlhg-1; Thu, 05 Dec 2024 02:31:50 -0500
X-MC-Unique: BoPkscsfN2mkrjfCSpSlhg-1
X-Mimecast-MFC-AGG-ID: BoPkscsfN2mkrjfCSpSlhg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee964e6a50so816407a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383909; x=1733988709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
        b=A2+T6nxYYcrrCl4BvVqAHBedez6J9RvdJUjGhc8IALSPaoXwR4x4eIAHmv5+4RKmIJ
         1sB96KeEA3QikagAmzGH7PCkVOLzVDWuybcnG7suRmbWBpwglGg1JU72IVP1T2uzIYn+
         GS2EYsGg+CqMrfi9lp7/ncwzLzjkrJuEjVzHaUzGD4AUki/4o5vNtJfwyih8XNYhOFsC
         N21vJaMJzhiJ01RY5Zn4J98wnFnovjdtRFyc2yr/vn4FJk8uCC3jArhjxPlHw9hnyJKs
         KP5R2oUEcIWu9joIicvymJzlyZp2qV1x/fQXLs3hchfgp9FZPWRVkrlBrJtw0fNicjL9
         843A==
X-Forwarded-Encrypted: i=1; AJvYcCWdjj10xJQ70QBX6yW4RPq9+nt1FHpATzvBo68mdoLbwS4NqIM3DIeuqokjMMN0bDZPRFO7+wHp+rMfZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5V33XhCCjcDOraOtXVvDhD4yIjc1NxyyoKNveI2FJJpbeDva
	IfygQu579gjzd16zg/EfKa54V8FHb71eHRQ+nG5rEf/8tRLNiSlwMqjVj91eNrdygXXA9ZF8YnK
	0XAS+VsmnkpeUHyyZx19SaeB3ktG4NaWFdkpVL7lbYHs2y+vG3QKLy29OMz0opt0nlBNIcJWoOu
	wNaC/5Wry0NWMu2Yeo0g/FrZYhCV+3pMNfniVq
X-Gm-Gg: ASbGncsu+4BSYZ5hl0A+tNlZ+ODC83ovZmKPOQ2jqvwUI/2dqGjugiYzhRuOQz2cgJn
	3zAaMD4u06Vs/5vYKt9bcMoo2Y5v8/gI6
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ef2f498ccamr5022352a91.18.1733383909073;
        Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGixH+V19QXJVTaRQQMS7yMn8u7saE4FALdvwG/htpjGLWE45l6MvTr9cB/l1hOZceUtfHA1KOmc6KCU2mMM4A=
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ef2f498ccamr5022336a91.18.1733383908747; Wed, 04 Dec 2024
 23:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-5-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:37 +0800
Message-ID: <CACGkMEsBKLkY5vRjWkP49LOOYmhY=Dw7U97xy0+xpL3-9Jnmiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when the recycle really occurs.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


