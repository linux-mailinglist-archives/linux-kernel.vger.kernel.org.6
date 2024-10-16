Return-Path: <linux-kernel+bounces-367712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA39A05BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3304328280A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3068205E11;
	Wed, 16 Oct 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S5zGfKSg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B821CBA0D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071491; cv=none; b=gST5aZI+ky7XER+yNeaGCkV5DCu/lv/B6nk/3CwY+gbBSze0F0hAOX0FcQXFj1xqFMwvENM+rzLq0JypEKVMHJevuUxr5o3k8pC2j8Eq5mdB4sr7uQu+JiMxKhWOQDzxLJ8Lul4GGtj2UMW3g405b6ButV7/Z71UFlr7eZm+Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071491; c=relaxed/simple;
	bh=h+MEcmZigNmxpEFSrj+58A1sCwmjB2v6r7R7JjK9bdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCWx6m1mV1Nab5fne1+8bG7Y46so0IxVNH9cv579LUS3IpV75H8HTj6WMDUB9HhqkSeTj7sPV+JIm7JgNKmYq7m7ULVePUDSSLQu21YDxIqGfoiKnihwswKcGoPzz1lSkpYfcYKpwr2ZBQJvB7lDyi63xzv8tKYN6Y6vRIVllNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S5zGfKSg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311fd48032so36763265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071488; x=1729676288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZPkSRw8N7EZUKHZCzOf4+8lB74dOv5D7QVgwukvOt8=;
        b=S5zGfKSgSVKWuELW5I32XzG+5qWMU5lo/3+zvKH+THt/+ITW1WTZHAFPqr8lljYd7c
         tQF/Q5UvTRqaMiAuftHwvK3Ypr7OPbSRIl+dcG/WcZAUMa/xjxUaKi5wfwucCT+wCe2s
         QxTVnmK+zA1nFoQqAlnJ694deGQ/gPVkfLhA+HzhIyWZrkeg3BTsePd3GtDSI7kenmuc
         ypbimeb4ZtUpdqWa4P3n+SQC14/LoeA3w/CJPdI5eS7mLHAx/EgLM/oLavh/tLDS6O3T
         dl9u7g/a5P7cXZ6Bd1oLvuQhejHaR210WZPHzAYzG9dNIvL6P8VTZjHK3XirtEjrIZto
         3MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071488; x=1729676288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZPkSRw8N7EZUKHZCzOf4+8lB74dOv5D7QVgwukvOt8=;
        b=eGEiwP9qWUZjic93gXKZaNgVnY2Xb/IFbzj9E8onLbDLIEeYabiStjVhkjQQCw9iuj
         zj94yMqlav8wgW+eukean/JfAKdojLWy6DsNwqRq3iajZLLWPqxUD+9qhi/OWFFumDp8
         AzDkf6HpAkk7VtLTMnHjoQL82jScCztm22sojBE+jGy7g78kry0Dg2Vvnt/Gr3ZK5S+Y
         R7Sa+ofgimjc3EKC13isyZHzmN7Q3rbGnbwm/KUKOu5fDfdlxDUdfqO8hB2vj2ZIR3he
         CuE/7KGqN9GA95zh5jZO/biWPGRew0AbYTdLRYB97hFVflAqBxf/OYdsLkUUEZdXpli0
         DPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZss2mCKvpmdJu+no/m5WDGtQG2Uu7WeE9kfX+Q4rW71P1Jv7JVqG/7KqR/wkL+gaZ3PtEws+pXQ+gbeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgDA2jwFbngdgeyyHvYYnfYRrThieNJN+Cg/u881E1q1OXygl
	s7ydVjuWfb6ergSPMgmQMpRFB4DlAeE66aFut9cc1bijwKMbaa5EqklHsHw80rs=
X-Google-Smtp-Source: AGHT+IFaXuasAjjx44bpxuqZ8S1oc+w6FXNhb+zFCAtNzZoVeffBTNdwY+uuoM8/6KNVbIFcADc++Q==
X-Received: by 2002:adf:fac8:0:b0:37c:d179:2f77 with SMTP id ffacd0b85a97d-37d86ba820cmr2258041f8f.12.1729071488142;
        Wed, 16 Oct 2024 02:38:08 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf80a4sm3835755f8f.87.2024.10.16.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:38:07 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:38:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Fricke <sebastian.fricke@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] media: iris: add platform driver for iris video
 device
Message-ID: <r7p4glfxjkcecm7fi4qkl3utn3damrun6lfzkmn5wddcd7pxq7@fpav7mavmckn>
References: <20241014-qcom-video-iris-v4-v4-0-c5eaa4e9ab9e@quicinc.com>
 <20241014-qcom-video-iris-v4-v4-2-c5eaa4e9ab9e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3bnbnmmxipdv62h"
Content-Disposition: inline
In-Reply-To: <20241014-qcom-video-iris-v4-v4-2-c5eaa4e9ab9e@quicinc.com>


--t3bnbnmmxipdv62h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 02/28] media: iris: add platform driver for iris video
 device
MIME-Version: 1.0

Hello,

On Mon, Oct 14, 2024 at 02:37:23PM +0530, Dikshita Agarwal wrote:
> +static struct platform_driver qcom_iris_driver = {
> +	.probe = iris_probe,
> +	.remove_new = iris_remove,
> +	.driver = {
> +		.name = "qcom-iris",
> +		.of_match_table = iris_dt_match,
> +	},
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--t3bnbnmmxipdv62h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPiXwACgkQj4D7WH0S
/k5/KwgAp235pPg3oX2oGlC0FlS9z/orTLt3I7bY9W3m398FCaVaZnSveecT+4gz
3JKoQvZYCzyliPr+texSdfLYuTXDZYo4PDnADU4Gi1HoWPwegFuE5otOC9Z3Z6PS
ZXAb5iiLIqmVNQyA9QuOMl87cQS1B01C+eodPJHCc5jiEkRtbfM0zfgjgvM0BGDg
R586IwHliDuZwtCZEHUNOnxYLnl6AMLcuXlClSL/hatrOVKF5bP2NopyUEvUZe4P
1wXQCSbacfoBk3p0nyEO5MyDUzFzfxaE9jnAPqt7/sFBQOGrMVE2NSbMCXkgZgfJ
7odao0LkCFyDuFDjGCHRpU3k1vZD+A==
=J7sX
-----END PGP SIGNATURE-----

--t3bnbnmmxipdv62h--

