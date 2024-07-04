Return-Path: <linux-kernel+bounces-240657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B592708A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B812E1C233E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5B1A2560;
	Thu,  4 Jul 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2Lu453Lh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857761A0AFA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078012; cv=none; b=ueX4xTyT54isteCK9jJafD931hq8Yi9Bi7zbvLI0lppEvxpxx6yjq/DJo73o+cOr1hGzUcCvQQ0rFjJDVeT06sbHVjjG2nZTKw7/5Sx8MAXVhIOQdxCOmhsbHu5qR8tC9n1LV87wF8NIiIIoJncUzNaINBjpoE5bws7RVBcX0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078012; c=relaxed/simple;
	bh=L8hkyB4iq65moVh8U5U7Hfk6dfkNNxJvfiIGb/94R90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYgKBPTD1h5sBIPrCG0ilb7FZioQdFrbGRNvT/he8h5KlaFYxdPhhysxoGOlUVw6aHqcTvvbeMK05ljX00xWUjqBcVO8ICubsbP7VPAnC8MMpgXaUEtSZTyq7JhNl4KBnY4Vqkvp/TwPF1bqsxI0/Q30K6B/3ja1ZbyYS8XEI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2Lu453Lh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso4529741fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720078008; x=1720682808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsJ3JP2U+OMM/MC5OxeS7nWjCli9SHs/T5AYnnnofFs=;
        b=2Lu453LhX8tlBqdkBiPL41xUn8xJr/ahPXpCbMscyyoUIPvr/23p848shOO9ZIBI4O
         3wPThp90WVlN6hRNCjHkm2iHSsQtL86TKMmomfiI2rb/3NpYaugDnIzoHif6xr223nmo
         FMYIBpMtcKz4gr8MV0MpuMfxYh8iaLBsIG1rJrwVhF6XMHWBzEZgbSJNyEQacBk0ZfjF
         KodbD5RJYrjMiuwGLW5IjIbTW4IcHLMjh+peMTdrc5XZSW3HueeqYwJRsJ7S6ZiW7rhC
         6kzHZ9VAw21vZIBYVM9bbcA7DnZvCE3WnCn4GiMhBEHr6vSMTxhHXCuRX611LOGA2ol6
         K6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078008; x=1720682808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsJ3JP2U+OMM/MC5OxeS7nWjCli9SHs/T5AYnnnofFs=;
        b=kii8aZ52JptXOuOxRJ0T6UDZIYuMIH4wXSZFVFz4odhqz5nSlT7kq4rEA29pDknC3m
         LoVF2kviKbAA+91xx298G4qxTEDUWnRrE6/08yM3jIvYwfkh2nahJNBj8aK0LXECxvi8
         uKmJbx4iAM4deRaK1VDt9SJO0JlA85W5OFoKqM+xz8Y4h2gEcT3drgNT0dXVe40Te5G6
         h2g/rJ52b+pqeenbED8bbdY5ILTzeNeZNfoqzlX1Un58NTsFfkJWrnfAs5eD4jOUxXPU
         tRcJb5IOTvboWhGlft2fSI4aGN+s0kfOL/h/GuQKFz3qLkhzXXlp/Fsk19UP9Up09dEH
         YIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgvfMnR0zfCtiDJUSRKatVDiXqV0kE01Iyv1wPA+00G/ndFHg7g+sxOBSYh0IN2/PE9OmjajsV4snJ3TydOoTifJkxm7fCH2bjRHdU
X-Gm-Message-State: AOJu0Yyp/SyBaP0G1D/nhya2TmV3YnVeGpfzSgNJUA7n+IOeKYCrBuMY
	ylIIQc/bLTjipQ3giqw5jIU5SGW+sANneOYMf4VlUA8L+ghlMJAnK4Z0BIFZ9ac=
X-Google-Smtp-Source: AGHT+IHeGvVYJNwlBwjEX5i7a2A260SiDaXGmU3EXhosJ9vXx/nTVNGkGZ/0ynYeTH7A1+UC/bIZew==
X-Received: by 2002:a2e:7e07:0:b0:2ee:4cd8:94b6 with SMTP id 38308e7fff4ca-2ee8ed90e17mr5781751fa.15.1720078008358;
        Thu, 04 Jul 2024 00:26:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a7bc:91b4:6b09:23cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264879e491sm10112775e9.0.2024.07.04.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:26:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] gpio: sim: lock simulated GPIOs as interrupts
Date: Thu,  4 Jul 2024 09:26:46 +0200
Message-ID: <172007800287.6156.4204655048215569328.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624093934.17089-1-brgl@bgdev.pl>
References: <20240624093934.17089-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 24 Jun 2024 11:39:31 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> I realized that the gpio-sim module doesn't lock the GPIOs as interrupts
> when they are requested from the irq_sim. This leads to users being able
> to change the direction of GPIOs that should remain as inputs to output.
> This series extends the irq_sim interface and allows users to supply
> callbacks that will be executed to inform users about interrupts being
> requested and released so that they can act accordingly. The gpio-sim is
> made to use this new API and lock GPIOs as interrupts when needed.
> 
> [...]

Applied, thanks!

[1/2] genirq/irq_sim: add an extended irq_sim initializer
      commit: 011f583781fa46699f1d4c4e9c39ad68f05ced2d
[2/2] gpio: sim: lock GPIOs as interrupts when they are requested
      commit: 9d9c1796a6ae70290c2e013fe4d79e99039a1015

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

