Return-Path: <linux-kernel+bounces-260906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F093B010
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE28F2839B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0C156C52;
	Wed, 24 Jul 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTKKvC4D"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270B1C6A3;
	Wed, 24 Jul 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818992; cv=none; b=nzfMwfreTwrHOzvFYTMT7rBIBadvuNVraajtI9x8IeV2VHTxY1D2Mz3ZdmSXMq+I1Zs2jGYdHnBoPQmNpUMi/ato7N9nQ0Z08u2ypX6abfMIrhJab2kZdgNuDzJIRZC6Xlzycci2QQ9foHKsrPTL7dyEG39vy6ZOchSFDCd0kPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818992; c=relaxed/simple;
	bh=ZN7NNcyU0S1YfbfqhcSpoRrSZCDKUwIk4FytmHMztN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwKSPnB+ImOvHNSoejDafwZZ2H6ozTX8NalyB+ywp+Pou/GtYWfH46tTLV25NtGvrAwMC7gJTtHmOQutENBo60GgQ5JsK7yAAbO6HEFWHRFYF+/QRtrOd0p4tF1dYCyqowZeWEsWYJmX27QjRReLXoce1dvunIVvQT5rYsDVNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTKKvC4D; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efd2221efso297876e87.1;
        Wed, 24 Jul 2024 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721818988; x=1722423788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyZGnPtusGipb+xlX5GGLVHXWIPkIHym0QAfrDKBQw0=;
        b=aTKKvC4Dhfh1Dimwhc2UNs9cf5dz6738tcPayxDCoBiO9/fifzGOJXQfAFRV2zOr8f
         4uJrLn+nQOlS6ITdVaZ4xqXqFKrrzZJ8bhgjQ5oWKM9KnDe53Dd+JH9vi1cdsiUVow7W
         27bSGrC8Mm0ZFlxs/GwSCG3ptjvI48o93rIQdtujETqZlMEgtSrju2M4kH9j/1MYjmNN
         f2M96irsYRddgsPQ58OItuo5kWJCDjD2jIAZUkj0E0qOvysXeskcEFrnQ5OvuNGVw/Jq
         7IObnshBX9yQZ3T3AU01IUcZ04qTs04YQv9SWj+R+Uh9s9byWm5xL3ZkDWayLQ8zv00V
         s6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721818988; x=1722423788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyZGnPtusGipb+xlX5GGLVHXWIPkIHym0QAfrDKBQw0=;
        b=FCzvDn4/oe4NtJ4/I2W5S327l9ZpGiINDV6jTCAkuXBrfG1JZfVMNpO1SECdOf8SBT
         H+xq59iGsVv4mYRFcltXkV0xAy+yeYPbJoRKVoe2ohrsjGllPK9xJxko54af16RQOwX9
         LcPxTKWJrA+QGkQUxypxvxQf2bsf4hLneMQn/y2LVF69D7v+zCOfUnCU06FShKlPlanD
         BzUTyLwqMaCSAvuOGbCzaEYtEicN7V0jp1K7KOcNkPM1SYP7xOCKpHWruXSu5AXPQIWp
         pzOBlkIGIbKwvaQLeSFicNnMU1UYGpxvC0ZZLlRweAC0/JHVXUV2xVImf8tPbOwuJ5Kg
         P0fg==
X-Forwarded-Encrypted: i=1; AJvYcCUVIohd/rUeNMLT/00N/JTb7pkyu6DOl8Dq26Gf6kthXUhWKb1TrAQuYMbhF3hzGjqTDH/aLje4qTTp@vger.kernel.org, AJvYcCXiIQ1ntyN+RCY1nLNN2S4FLi9Jdsi4grm9GKOzGWUeIzq5HfnwzGDK5ojt48AFJnmiNCICJtwhBVBcAUbc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K3XcGy8JTIi5Cne8/5W92kE9Nos66VlJVjVDI8dCmDThJfYU
	+1YfD2US7QXd1Bd6ZpRm9EKE+7oRBsyaWGtj5dV9a/zFHp5RYMdKtexhh8/qp+XHgJyTTr3rQ8z
	Cw66ueO+0K+cAaVRt4wywOuHD9hyDSyJk
X-Google-Smtp-Source: AGHT+IHZ28WTL9zR0J5KAqNR5wSGYqOK6qMP43wFHJpRsp/GYZIHczD0y+ox1z8i9Eixd7+YrYjgxA4F1tkro8kjh5c=
X-Received: by 2002:a05:6512:3f29:b0:52e:ccf5:7c3e with SMTP id
 2adb3069b0e04-52ef8db6223mr4997174e87.7.1721818987347; Wed, 24 Jul 2024
 04:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724105847.46962-1-tarang.raval@siliconsignals.io>
In-Reply-To: <20240724105847.46962-1-tarang.raval@siliconsignals.io>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 24 Jul 2024 08:02:55 -0300
Message-ID: <CAOMZO5AuiYD4KBZcfELRZsjEYXpPi7zGprvC7vq0hxfp75v5_w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: Add Ethernet Support
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tarang,

Please mention the board name in the Subject:

arm64: dts: imx8mm-emtop-baseboard: Add Ethernet Support

On Wed, Jul 24, 2024 at 7:59=E2=80=AFAM Tarang Raval
<tarang.raval@siliconsignals.io> wrote:

> +       mdio {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               ethphy0: ethernet-phy@4 {
> +                       compatible =3D "ethernet-phy-ieee802.3-c22";
> +                       reg =3D <4>;
> +                       at803x,eee-disabled;
> +                       at803x,vddio-1p8v;

These two properties are not valid and not documented anywhere.

