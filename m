Return-Path: <linux-kernel+bounces-232004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95291A16E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1382849C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4C5811FE;
	Thu, 27 Jun 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZTQAAqnM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564341A94
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476865; cv=none; b=L02IfbBG8GYjQZkmFzuw6X+qeD9U2tgqw6QH7PxXcpK92svuUHPRtz6l4WMMVYPkQKQb22FQEO3bp+IQPvWMtEH5f7nGdmSEdSmVyJINFJzgOlSBWVlqxrzcv/pIYMYFYj1GzmDmXR8HpBHll8RW3kuJBK0LwinTOa3clw+Fi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476865; c=relaxed/simple;
	bh=BNusu6iOKLpR/AzqAaf/ClBxFj3m8YsWU6L8e8WBrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXiKYIOwnlUz0Ouq2+EkvLIVKDMiSXe1lCypnXUBo71xRiXbGO5BVvdkkphFX1MM4rqpXZoiu1iRkPxT4JUT4hdqV2U9P24IeBYM/Se+VL6x5npvHXTe1jbw1q/EOTqsnoREa3TQWaZH4wLa1xLekCyP7TyCLQtU2eCBoHT9QLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZTQAAqnM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so117411481fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719476861; x=1720081661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNusu6iOKLpR/AzqAaf/ClBxFj3m8YsWU6L8e8WBrso=;
        b=ZTQAAqnMMuYoReFHY5Bq7D0Z2pXAIOEFI+OjhPNxcWnUauS6HzLuxe52mRLB3QDWRn
         qlA2f6uytzj71ywayLLcFIUtfmrnhwnOmnV220pvx8apti4StnkAC/Kpj8T4+YKcSa2p
         AcPyHdbsyWsAEzohawFNj0ZgLJpTtV23wvRiNVJQULlcsC8llimY7NuoHfBWmkP05Dfw
         Gsrkc8F5+LmoMthgievpFP3LOfWDi6Wndnj12Y7DpNIEk3iseXg1EPMideeGjXnKmoby
         wurmXJYxAIa0kciJ97F0/cnQMkZ3qtraD+G5WnGqYN4q1ZgSmbduQrjOlMmByAWRDx+n
         NRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476861; x=1720081661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNusu6iOKLpR/AzqAaf/ClBxFj3m8YsWU6L8e8WBrso=;
        b=q3md4wEHmGIwfesqsxM1jRxRxQsEJOQVEMP/+9ltQ+AugTCAplgqgg6ZPxGrIbcG0W
         Iwm86Q4CrDQkxgY0Cf9lNgLpZZ1sYG5FeZpdruwH/QMgrWd6ezNeP7rYtUBZZvBWdGqL
         0zBlfyxcS0qF+IebmEuZUCjc7WaGDp98FJxMxxZkUFzSJ+KtPxukX+0seqwtuFINt4dH
         3XreTCV2p5m68AJ7nKK8UjtV7mk2glotDJ7aZA4WWEZhtaYZG3qp+ZTY8R9+mmq6BsNs
         xU4OEnaDw6KnZrTQAnzFPxqU7YGOVxZNUfx2bqcZXl2BNFkU3djaQnsE3XZqtFaXuYUD
         NLhw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQPSAhyE5K1dKpn67iql4fK7agXbtryf1AZntl/B3wkX3uqmay7djAR8vmzPyR6PeT/rmfZ4SBZxsDUDJG+Lexarq04T88UdBrW7J
X-Gm-Message-State: AOJu0Yye38sQdsGYdxEKUh7htQTvTk6CdfCbHBUO96cHOP8NFMLe4zSX
	NjCtS8NPfgJPu3zVs79XTgBlhhxQrousutz9IxF06NKPKao2w4DoUYDPhS69y2k=
X-Google-Smtp-Source: AGHT+IFmBQHWtq0n2FUbMOa57N3W6XlTrtAsGYy4tqdoXDKjsos2ugQoYwrPaA3x+N5TdVxQNNesUA==
X-Received: by 2002:a2e:b173:0:b0:2ec:5945:62e9 with SMTP id 38308e7fff4ca-2ee4645fff7mr24158021fa.32.1719476859009;
        Thu, 27 Jun 2024 01:27:39 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fdfc5sm37261766b.10.2024.06.27.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:27:38 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:27:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: imx: remove interrupt proptery
 from required
Message-ID: <743qy4ke7d4l4at6bx6g5gtkgae3md7eoilzwgvlypa2h4ybpk@pvsnhh3ndv5c>
References: <20240605220839.1398872-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2jolsun52wlfjxp"
Content-Disposition: inline
In-Reply-To: <20240605220839.1398872-1-Frank.Li@nxp.com>


--t2jolsun52wlfjxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:08:39PM -0400, Frank Li wrote:
> The driver "drivers/pwm/pwm-imx27.c" never use interrupt. Generally pwm
> hardware generate a waveform according to register timing setting. Needn't
> interrupt handle at all. So remove it from "required" list.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with Krzysztof's Ack and $Subject ~=3D s/proptery/property/

Best regards
Uwe

--t2jolsun52wlfjxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ9InYACgkQj4D7WH0S
/k7xtgf2PBKUTg6EjJsA05L6cqAQuRnlTt9bn+lsLZBpJe2r4ANXxOGXZkXEcbxs
jn9xg2MEdYHjr9Od59oc9xQpHmSsbvOBuFXlOuA7hjM+FgriC1K/yIwmFlX+OEQo
3EYaRfY6iRTjieLlZI0zZEvzflhwflKYGvgIkY4VCYYZVSJOU+kVzyY06bG8iSeX
RAcTGZg3d0IV+Pj0m4lvlTGWOQxXwHNw+q+x5tWWfnZLlhUHrPBzrKEc+gT/BzGv
weTuT8JGOKht2T0AVJD/MIK2Z8tCGBVq3eYxfVncahk18HZsokw/Qvcm53RN6y1y
bKH2IyJvqbnDeyBsZmtwwvzgftru
=fwTH
-----END PGP SIGNATURE-----

--t2jolsun52wlfjxp--

