Return-Path: <linux-kernel+bounces-270935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAD94473C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0478283D69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB116EB61;
	Thu,  1 Aug 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p64N3HFt"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676B16E884
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502711; cv=none; b=dZWe1/oZD2x26zhj3aBUd1JvQ0lluxUnE22Xv/ctngaGXXri31ryzj71TXcyssTcdLk2Ret3cE1yawbMpf6f0PivJ/K1gudU33LNledXIvgzbUoQDtbUGDpM40suf+aYt2sAlV1WcNOsuFvoKtoyaCPrsDNAKsoEBBmZPqRvYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502711; c=relaxed/simple;
	bh=tPJsh7QBVoB1jKaglBQmEY/41DSc5GieU4L6EOgzKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1YvTeQuf3caMgKbUS+j5F0ruLxJKq9rxWfOzQQv+vIirPnMZJACnTnluNldre7WH+bKQob7Hg3rwFzL/QS1YRKAG+UIgrzSruQbSerMx/JK3zC1LP6qMaOkKuObWZGfjXpGXakkrIYd+p+E0rOXIOsUWNDOx3DN4zyoXKGeeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p64N3HFt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso44945785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722502707; x=1723107507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPJsh7QBVoB1jKaglBQmEY/41DSc5GieU4L6EOgzKkc=;
        b=p64N3HFtXalwCrxEXMEylVKebJuxRWLGVkbke7p+xgFyDkqQDk3zl7ECJzFKV3WZd5
         NgxB+uH7/yNVWQvcijUweaTmmb2HzfKXiVMCwDWY4iS9UTtJGViiae66ISD1PHQue776
         EWJJXVKSbhbYxFw83Z+nf4iWuvmU/VQGhZ0LhfuOYk5J4TI/50FFVTjPbYNbirKtnqtn
         7iaipsh5r0bzO+RaOG3eroYctOVIvxdmD6kQzkvIMdfSPuc55pJ5LmQ/Cu7hoPvDic6J
         MhBerDqPUsX42LpR9mD2w+xv/W6gTH4Qvgx7vvJDq3KV+WrnjSZspIJjluhWGwSUx+a4
         Gy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502707; x=1723107507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPJsh7QBVoB1jKaglBQmEY/41DSc5GieU4L6EOgzKkc=;
        b=OTmd7kU5kI0ChWjKY1DYPkB92l0xtA4qKFebErPpDT0BcI85JFptFIddw7WzUZ5t/y
         txpYoHzamEaUNfEYujtLRAle02Z7NemOU3kvCO1DY6QLXK6o/epWzw2GXb+3fu1DT6Sh
         39iVEvd/MPqkKYO9FN2icxj8kYKqQq0NWFi/zEj+qIIyX5tDond/eD2i9sAgbFQxbdRO
         iWIyzZFnHOn4GHh5O+4g8p0/A2pL7p+ADv83rqI/C3Sy8v00a84LrfIt59m7rgMnQi4+
         y0KmRmET1xHpim6k8BYLFggh0d/BclWK7rkHEFu+FGZzrl3+PUULN8I/+Gh/jyLL6DdL
         F2XA==
X-Forwarded-Encrypted: i=1; AJvYcCWCqpszeaJlRfGmV8KbmYSE5OGCHXfyCVwnfnUNZd2bjeQZrW+VIxvCWXTe1MbOZDW96v9JtyMQGyDPiwgIUl+IvzuXxyS6dQD6xl8L
X-Gm-Message-State: AOJu0YysV7Oo4oDnXoNqqYqwwtYvl2OT0nt6aew5xKW5lJRAamfNx+rH
	WbrrmL67abFtD8mnP+Q+pqiDXpX96An2DnXS1VbDju1ET57kf7C6Vxt8znWhzgU=
X-Google-Smtp-Source: AGHT+IGQRcl/PQtdlPyR7dNajFYBsKSLKzhWoU2XZu5lqGXwUWaZPT4AaFMQt0TtjLnMzLL60itwWQ==
X-Received: by 2002:a05:600c:56cc:b0:428:2433:1a07 with SMTP id 5b1f17b1804b1-428b8a3a27cmr13137615e9.34.1722502707309;
        Thu, 01 Aug 2024 01:58:27 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ad9ddsm49275775e9.17.2024.08.01.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:58:26 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:58:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: lp3943: Use of_property_count_u32_elems() to get
 property length
Message-ID: <xz4mlhgxh4fqi3ken5xzam4xzmjbfpmyxs76pthofqathbcobc@3wdrnrca47qh>
References: <20240731201407.1838385-8-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzp6gmohfws5ympm"
Content-Disposition: inline
In-Reply-To: <20240731201407.1838385-8-robh@kernel.org>


--fzp6gmohfws5ympm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Wed, Jul 31, 2024 at 02:14:03PM -0600, Rob Herring (Arm) wrote:
> Replace of_get_property() with the type specific
> of_property_count_u32_elems() to get the property length.
>=20
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT property data
> pointer which is a problem for dynamically allocated nodes which may
> be freed.

To understand that right: The problem is that of_get_property() returns
pp->value, which might be freed. In this driver this isn't problematic
as the returned value is just used for a NULL check. So this isn't
urgent and queuing it for the next merge window is fine, right?

Best regards
Uwe

--fzp6gmohfws5ympm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmarTiUACgkQj4D7WH0S
/k5C/AgApsuO8eskylvIA6p5E/s67TT2Qp4cv9KULs7QoOgd3BEOMzJMobj53Ox8
1HgANTWrNaW88h2aMTth+sXWNWFh58AAsqsrpPSZc8qX3TjcHQL9SCbQB2a5QSd8
vXtXYPU7TSRVOiGZdSrLwJyg6y77YiLhmAQItlET8rktg3/Wkxd0Duh5PWDdA0M+
Q6SR57HtBC9w611zADJ514wydA3sE0Hmf3qGBUPwspQTTiOQLKLtTYseUzm1zjYo
//D85WP2UyVkXhpNkZzh/CdSVn17ywtIV8y8ncCxBiK/SmwjwjDB/DIRcJf71Pu3
gD2xpTTaPyYm3n7Y7d5yZieSkRNhNQ==
=/DTF
-----END PGP SIGNATURE-----

--fzp6gmohfws5ympm--

