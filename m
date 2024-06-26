Return-Path: <linux-kernel+bounces-231437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CD9198B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5622C1C21F45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC7192B63;
	Wed, 26 Jun 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXg2dEf/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5C191473
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432372; cv=none; b=PO62xEjVOp7tuQwq8vxqsp0tn49CVeCpFmTKH4Xlx6V/QrGq7i0s0bSTu2xvw9BBv9QcOSH2iG44D2D1KnKIhrTP1JUpC1gSf0DnKR8CwTzChQZrGiqIkK2gBcp8sx0TRxHCclxs/94DULHLMMnL9r6/qjO3EIyKlExmvLN2zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432372; c=relaxed/simple;
	bh=wsM6UJGeNiu7cOxTs7IKpqbnVikAuohX9+YB9Y1dATA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLRsTqS/KqylnjRjwlFcrdEbEyeRLM7UHbmvYJOwGjvAq7vtMHf28iy2R2+HM2hyzgs7w7SnF2ZUsGB0VcB399x3G/wxRNGFxRWajlvhDOsKhBcE7zoJFj4adnbIgxoH+3yOO3nPBp02tfLz1b113YZrG7Qn978L6oifoN/RxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXg2dEf/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DcZaxikqPC0+hsmCN6vsq4zOqv6Wyyoc2VCe+F9XI8=;
	b=JXg2dEf/IQ0p6MSsNNiAc+hC8k1cZcuHqhg9r5ixZTj23P8cCncLI/OnIdef5aTVFj7WvM
	5OVm1FrgVJ0GKbnmyK2EeStpfzxWK9vzD4qdQjhA+n2VjhM+wA6TfkO0dGkL3PpUght0rU
	biH6NlHRr9KoDQnK4CGvluRPwZtYWyc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-fWf_LoTlPEu64WBMvOEX7Q-1; Wed, 26 Jun 2024 16:06:08 -0400
X-MC-Unique: fWf_LoTlPEu64WBMvOEX7Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7e262e0efso9071055a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432367; x=1720037167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6DcZaxikqPC0+hsmCN6vsq4zOqv6Wyyoc2VCe+F9XI8=;
        b=Z/tBdVt1IqmBqitomgD5p5d0s59/RTfkBW5MLN4Z2jgUCOFe3A/XBQx+SCnXhiGt1W
         djsRtf1LR+xxNapRNxdrRT9y0tYwL8HRF/oU7kycqNXGX1GOmhFzDfzTeNXakTxom/Z8
         7+coqvTCEJeL/KSoUM/uiD+elBAFnFDJ/ldtdzrvKEK0cGc7vpQImerfgVx1K7EHfj2y
         EgzXB+cylbFLKKWSeY5Nharqb4tQfQbIQn23hhLhgTUd8E1Qz8m0ApVVkdUpDIMJ1X0H
         +W6QBv9PPOBiQndQAs+Lttp9hQoupA93kyAZNRjd8u8tzrg5RjzUXA3ZusBUhYHpvxbt
         x9dw==
X-Forwarded-Encrypted: i=1; AJvYcCVs8y9A6z25SH6fTj4LGBIOOEiEFMZHw418BWX67w6JPYBrIeYJnCYDUx1l7fh1Z1LL8BR4mxnjfaibpxkoXNsFtwuQE+8/6awS7Xlb
X-Gm-Message-State: AOJu0Yzp+nEbegp2mdB2xvXWZIu+mjnWMJMofl9VZISABRHoY3dIFmo7
	+xW/laxfEfundTCuQcfY2vl+SD94bwSYzRchH9gXEEMQrzRqyCQEoA3QYsQF9y2IZLfOGrIhIw3
	Cv4trrgJiK0oxk2n1mqnu9CKccnVY9an3yIcUZwXCxmIYDTrIgkuhgRqScVF/6XvYn8TyPUekPM
	JczX6Izvjd9oED6DGIn871Ny4mctuAYgkrbuBQ
X-Received: by 2002:a17:90b:78f:b0:2c8:dfc2:2dc4 with SMTP id 98e67ed59e1d1-2c8dfc22f58mr1983360a91.19.1719432366906;
        Wed, 26 Jun 2024 13:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Rq5k7TgltBZYKPXKVbW7ERtu2Mvn17Q/zCuwWIPdCyM/RlzMQqoY4XLleKd4oWWmZGoB1f6cMbuc+zh1MWA=
X-Received: by 2002:a17:90b:78f:b0:2c8:dfc2:2dc4 with SMTP id
 98e67ed59e1d1-2c8dfc22f58mr1983326a91.19.1719432366469; Wed, 26 Jun 2024
 13:06:06 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 15:06:05 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-3-amorenoz@redhat.com>
 <73D32BC8-93A2-455A-AD9D-1FBB17553F8E@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <73D32BC8-93A2-455A-AD9D-1FBB17553F8E@redhat.com>
Date: Wed, 26 Jun 2024 15:06:04 -0500
Message-ID: <CAG=2xmNjY8gRwLyoVzSHiU2yOotP7rguOuf4hdTicnCbw=38XA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/10] net: sched: act_sample: add action
 cookie to sample
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 04:28:01PM GMT, Eelco Chaudron wrote:
>
>
> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>
> > If the action has a user_cookie, pass it along to the sample so it can
> > be easily identified.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/sched/act_sample.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> > index a69b53d54039..2ceb4d141b71 100644
> > --- a/net/sched/act_sample.c
> > +++ b/net/sched/act_sample.c
> > @@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff=
 *skb,
> >  {
> >  	struct tcf_sample *s =3D to_sample(a);
> >  	struct psample_group *psample_group;
> > +	u8 cookie_data[TC_COOKIE_MAX_SIZE];
> >  	struct psample_metadata md =3D {};
> > +	struct tc_cookie *user_cookie;
> >  	int retval;
> >
> >  	tcf_lastuse_update(&s->tcf_tm);
> > @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buf=
f *skb,
> >  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
> >  			skb_push(skb, skb->mac_len);
> >
> > +		rcu_read_lock();
> > +		user_cookie =3D rcu_dereference(a->user_cookie);
> > +		if (user_cookie) {
> > +			memcpy(cookie_data, user_cookie->data,
> > +			       user_cookie->len);
>
> Maybe I=E2=80=99m over paranoid, but can we assume user_cookie->len, will=
 not be larger than TC_COOKIE_MAX_SIZE?
> Or should we do something like min(user_cookie->len, sizeof(cookie_data))
>

I think it's good to be paranoid with this kind of things. I do,
however, think it should be safe to use. The cookie is extracted from
the netlink attribute directly and its length is verified with the
nla_policy [1]. So nothing that comes into the kernel should be larger
than TC_COOKIE_MAX_SIZE.

I guess if there is some previous bug that allows for the size to get
corrupted, then this might happen but doing those kind of checks in the
fast path seems a bit excessive. For example, Ilya argued in v2 [2] that
we should avoid zeroing "u8 cookie_data[TC_COOKIE_MAX_SIZE]" to safe the
unneeded cycles.

[1] https://github.com/torvalds/linux/blob/55027e689933ba2e64f3d245fb1ff185=
b3e7fc81/net/sched/act_api.c#L1299
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20240603185647.231=
0748-3-amorenoz@redhat.com/

Thanks.
Adri=C3=A1n

> > +			md.user_cookie =3D cookie_data;
> > +			md.user_cookie_len =3D user_cookie->len;
> > +		}
> > +		rcu_read_unlock();
> > +
> >  		md.trunc_size =3D s->truncate ? s->trunc_size : skb->len;
> >  		psample_sample_packet(psample_group, skb, s->rate, &md);
> >
> > --
> > 2.45.1
>


