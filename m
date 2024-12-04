Return-Path: <linux-kernel+bounces-430491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30129E3193
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EA8285B84
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4713A271;
	Wed,  4 Dec 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQqjHkCL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A376026
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280348; cv=none; b=cJNHwJK0PSGQhI5YODnsSV7HaVh5/bsPXSMgv83/J8a+zQk7Uv9OXOGRirOgM7iZnXvRJ69pNdwcQgmCAh5rrRzMPY7YEAduxAF6pQqxjB8adxS3c4loOEfDicaORhz7u27DgDBISv2abCuS84HRW1HpRXJB+r0dW1U6BUGmJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280348; c=relaxed/simple;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juM9Do+0GdWugDi6dCMOM0Zhft1X11LsycIXuN1PeY5vS3tVelRRSg3mDRvV2S4itrWYEFbVBptkmProUjbk2cZdDjdWobqNTz9N3pJGhsNf3ehgZGSCaAoZF0BY4tRFAiv13O1t5oGMRBqfv+ns1YAVtuCUQICJ03S009io0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQqjHkCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	b=VQqjHkCL+eMol8fCmMFHakcBqADUAsgwE+Kw3Kvt/kKMIj5FscXR7ZYnWT6z+EBRC2PQo6
	VMy0DQpIVaWASdbz4eXkd9IYQVdj5qpIJS5Et+4dlOHnK690aFtEd/iSEW0Qi7GZksHEFc
	4L2FBpBDUlZwAWJr4QdqJffNu2SBceY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-D9-xyYUlOCSt-k1TMIAuTA-1; Tue, 03 Dec 2024 21:45:42 -0500
X-MC-Unique: D9-xyYUlOCSt-k1TMIAuTA-1
X-Mimecast-MFC-AGG-ID: D9-xyYUlOCSt-k1TMIAuTA
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4af4c4f07aeso1746833137.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280342; x=1733885142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
        b=wgk1GscKbit5JC5Gi9u8d+u2yBICeo0zoL49EEV7aLQmzLcVNCqilj5cqM4zaT4qyy
         uuBo68rG2M0IhQ9VDQXLsouDWoFzakqMkp6Yfavw24F2LZl6CtQP+x2LdrjvXs7lfyoR
         0ok0MqG2k+hNcpVfBj9grEp4kyZ9RVW07MAsrJSujbA2xiy1FKTv26TxIRPubD3XW2x3
         WwpZYQbjrLNYNGYC4kSRCXQSFlG9ezT/ngnT131KrXyP7Wd09BCtIuyE+B5SsfZG+Ba/
         MLA3e0TszDJTHz4N978rXxsN3fEQmpzKtkP4dsP9nHSx/FLwPmd8sMKwyhvCE/aDf+yI
         dVew==
X-Forwarded-Encrypted: i=1; AJvYcCX+CgWTdI4klQNu+HSPbVCr0eGJ88qOaU0Itb/GsaemARCotvhugFIlPlAgKm5uQFRJDtAUyJDRoZokFkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1Achl0bpzriproLBMIRLIKMUZbuvtrU8tDovQAP7nBxfNnRG
	x+awUV/rCBg/G+FixI88c44Qx9NmjzMG8//ngfUwnV1ZUgE/XE0ar5WkODF4Lf+a+Rpf9LljsJO
	5iW5zc9msytwdrJ9xkX34KeWcIAKo9ryS0JDj4yTKsCa12+4MyZsaK+xia5Z3umkhcU+gi5Td9U
	hNTR6fDkvRinTY2IfUJBSfKlTDBiawhrQis7RG
X-Gm-Gg: ASbGncuXIupXA6nG2h9yRJsIll3XZmd2PcczZwtvKWuFtB6YMni7RiQRJGGynopeLS3
	pqQdHuhOZkRB7HuVd+kS4F4zkmob1W5e1
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id ada2fe7eead31-4af971b193emr6430656137.12.1733280342239;
        Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+v2rQ020MNSJM5uPbSBJm0D0/Db89xQqRoZNc5welU5BaKs9HJz5sd95RktgMEEi3m5Dwg3PuqbEbHeQzKSU=
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4af971b193emr6430646137.12.1733280341977; Tue, 03 Dec 2024
 18:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-4-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:45:29 +0800
Message-ID: <CACGkMEsd_fVOFcFGmW0g7DbD_G5cAudWuxc9LD9PNPm=HvNHQw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] virtio_net: add missing
 netdev_tx_reset_queue() to virtnet_tx_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:32=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
> be reset.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


