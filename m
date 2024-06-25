Return-Path: <linux-kernel+bounces-228931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3039168CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BA61C223A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9F15ECE5;
	Tue, 25 Jun 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DF2Z4mkj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97E158D92
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322078; cv=none; b=LygIh4R5S0Xof2Zkx90XutoBqppREDhWQxO8ryJJ9gfNLmwRard8etEKbdjyxz6EMHOFhD3i82+20/30z34qgccS3kkH6nPkmK0uDotVzFrqGzAS1YowlXUcakn82V+5Z2zwoY24XZcZ5HIRECkuc9rOJKVNDDEbS3ljJ1d0sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322078; c=relaxed/simple;
	bh=VDhiq4KNiBoS2AQjFUE49v9WVdfGpN0CjOyhMLk+bHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIQJ0vuSHnJzotPNCT9gXUP88F1GsBi2Uluez4aLbnCzrzkcEXZA3CBJXnlAYB7Yt809WOaoVSZGpHOv1yncViacQ4SzDODthOlqFgOKnQiaEXKTUDa1OQR45CSbzdzQfUucgpoLQ+WKLUuGqEAHyh31C6uuMpgwwVzV2REbbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DF2Z4mkj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719322075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWNaNJGyLYRUd32/YEMK6ZqcA1e4JEXghqX1Hdqp4S0=;
	b=DF2Z4mkj3xliKScucktEIKbBB6EcG0hYyTmi/oZvFoVqDW+nS/jXQh2Z336TRStxEeW1ZA
	mE0MUxbZPjyS3YMB3AtopeVPRrOXERBEFZvQ65M/F/9WoaodPnzUAz3WvdQIL7kPMP3fNz
	6JkXPtisL+t6yaTyQTDbJUrEpjxOi2s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Z3RltR8jMA2XUxlzzxUDIA-1; Tue, 25 Jun 2024 09:27:54 -0400
X-MC-Unique: Z3RltR8jMA2XUxlzzxUDIA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7316658ccso7036189a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322073; x=1719926873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWNaNJGyLYRUd32/YEMK6ZqcA1e4JEXghqX1Hdqp4S0=;
        b=Pij0HvXaOggdYhyA31f3gmiY3x8Vhj2JDqDVB+SdNTfbwvnNobgRHAemuDubkNk3RC
         rRrAjeF49BQseugDhhO0Y+QcORUz2lONHXieUFLiv4VgmmNlMixnb0RlYtQkGz+Kf1WK
         ps6RBSvIq4/a8g4tuRNpkJcIAy+rBfF76avmsH0uqUc0olU+LdIZWPJ3rxayv3JyxWjk
         B01QeT97Yuh9zUXMcLH0GSZ8SKiDA4Erfb1apzVnHtseJBpnaPWaovIWkAoX/Sw1BmG3
         hPHA1TYO98im96UgQvxjVEgQ8j5sgMwVlrEHEbnT0Ls/XvDPWlX/qOlimAIL5naDHOnh
         Tw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtlWDYnVcMdm/Zmjq4Dvtoarrw453aBncz44aFHlU3LSpH5RZTcqtwQTUP1RhsDUncgHVKywRy3MS8iV6NXvJhL0zfG0pYPtZ2caR6
X-Gm-Message-State: AOJu0Yxd51bwsa0C6x5P11CHm+gRl4V2rsyhokEScB1ds3PsDSZB6Ty3
	mmdFCZykoEQNaku9vyu3JLoTzWTTBMeIXjNgPnKsHWDMC+RTQ2NDy9sIDgXWgIRhdLtNIS958MS
	HQyTggwpb1Kp/xRn77k1JTak7MFctvVeMEWfsr+ivx1HHrJz9psy2b9jbI82wGUDUTi9MtAhpuY
	eEKW42baUOL9r9HUYgzWClJi5cqQSGvf/6xPq4
X-Received: by 2002:a17:90a:fe13:b0:2c8:7b42:4c3a with SMTP id 98e67ed59e1d1-2c87b424cf9mr5965129a91.34.1719322072926;
        Tue, 25 Jun 2024 06:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Dc/ROCgQk4Q/6LPYJ19zTIY2OkwKpkqgD4u5LeZNq04M+vS++O678uip5eULLnNMLJPBWn2X76xfXUVx10M=
X-Received: by 2002:a17:90a:fe13:b0:2c8:7b42:4c3a with SMTP id
 98e67ed59e1d1-2c87b424cf9mr5965106a91.34.1719322072568; Tue, 25 Jun 2024
 06:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625082924.775877-1-chengcheng.luo@smartx.com>
In-Reply-To: <20240625082924.775877-1-chengcheng.luo@smartx.com>
From: Mike Pattrick <mkp@redhat.com>
Date: Tue, 25 Jun 2024 09:27:39 -0400
Message-ID: <CAHcdBH4vM5hptpwNuwpan8t+g-nCekwnEeY-Emr4aPkZxR5DSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add GSO UDP Offloading feature to OVS Internal Port
To: echken <chengcheng.luo@smartx.com>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:30=E2=80=AFAM echken <chengcheng.luo@smartx.com> =
wrote:
>
> The OVS internal port does not support UDP fragmentation offloading,
> resulting in large packets sent through the OVS internal port to OVS
> being prematurely fragmented. This increases the total number of packets
> processed in the path from the vport to the OVS bridge output port,
> affecting transmission efficiency.
>
> Signed-off-by: echken <chengcheng.luo@smartx.com>
> ---
>  net/openvswitch/vport-internal_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport=
-internal_dev.c
> index 74c88a6baa43..c5a72c4dc6fd 100644
> --- a/net/openvswitch/vport-internal_dev.c
> +++ b/net/openvswitch/vport-internal_dev.c
> @@ -110,7 +110,8 @@ static void do_setup(struct net_device *netdev)
>
>         netdev->features =3D NETIF_F_LLTX | NETIF_F_SG | NETIF_F_FRAGLIST=
 |
>                            NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
> -                          NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL;
> +                          NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL |
> +                          NETIF_F_GSO_UDP | NETIF_F_GSO_UDP_L4;

I'll try testing this out, but preliminarily, NETIF_F_GSO_SOFTWARE
already contains NETIF_F_GSO_UDP_L4.


Thanks,
Mike

>
>         netdev->vlan_features =3D netdev->features;
>         netdev->hw_enc_features =3D netdev->features;
> --
> 2.34.1
>
>


