Return-Path: <linux-kernel+bounces-556416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CAA5C775
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF9A17CE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0225E813;
	Tue, 11 Mar 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhsSbMWT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900725EFB3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707056; cv=none; b=ffut0vN1Ry2O3fOq5u91AX8AWz3Cj83GrZpA3FGYz5diGKrkkbpaDACCY60bL5nKQrIB06le4e5Kt7mTwDNdL/7k9kcjH7TMm01CQW5fwF3d+z1aXgt6jxE5KH8WUD+z6hVV4CeJYBs5BApBdlapYZ/L+kOli3ISlumnu92YjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707056; c=relaxed/simple;
	bh=jLpO0aClIlGsNxrUNyVQiaXn8vjjrMvUwz4FprQTRoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM0LnHV7bB8ZG7XPQuZaf42zaLL9oUeZi65cxJ0JoUVmDKVKrcUtEgZ0t6MNsFT+NDcplkiRFfruwFVOjYS30BgoRN/HHjY/znFuyjyyvtrOv2CRjMwC7zXD/dsYwkt5y7Px68Jlp3NuTsbjk3vheTdSzFqTnPm0uHZeWGr+mbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhsSbMWT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242aca53efso162525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741707054; x=1742311854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVGJAzXPVHMjqIFrjU+0+4wH31oMqsdQyLQzVc+pkY0=;
        b=FhsSbMWTjmF83KcDjUo2txL3WXmnBHlHWnUNNK+Vd36x5+QvdeNe6JUVzixtsjc27k
         g2VAOwxRtKQxImBCjGdDrDoC4HulyYD839Vh8nPy7yLXUgYXf3IovmDeZXh0Kj1/su6c
         nUD49p6lMAu0+4tWSyrzHKD/9H8GQn2Uo8xnYO7sp//CZlZiiInKLR04yFybV78SbjJJ
         01nCNl7u3HvQOaO5Qj6/wvvUQ4p+erg+CxziXUOr6OyYM8eGOKX2NRBeZ/goiP1nepSR
         sp2xNE6Dms7fucwiTDPR72BmBzhJQ2879rO+UpYCE5AJPVWBw+BmZnlkh1N9QyMdf7Xp
         qXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707054; x=1742311854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVGJAzXPVHMjqIFrjU+0+4wH31oMqsdQyLQzVc+pkY0=;
        b=ew4XBiN/Txh4oZAbOelV3h25BKck7Daw1xQ/f06hZ22l9qEqEssXj0zCw8Qf2BMXRR
         at3n7ay0Jm4i2MyzYvPMu+P/kUo8GPDX7WYUJL9swbuyZKX5hjBEZDE89Qa74DGN9bBu
         ef+XY1Hpo04ZFMpXKlRD79CRMXAMIWjE+LAn8UKe2tFypdTG3GM8uF1QE1mCpgRQtXqo
         dqjcsgwWxgwG3wdMGsAzkDxNZ5Bd9yegiYhf+WPFSwqqeJ+KvTnuW8dFvXktRnx0/XqE
         rO9VZ2rWEu9zo/nSlK7kStXeM+O8GoSvdOqHU6gETiBNyXAtDX/rndlldPKmFmYEfUeM
         jaaw==
X-Forwarded-Encrypted: i=1; AJvYcCX6KsYQZ9fLs3HsLVevJdNq7aD8ZtjgG21InnCA9pG9s1C169IteMKXicwNDz/zegpeImCLM4kZndv0DAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOGgee/m2HhhnRNasAYEFmTry+joyH7OLnEju545awAIn6Stk
	Y+703XVxDt/bE6benj/eLpU213nKutoKl4Sxub0H9U39VCzoAsf17U5DTNfGc4b+BDO975XfO/F
	REICRSu5I9T7TlhAJcK3CC1XcN9XlAqL+1DCC
X-Gm-Gg: ASbGnctqeN4FpOI7YCMZp0BKuGrwoMX2zQv3JndNulmjslTVnk5Kj4KDVcGD3AFjS0I
	6QUV7A9sgG9cvDZP/cf4A5Ev4J0OF3Pz24etd1gR2yVLGBm+RqOtEOQBW8nAmKykg7CL+eFoxpB
	uH85PEvidlunJFEfG6J51+9an49lM7QrKbP2XfAzMKD0Q34vRlaFe6wEBB
X-Google-Smtp-Source: AGHT+IGYHJc/dR1cL3X3QNS0Lcow2KWr3zVva+Z830WG9yASnDR3fJuYHKDNLSUxaqcOEPiRmBNOmQ0iC1ARn/BdUfo=
X-Received: by 2002:a17:902:e801:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-225416231b2mr8512655ad.14.1741707054179; Tue, 11 Mar 2025
 08:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-3-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:30:41 -0700
X-Gm-Features: AQ5f1JqD407vBMjqQOmrKFXb7bJs2U7gZbWGDMPZYCzlPxwlBJDa2J8QTmskVJQ
Message-ID: <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> As we move away from rtnl_lock for queue ops, introduce
> per-netdev_nl_sock lock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  include/net/netdev_netlink.h | 1 +
>  net/core/netdev-genl.c       | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
> index 1599573d35c9..075962dbe743 100644
> --- a/include/net/netdev_netlink.h
> +++ b/include/net/netdev_netlink.h
> @@ -5,6 +5,7 @@
>  #include <linux/list.h>
>
>  struct netdev_nl_sock {
> +       struct mutex lock;
>         struct list_head bindings;
>  };
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a219be90c739..63e10717efc5 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>                 goto err_genlmsg_free;
>         }
>
> +       mutex_lock(&priv->lock);

You do not need to acquire this lock so early, no? AFAICT you only
need to lock around:

list_add(&binding->list, sock_binding_list);

Or is this to establish a locking order (sock_binding_list lock before
the netdev lock)?

--=20
Thanks,
Mina

