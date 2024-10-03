Return-Path: <linux-kernel+bounces-348585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1B98E95E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD331F24743
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E538DE0;
	Thu,  3 Oct 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSB0aiJU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05328F7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933656; cv=none; b=Ef6c+tAdu6Mz/hL3QPLC2u4Y4kV+t9ZFhMQ1ytP5OQGeQ81u4ILqY5I9y1L7QDEr8M09NFkyaBUFw/Kot4W8I6RKpLyIMpTKZm1C1ATIjocB//lQj2h5qI6fXU89z2F6bF8IaNyuEWjeVDXvpU1/Vw85f9KRQtPP8NLqs+Ip3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933656; c=relaxed/simple;
	bh=vqL/ppqdk+QM/SV8EyWZRhHYYP6IomK46dSDkw9zD7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KaxjggRNW+L6G0NtcWJ5dwaqUT2ZZmiug8UAdTnmkIC8QxnQqi3dI5Qua0aJtBFq/Fet0+pEkI72aAu9frSB7W8hc2nUunNCRjSmYFbU3HgPPtF+w1eBva9u9ixq9qKKhsisi0f6kbZVDfHrQPhLvdRX6zgxK3zrONZJHoiMKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSB0aiJU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2facf40737eso6638941fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727933653; x=1728538453; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkiI+6DRojCrXsgjtHDnPlGNG/WZzCgTht+C5PW2DEQ=;
        b=YSB0aiJU32nWRTBBaCJjhd0EsKoympmuu56mywoXLod1EcgEwHgANuXeMPbnHtuDa1
         mim3eCnh4qBE4sXTXSRYd2dI9irbWUtOmQomfC8ym+s9DZiZjxZVXyaPiJL4UL4uoBcI
         hX9NoK9r10NcY28ykxIH3uj8X0ccYjtdLdhZqsLyJv1e6mCANBGcJVy6qYaDp2FFPHEp
         m/sC5G1ytc8k6XCvWQzl/NRlYE1HpxaklLAFRWrKQaVaqn7qvO+/cMkjDQCmxuNiNn2d
         1Dn6iyi25+SeID9c5aPQvvjfctUCnlhLl7jR7t1f+YSJtyToRMvukAOcP8C1ou6ZT268
         tGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933653; x=1728538453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkiI+6DRojCrXsgjtHDnPlGNG/WZzCgTht+C5PW2DEQ=;
        b=wFTUZu7t28NxGqzj3h4OT0G9qiFesCHPSMpcP8LXxAJfSUGJ+AIXgvkIG5cK1fYD7U
         Dgrao4yO7Knh7NguZVgRrbFDHqhxuQWoTwTPGjaGajJ8mHbVFa0Z1t1Jz/T1qQzGUMoM
         TBgIUjFWKBRhfEO/SCa4BNsLq6MyaKCgBIuLEswOumqOyQWZIIz0i8/1fEvUiAA8910u
         dp4SjM549st6NkHPr3NQqBV3koPQq+3AGf8aRp+kZfGYTozwnLcOlj/zwIo2cwZmFPKa
         MWTQPWaoB+xID3y9UuLGh/hyYR/dgx1WXEoVi2J+uYTDCgymiNOC8/WgaMCrWyi8bYxb
         d7KA==
X-Forwarded-Encrypted: i=1; AJvYcCX9fHhVxSsW/+GxhYxA9usbALxMFD0LZYv0amoA6LUT/LTi4cb8C36lkFtbSU3fJJmomY5aqndZ47Boyew=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcspfjK9v0WMgboWjnzMKAoM62Lkvez/XYMmvIeq+Z5gZX076
	uYO01EE23pXaHxL+3utYqLfQTyz8pcsav11H0dW8kf+vhButLlIQqf4rVQ==
X-Google-Smtp-Source: AGHT+IEAN2nYA/Iq3pgOFqYfjnMLrXzY9cAQxIjcHVlGK5DAjyLiIc6O969IW0ICtWasRB8m42e4kA==
X-Received: by 2002:a2e:bc1a:0:b0:2f7:4cf1:d6b1 with SMTP id 38308e7fff4ca-2fae102450amr40063521fa.1.1727933652698;
        Wed, 02 Oct 2024 22:34:12 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc6bd29sm1092621fa.96.2024.10.02.22.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:34:10 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:33:56 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ROHM BD96801 Support ERRB IRQ
Message-ID: <cover.1727931468.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OH0Q299WtDlWYidw"
Content-Disposition: inline


--OH0Q299WtDlWYidw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add ERRB IRQ support to ROHM BD96801 PMIC driver.

The BD96801 has two IRQ pins, ERRB and INTB. ERRB is used to notify
'fatal' events so handling it has not been mandatory. However, there
are use-cases where handling the ERRB interrupts may be beneficial.

Revision history:
v1 =3D> v2:
	- MFD: Minor styling and print improvements as was suggested
	  by Lee.
	- Regulators: Rebased, no other changes

The ERRB patches were originally part of this series:
https://lore.kernel.org/all/cover.1717486682.git.mazziesaccount@gmail.com/

Revision history in the patches refers to the old versions in that
series.

---

Matti Vaittinen (2):
  mfd: bd96801: Add ERRB IRQ
  regulator: bd96801: Add ERRB IRQ

 drivers/mfd/rohm-bd96801.c            | 275 ++++++++++++++++++++++----
 drivers/regulator/bd96801-regulator.c | 130 ++++++++++--
 2 files changed, 356 insertions(+), 49 deletions(-)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
--=20
2.46.2


--OH0Q299WtDlWYidw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmb+LLYACgkQeFA3/03a
ocVsDwf/XHY4p8cgTz80ZIabyMPTb0QpvRZ2T3QgCkwxoCAiZON4iyPCUYfqDhdV
psKx0tp74P+4u0/sooZVBOJJQo6eGP6MFQawuEeKLZcM+6nblbBEKCsnkCgbB3g6
IvfMJnSnSQgJaszlEaWSf6fYbgjeIqrIXQYyvr+n6MQaEGpEuoRlylpslk4GTfCg
bvZOH3g+kFclgDDVK6bKcV+gxT1Z8fsH48MLu4vU2YV0HLPHabJj6SA6YI/ZPrIP
Xqp8LSU5+teQ1jCQRLguPXFSKTUMuNVh5joV0quhG6lp309pGDyma7EU6J9si6sS
xaAuzjJgA6Gi4naxaL4VHW8evXma9g==
=0vIe
-----END PGP SIGNATURE-----

--OH0Q299WtDlWYidw--

