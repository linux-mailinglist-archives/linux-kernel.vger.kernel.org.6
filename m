Return-Path: <linux-kernel+bounces-200236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608778FAD54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6EE2843AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BBF1422A7;
	Tue,  4 Jun 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XKGUi6tk"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67E139CFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489071; cv=none; b=mPze4OkMg+bKTBkht6shqQNfnKaTmeOKAC1mXZgngTBNudPJVljkss6KaHI5nAejcX1U6hVvlCkZm7cOboBKTu/alSO65ZQ41KUDK1/bV/dE5jurRxgtiODdF1bxEKKIkrF3q/FCEcbWlZA58dLWvoy8QGFzBae9gp6PUFutiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489071; c=relaxed/simple;
	bh=KJf2pXnlxe7k1MX+zyUO4LGepipFYbNI23zLJRKf5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlOxirOOtf4Zdo4fD6PqLtwaH2wAiO/CKjgAoyt+NB5dxYfwzExalO9/7v1i05rYxwJzivY8Bd8rDKHzygXxxMgjWBaSL0zLxXSf0TUCwh0NgSDe2YHflhcBSZ5Me3/DkiLiGcXmpRnLE1gk2EbfYZEdM/2phRqHSR/ifDgqfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XKGUi6tk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4322760f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717489068; x=1718093868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMx0DAEnud4ZAXbAP7JbZUsSrVWKe0ofICbawK0LpNk=;
        b=XKGUi6tkcNoT2I8TlMl0LXXMB2kDiCHzpCvgCkbtZ2xGGJNzeg1DAgSSufIXlBPVgy
         24nO77Ln0McZaAg5ssZUu8ab9H4aonnM0Qo/I1dxb22p270IJn/D6VEBuJ5KUIYvWYtW
         vPuKKZ/UYBCS8R5iRBvgrtcyW/jLSUijJ4z+7dL61G40jV1TXm8eGx184NjyMKxSU5h8
         oYWVLstkxnuoVhyABKG/nF0uPs3bFNq3MyqNriJZcFqfoYzk+me6Qc7LKFKe0x0HtVTt
         j9KNCVS9pGMBaUBzbrLvO67JLXN66K48amk6pqwaQitn37YAOe8kQzcZsCwKp9OdCbac
         vkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489068; x=1718093868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMx0DAEnud4ZAXbAP7JbZUsSrVWKe0ofICbawK0LpNk=;
        b=MvaKE+TBQ/RlmyoYT840lH+KSOYPYtgisHIaEPcQbI8Z/9DEzhPgu76rBB9f5bGEeQ
         fWsSH70VWF3b82iiUWuYMnMBjBLj2sJ2NlTgX7KkXeAhyeRbIojQ9FUyFXWal0CMpZb4
         7c7PIT9XLGZwByAkVtywc2ILSb81lGsioC9X3pwkUePcXzl70RS2fpn5SRlcrXDATElq
         oomVt+3qfDUEJCQ69QqHcmmxniMm41m8nLCgiHDFxJA0GmFXy3+rn+GZW0601ehP96Mz
         rYOd6qcE/dQ5tieEogYMC10Jsc4fKDyvJNp6kbe8Zboar+nF2todRDqrn3SunpH0oshN
         s1dg==
X-Forwarded-Encrypted: i=1; AJvYcCVxcWgVTeoHfqLa0op6zX7vo82BCrtw96WwfbiRJvOOnVNni7rOggYauaiDSGGKRwc6FSO6/Q5b0bv1Sux2eqp8xkCT5FxYhiSJ/sHE
X-Gm-Message-State: AOJu0Yw0xx7DJOX/8nIzwdbSNQ7OJBOYDjjRWeXbCa/sN1DpUFns2Qor
	4682ccrj4rogHYoxdHhUgUHUMBcNbO5IqTmXNHNVXeI3EIW8wK3nq30gYLqS1CU=
X-Google-Smtp-Source: AGHT+IG8KwelaEdu91MhiQlPTN5blf3+ic8FvdeZmDwoqZIwWA1MJk4rUYqO2f/1N9MKlqTjia0eug==
X-Received: by 2002:a5d:5485:0:b0:354:f142:65b0 with SMTP id ffacd0b85a97d-35e0f28858fmr8744196f8f.37.1717489067621;
        Tue, 04 Jun 2024 01:17:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:1604:5579:bac6:654])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca434sm10771262f8f.30.2024.06.04.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:17:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/2] gpiolib: Show IRQ line in debugfs
Date: Tue,  4 Jun 2024 10:17:46 +0200
Message-ID: <171748906381.10591.18127648133265044353.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530191418.1138003-1-andriy.shevchenko@linux.intel.com>
References: <20240530191418.1138003-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 30 May 2024 22:12:28 +0300, Andy Shevchenko wrote:
> Couple of patches to show IRQ only (when it's not requested as GPIO)
> lines in the debugfs.
> 
> In v2:
> - joined two separate patches
> - rebased on top of latest GPIO for-next (Bart)
> 
> [...]

Applied, thanks!

[1/2] gpiolib: Return label, if set, for IRQ only line
      commit: 5a646e03e956f45e74c0a606f51e1ebc13880309
[2/2] gpiolib: Show more info for interrupt only lines in debugfs
      commit: 54a687cd49e3625819f24e17655346c85f498cbc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

