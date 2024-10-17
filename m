Return-Path: <linux-kernel+bounces-369275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49469A1B29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930B0289F84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7A1C1ABC;
	Thu, 17 Oct 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G4M9dqA4"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1791194A4B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148281; cv=none; b=X8BYKl0kzX1PSSYX5EhXGWhkRgJmibo2GuZCCmgUOCeSnzpFgHIda80Qohp09StwmboUI7FSKbbJawDr1nWVK3mjlAXmmS60ZdcA2e/Vhh3RUa2iYDV9KSy7yo/LInVwSJCjiGPT0WRGBzrcAq73zIuD4tjyrANP9QSIx2l1iiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148281; c=relaxed/simple;
	bh=MwQ/QqF4Xq3zSl2kH29KTFMa8lfKiwZoQDpkqYfdd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdAytBsgFv4P8Qv5oAtoM1aPeIZCSh3Yh4NLku+ynBl7WHil+vm6rARabJQ+NlF8PZpzgHlTSCXnkXfDnQ7CDIYncdl937DglvSLjMiv7tr1RWuixpg7N8J3z5+cE1IeDb0Ro9Iep4TyZ7HF7jBMEkU4J/9smzLohJ+BQARu038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G4M9dqA4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso5836005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729148278; x=1729753078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3DswenITcCw0XymLVYi97PzAGeMumUlBNRkcDvrGME=;
        b=G4M9dqA4HC2yR5OlT/p16TMrv3UJHQ51bzM8NDXgVtXxauSbvO6zGlV/+fg1TnOxNo
         cjXB7ptdPNUes48tbLYLk2i0yRqFUe5DxsEn22ZJewwmR872F5GK0yGO8ms0r3lBNUEU
         IwIEfaF8T9Lz0IoZxCYn1ZwBuNZhB506AmyQ+kIVYNyJYqq1CvPJ1JftSBMPijRztdq0
         AEVL/XTsCzKOd13yFC3CfVzarYxR3jLUFkk4mBKT7dER4sQRg4A8I0NRJLvpflQGmu/O
         oWty5RdV6pO9FUNok2rU1XhS8ZvSIeEFPdBh0lWD+057ahBqp17nYVVuAFDu065jr7sn
         xF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148278; x=1729753078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3DswenITcCw0XymLVYi97PzAGeMumUlBNRkcDvrGME=;
        b=rQFiVzJzyCkJCy06+TbBWQnEbIMmv//Y+I3hikRDvn/5N22KgVgcFtf0dbuJiepTdh
         /LJvIZO+iJDkL/lmR3+V/W7kvibyshw2TfMZLnk0xrAV9m0J/4QW3ZQslPmwZg7vnG0w
         Z1OYurNk72v6/4Hgz68O9MPnycDxxp7AMxW0y1Xtt3uslYitR96OkUilM4NfZcI/pG3U
         Pr/jcjbpPMwgJdCxB2UafZ1wg43euaxn+LUWwdyvtP3SXWrEQzEd5t3RZVr17dAoLG34
         9x9l8w5EGgv3HBvKyme1hkurBy31VK9L42YuQi4NvvjlfOkvQuTNhj2+9kYw7eLrMlIx
         Ffeg==
X-Forwarded-Encrypted: i=1; AJvYcCVfLEUi9Oz+ifQIeUzaYNzf2vGf3PHL0L60OlXSKd/jizvgVCRx5olHd+VGWzmzcsrrz1moAeHkVkR0zdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIojGJeEcLicAt6+e5XgY/0QufZZwOLKqSsv8dsa3pWEF2HVt
	a45EY0Ykp/UFWrja7yrYqK/120i5nitgriqrqj/jbyjLE5Khthoh1aQ2U2SKgPY=
X-Google-Smtp-Source: AGHT+IHUDXAee0ZTsFk5yuCgpcZvwOmTHLpoWjvgJFOKf3hRZphEDDtXeUsVkyjBa4CIGxD0+pYVsQ==
X-Received: by 2002:a05:600c:4a13:b0:431:518a:683b with SMTP id 5b1f17b1804b1-431518a69dbmr31500765e9.18.1729148277836;
        Wed, 16 Oct 2024 23:57:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87adasm6260026f8f.29.2024.10.16.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:57:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: menz127: simplify error path and remove remove()
Date: Thu, 17 Oct 2024 08:57:51 +0200
Message-ID: <172914826143.5858.8145964682819076352.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014092227.78886-1-brgl@bgdev.pl>
References: <20241014092227.78886-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Oct 2024 11:22:26 +0200, Bartosz Golaszewski wrote:
> Use devres to drop all goto labels from probe() and remove the driver
> remove() callback. While at it: drop the unnecessary dev_info() message
> as not only should the driver be quiet when successful, the message is
> also wrong: the device was probed at this point, the driver had been
> registered earlier.
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: menz127: simplify error path and remove remove()
      commit: 3bd13ae04ccc20e3a312596f89a269b8b6416dca

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

