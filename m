Return-Path: <linux-kernel+bounces-572617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD83A6CC3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351861898C17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E20234977;
	Sat, 22 Mar 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxFysXxh"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9241922E7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675348; cv=none; b=cp9NLdfbfAlpp/TwwPh7ktsjbB2Tp9dra4XA/W4aU0iqD1DWnb2eoTuAluhmr/WxLfWFN9MFz1LxO7CdgfRturz71/3055juP51+ZDj6Y2YHEaACLYog3pocV02gGuuEZ8NwylmVXTDz7v35Zcbv5CpCjqUIYdDIfUuXqFQbt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675348; c=relaxed/simple;
	bh=KHWFdlZ5NopWz5JtmK2NAcSudHEsFBasqGr4YPt9k0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqovN4E8FRqdRN2C92okW2ty5FCd28qxGbvvoMampDQtv/Ffc3WbOssBFQmOPimgY+PHock1+IDqQ9oB3Q1PO/+zs7fHuRuJTkflGdBC7KzN8mGOuCPDAUOi/qCO4YXEFKiN/kzulNslYdlxKeCI9/xGbFMueD481ugQ+J4E/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxFysXxh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499c5d9691so3495774e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742675345; x=1743280145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHWFdlZ5NopWz5JtmK2NAcSudHEsFBasqGr4YPt9k0U=;
        b=HxFysXxh+q7EcMXLSjcJLWWrsZ42xa74FLZuJWHFwRTlIV0DAoxjnVc+HrqzMj6NrW
         7p4msISCfsPNOhSb3RJFfAc4WhRA+l42xf35e1+/AFwmRhNGlSMe4r/B78Fi/5pj8MmU
         y3/5IAh+B8bQ2Y+28ZbdUaBtg0Rg8gOl2Jfwerr7LIQ+w1fNJNlPGanh3oAcb3J1lR5r
         jupHqt7Qr0g+cuZAl9YMUmx3Cconb2qQZmKl1bkA7sx36xMudbdbDEzv8u57DMXmnkOy
         928/cA4foy1PK5l0hoTYJQbJMALHIm0ZSekYv1U/iz4euUCMxSaUK5EaSzHaP53lyRg8
         Zs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675345; x=1743280145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHWFdlZ5NopWz5JtmK2NAcSudHEsFBasqGr4YPt9k0U=;
        b=TZW7lpBHWNztkmGj2R9wvjvBfqdyDSVGao+0YsqXI5DlJhJRmb5njF50YJG8gTH6Bo
         1DGLvYzMD9W9qxzkDGfyzEEt5nuFTJKglGGTKVLMi0zb6AdyqAw2F/YjBbyi6n5AR/We
         qIaz+X5B4BqAqPP6WSm8NkCE0mHQZhOGabgW2b9PACwp1b9Ye9wPuMs6YbnVumdUCJdN
         31NLl+jPrbqitSOWTl65IrpRA6D/SkYXcVadMagWrxhuzytj/8Og0q21BCsiMY7tSlV1
         q38znbVIM68AN1rkzPA8HsLhP4SkXYtKlEF+TwOrNM+G5vU9kbPtf37fvU6+RmkUiyOT
         +JYA==
X-Forwarded-Encrypted: i=1; AJvYcCUskXa+tkFrAD2+bRnNtbblcVqW3aMj1gqIYJo6PJKgxrYZO9Ew1n1iJWZkMj233b0hn68ezrQuRH+TK3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMNSn6ALMu2u8deY9e4ifzq+2g6o7rlIuFVbsfYDKaMOyodd5
	mgt8f3xQdrtm9P+SWthDWp/q/hbxATDn2G1CfIWE7dDUYfr2nW1Qrc5nKerhy+CveJ+PbePSghB
	x02vCwb1OmzZtWt1fjMK4K2hDwYglCS+uqYkGeg==
X-Gm-Gg: ASbGncujpXN6St7NnnF2cRez+DyWTxgEoFpJlLy/fTd4LqPLODjq1JcdWm6CkOpIykI
	z4/CIfep/t7TY22Tg5F0L39B4WzbDED2D45M7zS/Syx6j63Mtsj71K/b6ZESs26fkqTsUDgc6v+
	L1SqEZwwup0p0+elxE/W2wxrM=
X-Google-Smtp-Source: AGHT+IF2q6jwtXEXdISMrTEJsZHuwMHpkZMrd/gSEhHtVx1XTuAURdVMpBsW+SbKy9wbfa02UJPs70fKEdTSL8nUrvc=
X-Received: by 2002:a05:6512:1190:b0:54a:c835:cc44 with SMTP id
 2adb3069b0e04-54ad65097dbmr2877513e87.46.1742675344711; Sat, 22 Mar 2025
 13:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org> <20250321-gpio-todo-updates-v1-4-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-4-7b38f07110ee@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 22 Mar 2025 21:28:53 +0100
X-Gm-Features: AQ5f1Jo1LvJv_MJPBONuBG0dLKXQjmXaUgF9Pv6wuPi1WRfXl51LTlK5Z0RR9nQ
Message-ID: <CACRpkdaW2JRYH6UTRy04VZ4mtV4bD6LFeU+G3fX0j1vkShjc4g@mail.gmail.com>
Subject: Re: [PATCH 4/6] gpio: TODO: add delimiters between tasks for better readability
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> For better readability of the TODO, let's add some graphical delimiters
> between tasks.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

