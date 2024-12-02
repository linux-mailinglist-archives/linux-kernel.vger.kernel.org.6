Return-Path: <linux-kernel+bounces-427918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCF19E0775
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BCA280A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B134779D;
	Mon,  2 Dec 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ToMIJWYd"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA13D96D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154441; cv=none; b=f/2/CrDdDQlQWBg+KdnHNFBbKsSdPjIpaSuJ8pn1htDDsc9jm6mcm5RfpnLY6RtXukuiQc5rCo71VNoUYfN5KAw4y+F2aE9ZPkHtPp1kPR/Un1iJoY4IUtENRz3u9gd3GIQW2uXaZc5DBvSnoiG0MizH7prL4jYkbCGZNwmb5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154441; c=relaxed/simple;
	bh=8u8fF5ha9BCebV7dj4HE28mCFH9G7mXA1hYQMfM+p5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DzSF16Sh2JsZIIgrFyoMjuPp6Su3HbVX4KTFrF9EI8eP2TObA599es7Q/+F2YFbd+9ugaEggmEjw9Rrz0k5ZNAOtcG6Hioqq8Z6WQcVEKBi6hJi4bRiO639H27LnvSkLC9CzWtDlqLEHeIrLTdO20SMWPWWiquPmh92wMo+EPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ToMIJWYd; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea33a922afso2111490b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733154439; x=1733759239; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNctqgbgKX4M7vIwY0GeY040xXoP0R2au1vBq2qCPD0=;
        b=ToMIJWYdjn1xjRNOSE7806aXxCZX3OETaQJaAjQRFuaoSkOeO1dUmVOlW/2aEzZI70
         r2WHSEfa4rS4xxfVkw+es8Im6eaDw884Ck4Sgna9YI4YCIP+aNKJjawdYMEEjkTC/+8m
         auvhAd/zsa7X9NbSuoKyWeQztCuHgMR+vwDqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154439; x=1733759239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNctqgbgKX4M7vIwY0GeY040xXoP0R2au1vBq2qCPD0=;
        b=KbwI672AzGtMmnXWLFBT6M1rqsguiM4t5qOkig7NCFinaW5Zn+A4i42RHP5dwEDarC
         Qo48pytyeMoWGHjsw40uzmA9z78kSxSah1x1TWAg2NwzA04s1vyaXy/eMtZ+oY9bs5da
         ELxAWXGzXuRYOJu82CX2tKrisxausmISE38ly3NRodeqccJJWfpoefLIi7Ca8ArywZqd
         i54PCNTyNuRkm4HNDk1no6/TOBffPdAj2SAGD58EyUgaeYc35p7TOtHWZQKwT16bAb2q
         /wH0vbm2DZRf8m+TKr8zs76TSEM5vI8X9Utr1ykcIg0AvIn3sZIwWoMriZQWoS0aIzYl
         lpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJnZ0WIWKZn/exZHdAbEyr1sdahhEkJm3VykHloEKmxto4Ggmfk3rZeXqG6AAM9eUk8l+agQG26C3Qm3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9oekVqP0pk7pPC0WbL8tUJrQc/OaeL+O3trUVgboWUjqZk37
	O9f4WR2GpmOd4+mS7GGZ9KCDbjV2UHvGM60meJ6bPWETVPj1arrpJ388dremDg==
X-Gm-Gg: ASbGncueOIA1KhycOONPO+QV7mLjs+LeiGsR+xcltXspHpleHDxzJ3iU3NUiCEuqJy/
	72Xme5a1p3inW2y3pySNgNjxjReG5u7Kxu3ScS66yTRdAFi+U7c70wGxENMNtSUE15LBV8+uOzZ
	VrMsntI3SCMLB0/TWu4BKDp6CpM1PG4jYeTU6m2LemcTJsnSv9VJ0a3m5No6ok+Xn+FAPt+b/fI
	6pm+tpH4h5peiBY3Ktp9Ake3PzBSYTLXq07KFxKVwKRCsFnuKdYs6F1dWGX0+ml+0vuOt7o7cPL
	Zw2TtRjk7zHx4McQu7zQOarn
X-Google-Smtp-Source: AGHT+IH/7hpTfNse9nN9Jr+DgfzObAaRxU/S7oa2RXexy0e4f94BDSUNP4uGp0FObZdTBwMHoHxTgQ==
X-Received: by 2002:a05:6808:1589:b0:3e6:2471:4d10 with SMTP id 5614622812f47-3ea6dbd43f1mr21613568b6e.11.1733154438947;
        Mon, 02 Dec 2024 07:47:18 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0f8ad6sm1159729e0c.49.2024.12.02.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:47:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: Fix warnings with llvm9
Date: Mon, 02 Dec 2024 15:47:14 +0000
Message-Id: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPWTWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKGbllmhm5NTlmupa5JskWJuYJpsmWqcqgRUX1CUCpQEmxUdW1sLAOK
 puwFbAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-staging@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

When we tried to build media with llvm we got some new warnings, lets
try to fix them before llvm is part of our CI.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: cx231xx: Convert enum into a define
      media: atomisp: Use the actual value of the enum instead of the enum
      media: mediatek: vcodec: Workaround a compiler warning

 .../mediatek/vcodec/encoder/venc/venc_h264_if.c        |  6 ++++--
 drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h            | 18 +++++++-----------
 .../media/atomisp/pci/hive_isp_css_common/irq_global.h |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-fix-llvm9-4c8d705c9e3e

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


