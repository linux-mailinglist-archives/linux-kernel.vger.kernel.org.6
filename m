Return-Path: <linux-kernel+bounces-553568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E97A58BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2773ABF10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337691C5D79;
	Mon, 10 Mar 2025 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igW6/dsp"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1C192B6D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741585550; cv=none; b=PxatlXHUcM9oJU2oeincvQ96aeJ+zSpyiD5qoAikFF4GZ2eghfNSRaypZ2m0W4BnSCNFIM+MfiVIcMbwo6yXGi96KCS2QP2rUmFRPQaAXIdM16yWQuXsMssykHhp9G5VDmQPyEj+PuCNjj0o4o6KIwk7eBOByQQf+PBXRpQd9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741585550; c=relaxed/simple;
	bh=DY82KMX4hDS22dhJw5YHjL/IBpcRs4OLmCAM8hynbgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCoKrDjC1Fmqa3lLskCUKOW0yPt4hLtkY0Hqr+uChZUCmaNgKz83a24CQb25VplBEfdCyrNB8bnxRDYA77HtMPh5AJ4WQDwSAcYs8Iv2Wr8ylusMVP9u8gYE4n1RIe8nKA8Dk8xkUFv/q+sof/LurWJbzNM2nHrG/5l/bUc2IkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igW6/dsp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242ac37caeso174865ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 22:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741585548; x=1742190348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdk8JIsy8Nv4wZkNtHkaIEhtB3SE9Fe1TcjLHkiBi6U=;
        b=igW6/dspWz1lS2s9sdBO5CCJpZtFZxK6GFFFZbwz10Atm6B4Sml3P4umOcIkxumZGg
         sxlKoei8c9nfyRy+A3cIleGglNu1Mci3Aa3epzGX32FYJtY06YOi0Brpw4weoovzSE30
         haKfxSamA8bfeoxukOAfcC4Jc+f3cllnYEbPWU8bhHdvkxJG9tKy9z6gBJvGwh0F91fm
         6MswM6H3PTHYXrqLRK+TwWEJcFFR9IypMEPSMo9svPIDjhrp1FXbrm+idRrn6N+z0xNf
         Ts4p/Juzq0g3pI22/fbyCCr+DyDg0jnW35u2wnOWNJwE6eGm8S4koiiEH43+M35wiZwi
         Q1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741585548; x=1742190348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vdk8JIsy8Nv4wZkNtHkaIEhtB3SE9Fe1TcjLHkiBi6U=;
        b=KuyHxH9DLjf6GZc0KiebnJoZgrmIke/YoWWakbEmgiSiztQgUsgZ5HBV5rt3ZcDPoY
         W6K8Rnc7rYErL5SC8JamQXLVjLZuPmPzf5wQEv87IRyPluQlT7BgxRc2gYNEBI5V4eAf
         AXBMmRp6aATlt01p8ELXOQXrmSzvc4flEDOQPq/UckTVWGMWwcNWy51w2XlvHBEakttS
         XT0QB2lyMKutBIa6pq+V8vSe+shcgl44vpoGXG/3BEjQQxzsFY0x+hdvvxLBuCYpGESJ
         ueWvu4a8A/rBupEnTjJTVpdnpRC6E79j6lh1/2+3x3F7jn0vtBkReIR0Ryfpa8vv6t8Q
         zJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCW4lHMOWSOZPKfGhddSGW2RwKuPm4rhDVQl/J5EeNNECnryZFkG3NLRLtWEsBEjiYP1NFxiI8Yx/9oQpBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdU8MCYUP7YtS8y3Sszlw7Hc34gbT680olxgY/xgzgnGH56EC
	LWtUnOvpMV58lIsGzdapoNYFemnaRnAcvJqxnzn8iQfwi4KCoUcQjjYHazBQVdWCzA0bxqhyHIU
	l1Jea0KuNUrV7ABa2qNTQofyWO2a0yI0i3iPv
X-Gm-Gg: ASbGncuqTQq/2lUv/OqbOHSkEA/JxCw4eSJsM4O/qCWnLkyrwE+QjOCHe69tV60KZC+
	OyAeXnEHtyrHL76GX5hBPstmEnZwq6DlcscTIZEUtTBKUqgyyWdFhOF8ii+Bo13/EyfeeXEH1eE
	Yi81ZqN17nEgeq7HzyhSscDcvlwn8=
X-Google-Smtp-Source: AGHT+IGxu7wIRTInzBiyf9nxCQSO1GLEfkcPemXrYOYE6jknsHBotxVlbcjDpO1VXJQy29bcwiKlXOFGjf2vqpUHvdI=
X-Received: by 2002:a17:903:19eb:b0:223:5182:6246 with SMTP id
 d9443c01a7336-22547816b5bmr2494655ad.23.1741585548265; Sun, 09 Mar 2025
 22:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307155725.219009-1-sdf@fomichev.me> <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org> <Z8uEiRW91GdYI7sL@mini-arch>
 <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com> <Z85ycDdGXZvJ-CN-@mini-arch>
In-Reply-To: <Z85ycDdGXZvJ-CN-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 22:45:35 -0700
X-Gm-Features: AQ5f1Jqk8kOtO3C5Pchm701Kts4Qy4PEDF_B0T63TmnCJ-VfgK7h_5EZzHN_Zng
Message-ID: <CAHS8izN0e5eXXYD+aPc7hJPa5yAfCQKfwvrMpk=gZ7QuH5CqtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, horms@kernel.org, donald.hunter@gmail.com, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, 
	dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 10:02=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/09, Mina Almasry wrote:
> > On Fri, Mar 7, 2025 at 3:43=E2=80=AFPM Stanislav Fomichev <stfomichev@g=
mail.com> wrote:
> > >
> > > On 03/07, Jakub Kicinski wrote:
> > > > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > > > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > > > index a219be90c739..8acdeeae24e7 100644
> > > > > --- a/net/core/netdev-genl.c
> > > > > +++ b/net/core/netdev-genl.c
> > > > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *sk=
b, struct genl_info *info)
> > > > >             goto err_genlmsg_free;
> > > > >     }
> > > > >
> > > > > +   mutex_lock(&priv->lock);
> > > > >     rtnl_lock();
> > > > >
> > > > >     netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> > > > > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *sk=
b, struct genl_info *info)
> > > > >     net_devmem_unbind_dmabuf(binding);
> > > > >  err_unlock:
> > > > >     rtnl_unlock();
> > > > > +   mutex_unlock(&priv->lock);
> > > > >  err_genlmsg_free:
> > > > >     nlmsg_free(rsp);
> > > > >     return err;
> > > >
> > > > I think you're missing an unlock before successful return here no?
> > >
> > > Yes, thanks! :-( I have tested some of this code with Mina's latest T=
X + my
> > > loopback mode, but it doesn't have any RX tests.. Will try to hack
> > > something together to run RX bind before I repost.
> >
> > Is the existing RX test not working for you?
> >
> > Also running `./ncdevmem` manually on a driver you have that supports
> > devmem will test the binding patch.
>
> It's a bit of a pita to run everything right now since drivers are
> not in the tree :-(
>
> > I wonder if we can change list_head to xarray, which manages its own
> > locking, instead of list_head plus manual locking. Just an idea, I
> > don't have a strong preference here. It may be annoying that xarray do
> > lookups by an index, so we have to store the index somewhere. But if
> > all we do here is add to the xarray and later loop over it to unbind
> > elements, we don't need to store the indexes anywhere.
>
> Yeah, having to keep the index around might be a bit awkward. And
> since this is not a particularly performance sensitive place, let's
> keep it as is for now?

No strong preference from my end.
--=20
Thanks,
Mina

