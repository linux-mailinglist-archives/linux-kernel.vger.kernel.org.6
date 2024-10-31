Return-Path: <linux-kernel+bounces-391079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6F9B8264
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451851C20E51
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B531C8FBD;
	Thu, 31 Oct 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cVFBMI8Q"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E413B2A2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398552; cv=none; b=LGNk8PoXc/BCtkaqfoBBtUjD4CG2IjZ8dw1bH2czM1F19ge31jO6uqpxWopO5ocn9RbLEnRvdLa4Lr30jrUzU1JinXvUL4AmJnH261wf7mzO13NCdMypinZjvVb9X0zyYxn8rcEHcv0GNcZyOHdkEv8wQVOnpH5ipPweqLKpfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398552; c=relaxed/simple;
	bh=CGONGnPUEDtTi2JgkCmUYsvNlgo3VaWNPCFM0hMfoSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=napb1mCQvp7pWFj46y0jVBz3+e9ti1pOO/ZXmSfNZIVmmRRAYTQOPHHnkElT6z5iO+gc943ALBEK5W3s3eyO1kWhXBDyvWNSp7oCWqAXo8FStE8h4+wKqfbagETJjywjJW0FBpgGv3cs9SsO5aAkKQTrr3obMZa+BWcoQhzsAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cVFBMI8Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so963046a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730398550; x=1731003350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGONGnPUEDtTi2JgkCmUYsvNlgo3VaWNPCFM0hMfoSg=;
        b=cVFBMI8QxM1yjP0uqbn3PMA+CHXf+m9GrAdFZ5GJNrmvgfddnV3hzL9Xo/kXiAEVXP
         RSgEXz2CK8bP85fcV32RC1x5lSP9Xf3IvtURBYnmYFDg/kgDdtm5oVw9+AtvsLrEsHPM
         v3Yx/YZAHFXlXpgtTNjWLN4ZNN/hwOTGO7vOhEa8UZQASlDV6Y1Px+js2Bm2hoodzs2+
         UWjUKrGb8/uSHAL0DpPterY6iYov+6cjLEXU/fRQ482csyr92+MJ8YynFJggEvZVGDDC
         4dyV24blI3uY4RKiBIq1YjGmRBQKEQEGht2H4sL3e+dWMSQSJ7hOrxoWAE/+xPz4EyhZ
         SK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730398550; x=1731003350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGONGnPUEDtTi2JgkCmUYsvNlgo3VaWNPCFM0hMfoSg=;
        b=Lv8fJ/3rxqNoMn9h7pFbhbGqL9v3iS2k1rhoBjI0VQ+m3PX59dez049svfC9ibh7v+
         J7YnOTr07Gxm6nh4quKWsfZ1qhUiEGvpFL3PfqSE3RxAJ/ocXPVQCmjmBmsJcYv24SCm
         kdBZgiJDMvqogbAOa7gutdI2yrHEU4kf+D9hlBm8MfjePwkyFzhPojkSe8ajzMZz5yEq
         Hjtclzt7QUHCYKLiRqOOJplEp9svewar5whbrwC3gf5bavl2FBpw58nLUehiLR7n6DCi
         MsT5+Iuw1B32r4maMpCciLZ1rbVJ/My7iTdK6rrPznzFMS8W4pMNck2ISlZ+18GhIabB
         QuQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlmFWBglrTsspjQFTkdcxHicEdP4+wC/eVJrPTBGNrxLzVKEQi3ggKKgx5fZlfp9AnJZw3m79RihGb+E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqXSZOlOp871jTpmtL3cb/9DKwBTDnZzhApol+fPb0FpLJub/
	w9DDscyGTnwVY8ZpmXEyZ3ULm/H/fiezeRjYtBpN/rixQIdZyvMMtm3njtZXeqrcgCETGjbyyqL
	sF0WqYCHyiFdZO4t0LYCS+vDJJw+LZN9WrQGaLg==
X-Google-Smtp-Source: AGHT+IHt08jL+VSeDdxtCUWC0N6k5/FvU8gg9RH4cmwidr/7bhcotgSj2PjtVnJtZFVU8ZFObNcr6YStCXu8I7VEgSU=
X-Received: by 2002:a17:90b:4a4d:b0:2e2:d3f6:7501 with SMTP id
 98e67ed59e1d1-2e8f11df867mr21697717a91.38.1730398550418; Thu, 31 Oct 2024
 11:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028125000.24051-1-johan+linaro@kernel.org> <20241028125000.24051-4-johan+linaro@kernel.org>
In-Reply-To: <20241028125000.24051-4-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 19:15:37 +0100
Message-ID: <CAMRc=MdjkejfSd-4w8nTMoGaToNXqTLitSQU+iBoJbBpUeQfhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: clean up debugfs separator handling
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:50=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Add the newline separator before generating the gpio chip entry to make
> the code easier to read.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This isn't a fix so I'll queue it once the first two patches are in mainlin=
e.

Bart

