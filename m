Return-Path: <linux-kernel+bounces-189745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF328CF46F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992ABB20B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917041095C;
	Sun, 26 May 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cxKGFPgG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6B101CF
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716731615; cv=none; b=EW2W/x1iYeeAHH9V25Fk7FglxVEBAlTCHsX8Qx4vimSrCnIQI8UNUG5WL5XYDKU/VfUP/Kw2ummrr/x8m0u3f35xLSF8uhp/jJP3jnPKEfdTg2wN/083hQ4xror0wwp1ES7AuXxsaY6hfW0f7cQ3fhgB/n88q4n04KiLKTDCzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716731615; c=relaxed/simple;
	bh=4DUJdEjkxUJgbaVeUQ4R/vAmvDf9VaruCLYklc7L/oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBuFOdzqAqluH4U/mk/IZe/EgEjyGWMn933LFzUbCPuu4Orp1pUJcT34roWmpqLSM8+K5kD4V1R+XX28Ma+aXVJfulHQwXlq0zazknOGOGlzSI1id+jbFNEAtuffyzS6y/B8YgVu6/eceTxBlCkypxP5sUI+Cu6jJk+TXdg35CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cxKGFPgG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso43968531fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716731611; x=1717336411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ+eNpUujXQv/I2aShP9JWthU8Vec/B5xvxOzvo8tV4=;
        b=cxKGFPgGZ68mZSWsYvec53i7XZroE2awZLgXNTFhBzx1hDU6epJ1DWpwRGkvXGpJLh
         Bp4XLvAD4dT3VM7ewDJbaF8Pu6u3hqNZWKHCdJf0xVUa91WFcXpc8lVuJoHtize50iAG
         TMdOMgnQiJKyI0VDnqIN70/E33H4uUn7fMCwhu7pyBu/G0rho8lSTM6Wi8prGQK1Wk4X
         eaCcKA2sKMuqtZ44tlifKj5coSOzR9+xpnXunH2+1tYHE+PAgj8kINSqHf8L4U/OwaxW
         k6rYEJJ8IMx6xyQjkwbff9VOQ860L8R3yoD5w1yrW6NPWXLvboNfi1ZYNASEEqRZNV13
         ++Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716731611; x=1717336411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ+eNpUujXQv/I2aShP9JWthU8Vec/B5xvxOzvo8tV4=;
        b=C1hP7JYNCWXB7SpidoCujJkKML/KpLBemIXI2QDrffUbFRnWmzKCg13wpv0Ygd7jl1
         EPHl7r49rf7oij0hz9CPGQGUwWJZCDH2URvBQZLekY/+n3oDr7WWd0mfOdprLvJDU97H
         qGdcxvJO1XnoeYQWPsJFWcUaWQuyc9SWT/k4qhU9QVOmcF2xy4eASgTMT9T60Q/0sFV+
         8IBnn/U2yk8YcL5GYIB1uscsQcd9OF6n2qxPM9C9QRvVtvoG8cuDXmLKynKR+8H1KsNk
         Aso6JT8NIPR9enDuX0HICWgLfKmrXKKHoIvLWKJA9MLvMDw+x68RMkx2sSmKGjSCsdHh
         0P4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeWY/92M++pcgmi8DpTw74KCmIdRPu9B0XfV4HalZkQ5M6k/VUiRx2BfwocmI4GDgbxl3bDNrupJJoO2g/0xEPN9UOnYVKzxZdnD9R
X-Gm-Message-State: AOJu0YzqS0krIe8bNy/AHuQyh+Xw4va4PrkNVhYs7Tu7gfsXRs0EYcpQ
	pk7E16Ksljj2xfCvba2rmAgpczfT0Qsyp9gB6TZHCQ0feXNEuIu9AtqSrPxN9jfCO8topUw9ryY
	944gKxmV1Ylb1wEiAu0yudltLRLBXqvGIQNOCiWm21h01odCO9cg=
X-Google-Smtp-Source: AGHT+IF+3IQbVc77xxtstsfMGHkyaHT/cjv5L3bC7b2v9W3j5znvEb5jOZ19F7ugtzBYR5T7s4xn9B427/FHrhZj/nc=
X-Received: by 2002:a05:651c:383:b0:2e4:dd5c:933b with SMTP id
 38308e7fff4ca-2e95a095ef4mr21960481fa.2.1716731610673; Sun, 26 May 2024
 06:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
 <20240519201241.7c60abac@jic23-huawei> <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
 <20240520171205.000035b0@Huawei.com> <5cf036d5-1eb3-4f63-82f9-d01b79b7fe47@baylibre.com>
 <20240525171408.36bda583@jic23-huawei> <003d0998-dd25-45ab-9bb1-feda2d0f91a3@baylibre.com>
 <20240526131018.40c772d6@jic23-huawei>
In-Reply-To: <20240526131018.40c772d6@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 26 May 2024 08:53:19 -0500
Message-ID: <CAMknhBGhk5VNG+L-HyT3=b2h38k0-dGwTfoWzxLTZfsKuidvtQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 7:11=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 25 May 2024 12:04:46 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 5/25/24 11:14 AM, Jonathan Cameron wrote:
> > > On Fri, 24 May 2024 10:56:55 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > >> On 5/20/24 11:12 AM, Jonathan Cameron wrote:
> > >>> On Mon, 20 May 2024 08:51:52 -0500
> > >>> David Lechner <dlechner@baylibre.com> wrote:
> > >>>
> > >>>> On 5/19/24 2:12 PM, Jonathan Cameron wrote:
> > >>>>> On Tue,  7 May 2024 14:02:07 -0500
> > >>>>> David Lechner <dlechner@baylibre.com> wrote:
> > >>>>>

..

> >
> > Maybe we are talking about two different things but calling them the sa=
me thing?
>
> I'm not sure.  Sounds like we both think our point is entirely obvious an=
d clearly
> it isn't :(
>
> > > Key is the complete lack of
> > > association between what is returned by the get_current_scan_type() c=
allback
> > > and this ext_scan_type array.
> >
> > Why would the caller of get_current_scan_type() need to know that the
> > returned value is associated with ext_scan_type?
>
> Because you are validating ext_scan_type, not the return of get_current_s=
can_type().
> They may or may not include the same data - to make this a good interface=
, that isn't
> error prone, get_current_scan_type() must return one that has been valida=
ted - i.e.
> is in the ext_scan_type array.
>
> I've looked several times and maybe I'm just failing to spot what ensures=
 the validation
> is sufficient.
>

Ah, I finally get it now. I was having tunnel vision and it didn't
even occur to me that someone might be tempted to return anything that
wasn't a pointer to the ext_scan types array.

> >
> > >
> > > So either:
> > > 1) Make it do so - easiest being to return an index into the array ra=
ther than
> > >    a possibly unrelated scan_type -
> >

This option 1) makes sense to me now.

Do we also need to validate that the index returned is <
num_ext_scan_types in iio_get_current_scan_type()?

