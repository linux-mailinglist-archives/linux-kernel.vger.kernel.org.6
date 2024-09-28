Return-Path: <linux-kernel+bounces-342430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C5988EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4031F219FE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311618595E;
	Sat, 28 Sep 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMDsb1F2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6A15DBC1
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727519476; cv=none; b=lV/cf0ymCor5dhnaKkZYqO+cFp4Wwp5nYNUzPfI49HOwEXc3GpQ8fzVSSWHSP+Je1UyRtb2+01eppE3prWo6ddDk6I2d2/nmOz5zP5lxGY5CT1+Tfq+6vulSAisvRqR/Ez6fUQKejCQMe+2pLK4Pgfn8wA3OPBtz4NCcN9wU/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727519476; c=relaxed/simple;
	bh=dDHrR22WmXcK1oZRFZfxwGP+7kFIwDMTIs076q/6V4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTsiEUzrz/SgSDMluE8K1wu3kXwa2A7pLsgJ1NjyjvkzZ6EiYv0Zz+f8ilJ7i4TACkWxeu/HXYf6UjW6C2O50kVYr51+HSJYZy2bCiE+gG/sTU+t+V3uiOQSy6qfKi26qsK0E7VQSq1wn/4VWmEt+0PetzDjcRbaawZOO0WP/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMDsb1F2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso3940126a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727519473; x=1728124273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEisC0iRnLOpREGpVd6A93qrY+F/ucLTNFfZyjxhWMA=;
        b=vMDsb1F2KdnOU0GIFE6G40oidLvkWLu/7WfqJFM2ZkWml30mg60h4CTPDlO+Sby9TY
         YWRxCPE9CfMUdmY7eSKprGBhLGd8pVgGV65Jz48FKqjt2lMxmZt9QJuQN7ODKhe+rn/u
         Vw0jfzB9pSH9P8Ey7wkvm1KHUj+HEckQxRrV7YrrxK8mlIJD0oiL05hHz8wh+WfOVsdH
         98UBwHWqhVa4Yi+n8lsthdYxsGDUl4iZR94ifDyZ8qvb9CjPVwX3pmTi2gSOYoGkpVPT
         FHU0T/S2oHQBA7e5RYw+JrZpt+xqQP/S2lCIr9Jhu+8vm1HhugY8iusUbUw5MU4/mUWl
         zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727519473; x=1728124273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEisC0iRnLOpREGpVd6A93qrY+F/ucLTNFfZyjxhWMA=;
        b=pUdjSb8b265yzPR1LNzY8Osj5ehi+zS59aGdnqHY+J2NhRHI4MPRoAt/n2B3jXaOLG
         x+/4buA61GqclwqilXMIG0IlYmSTZX1UeJFckfSvAWVmCRqhmkLpYos1xcpNs1bA2D1x
         gkpDBizRjNCKduKAPgaC+a9nAtHuGKqAqtiqbrUP95oqZyHcIrEH8dzZ+pcdRrNB35wK
         k87J3j+ko+Pni4eQHHBcdYzhKPgeuPL9kgJH5BojzSCsaSPKO393WKGh3z4zZl6ozAbQ
         2KbdFTTOI2Uq1A1XirB1VY8vnQJoGuKtJB8GX3aJ8gz+lUWtj9U3e8ZlvgVgqp2bp4fg
         /Fcw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zrLUgI9+RK+KSqIakjXvIYFQshl7AYhIt1kKHywkKfHfE1FWsOEDmuGO773Tlc127QdKinL4OXTqFjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jJpUT2yao60mstx+iZzf8XnjqVA3RYxmswEC3ld1pRYEFG+v
	50Exst77DXQCtRf97HezZo2qnRXgU2vy3SDZ+/i/6LEM2sI9mulJ7mlrhI6ivDCFNMB6TSuby0U
	fDhnvVJhCMMlohMk+czF9QnNyZbEgWD9xPFHR
X-Google-Smtp-Source: AGHT+IGs8s4/clyDBjxyWsfXBD07dUrX3uXFq6NNpNNKcODLAYZn3PgCmyDCXjPgjKTL4lCpqXExfBmGtguaX51yLAk=
X-Received: by 2002:a05:6402:42c2:b0:5be:caf6:9dc7 with SMTP id
 4fb4d7f45d1cf-5c8825fd2dbmr5517804a12.25.1727519472268; Sat, 28 Sep 2024
 03:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Sep 2024 12:30:58 +0200
Message-ID: <CANn89iJb_ftSAE1vNCjtEvt-XBjXUy6DymLbxc+WOJELrk7+nQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Suman Ghosh <sumang@marvell.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:53=E2=80=AFAM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Regression Description:
>
> Depending on the options specified for the GRE tunnel device, small
> packets may be dropped. This occurs because the pskb_network_may_pull
> function fails due to the packet's insufficient length.
>
> For example, if only the okey option is specified for the tunnel device,
> original (before encapsulation) packets smaller than 28 bytes (including
> the IPv4 header) will be dropped. This happens because the required
> length is calculated relative to the network header, not the skb->head.
>
> Here is how the required length is computed and checked:
>
> * The pull_len variable is set to 28 bytes, consisting of:
>   * IPv4 header: 20 bytes
>   * GRE header with Key field: 8 bytes
>
> * The pskb_network_may_pull function adds the network offset, shifting
> the checkable space further to the beginning of the network header and
> extending it to the beginning of the packet. As a result, the end of
> the checkable space occurs beyond the actual end of the packet.
>
> Instead of ensuring that 28 bytes are present in skb->head, the function
> is requesting these 28 bytes starting from the network header. For small
> packets, this requested length exceeds the actual packet size, causing
> the check to fail and the packets to be dropped.
>
> This issue affects both locally originated and forwarded packets in
> DMVPN-like setups.
>
> How to reproduce (for local originated packets):
>
>   ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
>           local <your-ip> remote 0.0.0.0
>
>   ip link set mtu 1400 dev gre1
>   ip link set up dev gre1
>   ip address add 192.168.13.1/24 dev gre1
>   ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
>   ping -s 1374 -c 10 192.168.13.2
>   tcpdump -vni gre1
>   tcpdump -vni <your-ext-iface> 'ip proto 47'
>   ip -s -s -d link show dev gre1
>
> Solution:
>
> Use the pskb_may_pull function instead the pskb_network_may_pull.
>
> Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmi=
t()")
>
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

