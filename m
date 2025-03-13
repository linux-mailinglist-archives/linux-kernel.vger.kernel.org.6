Return-Path: <linux-kernel+bounces-558977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436EA5EDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF5F189F44C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0E26038A;
	Thu, 13 Mar 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jKtdhVlm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D461DF26F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854043; cv=none; b=dolNpeF3J0BEjpeUaqFj7EN6e8CL31jCGmafDPWrhsZln91IOo0P/8kZkgqoHjTEPtvsPbtGKzwxDfDN0BhnCPhlzG7S9hFvmv/FTMO6l4VRRq1aPAxrYGbLGE7cgPbof/GVO9uNIl0/LzGgLFxRbyjEo+xWF6273DGZIFdSKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854043; c=relaxed/simple;
	bh=Hy+xSuVofnwueySGzw2wHE0q2UL2HSvh3hUYR0Xn/ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVBaO8VUbwOcv5GkMxyFj0DFW9K/FtSrIhbMYDaajW4gZcfxvovKbrkx8yBb1I/MtkTkTd8Gg0ASwNThB31p3FmN0fgfTHKqxmohyT74WwIr+J9uZlZvO3Ge1FOhUOe2B/cwJz/QGpH0JFtb9RIxKI34Hep8trjUSuSokrB/sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jKtdhVlm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so5487045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741854039; x=1742458839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNbTO5TjicLjBY2S6bO59mh/PAXU4LLxrsvGBXuMbkE=;
        b=jKtdhVlmMwPyE2+sppV3ay+nJcv+9tPETYnXdKA9fmcG1Gs0fFpC2koFTNVHhyxvLT
         E5zCacAOaCLUZ1aVWjhv0ME96TbKnOv7BgoQ6KEs8ZqNwcephA4prbe6jms1w3Lt5KcL
         UN+1Qfv8Yf1ruROCb+54956b5G0WRUUeZjBnzvOBugpsIqYJCpLLvEQu27VE/6D3Z2Kx
         jfH1SCihNWkaR3V5oaNU0LJS8dm0CxCpS+wFylMKQqMSoQMEjg2q1BSmT23RyyOCFXU1
         U5n+kdt3BMVjlrHO2BqHGexQY6jbCxTNWBJXSZ2pqsLUuT+Nb+J7VDpE6Ar1t4ZPiOgh
         +Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741854039; x=1742458839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNbTO5TjicLjBY2S6bO59mh/PAXU4LLxrsvGBXuMbkE=;
        b=QKU4b8V1aPDJZH+uzAki6+DWB+IrNLlyz04B/rB9QmcROZsifQOvHf6A5nAZbSMgw4
         v/S+yxHLVr+DJmGlpJx9T1TQ0N0np7O1k4Fxgc5TUQtTgNuSXp+GQZW32ycO4uk+OdH8
         JTdtgTeavGJjjv8RA4ETnC97K+6CpWCxg57rO4w6s/GCA+9paWU9hPvoLcJQJIpOhQ2c
         iVD4megcc0XS2Y3YNBomPcVRhvPSXyi2DhBkOfBPcEjRdJJx6CDL9rtb3DClIZRMr/z9
         JqMItqKJukTmcVjpCsD3lx/sFaLBoEFJyLfM1IVC6l9EdemlW83FpM2tPWPAPNUsHg0P
         EhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbQ9+IU6/t0Yn3TwJI7W0jxicHXORp6Ox9WO6zzF7lVMbvPUsu4wZKQ44zkREXptir/N59+X+TIMsORQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02qseHuPS98OimvbxwIUHpW8b7z8M/OGmsKDFblcX1iNTWg4H
	Fotn68FoI0t1otegMSNP9pyMR7Et2dAaofXOVWDvsgpB12C01LDHbKDTSngG9F8=
X-Gm-Gg: ASbGncvHBfqDRLbm6LzlPKo7mw47EQg/Fu1hysvuBaOQemeOZbA3YE01tRJu/TWxBQ0
	7yb/rj8fX0fPzXWpYlHOHvdWcmy/crwp7tgcF5l3iykwFGcOZHb2CneNrrPl1y3lq7wwvMYunlc
	6AN5nBCoSuXLACjMGts8EmdVhcItfZAxfd9T5X24bZvrzUApua0MBy7/W3q/Z4htT8aNRyJKuCP
	MBu3aCn8Q5I0qKbP6YJT4ERtrS/rw9RkzBE855g5BhwLSKTzCcA1im0M7Lu5O5EavqMtzQQVgGD
	XEKnzOZ17QawDTrbkPHwEFWeCw/qlevRkAQfu3tjQcIF5wmlLf1wowg=
X-Google-Smtp-Source: AGHT+IGrcDtQowxkrSkzeof6W2aS9uYKvk3LTW2BB4YIJuRbMAtEH7ewNad2BvzkhFhHtn4QOTOMdA==
X-Received: by 2002:a05:600c:3554:b0:43c:fffc:787b with SMTP id 5b1f17b1804b1-43cfffc7b0fmr139852135e9.12.1741854039440;
        Thu, 13 Mar 2025 01:20:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:90f7:ca4b:a5e1:8693])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d068esm45070275e9.33.2025.03.13.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:20:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Genes Lists <lists@sapience.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpiolib: don't check the retval of get_direction() when registering a chip
Date: Thu, 13 Mar 2025 09:20:36 +0100
Message-ID: <174185403526.7115.15257225871449545065.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250311175631.83779-1-brgl@bgdev.pl>
References: <20250311175631.83779-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 11 Mar 2025 18:56:31 +0100, Bartosz Golaszewski wrote:
> During chip registration we should neither check the return value of
> gc->get_direction() nor hold the SRCU lock when calling it. The former
> is because pin controllers may have pins set to alternate functions and
> return errors from their get_direction() callbacks. That's alright - we
> should default to the safe INPUT state and not bail-out. The latter is
> not needed because we haven't registered the chip yet so there's nothing
> to protect against dynamic removal. In fact: we currently hit a lockdep
> splat. Revert to calling the gc->get_direction() callback directly and
> *not* checking its value.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: don't check the retval of get_direction() when registering a chip
      commit: 0102fbf52b93e609fec0dab53b1fb4fe69113f5e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

