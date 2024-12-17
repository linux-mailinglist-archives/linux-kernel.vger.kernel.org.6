Return-Path: <linux-kernel+bounces-449391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A5C9F4E49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC81890B73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA71F7072;
	Tue, 17 Dec 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmRcvJa3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20401F7066
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446996; cv=none; b=P2gsgZpQ3m2x6QKyEaJ1OTVqRbd3eFCaD+28xH7Mxl8EJPwoYhpWsm3lbG8Z//Od0a0eXyqdr5huz6HBoIjYUSe//uWfzkivTil2FWiB1NivYNCShaHZBodfSbrthHszk91JFYqJkAvurgGVLq8aqkNbGIYK90khacZdWrIfp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446996; c=relaxed/simple;
	bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUAqUya+94i9mjEHWYFnwkSwD145YQxwD4elBn01m+pUk+39TxWNrm1aeR0lgQHU2O6OyXQUSfz2dHBAo+wQn9NmGruBxNy5/q8X6RdqKV8V/KFPbOhA8XJNNvQMWxvH3THx5t43cOHVkV/BXCgx5n3bu/3jkKqCw1y9ZGhrjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmRcvJa3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so5751974e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734446993; x=1735051793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
        b=xmRcvJa3WEHNTJQ6jFS4QaCDGSfFDW8fKu9wpiKn9CApLpdUBp+Rbm/KGM4DuWYhTq
         OEuwFpZVK5Tk7sDAhKoa0wWBWz11/wvbMvsuFj4yx5jZSz+UTox+vNFx3G8cX5GCnA3U
         fQ7dHP392ecZJ5O3L39k+CuqrjXmfxnLKpdV+tTPWc3IR1kcQ5TLU8NY/Yw6IMK1OTSl
         w1KayYS4ck4BVF4BWM6gAaioSexXRkmBAJwEiCjaiRCcBgWXXa8rkcB7t1yhzyzm42wi
         xO24YgDWv41ivj+l0zpCYaUPFKUyhmczjhsitwO8ktz5D6IoBVFJtcKCOoqrn+AO3gKZ
         hUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446993; x=1735051793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbiLnxMYe29FATDk3GKeMYCnIBCLdPQZgZIvhY1mWWI=;
        b=ZfjYnXBGpvyFJBONd6sgGh665zC/gK+YCvqMqcqMC5gvU4XJGH9d2EO+KsC8o2C1Ro
         uWW0FALQiAi+hXh2VR5B67Cf6yapfqyu4OTHpGYSTfH72xj/A2qd5+NKyfSIVhwWeWGC
         p9f/Y61AbUi224J39MpBMlPXmiZlUCqLpnumZxpXHolcMCUXu32wrcASGzKP8IX7+a8h
         RtjW8N2/o90jSJuCj3MY2XleBkV7+d3AK0DRslLYOhoyqYa7wXTj5rZbi6/02U41RNwe
         PCtZpdPsOJBZbCDetFO6FMUM/sSPqrza898Khz+Zx2lhfkxTospsj2RNQOAxBiQalNy2
         kRHA==
X-Forwarded-Encrypted: i=1; AJvYcCU18+UKKKbTharvY4S/RZAmQLsv4uODzzoaJLJK6P+cRFcIEYcFzBsFf8cx66ffHdVDRnhLmZenCw1CW3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+avZAAcC7HfyeumnKrgpRf4oxLjWNBoTBAVS9Zh2ZB/pS8Xri
	FHge5huqmgRCWoSZ+fRRSeGoD5QNS6cd1wCv7pqYJBeK0tlgutmofRkZUGlNx3B4OGwGbo7lnnl
	PE0Grf0e+ZeX8DY766X/xQQ0ewwN6KCM/Q3alNhhTjNiAw3UPlqc=
X-Gm-Gg: ASbGnctEzgU3+Mf2sQUavgqNwCluE5DwcP5IAr8lWqX33LMtkgfOC7QvZX9H5HuVWLC
	wad6YOqnFMt/Fkbh7QUudhpktxcxFwK+f7Lv5qQ==
X-Google-Smtp-Source: AGHT+IEojnvT9hVPC1FrcIjDlzTg/uUCwnVp85Wn55woQaSTaCTEvTkGa6X620K2Ep491Rxn9vhg4tMaL98umVEArAY=
X-Received: by 2002:a05:6512:2314:b0:540:2022:e3b7 with SMTP id
 2adb3069b0e04-54099b71a53mr5065250e87.53.1734446992976; Tue, 17 Dec 2024
 06:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-cw1200-fix-v1-1-911e6b5823ec@linaro.org> <87jzbymldo.fsf@kernel.org>
In-Reply-To: <87jzbymldo.fsf@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:49:41 +0100
Message-ID: <CACRpkdY9RvHKSLcgbncaOoPjzQr4oziwpum-r5QjQxQeTT-JNg@mail.gmail.com>
Subject: Re: [PATCH] wifi: cw1200: Fix potential NULL dereference
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:31=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:

> Linus Walleij <linus.walleij@linaro.org> writes:
>
> > A recent refactoring was identified by static analysis to
> > cause another potential NULL dereference, fix this!
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411271742.Xa7CNVh1-lkp@intel.com/
> > Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> If it's ok for you, I'll add the smatch warning to the commit message:
>
> drivers/net/wireless/st/cw1200/cw1200_spi.c:440 cw1200_spi_disconnect() e=
rror: we previously assumed 'self' could be null (see line 433)

Sure go ahead!

Yours,
Linus Walleij

