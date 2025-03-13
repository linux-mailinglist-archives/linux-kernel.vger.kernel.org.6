Return-Path: <linux-kernel+bounces-559042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF3A5EEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D04189FA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBF262D35;
	Thu, 13 Mar 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kf9tWMh4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E026158A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856347; cv=none; b=MHZ0zbhy9MWJH/jzwNmHy57XVnNrZX8nrJFe1V61kvhTJ++VIuPDOWZPInm1jSU9ta5IH/tVX99RPLbVQ+A9BRc+Q3jzeusv89XgXvcEb3C0PpsXVV5XpO+oX6mEc7Bo6TgQieMc2nGwCCTCqXJj9drPYG/ohaj+VeviKwCbO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856347; c=relaxed/simple;
	bh=yeNpjwZl2sl8oqjE5JYKjs0a93TMha76benj0TJYBpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcjfxYvX8Z+qh+vzvVaTQVhr/vgtH7YJICbndlHz5YY1wrrcA5dMZDEFNrCtpTghZSCnTvCRe9TKMXqK++eyEEkJBRTRooweq4XD7OmPMV/GIlObcRx0RsczH+rEgRmCBYGdNNPVuzSwiGTNVSywhsdb80Ti4XVqEKXdMi2bRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kf9tWMh4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549967c72bcso855466e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741856344; x=1742461144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeNpjwZl2sl8oqjE5JYKjs0a93TMha76benj0TJYBpA=;
        b=kf9tWMh4k3NN1sCoD/3wmy4HUr0xqzaAbEJRgOi1S1qIlQP4pu/F94XBHOJxROQZVY
         r19tHPSmXWsLAM/y5zY3pDbOFG8+l36YQtuXdCo/op0z6tzq4E3XCpyl0y5+6e5iQQPY
         r0+U+TERVtb9LCdfiCsOfdhuM6BIv0O5SmSOulr+tHXG1DLci5Rsi+STfDooGKmynmUB
         +CtpivGLyw3/jz1nPwDZyAdO/E3jTfwX2PEGb0WCunuieJ6Dw6y6jxGe7yJ9e2Bl7aH/
         NN8e97FTKh5jA7RoD+5kxXC8Pjjp2o7/PkqJdfe1pzaM+LzrbsWe3S0wwRclM89kGqds
         A+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856344; x=1742461144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeNpjwZl2sl8oqjE5JYKjs0a93TMha76benj0TJYBpA=;
        b=mMI3rL0n0tWkpsmWEl27WW3y3wf82mfzbPg0Qch+xKOAQQyc2CusR2BQGA6XVo7I4J
         5niUkWPY/ZbP2e7gvmB3BCd7Rf5hyMWeJa+osp/BW2QnmttV7B330VJMbCh2mBsJPxug
         7TqfsJp8LhjPebCxZ98MB81oIRkdB93z5tZFYiCnFwgVzq253y9LDMBMcx6+bO7LwdD9
         MqepGQEWqXuNIprZjSRW1KLQvxCxcK9X6cdQE09ZnrH5lKoGWW25MhFLS8Z/pcK0EbJz
         4TbKsT8hDl3EtLe7rJkgFCu2St+CrxiOLs49watT88zsuZ1a84LJ9W+ZAGfQEEU0tU2j
         racQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoWGFt6ooY+BSRx6nRVTk6TWPX1pNy4hmO3uP7rrdfpsucw6iO2BL8/S/22VJgzNjj+U92OSqj1/xKXGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVzvm16J108pJLqLmsVYAh6dpSWN1vU0CB5h/r6Bgbp7r4fqZ
	Ct0lPMd951v12nJkzUuRcD0T88AhnT22Y6MaLzjKi0OLzMj0VyEW0EkpvFc+83Q32OJ5k87eRZC
	oMAPq6unzsqcfalm001Jb0ZfCd/mrWISMQdIoxA==
X-Gm-Gg: ASbGncuSjpAaQRFWXXqRilbHdXwzkZ6wzAJisDtp3jESu4eg2dJZH1a2LU+EbBD7e9x
	/sKJOQGswuZK5tvARFqmhttE+iwLXSZzlAFWx4jH0bu6UNAWg3Y9IwG2/L8LCawTPo9sXDTcs6J
	3WPVrSPbMtCSjDVvjY39j5g13H4LtOX/91U/FCm6O20bvhtK4gVyxEIReydQ==
X-Google-Smtp-Source: AGHT+IGiiFdJ0ZBw6/jQUF8chaOzZeVHHI2CihuJD77p7pGnuyVLUQG4ICD01B3azbKMP6wdJwvnk4QQZ4PxIoF8jsk=
X-Received: by 2002:a05:6512:118a:b0:549:7d70:52a9 with SMTP id
 2adb3069b0e04-549910cb47fmr8194156e87.47.1741856343773; Thu, 13 Mar 2025
 01:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304133423.100884-1-brgl@bgdev.pl> <c540bd72-0d78-4e4f-a6f9-392166cc48c4@lechnology.com>
In-Reply-To: <c540bd72-0d78-4e4f-a6f9-392166cc48c4@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Mar 2025 09:58:52 +0100
X-Gm-Features: AQ5f1JrxwVeTyfPuKATvSFHmNNcoFIbaQ4PhOoNoJUSLtDixcR4Qbb6uk8DZ4sc
Message-ID: <CAMRc=MeOyYauKp2MndJULN3Mn6E=_i6HvLpChJd-KW9Uog6-dA@mail.gmail.com>
Subject: Re: [PATCH] clk: davinci: remove support for da830
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:29=E2=80=AFPM David Lechner <david@lechnology.com=
> wrote:
>
> On 3/4/25 7:34 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This SoC has some leftover code all over the kernel but no boards are
> > supported anymore. Remove support for da830 from the davinci clock
> > driver. With it: remove the ifdefs around the data structures as the
> > da850 remains the only davinci SoC supported and the only user of this
> > driver.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> Acked-by: David Lechner <david@lechnology.com>
>

Stephen, can you pick this up for v6.15? I would like to remove
support for da830 from arch/ in v6.16 but for that I need to drop the
drivers that use it first.

Bartosz

