Return-Path: <linux-kernel+bounces-171912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD288BEA78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FA11C23A87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554816C695;
	Tue,  7 May 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3F1Rb3Hb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D410E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102701; cv=none; b=sgB7G6inYUljaHiG1Z6lHvU5HCdp0Jj3XixFccEoFXvGk5sDmozYh+GffEkhG/UDbkFbcij1LnG1TjADLseuDZay6TgmMKY55F/DLvsbTnH4QCl/FMHA4XTrWSSg61OTNN80IYJO3IFTjIpUnGgu2vItp7VGStmYbn7lkjYYVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102701; c=relaxed/simple;
	bh=nHl3sg/Teg3ZtsUdlMvxFbfol/YlyyyrCIxopw1u4EA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqIrerlZdS1MbPfxaaCr+w9fBz82HyoT7DvFJ5IcAYAQFyKW8j6LN8gG6MOoXJcxNLn+DK08SZkNWbjTpujCe9yhyndjkavpX/n2PLVGX5ujPWbcGGOWP7GC02e/Ls+IhGDSqZgPXgIvl2B4vF8jUm1x44ePut3CDxT9wp+7IX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3F1Rb3Hb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so25790405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715102698; x=1715707498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg+4dOZUqNgUNfxdt5kp/P7l2bnU7NU4fGaWlMJwJ0Q=;
        b=3F1Rb3Hb7R00kC5L49CAiK+8FX0RAtpLn5Lg4J//1gEu9rvERJbb1iJBWdN3PyAAsr
         9BvuYeGDGK8gYFkQFbsgUNv8CDtlLSczlK3ZdizF6cSPEZB2ImSLWdabek5rZj2LfWmX
         mqksPw66Xm27pG+Vxn1Hnn5gbr7JJ+RzKJ26ksCaJY+sBItLWQhj3H13L4uc/YCz2HcH
         4D9nwcobcgNmNbsSK6cGHbT9PgtDyZE3pOwWLeRC1WUc1cq5Ny1hwF3+u9pOQPSCT0Sj
         Ke9GZyjIlV+d2p/Vdk4puLStJijPsCAghm618VPh4pG/r+vou0FBV7A6/hAzTrXBcY1G
         stuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102698; x=1715707498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg+4dOZUqNgUNfxdt5kp/P7l2bnU7NU4fGaWlMJwJ0Q=;
        b=UlF5EbnbZbHVDTGLlAHOVRfXngZOW0/uN8+pPYPyq0DcTETzA6h/A+1REVujCqOa2b
         d+hCNyYicOeBLJYq11K/00Lj96eMlPsdmvVVF5hXNApaYWWUc/EO3GzI/pghtUKTewoV
         I96CT3xMYKEOvmwSpiPs6feLH5v7gYaXXR8PcoQh1ELR77O53HypYW9aiwnN7j0TToQg
         o04Q5IxyyQRKKh425bchdgPtOosfie0GIjzlfROwodXwcLRDEJY1KIo4H2DIvpPW6qf0
         u8fbeBN5Yg6csDEEupYMD2F51LdiN3/DcNsAnj7E3KpopYqU3/mIkYDzacYJ2mODx8qF
         Vqqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUDmq4LOnSm+Vk3lm5kV9pbJ/xbzbzcoFjLndnhGsb/Ts9VNI+yRiELsR3IByBt7wjnnnGWzDpe0YYd7eYgUX9zfFQG/UVneV8yBQ2
X-Gm-Message-State: AOJu0Yx6i/vZAoPAFf7U2eGR404qUNo86SSHKhOPTfl0iKkhc+Zo93c4
	7yeJAQ0N9a/ayOX+20/KUOOgVkv0VJMZsvnDQCOIjgtmW2E4f8BeViGkTkJknEo=
X-Google-Smtp-Source: AGHT+IEev0fhch2yuQBzU+D2SmyRwS1FM5JlAeDunUKAQJGcUsmzINU9MYbqWGH+yzuOEJQUhr8+7w==
X-Received: by 2002:a05:600c:4f82:b0:41b:a4ce:aa45 with SMTP id 5b1f17b1804b1-41f714f721fmr3497285e9.23.1715102698375;
        Tue, 07 May 2024 10:24:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:581a:1d:3b79:3b03])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041c02589a7csm24031458wmq.40.2024.05.07.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:24:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] gpiolib: fix the speed of descriptor label setting with SRCU
Date: Tue,  7 May 2024 19:24:57 +0200
Message-Id: <171510269099.28563.17775004857177000516.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507121346.16969-1-brgl@bgdev.pl>
References: <20240507121346.16969-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 07 May 2024 14:13:46 +0200, Bartosz Golaszewski wrote:
> Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
> caused a massive drop in performance of requesting GPIO lines due to the
> call to synchronize_srcu() on each label change. Rework the code to not
> wait until all read-only users are done with reading the label but
> instead atomically replace the label pointer and schedule its release
> after all read-only critical sections are done.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: fix the speed of descriptor label setting with SRCU
      commit: a86d27693066a34a29be86f394bbad847b2d1749

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

