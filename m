Return-Path: <linux-kernel+bounces-394326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3F9BAD73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796BB1F21B51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7581917C4;
	Mon,  4 Nov 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RYzRsKHL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E7189F45
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706700; cv=none; b=ZVIjMLZaJ/NRrtCKjovRfptLJfUOR/bRECY+BhXkZjS4AGpY9lJ6oilDWx2TQBn/C4kEFlY7zX5w9X/P7MIWGPtivI/8Kokc4zTPJjIEIffsNqyZMfWx/JGthMJJMLzSAP1VgL3BX52QAGcXQtbMdKj7GpXynE1G5u7IA01aD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706700; c=relaxed/simple;
	bh=bBGXpkxQq9WwlvLIylvI4CcKW8asZCBB2u6tYpzX074=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvPE57iWqlSO7BPTfiAaQp44SCiMB2yBx43LcZDYKhkXucAAgWJ65yYpV0c/kcrMaFlfEzQPTh7iCKpwz40+619yOAZ6Le+YqbjA+2VNb3HFuIQ7KxCbgM1+ZLDBBZ1NQCIsA6H2gOC7Le4ZCjLMU+Ce+0x/Ks3p1yrKhcvJmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RYzRsKHL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315baec69eso33409075e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730706697; x=1731311497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoHoUe/n0ru6RnR0s9GjYaOv8P/qZ8/wVvXDim9+54g=;
        b=RYzRsKHLuHWouVtoT2MWj/WlrwlThtOsYPgEezXwvy75/wPPw683M83s4CpmxwlxF6
         aivBqTsYzHjVY68jTVEcruaysC3ACnvhYEF/BSpD5szQHJeak2WPMu/Vfi3ekLS7TiJz
         2F31taCJZ2dwKSiyYObtqJwktM5MnaPZk8T4S+xMahD9D1+TWwFHqFtSoG2juwAgsPrA
         UeEHqUB9z7fyUPYZrGV5RiHmsXcUsCBy8t7rPyAMv61FeO7cp8R4LPXfXxYrCOXVJW6V
         8R/qMu5yvkuRVm5ePCrLMH3JCk2DoV5AW5fRBJRZvco3lXKYLcknpIjqIOnDZ0yeVPGq
         m+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730706697; x=1731311497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoHoUe/n0ru6RnR0s9GjYaOv8P/qZ8/wVvXDim9+54g=;
        b=cpPY1mFS1M0VYsiyfIV4J1OXIzBfbCBi7CKRDpfuoK48KGMeWNFl8NdCbwr1WEl6M6
         +H2b2LTi3pL5ELLGqJVyBOJj27/JS3wXFFsljGSEul/C5A0P4IiB4e2pZx3Zx3qeHsNC
         U1AFh2vLfACCD4ksQwAA9o9Ns9fWkXGSr7ZL0SbMdapK+2gb18kAgt6asBoVoWX6hU/D
         rmKzJdnZCHvDDWa+3hCBxDJNadLNHXbEhikY7mEc28LaeKw46wfStwNRQ4OswQM0UqiX
         Erb7Hl3HCoUIDuGFV1q10PG96C3Swi1Va2bvHXPq6xIfCxFLFsF8en5MdSMJXyOn/av1
         rNbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCyJXmCO3htV9pxKa9YBvDxDKHtYPREEl20h0AGoaC7SNFYJXItcrjbG7yAxLpdXjErnJRa9g0qTq+pRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2or3fucWIlMb+Nzdv9Dtw0keC6RKZn4LKSRRFyfM/YHiH9kd
	VT5m69munyJHNfx7C0Ci7dqyMIAPWxyqe84RsgbEOXwZcIseG8nkU0kbW8UVWA8=
X-Google-Smtp-Source: AGHT+IH9u8iJgfbLJ5vR9M0pvby1ZgK6XMy0sElhN4iol45cul9j18O0oeCBL0jZGJfR0IJxsoeagA==
X-Received: by 2002:a05:600c:35cf:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-43283242c8fmr91040355e9.1.1730706696763;
        Sun, 03 Nov 2024 23:51:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2603:7936:7734:a187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4e7sm144136235e9.15.2024.11.03.23.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:51:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] gpiolib: fix debugfs newline separators
Date: Mon,  4 Nov 2024 08:51:34 +0100
Message-ID: <173070668557.8706.8349521309370832069.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028125000.24051-1-johan+linaro@kernel.org>
References: <20241028125000.24051-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 28 Oct 2024 13:49:57 +0100, Johan Hovold wrote:
> I've noticed this before on some systems but never got around to looking
> into why the gpio debugfs newline separators are sometimes missing.
> 
> On recent Qualcomm machines with 10+ gpio chips this can get really
> annoying when a third of the separators are missing (e.g. when verifying
> pin settings). Hence the CC stable tag.
> 
> [...]

Applied, thanks!

[3/3] gpiolib: clean up debugfs separator handling
      commit: b9b7e4a67de1c9d40138f89e86c92ee72e631f47

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

