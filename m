Return-Path: <linux-kernel+bounces-524692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53EA3E5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FF3420300
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAF2139BC;
	Thu, 20 Feb 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrbJr7r5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC01DE896
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083609; cv=none; b=kA8nZ8CpYS+zG39/tbiwUa+1izavDYUtKS2YjCWzlH5PkLOCizlqlZAcTleEQlsi4tt0WxSd+4yBLfv483mtHL1Z4TetGBoJEu6p8ZbbCXdnAXtyxE6pAy3L6lJILB/Q+wySieN73/m99SoD2nU8F9a2AGHYCNH2W87bdj4qzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083609; c=relaxed/simple;
	bh=4lTYQPnj1G0KIZ75wuzMVgktOAM+fH5Z7qXuzrTrHRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU0O54NPNM/Vm6pq5O/CqlScnd1SIqkIW+c7EWIgXfb5NtML0J8J4lpebNH9qTVfL9z8FpUhNumOyQRiqiVNGJg/SrinsJvxdtxyKKV7ZActTJUh+5hiMXo6zhTlgsmWJGtwOKE4Xen6FVrZCWtYo8B6TcArC841hR3TWfzLbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrbJr7r5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f504f087eso1219220f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083605; x=1740688405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUxRiLX4DyVPlrMacNkPsStsx8cpP9d0LZJXAgp6S6A=;
        b=WrbJr7r5fKIUY2bRXtChIOy3TzDkdTXdbTaf+/OzBtyv7PeeJk6zI1u+VyZmQS+Y3y
         8+UhOSqMVvpChr7QbJRO4yKBDPnniytmyTohVpq8s/Xg4U4FCZM6wcnqb0Y6dys53Pe8
         /s+Kw4DWCi+zXjN4oc7nC1B2zm9+v4oID2ljHVoj3qZRxOr+BjwXgZOwrehFX19S36dO
         RVWn8KAYg58OCaNFW9hRThMNuj7gqkckc0zUjG6kdZpPtSGaoCqmFhd57fuz/76xX3UQ
         lDJZSt65b7wjlKqMpLKybnayk/eC4IFZ8242DMl3KTDsWvaCUmTmxvH3gTOg/JZPOKXf
         qTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083605; x=1740688405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUxRiLX4DyVPlrMacNkPsStsx8cpP9d0LZJXAgp6S6A=;
        b=QpFMXCP3rkgORUCaod0Udtpf4tpPpSjXWQnbvHOJUTjqJvARG0efbBUNWpwaKeY1VJ
         cE1nTI+sIMFH5UTT6uSZApXVSICkAsajB/ks8mm5AZKQSBFnumQ/FptOJfts2H1cpxce
         Yw42Nx3E2/prKdRwbCf0WTsVDScnoNCJF05TcokNWeEp6GqdKTSHX4mjMGLjqefjoUuw
         rPW+1aLm34OJCjcwIcC6AcfI2itvB9fxrib3MCNEPn1MWfnyCHV57BkQaOIVJ/E0DXT/
         EWwbjlxBmoMimpDh9V41mXOfEts/m9UoL8K94iADhnojM9mnWbSnjKZgWhkTmn43GtzW
         +73g==
X-Forwarded-Encrypted: i=1; AJvYcCWRsDHYa32QM9mZgKUJPE2C8G00whe1HgocMHUThLHp72hH3vpQsGYN6Sh3UK/D4JOJphOspMWLh4lu4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcx4afuEOFfxBssxr5VU4jIempioAjfqarsbKCcz4W5zsie1Ff
	3ifR407LAJ4smQDHsNdtedl/zaVdq2XcBsinZMLQXBP1qWL6JTYV
X-Gm-Gg: ASbGncvc3kVB4fiImPE/qlGUfXFYTSiucPhssteQjfB6VJUNCU7yRikGqq6woKuWH99
	KtgAzUBByVin6ANU9DWpE4gUqeTGBa+MkTzKWyZCFJfbqugPp3Vzdng0815yngTonmOEOpiswUM
	kYzmbaKblCf5cYpjVxZtsUnFvO8271k5+xyxnNixBEf29sbybcsjvJvE5ZwIzJwuzSnhwYYRihz
	0L46RtOGdmzwAqDLEfEqsfxDqppko0IYOvwBh+cSli/qaYjPMKmg4eCbUG/Ys+CVS07PSoO3Ki7
	8KRikqSx1TWuBDERp5xLFihinpzBRZdHvsEIlaAlJZ4eBnrVj7UsFSbOn/xlm4O8V0A=
X-Google-Smtp-Source: AGHT+IG3ll1f11+UZwtw+Jor04/g1jCvuU4qYpcPBlXzdyIiMI+7ByMCtbhip+csjv0HRfpmtu7BRw==
X-Received: by 2002:a5d:456b:0:b0:38f:4e50:8b0b with SMTP id ffacd0b85a97d-38f6f0630d5mr472733f8f.31.1740083605337;
        Thu, 20 Feb 2025 12:33:25 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4158sm21289979f8f.3.2025.02.20.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:33:25 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Philippe Simons <simons.philippe@gmail.com>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [RFC PATCH 2/3] phy: override dr_mode for phy0
Date: Thu, 20 Feb 2025 21:33:24 +0100
Message-ID: <2428472.yKrmzQ4Hd0@jernej-laptop>
In-Reply-To: <20250118102207.9339-2-simons.philippe@gmail.com>
References:
 <20250118102207.9339-1-simons.philippe@gmail.com>
 <20250118102207.9339-2-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 18. januar 2025 ob 11:22:05 Srednjeevropski standardni =C4=8Das=
 je Philippe Simons napisal(a):
> PHY0 mode is fully determined by the selected mux route.
> Ignore changes requests from controllers.
>=20
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

Some context is missing. Why is this patch needed? Which scenario causes
issues without this patch?

Please also provide cover letter to the series, with "big picture" explanat=
ion.

Best regards,
Jernej

> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinne=
r/phy-sun4i-usb.c
> index 24fbabe7a..f163b355e 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -544,6 +544,18 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
>  		return -EINVAL;
>  	}
> =20
> +	if (data->cfg->phy0_dual_route) {
> +		/*
> +		 For SoCs with dual route the PHY mode is fully determined by=20
> +		 the selected mux route (i.e. USB controller to use).
> +		 As both host (EHCI/OHCI) and peripheral (MUSB) controllers uses
> +		 the same PHY, both drivers can try to set PHY mode.
> +		 We need to ignore this requests, but not report error in case
> +		 of valid mode values.
> +		*/
> +		return 0;
> +	}
> +
>  	if (new_mode !=3D data->dr_mode) {
>  		dev_info(&_phy->dev, "Changing dr_mode to %d\n", new_mode);
>  		data->dr_mode =3D new_mode;
>=20





