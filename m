Return-Path: <linux-kernel+bounces-306625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F105F964175
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1A1282E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DD18FDBA;
	Thu, 29 Aug 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbzXGNGi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FF1537CB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926670; cv=none; b=MWhxQOChIhEn6eIWdEiVgY78kao61S66drgjg541FoH413zsxommOwJOWZC1y8rBCIthFXHoyOCuoziJby8J50QMUdk41H5GsDvYqWvo5i4Npv+8gfTkYbxYZW7Yc4QYT7AiLB4VtFMIMfrp+ZKDEgbDHcorhDK0XfG7jaV8cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926670; c=relaxed/simple;
	bh=wHItm0cKnnaiF4q9fmEemTB6NMjNhRCJeehB+N+PzI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiLmqlMSPW5RDgFLg7iLOuGcCvkzaR/OOLm4fnyn+i3KZaAWfP//moBNLLOscaKyc/1gUqY1FY8ZPSu6DUdJ/W8s7TbOpRxokfnFIhTrty3tDDbwhyZDUGENLIIWHh55Ld+4rYRCGDqOPCkVxqFxiRc4tjq0CCD7CR13Vt23fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbzXGNGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724926667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mmwGYx8IP56w8yEP/hicn/i9wnPK+R/r3F9WzYay6Q=;
	b=EbzXGNGiAlJAHv8xg02g6HWWQ3eVbhtGILeqLO3x2HeV9ZHekmbDZj5asaTOP9ulOIrYU4
	Y/RIyYKzFNjgipKmC1INCaqIYNgdgdj3c3+1fGH2odeN6lPLMCBuwd2F7uqooaCeLVuSs9
	nz+yYOgO64zdT9G/71nSDupbTxRF7EU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-pTEamWpoMiW3w2gN1Qb2uw-1; Thu, 29 Aug 2024 06:17:45 -0400
X-MC-Unique: pTEamWpoMiW3w2gN1Qb2uw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bedba9894dso324836a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926663; x=1725531463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mmwGYx8IP56w8yEP/hicn/i9wnPK+R/r3F9WzYay6Q=;
        b=qDS7x03JEjtjAW+uSnq/zlCmsQbu2A5d5r/1Pg7BjzmzCaxQglDcyhlEOs/Iz55GjB
         AhQWK2g4HaivhCnLCx1SNmRJhMpPGaGS5mavEFj3dP+YUPoUQg9/4z++AA6lxMzhRGJH
         A/HdycrCzUvAMjweVLoL8l2UE37T0tFE4hAkD4hEQGnr9sd0tuDePqJN1X1p856sBNr4
         fcqFCE5ZJEUAAiZP5Mn8YnU/HI3qY446uzGYZnugWPON3wcy4IKuKAuHC+5BmHZXy18m
         Vy/+8+/EfV03zKxbZZminTqLRDepLqVhjPmDp+YledmNp51lm82/Njsg9rFIlQEiu6RP
         6JbA==
X-Forwarded-Encrypted: i=1; AJvYcCVb4LpGzz8IRaF5zD/qGORdsPootP6KTiqLYFrh5DD9KHW5M1KMRBWQ8I0bNGLvZBVMI9tdYeVWVRi2LCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwkjulKb3Z2dEe7gHPK9GIBd3+CzWOkkI7tNxIjZv2ePYHX49
	HIUE++5f6y7AODEsVAOS1j1FKGJSpvDmgclOhuy3JatKbMI36ii7eZgH3nyhw9UbpdvJeIpzF+R
	PLTsc9BxJhWeaC/OPwpEGeJ2LaUpv5PUOXgfM1iB0hP4NMLD05DPfHzKtD/UTuA==
X-Received: by 2002:a05:6402:2353:b0:5bf:a2c:4f35 with SMTP id 4fb4d7f45d1cf-5c21ed3fd0fmr1711576a12.10.1724926662976;
        Thu, 29 Aug 2024 03:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnxtX1dyLotbngOwRntZMasp8GlOKnrQUf/CTxmCFchZTpvVeZZxoc/aKq03HesYuywXiFag==
X-Received: by 2002:a05:6402:2353:b0:5bf:a2c:4f35 with SMTP id 4fb4d7f45d1cf-5c21ed3fd0fmr1711541a12.10.1724926662241;
        Thu, 29 Aug 2024 03:17:42 -0700 (PDT)
Received: from [10.39.192.156] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce784csm527340a12.91.2024.08.29.03.17.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:17:41 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: edumazet@google.com, pshelar@ovn.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 net-next] net: openvswitch: Use ERR_CAST() to return
Date: Thu, 29 Aug 2024 12:17:41 +0200
X-Mailer: MailMate (1.14r6056)
Message-ID: <CF346267-CFB2-4DC9-9E88-C502E1358830@redhat.com>
In-Reply-To: <20240829095509.3151987-1-yanzhen@vivo.com>
References: <20240829095509.3151987-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 29 Aug 2024, at 11:55, Yan Zhen wrote:

> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  net/openvswitch/flow_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
> index c92bdc4dfe19..729ef582a3a8 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2491,7 +2491,7 @@ static struct nlattr *reserve_sfa_size(struct sw_=
flow_actions **sfa,
>
>  	acts =3D nla_alloc_flow_actions(new_acts_size);
>  	if (IS_ERR(acts))
> -		return (void *)acts;
> +		return ERR_CAST(acts);

Change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

>  	memcpy(acts->actions, (*sfa)->actions, (*sfa)->actions_len);
>  	acts->actions_len =3D (*sfa)->actions_len;
> -- =

> 2.34.1


