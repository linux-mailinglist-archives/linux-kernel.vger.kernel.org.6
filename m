Return-Path: <linux-kernel+bounces-561141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C8A60E05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A225016E481
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F81DE4D6;
	Fri, 14 Mar 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xScv5mFy"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEE1E04AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946265; cv=none; b=oImPlMRic14FGBZq+VHPO3DKigsPnacU1HbUN7iH7En5DZIlP0X3hL4SXl6bgrkwjCbvGy1Xi/zhecFjw6TGLdjFHMJQRHA8PeHBYtGGQDK7PbCiDGe8WoYgiWMEOyMxBJg0n4lMt4vw/WNvcglqIk+N7GYxLis42c53HRYcp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946265; c=relaxed/simple;
	bh=LWKYNIbfHrf2dIs2Gr9oQspYlrFLbqyZwnqfyCC9sp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDrpSLsURqJ3mn3LS4kYdqVVOYlG0NoTwrfLkA7AjrEdikz58iMZfwko2CHbjUInoog0cycddUmqKJhD/KeQnrcw/Mx2hoO3lPb6atk/sLBEnX5IH7U0M3bLJ0xDqBUdOdDlHCQ8XU+xAgZMpVYn8OC84t9EfB+3UXXIYCV04s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xScv5mFy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30c091b54aaso17772531fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741946262; x=1742551062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7B97j7QW4aEhOEY12AmZMGHsvdqRoWdmKy6CRQeoK0=;
        b=xScv5mFyLQIY1tnTmmxQ7RVBkIH62/5zrfBLn3QFqfc/X0c0wqTl1Nu7YsPc1tXe4u
         zJoa4CBUAQVhvF/r+yb/OJ+gP1A0F/DGXLiItVbLOfQ1uwVETI0PTqJyEOfeCyjQxWaf
         4kHSX41yjOeiPF7UT8bn+ABo/P9TU/5228fIr6tSstkWPJ7GmJr8B1JUK7+/lfv7+y74
         KXidsliQiDmlg0OFpXLPM01ukg0MaZAjFNiujZM1Kr7slvxg5ZWWRVW9iyZqRDSK2sN/
         zwCg3z5mcBTXAPHEpBU3dlKa6NtmwCCyMNCNeR3EwzqWBxksQ7IN8wnIXWf/ImVArDTJ
         E6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946262; x=1742551062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7B97j7QW4aEhOEY12AmZMGHsvdqRoWdmKy6CRQeoK0=;
        b=G8hssN0FC5ysO6V2V8LD6HlA6ylbr9CZcH27PBupI1epZB2F7wrZUwtDfNlXGTeNe/
         wKMxm+1M02Ic8rG6tOnh54JbER0SZeVr5f68TpCN7BDO7KOLZ0vo9r+7O0rUhogbcNb3
         3Mzmnb+LPoIZfnF26xV1ijISsTshGGutQ9J5OO2cYyU9YpA+EQnGINbVHuPkJLp4d3is
         bZoABF2ilel3wywozOQNBX8C8UA3nfjolJA6QVB0VkjPGrxDMO2BLiTo3NIIe7fSzOBM
         TR6LxA/7UIq995lFPwdplejE+byezJuCK3ZUyISXbz7ef4C+p6paOjvXjGGSTtLrlCaP
         sE9A==
X-Forwarded-Encrypted: i=1; AJvYcCUcwgCfKZcEU0SYdorRtSaHp0+ujQpv8u5zdtFKRmMViDAR+ft/gzM6nuZfdwd9WFUk7Cabk9hojXav7KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSZaIwPRnfTd5Nz1Qn88BH02A8LgTJ1Js7gKiHxVeNNxDacxE
	nm4+oOlw6Keahmw9AgrSTOd6S+9bEyUwf6UertLOj5qt6EafGV9EteH1Ual9l/MyIyyIksVjbGD
	5H5fEHPWHl1EMC3Dcx6H0CrzhyNcCJ2RnfyZmuQ==
X-Gm-Gg: ASbGncsiOKv6xpRx3Yv9oRl2poqCLe54LSKDwEKa1yqErvTfcV3I+HoEMToLI+DTmZH
	xLV7Kj/sTREA5JpvTkk5o5WDPhYuBOgQjO7MvL/bdEpScppYVhgGcPOUJN7GVYzyAKHxFm0xKvS
	//I5shc2HVebD4og7WNLnIniSUNhKSooF7cVHRXexL5QyYF0ImKaP2V59p5oPZHYE4uBF7
X-Google-Smtp-Source: AGHT+IHUkL22puzejCWdSfcyfhQgtgP41R6mY2yr83XR0Bby6654IFiYrZrKZL88lqND0syAtI3FL3xbo6lkvTl7yC4=
X-Received: by 2002:a2e:a582:0:b0:30b:b9e4:13cd with SMTP id
 38308e7fff4ca-30c4a74d14amr5326571fa.2.1741946261461; Fri, 14 Mar 2025
 02:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314160641.75afdc79@canb.auug.org.au>
In-Reply-To: <20250314160641.75afdc79@canb.auug.org.au>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Mar 2025 10:57:29 +0100
X-Gm-Features: AQ5f1JoIA53xACAJX3Z1UhX3wGqrZSlKJbDOiiubrXipf4lApJl9HrhvdnbqVQA
Message-ID: <CAMRc=MdcjeP24n=Mo9bisBw+qjz+jmv2NK0WtSCqYa6FHJgSUQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the
 gpio-brgl-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:06=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/gpio/gpiolib.c
>
> between commit:
>
>   0102fbf52b93 ("gpiolib: don't check the retval of get_direction() when =
registering a chip")
>
> from the gpio-brgl-fixes tree and commit:
>
>   9becde08f1bc ("gpiolib: don't use gpiochip_get_direction() when registe=
ring a chip")
>
> from the gpio-brgl tree.
>
> I fixed it up (I used the latter as the conflict was just in a comment)
> and can carry the fix as necessary. This is now fixed as far as linux-nex=
t
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>

Thanks,

I will pull v6.14-rc7 into my for-next branch once it's tagged and
resolve the conflict before the merge window.

Bartosz

