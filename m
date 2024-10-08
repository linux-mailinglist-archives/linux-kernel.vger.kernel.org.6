Return-Path: <linux-kernel+bounces-354792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BC9942A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C391C21046
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19C1DF721;
	Tue,  8 Oct 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MX+Z9ad8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A81DD55F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375771; cv=none; b=ONk0HciNvbJ2kCmXIgctisiaFkpM2NxEJiNSWO+q0vWE2GHdbig36bJxQA1RkWiMSQ9ZgVRm+Ig0EJ3xgWF3kHOwmMdT3I/yFnKwqlEywu32fVLkUTKypvWgrlNjUdMMPmH3NrhgGhrJbfq/2VRcjIkIXzW3k+LFeW01rKi9v74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375771; c=relaxed/simple;
	bh=V+QO1gZ1yi8AFrRG0aci7Zer7kz/k7zfNOxNVNqmN4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG3s4ab48wfLuIZDABD4cWSChfB0/feeaUVRmd32Ww6UkdvOT13vrGuwtY4/oVKzs7c4O4pqh77Tihi++Mm3xx7T9tn55zH2VuhPOVGhbi9t0Fp2rnt1m95QsU+e3KGQ+6+FL9yxajCoQsMA3u7BTTTjoOm85htcqt6ODdhYVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MX+Z9ad8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso47467645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728375768; x=1728980568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGr1KOBqzMkq9zDAlpbx3jqH5CMbHVpkvLSNFLTTlCM=;
        b=MX+Z9ad8AfdvtfNSUD6o7LluzPUi5rizLYknU1l9pXEY4RH9Co/D7YbNnhtnYOIk5A
         hNwFiF4Tc856F1dMbKNjOHywO6N9nCmbtdS7Uztl9D4iCBRjvaI+6GxgFfp4Nn8fnre7
         O5AvaXiiv6tZhLqBDitYF47acTE+uZ8PdPlBmaB4qR/chgIT72qmNCRkBYzwhCz+U3Vs
         c1ZfIt3XfRKZvMZYlHv4Br4NRiDbQ9ZBBdcjkVsygsO/JPrLtFcM9I9hdZbHwPmlEiKN
         w/e7eonnV22BEaPYcfnAj8H+OwmMmKmgw4oK8W3tpVLSVAY59ADC7ltrUZM5FujE9IrR
         ygyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375768; x=1728980568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGr1KOBqzMkq9zDAlpbx3jqH5CMbHVpkvLSNFLTTlCM=;
        b=KGtgd/hE5qNaeC0CmpgP+jUheJGNTbuOgFladOpD+CJ6DH+eAmjHbLX8t9MjXgKGo+
         c/PD0mwPmZ7SXb0b8zUyAPjqRwf1xF4ms/aXKFMoZvZZ+W/6a45xcKeXKGZJUvj3v+mu
         WkYiX2hZDsF+JaW7f9teRyb8QVP3FkGqo5uRUKUa2RdoFlCAiw9x/VQF3aflM1sZkwgE
         h6NBR2jzHa0JLdgntEijMX3ADnZtWKbE2CVIeXygglc2xy1Wf6kEcRIogHITf8Fv/yfV
         9MdzeB+zoCWBzpjZMwF2i4Y/yY61je7wNMjSpLd02VOrAf/4+iTHPeUQjuq8SqC+fOTC
         x5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74uO5e4Kvvmf8YT4wgC+Gk2i55PyTnqleYb4v8Z5WBY3dI1uTVVoCULTZtx6cv7iilMaWOwCwWVXxbdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYEyME9jj3t82q0dU7SOc0COr8p5uLdV671zcbjhmXWWaduGg
	21T/uTBFolFy0vRO5kVmZ7im0OWBO2vrM53ko6RUOzBoiT29p8g+QuZLse9rD40=
X-Google-Smtp-Source: AGHT+IGs6yt8fxB2n+NjHQaLtndPKlWWB3FgWwvloahSXSBLUScPw7lYAquculPe8CZ0r9eHrs7qFA==
X-Received: by 2002:a05:600c:1e22:b0:426:614b:1a72 with SMTP id 5b1f17b1804b1-42f85ac08d3mr117725465e9.17.1728375768211;
        Tue, 08 Oct 2024 01:22:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4304efc2b1bsm9928185e9.1.2024.10.08.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:22:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] gpio: notify user-space about config changes in the kernel
Date: Tue,  8 Oct 2024 10:22:46 +0200
Message-ID: <172837574980.35320.14657169986213990017.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 04 Oct 2024 16:43:21 +0200, Bartosz Golaszewski wrote:
> We currently only emit events on changed line config to user-space on
> changes made from user-space. Users have no way of getting notified
> about in-kernel changes. This series improves the situation and also
> contains a couple other related improvements.
> 
> 

Applied, thanks!

[1/5] gpiolib: use v2 defines for line state change events
      commit: ee194b12bf9a2f2ed57b9c5bc7a5f221f7f4a06f
[2/5] gpiolib: unify two loops initializing GPIO descriptors
      commit: fa17f749ee5bc6afdaa9e0ddbe6a816b490dad7d
[3/5] gpio: cdev: update flags at once when reconfiguring from user-space
      commit: b7adfb6076ff0c1ebbde56d1903daa3d07db92c5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

