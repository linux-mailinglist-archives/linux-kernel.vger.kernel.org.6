Return-Path: <linux-kernel+bounces-519213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B9A39924
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D5174F45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF92690EF;
	Tue, 18 Feb 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iHEPd0IS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46444267384
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874409; cv=none; b=DVcMoFUAQwFyWcamoosiEcKhngpGUOreqDei9RBcxbd92FvQi5PtNE0tuZ7olFvIv5YrlC2PRBHP2Yi2CilBa1GqETLO0oulA7poYERg3g/TP7nT5MvHAXWGij9dpJmTvMHhQWdguMtL+k0zem6VYpfgetWTWqQjB1mgYO6f5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874409; c=relaxed/simple;
	bh=R0qIYgCeEQo9kJBLh0KVPhAphFigMXsi3VlgZ5rPKEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUGV01IN6YVo2Dfr/AUKOqVltH2gxQIXzLmuhbMfEq4tEmwdLa17+931VCLK67c9B7jBz7nXqy3PgKeIH4SazIocl7NEi6V3ITnwo2pr0VC4womXjJQq0PM6VCiU85xvSZYWuuR3w1bUv/1epLSVPMFS3H5tYq8q1bJzW45l6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iHEPd0IS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43964e79314so48404235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739874405; x=1740479205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVuCVswV16narj821ZS0eMp6ZNcBSJyZmwp0vTbPAms=;
        b=iHEPd0ISjShzufzAnl4S/W2Acq02mQ/0dtK1mcV1pmvuXXdXtpXViY42qmVwYuJbU6
         hn7LhjpSROd34fYO1QKGi0PSHOrDvCswWo+u19bi6NQhI1MgNHx7qs9ulnHVNlrUkdMz
         +XAN6l6syHwA1townIBq70PryH+b7leQMqkDCwYQkDvUEmaAC0QA3+NMwSJbDckQFbVw
         Fk2dSxSi+8vPFPGQ4beOKg6QD9MrCyP0UhwsgrdnD3LRazTcbCmSB8YplNSF/KOt7A7n
         t/anZfgkmuWG7OGlpNpECAfSPOtJqbkHObvVvCMqFv9dJTS+sdxISXGRWG7ywOLURvrx
         Rotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874405; x=1740479205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVuCVswV16narj821ZS0eMp6ZNcBSJyZmwp0vTbPAms=;
        b=JAKmdC0m0DFd0XV8I+nTxuDt7VmUiXlOgcSNTFZpGQmd8bckKnMNlGim6wusbZLNnP
         ZztQLPDhhCqLvMLuT8Vqg2tGkf0PSmxB4mmZkq0QkXzJRlfsNE9dH9wsnT6HuA1xrx1t
         UvnOnro0ZzBC/DUbrUs5Swsb/izM0t64QtGmIedvzpWDZbiZAcrnj5G8cL2mUbk++pFa
         66vE6wobOybZEaNukqIUS+Z06ougeORj0SdZyzyIQkZfSWlJupBK6skGnW/UL+hDxphl
         79i78jPa59SxYH50um4kVvEwOmfS3cXBe0HEpltvN9UkPs7nhNKGaz6azbcRZrAMXerj
         FH/A==
X-Forwarded-Encrypted: i=1; AJvYcCXuVCTC3kkJ3Xb9PIxcvWOgUR+aiCZpUUA6qduGSPYgVMHx8jzgzh4X66nmC4goZgi+m9DErIuQp+rcmD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzg+/dTgF1g2dVGXJdr+TPzgSL8xRmVt/QPkFc8JR5TgdbSXrS
	5cXlNfG5hHqDObEQFGlARAiDhKuAErImzjqijDPpKJAEPz08bigJ1Ki74nAJloM=
X-Gm-Gg: ASbGncuPULWyGNmNYHJRmv9IIvloIVFyMf0INl5FEMg0DaSp4Nt0nRhKccNlQZwIXjY
	3G15FerHVAej91Ma08WPV3G3SWx6c1M4Y0+bQy77CBEfOw8L33auEzaALXclyGQLraKHKkS1kri
	utD0LgxzsA1rfppCgW0McXHBlRMwn8Xn7tFcfjt6egZGRnJnS+aOnvZjjKxTpFoDhmNhie+Q53I
	3+8uVEpOHgbISw9e2GDe6T18Pn4wpg8yGsd7tlAMVQGG5dxQr+HmHdXg2BcB5WpLHAssge4ky/V
	KT909u2GqcEiStU=
X-Google-Smtp-Source: AGHT+IHYrr9CR1u4TX/WgIeANFN3wkpU/AOROz4viH7ujGhFJvNwmMI6SzTG4mXB4Ko99gH55l7OkA==
X-Received: by 2002:a05:600c:1d04:b0:439:5f7a:e254 with SMTP id 5b1f17b1804b1-4396e745a72mr106742665e9.21.1739874405324;
        Tue, 18 Feb 2025 02:26:45 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:30b8:840a:cf5e:6adf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618262d3sm145793195e9.22.2025.02.18.02.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:26:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dipen Patel <dipenp@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	timestamp@lists.linux.dev
Subject: Re: [PATCH v4 1/2] gpiolib: move all includes to the top of gpio/consumer.h
Date: Tue, 18 Feb 2025 11:26:43 +0100
Message-ID: <173987440185.24201.6935199130548694687.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217103922.151047-1-brgl@bgdev.pl>
References: <20250217103922.151047-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 17 Feb 2025 11:39:21 +0100, Bartosz Golaszewski wrote:
> We have several conditional includes depending on !CONFIG_GPIOLIB. This
> is supposed to reduce compilation time with CONFIG_GPIOLIB=y but in
> practice there's no difference on modern machines. It makes adding new
> stubs that depend on more than just GPIOLIB harder so move them all to
> the top, unduplicate them and replace asm/ with preferred linux/
> alternatives.
> 
> [...]

Applied, thanks!

[1/2] gpiolib: move all includes to the top of gpio/consumer.h
      commit: dea69f2d1cc8d9ecdc72ba350d10a1e71940ef18
[2/2] gpiolib: don't build HTE code with CONFIG_HTE disabled
      commit: 63cdf6241ac7edd94cb4cd9a8f1ba2c3c61ed219

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

