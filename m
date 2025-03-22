Return-Path: <linux-kernel+bounces-572620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4BAA6CC43
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C213B7F71
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B69233153;
	Sat, 22 Mar 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBlgCdl/"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F8145A03
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675505; cv=none; b=aQ00Er9yJrrVf0oB1dWSF1Ia9mu8FzPL0fKUvnuxEVsqYQt2Lw0f7iVwtc2scNADuuAJJUYTUtZ2AYlZauZmKvyOUdRvLNh+3l2Fd2plHSeve64sqsaVEdcl3odV3w7XCqMPZ7kKTmSYs1+b51xHELzl80e69sPIeO5Ddv11CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675505; c=relaxed/simple;
	bh=s+Flcfk568jiSxGbIUnZkHfexTTZTX0yPITgwZ+ocYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFj1OqbgqwTR54SXw/iQ8jk5Q/Sztz1Tvg2UkM1SMfGbqKdOLZvbAKLNnJFlNOOlGLDfmlCu7XKH7d0EdmVy+C/FtbUKTZTG+HxrH/OhYBS72p/Dtn7PKgibeshO1pY8ksI3YQMIHJPdQWv83D6Ed2V2azaGRM++T6CGp2/yKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBlgCdl/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54ac9d57173so4612526e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742675502; x=1743280302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+Flcfk568jiSxGbIUnZkHfexTTZTX0yPITgwZ+ocYk=;
        b=jBlgCdl/rQ0ltNqav4TZw/QrduaQfbCkpMBZ/YsghW9I3SIZ7+pfXjwenakvhPqeez
         d/TuhX3D++8e41vU7av4w3k0LZO7codMdT1gJ0IGPHhj0KYeijpUS2a37wLhvEvdbb2i
         rT2qDW5DOjJW8lrfbcuBIhzgDNQq2tNPm06QJ/MQVib5k38IuM+HqJdGY93W781bB7o5
         gs+7vfovQkrUV5GDO2hDmFYNH41SzPFBfmhhbMKaqMMAmCyFkxyWukrHjVejOCq9DUsd
         lzPIb5zC/L3NOK/RnPjgNCcrrIDakZTlbCOiuZVVRCsk3lUCmwkbq9odBK9rpbecYGFO
         oyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675502; x=1743280302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+Flcfk568jiSxGbIUnZkHfexTTZTX0yPITgwZ+ocYk=;
        b=Vi8Xy4/DDvNEhlnNLkk9nwdBskbtp5og8MRoROJFTUoxmiJc/FkTXun56JTzhzVPJj
         Smyd9ffDAstMEVfPW4OfRNgxOOMtV39jYDtCDsrnVA50d4cT0zq0650hyAilciMIs2wL
         HiQ+tb17/PjMQ73arCW8IKSFDG7St731EQNOS7gypUl9VR2KcKDn6nGFu9IV2/GPYhLh
         Y5akHk6y0F6tziadw2uIjJT3g5JUX3g69bL8aPj3TClwdQ5UHHWduXKMw6GbRamWrZej
         t4UvyI5HHNcWcwOhqVGCs327zRdR2lON2TT/csEpDAVorScdZJru2l7zQxL0xdW0CIXN
         PjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQoR0SBP2N3xdnIJOJRaZUnEZHAoqR0+PbQMNJh9XNXG5clLocKt+wD2ImYQqWvXyRW8hr+xvow5YRcdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxw0MoIrg8YWIfFbTFdeHy/8y6F6kcLigpMNEqTgpQmRf88sVd
	KJX+/f17Nzx5gV3Hww6M0uIQ+GLnAzYwCEarzjBoPBwSpYyDwctWa9ZV2+916lePRV7CLzhHMbQ
	KlwWTzEE8Km9Pqr5yuRTBg4Dz786l2yq1oAE7TA==
X-Gm-Gg: ASbGncvZG0pjJEgeTlvdz97hLLVhC5+kLHSFCV6RaBIvH8u3v9ERSv95XdHPuPnQ1Ka
	d1347LBJeoTCY+4O8SItb3auRUZrpeL4hoGZ4lrEZQarQDB7Jy48P/yJ7moFOm9nbAI+RGXku/Z
	2bjRW+gPMrDLIYhgQnyCWxM6g=
X-Google-Smtp-Source: AGHT+IHGWWJI5JCObJmlqejbC9ZGCn3s0Cwal7t60QLMdK5BgEDYUQPyqeMBUByTA+eeumGh9JU/MsKGIIRqNM+acII=
X-Received: by 2002:a05:6512:3d8b:b0:545:a70:74c5 with SMTP id
 2adb3069b0e04-54ad604dba2mr2358554e87.13.1742675501604; Sat, 22 Mar 2025
 13:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org> <20250321-gpio-todo-updates-v1-6-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-6-7b38f07110ee@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Mar 2025 21:31:30 +0100
X-Gm-Features: AQ5f1JpOqyiDfDTaZrmmnQbBILSf0E7bIKkFcJDNq4nhuhWHpxZa9XyIxTF1OSQ
Message-ID: <CACRpkdYQhxpQPmohdfXy1Caz=Wjg048SpJv_OBLUuOuU0icaVQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: TODO: add an item to track reworking the sysfs interface
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> It seems there really exists the need for a simple sysfs interface that
> can be easily used from minimal initramfs images that don't contain much
> more than busybox. However the current interface poses a challenge to
> the removal of global GPIO numberspace. Add an item that tracks
> extending the existing ABI with a per-chip export/unexport attribute
> pair.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

100% agreed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

