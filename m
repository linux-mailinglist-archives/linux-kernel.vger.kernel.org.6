Return-Path: <linux-kernel+bounces-538273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE5A4968C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185EC3B532D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2425DD02;
	Fri, 28 Feb 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvYIFSlt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9325DCE9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737078; cv=none; b=M/JiTu4mz3v+a0lW7nbwwFwXk9Czf7foXPlR7P7UlhnRShq6c9Ag3NTbZDELvwHqZufk8A5Pd+Hxy0OaEwtnAp9w39Jam6UHSQsORtDCu+CXzSBdPLvB8pT9Cds95rnN90CNUeDnDVtoVLfj18Qo0ilMFwIZAOaJRE0QVis0MJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737078; c=relaxed/simple;
	bh=UuKQE9PiNiWTjYawC0D2E2T+N47JBs6uLT6vnIJ4QQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO2cBYL8XGmcWe7K/spKoNLEoldpSKakTn7w8Amh3UhOBFlkr4JvNdkIuMSB3Qo+TAtjeDgvd25wUtmE5oojREtaqVx1c5IqpCXe6HhgqZVlee4M7AjwV9/reoiXLL9z7hzIqHY4Xu97qJaUgVD5eFp6gLrAWRzxHsvfQ7UPGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvYIFSlt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740737075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
	b=CvYIFSltlz6qm7tFBMRVXPG+soWXBWiyr1TgWfSwcpocU6Hs/6dF1Iwjg9k+Pj1IUkp4Og
	zSm9WzATRUn8VvP2EzU8yEJNt/T8xlzu3Z5r3YW8Ls859msd7y7VYI7g4RPuNDCVx6CVzi
	oXhL+6ouvdR6VEAR/+0A+RdpvW21vFM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-2LpCoVJhMrW-zGjnEAzKJw-1; Fri, 28 Feb 2025 05:04:32 -0500
X-MC-Unique: 2LpCoVJhMrW-zGjnEAzKJw-1
X-Mimecast-MFC-AGG-ID: 2LpCoVJhMrW-zGjnEAzKJw_1740737071
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so213618066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737071; x=1741341871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
        b=YzvmNhdbTmYtN49ZG+mbaNz5nNrZrSwUrOn4FteaEwHq5d3Pd0ggNDTjw0hsIShGnH
         o4gbX4il9TcCZdTo5kOw/f86x2Vyo0XSgElwK72Ipv+tzUby/LrT1wpDKXVA9Dvgoitt
         h+ltIxKy8K+oqbf/NI4+Kt7klcYDxO4isYoBQBH/ATtnxEPMpXdHzxgML94Fsz3LtmFu
         KaOrk60O0fwl8vQkSlJnMUkOKs5u2CPE+7RNjO9wVn14RNrDRZwKtPntVBGMFx4faRKn
         mo0vWGznpSBjJa6QYzO5ItAF7Eqb6l2WeZxCwdMicAHquAtJvIhJyPdkYi6M3DdX2NQe
         VJeg==
X-Forwarded-Encrypted: i=1; AJvYcCXyDsT6p4wzkHLfmIvqz6m+SN4g0mRiEvnnCBnCppgpby/QvywAvCCxvJBOw7+8O9+ax8SacB8HovznT4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWx18GMugVcoR7Y0Ub/9ixooI5zEKjtUWDQijG6DEycMYF4pq+
	l/EQxVU2NQOneriTw9lbcu7yj8mDZuwybUUPTA3NUkYoy3b0UIiQI0L+Cv/QgXgdT7pvvtOMjqw
	exbC+uBTvbGV+MnymIMCbtnAsi/jdjmxOrriFGMJZ2uThXLxofE/hGATrRaq+J4e+QsriQfqOmr
	OEHKarzfNM/kzN0hGOGJ3s9jiRBNyOR7+9ruC6
X-Gm-Gg: ASbGncu60dylC/H2x/JyS+Q55vNbdvYSJX0/A1IuyO+yr5lvW1idUI8X62tG44Krn6q
	2vcqWAKHL1FDEM0DLxAAJalB70RY7jAXbB4csn2FPkkrvRukROvS2ADdGNdbYTQUAjE7Dw/KAfw
	==
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id a640c23a62f3a-abf2682e053mr246636566b.48.1740737071116;
        Fri, 28 Feb 2025 02:04:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlP3JKJrSRB/JTuQ4dTL5H95aY/z5Nm2RXbOFZIVZJxtaPYIfL4JwvtC2IWGfuLodoaul4Om5m1WS3z/d2xWM=
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id
 a640c23a62f3a-abf2682e053mr246631866b.48.1740737070662; Fri, 28 Feb 2025
 02:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
In-Reply-To: <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 18:03:52 +0800
X-Gm-Features: AQ5f1JrhkprlWfBZR5KYsNgoMHpIaTrKPDWKrlUwM9FIxE_uaiyMqKH3Hp4X8Tg
Message-ID: <CAPpAL=zF3oFO3OSO793Hk0YQGh2PK7RsdjZ5bD19-EHFe_6CyA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	patchwork-bot+netdevbpf@kernel.org, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Feb 24, 2025 at 4:20=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Tue, 18 Feb 2025 10:39:08 +0800 you wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] virtio-net: tweak for better TX performance in NAPI mode
>     https://git.kernel.org/netdev/net-next/c/e13b6da7045f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


