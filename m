Return-Path: <linux-kernel+bounces-365298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4B99E020
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FAF282913
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D601C3040;
	Tue, 15 Oct 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2VwPFkO"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111B3A1B6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979278; cv=none; b=SPYz3F0b26hovkwJNIKrlbrzSKqO9kLnLEATqQJ6lsYnBGnKKOfmiIspyP6jh6LKSiWwuyMd/WM2ehka2unZZVIK5sGHXsxcFakcrckEDyruyMFvQNgsYTLF6wLSsoifUcewI3+aIHMJOPihzXbSoIAw+qHF+WHc7kXIfcLlp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979278; c=relaxed/simple;
	bh=pIgO6XYwXpJc/EvDj62RGinZYW8LiDBdZLoR+q+waa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkgenx2dJ3+Ppt118CJk4G5rT3gib1KBLvky+OYDk3eb8LDsiuT75B37FL3lE7rRvrJFpxskgNFlAu2MN4JfsmJA5wwvzcnQE2KDIhsmMOwHP8TB7BK4Nc1RGSSVJqRHjMygfPZhAXrpRPoZ2p5b2UFZrJWuypEbmCp4WJYtg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2VwPFkO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so9632471fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728979275; x=1729584075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIgO6XYwXpJc/EvDj62RGinZYW8LiDBdZLoR+q+waa4=;
        b=W2VwPFkO2jOlg9/RnMI25ZJwEnEp4r/QMXeRkrs1lkslYJcZiZZNvNSIQM2gtCdN8R
         ZH9bCxOi5I3Ex6OpphxRmhTVSxwPBaSWYOMJLz/rx0tBp5wsHPiuEnfPb2ZtIxdcrCKe
         gFP5bRm847jw2PuxkCnBHAZFPrDuN6IS18vxnt0FZyob45wzE6qcnb34E0zUROjYVVVz
         gHtJFgT+sqDlV36It71Hscu200olgpTF4G/7wv6PjfrOyGKIZwMGAPnDOCNWWeDCww+l
         gUq3H7AWsRXkWByVbpv8t7strNHaFn5HpfCdPQ9J26Wcj72RO8Y6/mvZ0BDJP09MkRNX
         Lt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979275; x=1729584075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIgO6XYwXpJc/EvDj62RGinZYW8LiDBdZLoR+q+waa4=;
        b=vxgOUW395zMuLLLmK1gbLElR0KaSRuW5ZgOof0iyZls/XFp0cbYAUfoSizruezCBK8
         IPg4YGC1mF8Ega9u5z2VIpvl88YSQ9tvqDs+0fiHho+kW+gtT5yOLZsqrMkn22AjXbDa
         iLFZ9cdRTh3XVmnq6rqHBTI3b1myBwk01KOcJdzwDM5B2Pm4G10VKiEiU3hu7mWLbM22
         l7rttS2ZoEGOeCrCFTvbnQXdvxlPtOkp1kCYuODJ1kSIm+bRUKwuzeHvmJF1BeY/pBkp
         9hH4pmEoF3gOyFYsQR/nQ4e/H0LrMZCMbezSh/TjFjs0MiveWozO9OPrIb96Dj6r3Miz
         IGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVrL9nVWXxUy8PvePr42bEm2MaVI6sJpaSlRCqKJIA1Ft7oKVLvvTA5ZKniIYKD0sqLIu6LrIfaEgVjvk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymltTq2bBppnHh1EzrUJcVvoLlxXOqj5WqqkAfTWXt+jP+kTNw
	1T5tXEttUA/IhimWDrO/gVQS+ivIfNZnyhLXDjBy9SWw8Ck7cKs9Qh1ndyjODLPYwXmzYiwJ+XF
	L8pQr3IR5l/SQES4SlVsxMcHDOYEjk4JUE1/cMw==
X-Google-Smtp-Source: AGHT+IGE/sCPCFMXV/AfRwSUXg7lkFjR6NSHlew0WV7C2E88OUkUL6CHmuX2QQd+Yi2duv7AODl11Uytgr0Y/xNW1YI=
X-Received: by 2002:a2e:a9a4:0:b0:2fb:2fbd:3c54 with SMTP id
 38308e7fff4ca-2fb32740379mr53333381fa.2.1728979275047; Tue, 15 Oct 2024
 01:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014092909.90607-1-brgl@bgdev.pl>
In-Reply-To: <20241014092909.90607-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 10:01:03 +0200
Message-ID: <CACRpkdYVe_SVW_o8HkJamZ_m2izKvbV5vj9qOg4eTmGX47RerA@mail.gmail.com>
Subject: Re: [PATCH] gpio: amdpt: remove remove()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:29=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the managed variant of gpiochip_add_data() and remove the remove()
> callback.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

