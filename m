Return-Path: <linux-kernel+bounces-363520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F100799C36C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2387B1C212AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FE15A85B;
	Mon, 14 Oct 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Wao6WulG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0005158A33
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894720; cv=none; b=p9jMehAihGU8jY64ns0PnskcCVY74ClERk8LpPp7UWUD/i4/ukuj18ZtnrB72z7BDn6Gnl0kHFb97CeSuEisuGeeLo2ATdFL5uiQ4lirPq8mztrAQxSBHhENZOlhapfVMV3te5R03fNW1g0D+30MnmCSIlWwm4rMGx4Wrw0TtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894720; c=relaxed/simple;
	bh=HOQuL05aTcz38UQAXd6dFnZM0C3Y3Fs1xb6v+HFs2rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=he+oVGxCSS8JG8RiZP44Tn8AV5VCTJAdhU8udoXQ6fvyK0s3OIwFQ4Zo9RHoyrXwZyC1PDUSs3h+myxiHSiOD96v2PfWQKTGzyuyY86OxiV9yOJUjYUNofHS6tS33P6CP2HmMibc0wCc2acRVLA0Am4IgmfFloeASoAqLBAQSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Wao6WulG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d50fad249so2499146f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894717; x=1729499517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnqEt7xHoA/xDc8TV9q3o1UbtE0Cr8uGVizTXc1c8c8=;
        b=Wao6WulGa/RU9eFMHjos9HqE6IVyuZ30AoThee+rH1AojU+kjg2w5scjTX1cHDv8nz
         UoXZTd0qCZTSLrp2jOGmNqTCh0sLjb4JOn9HFZtAbedYMFDQuzIEQyaymPukHZ5xdzx6
         s77B0nvYifBlGXfVqjfLPQxDYk91+QqDMYSSR3iZ1Q7ulBvL4wp5NvOWOVWXHFZGHuPc
         twmIHpemfCbNzidHoHR1EH6V2EQRtsn6I5tBhDXXo98s8P/bHabCj2DVgJ7RMPKzExVd
         lP3/VTKtq1rG11Sg9NzmgXA6Gkj369oycyydxuC/gl2Kx6WMwZ+GgpZyaQhlJ0qGwQFQ
         0q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894717; x=1729499517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnqEt7xHoA/xDc8TV9q3o1UbtE0Cr8uGVizTXc1c8c8=;
        b=sEauqrTlOzcduyNND5U+3m75Lzaw69YdM0dwFKppWjb0u5U760l+RpUiL2lVgtzg80
         szNTRx7OIn+w54VKcX4+sCIZ3BlTQUcFdqvLOm+jTlKmXjdIqm+qM2JO0ciO7QRr2/eM
         6p4j6yGarQ+40L8AfrwQAtCWAmnNlQ1pi8CDqJxyAq4r7jKFa+2Ca+dgzMj+LoF5MzOu
         D4kjYhEUw/KYLvedXVzHaAhGB1pwJQGp91BbppG+z/mI+aVrkkEUdKwrAvvnskMXO5Aa
         Is+/7UFwyncpKcIUPCosYctxFcuF6JBTMM0qwm+scdBRLUE1Ru6WK6BlhuFLxRslpGES
         RpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOFuoE+TgxgN3EgW/2ccCTef+5OEr+d9XVE6jeBO0DRDwmUBzk/Gy8bCtu3r17Si2HrxxJ34RCvpkV0N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHvRrww3i+clfafvI9wRPOukASPmokld+3uGZCdi904f53D09
	V1gjtieosrloPt7GYUXUvBOnXXYmwB0qgC6K1AL4hY5t48GxdFu+slZbF1KUYBy9eG9ovIcBnbe
	l
X-Google-Smtp-Source: AGHT+IFypyDVPNB7GTsY0jbyqffL/WpbjaCVbT/mDxbT4wDXJ36Piix6XrL6ax+D9xuwuNyBr5Jfcg==
X-Received: by 2002:adf:a306:0:b0:374:c92e:f69f with SMTP id ffacd0b85a97d-37d551b473bmr7205594f8f.16.1728894717195;
        Mon, 14 Oct 2024 01:31:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] gpio: vf610: use generic device_get_match_data()
Date: Mon, 14 Oct 2024 10:31:36 +0200
Message-ID: <172889468798.57095.6447484996457464693.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007102549.34926-1-brgl@bgdev.pl>
References: <20241007102549.34926-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Oct 2024 12:25:49 +0200, Bartosz Golaszewski wrote:
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() and with that remove the of.h
> include. Also remove of_irq.h as none of its interfaces is used here and
> order the includes in alphabetical order.
> 
> 

Applied, thanks!

[1/1] gpio: vf610: use generic device_get_match_data()
      commit: 1b35c124f961b355dafb1906c591191bd0b37417

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

