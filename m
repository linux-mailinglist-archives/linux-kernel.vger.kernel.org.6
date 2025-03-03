Return-Path: <linux-kernel+bounces-541166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728DA4B96F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E827A72A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219941EF08A;
	Mon,  3 Mar 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0hpmpH8J"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83B1B0406
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990892; cv=none; b=Nl4fA7ZkCkcMMiB9Ih5Gv/ksgKlxJkaoSXz5NUqUAd6hGvbJr3uqSJZrWocB6QVdBb5fr3ruaUB2P/vt77WrQbXI4J+HSrNXrgiyqDpg0s1yuw0X5R2yszHxGwTih1g7mwQSF5wPr56y0gxF5e9B0ZCAPGODpUM+U7Thc7d4FMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990892; c=relaxed/simple;
	bh=Xu+R9dxCaKB3LBzWEXohsvaFOO89yN7GursH9EJ00LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OruOcOno+uTQQywe3urIrc02W1O3sylN+H9urxuQhjXA/0/YvIaVcfAPfAF3gyz3YQJyLYu8ItFTFIpsucYB2LZey1y27JuFpgcQ4Ab7djsbAZ7BX53ie5iDG/wpSn2GInw9uTLUtfqx6SbrBwGlU6clRkvAN4WO+g6RR0UOX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0hpmpH8J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so25596155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740990889; x=1741595689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3zs+zZ8/UkKqB1ndx1maETbL/N7O50KZ86fibMQj0o=;
        b=0hpmpH8Jl6q1Cwqc2s+8ozRRG6bYlThc74/SkoPBjPvOpVh25bohEnt5A1cH1cCKbj
         wUiDipKl6mot3XxNLp3I+X3ZuRgvRj4hQ+qN0O81FiYsBD/uZrQH1jKTEmYyYj+00lde
         MfP9HU2ZsEQ+WDi+BanrBIT7QDLD2qtzhr+jiMTr/9a/c+yfu/vbwvYubFRgyr+um22l
         s8hJPB/GVTL3B+WPr1mguzcK4oqZbbLNB3dwM//7VCVQjK+An8w1SKoHWSCNkibAmghH
         2exFikaqqmDCxBPFm2Vt97yeMG1h7vSXbuz8447HJBPCavqbxllyku+dzP7pptnZxWOE
         xA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990889; x=1741595689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3zs+zZ8/UkKqB1ndx1maETbL/N7O50KZ86fibMQj0o=;
        b=AzpYZf2/WgYIU26nOw0I1kE9D0+8f2QDyGQWHIRn5u0jso5KL6lKJ1KcpW8VjFv0QX
         fGxyQv8HHpiUXqP7BEGeqTPmv+8jiUPBgdUyVhbWB0n7K+3X87r3ksRgbrRToyLUtxqK
         dM/VsRtSegEyQYYPywombuOTt3aC0oteGWpb+wFDKr/oEh5fT9s9xhCtN/B68+QPIPBn
         IUy/b6ErpM+6rYk8NCUshzGgOpMiF1sEccjYKbn37jQd0xz4PCN6bd7p2VXy3OjQeuo+
         4DLbtl/Wewl60Kz4K9XIozIxlO8/TO+zlGInEF7qgroaFc1CEy2H0oyuspHWlZReUmjH
         uzFw==
X-Forwarded-Encrypted: i=1; AJvYcCVMtfIvrRyvUN666mFxPLI/rJ8awWR0Mal7eJb0QGFP2vJWwQsx6N7Ify5KAkia31IzV1d/KjcotvdIE9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeeg0NQf5lBZTz97U/6e749B6Un7fAqGbH2a08eWxZlsl0+T4P
	KXM3kpMjoWMrtnSHJgQJ6HLdpXj6CTAzeOvIC6W6ZjvH8LiU2LZ7+y1B12FLGTk=
X-Gm-Gg: ASbGncvtP4vak2xduKGLpKkKoi2MsaLqOJgs4YZnV4Q51nYlVmyBlVprMx7BJ22bNMP
	bhRHvpNW3NqEmfDIBaB1MEN6+XIN+xhvAE/Q+TNLcPgbxMdvx82PVSG1MA9nInoCPS/VLvAfxRK
	93aF68ZxJF06or4PjeaNgu8tVhLVvBPLUT0+BQNMYPNbRnJRgcig3bvs1OZqMuuKXg3421pFFmE
	jEBJe4jjl1AATdnDILmPY2gDrvCGPWndepo4QeVCAuOgainDEnyXYH72u4S4KQNl3XJavw0C4o3
	Eid0C+ynVEUryVlYk5kTPMmu9ad9Efx9iYhpU06tM0nB
X-Google-Smtp-Source: AGHT+IEwuZAAiW0H5EeuN1Sr0107Xsyhqgh45iWAu7E/k1rlJKnPNTa6lf6tq6fInDdNw0jPCZD5fg==
X-Received: by 2002:a05:600c:190a:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43ba675830emr79746845e9.24.1740990888929;
        Mon, 03 Mar 2025 00:34:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532ba6sm180406115e9.12.2025.03.03.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:34:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: remove unneeded WARN_ON() from gpiochip_set_multiple()
Date: Mon,  3 Mar 2025 09:34:45 +0100
Message-ID: <174099088185.13023.12920341426631248647.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227152831.59784-1-brgl@bgdev.pl>
References: <20250227152831.59784-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 27 Feb 2025 16:28:31 +0100, Bartosz Golaszewski wrote:
> GPIO drivers are not required to support set_multiple() - the core will
> fallback to calling set() for each line if it's missing. Remove the
> offending check from gpiochip_set_multiple().
> 
> 

Applied, thanks!

[1/1] gpiolib: remove unneeded WARN_ON() from gpiochip_set_multiple()
      commit: 8014097f1466f7e034844770c537b8dc7d98811f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

