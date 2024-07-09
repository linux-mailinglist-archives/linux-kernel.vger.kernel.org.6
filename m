Return-Path: <linux-kernel+bounces-246770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3D92C66E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0579B1F21404
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974A18563B;
	Tue,  9 Jul 2024 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROXDooGy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795415575E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566685; cv=none; b=bxo7uiZGWsnMW3y8JU0a4QhMVE3Sz2X5yZpmXKjhyXXm6lfM7v1TyiIlPuHLXklwhAFSMXiXb22XdufhMmII/XyrbXZtFidyxF6JiKZJwENFtL6cPsM6AVelx0mMxx/tKD7RICOEmQhXr0HiCtJA1Goji57zKTdVA2jKse6Lr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566685; c=relaxed/simple;
	bh=kqHiTzlsTpCwC+mRhJ3ANcZGbTNLa7dlOqr7e0N5x8Q=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFXF2CN+dqdVNi/b/McNHBlQJjz6uMVIBPUAkPMpEAXUvE1lzlyTEmeIkm755ZureoRIRTwNpnhDS00MlIlcny9s73YHDjV01Zam5FT/L3kXlDd0SWS3Ji6FCiJ61RMDjpFEjjygfWUKoTi7ez45oLppDbdYuzPSYJG4RJczEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROXDooGy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720566683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoXVxLHrISaurBK8S5yP5fDz6rnlPjSwahgWcJsOvhE=;
	b=ROXDooGyuHa9NE80vEwrf+8bKUrwgDG1+y2mhC0HNx9J2ViBCFH87Wgm6UeKCo4I929xxa
	bMMFP6cm2giENS2FeGGqOyo75DMu450L5cvSwI0Fj+kx79oiwB5QUt4jeBaZg/j3rCSzWK
	/mKZs/tER49tbzrKK4tfr4gzEdV/Ri0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-PzF0gSfZMOeZ8V3QihsBaw-1; Tue, 09 Jul 2024 19:11:21 -0400
X-MC-Unique: PzF0gSfZMOeZ8V3QihsBaw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e02b5792baaso10060183276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566681; x=1721171481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PoXVxLHrISaurBK8S5yP5fDz6rnlPjSwahgWcJsOvhE=;
        b=hZUr5EV2ECyViQKeeSrbC2mEjyHcsRQ3lWjYCYuBbruglzQ+nBPLUwCRovAWHGT7sV
         UzIKR4ZmRV7ufEq8LyrPes9TauMDq8cUcIJ5sCMOK7ms9xeTMGt0Qj1bxR2Dq8OoOcwY
         ZJWp+fHojUlX6b1TR9aoFOu+S7pJquFOr6rGBUCHqRT6hj51TxwhUpVfp8iTWdnMQird
         nIL2wZAlXqnBWvoUQjH9yGPIU8WTwMzmW52wpuPc7ClrJfTzU1xyMe75ywM18VKw+5bq
         t6HplgPmHR/YhlQtuCZ2f0qJVF9GbAzX7E8uF0fs6bQPtkSpzz+6URWE5eqJkZLvKcU+
         BX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZwV3D1CKA8TkaWTsNPo2Sa2+UzWLbExUa3b3yVnjs5oWJ+q8UzuQJShSBv6NwHJ1nPFopXXxIBxaMhCy1UY3UlKEzHPSvQEdN4qCn
X-Gm-Message-State: AOJu0YzCgsB/oyajg34WNNaWPlvFhonA61cp6bC/uGX/8cXh2ukEWQI7
	3+7PZ9+5ZupTbeYXC9PpoWK49KAGCPTlbCTdQLNPrlkL/X0WVvi3cpTR/n3mU7+B3NHTDAxqwBh
	XK9Tw2lcNr2d3SykYM1h2NoxMRiG+FvFHb78UmLLIPDQAzZqFfHF8tr0I881/z8vOKKzIIx4sGn
	dJip11R2cnzUixUGHUUM53Po1Xs0StXE+DFuic
X-Received: by 2002:a5b:94c:0:b0:dfa:7251:72f4 with SMTP id 3f1490d57ef6-e041b039ac9mr4739828276.8.1720566681295;
        Tue, 09 Jul 2024 16:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+cVuh7KFsTed+EwrnB1ORON6jzpEvdT0f6NcgV8m1sDJZRh9dDwT2VNgEcjE7Nf4rsNO775cHSsxQdeqngwM=
X-Received: by 2002:a5b:94c:0:b0:dfa:7251:72f4 with SMTP id
 3f1490d57ef6-e041b039ac9mr4739807276.8.1720566681012; Tue, 09 Jul 2024
 16:11:21 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jul 2024 23:11:20 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240709203437.1257952-1-amorenoz@redhat.com> <28d092ae-96c8-4145-b679-399d2f71bf8e@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <28d092ae-96c8-4145-b679-399d2f71bf8e@ovn.org>
Date: Tue, 9 Jul 2024 23:11:19 +0000
Message-ID: <CAG=2xmMLkgfU5NtvWciDU17gQ9d2vOtzK7HHyZZWG--_2a4woA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: psample: fix flag being set in wrong skb
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:57:14AM GMT, Ilya Maximets wrote:
> On 7/9/24 22:34, Adrian Moreno wrote:
> > A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wron=
g
> > sk_buff.
> >
> > Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/psample/psample.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > index f48b5b9cd409..11b7533067b8 100644
> > --- a/net/psample/psample.c
> > +++ b/net/psample/psample.c
> > @@ -498,7 +498,7 @@ void psample_sample_packet(struct psample_group *gr=
oup, struct sk_buff *skb,
> >  		goto error;
> >
> >  	if (md->rate_as_probability)
> > -		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> > +		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> >
> >  	genlmsg_end(nl_skb, data);
> >  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>
> Uff.  Nasty.
>
> I'd say we should change the function argument to 'const' to avoid such
> issues in the future.  There is no reason for this function to modify
> the original packet.  What do you think?
>

Yes, that's probably a good idea.

Adri=C3=A1n.

> Best regards, Ilya Maximets.
>


