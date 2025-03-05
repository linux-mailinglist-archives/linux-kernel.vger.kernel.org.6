Return-Path: <linux-kernel+bounces-546921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4BA500B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C01884F00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7F248890;
	Wed,  5 Mar 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="l9Mm3tv7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283438DE1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181845; cv=none; b=qZj5V4+v6/jcJKQ7q63vLJPPe7HI0aF2tX7xPkVFyyTTD0PM3QRQTKwV82Nd50ZuADglsUfw9VYR6K9TAan4AGpe26uHu6NSxdmeOkMZHJKgebztf6btvTpJfIrKDjtkp0WvM6oOnaRPeLoUv5Z2Pu44N1qwfF2eXIwG87xXSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181845; c=relaxed/simple;
	bh=CCEWgqLj4aiuDzP1CDbs8EIm+Xpm8K8kSq2O/SBGEZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbjisjsyjrJ/SeVsqvJLXrJkSB3m5DyVicrEMX9ksqIfnl6CwIgvzy/fUBFNkF2bs92ztp5CBvHXqqE40LCUIlAswUFivRtMpddzmMOuZj5znEI75ym7SiOgD3YYNE9nEAjtG0sgf5Cy6s1FvT92SGfum3UxTfvTv1Dgk2+ojSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=l9Mm3tv7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so6025795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741181842; x=1741786642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDpxU5tOoSGV884CeIJTg60HSzdLE+BUNCutu1HhCPQ=;
        b=l9Mm3tv7n5tFsioiIu0R2wdseU6DjxtkyUw0teCQ2ieQCqx+vlVD57NpQZN+1YOqOx
         BK+6CCq92rSVF/IB3w8T1AticzwEOz0+ISlfsvz13VRGykzgXwarXCEgyG52sm8Bi9Nr
         ZAbQd6IUZW0IucDdC2ZMp12OMF6ulgvl+a1jEWgmszVn5ezUuzF96hEwpbSygTADFErO
         6Lh878ewU8a0KsodfqbnAscBTP2Kv5KqwVgzLro4dzyQMb5UchK5iQjDgHzo+8yURj+5
         bprfS+kwBOYB+P4Q9lNUUbiZwF8Iinbma9O2yD9kVYNCbYJ5WGZx7Lwj7vfGwgUzBSxw
         yJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181842; x=1741786642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDpxU5tOoSGV884CeIJTg60HSzdLE+BUNCutu1HhCPQ=;
        b=XrbX4VVNPBi9zyV1wgOP5030yRopJobI/4akalTUmqLUMao9uvDx7QnoVHGVU1w6wD
         1CEJYCE2A71Z7YJplAC2SpQ4bZ/M7y2ZtvVZQk5kaKng6IJSIIPzZoUxBORflxu14/xE
         zhXEqFw50xqhqOm05xIYWyoRcbk0h7Nn6D7VvYH11HyZjTsIOkXvmLJr3pB1O3JPJJFf
         BGKSwMkK0bH1l7884YPm5krjTiL0KHQsDEhyAPqFyrgHMHwxWXEicqRTtW02cuDOa3w7
         LOHF8n1yN1sw73MitGAN5m8R+/r0FZUfFtPLeA5zGdeKvfg5R7PzoipjCf5I5tE6Yt40
         ZCDA==
X-Forwarded-Encrypted: i=1; AJvYcCUC1kSpU2epVw4UifOCpVIsQ8bl9iiqewE4HnEObe0ze53wpjKK5zy9paQBvP7PIYYxwBSpvjFiqRlvfjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9wT6oAdJe/U1uD6ASwNdOp9wiq8E0M5OJAvmsVSetzspkGu1
	6rZ4lkXkKdq3TOW3Jxc/sXWkEcHRGOoHgYdCvxu+sVXKQRws15/jGISb+E0kd8U=
X-Gm-Gg: ASbGnctHTHcHEBLVT7dR9Ls1hU/Z5hUpWLNWjheE0OlHAA2ZGRajzG4zrklniyTjU/w
	qTbpJLdS1TlU1EOAQHqdoq0JZ8HxJXSu40vatSz1EHlJthC8VDPlaZ3l2BWmxrmmlevKeFZ3zCI
	QbHbzRAW6aL2H7CJMOI2vFse0mSSbeU87hHRf0u3REjww8izCrze5UYyrz+2isZ9QCOhtQs5iGE
	tzEd37ake8ItP6hw/EE/Hr7+ebufcwvGBsECFDp0anotsCqzbwUYL5ylcOjSrC5ZanfMkeMIqwf
	zDNC8TFaNUPLR0CsVRoOc8ONDg4o7a007uJ3Lgp/RD0S
X-Google-Smtp-Source: AGHT+IEf85Rj96IsphN4XwesJwrtgwxuE8nIHMoDHAnmsOaZvl8juQN14Y2RcAgYKNr2utbNi6Vg2w==
X-Received: by 2002:a5d:648c:0:b0:38e:d026:820 with SMTP id ffacd0b85a97d-3911f740634mr3591774f8f.16.1741181841692;
        Wed, 05 Mar 2025 05:37:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e514:53b3:5af8:e408])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm21487179f8f.50.2025.03.05.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:37:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/4] gpio: Hide and obey valid_mask
Date: Wed,  5 Mar 2025 14:37:15 +0100
Message-ID: <174118182949.69056.4837861377864682454.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741180097.git.mazziesaccount@gmail.com>
References: <cover.1741180097.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Mar 2025 15:11:59 +0200, Matti Vaittinen wrote:
> GPIO controllers may have some pins which can be excluded from the GPIO
> usage on certain hardware configurations. The valid_mask member of the
> struct gpio_chip has been used to denote usable pins if some pins should
> be excluded.
> 
> The GPIO request should fail for GPIOs which are masked. Under certain
> conditions this was only done when GPIO chip provided the 'request'
> callback. We fix this to be always done.
> 
> [...]

Applied, thanks!

[1/4] gpio: Respect valid_mask when requesting GPIOs
      commit: a501624864f3fd9ab785f1f674f48dca535b198c
[2/4] gpio: Add a valid_mask getter
      commit: f636d4f60ac477187a466a573f947731fa762059
[3/4] gpio: gpio-rcar: Drop direct use of valid_mask
      commit: 43b665c961a6468fa8416805ef71daa5e7a152e7
[4/4] gpio: Hide valid_mask from direct assignments
      commit: 8015443e24e76fac97268603e91c4793970ce657

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

