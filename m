Return-Path: <linux-kernel+bounces-210521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029E904514
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40B1287A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0884E18;
	Tue, 11 Jun 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g9R5cbRu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC682490
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134770; cv=none; b=QhuuYWyyfGst6rTe6DVP2Paogt6bBO4Jtn4ykfP9lHsAXt1EWc1Uqio4frjaPd/uYL07oD/nqoG84qPZe8JMQ9sDk9R70LU+5c/Vko5CYNKhCK4SY/itv3bNI74q9aP9XPw1hNYDuwAJr2JS1C62NAC1uxQMwHtyb0qYO3pLbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134770; c=relaxed/simple;
	bh=IqXk5VaCmQE7GFZ4qCk7sOGyNUFyKQWOAEmemBAPTk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VegFHHeRtoILEa0fdceH49nn0hKDgSjoCjqAfZr1liiFVMsHQaoMShsEgSlq2SrNTQDum24/TDT+dx5O+28gbMVW3u1UBW1oRR59jAvGQq3UWBTTVIkEt/Vtif5we2mUGWOJu3RKoQHYXlLTGb6GDZ4ByKmkgpPWv3yc19c3QaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g9R5cbRu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso26654365e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718134767; x=1718739567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5blWNBlgTudEhQ4RHJLpYzb45t+Qa/EiIUihntYMOSE=;
        b=g9R5cbRufbIsL/gvzI1eM8vazAVOq13mCHSG/sLoEEx3qL0fGn3t4erczi1FZttc1b
         vZ5ed04fU0tzh5vpoPvLW5AikvwGL6D+tAiHbds+sMSBJv7ppJ9KkisNPk2N6/GFB1/P
         KOwMKUD3m4lGGygPOdwCXYlIzMQhsICSJAEpqS71loxyfSc+mT+s82/Z37m98DdKvB1X
         +/TEZsBM/Aux2fKLATpJtmptH4AcpHRNIEiIHNEM7V5r5rlDCGyBdr4qYoaKsel5PlEb
         bmDQ4625XqQPMd1ObuU7O52z5rLp0CFHUiR+5u4BU8J33cp+kp2+zIS+24RYVA1+ZZ7B
         4RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718134767; x=1718739567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5blWNBlgTudEhQ4RHJLpYzb45t+Qa/EiIUihntYMOSE=;
        b=rLIfPM+W9GEmjatouz6nzKD8dQQmnRYwDmP0Q2PR45tPptDinfbSUfqShbbwygB/lg
         9v6PGVyJfu++SrBe1wlXL4qzDmjahRgYGaKwxOMJbIgKChCLPGrXpqEFdCoVpSzb0zRI
         newK/SojobmLaGlBgUeFCwrdtCBNyjXEFwpkSKhiJZPyP9C/n23b+YvPzeqpFutPu+Sk
         W3sMDk89Xrn4A62MaeEczS1DfaYJEL+dDwn6aoEGpo9Gj/1gxRJNtbcerFwqPe7WvFRg
         A4SO708IGrBSUdEc8yNaYiih7G8+ZC5alTVaUHy9Jv+JlO4kgnLXw17YdqHOu5sGmmhA
         7MHg==
X-Forwarded-Encrypted: i=1; AJvYcCX3g9YZTfPWRX5nMZaJta/n0etmpDcd2d17w1X5va/joiSKLBl3MfpUcCDU9XUuGNeNXa1JOQ40C360Hq/Yk6+uB2KPDcyq1D3thSdR
X-Gm-Message-State: AOJu0Yxge/ljJRw+DvFp0abV2kiEp89vF7aZzyVPKhe2pAvliF5Var+r
	kx2Pv2apZ5xgUB0lVV9qxhIIVLsAdlj4tfF8L4wHJNmEB+RaTZ/7Hs1aA7JtpqA=
X-Google-Smtp-Source: AGHT+IFZA0J3tmBChSSi0X96XVBSS8JpDTlJFpHi4F1guKOFDJGdDHK4b05tdSaW+ccF+9sbRKq5xQ==
X-Received: by 2002:a05:600c:1913:b0:421:756f:b2e8 with SMTP id 5b1f17b1804b1-421756fb522mr103151765e9.11.1718134766865;
        Tue, 11 Jun 2024 12:39:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:38d:e428:e1bc:56b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158149008sm220334895e9.29.2024.06.11.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:39:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] gpio: sim: driver improvements
Date: Tue, 11 Jun 2024 21:39:25 +0200
Message-ID: <171813476047.70006.15954339117061264583.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610140548.35358-1-brgl@bgdev.pl>
References: <20240610140548.35358-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Jun 2024 16:05:45 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Andy had some suggestions in his review of the gpio-virtuser that also
> apply to gpio-sim so let's use them.
> 
> Bartosz Golaszewski (3):
>   gpio: sim: use device_match_name() instead of strcmp(dev_name(...
>   gpio: sim: drop kernel.h include
>   gpio: sim: use devm_mutex_init()
> 
> [...]

Applied, thanks!

[1/3] gpio: sim: use device_match_name() instead of strcmp(dev_name(...
      commit: 8a05de23adabc4d982dfdeabc184a267f7a50491
[2/3] gpio: sim: drop kernel.h include
      commit: b5f5cbee764e2faffe5241445830a5e43084f3a0
[3/3] gpio: sim: use devm_mutex_init()
      commit: 413427153921ac8263d3a516bfbdaa42fa058085

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

