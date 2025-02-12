Return-Path: <linux-kernel+bounces-511634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48A6A32D89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B3A7A2FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80125A331;
	Wed, 12 Feb 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dRR/4lCA"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BD25A33C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381598; cv=none; b=DNCnIU2z2995xu8XmRlbsyUW1mUlm+FPLsYD+Dg48oTve9BsZJp/leQWBONUTjgearqH7apTfo/VRANEaBCjz8yDHFI1NJzHOi0ZUQ5Z0ywNcG2zUrlIQ0bkXbNdjdJMkuBAndV0rU1RsVaIrGT+p+frQs0hs6ZnikkqL3gRTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381598; c=relaxed/simple;
	bh=cxkJV60+sf4P/rsGTAfZtv+YvNaIelKydnRgfDpCgeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BldqLK+ESL+FJbkC/9Ffpw3+30vXeKTOm5S0CVV3BNIcpBpMKu+w/RNUvh6KEz5xkRs/3IfIuP2AJRqFkfNI4+UJe8QrNB3nVhyDyaw6bpCMzWcqDHTOzYG+GvdvreDl9WZY9ELTqy0fwbC7Iau/xqgnFwAY/rADvVhpCWg9p1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dRR/4lCA; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a01bcd0143so23805fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739381595; x=1739986395; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72VD7sYVet7S5yqMk9w1SxSUJq1Pf2TFibod+5PMSRY=;
        b=dRR/4lCAcRAvF5ihBCS+kSls+yD2ckF+RW60960b+erLM1IrJxtGg+kOOJpWsInU+F
         pVGw9vJExXrVWQRqMD5VA6emyXo/1aHObqW4gaHIjC5DJq4on+rhBC0/K58/2+Na8FYQ
         FiozRPAkM3SFdtWLYOWN3Z3aWwuu9ZVNk5HGzIEMIoJgk0WyHn1bXIEcby44DCKPTUOw
         bEExR4HT1z6tQOOtLC7bnFEnmIXdhBla1pgUeoJEA0r467udnH+2dBsUDdV2MHZOk5Hs
         FS84RV4pHFsJAR/kiTL3X9yyP0l0KX0u55N08mBJ4zpc50Wbmpgr2qjeK+oyEAaUPGW9
         KEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381595; x=1739986395;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72VD7sYVet7S5yqMk9w1SxSUJq1Pf2TFibod+5PMSRY=;
        b=EMIAongl6euU/auEKkgr/rACR+wLX7rqVyCNwKbG1+jOks4S6Izurfo5MY3+R9Ikk1
         N9mKtgwGye3/y/5IWrqJY1lI1zoXb+uA4DqTwhLBHG72/edLkYlMnoyra7DFjzaLyuet
         c/dCPU7pCZMDE8jFSu6fmOEVF8R2ylw3FezxHzqN20p0tfYHa/8P+itRWVTx5PiMgbwa
         z6TRQusczEUpTrAcGZ06bmL8HM3ZsZWoV1ncWouwEBNJGwKTTWPJ36yfr2+lWHa2RpSi
         r5g259O1xYtlYCj1Q4jGU5lFlsvSrhz3TZcHm5SjR8DGuhiCe7ImuGohib32zHAo4zlp
         npXw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNznHzxXyCW1bl0ZATl/f4StOJIu26s3Ro7QlqP4cV5gkTGejVDghcBAceZP9DGApEvVxHxPDmBbM8+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzb0yoPXtxk8euW76of5CJ2nhSH61CgD1P+1lntbKakt0QWUfP
	id3gfeHYzeV6oeAkg9hHSR0AzA0ImXQi5E50/jXE0gU8nPsjEVDXtLxttrdFJCs=
X-Gm-Gg: ASbGnctzeANZ8sgbkpV1zF5A1lAg2A3R8Vcw/OgAvp5SgMIv2D2rtcpYT20DXzRrchb
	4hMBBPxLLUYFI70iUHYIFpqdQMy0iIRmcA9Qg/faY7s72bU2iApdPL5SnLDae/pPWfWMGMipXTz
	yXPOsOZoKFiT0raUPAD+T7dKTuUxtALzj4w6e/CJMyzvyY7bCk2doBNL3RXXCaLU8dBgrtBJHbK
	yCLCWCtE6XhFQ97WrmGxVpTGlXdVLcPmZ04Qz+QLFdKR9P1UdcR8TsXIeC8DBcYgwToPxmVxhGH
	tsKEM7O0H7MFMntz+Cm7J8OlRegske+i5MByrcx3oq5snnk=
X-Google-Smtp-Source: AGHT+IGhI9+IRcyp7FZ5+iDkPMiJLIwnW6dJrSCJVX4eRkYofW2SpR6cdFtktOHd3GXkZqqBRvfuNA==
X-Received: by 2002:a05:6871:580a:b0:288:18a0:e169 with SMTP id 586e51a60fabf-2b8d658576fmr2419433fac.19.1739381595433;
        Wed, 12 Feb 2025 09:33:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9343c2sm4720190a34.20.2025.02.12.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:33:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] spi: offload: fixes
Date: Wed, 12 Feb 2025 11:33:11 -0600
Message-Id: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfbrGcC/x3LTQqAIBBA4avIrBtIsx+6SrSwGmsgUhyIILx70
 vLj8V4QSkwCo3oh0c3C4SrQlYL1cNdOyFsxmNq0tdEGJTIG78/gNvT8kGBj3eAW6qzuCcoXE/2
 hbNOc8wfIPyH8YwAAAA==
X-Change-ID: 20250212-spi-offload-fixes-34a8abe6417e
To: Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

Fix a couple of issues that were reported with the recently added SPI
offload series.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      spi: fix missing offload_flags doc
      spi: offload: fix use after free

 drivers/spi/spi-offload.c | 13 ++++++++-----
 include/linux/spi/spi.h   |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)
---
base-commit: 6cc789bf76b1f414791c69227e6c21ec41115213
change-id: 20250212-spi-offload-fixes-34a8abe6417e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


