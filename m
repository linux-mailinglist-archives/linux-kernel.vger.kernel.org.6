Return-Path: <linux-kernel+bounces-537975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E48A49320
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25EB1704DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC3C2116EB;
	Fri, 28 Feb 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4DIBl66"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCE202C22
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730504; cv=none; b=ckoiX0JDKESygt9Cw93fcFhl/BZctRkU7S4qhlxmRW8nKmqAxy/+vL2X2nwmY3L9FnFdMhS+zrWDLs802dl17ZOMrH9RGAeDkAWLMC5CFz/XaMeifnIIHF6Ha6/BsdUF3zhv1HjG8GRTlnSFNVTEhLi443ZcAdnb400iaeIBRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730504; c=relaxed/simple;
	bh=i/awX897IKbbFPKU31yR0reOKho27xl7tHdkuuKPePw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW7IEUImAMVlJLT12dWtSZ7JhD5Dnv2dmLgr+bvIL2RPQAFpzPaP4KNjlNGJ+/OrK3QitPXFlKMOGMt10XsRdZJxDvth1GXYlrFevcey98NKt0x/mWuMNGyMOdYZEUFvuubrZJr/mvgRCTPQEpK2hNntqBpAn893VXiI4Ok4ZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4DIBl66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
	b=R4DIBl66kcWAN4HHATNQHPQXFkuSUZgAXFwtVCcKRgh7IyyEZxS6AKvxRmjfydOc7UxUrY
	qGu0qS+axEsE5Tu6XZD+GdIPuhWMzPQKQrRo7J6hdi+zzQSrBCKUwReLRL/5JtcG+vzusW
	ddrW9aTp48rgjEKotjdKm9dMjm0mudg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-OX_9k14TPDmJv8ObvGqQOA-1; Fri, 28 Feb 2025 03:14:58 -0500
X-MC-Unique: OX_9k14TPDmJv8ObvGqQOA-1
X-Mimecast-MFC-AGG-ID: OX_9k14TPDmJv8ObvGqQOA_1740730498
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so5243460a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730498; x=1741335298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVPNzs6ByW/HG56n5ZRSBScqeoqqOmHNsYho5zA17Ek=;
        b=Oao7DR8D1Uh/MQdx3BDjloVhboBFhclEKUB19BPhZGGpIWbPOQQxU/oaCjeFsEv1x8
         Flm7nIc3Ai8uzfWa5akp74qSP69Oa0ZVklFOzEtm6gO1GqlWuXooAJPd2z0aUAOBige2
         NtP/UyzrtVxecbPEfWbneXDEQBoySM5avwkMwzz35JN/d7/1ziLjDI+r8w9Ou6+MuZC/
         xPORuZ6gV/C23Yzp60LHXn7wfaKRjLcU/EIo5GkjhU/fGza4RENzPhhKUgd/h71SGmng
         GLd4lAhB8+QRkpS7oSl0QwGihVChN1TgbtwkyJNmEaLQS4agNwD3xXCFvA7Tklb1G/ZB
         gzhA==
X-Forwarded-Encrypted: i=1; AJvYcCWvl7+EnBIcbSRbTapPuf/+Cjicit0JaVTotxJSF5is3wzctZ1mjgvpT9ESczxvG2WjXMbhO1Rxev7UCYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXrMvYe3BwghQipRNy7Ht2nBDoDypXP3JiFDrlk5RXjE4l0/L
	Vq1KlcL+ErcqkHIResgbQSsbEKQ50MGxFPGpp/VqihBzkxVENEcFvdJKSTbr0v8kC7H4cZJlCRP
	q8eBKTf/Ss5XeAb/a63TqmruRrStSDB3NXYtvfSM8kuqBM45qcVPMSuFdY6qUS5u7bu6aV7spmO
	z9SWqdULvEQ7uMi0LGozpbxC/61NDlSac6hfXd
X-Gm-Gg: ASbGnctIUjKEy1841VvxYUW3vW6tWhaE5/s/Wc7fRWU0ouJxwT+gGNFbKQpkHzY+jXA
	P8KnGOl76uIswHsq05l8nTeZ6yKR/xd4/lQQGcK4e9ktWtWaC3+oV+Io/37p37gHK600obBH0MQ
	==
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2febabd9c6bmr3713394a91.26.1740730497705;
        Fri, 28 Feb 2025 00:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcn+x0GZCIknQ4zTQaIWwzNhdUzSiOqz72PNKBkKpuyU9ZwZnQPTZZgdJG8a4JcV4cazyA92Z/y0DGoohoCj0=
X-Received: by 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2febabd9c6bmr3713377a91.26.1740730497420; Fri, 28 Feb 2025
 00:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Feb 2025 16:14:46 +0800
X-Gm-Features: AQ5f1Jol8DOnnluZJdrms83ewIQuIWuNFxqYbgH6IOJBaoShyIqsVl50giYriC4
Message-ID: <CACGkMEus3m5M5ecA4u7irKd-N0p0=ZjnAPanLk-YJgoB6jhgBA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	mst@redhat.com, leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps. Note that the netif_queue_set_napi
> currently requires RTNL, so care must be taken to ensure RTNL is held on
> paths where this API might be reached.
>
> The paths in the driver where this API can be reached appear to be:
>
>   - ndo_open, ndo_close, which hold RTNL so no driver change is needed.
>   - rx_pause, rx_resume, tx_pause, tx_resume are reached either via
>     an ethtool ioctl or via XSK - neither path requires a driver change.
>   - power management paths (which call open and close), which have been
>     updated to hold/release RTNL.
>   - refill_work, which has been updated to hold RTNL.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


