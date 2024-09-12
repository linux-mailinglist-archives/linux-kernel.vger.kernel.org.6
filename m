Return-Path: <linux-kernel+bounces-326233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3E976546
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C1E282309
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFC19CC07;
	Thu, 12 Sep 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I5Et9bKB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E8188A01
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132309; cv=none; b=T09EzSLgYnaxRA8FX3Qhm+NjnZ+I7PNsZ5UZk+ZvVc+xE8S4NnIMldTrbITrZYgf7qEzn044GF//JsmRBEYvj6J3Odn5QJ60FLaY8RoBFyuoA5K+yip8XhB2ihaGTEX6/YBHdyBOqFlqOTd+rRuVMJXRDNZdnqQU/gDAePF4s5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132309; c=relaxed/simple;
	bh=tr5zd8KezfTEN3Lgsgq9qnwpZazOA4kL3Y5Yyt/VncU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XnnM6iGVoRnKsIlb4r75ar+lchksFysWTMW44nXFrhictzDRaPTKLXt7SyBEJJB1nKT7RbXA8iz0mYOSCXm61w+WihVX9G9cBfDFtJHvq6VYsfOQHabs7RFJkg8ruHNhTnfnv/+z0nO4peN2eYJaDHj9Hg+ur44OGRg8qe6+mHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I5Et9bKB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so6368535e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726132305; x=1726737105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzjqhs8y7WhTKRO+ysq0TRz4Ei1eT10sjX1ohSFJoGM=;
        b=I5Et9bKBhlNGcPna9Lz4jlvQR7WYjhmfpQP0SaTX1iX2cGCUd4LG9oxK3c+BcAbnc5
         HGYrd3Wxr7vqxduMCVeDYo2rsJgWMKanVkpoxpo3JhYowg6PjNVfT+t45a8OqbznAdR0
         A6wDuVm1rdQD95MdpNtozZqc1IiolHs8PBfK/ke9INfRI8poHfFiFK5EGidWpIUYp8Ea
         2jBZeO7oLOysx/XttXzrhQgRDPoegpI1gAjZsjGrN6iqF5vzB1Y7NkizUpDWC4+3yhOT
         lvoNpiiQXa8EPXMvuJn81xMJ7IuQPWfeiUugowEDxQxk/Tjivd2jZNOouCUeg8a7OB/d
         7tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726132305; x=1726737105;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzjqhs8y7WhTKRO+ysq0TRz4Ei1eT10sjX1ohSFJoGM=;
        b=ZgEKfzHYLkNJ1NY8LZt+tmCFYS9oxQ/wbOzizD6LcVV7Wh6lyi0xiEtj7g/qJnUp+P
         sCVbTks3LIMb6p0BLPvWtYWq7jN7LYWWF540i+BzdFdhWXYa3IOOefJRMIQaDZzkM1U2
         l4oleKzmsPogrkpIClCdZ5JaZKOAYgk0Jox2u3tBFeNwzhFM+vfp3l3Aweo/qlibFNlB
         Mmi0aG1WwrP+NxxGBRrVifBdmlemSo9ceTmgj4UWDPhVDljB9ZUOHUvXp20cOjP0b0gT
         9nah2RIvkbPUmCLYQ02scfNIM3K0Gb4ZmAAw4c0YXqSxKwlRh2EVNwnEv/k1RJYvf19T
         pIRw==
X-Forwarded-Encrypted: i=1; AJvYcCV7w5omdydST5X5AwxMvIn4w7kDlbCO5tFLgn59eN+01GdSPZFze52wIpNFxny0D1yz7dGqgtHC8ijaCnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOD3L+nXVxiez2y4NUnjNYzl6Wl1GDioC+bWRXVJWPFueVtaPN
	wYulF46Ha09PSoYFiYmCHoK5N24kiqBmhfLqrtXsCUwrFynWMJR3tc55wkcOyyY=
X-Google-Smtp-Source: AGHT+IEuHhjhV4y8vkeinoRMStEHFH4N9AdU6uuWOfgf54EkhTBqvH37tP/rjH+rnOtOdA+OzPDNHw==
X-Received: by 2002:a05:600c:35c1:b0:42c:bfb1:766e with SMTP id 5b1f17b1804b1-42cdb55006fmr16625665e9.21.1726132304147;
        Thu, 12 Sep 2024 02:11:44 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:fd24:8a54:e95f:a4e9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42caeb81611sm168631065e9.32.2024.09.12.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 02:11:43 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
References: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
Subject: Re: [PATCH v3 0/3] clk: meson: Fix an issue with inaccurate
 hifi_pll frequency
Message-Id: <172613230299.80574.607879947069442060.b4-ty@baylibre.com>
Date: Thu, 12 Sep 2024 11:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Applied to clk-meson (clk-meson-next), thanks!

[1/3] clk: meson: Support PLL with fixed fractional denominators
      https://github.com/BayLibre/clk-meson/commit/1287bdc8c6db
[2/3] clk: meson: c3: pll: fix frac maximum value for hifi_pll
      https://github.com/BayLibre/clk-meson/commit/d4bc8851da59
[3/3] clk: meson: s4: pll: fix frac maximum value for hifi_pll
      https://github.com/BayLibre/clk-meson/commit/0ef513560b53

Best regards,
--
Jerome


