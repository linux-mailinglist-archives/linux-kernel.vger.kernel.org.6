Return-Path: <linux-kernel+bounces-247715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B236E92D387
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3851F2156E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B7193067;
	Wed, 10 Jul 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5kgyW80"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812B193078
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619728; cv=none; b=GklUYbJNnn8yHZm0Bw8vP8iJQIh9MRvYppGUAnhHHgPmGGkw8IcoAHsOWjHQiJwkGYZtL0lSFMG8DBxsyA38v04y8dvwz9o+E9+hzZySFgQ44L1ubQQlxl/UiBNOgsSZ9mbVteWIFvvmA2LQXNFpgiT4OQsLxi4XqUuqRo3HeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619728; c=relaxed/simple;
	bh=unwM1yX4G7k+5zP+t5zmO26Ky6V01mVmYEwjkpEX66U=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTzfn+gUAGt9kyoqwOYYvA6Xc9cb2qEq4kc8orL2Zj/WEFqLOz5eChdvaEaiIHJ60fVi4DptK+CID0L8Aw1LA9BLTWqqSFHEdyETny+Y/yRuOnEW/7JpjPSX5f7BTiOdz4zzVvO16RslAi+OIunQqKob8g69NsWBIn9xw743g+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5kgyW80; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720619726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzubncjO4Fc3ES63FnB0xYnze7xo/KBKDvi00k6GvUA=;
	b=Z5kgyW80OivRdCc8QRLINj+iksP5/umkDb7twFly8+oopozT3dsh5UyCouY5JEexP7S0al
	k05XXqiHCO9WeY26NesUitSd0/M3W4YkFkM2X/HAiRqWUJAMYyyT4+MSShY4IO14Tgh6F7
	YIX89M8LBJNk4Oz7ZzKb1w0BAvOsU3o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-bysgB7kAMPSdyKyxTVjaOg-1; Wed, 10 Jul 2024 09:55:24 -0400
X-MC-Unique: bysgB7kAMPSdyKyxTVjaOg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b5cec74f1dso66774176d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619724; x=1721224524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bzubncjO4Fc3ES63FnB0xYnze7xo/KBKDvi00k6GvUA=;
        b=aj+Wbb478H8xsCD7y976XSXVaqE2LSqnYgPNaYOB/FKVSBV/T5S2TyokGCwkjHykvM
         jMhR2PEEboN66lC33kOdOLL+ga2cwgniFjI7ycEJl+/dI6otuxobuIwtUF+F2qpE3oZZ
         BVyDnlMF8AZubg3kUYLVwBJiNDeCaYym6OhO4IRSnFyqwjvGweIGYMW6FpBMHBpNAtak
         yd3ci9qgICympaxR7TOY7y0RrQD8sSSYLDS2aaH+xfHbZXWkMOs+NHgGf4HUJLV90KXG
         eU2bDnTq75HJT/9UWW47SL9qZdSiSs5PLpIbVudOJ3bYLodkkrT9r02UtuuODH3AwvGO
         G1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWOQcTxMZblVQhK9Dm1HhQtRXgRncp+avasjrWCAN5N04j0jMCrfWV1hUorwPd879WaxdQxP+qMRNxwG9JBOYiGirgSV4Y4IkU/pd7W
X-Gm-Message-State: AOJu0Yz0JjRKwCA4sSkJfa2lqdLAavk4cj7AuHT4S+soDTzt8ZvF65KB
	bpXU+o5UbMyIdCyahq6kMwMdtQ7oY6TVkkMUR6A8lT8b1vR8FhKqiwzkDYsIpUORkRmJSiPHxkd
	tHciaxnOD1u42JY2h7ZIzatatgDaUvvQmnQ0XsgAJr3zN1hfd/z33Puikoq42K0ExeBkKNr2yYc
	/zHGquhv9Zsc0LIOnjuMEho7V4kqKP09Xw1s1q
X-Received: by 2002:a05:6214:1309:b0:6b5:17a2:887c with SMTP id 6a1803df08f44-6b61bc7e905mr66221226d6.10.1720619724269;
        Wed, 10 Jul 2024 06:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9LZ31BMD2ytn+bbb8lOwX8cx2G0J+8MY08qrTWKuSeNvjsoJM3arGjiqJmzdsk1ZLXo1hXw2JFMfLwik3jxU=
X-Received: by 2002:a05:6214:1309:b0:6b5:17a2:887c with SMTP id
 6a1803df08f44-6b61bc7e905mr66221076d6.10.1720619724036; Wed, 10 Jul 2024
 06:55:24 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 13:55:23 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240710090742.1657606-1-amorenoz@redhat.com> <172061821475.5582.9226948763101271068@kwain.local>
 <CAG=2xmNR8Uw2Ecw=NS5BoRGoWWp7hJgd4zxKTRbSrq+VVKq5Uw@mail.gmail.com> <CAG=2xmPQuaOEdktezoe-ghr-Lnax_h19Ho3-e8pEBhwH_t=kCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=2xmPQuaOEdktezoe-ghr-Lnax_h19Ho3-e8pEBhwH_t=kCg@mail.gmail.com>
Date: Wed, 10 Jul 2024 13:55:23 +0000
Message-ID: <CAG=2xmO7VssQJ_gQh-T6_iEZuXUa1shvYmoQauCYVB6mVv9+Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
To: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 01:54:58PM GMT, Adri=C3=A1n Moreno wrote:
> On Wed, Jul 10, 2024 at 01:51:59PM GMT, Adri=C3=A1n Moreno wrote:
> > On Wed, Jul 10, 2024 at 03:30:14PM GMT, Antoine Tenart wrote:
> > > Hi Adri=C3=A1n,
> > >
> > > Quoting Adrian Moreno (2024-07-10 11:07:42)
> > > > A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the =
wrong
> > > > sk_buff.
> > > >
> > > > Fix the error and make the input sk_buff pointer "const" so that it
> > > > doesn't happen again.
> > > >
> > > > Also modify OVS psample test to verify the flag is properly emitted=
.
> > >
> > > I don't see that part; although it can be sent as a follow-up and not
> > > part of the fix.
> >
> > Yep. Sorry I was planning to add it to the fix but thought it was bette=
r
> > off as a follow-up. I should have removed this comment.
> >
>
> I'll resend the series without that comment.
>

s/series/patch

> > >
> > > Thanks,
> > > Antoine
> > >
> > > > Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability=
")
> > > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > > ---
> > > >  include/net/psample.h | 8 +++++---
> > > >  net/psample/psample.c | 7 ++++---
> > > >  2 files changed, 9 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/net/psample.h b/include/net/psample.h
> > > > index c52e9ebd88dd..5071b5fc2b59 100644
> > > > --- a/include/net/psample.h
> > > > +++ b/include/net/psample.h
> > > > @@ -38,13 +38,15 @@ struct sk_buff;
> > > >
> > > >  #if IS_ENABLED(CONFIG_PSAMPLE)
> > > >
> > > > -void psample_sample_packet(struct psample_group *group, struct sk_=
buff *skb,
> > > > -                          u32 sample_rate, const struct psample_me=
tadata *md);
> > > > +void psample_sample_packet(struct psample_group *group,
> > > > +                          const struct sk_buff *skb, u32 sample_ra=
te,
> > > > +                          const struct psample_metadata *md);
> > > >
> > > >  #else
> > > >
> > > >  static inline void psample_sample_packet(struct psample_group *gro=
up,
> > > > -                                        struct sk_buff *skb, u32 s=
ample_rate,
> > > > +                                        const struct sk_buff *skb,
> > > > +                                        u32 sample_rate,
> > > >                                          const struct psample_metad=
ata *md)
> > > >  {
> > > >  }
> > > > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > > > index f48b5b9cd409..a0ddae8a65f9 100644
> > > > --- a/net/psample/psample.c
> > > > +++ b/net/psample/psample.c
> > > > @@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tu=
nnel_info *tun_info)
> > > >  }
> > > >  #endif
> > > >
> > > > -void psample_sample_packet(struct psample_group *group, struct sk_=
buff *skb,
> > > > -                          u32 sample_rate, const struct psample_me=
tadata *md)
> > > > +void psample_sample_packet(struct psample_group *group,
> > > > +                          const struct sk_buff *skb, u32 sample_ra=
te,
> > > > +                          const struct psample_metadata *md)
> > > >  {
> > > >         ktime_t tstamp =3D ktime_get_real();
> > > >         int out_ifindex =3D md->out_ifindex;
> > > > @@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group=
 *group, struct sk_buff *skb,
> > > >                 goto error;
> > > >
> > > >         if (md->rate_as_probability)
> > > > -               nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> > > > +               nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILIT=
Y);
> > > >
> > > >         genlmsg_end(nl_skb, data);
> > > >         genlmsg_multicast_netns(&psample_nl_family, group->net, nl_=
skb, 0,
> > > > --
> > > > 2.45.2
> > > >
> > > >
> > >


