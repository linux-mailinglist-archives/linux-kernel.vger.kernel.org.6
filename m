Return-Path: <linux-kernel+bounces-244117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB96929F68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BAAB274D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3386F30B;
	Mon,  8 Jul 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JrnxO4dt"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3834CD8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431609; cv=none; b=aSBQU1pz5XSdDLCxMxrz0sZeO0j1sTqw1jwP+HJIWcfC9s6spf3g2kR827HgLAjv/6n9qnLipdaDFRZfE7xbWq2xQlZUuWK4VzFBrtppDAyLrSmZp0CFeT8XuRS3IlZfzo0QWLQluHGB4oqwe9h42NOIhGXb398IxxEo+zXBHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431609; c=relaxed/simple;
	bh=WaFvJOB3LuiYAl5tSbw8XBeRtas3+9eoV/NljR6xXu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdxmLhoZlnGapU2A0jo4+Qd0xxKD3bWu3LOzf7yqPOCM9533TgAPWB8pAgtFP4ClMiJqnmDtIKRAo84PS9FxAD6T8oBiJwUOH9tGqC9vx9yPPxcKud6g824RqzFaM9k4uJaWpsxzj9Aar/BhlAztmTWnB9OCi3V2CE7MM1jlQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JrnxO4dt; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CC3803F630
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720431602;
	bh=7ei+RMDKGt0qavUEnbUSXeg6e8zBixhaGO9TYuEP2Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JrnxO4dtSCSti5Qln6bffbctd6AGOqfYHOV9FBD4SKC/B6oAOLsoSr2oBWmv9sN+d
	 ySLdtyG6vkYYFsZlCddeX3inMD6pT7XHncMMMryZG8RodDVV3S4oyXj3mo6zKJbd2C
	 Na+QxW/qsCVw26fLQK1hIFfIoXw8TWdd1CiIbFC+lUvN1UCtTpeDIeSTkOKFrtff4U
	 llNZ+7WxHUNOfrXtiPCe5M9qFIChJZ88mMCq4taKsxh2kzM9HaALf5i4Z8aDCJmA9x
	 aTSMtobKXgNvGBMZktytus+vn4tiin7x3PuKxDOLuTdGYJ7i6gG/UIZB/yDeojMkO8
	 HyGSczPXyRG3Q==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77c20f3adcso268736366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431602; x=1721036402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ei+RMDKGt0qavUEnbUSXeg6e8zBixhaGO9TYuEP2Ck=;
        b=eBO80xoFJfvT5/UBMEDExpNyLwqYhIOm4pxNG+eePvlY77ul/R5MekP4OhRpde9iKp
         +EyKKDit1Hacp94bs5QdKvBUyvhPxMMS+s+dFNKH4/SfwIkdJV13YK8U1Zm7289FJtKF
         CGaH+slUJJnDMh5/RZxiLHmGF7OXS64langMLLnADCw0rpb0a6JkOZNUu7ou5+kRIrZr
         4LfcTdQqPZUIImx5dH+ODC7pzoV0H40EN9OhnZD0oLdV0nGxaZWkkm5AJZL8BkysYj/Q
         w9gryv93i2sjQmBFyJwBC1H15DwIhK3CfGEiJLGFvvNNIwrxU+pBsQRjaIB16VN4EeY0
         YySg==
X-Forwarded-Encrypted: i=1; AJvYcCUsZnLhrZpmCEKthxK/6MTq4IaKzYUqOAA2WRKr9qaDE9kaXvbf+m6jIzVeKhwaCCZt6rumj9E7t1nb96pEfbw+aE7dQTMmvHAlUZfI
X-Gm-Message-State: AOJu0Yyg0vyuHABPajZWahZLsaCDC8h30GbBD84i6PApOgIgYZ14q3Vv
	ymRZUj/2wOt0cWMt+nRrrDaApgHqYcjqtofFwKKlpizt8kfVSs1tqju+n1ojpkAPM/qxtnOKEWS
	w0bC/iexYhM0PY4dD7WtwGonbQISzlrPxXTbdvAaVAzWV69tGuGFENquPqsxHNyBMx9iECMovL3
	kWL66g7texZG20VoPBDJetMymvgpq78yt7Z9pX+S+nZOEwABDI6J8s
X-Received: by 2002:a17:907:9620:b0:a77:b54f:c25e with SMTP id a640c23a62f3a-a77ba7097c7mr844317866b.53.1720431602395;
        Mon, 08 Jul 2024 02:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY8/evpdBw/IfUE6NzTQP9L4Tw6quV4206So53Zy4ouW7JYhzgqtmgj/ZFwKu+7dYfhWhJqGqDKpcGa/fQFQc=
X-Received: by 2002:a17:907:9620:b0:a77:b54f:c25e with SMTP id
 a640c23a62f3a-a77ba7097c7mr844316066b.53.1720431602031; Mon, 08 Jul 2024
 02:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com> <ZoukPaoTJKefF1g+@localhost.localdomain>
In-Reply-To: <ZoukPaoTJKefF1g+@localhost.localdomain>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 8 Jul 2024 17:39:51 +0800
Message-ID: <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Florian Westphal <fw@strlen.de>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:33=E2=80=AFPM Michal Kubiak <michal.kubiak@intel.c=
om> wrote:
>
> On Sat, Jul 06, 2024 at 09:42:00AM +0800, Chengen Du wrote:
>
> [...]
>
> > >
> > > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > > index 2a96d9c1db65..6f41796115e3 100644
> > > > > --- a/net/sched/act_ct.c
> > > > > +++ b/net/sched/act_ct.c
> > > > > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk=
_buff *skb, const struct tc_action *a,
> > > > >              */
> > > > >             if (nf_conntrack_confirm(skb) !=3D NF_ACCEPT)
> > > > >                     goto drop;
> > > > > +
> > > > > +           /* The ct may be dropped if a clash has been resolved=
,
> > > > > +            * so it's necessary to retrieve it from skb again to
> > > > > +            * prevent UAF.
> > > > > +            */
> > > > > +           ct =3D nf_ct_get(skb, &ctinfo);
> > > > > +           if (!ct)
> > > > > +                   goto drop;
> > > >
> > > > After taking a closer look at this change, I have a question: Why d=
o we
> > > > need to change an action returned by "nf_conntrack_confirm()"
> > > > (NF_ACCEPT) and actually perform the flow for NF_DROP?
> > > >
> > > > From the commit message I understand that you only want to prevent
> > > > calling "tcf_ct_flow_table_process_conn()". But for such reason we =
have
> > > > a bool variable: "skip_add".
> > > > Shouldn't we just set "skip_add" to true to prevent the UAF?
> > > > Would the following example code make sense in this case?
> > > >
> > > >       ct =3D nf_ct_get(skb, &ctinfo);
> > > >       if (!ct)
> > > >               skip_add =3D true;
> >
> > The fix is followed by the KASAN analysis. The ct is freed while
> > resolving a clash in the __nf_ct_resolve_clash function, but it is
> > still accessed in the tcf_ct_flow_table_process_conn function. If I
> > understand correctly, the original logic still adds the ct to the flow
> > table after resolving a clash once the skip_add is false. The chance
> > of encountering a drop case is rare because the skb's ct is already
> > substituted into the hashes one. However, if we still encounter a NULL
> > ct, the situation is unusual and might warrant dropping it as a
> > precaution. I am not an expert in this area and might have some
> > misunderstandings. Please share your opinions if you have any
> > concerns.
> >
>
> I'm also not an expert in this part of code. I understand the scenario
> of UAF found by KASAN analysis.
> My only concern is that the patch changes the flow of the function:
> in case of NF_ACCEPT we will go to "drop" instead of performing a normal
> flow.
>
> For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even after
> the clash resolving), I would not expect calling "goto drop".
> That is why I suggested a less invasive solution which is just blocking
> calling "tcf_ct_flow_table_process_conn()" where there is a risk of UAF.
> So, I asked if such solution would work in case of this function.

Thank you for expressing your concerns in detail.

In my humble opinion, skipping the addition of an entry in the flow
table is controlled by other logic and may not be suitable to mix with
error handling. If nf_conntrack_confirm returns NF_ACCEPT, I believe
there is no reason for nf_ct_get to fail. The nf_ct_get function
simply converts skb->_nfct into a struct nf_conn type. The only
instance it might fail is when CONFIG_NF_CONNTRACK is disabled. The
CONFIG_NET_ACT_CT depends on this configuration and determines whether
act_ct.c needs to be compiled. Actually, the "goto drop" logic is
included for completeness and might only be relevant if the memory is
corrupted. Perhaps we could wrap the judgment with "unlikely" to
emphasize this point?

>
> Thanks,
> Michal
>
> > >
> > > It depends on what tc wants do to here.
> > >
> > > For netfilter, the skb is not dropped and continues passing
> > > through the stack. Its up to user to decide what to do with it,
> > > e.g. doing "ct state invalid drop".

