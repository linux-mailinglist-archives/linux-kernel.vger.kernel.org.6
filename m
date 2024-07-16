Return-Path: <linux-kernel+bounces-253453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F97932186
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37291C20CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893103BB32;
	Tue, 16 Jul 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jZ9zq28U"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB311224EF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116475; cv=none; b=dcRhLljm6lIjYRA62h9dBSKp7Dij0cGiKsSxpP2vnbTqxSdQk+eOwxvGDw9/pV0/J+7EgHR+SVx2blRUz8Wszl86FDHiW8lNhzEIYQnlEvvNjnxBvyoEHLNr66rTLTl/YsGLy+7zxfeBrBevtnlIr9BOLkvmrE/rtEbNLEciCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116475; c=relaxed/simple;
	bh=MNn8gxXYqvsNcb1Yh/X9L/MXxeX3VNL1a9Hrw0q3y2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=th5rLi17J0ht2fNpFhtNVDHFSiJXNezrmQntnkCKlU8u8h5szz9yjRQnXG774KjyfYMNQGTp3xsjEE1eJTeLR5HPFZ0mib8A/n5PY1NT2FFuhX0Xy4VOjRxeeV+hngtMWpti5/KxHw1rjjgTyvdM5f95ILNx/o36eJAmN6EgHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jZ9zq28U; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so69033881fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721116472; x=1721721272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsyjNs+epxjHFckk0dd03DwfQ8j6M5Wrc4itesRp3IU=;
        b=jZ9zq28U/QegcdkYucUMhsZ0jz/UEk+ep9TqOdqrh04TvsoAMdaQccxfm5eZnYTuFt
         OEXGX5DwXlut5H0URAzWjrVCZ53d8ox0dDlapjfXDm36piDq7bEC2WLj5RVWAME9VmDv
         qUEKl4GAtcMU7cBdkLXa5GS26a4jn1cWeFkbGcrMYouv3BWp07uk7U7YJFUSUXtChr7U
         RK4xW5UXY/Wx1GYJboIKM6H8rGt3QXS5afpnYfs8njrKr5FvzkQML36/Kg20qT1AGyXx
         +1S2AszH7lhZTUxrqNpCwFsh+JCnJEK+BVvGyWgCmd+TsLxxrSER/mWSLszPtJUAG0P4
         JkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116472; x=1721721272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsyjNs+epxjHFckk0dd03DwfQ8j6M5Wrc4itesRp3IU=;
        b=Nc0v5X1hKxZ7SxP0Uixv/HbIRF8xqnyJ7w27REiHSzaMfU177HJ2arFzdqnCg+aPhy
         xWQRHGz4ap5iEnCmGLb5SqU1O3V34afvCcvcheQXKp0/2h1ycQRtdbHlxYQcnYic59Xa
         YEWsLVPjyJFW22kLM0OgV3FmU0Yi3hG463j0WFHxnPhkNgNYAfFmOdVwxFN21DdxHaMl
         uPGOAogJXYQvkbXTrbOi7rcLWhmwVAJ+0meQCZVL8mBUv8A4Ar/tXjEczojI7n3grV00
         NNLsgVTrfB2DHH2YVXgdw9HZVHk5RiIpBEiXbOF7wyShql15fbnm7x25Zx9aphMNOvlt
         Vq1w==
X-Forwarded-Encrypted: i=1; AJvYcCV6DjDKoACH3qJd5nxhO+KtYDMAdaK8gAu9Yo6ag3hcdnZF7F2CUxYCkYZn7UI733cMaxRBdMPdB67wA1zOTSUxjfbxVgyyuu3EBWCr
X-Gm-Message-State: AOJu0Yy6pu1086NhJLGpPaTmTiRr0MH2wGNM2ThwDPYFCaF+cQJ+wR2l
	8LQ/HXBRCxQXRLilfv35WXwCv2PFBiHZO31RWB8nrnMHz5tpj+YBEATLq0w7QV6Su9regKoF/KE
	MwvCNryNwq30Thmmru0pxFdSc6yp1PSLEIGaBDw==
X-Google-Smtp-Source: AGHT+IHxiGnjKEzJz5PukU3GQJwtAAOXLOqzHFNcG1Fx6SzxLyf+ALXiDO+KrLhwXbWwUy5jSuyneyfndt37ndL/n+8=
X-Received: by 2002:a05:6512:690:b0:52e:9ab6:cb53 with SMTP id
 2adb3069b0e04-52edf032e94mr698476e87.64.1721116472011; Tue, 16 Jul 2024
 00:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl> <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 09:54:20 +0200
Message-ID: <CAMRc=MfdREubJBjxy-WDZotYWY-uU_6C1N7L8STisoJwtpAgjg@mail.gmail.com>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:17=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 12 Jul 2024 at 02:13, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > This PR contains the core power sequencing framework, the first driver,=
 PCI
> > changes using the pwrseq library (blessed by Bjorn Helgaas) and some fi=
xes
> > that came later.
>
> Hmm. Let's see how this all works out, but I already found an annoyance.
>
> It first asks me about the new PCI power sequencing driver.
>
> And then it asks me separately if I want the power sequencing support.
>
> Now, either this should
>
>  (a) not ask about the generic power sequencing support at all, and
> just select if if a driver that is enabled needs it
>
> OR
>
>  (b) it should ask about power sequencing support and then if you say
> "N", it should not ask about the drivers.
>
> But asking *twice* is definitely not kosher.
>
>             Linus

I didn't notice it because I almost always use menuconfig. I'll look into i=
t.

Bartosz

