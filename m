Return-Path: <linux-kernel+bounces-520550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F5A3AB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A68173C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26031D6DBC;
	Tue, 18 Feb 2025 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsrLK/3i"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38911D5CD3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915515; cv=none; b=M/1ChNzmoRLcAqBh6i1nRfOg4WbKK68xwQbIqnrJmF/mi1YrBUHJqcPjx9qIw+rW3HDwX/c2S5d3IQmyajmBVdXzu1fGUxVkR248VYf9CaEzguXXFSmhZFPJcly9Qlnq+m73504fFNT9dUoIpoGVJ732UAIYZB0xn6nEfizdtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915515; c=relaxed/simple;
	bh=3CDUJavJ/w2Eyz6VWoYc/R+F8v/kR/eR9xKGteJ8Cfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oURj53IcJJlenD36+7HAQCXf1mA7euy6s5cKnDjcxAElIacucarNBbzDJ3/Snbe2fK/sNBHRR/pKv2RQZQiGA/ZTBduvv6UVD+owJyIzZLj67JnZ9Ktc3zIaxHWFoaL3mV1eeTTLrQ7Loy90kHhfOf09rYQEIiVz+2YqHsuDUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsrLK/3i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212222d4cdso392385ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739915513; x=1740520313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UGIfcSBO6nPRNgzLOD4hhxNfN7xC9ou+BofcFQJ5rE=;
        b=CsrLK/3iEhGFvuDmuuJ1A4BIaZYF8IJ0OFgGNcqhstuojxzCZ7v6tsLxI1M6/WblhB
         GEZe5LBoTaltiKhQWnzskvWBha79hQt2bNsOMY1IuWb+obRjOkOZ11gTxHv6afjQz2pj
         NhzglQGrnAbF6tei+07+LJmp2ZaP91WVXL2HmyGXNrtCbdFLaN3iszPmKjsuHTAkqX1g
         uc1epeMQaylvUdPF1BO673GSx9CR107m6jGjxovPg4mOgAzhPXTvkB2u/1Y6/p8itgLq
         cSRjNk5l7lrd/QctFqQaH28SkJMquosLCobc58WaKdvuw4jEh+Yx9pCmkJru2E738wiI
         KC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739915513; x=1740520313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UGIfcSBO6nPRNgzLOD4hhxNfN7xC9ou+BofcFQJ5rE=;
        b=djbemwlycTA84M0BGJut6gsAJwvAfyCW9fihSNI7TcqvRGW0Gdu7iiiAnw2H87TDxd
         aZkygF8sUOBNB5hb6HLUVwyNO7pMzyTqa9ubTap9HAoV10htwojSaHh7KMsDeqk9SgsK
         6wn2RfMPn5HBvLMw3RDNYDRbrPWzu5/iHUl5zsYRCXTJu2bnGU1mfa8xPeto1Y1Ypunt
         ZGiWYH+rVabelY4CtQk1E/COpteY0d7byl83RBAW1UpTx68btnp75WX+ete/RR7Bx0Rj
         5hSIn+C1P0BcoSVmSG/66T7TzkY84fob4un612UuFlNQyYbEgKMnpm2Qn0T9m8Ma9xRS
         9GiA==
X-Forwarded-Encrypted: i=1; AJvYcCXgfVhulTHDWFUt6/7ddAtYHxm3oNDnBflkAUMgtZqiEDvEIitJ8zok+AWkhS5kpBcI9uJZS7llc3b2mQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIX0gZtZf4YATci2wf6qZ5Cj3129k0hfvmuM9LxV2jXpORbiN
	k9tK/6k0X+eCJO5xJFxYKrdSZCF4FhL6HfYDHXLlh0o+y/dDwxuZAdGbILIBeXab9D2BRLAXxgr
	1J943V7H0r4J+Dsg/lq4kXzSc7ADBuwZvbHzk
X-Gm-Gg: ASbGncspxxlgd5cfP+AV1n3xlKPDGUvOia+S4CGxWgL/+ybo8IkF8IgHAC+S0lF/asW
	6dVftycOdL2CIAY0Pkmlp/26pnuFfm74F43I2/kfhKb4m3Z2MlqqW7Hj1FbOhnovooFu9Aa06HX
	aZtDLhRmYwercNgiR2e2E0NZGmSEk=
X-Google-Smtp-Source: AGHT+IFxN+I6Pcm4D/MWcGGzuqiVfnA3lm6uCP2yMFXY/srLZuNcuFLVdARwU8ZoZScSvTimcKvb5jsOUISnTbTNl60=
X-Received: by 2002:a17:902:ec84:b0:21f:2ded:bfc5 with SMTP id
 d9443c01a7336-2217429ec2cmr646285ad.28.1739915512661; Tue, 18 Feb 2025
 13:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218194056.380647-1-sdf@fomichev.me> <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>
 <Z7T48iNrBvnc8TZq@mini-arch>
In-Reply-To: <Z7T48iNrBvnc8TZq@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 18 Feb 2025 13:51:40 -0800
X-Gm-Features: AWEUYZmi1pNM_ix_ad_TMYM6qsRS6rUyvQfajg5wC41TxsXXmNmKoHWvga_pJgo
Message-ID: <CAHS8izOu33xLNQUJZgKq971f+rfzqaj0f5CG8sQ7U3pKth_QBA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org, horms@kernel.org, willemb@google.com, kaiyuanz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:17=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/18, Mina Almasry wrote:
> > On Tue, Feb 18, 2025 at 11:40=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > Currently, we report -ETOOSMALL (err) only on the first iteration
> > > (!sent). When we get put_cmsg error after a bunch of successful
> > > put_cmsg calls, we don't signal the error at all. This might be
> > > confusing on the userspace side which will see truncated CMSGs
> > > but no MSG_CTRUNC signal.
> > >
> > > Consider the following case:
> > > - sizeof(struct cmsghdr) =3D 16
> > > - sizeof(struct dmabuf_cmsg) =3D 24
> > > - total cmsg size (CMSG_LEN) =3D 40 (16+24)
> > >
> > > When calling recvmsg with msg_controllen=3D60, the userspace
> > > will receive two(!) dmabuf_cmsg(s), the first one will
> >
> > The intended API in this scenario is that the user will receive *one*
> > dmabuf_cmgs. The kernel will consider that data in that frag to be
> > delivered to userspace, and subsequent recvmsg() calls will not
> > re-deliver that data. The next recvmsg() call will deliver the data
> > that we failed to put_cmsg() in the current call.
> >
> > If you receive two dmabuf_cmsgs in this scenario, that is indeed a
> > bug. Exposing CMSG_CTRUNC could be a good fix. It may indicate to the
> > user "ignore the last cmsg we put, because it got truncated, and
> > you'll receive the full cmsg on the next recvmsg call". We do need to
> > update the docs for this I think.
> >
> > However, I think a much much better fix is to modify put_cmsg() so
> > that we only get one dmabuf_cmsgs in this scenario, if possible. We
> > could add a strict flag to put_cmsg(). If (strict =3D=3D true &&
> > msg->controlllen < cmlen), we return an error instead of putting a
> > truncated cmsg, so that the user only sees one dmabuf_cmsg in this
> > scenario.
> >
> > Is this doable?
>
> Instead of modifying put_cmsg(), I can have an extra check before
> calling it to make sure the full entry fits. Something like:
>

Yes, that sounds perfect. I would add a new helper, maybe
put_dmabuf_cmsg, that checks that we have enough space before calling
the generic put_cmsg().

> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2498,6 +2498,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, con=
st struct sk_buff *skb,
>                                 offset +=3D copy;
>                                 remaining_len -=3D copy;
>
> +                               if (msg.msg_controllen < CMSG_LEN(sizeof(=
dmabuf_cmsg))) {
> +                                       err =3D -ETOOSMALL;
> +                                       goto out;
> +                               }
> +
>                                 err =3D put_cmsg(msg, SOL_SOCKET,
>                                                SO_DEVMEM_DMABUF,
>                                                sizeof(dmabuf_cmsg),
>
> WDYT? I'll still probably remove '~MSG_CTRUNC' parts as well to avoid
> confusion.

Yes, since we check there is enough space before calling put_cmsg(),
it should now become impossible for put_cmsg() to set MSG_CTRUNC
anyway, so the check in tcp_recvmsg_dmabuf() becomes an unnecessary
defensive check that should be removed.

Thanks for catching this!

--=20
Thanks,
Mina

