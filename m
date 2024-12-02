Return-Path: <linux-kernel+bounces-427919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E099E9E0778
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5709280DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5F745F2;
	Mon,  2 Dec 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YqqnGscm"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143670837
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154446; cv=none; b=WY5F7n05nc8B7g4Qw3i3PO1/lFRfjIY15iRdk4LONuqkAIfufQU2I73/bLVA3bRD+jkrVp1LfBIGl/u9rIT5HxjjYV/cDnuyRGH5KwYwsG+4Ph1CzTotFiU7wNam27HmjCxkoVTtfQy2OuPFhUKUdAIgpPPFj5faPH3cTCowQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154446; c=relaxed/simple;
	bh=rjvM8q19fcbBsiIYtenn0hKh0vxaDX+5kJuh6tcl068=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siJ88f/XQpePwp21GaecryP6TeUrFZKnSIoB3sVjgvm0K58S3qpiL8Qm5AEfZKFfbx0vE3ppRkBzJy9B5E01LjiMT91KYeYO/lNptjJhLnTEKqLhK6ttUbUHN+mjGaze/sTi2gvNZRCc4gmN7psUEhF/X3lS4CR5dvuanpYw3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YqqnGscm; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5152a869d10so1078756e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733154443; x=1733759243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pxSoz1ajcI3n8y8uPzRsEcpmfNX2HaWKguXvR+KRDQ=;
        b=YqqnGscmJ2HFm+aU/E53L8QmkLzpSc5bLPhTe0GeXcHOfQwkFy4QjhbwzNlwXr2BRt
         6gBnvHToqw7pXxW1/KnR8Su/9TjeFRDj3xbqtNLm8qwBuqt6vduXJMMUmjd1dsQFRN0j
         3uF3WGeWGZRksIeAraBkdqr09H6YMW/Y5ho5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154443; x=1733759243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pxSoz1ajcI3n8y8uPzRsEcpmfNX2HaWKguXvR+KRDQ=;
        b=f7rPeGy4eD0uxRVyqjplCUU6f7SG58VYXQeRgpThGw9qzaND+N6aD3HedBcanZoGRY
         uXq+32r81dIsP5SUmNJA0knEAA9MG3mppDEWiqD1kGy2Kt6QWOxm8MtCYjSYs00o7ZcG
         Q2S3Bc6IsjKYpX3GLqv/paDzW1/fw2YqgRTc7XGVf1JC+EUxh+1J+1222g1ycm7fWdmw
         jaVsaXGuOKR4O3NasXyXwIxaiTgMcoou210UDEAnKeBt9IAHcatgnrNS8/3/KKqSDti0
         cioeaTRgOSkV6Ri9H3vJu3DXW8vdnvRjmrGSDIv2PaP5psuCkCsOw0DuD65UlE8bUIMZ
         e0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFNerZg2OT3w+vO+nXDCAkXdbUzRH+qn4t12iUnCpxnFnKdNxwM9EHdk+29xb9nnkHSieJdWR2rI1vug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrkPM8N1ZRIWKtafXEFMGaNWjyHvoew9mjg2PpO6OXtXPSVeR
	qZDHNJhQtqaaCy7U3GjHa0UkuqAngFPT+oj9dPAlJPm+AxlwlUeFqRbgC+QuzQ==
X-Gm-Gg: ASbGncvadO42h9ZwI7xJE00E9ZEIleIFFxwqbGFVFURXc/NB0NhoVJXYtn/OQtA/BJP
	HFUDIINMGm7zEbmBqGbasVQVmb0mibB+LXsFY4YEGnI4wOjQdnaDeylaEsaiRpD+CoUwDGCD5iJ
	EN5N6+aa9v+Dc3VeG1i2HbdVdcQq0tokET8hyQouNgDkmL7yBbmqAf1kWS/uFdiRqKRgjtsiFXC
	4/RG8U5yKrNFvK4rCVYUd2z8z88L3xSy9FAIKT1YxZct8QVsqWiCbIw3aFB2NamOj7ABCnwvCwP
	hgZS+jYdB3veYGYHi+2xKbXy
X-Google-Smtp-Source: AGHT+IGaWcZbV6qtojnjaBkX2eRGECUPG2dd+i3FQicKN4gnW5JGkqWcKAek6j+Ilms9M2b0vFq/qA==
X-Received: by 2002:a05:6122:3c4f:b0:515:3bfb:c7b7 with SMTP id 71dfb90a1353d-515568dab17mr30842699e0c.3.1733154443629;
        Mon, 02 Dec 2024 07:47:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0f8ad6sm1159729e0c.49.2024.12.02.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:47:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 15:47:16 +0000
Subject: [PATCH 2/3] media: atomisp: Use the actual value of the enum
 instead of the enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fix-llvm9-v1-2-2a50f5acfd0b@chromium.org>
References: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
In-Reply-To: <20241202-fix-llvm9-v1-0-2a50f5acfd0b@chromium.org>
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

hrt_isp_css_irq_sw_pin_0 has a different enum type than
irq_sw_channel_id_t.

Replace it with the actual value of hrt_isp_css_irq_sw_pin_0 to avoid
arithmetic operations between different enum types (and make the
compiler happy).

It is required to build with llvm 9 without these warnings:
drivers/staging/media/atomisp/pci/sh_css_hrt.c:68:19: warning: arithmetic between different enumeration types ('irq_sw_channel_id_t' and 'enum hrt_isp_css_irq') [-Wenum-enum-conversion]
drivers/staging/media/atomisp/pci/sh_css.c:1233:40: warning: arithmetic between different enumeration types ('irq_sw_channel_id_t' and 'enum hrt_isp_css_irq') [-Wenum-enum-conversion]
drivers/staging/media/atomisp/pci/sh_css.c:1237:40: warning: arithmetic between different enumeration types ('irq_sw_channel_id_t' and 'enum hrt_isp_css_irq') [-Wenum-enum-conversion]
ro

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/hive_isp_css_common/irq_global.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/irq_global.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/irq_global.h
index 2c47e7820bd7..69e68ecd6bc3 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/irq_global.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/irq_global.h
@@ -18,7 +18,7 @@
 #endif
 
 /* The IRQ is not mapped uniformly on its related interfaces */
-#define	IRQ_SW_CHANNEL_OFFSET	hrt_isp_css_irq_sw_pin_0
+#define	IRQ_SW_CHANNEL_OFFSET	HIVE_GP_DEV_IRQ_SW_PIN_0_BIT_ID
 
 typedef enum {
 	IRQ_SW_CHANNEL0_ID = hrt_isp_css_irq_sw_pin_0 - IRQ_SW_CHANNEL_OFFSET,

-- 
2.47.0.338.g60cca15819-goog


