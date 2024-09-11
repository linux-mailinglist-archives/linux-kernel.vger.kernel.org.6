Return-Path: <linux-kernel+bounces-324385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51820974BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B661C25909
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9113F454;
	Wed, 11 Sep 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM2vHSs5"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6313D601
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041274; cv=none; b=ttdoThRgVT0Bz6LlJjthabDIbqbEvu/L9SitYw0iHdYe/OFlYV15ivPPHmGky86eeqnPFX5xJRSm3NtkPmlBNCmC51luM4JNsfQyBYZ/QIJpD87XL4AK7GeSfTItWPCe0Ltxjm8Vrtjig5oL6Z1a6UqnZzY/p1ceFCXNuYuugio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041274; c=relaxed/simple;
	bh=JwDXvBMIcJ0cEyE7/K39FaGGwLoRz1fdPA4mgPlF084=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jHHHNMob+B0ZP1TUSuAQwd7NjNraorDKYKGLVq0QGXEfw7adijFL82OIZML9Rc1fp2Ojp3mfhtE7mOlg+fXKqEREQlylbPkuZB33GzKmMeHuza09CCAnWs+SrqP/7dmFk+y8dRkOqExCjGGPmXKieTaHjnC/R/o0oNXiBiJ+uAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KM2vHSs5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c3eef39eso3666649f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041269; x=1726646069; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXMVw2a2qtH/DhsDJ1EGdSmuLP+t4A6t5u+JU2Kmg=;
        b=KM2vHSs5NnYfAfyUZObCOJHWGSGHp0Q/gROJYRPCOM3vmPLByJTB3NyFdcYAZ617W8
         ldwjk51YilO/UsUExce7m/Xn9N6O2kx/01pD+BzjYvmsTkKqVuHMmBFOxAXKQkQq7pol
         e203P4i2FakxW9qcV5NTbmXFdvT5DFPuTuo7uVBPJPYGbsERaNdCCa8wpd4psamzCq3n
         7G+3oFdYpnKIhDCRzmwH/cprjoOgFV64BK/0IcUhZDB51Ff1Q4vgJR4vsfxnkoiM9TUW
         NZZ1z9gBuuf5kcC6yWYFR3NqkYUGEjjoOzzdGSEm2NDN38q1SPWXyCTxvTISwZeBEvOe
         KQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041269; x=1726646069;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFDXMVw2a2qtH/DhsDJ1EGdSmuLP+t4A6t5u+JU2Kmg=;
        b=g0pkG3AsOIQcFewLWOoK7+sLQoDuKYwoXRBwLHCNAHXWx/5VfeuCUy5UTdOXJYNi4J
         7tBcCp5zyJnMLmzAYUEWZf2MoBRtt+CFhhjLCR0VS+0pB1l5ysBrJi8EgMTLrDufC6oj
         H6w+KbAaFZRpvwoK4JAys8lEddn2iS5SydXVhavl5j/wT28Ncr5QYR64KonUugl2MHdT
         DRfVAntiO7uZ6WDdE4qbYFRbUWawL+qgM29T4U2DbHwgsUqiwJIgVBlJ80rlPGZDxz4W
         bOaJ3oN4Ukg7i5RZ6hF8esugx/bEWuE5TLBW6Rgkx0YUkYE80ca3r7g1iCpoWBi16V1g
         lplw==
X-Forwarded-Encrypted: i=1; AJvYcCXsv1fmjdKTc3uM79qnQTmdXiYeVx0ofyQDk/oHxR5nBpZQi3c9K5D5bXfs6MnHsJNhCQKHc/9FJb5o3Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hO7P6Bwmtb+LDs/FYznA3BW1SkDMUnzqJV2vo/63iKAN1lSO
	sDH8nVCbpuM40Bv7H4mMgQ7MFekJSPpNz4vsfBKITVeCxazzumZSeXtcHtfAdaU=
X-Google-Smtp-Source: AGHT+IHMGxiJwIOhxACyDX9LH5o77Ml1wigv6PlpISWVmZUFFncR/IDRy7m4dUOHOG2tDvF4nXUVdg==
X-Received: by 2002:adf:fe82:0:b0:367:8f81:fa09 with SMTP id ffacd0b85a97d-37889674bdemr9244557f8f.47.1726041268975;
        Wed, 11 Sep 2024 00:54:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3743sm10900659f8f.79.2024.09.11.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:54:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:54:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These were a couple bugs I found using static analysis.  I have not tested
this code.

Dan Carpenter (2):
  iio: bmi323: fix copy and paste bugs in suspend resume
  iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

 drivers/iio/imu/bmi323/bmi323_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.45.2


