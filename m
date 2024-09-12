Return-Path: <linux-kernel+bounces-327263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4A977311
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE011C24069
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3DB1C174A;
	Thu, 12 Sep 2024 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKVAkLI6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930513CFB7;
	Thu, 12 Sep 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174584; cv=none; b=V2jJyoq/lVTZMO4tadKxezF5fhjG3NfzHBug2b6uchDxqu+b+GcyD1cvyLU8CDHq6J0ekiLp3Y3g3INP5hPC1NPboIw/54cH1UI1qqreNrzYkkPKelmKE98/hmWvGKCLE3TXRZi2DFUR0AklYj8KYlNB3BCXG9o03nTmYDNUgAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174584; c=relaxed/simple;
	bh=JCBJWBQxeXSFHiPgv+FCZsBBAd2DQYlPd7mAd0twXWo=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=RIh2Z0wJDGEfT5vUeu5y09kLXWptkAqZpDCms2GE3IeQmzqisp0g4nfeb5PvIZ4B5BLJupiVYRCPp2r3FztVvTigngoCz1425xFbsebcWVBr6sepI1Tm4ClC5BQCyfKiO+NbiYQgQ8JGD/sxTC0/O9Nhq1/SVvDFvY1Ie36gXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKVAkLI6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so13455275e9.0;
        Thu, 12 Sep 2024 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726174581; x=1726779381; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7YB7OGUmP2DQFc+bvfH2hCbNbgkST2+Q5rt52eeLQTA=;
        b=mKVAkLI6F9ZmUbgnD5AvIFMO4rmpLp0q4MTdLXFfPsakoFOmJEp26jAu8+W8wnYW4+
         kl0jum25V/q1Uj9EXcVxjw6e5cRi1Ylbu50sNmAKlTnwPsbC880nPY50EMmR3IvDLPUq
         YxFSBi4QxOMX70nJYxjSwnmFW9tsXHGYFA75FZMffJJQrNGc2d67fzbwAXcVH+zXwQRm
         eLKsAQmLhryrVgEgwaFmKyyyIawQqx1mzJzSJ/oroVjUQFl8gdD56Q222W7TkB7lDokt
         /cx3g/qIFc8weTNxE3nrhghJ6PdM2fn1zyXUvmsw3pevZrR21TQgwdSc6UknncLL7k9x
         UM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174581; x=1726779381;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YB7OGUmP2DQFc+bvfH2hCbNbgkST2+Q5rt52eeLQTA=;
        b=aXdllJycQFZcHxtdK6sPq0nXq9x9C928FUoR4U8UK6QGf8wEQzS3uZVz78ux/hYO55
         vOPT3+CSPeM+0A0UDsriqmIuOZHWG/RnpOrHMYqT2d/1W8gpA1Kxz7aYfHEBPROUDwPS
         JhJ3DuhcRLSseGlrpm4DP2FahGAw7l9NqCMIBF66DofbEPX1o1W/VXWvd02JpspXPOOn
         V4yCRKyCiN9B2lWdID5hwxqHIk5var7XMWBeVfyPgnHxs/Kp+aQ2D7YNj2mczosDB7dr
         /pxhQgX080tZdUpfBQOfwSmE4wM40VOiWwY9lDmwRdl3/9ypK8nIr86fBF+LF5S85IXE
         7Nmg==
X-Forwarded-Encrypted: i=1; AJvYcCUsGajywT2y9tiQFe5wkjvBJbzuqttpjNaOkgGbMju8v3J4H3q2dvtAZPcHCcy7zibf0C8Yfxh/ZH0ojQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhecJriHbj353BFYImD7Hmc6mwzErts8ofCU0OiKJ2mMFQ1nIl
	jN4wsr4XqH3tMmITsjfsSvauP36Kesuf+OwLIWMxwJ1ErAjlhjuwTpMHXw==
X-Google-Smtp-Source: AGHT+IEwcEaz5nKF16N5xA8l7cvpacZadUc376ihK92QYjGbHuWcgHRwzdIylk4pJsb/Ujcq8xCzwA==
X-Received: by 2002:a05:600c:3504:b0:42c:b1ee:4afb with SMTP id 5b1f17b1804b1-42cdfac946fmr25591885e9.26.1726174580559;
        Thu, 12 Sep 2024 13:56:20 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01d4617sm80600155e9.0.2024.09.12.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:56:20 -0700 (PDT)
Message-ID: <66e35574.7b0a0220.20af38.7a93@mx.google.com>
X-Google-Original-Message-ID: <87ikv0wpzh.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  saravanak@google.com
Subject: Re: [PATCH v2] drivers/of: Improve documentation for match_string
In-Reply-To: <172617312190.738061.4164864853737783773.robh@kernel.org> (Rob
	Herring's message of "Thu, 12 Sep 2024 15:32:02 -0500")
Organization: Linux Private Site
References: <20240911204938.9172-1-mikisabate@gmail.com>
	<172617312190.738061.4164864853737783773.robh@kernel.org>
Date: Thu, 12 Sep 2024 22:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dj., de set. 12 2024, Rob Herring (Arm) wrote:

> On Wed, 11 Sep 2024 22:49:38 +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> The description of the function now explicitly states that it's
>> an *exact* match for the given string (i.e. not a submatch). It also
>> better states all the possible return values.
>>=20
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> ---
>>  drivers/of/property.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>=20
>
> Applied, thanks!

Great, thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmbjVXIVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlxfUP/2bl5IBRgknyBEypmo+9fZdP5rHs
lg0aeWVg0yOYXuP7wZBDIwGJjCjF50Z6C90R2tr0fGYbItSSAEfmnqOeN1XArlHa
Yi6XeFt5eTHRdbvSR1nbjEEVgw2ISl42tIYOpRTIELmQLQj2GUowyR3eoFHj2vNs
p2dpx3jZBNCWkoCfG7uDBppjc0L5ro7I0llArmEgnv0DXMsItsB2mBnkq71KB+7v
9whritIfrW2SYOm/2HotfF5w16W0pqMlHS32i4g93IBY5faazfBOfc7GMWpFtoTw
pgAezDlA9cUIv7qsXAduGffMGPx8ST8hW4yuyqTJ7ifQ7hf2DT+Uh8eBro30hc1B
zGY75n5Hz2HA/M5Iay1VHhhX9VbefiyJ9/8rfGCQlvjAIyZqmPsbrrrSt4u5H4Fz
o968AH3E9kUHj0oJgzopIy6HzjNfU2UPGRBSpgSM60DSOd8npg2dAT9gSCEuAFC4
/lJZZ0sWfQY1JfcWeNoQz+AiV7D7KyvQJLc4ykJTsrcgxNax0JURK+1RaJ4+3AvD
5dTTvwGwr7+HnWDHAUTJn+fobwGkCUHTU9h39CkOgHJ5d1Yym+oZVu3CD1xoPOIx
/NfRnVVlstnvn8zyBKJhwgPC/yH3bQHNJydfh5LXC7+3mA8i1K4IbpmI91wHRgV+
K/qduJ9NVnpLlby2
=NxGc
-----END PGP SIGNATURE-----
--=-=-=--

