Return-Path: <linux-kernel+bounces-365297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F5799E01E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EB71F23939
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7341BBBCC;
	Tue, 15 Oct 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxRaw1l4"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5B1B4F3E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979259; cv=none; b=exVbw0qeyJTyKCLbe6iSSXkvjhyiOYgP9FWKN41PAJvK4D0Hxr6m4xblLSkcZ00z5/8+aWPb9erLL4Gm5OYMt5QRZtm9JbcRW25CbkiI8uyzQxJREihyWgcSiuDetqfk0fNBBi6mInH1WVwwNvZw8DsFKmWpmuI/fDQcIGd+zNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979259; c=relaxed/simple;
	bh=jHgMpCTM4SlQ/6GdpYDS4btE8Eew3VVLXz1adZR0qII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPEdFlBEeatISH+E7UgU2Qy8gw5UnIHzVFiyRdgzxfzlxa9tEbaFS3xEOk9/BevA1NhN/UUjsMgygWnvBzxMIMI0vMxJSv3TZCCXtff0cxI8R4h9//56JTSz//KB3o5isJSn676JamGr/qwny0fGTRMRPeK1LaMwew2kBkv3xwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fxRaw1l4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso4908131fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728979256; x=1729584056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHgMpCTM4SlQ/6GdpYDS4btE8Eew3VVLXz1adZR0qII=;
        b=fxRaw1l4aNU0qkw2PWfDkSkzeccJAQXWqSgA9YRkKFhNz4gH4P5fia+TRMw0HMtmQd
         mPCSJpiiwZHNH9xvuWltooFwFv0nfOMjm2Xm7WLEVGtoplKKIQCZd3I//cB+jR8euU4m
         dUNm0hTkAaupvPDCE/x6fsDppuLOCU87EfgM6s3AsxJEQBYKvWvJ7PpkEFszU5xUksXB
         fyWLB1bA6Uz9AUI+Z3DYF02yfxdccOrHRlLNpa1Fh6weB25u78leFp2rIcJna07s3Ckc
         rRPFkjIJUH2qIidhHsj/SoxLkuZVTourxC8h3raT/PLBbp4KmcX1q60ADhkTYLGqt0p2
         bjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979256; x=1729584056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHgMpCTM4SlQ/6GdpYDS4btE8Eew3VVLXz1adZR0qII=;
        b=tt+5fzMnic76ADR+bs70R2E4jOwV0hd0i89zuRrmtBNg6SDI/8Urs9EPI70cRRLXAc
         Papolm49fPgucJn+GgYx1DYJgqIL1STbmJPqE3bZtrJij+R25uU1SVae23OKmSdTiqRO
         vDsQoP62/tUM9gxtAgG/0/dX8nkysDju3k0IU61ecyWh6FrsBzcwInPkE5W/QvGotj0v
         8ypFC/vKioFoSg54QEhYIXBalN6gSUyY8bvfYufRUZv7HbVv+nrqu70kDVy2Bu8BK9SR
         E3f2/MbzcDuecMcp/h/rphl/0w358aq548TkN4dgoP/w4ijA9d0abCPBuPzyVYQucsUk
         f6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMXKXHW1Z4E3cREIFIw+khX18QmiqE13cTktdra5FuQF1+DNE1IGxSz9fy2Sbw+6EAk8QDcRLzsf2Tijs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBzaPCf9mfIIG26PJEar1SkUkrSQ3vOXfd/9LFKMZfagKaRmC
	/D4LA3zU7l8eJbFgz5WqXTHerpPChyiOa6eXB0WZxp6ok/utTLrc+KzQmOta8q3aCVrqG7Plok1
	5PwuKjU3pSXi0rF/LREkctLwnRwl4Uyoex/a5xw==
X-Google-Smtp-Source: AGHT+IGhh8cbNNdBvYGtYy+hVIjC9uHyrif591LD5maFyHpMiDqT6EiZW1E+t7FildxioHgmf0UJmXMezYyMZGRMdm8=
X-Received: by 2002:a2e:be8b:0:b0:2fb:4f2e:5be7 with SMTP id
 38308e7fff4ca-2fb4f2e5d27mr33207911fa.24.1728979255684; Tue, 15 Oct 2024
 01:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014092227.78886-1-brgl@bgdev.pl>
In-Reply-To: <20241014092227.78886-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 10:00:43 +0200
Message-ID: <CACRpkdaGy7W8CRr8G+R9O6+DEfCz=j=x+-j8qPK8-zwVF=gb4Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: menz127: simplify error path and remove remove()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:22=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use devres to drop all goto labels from probe() and remove the driver
> remove() callback. While at it: drop the unnecessary dev_info() message
> as not only should the driver be quiet when successful, the message is
> also wrong: the device was probed at this point, the driver had been
> registered earlier.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

