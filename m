Return-Path: <linux-kernel+bounces-557074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD9A5D347
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220FC3B8812
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0123315A;
	Tue, 11 Mar 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKLjwWDD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DC230D3A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736625; cv=none; b=H2DNwzPvmbEN1ejAdAHYOcBCIT3VEq2wKTFsmN0YJmZtsShG6/3XXCyyRtysXf9fDBFC7I5hXeVeKIEY4PoZuscmfl7s+ypsQ32u/fxcBoS34ku6O5NyrEjSbcN5gat8Awqw7nImK12Ku1MCLb4gdxu7vmPEc5H3tVRe+fdJkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736625; c=relaxed/simple;
	bh=iCgpy7jqhyG8ncQoVUWtdSeMN+6GBfsiRY/tnxRgmAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/zerbM1tsy3ZPv7YTlK3v1dtEl1yoT0Mv90zgYo9djn90DdLUM5Y3d7+5UFSjaLSNtXc4V8qTTw96hR4A4ZUzNZOIA2dvhj+yFZZkAHaJ5sQFN0ModUhcJSjr/WLzz02nihzmRkwIr3zW1sizP8lAg0diHCYJnL4IC37AmvsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKLjwWDD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so37305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741736623; x=1742341423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ppVOVWNSTb9lRWGG7Ph6sN+tL6fna9IjQIMtQXlGkQ=;
        b=HKLjwWDDNbjvOxAt1qFgKJDaPS22Z/ZIKGIzUeZjkrvuomBtxUErQFAgRXhJ0wNLsN
         SrohY18P+MINSp9rRBqUZePTCduXM8k3SjzAoN0CQ5X4VGeuWXTlNqTHm9wEHq0AawCh
         ZCNUZxpDFaOb8HG+HJ67PPi91lfpjIYL06A+qsWKhvMqVcGFowkOM/1/eAJEfVBkUuc/
         hTqWXDf0U9mGTnibPwSfzrymwM6mvdNTXnnND4XcxtqDDo4+5LvBRP0S3uoi98F5si1p
         KE6Goo+f6XOk2/bONA36AXc1CUc9ySplug92cUINjZO0lPLXox1zMHg0eKY52ZpbX0Y2
         cssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741736623; x=1742341423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ppVOVWNSTb9lRWGG7Ph6sN+tL6fna9IjQIMtQXlGkQ=;
        b=G/e97PzUrgH5jngyY1EN+69Xzr+nR1I7z4AjHD0anGV5Yh7u5MratemVzp+943rcFC
         V4xsNzJRj/pbuiHfwaUQCFRq76+vBh0Z+GJSY2vxUyeDvU3T9NRE5SZY4AshH/1hbiyS
         W76OZGZOg2F5ZPk8du0hsfcc/Ce8j9i2nJp84EOLlTm3/LwS2iQf5SmLqXiBmvON2wKe
         bDSznSCLKG+5Eejxcx7XtukH1/zhurXyu+osnmtzEQXrbssa1N9QC/+HIPr7PClsgJNg
         a0aZDRnzhDzxcnIJ3JYcE17V00Ozt42SvjGtad6iKzOqZRdUXr24Yp9whYMonI/KU4TR
         a5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1mX6aInmx4aQka7npKf3aCQL8fP0p9/3F1Sd2uX5ODXfORZ3KNhHRPgFblXVndi1I77T3wrnuJWybWEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB68lwvIifju0x40o/JKo9fVnQzkot9ANTFTA7R9tRQbPlwA4h
	xHE7YP37b3zEFkBeCv/tjtU38MTnXZtLvbvbBGh7DazQaNyGzy08xForw8RT9etbx8oofCmtHGs
	eyYDOcsU1YHHxvaxnbOJbQ4KDhBafvQVPN5m5
X-Gm-Gg: ASbGncssRKYjAX16QBhJQLKqwL+znS7xO3eZexKYw/fMCGEc2UKDyOri0VcFOk58YIZ
	1Ap7fh+H49SMsckw0oZo+LeK53qcaNZwqbV4MH207fJqjZCGUxu3VO3DYqO7ZYQOOrkM7u0fxD8
	3dJ+VXHWVDphvNO5mDc3yIAfd15iqW+c47ynpwp274A/4kvdshIBedU2sB
X-Google-Smtp-Source: AGHT+IFLU7rsQR2M0qHo6nW3AteBCzXQjrNolzxyumOYhESi054ErKG3j/6gAo4JH3I1joNusd4jReGkaGHr1pMOOpE=
X-Received: by 2002:a17:903:41c9:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-225a935ef07mr1248865ad.20.1741736622493; Tue, 11 Mar 2025
 16:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-3-sdf@fomichev.me>
 <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com> <Z9CXDDrruPmTjdW5@mini-arch>
In-Reply-To: <Z9CXDDrruPmTjdW5@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 16:43:26 -0700
X-Gm-Features: AQ5f1JpCKj-RR2Ss6cUPvTr95MQ318RQBjbsQc4MI-nxp4MpOAIaOe8FRcqBnrM
Message-ID: <CAHS8izN=fPj+yMqZBFX83Bvbvpr-fXNnuN_GDq0eVXTOeB7aWg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, donald.hunter@gmail.com, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, 
	dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:03=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/11, Mina Almasry wrote:
> > On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > As we move away from rtnl_lock for queue ops, introduce
> > > per-netdev_nl_sock lock.
> > >
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  include/net/netdev_netlink.h | 1 +
> > >  net/core/netdev-genl.c       | 6 ++++++
> > >  2 files changed, 7 insertions(+)
> > >
> > > diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlin=
k.h
> > > index 1599573d35c9..075962dbe743 100644
> > > --- a/include/net/netdev_netlink.h
> > > +++ b/include/net/netdev_netlink.h
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/list.h>
> > >
> > >  struct netdev_nl_sock {
> > > +       struct mutex lock;
> > >         struct list_head bindings;
> > >  };
> > >
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index a219be90c739..63e10717efc5 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >                 goto err_genlmsg_free;
> > >         }
> > >
> > > +       mutex_lock(&priv->lock);
> >
> > You do not need to acquire this lock so early, no? AFAICT you only
> > need to lock around:
> >
> > list_add(&binding->list, sock_binding_list);
> >
> > Or is this to establish a locking order (sock_binding_list lock before
> > the netdev lock)?
>
> Right, if I acquire it later, I'd have to do the same order
> in netdev_nl_sock_priv_destroy and it seems to be a bit more complicated
> to do (since we go over the list of bindings over there).

Thanks,

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

