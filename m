Return-Path: <linux-kernel+bounces-337082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9EB98450A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634DCB2592B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F411A706C;
	Tue, 24 Sep 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKwpgVkh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6C1A3AA7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178096; cv=none; b=dIAyO2XHHNUBFlKe85OqCNO4rj4i93ywKwMlJR7G913AR0dRiW0gD29CJMG+DPgUraIofM76jIszODOZwBgrnCAmFfSx8aUKy9SCEipH10bcGBcBbtLQDXpH+6NWfYPx+qc+xMq1J8b5Z5cDcSNOnwcClsVwBKHD3T4z/xEGfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178096; c=relaxed/simple;
	bh=9b9AIM0D0WQUMIffHpOBsByjwEElnQ05FKM2vCnaOXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFODMLjsZbp3VgC2Mp0JNCbUFq11GVa0PfNEOzyVKeKcYwW+HmxZ7OPROyewt2cHw14VB7NPe5g9Og6WAQtdvkV1PxLWne3Hqw74EAL5b0ET7VTY0UdyBqIHnZYdOEykMBjrYLU2CvppnB26Fny4Mz7JolzWIwk9fLDQwk+CPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKwpgVkh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so5725447e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727178092; x=1727782892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9fc57nlwLbQdQ2sAc2oCWAZfOvWwEj+gafnpAGtImk=;
        b=lKwpgVkh6wH5S2enMDs0MvorEO9GJnJXbagQ2FiPvfeybOb9f3NOqxPY82UiLrHZBX
         c/V+38u63ZguOWJLkALg7RAlX/iXybdiIRd5ddZnMQwTwOk0lCXR+etWQ3vW1Lizjuj1
         XpW/SKAWR8W32X8ieCW3+xdClhVlEx5nxTxZpv0K0q4ySxPevr0xa4XU2k3laFrfV+zB
         pos/yK45yFad7d4zIdAbpTm46IG4sWJJEG3z/pJmxsLWpjngykA5WpFBB4Dx2nyskga+
         m0Lytac0YAnHF087yo9N9XNJxE6SoiDcsdNS3euyds25sL3ISSliVWFnYl4RRCsb0ZdN
         vatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178092; x=1727782892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9fc57nlwLbQdQ2sAc2oCWAZfOvWwEj+gafnpAGtImk=;
        b=vWf3IG2/EL+a5GRaRfXB8f6C3nWxc7Dq5Rf0RxM1n2QKNKdlVeh+u2phH2ZyUbHNoy
         tVBYD6Ldl78/wB04ZodqYfDML+a96C756bugSD63snV6lNySKtTIt72tnwvfoRPfBGLf
         AnMlKZ31IW56UtyCWsTb9ZysEyEh5MmbKhlmDvJuBeK+FseaVtMOwYww5IlafKSGXLDR
         ycLbFKQzCMTDhyOair8HTCjiSUC+H4ssOuNxEj7ZvnNNCmK6nB9GlOYwabZAcEeX9uhx
         gN85zGsodPdfgfHYEEueh8fWCed3H0FvlsBoIDUrdjG/+KEv6WqXmBmCrFtiKPmurQ3O
         nfMA==
X-Forwarded-Encrypted: i=1; AJvYcCWohRlQcvJ2JDfYSgxupsf0kW736gJMPYLFCNt8oxqkpXb7lLqoeYyEzlVAqRI9ptaVA1oE7GxqnefNQ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghS8sq5qQ8UVULi6RZleGWqbqSZbS32yQmGQs8sacz9aFeZzc
	+Y6WddxRsZRuICzoiNmJcfb3zUi7Zg0KhTVvnTsiQV3X8b9eUAcAklviyhrplfAYIQReT45CAfC
	74pa+EVoR6tc1UzI42u7LZjDZlR8n5LFGHTZn
X-Google-Smtp-Source: AGHT+IFj8cqiMiY1AXVRvhe8rwF6DcWkYvkXpBkf6ecfSJZUFkRYRRAZL4pwU0vfwWYZ0ZEAuIkQNbltGVrr7/auBdY=
X-Received: by 2002:ac2:4c48:0:b0:536:54df:bffc with SMTP id
 2adb3069b0e04-536ac3201c7mr8557051e87.42.1727178091961; Tue, 24 Sep 2024
 04:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013039.29200-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240924013039.29200-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 13:41:20 +0200
Message-ID: <CANn89i+Mg56hG_Z4N0KnJ=9c2mTHQAHTQEJ1dbagBpjhijAoxQ@mail.gmail.com>
Subject: Re: [RFC PATCH net v2] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Suman Ghosh <sumang@marvell.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:31=E2=80=AFAM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Regression Description:
>
> Depending on the GRE tunnel device options, small packets are being
> dropped. This occurs because the pskb_network_may_pull function fails due
> to insufficient space in the network header.

I find this a bit confusing.

Perhaps explain that pskb_network_may_pull() is adding 20 extra bytes,
to the 28 needed bytes (20 for the IPv4 header, 8 bytes for GRE)

So, instead of making sure 28 bytes were present in skb->head, we were
requesting 48
bytes. For small packets, this was failing.

> For example, if only the key
> option is specified for the tunnel device, packets of sizes up to 27
> (including the IPv4 header itself) will be dropped. This affects both
> locally originated and forwarded packets in the DMVPN-like setups.
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
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Please send a V3 without the RFC tag in the title.

