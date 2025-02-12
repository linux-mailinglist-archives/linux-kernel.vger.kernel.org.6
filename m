Return-Path: <linux-kernel+bounces-510859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B552A322F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510A87A1E86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E96206F3F;
	Wed, 12 Feb 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UXuAfugM"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7931EF0A6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354241; cv=none; b=UU5Pg3ZU6ln0TUqaTB/ut/wQCxZw5++XHPjA269CYOU6hTQVzLJCHdBBwQGDo369IuhEkQpz1mDMs2ixV3pirXvVAOG0uJrSVQ6pGWhdrr804j7cRuge7OgUdC7f5gz4xMDrTftkYHXS8tSeAJ0E2iuMXo/23gEvB+oCkKmbBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354241; c=relaxed/simple;
	bh=DbWnxZQj/QY2+PENDx3QARa/H9rHcPmmXzkYM1WueAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkaMIUnv3AT+zUuA44xcQFEubbVFO8tgnGpWbe5WQ+tF8/yZkPsjMBJHs8KCW408wshLfK4vepD+/LeNH2JO/bjItMxL7M2VUnugYikaKxgn8/ojGrniMnQ5Z8dX6hAprIBB2LDIDWodGatJFWrrgMaay+DLxcrwdgsOxptnNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UXuAfugM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43934d6b155so3935825e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739354238; x=1739959038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6vJyJgeQHsvu6Ff/y0C/JbFL7zNshY57B+aHRbXHVM=;
        b=UXuAfugMmdiunwS5DAOP7Sb3521mL0MCbjGNacRvIShKBdA7YriBtylrCrtRtyHmYQ
         SPjTxkQTw32WiX8iYfhH0JQMsR0yS5GBp+OORCgDXyEkvNtcWmHi7+Jk191cctQiouGD
         UotovcVOB3KN2EbjrkDggJGd04wE3F0ISLIV16w1lzsAtXwgcdpTCouZo2VoGq/ntKOA
         AncJ4p5VGKgu+NFwsIBOOe6y/+fmMcT8LDJ/sf1SU+2VtismrZvD0tGjNYPY4y53O6RT
         P6BRIIyfrE+LKPL0h91iAwLTepZXfsuEOGlpY+nl+ty3gvf5KAOvIf7Cw2MDDvpvlpOn
         dmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354238; x=1739959038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6vJyJgeQHsvu6Ff/y0C/JbFL7zNshY57B+aHRbXHVM=;
        b=pm/mFOaKrCZEPwGMzzMqBM4AMT1sGJsZZco17vyGc/JHAx3jcJrpIW6V3jJPNQlFTv
         Xv782PKleDSW2lPz2S6SYyiUPeqmbB4CQvoHR8xhvFBLbgDephmsOvN8uSNG4FMuQiln
         9g8mVSuhHQ3Gkm3ELed59Ej+11lhNo6NEDv80LNg5sEF9kLiqIWxzMJtq463YowMerHJ
         S21hLhaRHlDpojcGYjtgc8aafKosmvRj/nqqZw41z/R5F7Dva1Tnhz2K7rTC8S5Mcaey
         bD0GHmeC+lmFx2/aIoIiMK2kBvMxZlqQxcBi3Yh9gggvrM3YDE//XBDCXb9hYqmQW8zI
         cjxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3+Kg/f5lW+3X+aT7NprLth9H30jObIrsu7a7Rw11k/B59Me5jeNEUOOg2SZqDI/6UANNNgJNsGTn+nE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbz3F7E1tV/b6DvXVxhk4IdhCd04HtK+gWyPTAFkwJofitnJvC
	34YV3zY/dHXDQA9ZNEpaXfrc5omy8+h8v4sc846xSHk5Z1dFlKdnouDyQLQk3s8j1x/9uk2i3rK
	KB7I=
X-Gm-Gg: ASbGnctOKBVLN4JNZXTJ9sTzN/Rih7BzOwE2XJDWeMKfjEtwJLVLhStU/RLU9hDDxGF
	RYt+PzyxgI8lDdePZvWeKVdQI8MoIIBaDwOVeTalBta6gMCMfbAKIUj5g+n9Ud+gjKy3wNSU7R+
	0AmiBfz73Tiv+wggLHNg7EnpHccHvbeCvqj2S5aCI+S1lhtANYMDGR3uvBttXc22yGWO7euaW47
	hMooCBjKElv1jur5wWJxZVNXgpLfO/QyQaH8iN20rflMTm+XTOCLtNmusY7JCkYEpcCzW2N4LjQ
	AH8CZxx/stEs1f8=
X-Google-Smtp-Source: AGHT+IHmNW/uEKKhVJH5d7jzvEsFDf7h41DfWWQR+7ySmCWdVvV8vJ3bcQAm3tRGaO+q01hevGkb7A==
X-Received: by 2002:a05:600c:694:b0:439:5cf6:ec3 with SMTP id 5b1f17b1804b1-4395cf61043mr7945095e9.4.1739354238666;
        Wed, 12 Feb 2025 01:57:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd511e626sm11255636f8f.74.2025.02.12.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:57:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate gpiod_direction_input_nonotify() call
Date: Wed, 12 Feb 2025 10:57:16 +0100
Message-ID: <173935420805.13771.5715845143153249360.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250204175646.150577-1-andriy.shevchenko@linux.intel.com>
References: <20250204175646.150577-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 04 Feb 2025 19:56:46 +0200, Andy Shevchenko wrote:
> Deduplicate gpiod_direction_input_nonotify() call in
> gpiod_direction_output_nonotify() when emulating open-drain
> or open-source behaviour. It also aligns the error check
> approaches in set_output_value and set_output_flag labels.
> 
> 

Meh, it's a bit of churn IMO but whatever.

[1/1] gpiolib: Deduplicate gpiod_direction_input_nonotify() call
      commit: 8beaf839018096cd20e427e68645b4fbecdcb1f0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

