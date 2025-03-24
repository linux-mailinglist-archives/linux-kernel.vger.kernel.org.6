Return-Path: <linux-kernel+bounces-573855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0579AA6DD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C91F188C236
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C8725F988;
	Mon, 24 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaGgcwNg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2010F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827160; cv=none; b=BKey3QiaEs2QwYUwnRscmGe6vXX1sF7P7bzTTml0wyLn2NJHiVUPMmn6nP9RNaJVxmddRQwygCdk7nkgDtYniGm2LeGXJtxsQHHk0tgj+0afYttRTbhnk+y3wz9hJ8VNE5y28uH2fO1Jwuaa3okre5n4UxnwztNmEDvi94lBPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827160; c=relaxed/simple;
	bh=nTliLNqMZBbrK6UBfCB5qUOnQ701+cm9BjDjoUn7wrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw8yWXorTaFSSxW7m6dL0Vby8CfPBfbwODIgFGRVBeK1oTvO6HdBchVD+ziglkX53zEfi7oJXX+Vgb/vMyovmcteeBDghm8tRL0pkD67iUaHWxRdAj35Jym/Lh2jcD8O8L1rETBB+FqPyW8lOjR8ocN+5RkLOjFPyYIcMOs+yBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaGgcwNg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
	b=LaGgcwNgzDnPFuCxmGvN85esBcy4QKnDCvyIYLTR/aOFj1wTKfwL10mCfBFYWJQ9y5lIZ8
	oKdIBctUPm2ER2BFUvSQyyFFY7eQ6N5dYxxEJ8VFXSFnBAcbK3946o5uHlKjZlagqoAPJP
	BE1I2jOxi+WnDmWuDvJEDDyITStRMwE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-R9tLUOifMMm7Vd9QLYB2SQ-1; Mon, 24 Mar 2025 10:39:09 -0400
X-MC-Unique: R9tLUOifMMm7Vd9QLYB2SQ-1
X-Mimecast-MFC-AGG-ID: R9tLUOifMMm7Vd9QLYB2SQ_1742827148
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5c03580aaso3506149a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827148; x=1743431948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
        b=E98ZldbP+GyjZLMWNL5sPsPTZl/8fsW3Py6DiUpBGOsdK2pmQgKDHtbsMyv4+/L2hZ
         C46R8I2aK0PfhRDF2EIDVE5cI5IogTkuTMYgdOfjSfcIzI5uhEg+hMqo04sM7P/NNbLY
         Km1WjNKQswzrZl4cW5VcEhKNTICuXC5PP9QihF5Rq5s+istT+/vhCMDojBtwi0mQ6fmQ
         NdYivJLwkxLGlzvQcRoYiZbz+pIbhK2xy2q6tHA1QZ/dQvEZwZkoh8ccLYcREinINb7u
         Le67700famy+dUuaOXuq9HNaX7iCvKLGurEJQ9dX47NtOZ0YxohLWX/WmbV9iHv1esYW
         BpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6P2PrlXOTRBNL24GJTyM+S8KLlDJ+3FkxQx2y8maFDzLDTsC9YCaBxCWMbL+M4NzuLVrrDiCufftzuEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmPu/3LtqBTu3wrUbakS8YFykmYyORPalJSianFw48bvtjVW+
	Mljc2Mzmmtzv0IPAv88t5uSt89SX+6T2JW0dgBqHoztjmKPY7NbPLC5+cbwOkTRQsmfDVQy9gOV
	AU1Gu5ayAwl1JkoIfNgRFX/Lfo6S5NM90cwBveojBjYAj7SRXKglBeUReqgFZytmusFFRMNh3uI
	AbKCSvhEUmisE1ycaXgyt/HOC4u3aa+GhmDVl/
X-Gm-Gg: ASbGnctA+HB4TEKd3WSzNmfIFolCJAVvYXVNGcIa936gLQ7CosYYnaUtRTAVbnFyc8C
	ouVNslBHQ3mMr7YD2LPe1nl02Ze4M6isSyiyz022+nJi8bqxZePZEFnJF8uQHPQWTjV/mQpJc/A
	==
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id 4fb4d7f45d1cf-5ebcd51c105mr10515827a12.32.1742827147951;
        Mon, 24 Mar 2025 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9DKx6B3C9S8Xr5iUK6i6jAmqu93CsYREN/zAlEYF/Sj4+lRsLtO/S8UYF8aFRkQ36lLETXWAjFegsoIHGZa8=
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id
 4fb4d7f45d1cf-5ebcd51c105mr10515798a12.32.1742827147499; Mon, 24 Mar 2025
 07:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321142648-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250321142648-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:38:30 +0800
X-Gm-Features: AQ5f1JrTYgZzgkgv85az98_SpxBT46ja6zriWYT-n8Fbp7M8MZtf2vAwTdHHOlk
Message-ID: <CAPpAL=w1BRdeEKnPa2Gxgq7F_xcyieOSms1tFXETUpzE3An4sg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches v2 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Mar 22, 2025 at 2:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> > Jason Wang recently proposed an improvement to struct
> > virtio_net_rss_config:
> > https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_=
vo-KdP9A@mail.gmail.com
> >
> > This patch series implements it and also fixes a few minor bugs I found
> > when writing patches.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> > Changes in v2:
> > - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> > - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336d=
dd@daynix.com
> >
> > ---
> > Akihiko Odaki (4):
> >       virtio_net: Split struct virtio_net_rss_config
> >       virtio_net: Fix endian with virtio_net_ctrl_rss
> >       virtio_net: Use new RSS config structs
> >       virtio_net: Allocate rss_hdr with devres
> >
> >  drivers/net/virtio_net.c        | 119 +++++++++++++++-----------------=
--------
> >  include/uapi/linux/virtio_net.h |  13 +++++
> >  2 files changed, 56 insertions(+), 76 deletions(-)
> > ---
> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> > change-id: 20250318-virtio-6559d69187db
> >
> > Best regards,
> > --
> > Akihiko Odaki <akihiko.odaki@daynix.com>
>


