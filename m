Return-Path: <linux-kernel+bounces-245721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70692B7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF0B1C23392
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF031586C9;
	Tue,  9 Jul 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xb1PCr3Q"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56915749B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524356; cv=none; b=ZaSqOewnFUg4qgJyrZ5ZMCR4rX9Heg+Ve/nWpxLd+R/4tD3cyHk/iXh2tltTaRvYIQXp8qNAmq1QYJzc+Y26YoHbnfcEVDItBFbDGQvOdT4i9ptIXoB8KpjT1JI6tlQtpE7OIoL8S2ps3DI/JSNzkjwgw4PeziaEv6q+9HOUZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524356; c=relaxed/simple;
	bh=vvcwRkM3OuNTwdiB+rwHmWDHQxrEcGpnnFXILUWOzkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAu0Lhc6Fc23dPeA0R7Sfy2Mc0Yp8d0rgLquxovgmDEW5LXAXY1CQIirDHah1tLuUDCzZQSmIxhB2a311/J7snPKRVdlUEkacliYHWkVS8z3xTcLLoqBerjMiv+5z3UtUpjabelIioM7n0lnemHvw1M2Fn51taqWorLTRzY5bfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xb1PCr3Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-426526d30aaso27708085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720524354; x=1721129154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfvGjeFG4a32Sifih9R0O4zMufu9Pz8z2RfvikPSPHY=;
        b=xb1PCr3Q5SlATkx0icGFBSkllrJrS5sb53tLnukqOpmzRE6pw0+27j3kEK0ujlSndZ
         KyFjjN8Jwm173NOiSoV+1mlxeCz+1w9bhsEDQDoX7Bb9kZRCg7ocKOMtPACWXUs1JeiR
         TCsMA45huAQhNYcts9TWuyelr+SHnAvFFZipLg/lAmXjWxlcPavrKlJS9+UTGyQrn9r3
         hzXvpOmeh753KXvWUsKKYGp4f0AQbD5gymP8fqj5rhcS+s+XhFHxNwxo3NWn76umRLx1
         Yc6+jN7w5HauGYqSkx+ZBzS/svY+YkumzbQeNlOe1BnzJPfzaqbSlRC3SBqkFHzC0XeR
         F5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720524354; x=1721129154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfvGjeFG4a32Sifih9R0O4zMufu9Pz8z2RfvikPSPHY=;
        b=JOve1QgTjLXPvr1yTQtMMWMD+kVBHH16Y/Szz2HeegIJ4ZhSBh4ChZO7cr6AcTk+p9
         jGVTkKkpKDdb10OSeVnIznMQ4SMuiT+3yt1CJO6yynNwMg72hDFy4IOQBoiKqU4hCH8/
         3Wo0bw+DHr6SpTzJRxlUsJMvtgNDtDoRhOc1grbzsYYv1EGNYIuWa+pVe3oswCL8Hxe/
         Alycr/4tTTDpA9hn0sQH1jzwL0RNufoFUopjyu7eCayZP2k/mLpAKur9bDq2V35mXk/L
         RmJaYFcmcCXEUVrYW94xwtDaE0Wy2aZo6+BLCXQn348/NNPUSMb8OLqfMXDVLrz096gV
         pzXw==
X-Forwarded-Encrypted: i=1; AJvYcCXoMRm91LKU27Dj2vQmDLjL+vgXyuwTkZs8NJsQLYlGY6fpF+P/Kp7wDuLjxsBCfIuGzC2ymPob9MH4punFwalma5yVHJXSdhNMVQ1i
X-Gm-Message-State: AOJu0Yzz3+d7FF/ymHiSLdZA6AF3nqvxF/u6zrugQ0Q0Mx5aTNQk7FfW
	Y43dn+FFNHUevKl8pUpRxDTCl0lioBUENVstIlmfdiyKPlymv4TyTzRn2Gdh8Z09eSSg8+EB+Sy
	M
X-Google-Smtp-Source: AGHT+IEwiUV54wszrwv/TVpmnu4opeBXJ7Hz9ZlHIOaHbIMMziKYWgHtgwNOIGC1RqDnTBuWbmkq/Q==
X-Received: by 2002:a5d:54d2:0:b0:367:40b9:e9e6 with SMTP id ffacd0b85a97d-367cea67e6dmr1515785f8f.21.1720524353582;
        Tue, 09 Jul 2024 04:25:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c270:70c:8581:7be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e039sm2307724f8f.2.2024.07.09.04.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:25:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	arnd@arndb.de,
	durai.manickamkr@microchip.com,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: gpio: convert Atmel GPIO to json-schema
Date: Tue,  9 Jul 2024 13:25:51 +0200
Message-ID: <172052434347.27822.16864713604407945517.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709092354.191643-5-manikandan.m@microchip.com>
References: <20240709092354.191643-1-manikandan.m@microchip.com> <20240709092354.191643-5-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 09 Jul 2024 14:53:53 +0530, Manikandan Muralidharan wrote:
> Convert the Atmel GPIO controller binding document to DT schema format
> using json-schema.
> The at91 pinctrl driver uses "atmel,at91rm9200-gpio" compatible string
> to find the number of active GPIO banks and identify the pinmux nodes.
> "atmel,at91sam9x5-gpio" and "microchip,sam9x60-gpio" have additional
> registers to handle drive-strength, slew-rate,  pull-down to drive the
> pinmux configs.
> The new compatible string "microchip,sam9x7-gpio" is added.
> 
> [...]

Applied, thanks!

[4/5] dt-bindings: gpio: convert Atmel GPIO to json-schema
      commit: 337049890b8cbbb4fb527c58976ea19f4dc747a0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

