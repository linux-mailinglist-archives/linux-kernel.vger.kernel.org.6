Return-Path: <linux-kernel+bounces-553397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E5A588AC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF09188DC51
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE021D5BA;
	Sun,  9 Mar 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quyVVZ/s"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3016B3B7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557446; cv=none; b=nuESjjaKkJbmftDtJT5jWlkRJbCyfGCxt+LcXBtZH98YVfTpx0LawQwpfrgvtLz1lhFvl3nd+r6tBBT9yoscQqrS1eU+sWUvkRWG6OeRMxQnSkDagvgTCwv0p9c/Y/G1VL4SaQqzYQoFfCIkrLR2Uu10EMr4diy7hBzOI5KoclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557446; c=relaxed/simple;
	bh=IOO3vW5DRrzxB4mImWuN0bc3+CxEqFoHgR64CmSjBn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGjwe0WjfnieeC0pRlIbs6LDKKFiC8I0oCEag/FIvJUAeFrCH8YxUVlRtBnHwWtU3BYXggAlYvZzNtwF8PdYoXtYr0CmeLP+xVnhHrbmAKyQOm+1YGW12uvPM1X1w3CuhJTS1wg+1o1QwzGw5wUqFWqWyCcha/rbwLOVQu4nyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quyVVZ/s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242aca53efso152825ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741557444; x=1742162244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2wudePMKO0a7WgcqR4nia6eVNU+3LQ8sE3S2FURcRY=;
        b=quyVVZ/sTESWfkJT8fIlfwmAjnwee4s2uzpgVkdw0ISkG4tnHV6tkLBOCUS1hWcku6
         gTuVkMB/DqhfIAFjGObwqUa9Hy2yOkrj2/aPDfvfDA6ts6qjUMErLsYKL+pMaBb073QE
         vSTi+5W9KjGWORyoo0QgXu5kCeQlwhp+zHZK+zzXwdl07sRhPUKxNTrzjtUNQDo+1pmC
         4Zv64TzKNtVCZkqm6KzKI/iw7h3H8UH7J+0ZrOytEn3kjbf0T5Gd9CDNQW+geq3YWIOl
         WZgpMVLhHbHnuWdQGlICOJIBH9D6lvli1dUsQ/QBpftUxriL6F9ftCaYZH9IRW4M2Bn4
         Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557444; x=1742162244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2wudePMKO0a7WgcqR4nia6eVNU+3LQ8sE3S2FURcRY=;
        b=pXSo0Xxeg4+kMYtot4ivm/6bKiksNNtqbTTsia2Rs7nsQU0T83w18sDkjWKYXBcTSZ
         PbAOP2Kyxkzx0hqI+0ayTqFJXh+12qG9JsygkQecdjLdNfDgJAflWIOaIJEOv1jCM30d
         LY05BycznRbqAFQSfmhcvGIdoBCPta/2gplmzhmV1QyJf5fclo+gjoQrGYIaPIrnDquB
         J8bV1cJ9ex9X9VsPXLDnzOVXmGIBZduzFXDNd1Es2kSAh9ygjqq0SH2/jxAyDqr2B/cK
         TRuqhKNaBCu1Ozrhai2/yH+MYtiu/X+kXzIABnj53zFRtpRgjoE533jPQ+RSqVP/AcQW
         Tbug==
X-Forwarded-Encrypted: i=1; AJvYcCXW6TwsQt8teum2APVVM4e1J3UttTS50RJJ4jfivyFJmmtTkT353yyv9wp5AmQA4uSfE9TGchKeQxOIlhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oKXEU0MQ5aZusFgYD8jsPFUKumId7EeGet625k/j1nUAnI9o
	UAl747cHLGDKx2wLaIlzGh0H8KwBC8mHmAAbVh2LnvyDW/vlx3J/tHc28IodmI0it/VNCt0859G
	zP5Yo7HfMfyXtCT5McHICnF2BxZ8wFcHzDE5J
X-Gm-Gg: ASbGnctaRBByE9F+B9ptIQSzUB+EK2ghpe+hnwdYmKjjDI7WXUvpsEzBkm00tNWuxvw
	vK9IKM2NQdsATWLy/D6rKuuoaJ29EZcxNagXJDs+5VMqiYpACF+0zRQylrbxCoCw0eIjQ0+6OBJ
	g3xCYLPbJSNjEm7vimG9E+MpcADgo=
X-Google-Smtp-Source: AGHT+IERm+N9tbCUGGJ+MXH4US5kbkAUzDlwr9J2QPgizF7Pb9AOwPC7JLew53ElFzF260gr1QRtJjUsfw1DEzN1XTQ=
X-Received: by 2002:a17:903:22cf:b0:215:8723:42d1 with SMTP id
 d9443c01a7336-22540e5a369mr2492205ad.10.1741557443599; Sun, 09 Mar 2025
 14:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307155725.219009-1-sdf@fomichev.me> <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org> <Z8uEiRW91GdYI7sL@mini-arch>
In-Reply-To: <Z8uEiRW91GdYI7sL@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 14:57:09 -0700
X-Gm-Features: AQ5f1JqrzUpfGFvobvIHXzlf0odrxpBbx4xi7Bhn9Q73KD7xZh-f11MEcgp2jP4
Message-ID: <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 3:43=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 03/07, Jakub Kicinski wrote:
> > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index a219be90c739..8acdeeae24e7 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >             goto err_genlmsg_free;
> > >     }
> > >
> > > +   mutex_lock(&priv->lock);
> > >     rtnl_lock();
> > >
> > >     netdev =3D __dev_get_by_index(genl_info_net(info), ifindex);
> > > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >     net_devmem_unbind_dmabuf(binding);
> > >  err_unlock:
> > >     rtnl_unlock();
> > > +   mutex_unlock(&priv->lock);
> > >  err_genlmsg_free:
> > >     nlmsg_free(rsp);
> > >     return err;
> >
> > I think you're missing an unlock before successful return here no?
>
> Yes, thanks! :-( I have tested some of this code with Mina's latest TX + =
my
> loopback mode, but it doesn't have any RX tests.. Will try to hack
> something together to run RX bind before I repost.

Is the existing RX test not working for you?

Also running `./ncdevmem` manually on a driver you have that supports
devmem will test the binding patch.

I wonder if we can change list_head to xarray, which manages its own
locking, instead of list_head plus manual locking. Just an idea, I
don't have a strong preference here. It may be annoying that xarray do
lookups by an index, so we have to store the index somewhere. But if
all we do here is add to the xarray and later loop over it to unbind
elements, we don't need to store the indexes anywhere.

--
Thanks,
Mina

