Return-Path: <linux-kernel+bounces-363515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A999C35F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413B0B261F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FB153824;
	Mon, 14 Oct 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g9u/1aeT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0F14D70B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894708; cv=none; b=nJk+C3PejHHrQgRYv09TocCM4DjLc8hN0CSUaNociCM+a6b/yS7zL6L+QpjpYSKhSrssyvXdLfJWcQOttsgmWSswjCBioijkZmQGwVLM8cfwF2SAykWaxtYNc/VQ/OEVTxPPXB9VKrxCJ/x4k4A19fpD3YJPmRb9nB+hmNoquEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894708; c=relaxed/simple;
	bh=gmWuCVngXdsFXb2tCMrklsahOitu2AkKO6bcxumDxTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOuOEBoYvmTXA5TwEK4+6uYfvc0tmMhGBAlGwmrIswDNQ3MTXvihallGKtq9bSDmFfcRUv0m9rn8ZaBEY5AJNgtUPY9Totd+zOeB7i4UYswFIrlq4hM2HGDLbTKKAAHMdhfTHNm6UuU/1hDWfkVXV4PEHIOpCrFXnVVb9i4d4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g9u/1aeT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4305724c12eso30012055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894705; x=1729499505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2aUenQHtDR4d3im3kX4S2ns02KTZQwh5qzY3YgiWBY=;
        b=g9u/1aeTUqMYbDGTvsHDQH3407XRnf9vJvFYtYwKmX7Wxs6lxTVrHrl66lSCRgqY31
         wpLx9vaDTiIH1q3lqVrFKUWyTJe9KlFNEf5yWJlg+nwYh5woW51VdcOOTp1nV+WALNuG
         66mV/dxeBR6KHwevjvDD12U5lUzsn9T7J6JQ4CKUzEL3N8z8HMFiOqHNLebAXcK4Uchi
         aT2zvQTNZPgg/VZCnRPEqrghHdSQpLCAesFoH6hUyGYyMZaI8qewICIVVKr/A6FLPhFj
         MV3dgFrdgROrSgCGC5c3YyHtEHPPMdaTIt7sPh8aXMaVN5ULITb8sA90+rqEAIN7QalR
         ciJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894705; x=1729499505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2aUenQHtDR4d3im3kX4S2ns02KTZQwh5qzY3YgiWBY=;
        b=TX+Z1m9rgTFGHY/tFxDpgNG+pti11ZO2JLmZgkpbJiNZI5CBEVylxUNfr9n6l3tVi2
         UEIiTgyD6q6wlqd0JR+tapojDpLcX1vBzhGyxbkFex5TCgohFj8He1pmax891nNcQhQR
         Uk2NM6k13+ig0xeetWJFAs/FuY4Njg+jjRog2D5CtBCy8PLoN6YMRdNXlNMlRH4OEc2P
         GIHCSoVg9pb11sOg482OWLKaZkzZghjIylK0pwCvZJ7aSkF63nqhHMgOhtWw5wV5zh7a
         e9SxXu3/teaK/l5aZg8iW79AkXj0aXkL6QrFTAzQ89+8hM3VJ2wvCbtPuKkVg83sKvnk
         gNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPNSXWs/KULxWCsjnO2YhuAxfsscSnAkkIcGQIkxZxJdt7uIvcTDU4m736sT6rTgUjPUBY/nnaX2yAbiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fopHlXPbufYS0vddezYFmMgrWUVU2q2Dod+mQAtAoFe18ufK
	cesFtM9IDLU5zPEKY2Q11fTtSum598Nog7YUBQgu+eTnyA5vc/cOaAOfAPYcsKw=
X-Google-Smtp-Source: AGHT+IE0IvkqMtxjmmWnvyKx/nVbv6T1IUy7UMhj+4NYk+B3uzC/VKqBrGEM/7Aqd8RMPLchoDgXNg==
X-Received: by 2002:a05:600c:19d0:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-43125609022mr59886525e9.22.1728894705196;
        Mon, 14 Oct 2024 01:31:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: mpc8xxx: use a helper variable to store the address of pdev->dev
Date: Mon, 14 Oct 2024 10:31:31 +0200
Message-ID: <172889468798.57095.15268233570021195003.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009162910.33477-1-brgl@bgdev.pl>
References: <20241009162910.33477-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 09 Oct 2024 18:29:09 +0200, Bartosz Golaszewski wrote:
> Instead of repeatedly dereferencing pdev, just store the address of the
> embedded struct device in a local variable and use it instead for
> improved readability.
> 
> While at it: rearrange variable declarations.
> 
> 
> [...]

Applied, thanks!

[1/2] gpio: mpc8xxx: use a helper variable to store the address of pdev->dev
      commit: 2707a028c9b9c54a6dff22c9dcfebf3083ea095e
[2/2] gpio: mpc8xxx: use generic device_is_compatible()
      commit: a937ee6d7eba055226fba300e17ade6f65de6d93

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

