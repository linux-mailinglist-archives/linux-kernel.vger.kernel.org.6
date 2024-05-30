Return-Path: <linux-kernel+bounces-195779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3498D51C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C564128540E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38750246;
	Thu, 30 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzSpNtS2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060D4F5E6;
	Thu, 30 May 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093702; cv=none; b=rNSqA54lkSMZq/0cRzEDxWl/npawiojZ3WzOtz8F4IF0YuiayavfFcjnktMhDicBKqX4z7P89QjFgxQ/R1Se335HENRdMkCbOXIBZqVrfdkrD0cKenLN70ixmwibNzdFeXL886kwsdt/bQdfjd/bG9J6Tg/V0mtQAaoUP7Jn+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093702; c=relaxed/simple;
	bh=JwPD0bVhS/IeVj1dqlzL/NEqWePcCZ2f0FH75ThyRV4=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=E3sd7Hky/7f3TeWTKzYexetdmWLdmJCgi709Fpz6JKOYAqJIR8BoDNQmE+Pu+u0VYyq1DZWPco40iukSJdYmVShWBnrJLqFRcUuRqzdeJXp4g3NUQsPlA0FA7vrJTZqfopVODFaIzsOIDZstPw3VYe9iCvDBmcLJ+rCYtJNkni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzSpNtS2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52a54d664e3so392755e87.0;
        Thu, 30 May 2024 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717093699; x=1717698499; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9xvggD5zyG5hkDkxWfILJwXhYiELErkkmtBD0MYsbXM=;
        b=YzSpNtS2YNx4uZxllF4kZ60PlkSV7ma3SocmbqijhwFsho/kzjPFrXxyY8o2R3d6US
         AK5DE1vIxTkDi8R+hEwmUejBz9t0yznrg1VFnZVcB0771Zp7xxvXwaEtDC565yCLFwgL
         0oHvzfzs4xeikusqap70rPZFWOGgSVIxPTQTv/GIH+aWF/ifiQ7LKXFqoXlSB33xGdXc
         LceMSPUBvmqhrTLw3BefiKJ+EYYuhSPA1+qRyIpjebPaN8dKOtQA9JaH5BdRWsfYQltz
         sJuc03bo5ADcSh8ZItC4zj0Rrcazx3jIYwU23t8Uoep9QKYItKzlFfh74uRlHc9wXnZD
         rmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093699; x=1717698499;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xvggD5zyG5hkDkxWfILJwXhYiELErkkmtBD0MYsbXM=;
        b=elLfZjCnuLzcwhTpmNzYhPnkFVlPQENV8YP++3hB99TZpFTryPKAVof5KLDHIcvnfL
         1MCyGcFNM8fI3MfLE7V9/HTTbF+zieHQBcPGg/jVRKlPwnlYtjLV0OQphaxjAYkyMOKL
         tew7qw7Xdmh4yhgnA1k4CwHh8PKxaAM/Nt1rtEBUlByXczDWZXbyIwz7nik2r4RMaV75
         Cm3Zv71kPPeaVk2vkdxEnES11RumNF0/0nYJ32tmE/+YoITBOiQS7I2YnmHaPMKJ8T9H
         Lf0yzaY6sF/r+fSK3LT+G5ocGuSSLYjea0TJigyBYMV0OWIuEukIAd79qZsz6TXcIIGv
         CSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2pidLLsRvhySAokSkvGHAyjckwNTYFipBLhsUmXRsn9LKqok/Hu86STwz+utWgQfojFFRLL/0wgTHEToXT02zqmtLU+FEm26aqVmN/wPtJ1HNs/r+9EEyStS+7uiCd4flvnt9K7Q7oSI4A==
X-Gm-Message-State: AOJu0YyS+N0EjG2ArrUA6VDONp/LyeS85Gm8zF3H9wzPTL45764OGqNq
	IPzXETBPJTvQ3tUADHcfmVi7/YLIl+oQRownrwpmOwitC5vLttGs
X-Google-Smtp-Source: AGHT+IEQ0HOg2nVCclhwyMBh137n9XiHsinuwEbUK5FBdZaY8TZg5QzJKYc6yUFpiMsZXoVqvHEN7Q==
X-Received: by 2002:ac2:54ba:0:b0:529:adc0:2129 with SMTP id 2adb3069b0e04-52b7d4186eemr1751587e87.11.1717093698952;
        Thu, 30 May 2024 11:28:18 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85e98sm2416566b.176.2024.05.30.11.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:28:18 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=3c63f374e1b0ea791262a8278936583225c80209dd68e31d90030b5f68c0;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 30 May 2024 20:28:17 +0200
Message-Id: <D1N6WYWR463J.3UVC2PP2CUIY4@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: <paulmck@kernel.org>, "Abhinav Kumar" <quic_abhinavk@quicinc.com>
Cc: <sfr@canb.auug.org.au>, "Rob Clark" <robdclark@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Sean Paul" <sean@poorly.run>,
 "Marijn Suijten" <marijn.suijten@somainline.org>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Jon Hunter"
 <jonathanh@nvidia.com>, <linux-arm-msm@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Build failure and alleged fix for next-20240523
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <287206c0-b53d-4aa1-b35c-0725adc5e9ef@paulmck-laptop>
 <28db820c-860d-be1c-bb94-ed534622fdc8@quicinc.com>
 <4f821c7f-6201-470f-b39d-ba689ca027d9@paulmck-laptop>
In-Reply-To: <4f821c7f-6201-470f-b39d-ba689ca027d9@paulmck-laptop>

--3c63f374e1b0ea791262a8278936583225c80209dd68e31d90030b5f68c0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu May 30, 2024 at 6:55 PM CEST, Paul E. McKenney wrote:
> On Fri, May 24, 2024 at 12:57:58PM -0700, Abhinav Kumar wrote:
> > Hello
> >=20
> > On 5/24/2024 12:55 PM, Paul E. McKenney wrote:
> > > Hello!
> > >=20
> > > I get the following allmodconfig build error on x86 in next-20240523:
> > >=20
> > > Traceback (most recent call last):
> > >  =C2=A0=C2=A0File "drivers/gpu/drm/msm/registers/gen_header.py", line=
 970, in <module>
> > >  =C2=A0=C2=A0=C2=A0=C2=A0main()
> > >  =C2=A0=C2=A0File "drivers/gpu/drm/msm/registers/gen_header.py", line=
 951, in main
> > >  =C2=A0=C2=A0=C2=A0=C2=A0parser.add_argument('--validate', action=3Da=
rgparse.BooleanOptionalAction)
> > > AttributeError: module 'argparse' has no attribute 'BooleanOptionalAc=
tion'
> > >=20
> > > The following patch allows the build to complete successfully:
> > >=20
> > > https://patchwork.kernel.org/project/dri-devel/patch/20240508091751.3=
36654-1-jonathanh@nvidia.com/#25842751
> > >=20
> > > As to whether this is a proper fix, I must defer to the DRM folks on =
CC.
> >=20
> > Thanks for the report.
> >=20
> > I have raised a merge request for
> > https://patchwork.freedesktop.org/patch/593057/ to make it available fo=
r the
> > next fixes release for msm.
>
> Thank you!
>
> This still is not in -next, so I am putting it into -rcu just to silence
> the diagnostic.  Or should I push this to mainline via -rcu?

I pushed this to drm-misc-fixes earlier today, so should show up in
linux-next soon and hopefully in v6.10-rc2.

Thierry

--3c63f374e1b0ea791262a8278936583225c80209dd68e31d90030b5f68c0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmZYxUIACgkQ3SOs138+
s6EtthAAp41m3IJzGSaKe1+TCFp5MCBxweTKfght0Ks+7Djtk1yp0Nek6he8G8YO
f5GWHEizfKgfdQO8NLGt9qw3ENJJOTgiG+TdjQAg/p4Z3uNN5EUqB17l4HR/+ph8
cXB5ZrHqS5nb2jrDGHc4ZJGW/4drN4D246LepgcudAuLD9jy6P9oU5V5tLQMJk3g
d/f24vawHEgVb+IC1q4kyz1rYyFhKOGuLs8KDAUSgR2SN2SQwiA8733mzpjULjCG
dAjSUKFun7EIhEwGTijkwUTVOps4VM6Ya0qHmJSlFbmrRQ37NgUB8A9UGDy7wGiC
yxBM4d4qhbfdyux/NXxSi9xQ0iGHpzi22JlPUFHLp3x9yRmVp4YwQe1gsTtSWHWH
FLW1NdJutUg7L4HQC0roSxwbGgTcEzoMkXD5AJz7OCA8WIG20VidVkAgjUu/qEyk
ZjGofu4Trkr7n0B7TuQtHiJsaCaZ5fPtlqhXYVuo682bcqDqwwWgBVlTBByA9LYY
kAtOYkYWtBAAdQT7r2VeLh5MNiA9o8hbC+dehtickVC+RDWlbAo/M+CZl8rhcDEj
8PY2iRdOtpmOB1KwuVUVzCQSOio8l0B0CTWz92S0Y9vae75uT0wWNAVqskDyK0eN
UgrYLijKMWhHtxKPbnmpQyo0o8FXJSrpPApR2r7ox67VDZRX4P0=
=rMdd
-----END PGP SIGNATURE-----

--3c63f374e1b0ea791262a8278936583225c80209dd68e31d90030b5f68c0--

