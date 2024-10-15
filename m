Return-Path: <linux-kernel+bounces-365190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928799DED1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554D2283588
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00EC18B46A;
	Tue, 15 Oct 2024 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DJBhNaMp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DF172BCE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975331; cv=none; b=P8T/55jZi3h5Sn8zrmUXfPLZqfjXNV3IDTkehmH5YXOUtI1IAhfV3gEzD5JRD/P3DuD5Yqj0lB7GeUwL1jvAZ7/CfxH/mw0DygzXWrWzy6IBFetoQCemtquvBBcRxKrWuw4uS5dWskp9gmFf4DHaLmvGzhL5DJrdRA8tMCrmVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975331; c=relaxed/simple;
	bh=jZYLrJ8xNerZp9HBuiAh6NFLS8vq3D27IZacqxGdRQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOQgcYZuET3StiVtaTdCBWL9XA+12LQSnXfSWhA2FLfwPLSjaWnO58UvXggWyomnGvb6k7cD8AoA3pYVkqMGHeSKtl6yyuP/mmXeS2Xk8E/deuNCzYzWPrboJGoa+zG0LJ2z4bEyD0wC8DKospgfb3XuOIAuaTkoOmx9ybQitYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DJBhNaMp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so5040674a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728975325; x=1729580125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZYLrJ8xNerZp9HBuiAh6NFLS8vq3D27IZacqxGdRQI=;
        b=DJBhNaMpiVBtBq452bFdJjImy5Cf2/D9thLja+6BEzfcTd2/mDbXbLmFP02Y+jlNV1
         85MKukkZN7J//J0uzI4o3grvlgzNAadBijyzJCu6nSCaAM+lq+XVB9qbk4IWpZYU799w
         tEVp1rxErMMASXDlvaw8yFK9G02jzCNwj0/5nBjcuD2ndGpj3NeMexgr5Xg1OmXL7YwD
         +bWnDP9SEK2osvtz9WIhMzhd00zM12MU1TUDiAFZoapYTtN+P/XIefCkPvIELR1bQm9b
         KYnlQJW1p308iBwAw0yb1c1HFCECJceufex/WCcuKpmi+38ao25YwrZt5nq3Gm/3AyFG
         Ud2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975325; x=1729580125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZYLrJ8xNerZp9HBuiAh6NFLS8vq3D27IZacqxGdRQI=;
        b=Jzr4VCAdTyRgWFQ8JNaLuy3nJDPFXKxnMaNDGdHNmo5w+zqXtpnvloH1gtDDmS0oQ7
         9FOmCS9Sx92IfybxCiggyuGFQIyIYJr0+9Ep1BdxHurfiJJbgL2A6sEjMbfRur9e1vYH
         N3ecxxa6iRyzOt03qmkDnRVLiPxYvDsIQTQhsChx8HfOegyoaeBBjZKcpky9+9fraher
         MvnVnC1xvKEMZkVEnD/wwzapOFSeRDKjxmXL2iOa47Koe/Almr2qWTpKbO3EFx4/AFgk
         KEoj0v4ybkcm21X4mzUmgnfOKdWap/KkCOKj0WzCnkJoeimaX7hxG2zty8V7ktmiNU2A
         yycw==
X-Forwarded-Encrypted: i=1; AJvYcCXlr7ZiZXcmm4/RzRcVSW+c6N25hgBklpUBdeGNCLmVqrTF6DB+3rXU6VH6Lh3BGQvgmtNSlKzwToTwUtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgJGYSPlVK60fhAYRUElTgS8PuKzdf5KQrIhb9HowtYthtfTX
	XlUAyW/9iSR42tFar1ooXAjLQD2+CTAPpZ5dQGiRzLY1OA/AcSZ21ckEAjLn5RI=
X-Google-Smtp-Source: AGHT+IEiUXLB/52gD1Dyr15xJWH+67WAw/ukSLd5WNLqUeBey2zQoDpyevrWkTJhbeKimw0i5WN3YA==
X-Received: by 2002:a17:907:c8a4:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-a99e3b21469mr872943566b.3.1728975325105;
        Mon, 14 Oct 2024 23:55:25 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844cc9sm32689666b.182.2024.10.14.23.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:55:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:55:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jacob.e.keller@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [net-next] net: ftgmac100: corrcet the phy interface of NC-SI
 mode
Message-ID: <mtaia5jqcpyx4bbybsvqa3kyl7o6mlavbhn3jk5gdb42ftypxn@jeydtf7ldprv>
References: <20241015020610.1824763-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="penfhnhf3dcru6gk"
Content-Disposition: inline
In-Reply-To: <20241015020610.1824763-1-jacky_chou@aspeedtech.com>


--penfhnhf3dcru6gk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [net-next] net: ftgmac100: corrcet the phy interface of NC-SI
 mode
MIME-Version: 1.0

Hello,

no idea about the patch content, just noticed a typo:
$Subject ~= s/corrcet/correct/;

But maybe that's only a joke I didn't understand.

Best regards
Uwe

--penfhnhf3dcru6gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcOEdgACgkQj4D7WH0S
/k4FzQf+PpjBrNaJOvtSSJHiZCkYh4tGYOLluXkZ6lozMPVxQerH8Ay/C40IBNao
pEjbfu7qfbyyPRoWLmfidswj0OiXvqO+CP9dkWokaeRI61EC+xbd9QQo00yrWlbZ
+mYjOZ52MyRoN3vVc2P0uo5t2K4UijIM2EovFDWKk82nfynUjfO34nm392qsv1so
oY6ADrcpcz7C8xhbHZ/jRmhp56ZzBmlLKi6z5fTET78PoNNbXoy/wMPpiKc62sHA
WF4rro263ztndp7vKyO2Zhr/kMrw0HoJNWLalXDpNBSlXREDGFNR5XiLm6/9d/wZ
oS7K4lIaLGaqfQlCbZNUiKjXBYiB+w==
=Mwzx
-----END PGP SIGNATURE-----

--penfhnhf3dcru6gk--

