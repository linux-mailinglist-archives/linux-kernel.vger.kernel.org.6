Return-Path: <linux-kernel+bounces-436458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56989E8618
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FCB1647FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80D15957D;
	Sun,  8 Dec 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imTp3Ie9"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D831155A4E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673299; cv=none; b=QIw1oAL2wvAd11HzPJbXJCQ5g0OcYboXghMbxbjCFsMjdo3IT06IPUteX40pc58xiHuPFL6GKj0dg73A0g4RzvYvlmlq9rDojGe1CiJkaS6KFtGGqXO6jZv16k9HqVL0ulkVOZgrzCuWsnLRntClo4YgF0Bx2oug0rV2J6CQIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673299; c=relaxed/simple;
	bh=sLGXgrOtyFUCSrAr0PZXAw3CO+iv36B75V8uwsPkqk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4MAqezOqZsMJ/axDt+S1O0F7q/zsbVSsnKk9eml6EWBmF4xsJ+LWrwGMRn+rvDhlsZKSSvzETrZ+oFMVK947z3KigIJS/2RxuKw7LFWqXTCPuOh7/27HcH+yD2B7uD7wFonh3fL5Bbnww4waJ5sDSQUMY2WnvsM2wE4eNrqxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imTp3Ie9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so4358987a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733673296; x=1734278096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Ir5Ze5F+Cakp++YqE/4K5mzAf5gGTj0H2toLbkGXQ=;
        b=imTp3Ie9f6Nu41ws/jRN2gZjI2TogcgKWipxSOtO1TTM0EQrhUhmswizQlLM+9JRwL
         1/VPWoOaLCP45fSCeqXhhaUW04qaYQaNexyMEKi3jdbcX0nxJrVN8VlsUX32FLS6ZVWY
         duKxmj9Bweljp5MZ/OIicf8oeRcqXdITCxwMspL7FrF2aEbbuIkkHd2N6T8oR/PCpnbw
         MzIonAYKdzQjOVR84rT104X1VFVKC+T3Xf2cdlf1QFOfE3TLH5VlIh0d7/baokMz6WeS
         TSdRAVyvKmmHUbj45gnIcx2cjCDtpR7/yRgb2rxuDHnqXzHpV+QljMqgSCm60/RJCdEn
         PxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673296; x=1734278096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8Ir5Ze5F+Cakp++YqE/4K5mzAf5gGTj0H2toLbkGXQ=;
        b=Ynh5UuaSNuWWjzyxmzp4y54/zBTYlGwp+l1rH/yZLgcC+ie2apuZGD9xbQ7f3g1J2C
         FiP4/C4GMh/rhl58llNM0//WxqOdsmTz2TbM8fBs6HMQUClyfhHVaOydma/LoyYwXWxS
         WLw+1IwuPDO234NHG9JrLheipTlihD4dj7yawuG/0j2nVuGD6gs//CUtffD0BlpCufuk
         YYeqSU90BySW427ieKVEduCF7WtHcZydY/MNi0IuxM9VtE+XA1deI16dQiq25i7FJNYc
         y9W3x2t1Mtt/LpzsZMJ5eVJMWjhnFg/+dL13SG1Z+/4EPdqSWE3UcIGCdOYMCo441eL3
         Xakg==
X-Forwarded-Encrypted: i=1; AJvYcCUG+WWORvYO+o9wSHI98OzxFubQ9rJgWpeKLuQFt8J/+sfx4MpHeTI9uCgWQ/6RPjqQ6rNAcmJGy1hmsEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2WSboI3+FGOSH2UpxhaSD4+zdNb4yy3sG5RxSuMGCGk7Yn1z
	sL6je3pyPrCEND1aTx+oW2rngNL/sYHIdCGPq0IfqfHWHJqeu9yFai1+FBDapHjPbUxHMHnCqio
	cjY4I2qXIEcfUIdRtQinc1ZwmOKlIjKqZNCNA
X-Gm-Gg: ASbGncuUVWhe7Zt4CFpl1L66HTKHmbvwmG45vAreriVLncg+fWVKXPj6nc+oSSRCODP
	B7Mz9C1yhowQ5mr5HZt52CrrQiXyZM2A=
X-Google-Smtp-Source: AGHT+IHNDCZtWupPE2CKmpqwWgSSxU8NjMFFGRWVi+JYDVnnaUFSF2Bl/ZJ1PGYqEOpPVp+J3GCHhK5AwFATV2K8lgg=
X-Received: by 2002:a05:6402:4586:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5d3be715323mr8666902a12.26.1733673295651; Sun, 08 Dec 2024
 07:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204052932.112446-1-wei.fang@nxp.com> <20241204052932.112446-6-wei.fang@nxp.com>
 <Z1W2lp5jNPqJZi4C@shredder>
In-Reply-To: <Z1W2lp5jNPqJZi4C@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Dec 2024 16:54:44 +0100
Message-ID: <CANn89i+E+kCZCNBtu=XnyLHsMNF=Ks9BkK1+qTQNxrPDQX-Mcw@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND net-next 5/5] net: enetc: add UDP segmentation
 offload support
To: Ido Schimmel <idosch@idosch.org>
Cc: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, 
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 4:09=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> On Wed, Dec 04, 2024 at 01:29:32PM +0800, Wei Fang wrote:
> > Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
> > enetc and LS1028A driver implements UDP segmentation.
> >
> > - i.MX95 ENETC supports UDP segmentation via LSO.
> > - LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
> > ("net: tso: add UDP segmentation support").
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > v2: rephrase the commit message
> > v3: no changes
> > v4: fix typo in commit message
> > v5: no changes
> > v6: no changes
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
> >  drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/d=
rivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > index 82a67356abe4..76fc3c6fdec1 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > @@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, s=
truct net_device *ndev,
> >       ndev->hw_features =3D NETIF_F_SG | NETIF_F_RXCSUM |
> >                           NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTA=
G_RX |
> >                           NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBAC=
K |
> > -                         NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > +                         NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 =
|
> > +                         NETIF_F_GSO_UDP_L4;
> >       ndev->features =3D NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM =
|
> >                        NETIF_F_HW_VLAN_CTAG_TX |
> >                        NETIF_F_HW_VLAN_CTAG_RX |
> > -                      NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > +                      NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> > +                      NETIF_F_GSO_UDP_L4;
> >       ndev->vlan_features =3D NETIF_F_SG | NETIF_F_HW_CSUM |
> >                             NETIF_F_TSO | NETIF_F_TSO6;
>
> I didn't see any wording about it in the commit message / cover letter
> so I will ask: Any reason not to enable UDP segmentation offload on
> upper VLAN devices by setting the feature in 'ndev->vlan_features'?

Going to back to my commit, it stated that net/core/tso.c was only
dealing with basic stuff.

Adding vlan support would need some changes there, I guess this should
be done if there is enough interest and testing.

    commit 3d5b459ba0e3788ab471e8cb98eee89964a9c5e8    net: tso: add
UDP segmentation support

    Note that like TCP, we do not support additional encapsulations,
    and that checksums must be offloaded to the NIC.

