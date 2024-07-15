Return-Path: <linux-kernel+bounces-251966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEE930C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EEFB20DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885E3D68;
	Mon, 15 Jul 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP4TaZFO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568905C99
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721005726; cv=none; b=ZBGmyLDkxJDtRo49r11h0Fg56WhthFVMoh+Q6goa4lBrPpmmUbGG099IRfwaQ+CXTCm94TCrMsEQcPGwiW1XTsXLWg14vH9DyCgF/1kFjasrw29lV5h1JaYexhaIGONd4u4H3ICgsURRku4zdb4Vjz3rWB+ubU1YdO3B31Tb49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721005726; c=relaxed/simple;
	bh=Pa5I0cVPLyu9hM+t7OcRoRA7sRLi4NugvS+t0stj8qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk04jt8NF4y1RR1sZDtVjEUPiA67/4NNPnqYyV9ZROixj9kztXmRQLv7a3xSBOhSIgyPi7EUi7QDwk9YmCPoexRlYEWQqP4DvZHW+cWj6RPPPGoM0D8DvEXI3e5lCiwMk+Vp09+VmvP55Hm7cqvfOqjyFbuPUMN4m4nHzKDB9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JP4TaZFO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721005723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
	b=JP4TaZFOkf0suF/tn3u7Xlp9fYeXmBec1E3oRoMssixB/Ew8+KA5r4kU2BtF5OFvUdTfsD
	e4Ll8pmNZISatmjKr95K+otxK0Qww5sqWTobIn09l3xOIAK0xqP4jzfokUy4x9fyS1Aj+p
	jt9FKHeOiSKod3icKkkIVILQTHqfIvs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-gU-8rlgpPOSMboFZjmx6_Q-1; Sun, 14 Jul 2024 21:08:40 -0400
X-MC-Unique: gU-8rlgpPOSMboFZjmx6_Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c9e5c4fdefso3790863a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 18:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721005719; x=1721610519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
        b=eCmsmzFsdRpszLtCYIVo4r02YWOcThKEiYVS8oCtfxb5iKmPbAS+8fWM1B20HsowtE
         Mk9T+FVL+b3YcHYL6pHN583DBRTW+8lJpICuVnKK9SNQ0EG+gHgyTyqPhUpHqJcJ5aM6
         Ktd5/GHVWMUT6aNgbs7tfdn+7fA+fNst8RxgXveQzo75IKphDISDdVs0nJmyNX2l7cwa
         vGCbw6sHxMXBSxRResOM6zIi3R5bgYvZa0SbbaBUVKSXX9dKeuGEOb6N8DzoU9lxzspN
         41c6ZpAoIkwQuXbffPZA+2S5QhXZ9+u6tQF5po0SIEIvuSDNjyQpHGNXJ2qq4GgfEq0C
         515w==
X-Forwarded-Encrypted: i=1; AJvYcCWUSGHMXhWiFc57ysV/02kz5nDLisjj5UlXSSA6B6CYoueTa4ICyuKYTjUwc3HZ5U3xQumaF3e3rfRXmzc3JJEYbyEc5VChT0KHl4eg
X-Gm-Message-State: AOJu0YyPFTkSaLHSr0Eff13FOYJmch1Ha1OYQWDx/nMw4ynq5bFcOp0F
	WF58M9wfg1veW3TtTkpyg5qVaiE48f7Tfu4Gi20gmghPdruTgy+HBoRKRmJPC8mADsq4r0MogjA
	nVupt3y6dGAS3VGhJIyHtpYMJv/LgifYmznqKNkihyVCnBlyoRZZDshxHoKeuvYjmc679x2Rykq
	heHEivbicclXmSuenEB2yifx3NKCxwH6A9BdjL
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2caee674e2cmr7215529a91.3.1721005719665;
        Sun, 14 Jul 2024 18:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfOYW4Dode62bRmQR3obF0rhuYSCpoHB6v8yaabskH3L/XYm5x+VvgWMx3soWzdSy10hWnKT2zpLzTYDaJWk=
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2caee674e2cmr7215499a91.3.1721005719219; Sun, 14 Jul 2024
 18:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712115325.54175-1-leitao@debian.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 09:08:28 +0800
Message-ID: <CACGkMEtDDCtF3FrjOppS=+Fmb1uHZborXn3biuRKV4iTwHmVaw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rbc@meta.com, horms@kernel.org, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:54=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
>
>          WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_=
put+0x82/0x4b0
>
>           __warn+0x12f/0x340
>           napi_skb_cache_put+0x82/0x4b0
>           napi_skb_cache_put+0x82/0x4b0
>           report_bug+0x165/0x370
>           handle_bug+0x3d/0x80
>           exc_invalid_op+0x1a/0x50
>           asm_exc_invalid_op+0x1a/0x20
>           __free_old_xmit+0x1c8/0x510
>           napi_skb_cache_put+0x82/0x4b0
>           __free_old_xmit+0x1c8/0x510
>           __free_old_xmit+0x1c8/0x510
>           __pfx___free_old_xmit+0x10/0x10
>
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
>
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
>
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


