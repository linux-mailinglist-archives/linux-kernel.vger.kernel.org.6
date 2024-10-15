Return-Path: <linux-kernel+bounces-366309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382799F387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23E928255B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916EC1F9EC9;
	Tue, 15 Oct 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="a5RGMNy6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928C1F9EB4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011519; cv=none; b=CWy5Mjrs14pky86kkqp4jzhsNxADX5A8yabnmYARGNwgWobz7jdEgDUJlgsYq5bh7ZlHodAtY8aDxkKqVOHzFpb6Jc9US8lsctL7XYh/lk1JWyeO3VYSrlKPH0BsN/cQSf4jRbbaiJtewc4ysoI718ssTpRsL192h3T8M+71v+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011519; c=relaxed/simple;
	bh=eYQWHEX4p3a/fnZQ9VWX5UvNWH6lxOblp+VynNg57cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8zpC8Dnqg9pqErrrT92FWoXfHyfbe5zzueQYi4XoJz33Sd0Gy59Grkrf0tSFmctYGMF40wFNStogrzSHSjfL7I8WPv3vvi9/p50gmbPomixFlnPzIU3U+/7aYTP7CjBUmO8druJ5HQwFtyvhZ1wKUHhbd4cWlXLsGp8/iazmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=a5RGMNy6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431481433bdso5100055e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1729011515; x=1729616315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmtbYhWLn0Ei+hFke19L36m0g4WY0wniurF00uzIXF0=;
        b=a5RGMNy6dFp+LbGRr9fcvHShJgJ0fe79V2w2n7EON53akjOP3N3saMXCrfb5cs1YUY
         83pavjlK+dvP16Yib4Zc4nvKB8m1uCHtoxq1p/RQs/G8hLeSEuM5J1RQynEz05ZOeHA9
         /V2JsB+ywd5OL+7hR6yCrxTLW7iNdD2nZrFK5YXVZJq7KoKKzPFHq74g7oBLshf7/jtw
         cmo0PloY0BiQ1xj4Xislym/wQqia4icXta0u92D3gcKU7tJS1/OHtBEFlsssSIZSpcMu
         zFXAxMYBYAQT3ZEfqlGbbrpQjOpnp7NJgd0jmEtjtECPtMSyw44MyrvLPK+tlsaWnVsd
         V2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011515; x=1729616315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmtbYhWLn0Ei+hFke19L36m0g4WY0wniurF00uzIXF0=;
        b=JZTjuUvjK9yIz2QYqez5p3Dvs0gPvyd/qjNcWUbRdsCkpAxCGx2m4qkCrrRNxQP2do
         EpfKt/nB8hl92sVsogyrboIm05sA4SLKiR6xXKR9xIN1fxkmO8A2NLb5wRRqGO/6EAVM
         /Su1vfQ/1RSjt4hh66ll14BtYomm0UA1TJDs8TLJA+2oFqIyZtDP9M90MWJB7GWuY2Ba
         26vn16YOgnkbHO3GDeDeBPJKOKg5il9bU2BKciBc+QX9PIkKerjT0dYzn2sk0o84ekkV
         m0KTmGmlX84MV1Prnu9EZeaj83PfI24CV/pAQwBnCi/rqnr4HH1r/ccF9PgB8pYRtpfB
         6xhA==
X-Forwarded-Encrypted: i=1; AJvYcCUsOjbeNs5GP5l/MPjmxgi56eOIjlwoObJZjad7nfBKPgR8Q4MPhqx36l1gHQ1cHYLuLrt6rYGMOOHlBZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Kgxu24SkmHi4MnQoZ+jOC/ZheMKrQKkvQOyg7gs3XrwP0DL2
	HZFfEWb1tGbZHrqf3QkHe1MN03bRvskJGPRNo32F9+1i2IFGZ9crXNmLkkxVjkI=
X-Google-Smtp-Source: AGHT+IGY/1ommtk7PiWRnRTTjMT/8qhLCmbH6vDxu8ze2oRQD2WRZcaDUh9D8pLOu17F3eA0ObvgMA==
X-Received: by 2002:a05:600c:4fd4:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-4311decaadbmr157521075e9.13.1729011514615;
        Tue, 15 Oct 2024 09:58:34 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314e632641sm2201035e9.38.2024.10.15.09.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:58:34 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, andersson@kernel.org, upstream+rproc@sigma-star.at, ohad@wizery.com, s-anna@ti.com, t-kristo@ti.com, Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] rpmsg_ns: Work around TI non-standard message
Date: Tue, 15 Oct 2024 18:58:33 +0200
Message-ID: <3194112.zE8UqtGg2D@somecomputer>
In-Reply-To: <Zw6cyFirqQ6Esr+0@p14s>
References: <20241011123922.23135-1-richard@nod.at> <Zw6cyFirqQ6Esr+0@p14s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Mathieu,

Am Dienstag, 15. Oktober 2024, 18:48:08 CEST schrieb Mathieu Poirier:
> Good morning Richard,
>=20
> On Fri, Oct 11, 2024 at 02:39:22PM +0200, Richard Weinberger wrote:
> > Texas Instruments ships a patch in their vendor kernels,
> > which adds a new NS message that includes a description field.
> > While TI is free to do whatever they want in their copy of the kernel,
> > it becomes a mess when people switch to a mainline kernel and want
> > to use their existing DSP programs with it.
>=20
> I suspect there is a lot more things to change when going from downstream=
 to a
> mainline kernel.

Not really.
I had to revert c6aed238b7a9b ("remoteproc: modify vring allocation to rely=
 on centralized carveout allocator")
because the DSP has a sub-optimal resource table, and this workaround.
With that the DSP program worked as-is on kernel 6.6.
Downstream was 4.19 TI.

> >=20
> > To make it easier to migrate to a mainline kernel,
> > let's make the kernel aware of their non-standard extension but
> > briefly ignore the description field.
>=20
> In my opinion the real fix here is to get TI to use the standard message
> announcement structure.  The ->desc field doesn't seem to be that useful =
since
> it gets discarted.

This is for the future, the goal of my patch is helping people to
get existing DSP programs work with mainline.
Not everyone can or want to rebuild theirs DSP programs when moving to a ma=
inline
kernel.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



