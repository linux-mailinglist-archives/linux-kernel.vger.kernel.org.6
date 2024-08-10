Return-Path: <linux-kernel+bounces-281976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F394DDB6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133051C20CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D969160887;
	Sat, 10 Aug 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0XEzK5qb"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D139D04
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723309429; cv=none; b=WPR6Ob12ppeud4YXJI97FIsupjH6eYpmh8icL9TbhBuwwXZWbzgAFZCIfU8IC8VwZWihHNocMJHOdJceZVLYso7CfW0MIQEv/oj5LUcLKNIX9iZ99cQrOP3AFKgyxCxqgEWdeDimAQCYeGi9i7j43eSutCwr08KbwdsDucDfDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723309429; c=relaxed/simple;
	bh=q5mQIDvpETqaiGB3H20bYcGJ78nQlp7zoVwcbTRpwHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtylFtpmnwTrgKgOeQoQsXpa2MGTB955Y9DqahpuiL26grolduZpKXQ6UH8WLARLUIbS4a2cDnKI8Ih7rGDukPyLCXbegSszjlzoLjci+C/VYfTVldy1hKildvy+BMWMxE0NhptMzJkuPOTf236TQjiaiPpySe23kZZ0K3wvdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0XEzK5qb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so6136724a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723309423; x=1723914223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5mQIDvpETqaiGB3H20bYcGJ78nQlp7zoVwcbTRpwHs=;
        b=0XEzK5qbZh/fVvvkkbJBHDa3QeJRSgCIuwv2JLe+orPzQeaYGWKvWUlHoRhL32pxg0
         b7YNTUKLjYGgJqI815RXc8sOehrcYYvirZRiBqUhBg5zrbyUhHQRKivIhk90o+rknYXM
         G6/T6tSaDkyoODBFftPYCH0/WpbnxnWF0VWWy0fd4rlch8Oc7XasR7SDjfFt3+/KkBlG
         0o3+XsPLzvkCFifbB1rB+HeUwqdoRYFxd6e2rftYgoTDojQKUR2GyoPNxY9o+suj/V9Z
         nGMvRuYHC9pV3MvN7oI42EM2ITqgrfCXx0eYXhRvUGFpdgTTUtNmtfgfmd+shSpmrxBF
         LHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723309423; x=1723914223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5mQIDvpETqaiGB3H20bYcGJ78nQlp7zoVwcbTRpwHs=;
        b=PY/uh/S9BQYQqPqZXMxMNOZRXhH9qqxbCQCcDdYui/OE85cb8QJexuS7PTwplQWiIL
         TVX20om/fsYp1ZBSj+jQKQKm0edRN8S6f+WTEz1YXeMIpTcbfgW8gdmUMd+7nQzgEbEA
         yaXbjgqZn1SR7RDmRd64kRSnqJk1TBNG210e/rhxXQslJzbokNXM1+cESyIOD67t4mqk
         oZDZfXVZIbQkmR4VPaF9Xds0hlm363e8iGTMHIadeDXmS86Gu0a16WcE/vqCnoxl8ksb
         7UWmcHGoQjTXfrPH3oZyUw5ulmPZ0N8bvipyYeMq5/wKeB3eDXKqFrmndq41sg6Ue3BQ
         kl2g==
X-Forwarded-Encrypted: i=1; AJvYcCXvZnOIiFrivqfd8COkqMR6QktfXLen5i04O20YOAjHP0zz6RAbXfJ3xtcwPxHHj2Hz3WLSmoI87A8gvVTyft0G+UzhPJgfI2e2DZOK
X-Gm-Message-State: AOJu0Yz6Ka3eLW66kiMZMr++BFw2sf/YbOSrSQZ4XzAbXcQ5hTU4+2KA
	EW/WBUEm5pe+GRzPOi2nZ5BuEB798dC8m9G0HVanP4GAF8n/JQxd17WthOtTKmI55EaYO2QlV8d
	n
X-Google-Smtp-Source: AGHT+IH3CUTxNantP3YdSHWzlNr2hFCqHGmvvRYIaK31AA2iibDMT+XLqTAdjVkz/bCoQebF//x9dw==
X-Received: by 2002:a17:907:5c3:b0:a7a:b561:356d with SMTP id a640c23a62f3a-a8092019294mr824281566b.26.1723309423288;
        Sat, 10 Aug 2024 10:03:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1d153csm83461266b.137.2024.08.10.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 10:03:42 -0700 (PDT)
Date: Sat, 10 Aug 2024 19:03:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] pwm: lp3943: Fix an incorrect type in
 lp3943_pwm_parse_dt()
Message-ID: <yl3p5426peztl2x4nnsvtoelo42bzsali53lmwpysh7cfp5qli@u3fmcmo6tkjh>
References: <20240809080523.32717-1-jiapeng.chong@linux.alibaba.com>
 <96f7b10a-e33e-4602-ab5f-4ebdac260592@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tagwr7qt4fw64q7h"
Content-Disposition: inline
In-Reply-To: <96f7b10a-e33e-4602-ab5f-4ebdac260592@kernel.org>


--tagwr7qt4fw64q7h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 09, 2024 at 10:50:49AM +0200, Uwe Kleine-K=F6nig wrote:
> On 8/9/24 10:05, Jiapeng Chong wrote:
> > The return value from the call to of_property_count_u32_elems() is int.
> > However, the return value is being assigned to an u32 variable
> > 'num_outputs', so making 'num_outputs' an int.
> >=20
> > ./drivers/pwm/pwm-lp3943.c:238:6-17: WARNING: Unsigned expression compa=
red with zero: num_outputs <=3D 0.
>=20
> Which tool does emit this warning? My test build (with C=3D1 and W=3D1) d=
oesn't
> emit it.
>=20
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9710
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>=20
> This problem was introduced in a commit in next:
>=20
> Fixes: d6a56f3bb650 ("pwm: lp3943: Use of_property_count_u32_elems() to g=
et
> property length")
>=20
> Rob: I guess this wasn't the only conversion of this type. Maybe these
> others suffer from the same problem?!

I hoped for some more feedback, but anyhow: Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with the Fixes line.

Best regards
Uwe

--tagwr7qt4fw64q7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAma3nWoACgkQj4D7WH0S
/k4lQQf/T6qKNUuy4/g8ds3Y/Xa4SorW9190u/XaGhq5Z61468lu+4vXvZsGY+f7
Utc5X/b4Uw87ZxTPHz6yfKoYzTG/X9oM+P4s4uyTb81w+dRq6/5ft7HoV7LzK+q6
Qs5aPfeiagXklDpPEkSS/qyXKx9knFipWB5b53azEn3XMrOhG60RL/moKXCdMiMZ
Prf8HWWSqggLWpjBeiaFCUgagNuQvGpsVQ/v0GagAVG0zMWXYE8g88OgiBa29Ic3
FqpKlqkNXUNoQIvoHebo5VZEw7mapL42cc4bHo+vKSTi67UcifzMjVUNwllU7Zg0
D2gS4KpCZ9ylmfAfCdPuN7T7/DVrdw==
=Fhg5
-----END PGP SIGNATURE-----

--tagwr7qt4fw64q7h--

