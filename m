Return-Path: <linux-kernel+bounces-248609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF792DFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F2A2836E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F298823DE;
	Thu, 11 Jul 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="uNwFtapn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BA74047
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676419; cv=none; b=eUTlp4Oeddw5P0D8bS4JzsbszY+hFnA1eiYdkVgs9ihpSF04lwqbNrG7hqkexR1duLHS7EscjS4j76OKRH9NRA3ViTsOBBdkQazPbydFO1ViCiNI0SesIP/psAft9Qt/69dduQPNXQoqHAOgCE194kQlOXy5o4UkhqmObMiWLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676419; c=relaxed/simple;
	bh=er2u/C0ayZ13lixi8pV/7AwVK//BH86gyj62gEdZx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L84KvqqaBevUSJSTpko3iXREEp15pgpzS/8C1k78od6B2Ym7Jzd62eSmei3aaqgqrHWXT9ush3ivmWeL8/4BGvJD6tkgWYO4hv9/l0Q3um9R33OxtfuqEV7caUV6/uDutgLhV8iCD/p7QzXNweGRxXezlqsROJqwJoO4BIjiIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=uNwFtapn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso671031e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720676415; x=1721281215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtQfbSYXmPmFxIghTAuaXxtKY59+oSbNVAa06oAvgE8=;
        b=uNwFtapna79wdTJKkHWqopN+thTpQZnZjgTuOPCM8QpZaYpNuSWFiosCRNIOvCBdWR
         XUfoggw+CZ+8DS4HCLGPiJVnNRFM7/Yz1HeYhON0Re3/UXVLFRzRmiE68FUNkbMBWyEL
         S01597pyjPBHeYZYnTvTY6ojpmuHeA3QwALvp7WMn70jsGebKTSs1djASJrSh2xskf1v
         HOFLKQLb8bQdiQkWAZBeDlDtlTYYNic6uGlVTj5P3FXkPsxh+MfxnEkODIFvh0ZfpKjW
         r/8O5QwKg3WDk7clFIs4FPBTx/XmmnGf8xheixKOx2fWPED+SYV9IH/Htus/XYRmCgsD
         As5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676415; x=1721281215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtQfbSYXmPmFxIghTAuaXxtKY59+oSbNVAa06oAvgE8=;
        b=J4gWmwt5Hl313OYll9iwWJX+VaYQBvzI3CT/SESIVrkCk6GZGrKjvK6rSxRpAeHr6o
         USO1uePixag4dsHBNaNGZeCtuCcdjINgh3c+tPq0ZAX7Lc1+/dpoQFdTxuhy/s4FaIR0
         n9TLR8vH6ZPChbWv1XYJESWqq7C2LHdxg8HW9KudCurwD+wBjy2zbeRXkh8TmjC4uHHZ
         Uuk7gsnI5mBSEtr8rpZlCfEZsj+XaOingvWKSaDeMzLFoKK3Fq/NLSpcfC/AzSKiXK5a
         Z88IfgAFA9g8NVXAaRCr86icBh3jHi78PgdivHVxsEDUHGvvEoOPqAWW0N0oGZQBjzlf
         u81A==
X-Forwarded-Encrypted: i=1; AJvYcCUJHPyGtnCckkeDr06T098kBbPtHCboVeZZdj1PVL+SQfHC45FdE1FykoD6fIO3MyVRspwXyZOfCI7Bcrh9Cu5EkNKAhQHMtrPn7E8r
X-Gm-Message-State: AOJu0YxCy/5RtTelNz4oLyqF4WC2fHAgsRzv3QnJ4VmR3EwZtNUy+mE3
	m0wwksM+liCzPTaoJ5NKfTYTlybsDXW64X1KpfZSH9PayFgY6eMDL+WjyjlBLmUm7DR6AD3Sytn
	30Ap41v2VdUzxaQ2RQV8Qv2mY9MmDMoU6xYIbzA==
X-Google-Smtp-Source: AGHT+IF+BKDpNJnivyTpTW415g8VRESZbb/7e56pM3pMEuHmh9WnGF7mjq0NVvmuJHBA9fsXR2GqhBai5y9XkJzcVSA=
X-Received: by 2002:ac2:5544:0:b0:52e:751a:a172 with SMTP id
 2adb3069b0e04-52eb99d288dmr5355776e87.49.1720676413776; Wed, 10 Jul 2024
 22:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620113527.7789-1-changliang.wu@smartx.com>
In-Reply-To: <20240620113527.7789-1-changliang.wu@smartx.com>
From: Changliang Wu <changliang.wu@smartx.com>
Date: Thu, 11 Jul 2024 13:40:02 +0800
Message-ID: <CALHBjYFn_qB=Oo3TTg0znOnNz9rX5jP+eYSZbatAN94ys8Tzmw@mail.gmail.com>
Subject: Re: [PATCH] netfilter: ctnetlink: support CTA_FILTER for flush
To: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PING


Changliang Wu <changliang.wu@smartx.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:35=E5=86=99=E9=81=93=EF=BC=9A
>
> From cb8aa9a, we can use kernel side filtering for dump, but
> this capability is not available for flush.
>
> This Patch allows advanced filter with CTA_FILTER for flush
>
> Performace
> 1048576 ct flows in total, delete 50,000 flows by origin src ip
> 3.06s -> dump all, compare and delete
> 584ms -> directly flush with filter
>
> Signed-off-by: Changliang Wu <changliang.wu@smartx.com>
> ---
>  net/netfilter/nf_conntrack_netlink.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conn=
track_netlink.c
> index 3b846cbdc..93afe57d9 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -1579,9 +1579,6 @@ static int ctnetlink_flush_conntrack(struct net *ne=
t,
>         };
>
>         if (ctnetlink_needs_filter(family, cda)) {
> -               if (cda[CTA_FILTER])
> -                       return -EOPNOTSUPP;
> -
>                 filter =3D ctnetlink_alloc_filter(cda, family);
>                 if (IS_ERR(filter))
>                         return PTR_ERR(filter);
> @@ -1610,14 +1607,14 @@ static int ctnetlink_del_conntrack(struct sk_buff=
 *skb,
>         if (err < 0)
>                 return err;
>
> -       if (cda[CTA_TUPLE_ORIG])
> +       if (cda[CTA_TUPLE_ORIG] && !cda[CTA_FILTER])
>                 err =3D ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG=
,
>                                             family, &zone);
> -       else if (cda[CTA_TUPLE_REPLY])
> +       else if (cda[CTA_TUPLE_REPLY] && !cda[CTA_FILTER])
>                 err =3D ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPL=
Y,
>                                             family, &zone);
>         else {
> -               u_int8_t u3 =3D info->nfmsg->version ? family : AF_UNSPEC=
;
> +               u8 u3 =3D info->nfmsg->version || cda[CTA_FILTER] ? famil=
y : AF_UNSPEC;
>
>                 return ctnetlink_flush_conntrack(info->net, cda,
>                                                  NETLINK_CB(skb).portid,
> --
> 2.43.0
>

