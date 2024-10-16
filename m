Return-Path: <linux-kernel+bounces-367695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF539A057D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A00B26EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AEF205E02;
	Wed, 16 Oct 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nnu3HiNR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFE1C07E7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070861; cv=none; b=os12wNk0Bxbhd3wna5hCRFIgY155+o4KZsx0ThER21JvXIS9VsMJJxPT8UByzE9VNBBOumbmGYKNXNWU0g/6iz3Imi4lDVk84Ey6zmiW9KGLrdGypLjwBcA8AkOJ2gMtPf2l3C5dnsib1vfd3zI76xC6T7a7VKODLbOuuRGQmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070861; c=relaxed/simple;
	bh=3MX0N+l1+rO0gZxDsjj0Xz1/2nU9qhw6F3JYPSXc03s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHkRBXLQkjHlT4PE64LJbB+mATuNrkO0KSkhfyFr7RqOErr6nJopGr4nwbgw0J6Ezd4Ty4swT8hM3FcdHtyOEXQ4Cy8Wm9dsFTl19cp676GjrmJ1e6/kF3Jt93eTdWfa8cJlHqZYUwhPDax1mJiH5YZFiR1rd6A6oJlFaqUaBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nnu3HiNR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a3da96a8aso71880566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729070858; x=1729675658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkTWYiGZQ+keiIE1fDd/NGylZkJ/o8QzKwt0lHenVNU=;
        b=nnu3HiNRD6PIaUQDW9Rz8ggh/1Z9To/rsmBhAE5znsgIC3HpCAWL0So0bdFK1AvSkv
         iG7yRJQKuyO3nnf1ahdSq337SmwmzV50V5Qp8TrKzhxWCY3oaF2xGrbcDtoPCptbOIO1
         Z+hbno0+d0E8cfxB2gGWrX/bBvPQJ0hSQjoTdmLPHSKmub5vCIl7Gtg5tRcxzgsdUVv3
         BRs94R6sQu/BkCcCUu3gexhYUKM9RzQHUfc6jNGFnRL/A1qROBhguR7q7gEeN/Dn4b3p
         VWJ8CIQ+Q7cZMI71EkpSDS64Av6OVvSlpwWpT4/71E3CRhFwguaeh72vkqa0Kzz0On7s
         iPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070858; x=1729675658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkTWYiGZQ+keiIE1fDd/NGylZkJ/o8QzKwt0lHenVNU=;
        b=I37/24XOnwS5KVETZZYn2oM+5g3jt1GFM1pdsbhB/B5n0Jc0EuwW3h2ih6xjT526TO
         k6m4bNqQSsZcltorBinZfCMB3caz2jjiX5ViPUSbSG5WXpFqSI5pb59QUbk0XIe3mDQl
         0YAqZrgrL/cnDLhBJOUo8vPyBmMj7ENMQ5zCRD6Xn/gk4X4upIH1En65gQ5RFIgUddTx
         gNPagu7kko+269Y7Mu1Q3BFW8PJN7l1Nv9xgIIwT7OoVvqDJVr4W8y40eOdscuzrRQtD
         CHT+wa7hJfXHV3LJkwZc7jwNV3lVeguH1qUgKooZoZjHylgK/ivw44GDpIg7qjCt+yAU
         MdPg==
X-Forwarded-Encrypted: i=1; AJvYcCXPrlsUv8wqKrIz3wgw2z27va3wg1fAMmkicrxNMM64gLCMJoBhUoJujenntMHjj/DlIfNqf11PGPNAu2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmjMam2KQf8CRJb6wYMV8S4bqBFLi6LGFo2l1dD9nqOmHCfr9
	k8fotVgLH7kCjGiBKn4Qdf1EP4mLq8c0UI8+H+fV8+woTbGeqJJYYBCaSBg05cM=
X-Google-Smtp-Source: AGHT+IHsN4Gvg9FXmit1XET1Omd/eAaw9Bqv6hVqc+m9T0ybnBbiCdCdwTlYq6+4D4QNBZh5AvCM+Q==
X-Received: by 2002:a17:907:7da6:b0:a99:5687:496 with SMTP id a640c23a62f3a-a9a3370fc51mr241819266b.30.1729070857783;
        Wed, 16 Oct 2024 02:27:37 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844cc9sm160331866b.182.2024.10.16.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:27:37 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:27:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, 
	Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v9 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <3wjk75z2ozz2lg7qx6by3phjoe2brov6rz4jezpowrreedjua6@wt2js5hzqqdi>
References: <20241010-b4-rk3588-bridge-upstream-v9-0-68c47dde0410@collabora.com>
 <20241010-b4-rk3588-bridge-upstream-v9-3-68c47dde0410@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kxr7txtbzz25ydaa"
Content-Disposition: inline
In-Reply-To: <20241010-b4-rk3588-bridge-upstream-v9-3-68c47dde0410@collabora.com>


--kxr7txtbzz25ydaa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 3/3] drm/rockchip: Add basic RK3588 HDMI output support
MIME-Version: 1.0

Hello,

On Thu, Oct 10, 2024 at 01:40:51AM +0300, Cristian Ciocaltea wrote:
> +struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver = {
> +	.probe  = dw_hdmi_qp_rockchip_probe,
> +	.remove_new = dw_hdmi_qp_rockchip_remove,
> +	.driver = {
> +		.name = "dwhdmiqp-rockchip",
> +		.pm = &dw_hdmi_qp_rockchip_pm,
> +		.of_match_table = dw_hdmi_qp_rockchip_dt_ids,
> +	},
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Additionally I suggest to drop one of the white spaces between .probe
and =.

Best regards
Uwe

--kxr7txtbzz25ydaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPhwUACgkQj4D7WH0S
/k711wf8DoNI0nAJrwWSlZ6jh7cUNs9hFjDKDxrrmJWOmI/UNFwavdEYgYH50Gwd
0g2uYmZW7C9N3fJlT4+gYj9ReVz3+SEPGgrgp8NFdoyAvrqx1pbJ9WRX9Oo5X48J
jEm0/qX2zpy6mUD9EMbU8SbckuNB7WtlsKF/ruOFztTR+ieEe3WEpmRVZfBrWUyH
OMC2rev1TYtyQT3hN0fG8lbee3IMRjopaFXRNZEq9wHLYgienLj6eheiEm51gb5x
PeXUp+b+wQnUTWOoX1POE07IjfK0oUDvhOLIP74zGPwXeOCpMidZQeHjTtIq2gYM
d/mVwN0enReCIbhebaBqmfP4cd3vTQ==
=REG3
-----END PGP SIGNATURE-----

--kxr7txtbzz25ydaa--

