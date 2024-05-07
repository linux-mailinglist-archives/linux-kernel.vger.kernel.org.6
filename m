Return-Path: <linux-kernel+bounces-170826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D278BDC96
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E501F221C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E113C3E2;
	Tue,  7 May 2024 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="evFCDuEd"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538B6F06F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067834; cv=none; b=QBLl0ZxAK7Z/tmKpDEhBDnyBNdyBa2yh7xae9CY2nlV0Y+EyEBoPSOVi4CLHqXFupZVuNwt6VA5X4nTvEVJy2NFJMtthahZknMlv6nnqHaqiWt7zA93AEl/+R7EQmb/kEJJhKyHSkUJTiSzAhpOGNeJCQ9hAQ7ObWI0xQHSCWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067834; c=relaxed/simple;
	bh=oHHqYRD7qMgv2wEkOdho0u35Sixf1MXzeNBC03qPDMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuidW4dI3YQ6CVYOeJ7r8KNJoii4+Yp+BNuOeZww1774PHDOaDeA3KQ83jJMoQFdlxANlXQ3Cfl/nci3yypLGWUilc0dXgTh0N37ADJAzkffWsRj4iqnIvc+xfiHotvSgLodfiCSGJeOl6TaDtllAfkrRjeMV1TEAKi6/MOPTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=evFCDuEd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d99ec52e1so1776279f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715067831; x=1715672631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcEGZ5grKxd70UshoNQ02EH91BRv8n2zkyfR63pxkJg=;
        b=evFCDuEdAF5KL0fNIe8H7amA6FYBUxP9e9JhoGSlxg6hgahnxs2XBRUjwEc7yOllmS
         wL3tbFi6AIHfdPw/heBTO2w6B6axGIRRkVTEsbifqOjw/sSoAQcObXosx4jJ6SA8fYkF
         JEybCWRXE3qlZrNWGuCib3xTeYuCV4uREuqDN/GvaP2MnZZZY2Bj7xZQwNuNjarz4qvD
         jwqm9+oprraiZpfgc0hQJn2XdtAdp41IzCPBRuwabiuTRi1YFFl+v8teusQgOKyOwGvM
         j+l50dkRxnEIWKGB/fp6iPhOhUFoR2Fgi1SkryEo5giy2rODJ00wEIQ/2E8D8qyxH87p
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715067831; x=1715672631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcEGZ5grKxd70UshoNQ02EH91BRv8n2zkyfR63pxkJg=;
        b=m6yL3u9/RohMCwosC5/7nrm7xZqUnTdLMYWsjF57R/yaf170lNSCpsELghx4m8s0xX
         4us+OvnrDChj8zSr/lbqL/E+1j9wgtxmHDV0Dh298LF9tpe8ls/sAmOa1pRo34yCzDHo
         j+ECvY11djK+5coquLhH6wTGP7r/ulictyzsqVZj12I4ZOGYFUGKO8Gwq20WcrBb4tKz
         9AKxTN3y5xfRWHRa2Hex64kh7hic/LQBU9r3ZOMu3m8z4D0VjXC0c26mbZxHunjGq62A
         zJe7RK2crdxZ8foLXJ3rQuWwrRIedIJU3pqbsyGK3GqX2tEhJ09LpNXUNPACjyzo2BKY
         bJNw==
X-Forwarded-Encrypted: i=1; AJvYcCXKqAQTfMikvMs/M5qBB/TRhBdNtp1eXKrGiTgmBXCwxrYt4m6o6TIi3xDJJsmLbrbOE4+ZnJpYdMJjCxR7RzD0CUN9rTfY90qj7BFr
X-Gm-Message-State: AOJu0YyoEKTdQbZwGUq9AheHmqHkrqHWs30mZ32a2GupXbARXvKBT2dT
	UKeUHRfm6sM8F728Idg7Nvg4jIDaFKzFWYKDuqAsY7E8cgvJtBdF/Hvhc9iQWa4=
X-Google-Smtp-Source: AGHT+IFI/xCIACN3E54mOQrSdjKSC4CLhwpA5gRdj4LKQvI58B8XAwdmaCnLNwGESmPcW97zSCNY/Q==
X-Received: by 2002:a05:6000:e0b:b0:34d:7a55:f95a with SMTP id dx11-20020a0560000e0b00b0034d7a55f95amr8170777wrb.19.1715067831426;
        Tue, 07 May 2024 00:43:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:581a:1d:3b79:3b03])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5412000000b00346bda84bf9sm12331872wrv.78.2024.05.07.00.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 00:43:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Discourage to use formatting strings in line names
Date: Tue,  7 May 2024 09:43:49 +0200
Message-Id: <171506781682.6288.6692636956225077878.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240505141420.627398-1-andy.shevchenko@gmail.com>
References: <20240505141420.627398-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 05 May 2024 17:14:20 +0300, Andy Shevchenko wrote:
> Currently the documentation for line names allows to use %u inside
> the alternative name. This is broken in character device approach
> from day 1 and being in use solely in sysfs.
> 
> Character device interface has a line number as a part of its address,
> so the users better rely on it. Hence remove the misleading documentation.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: Discourage to use formatting strings in line names
      commit: 2b5ae9c7d9e5ef4bc52c932fdf10328feb5167c6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

