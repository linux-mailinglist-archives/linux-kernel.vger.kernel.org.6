Return-Path: <linux-kernel+bounces-245333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0692B164
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6221F23B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC750144D00;
	Tue,  9 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ydv5RTag"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3813211E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510926; cv=none; b=RqMyzM5mIEcidew/o4V+/NEd9bpwDdnp2Ia9tjcfpDAP9NN61rCbpBskvxK60pVcaFwvwbKZEtXyXs0Wy6QzErx0dtIirC0MsHSt749gw2ry8HybLC0E5Sccn36OEAh68iTBpUb/8AHNymjNFULUBVBIBcttsDRklmIicOBXd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510926; c=relaxed/simple;
	bh=xJRLCzKoNDhkeYwYcPWKixASKx8FB9va7pEq5MrqI0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBcSXzTLQd+1agY7lSkEMeU5oZ4IZHInrkmA5woFYWiX3cR764r3nwSY6yLm04Gplq2JLxuSaZzJqzP+2giVXJsFuhhP+Xyd7dHLskXnSiqlyHjgOuVZJ5gfkwA6l63BT+ZPMBwRXkDasmT9XoP7ZYb5rDVUUMKIjdcji0BFID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ydv5RTag; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52eafec1e84so1687556e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720510921; x=1721115721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JalcFjrpq0ahXu3HtCTQVi+o1I/12oWKnc8ukzoGtKY=;
        b=Ydv5RTagbNhpnQsERG8J8pZnx9ZuFH5wXQHhmS0PpacOhVMFQmhuFx8emRIc8oQWNE
         JkZ0Crwv0hJSFH2Fn2AgDb63jIOyESOD/p293DOWXZSOpOQmy4JWSuGcGMvMsRIL6k4p
         XU1S28cUOiSuorKhkRiVqOga+8uPaTlFg4n1jlBOln3sYzcLELVJhGLV2zxGR7wTdmLB
         pMAKPdvHOLpM2ozdA+xKkhS2LskIDTG0yNqvxxtygPyE3dk/Df9mSGuFpeO2XUDM42t9
         6A6BOmLmKNiZ6+l8TazCWtOFNbKgfUDHllEVq3VXsEc69pM1fHjqD0KLIhMKWiuKlHpS
         QrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510921; x=1721115721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JalcFjrpq0ahXu3HtCTQVi+o1I/12oWKnc8ukzoGtKY=;
        b=aa2kNcU1OM86hMNdtNpzSzDu1JcunMYOR715XRfRjbD6y5rAbYRJlM0THcpta5fod1
         G3nbJY/rWkZQSiwZn8Q9s9GdEeN+CS9yDiFiEDkduxkIM/esqEqQ0nZXWNlZ2Ef1mAEv
         5RmeICHUuoUu05r4Y6mf9CiztyL/I1vdApAeghv2bHZPf8qWjFcH9iThK/+4X9JPv3Ak
         FEgUT4ZNF/rr+PSbDRByjP7xFIV9sfZ57AQHQ67TRN/irBMTq9Y98vZA3FpBevL/Vper
         vAcsFHGRf80U1LZdvImrfFcWGrGzQnI8YoQY08etKQaMnWbuhUxJm4UHIP8CUIwxOAwL
         5wrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcya9R4+6NBaaPEM6n9KyqJN/FaVeyYEkqch7lEJdljeArUNc19SV7e91pEhpuBpsu5g1YTVucjS441i52yW5lacdp06SnnloSRfhr
X-Gm-Message-State: AOJu0YwFBRLVhCZaCYW6RPYCVl34lgxl5fVw8mzmFLHMLt7WaVL03rpM
	UVyincedD94Hd2Q8jEfNm3g/H0CvPnEYVcQlzfhHH4xuodlb9u5tWGAL8oE9yZxFpCIpHGghClr
	9
X-Google-Smtp-Source: AGHT+IFzgDVpkTFnErT06UxOVfkF7s4Xx81NBC6zg9ksoy0SIYXBWXCUEC3KtDW6Olt3ymjJu1TieA==
X-Received: by 2002:a05:6512:3d01:b0:52b:88c3:b2bc with SMTP id 2adb3069b0e04-52eb99d151bmr1214588e87.48.1720510921137;
        Tue, 09 Jul 2024 00:42:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c270:70c:8581:7be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42667720667sm83291675e9.33.2024.07.09.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:42:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] gpio: virtuser: new virtual testing driver for the GPIO API
Date: Tue,  9 Jul 2024 09:41:59 +0200
Message-ID: <172051091644.6169.4337890998290511696.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708142912.120570-1-brgl@bgdev.pl>
References: <20240708142912.120570-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 08 Jul 2024 16:29:12 +0200, Bartosz Golaszewski wrote:
> The GPIO subsystem used to have a serious problem with undefined behavior
> and use-after-free bugs on hot-unplug of GPIO chips. This can be
> considered a corner-case by some as most GPIO controllers are enabled
> early in the boot process and live until the system goes down but most
> GPIO drivers do allow unbind over sysfs, many are loadable modules that
> can be (force) unloaded and there are also GPIO devices that can be
> dynamically detached, for instance CP2112 which is a USB GPIO expender.
> 
> [...]

Applied, thanks!

[1/1] gpio: virtuser: new virtual testing driver for the GPIO API
      commit: 91581c4b3f29e2e22aeb1a62e842d529ca638b2d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

