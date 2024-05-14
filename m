Return-Path: <linux-kernel+bounces-179135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CB8C5C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19521C22253
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C5181BA2;
	Tue, 14 May 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="ZF1wg4ws"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB3181B82
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718152; cv=none; b=mTU/rT6XVbEqktuXMyGodlnocnty5kV0pwm27fp/GFJ/lS7FOCdj8CbhjnfX4t+ssdXrsfTIVNbWCTCQvycp7kh/LjpGhhku6ZZCezFETTtEEFaVetuB8aIoY45ftRaPW7h7lxMtLUnDkitzAavrBseSHoOXhAtll4m6t58RhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718152; c=relaxed/simple;
	bh=d+VcjteYj9SNA9aGf0rBf0JG873t1FLnFV29qq/mXjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHrdSOML9uRSPVocZoT3b/v/rF1EdH6EJe0s38/haQ9uGu9jW6zMNRAwL2Ki+t6zLzVgdpchOw49WQMFTUylATtfuseP7HuRoYqDN1Pnp42KLvDWuHSFG44N3f0sd4VJHBVvAgZyLtOa5QZg8zSY5qNNYNFdTa6JViWHKRh74No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=ZF1wg4ws; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de603e3072dso6744560276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1715718150; x=1716322950; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d+VcjteYj9SNA9aGf0rBf0JG873t1FLnFV29qq/mXjI=;
        b=ZF1wg4wsOGgwZKVe0bSFdfwyENKqsBfsY3CcdSS5S6xw4sptc7LRW/Mxx1VL06k6Z6
         Fy0ScD3vAT9/FpZuI7p3oIhH66S0AlnbzfWNN0+09CzanqBt1SS5qiPc/eLd6zRJwsEm
         IuXL098LOUkjfE1JScXfaDkOhsVWoQduDaIzYNG7qv5SU0ISH6u0FY4u1YkUrp3YRCfh
         BDkdu/HS+/dpQRrzajaDnI3mqAIQTURNAAV7JgujwUCLnR6FY1t8TYmWlKouY5uvwqyR
         QUnztHFrdCpgIdsCBEdVll0vIPPrHpUqv2Wmz88fGWDrCfMQpJfneLsbH5coc0LQIuDq
         thWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715718150; x=1716322950;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+VcjteYj9SNA9aGf0rBf0JG873t1FLnFV29qq/mXjI=;
        b=u497+1A0Z/p4wBRa3rN6PUenZVQKG60D3s12y2/MCvCh+gVfWoUPJir2QV2I62s2FZ
         ox1l7WhpNSAC66PHIopxNXbVe+Sd8xBCFYCHCoVozAwfenJdAPnfW2oTvSzG3XrE63Uj
         AWrnhSW7bSog4V+XjdgvExiiJ0O2yjlQbtnwiosBOE8MuKno/whYyNO4pfcpaohMZ2SO
         350RHq7ERvUeNWshqXTPG2mH5502OkDw1KJVjkauy7t4aWa4IUUZgcRkhXHy4VzpyuUC
         YVmrelY1W/sR6oDik8/hAzavryJa6Y7QNxDqbdAyaGZQ99cWVenxIrSR7vvAYRFTKxJX
         IFbw==
X-Forwarded-Encrypted: i=1; AJvYcCXRQHYbkgpkfSZqPrZoPvmWnjXGb0XfeMWJg9S1r50IPaNQKaeimo+VrYq898d/Aem3NrCG700wlHY00grzle++rLabteyjxp7TUvMo
X-Gm-Message-State: AOJu0YyIppd92D7wWQa2nUzo7r/kriihXpyuOgzK+rwaA4h6gQPJh0aj
	KhLF7FLLbN1fAVLrNfLrgp5f1/FC3F01C+pBbMJLbB83QSF0LvrAK+dXEKn/Ni4=
X-Google-Smtp-Source: AGHT+IGKbrei/hBF59KPSMuKtm8FOwgj1uruWeGRRZhnJ24IqE3wDufQHwIuC3NPjleyRye7SlHKsQ==
X-Received: by 2002:a25:a322:0:b0:de1:2843:9465 with SMTP id 3f1490d57ef6-dee4f3089e4mr12934632276.30.1715718150626;
        Tue, 14 May 2024 13:22:30 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd42sm56648326d6.91.2024.05.14.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 13:22:30 -0700 (PDT)
Message-ID: <432f336e6d4b0666cfbb431591624d0e1fefd773.camel@ndufresne.ca>
Subject: Re: [PATCH v7 7/8] media: imagination: Round to closest multiple
 for cropping region
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Devarsh Thakkar <devarsht@ti.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 linux-media@vger.kernel.org,  linux-kernel@vger.kernel.org,
 benjamin.gaignard@collabora.com,  sebastian.fricke@collabora.com,
 dri-devel@lists.freedesktop.org,  laurent.pinchart@ideasonboard.com,
 praneeth@ti.com, nm@ti.com, vigneshr@ti.com,  a-bhatia1@ti.com,
 j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,  p-mantena@ti.com,
 vijayp@ti.com, andrzej.p@collabora.com, p.zabel@pengutronix.de, 
 airlied@gmail.com, daniel@ffwll.ch, akpm@linux-foundation.org, 
 gregkh@linuxfoundation.org, adobriyan@gmail.com, jani.nikula@intel.com
Date: Tue, 14 May 2024 16:22:28 -0400
In-Reply-To: <7e3ad816-6a2a-4e02-9b41-03a8562812ad@ti.com>
References: <20240509184001.4064820-1-devarsht@ti.com>
	 <Zj447ePSnccbj76v@smile.fi.intel.com>
	 <7e3ad816-6a2a-4e02-9b41-03a8562812ad@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le samedi 11 mai 2024 =C3=A0 22:38 +0530, Devarsh Thakkar a =C3=A9crit=C2=
=A0:
> Hi Andy,
>=20
> Thanks for the quick review.
> On 10/05/24 20:40, Andy Shevchenko wrote:
> > On Fri, May 10, 2024 at 12:10:01AM +0530, Devarsh Thakkar wrote:
> > > If neither of the flags to round down (V4L2_SEL_FLAG_LE) or round up
> > > (V4L2_SEL_FLAG_GE) are specified by the user, then round to nearest
> > > multiple of requested value while updating the crop rectangle coordin=
ates.
> > >=20
> > > Use the rounding macro which gives preference to rounding down in cas=
e two
> > > nearest values (high and low) are possible to raise the probability o=
f
> > > cropping rectangle falling inside the bound region.
> >=20
> > This is arguable. How do we know that the bigger range is supported?
> > The safest side is to go smaller than bigger.
> >=20
>=20
> Yes and that's what the driver does when do when application passes
> V4L2_SEL_FLAG_LE while doing the selection. If application does not
> specify explicitly whether to round down or round up the cropping
> parameters requested by it (i.e app is neither passing V4L2_SEL_FLAG_LE
> nor V4L2_SEL_FLAG_GE flags), then it is preferred by driver to round the
> cropping parameters to nearest possible value by either rounding down or
> rounding up to align with hardware requirements.
>=20
> For e.g. If requested width for cropping region is 127 and HW requires
> width to be multiple of 64 then we would prefer to round it up to 128
> rather than rounding down to a more distant value (i.e. 64), but if
> requested cropping width is 129 then we would prefer to instead round it
> down to 128. But if requested cropping width is 160 then there are two
> nearest possible values 160 - 32 =3D 128 and 160 + 32 =3D 192 and in whic=
h
> case we prefer the smaller value as you suggested and that's why the
> driver uses round_closest_down.
>=20
> For any reason, if still the cropping rectangle falls beyond the bound
> region, then driver will return out of range error (-ERANGE) to
> application.

I would appreciate if this change was based on specification text, meaning
improving the next if that behaviour is undefined. We might not be able to =
fix
it everywhere, but we can recommend something.

Nicolas

>=20
> Regards
> Devarsh
>=20
>=20


