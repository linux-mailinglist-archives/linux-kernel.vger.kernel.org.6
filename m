Return-Path: <linux-kernel+bounces-399572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E089C00EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D4D28330E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767D1D7E50;
	Thu,  7 Nov 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YXgXWvVz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1D1957FF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970947; cv=none; b=IgrK/uBmZvjz+Rr+n0CLAfTxhJ33B8e6utdog4t2QLLVpi+a3qA9vneTDTdQ3XM993Ow9tbgoDchxNQLoin+HM8FWGOTNWDKgwjE38OhJ7qkRXyx81QcLOu8OkyXj6O/ZDfOiLrTq62Iq3ueHizk/rWM3enxSN2mmwlrUiCBUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970947; c=relaxed/simple;
	bh=Aq53KfufQB+tyZ8Xlp+tAR2Er4hWBskVLo880iJ/1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H9hJDiFfoQH6lKIHqFj0o0UktmpfjEf8fc9HqhES2L3H0UWSbVVtockLp9STJHfdh/gXgy32qbs07j8KTvUvOzNKvxzG6oqr7iHd1819w0JwoeFy0QLeC2KZqAe5+xwRwNWecfZJTwH73k5bc8Z88IU9wR0aS8/XpI5tuXhCFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YXgXWvVz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso213265f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730970943; x=1731575743; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OJ7rtyUAdiCrwcHx4MSWHh1xdNMHwH1AjsX2snl8cI=;
        b=YXgXWvVzo3T8WpvFOzPtlPs4vVXwDlj2M/NVUZOx+GWUtdz2iFLNNFUJkbdDgekHiY
         gre/MvN8n14DIaY2hogR2p80fCAoeDzrN/BnzGcw6kIiU6T/vNQFjutc1w1OhZNhaLA/
         PCzCRkvpA3BioaXQwoqDdNPu0C4AGTaADngmnx6649pnYqKu+lKYDwIs4+83BWPgvkLe
         Ndc36M/kJZj89inSvHJnOiLpNmHM/WSI6dHdHjGKICy4HYpL4s1gLKrtCjHzFNXNn4hM
         XmEzCt2IQl6eq2SMaa84Ma8WQ/eTJyz0UPR6g7lqO9lXMAcu5iYd2ioGSdK9FNh/QpzX
         dmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970943; x=1731575743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OJ7rtyUAdiCrwcHx4MSWHh1xdNMHwH1AjsX2snl8cI=;
        b=OANWp9eJB0He8zlC8UB9pG2n/6L64d/mQCbXeXzLdd7IN+ioSKfsAXGBPs3WnUiFaH
         Tg5UEW9w1aPN95NECa7vapIP7zZct+iLsgezcSWp6t6f22tRIY7B7QRCjqVQL8/F3Qp3
         vAtzNUijMWDU4zccmEAIS6UEir7Wb79Mc4dwoFlE8gZrAFL52B+6cC+PNlqI+g8/0zxB
         xoKwhBBIBPiPNl+VOmDJ2Yw3hNCfVVWA3q4ZRDQgmAWHH+m77VwlqCL9gXwoqRElCYjd
         JAzsZkiERtEq+iOKCy/rsBXZTQAKPIaISkb1snI08gPem+zwmEihizT6GUFSW2RHpMOd
         Ajow==
X-Forwarded-Encrypted: i=1; AJvYcCXatryR06UVu0BQExU+edBV9SRA1cDQpz6f7nXlpiOBB+TLhlNqFI5NtOA/nM/1exfylq0whK9Ue7MmiUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWQfR//OQhXgYprb5EM4jibR2VcJUCGFT1aN4oNA7ToB0sLT2
	bH7UaCrKLB2yeAqTv1bvFAkolisCBJP2Gp9mzRVyVzbz5YdQuLM1S4tbtVnMcxs=
X-Google-Smtp-Source: AGHT+IGdcuKzROptTzoQj4ZxP326YFgJRISOCDEl3wG/eViXJrvy8/H7yfnGqnnSgpNWXWXlN+42RQ==
X-Received: by 2002:a05:6000:18ac:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-381c7973bf8mr19197690f8f.0.1730970942680;
        Thu, 07 Nov 2024 01:15:42 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5e4sm1174100f8f.77.2024.11.07.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:15:42 -0800 (PST)
Date: Thu, 7 Nov 2024 10:15:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Trevor Gamblin <tgamblin@baylibre.com>, Erik Schumacher <erik.schumacher@iris-sensing.com>
Subject: [GIT PULL] pwm: Fix period setting in imx-tpm driver and a
 maintainer update
Message-ID: <2m53n4ksfvepuke6uifkxwggepcyqs3vghrkgul5tlputpgva5@ch3o5sy6ekfb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="injfv32txdhjxuo5"
Content-Disposition: inline


--injfv32txdhjxuo5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: Fix period setting in imx-tpm driver and a
 maintainer update
MIME-Version: 1.0

Hello Linus,

the following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.12-rc7-fixes

for you to fetch changes up to 517fb4d77c44c7519ae6937329c496894461f416:

  MAINTAINERS: add self as reviewer for AXI PWM GENERATOR (2024-10-25 11:31:17 +0200)

I hesitated a bit if I should send this pull request. The pwm-imx-tpm
issue is old (introduced in v5.2-rc1). On the other hand it's a real
bugfix that I'd like to see backported to stable. So I think its honest
to ask for getting it into v6.12, too.

The maintainer update is just a commit I wouldn't have sent alone today,
but as there is a PR now, it thought to value Trevor's effort by sending
the update along with this fix.

The commits are in next since Oct 28, thanks for pulling this for
6.12-rc7.

Best regards
Uwe

----------------------------------------------------------------
pwm: Fix period setting in imx-tpm driver and a maintainer update

Erik Schumacher found and fixed a problem in the calculation of the PWM
period setting yielding too long periods. Trevor Gamblin---who already
cared about mainlining the pwm-axi-pwmgen driver---stepped forward as an
additional reviewer.

Thanks to Erik and Trevor.
----------------------------------------------------------------

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Trevor Gamblin (1):
      MAINTAINERS: add self as reviewer for AXI PWM GENERATOR

 MAINTAINERS               | 1 +
 drivers/pwm/pwm-imx-tpm.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--injfv32txdhjxuo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcshTkACgkQj4D7WH0S
/k5+bwf/WknJrVBgzxMzB/pafxdZqqVxO5lKDhC/dkcAGaoKlrwDdLBGgrv6aQvu
RJ2KN8JiCtrBzywTBbq+LUnxujeqpGmGsUwt65d5yT9DkL9ScuxFhY+lTAadv+qA
tgDEVP+6wHSXZcgccYZmUN4Ov1q1tz3MfZMNT9qfa3xCDdDwfgbvNLMxvdfAt6C/
G2pcvZtU/G8dtuvMEgJ6xWMAu97ZLZ1y8bC19zh+xSBqtDibPitgMCe5FWecbPW8
qGK3eLpBj4Ahb5fXbsAJzLcCC1macjDJnC9ca8av0jfJydcid9u623tGQjeDJq9e
j8g4UTP6odpL1mwgbOJvMhDTgk6lRg==
=YSb8
-----END PGP SIGNATURE-----

--injfv32txdhjxuo5--

