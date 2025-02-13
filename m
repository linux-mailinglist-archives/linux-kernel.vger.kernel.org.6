Return-Path: <linux-kernel+bounces-513615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E279A34C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F50188CC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0D23A9AE;
	Thu, 13 Feb 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gow7KwF1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA942063E1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469242; cv=none; b=ffc1W5XxxCZMFJL//x5EnvpjDD498d15Lf8rFxtMostc5d5q1LN7FbFv6QGMeKkWGYS+M5e6GbxMFUccxOPqIYZ/OFY77v77d3G24phI2zAAR90mWj7cWQZNyfhMhbFV8fz79WMK/MTkm1EvMihpuP/J7xk2v03V+RdpnxWvoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469242; c=relaxed/simple;
	bh=+269OY7EaDipCh3onm8DEanHmFliIp3h0+vp7uAa798=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etizmcgzu/Kmg7E1ejKckYB3zYcwmK6DrLF2GXwIYUWzXVMD0ELCBAHwMfNz2QlU8LrS1YUMz2ujXmBfiBDOid0AGXOSPeBD6xVtBovOCVJOyj0nPqUfvffrRKgtedDXEoFaPeo4RXZF2lWmhrQeyVk5T5VgCrzlWnDC7QP/Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gow7KwF1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4395560cc13so13329905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739469239; x=1740074039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AASLEmG4hHg23vluDlbgkllPBBiNPcd+6WwxQkkx/88=;
        b=Gow7KwF14bVZsUVIKSxUfucaZlTh3/avUJbZxPcZ84lO2c/rvAfKMIwgn2SI3NCDY+
         9fWo7FivfdU2cn4NhMWh3nHQSigqTk8abG7BSqFjW0CnXmxq0Kmn610sifpm5Z5xt9GW
         YpZBc1yUrAFPXYZtCCcAK21xueVj8/kadhj9nhqhBpAb471WCp8CnZkjBuGoL71EvVpG
         oQdnfQJFIekNYqTuj/Oy84APLTHWhWxUyQ6WvJW3VJCzE/AHP9C5g+8ltknTjDfadQL/
         5w7s9aGPNIgfPIKwF+i+VnwO52NZwk8iEkvSuTYUqfP1bWTJjqPXlA3e+JxKlqqsTyHn
         SGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469239; x=1740074039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AASLEmG4hHg23vluDlbgkllPBBiNPcd+6WwxQkkx/88=;
        b=RJVRI6extM4hVfn3fGyTWdmcVVX36RaCKkxPwQuAaTV14vFfU6yweeLLryxWpP8gc9
         sBMX/SLzQ1DSz0W5x0l8AZDJ/4caoeUUAtTP1Gh10/KMNnVBoGoGWrhfcEo6tOZartPJ
         b77C2pyVc9mAq0HjFtITIQ7NmcPLbiBLvF1wzGCseqQkzalcWy5DNliVM1GKqsD4Nt+Y
         J2YeADtPmEDqA3n0O3tmX2Q5dM8OVaOIPY3AUuW8y7bj24DywWtZpBnBW8TLle/EI09k
         Lqj0LmT9sF/XeIgL5lnTr9y9E52le9Mg/7ceHbkJlQ13B1wwbf05ljnSXn5pnW6XP3d2
         QXfw==
X-Forwarded-Encrypted: i=1; AJvYcCV5B5HNKq23qxRSxh30qN1cj2LrwM6g79zjKC9Yq8ddTkz2tArcHAF9ya8eZVdzg2XLaZk6CTLkEHDJqIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHM22pKx+UDgDbBo31+PKNHE21O7t4tAzC8H+sghraoGfyQbYI
	3pZaZvFsmyZwtT5UV8hnYIhVLLtPX2l0i+mFDaDE2yDuHVZyN0p6T7ep3Kycabc=
X-Gm-Gg: ASbGncuCUvjr4shZSLbOkqLHGPP9/FWW7CV26VgHOyjXnEM7JLbWv8mJFbPtltMijM7
	hWYOPZfdQcwcdPkZTyVhqM8ex5SJMbfnQWyOCFmi3KybkK62AzuzxsSgTnjZWvhkQ/IF/u3Z3du
	Xvsc8YzFkVPqghSdMwYtHZ2PpAlQrpdKp+gw7bLhV8rnnAn3dkPN5uv16myog2hM7N/B1x8L63r
	s5fhTD3fce1R+aOcuHAQHEH1uCeidPMq2kD2zHpKMBFeEqAIHf14QE1ojPQQsDUESOXuRegRX4s
	E6Q75HPCtLR1oxA=
X-Google-Smtp-Source: AGHT+IG42/S+tsvaljYDR6/SRyicTAxV4SHDiyz2AP6YClUGY82Q4xoEFmMDivThTYJ91m0TxC66AA==
X-Received: by 2002:a05:600c:1d9b:b0:439:60ef:ce88 with SMTP id 5b1f17b1804b1-43960efd0aemr43983675e9.23.1739469239541;
        Thu, 13 Feb 2025 09:53:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:affc:1fb5:fa08:10e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm55390325e9.3.2025.02.13.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:53:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set
Date: Thu, 13 Feb 2025 18:53:57 +0100
Message-ID: <173946923528.103541.37570270811887464.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250207140640.57664-1-brgl@bgdev.pl>
References: <20250207140640.57664-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 07 Feb 2025 15:06:40 +0100, Bartosz Golaszewski wrote:
> During the locking rework in GPIOLIB, we omitted one important use-case,
> namely: setting and getting values for GPIO descriptor arrays with
> array_info present.
> 
> This patch does two things: first it makes struct gpio_array store the
> address of the underlying GPIO device and not chip. Next: it protects
> the chip with SRCU from removal in gpiod_get_array_value_complex() and
> gpiod_set_array_value_complex().
> 
> [...]

Applied, thanks!

[1/1] gpiolib: protect gpio_chip with SRCU in array_info paths in multi get/set
      commit: e47a75fb5b139233bdbb889995edda4dffc3f0f7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

