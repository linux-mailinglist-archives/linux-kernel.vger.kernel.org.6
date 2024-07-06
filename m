Return-Path: <linux-kernel+bounces-242993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5BF928FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2C32830A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF541BE71;
	Sat,  6 Jul 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UmS6ar7f"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0A7483
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230144; cv=none; b=ckMlUhx0ELGF6lUqXJEkDseJI9o1C5KcnmeAyNdlurHIhYWM7CJgznDm8w2oj10iCrRoTdKQBoSk/Ymd7kfiJdCaaoMcEgdxeHvqWOlNt4fo6+s+PVt1zUr6T/9ZEufVsXJiF9OP7eT4dx8kAmCgjRZukbk8X+lxryzzfgpzVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230144; c=relaxed/simple;
	bh=ex1DgW/ugHLSPdwkHXbUFL/F/HftU3SgsiKaObspFpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mE8RjKmd1R604VzoLFjsabHr8BVAkhgtFOlojyTem27rrFUi0KDRgL6OHKXZ2kD4pLG2k88GIRuthucb5hro6Aj/Kovh+jF7FUkil0QYcvXAid7ff1aMAVD+wPcHwZJpcy4ejArYOp+UReSq8zooZ0p3xH8rIkwWMHZwnLx0D8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UmS6ar7f; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04A5B3F0D2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720230133;
	bh=3XZ/I8/29Q9OqWgdwL7m4G683taXQm9BCOiYZ403b1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=UmS6ar7faSrl1V8Bsaog2XiMC/0hMCs9vpN6s4e0XWruf5ER9CPxQ55tR/5WeKHL4
	 sJXlGdVb5bMeIABy/OdNhYnX5CJ/M73o3OyXKpfG+nF7ZmaUZftLK6wje0nZW/GVTE
	 0UqP2Nzpn5IajLfuXSJ1vNOMuP+uvju+CZL+xpRyPNgNwoHuxtHRq3ao1AQZxzPwQg
	 WX1IAcLXQ6Gbj33YufsMhs90V0guchB7eIiGjjMFwOtrMPylWEwhLJj/2ldfbpgG2u
	 BpchLQE9YCInr8QlDMFO2LhJxBJUvdK0VRnKEWUnnbkPL6rDJnHrHNhbMHTFK1aQfe
	 wI787YqsULwAg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77e024eaa4so27751466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720230131; x=1720834931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XZ/I8/29Q9OqWgdwL7m4G683taXQm9BCOiYZ403b1I=;
        b=nrd4HEWQRFSoDSFv7X9IFQ6dl/z5jNWWKcMaEZkqBIttqcYCqrKXSTE2gtsZGuB6rs
         bj2pzxYiOhmczYnWtq8cDFV3n6FGF5h6UQHCsVLKfL83vY9C47WeLjE561tU2WD2bst4
         OSMp1NZNSNz8v3zO+KynRTWMwdX+7K+/K4E7w3iDwFjwOFi5YqEtoEYaGdRJWTmJIZ5U
         3pOQvFBOv8avUTlTq9B2qN5undRLiVobVmZ69jO54ZGP706utGew1mIfodMIlBUKrfVe
         OSeigBa9Hx5rUaz/mvRSBss9kQGx9KoE0RKJuNtz2ehVYmqSLELwSgV8TNQ2ygyjPg67
         bnPg==
X-Forwarded-Encrypted: i=1; AJvYcCWSSem5MVlDlbEaVnxct0u4CYPjiyQTlNiIAXW4zHTYIjkYD5tGsTSmzWi6IFoGDu4BoEIpGkGsxGfUqaPWYAth7ujJUapMqiC9sEMh
X-Gm-Message-State: AOJu0Yz18S49U2uV9ZchcI7N3rd1GNU+pkqv11RGNki3lZbuyFKsAVZD
	TqXpuM5XBGlhUGEWIOWaJzoKTK50t+lHLoVtJcrzBq1Z45uNK2VrG/QDjsZvTZ0/hGJza/7LZnH
	GbBILu66w8aGnPIHjIYWabPRrYRd7TW/KyN1kLbQZxJKl0hPIy+AM/fNeuLdHn8ABLLLIeIs2bF
	KgXuLzSChoLVcTFMzie9Mtev/XjHeR/yqgs9v07XRy8/bhiQfrQGJw
X-Received: by 2002:a17:907:7854:b0:a75:25b8:ffc with SMTP id a640c23a62f3a-a77ba7123b6mr362611666b.57.1720230131599;
        Fri, 05 Jul 2024 18:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmye3zDFCxfH2ABGVOnpWkEeJ46xAZ4skOiFrNEtrKcYgmlyPkMNAQ9s/pH4j97WHa+Qnh9GKBHYVavatRWO4=
X-Received: by 2002:a17:907:7854:b0:a75:25b8:ffc with SMTP id
 a640c23a62f3a-a77ba7123b6mr362609966b.57.1720230131096; Fri, 05 Jul 2024
 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
In-Reply-To: <20240705093525.GA30758@breakpoint.cc>
From: Chengen Du <chengen.du@canonical.com>
Date: Sat, 6 Jul 2024 09:42:00 +0800
Message-ID: <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Florian Westphal <fw@strlen.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 5:35=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Michal Kubiak <michal.kubiak@intel.com> wrote:
> > On Fri, Jul 05, 2024 at 10:50:56AM +0800, Chengen Du wrote:
> > The ct may be dropped if a clash has been resolved but is still passed =
to
> > > the tcf_ct_flow_table_process_conn function for further usage. This i=
ssue
> > > can be fixed by retrieving ct from skb again after confirming conntra=
ck.
>
> Right, ct can be stale after confirm.
>
> > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > index 2a96d9c1db65..6f41796115e3 100644
> > > --- a/net/sched/act_ct.c
> > > +++ b/net/sched/act_ct.c
> > > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buf=
f *skb, const struct tc_action *a,
> > >              */
> > >             if (nf_conntrack_confirm(skb) !=3D NF_ACCEPT)
> > >                     goto drop;
> > > +
> > > +           /* The ct may be dropped if a clash has been resolved,
> > > +            * so it's necessary to retrieve it from skb again to
> > > +            * prevent UAF.
> > > +            */
> > > +           ct =3D nf_ct_get(skb, &ctinfo);
> > > +           if (!ct)
> > > +                   goto drop;
> >
> > After taking a closer look at this change, I have a question: Why do we
> > need to change an action returned by "nf_conntrack_confirm()"
> > (NF_ACCEPT) and actually perform the flow for NF_DROP?
> >
> > From the commit message I understand that you only want to prevent
> > calling "tcf_ct_flow_table_process_conn()". But for such reason we have
> > a bool variable: "skip_add".
> > Shouldn't we just set "skip_add" to true to prevent the UAF?
> > Would the following example code make sense in this case?
> >
> >       ct =3D nf_ct_get(skb, &ctinfo);
> >       if (!ct)
> >               skip_add =3D true;

The fix is followed by the KASAN analysis. The ct is freed while
resolving a clash in the __nf_ct_resolve_clash function, but it is
still accessed in the tcf_ct_flow_table_process_conn function. If I
understand correctly, the original logic still adds the ct to the flow
table after resolving a clash once the skip_add is false. The chance
of encountering a drop case is rare because the skb's ct is already
substituted into the hashes one. However, if we still encounter a NULL
ct, the situation is unusual and might warrant dropping it as a
precaution. I am not an expert in this area and might have some
misunderstandings. Please share your opinions if you have any
concerns.

>
> It depends on what tc wants do to here.
>
> For netfilter, the skb is not dropped and continues passing
> through the stack. Its up to user to decide what to do with it,
> e.g. doing "ct state invalid drop".

