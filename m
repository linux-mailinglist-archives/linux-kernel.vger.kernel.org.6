Return-Path: <linux-kernel+bounces-375792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B889A9AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855B1282413
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743D14A08E;
	Tue, 22 Oct 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bqV8K0xF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F31465BB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581715; cv=none; b=YMHxQIW6x06aaiMaL8C4sQqls43+chhd7cLUXRpVVcPuHRj2Z7wY7CD7NqRgLrFXTRE1m5T7TUJwyMHAKMKrc9GMDoq1wqmpp8hzXkFZpXLw5AHsy2l4Ofm2P2OAe0lNCchIzqpdFg3FdiAb2oDmWag4SWUSs6Dj7mYsoqlq1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581715; c=relaxed/simple;
	bh=9CBkz29mLVQAbEQ7wTV/BYgGmzmw+enhQtCpmG1QYj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4A2Nt+p0NDCzZWeo5pDEDHfiMpHb+kIF8GVVeO9jrwr3N2TcG0vpTsNpvQ4/VdQvB3KOEwjwTDi3u/GBe7bmvbQdvjm7TUqnxIKJCGo4k8LE91ORL+1kkHO8vcP1RCD+jmNeV+11z9UeH8gSjtv8/1xXBJUHwn8Wj9mYewlg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bqV8K0xF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316cce103dso36928265e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729581713; x=1730186513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15zyfNYj2lwLq+Kn4fS2pz0ncB6EnSFkoCeZ2Tc6ozE=;
        b=bqV8K0xFP41y4EjM0llVRYXRX9RhDrA0G8fVqrkYH2kElsH0Vs2ns0/xL2fQrH8FKG
         /AONMC7VnrwCgGyml6qArZWA+lRUfWfndls+ShTJTqeyG1zjPgjkmoKthkGPxAInS4m/
         ltIMekjwQFBOeLlY6+w1QhB4aA6/UjqFo0eZU3EFCW/z+o/YUNfMOYwYTEsS0ry0Z086
         /DVBTnBCzN2Wnp/66gZ/1hDY5gO78Wut2PBHOPypo1+TE3rLNbWCwj8d1WmCGo9rOZOh
         Q0+1ZP9zzxgwFFbCfD8cVvW8UqLeG1u6lLBrE8OmUc7x1LOu/OOpQwUiTUwj2NYYvkjp
         ZmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581713; x=1730186513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15zyfNYj2lwLq+Kn4fS2pz0ncB6EnSFkoCeZ2Tc6ozE=;
        b=FoYvQ62oDQFbN20/p8UyqpeUCgqc9kj/XBz130hQKtLb4uXSheqL5cQKgSMFIzSsP2
         nwHMLusnw5Qd45JmKp47W/680vq/g0RU8moxy5+k5HI3Jf9CpomMxsvS0lQblbIiK2nz
         zWIQ3KXABt3GZt9QxjUrUzfiU8Ca4twbB7OqKKBbjeh7/pHuZBJiKo5aH1vw9Ovi++pk
         FnEwQMBg6FhlizE/6k3GXIm9Yr+WUaUNrl38On0msBAK/0PYoo433/nBszw1AuID/4b+
         Ex4L6MI5ESXDe7yaMrBbbBtg+b/NjSrTYRTQ0btP8HRz8a8vDxtZoSYx75HdlLlzZhOQ
         iWUg==
X-Forwarded-Encrypted: i=1; AJvYcCX/E1T7YnPgRXWwP3Xl++bEx4J4JRREJfksKXGxm1h1DfI5mG+XAyFQn2bSkJmGY7ftDWNXF5VOvzImGCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kpK4/qx521qzz8QewRbt+3hTdUYyJf3i1iVr3eiTz7OqR985
	7cJE7WXXdEC2CLDJ2nosxLditLvWZ1pF/w3zlQZesk7SrGma3ysRjCfyE+HPdEk=
X-Google-Smtp-Source: AGHT+IGU5znKna/XKNfNduII0UxhuAkgFg6uSzzlOrY7l/bLkNmn3Z2D5poXLeR85ec/ufvJ7/bL+w==
X-Received: by 2002:a05:600c:350a:b0:431:59b2:f0c4 with SMTP id 5b1f17b1804b1-43161627098mr143475305e9.8.1729581712581;
        Tue, 22 Oct 2024 00:21:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9c8b:c7e5:66f5:b8f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a47b74sm5942453f8f.27.2024.10.22.00.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:21:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/4] gpio: xgene-sb: Improve ACPI and property related code
Date: Tue, 22 Oct 2024 09:21:51 +0200
Message-ID: <172958170915.19451.9656518623046632221.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018134550.2071101-1-andriy.shevchenko@linux.intel.com>
References: <20241018134550.2071101-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 18 Oct 2024 16:44:59 +0300, Andy Shevchenko wrote:
> Improve ACPI and property related code in the driver.
> 
> v2: reorder the patchs so we want be sure ACPI_PTR() is defined.
> 
> Andy Shevchenko (4):
>   gpio: xgene-sb: Remove unneeded definitions for properties
>   gpio: xgene-sb: Drop ACPI_PTR() and CONFIG_ACPI guards
>   gpio: xgene-sb: Tidy up ACPI and OF ID tables
>   gpio: xgene-sb: don't use "proxy" headers
> 
> [...]

Applied, thanks!

[1/4] gpio: xgene-sb: Remove unneeded definitions for properties
      commit: 8b26b8e8be3eac0a3beacf1f07bf2dfb4d679d37
[2/4] gpio: xgene-sb: Drop ACPI_PTR() and CONFIG_ACPI guards
      commit: 33319f6d3416fa00e87e9abf41d9ac98a5d5185c
[3/4] gpio: xgene-sb: Tidy up ACPI and OF ID tables
      commit: 6ebbe789fe7a65205f77289d1ace46d52f1089a3
[4/4] gpio: xgene-sb: don't use "proxy" headers
      commit: 101b259bce5cb7c74c4f96712ecdc4d204d49360

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

