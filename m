Return-Path: <linux-kernel+bounces-263715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F593D99F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF451C2318D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEE85588E;
	Fri, 26 Jul 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XxbHQQth"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210B184F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025127; cv=none; b=nf10KfJ2E3Yh2PKravg38ilJ+w2blv13CjajOjWvWmfHjQkztzA7vIIFVC0Tp4rF62QD3q0v90KK+PqbIxJt8bVpj1X1QHs+0QzUHyDRI88m+SNPBZQ0eLFScoS046Qv0RI/0azOfImNGolBcyoVCtJKpoU8f5jaIVY16rDiyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025127; c=relaxed/simple;
	bh=t/xQJdIhtTXF2hpyrs+YVJQHpTkO6k/STifcvBMXxj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SuF/nppJn2pFdqdcIB0e8p99gVOmrwDkqYzBAcl+VwDAInzJH52+vujuTuPT1vnfXxeBpWnPVph8A8+GuHiMXSBBgtrxic2raF1vLKEKJZFwIcCQUykAkl9HY+qMtfsSZmsdr3htOt4ROYucpRqxN9Hle03ETGB68l2n6C9TL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XxbHQQth; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f24382so588048eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722025124; x=1722629924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5hHnGIRzay4ofgZ9pZK7d/c6GmutY9bb/g6Td7EXnM=;
        b=XxbHQQthQJe/0/NcVjt8DOHhbExnpdtsVGmXyDX0XtV74t8pVQh3qHd04yb5HW0thS
         tLItXOcpTfI7D7fGz1hLqC5SpoFpCxrRyEhJRUkrh/R9NeXduJxWnZpTMnhiNOXmxOSz
         4gwD5ggAXKA9Lc1nZUBrQdUt1FLpFZzKzd3EnmypzMOWKglr8bLS1wid/2ZSSqpxeSCx
         NhMFMqD/+rfJoiTk4JZC7pHELJiG2W2T7+v8j6PB0kfPAi7TuXJ5A9vqpjXATFLZ49h4
         rIwx4eHJfsNOwM1wZPy/dncPQIr6d/aPHbqObTs1LkItIaMQQyZ/3vDcT3SpTc9QXg5O
         uZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722025124; x=1722629924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5hHnGIRzay4ofgZ9pZK7d/c6GmutY9bb/g6Td7EXnM=;
        b=h/DLE80bkmlepvd8bv6+aSpeJzh+Sk6S3pAEigCPAJN1YUdYpJYt0JJGilE/sT6HvJ
         Bdp5Vix2K36+JRT87wgEW6/18fxisEY7xnhOcwf37PZ0OPIRHLTX+SHz1hz6KMJz/2Xr
         tQLpg913Fs0pty2JD51wnKR1lc2Ib8HIb9FcFRlOBjtxVJsGrT9PVLc1vm++GE+NIhR6
         Mnh+Hc89Vo6RR4DhuPLd2ukZXwOFW9wYDmsuLT8n9ZSRlshCowQOCGgripI26HlalCch
         f6+RQeWnNLG5Bjx3A9Ekkjh5tbe48pegcIMi1qa5rMOcuDkYVIrUFy/aH2LNy/14A0yz
         5VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY9b3Fy2/ZOwcXXEs2DXF5Y40rumjZgK2D6W82RoUZVnWlJFdxyJUWN6JgWKMd4Wl3flUUW8U1UViaefDFykTZXGlqDVhTo6bF5Ssu
X-Gm-Message-State: AOJu0YzWpcJFVsc58c5Ao0VsTT66gI3NX2xv21hTDnv899fFot1/4UQW
	SKNHRmGsdFDkUCJGhFajTHVtEeIgYWGOGrC/1TI6tuDmjwvGXrH+0bQ6hYNqKeqv6Cl3ouzeju7
	P
X-Google-Smtp-Source: AGHT+IGG/bK2+K/Da4LrV9CC9/8cFUd5Tm7DlPEasAWLz5DrSZVQzPDUptHwtZjkXTnx9VvbNLUJxA==
X-Received: by 2002:a05:6820:2292:b0:5c6:658c:a9f6 with SMTP id 006d021491bc7-5d5d0d86e0fmr1046551eaf.2.1722025124053;
        Fri, 26 Jul 2024 13:18:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5b346d58csm528585eaf.6.2024.07.26.13.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:18:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: backend: spelling: continuous -> continuous
Date: Fri, 26 Jul 2024 15:18:40 -0500
Message-ID: <20240726-iio-backend-spelling-continuous-v1-1-467c6e3f78ff@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This fixes the spelling in IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad9739a.c     | 2 +-
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 include/linux/iio/backend.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
index 9b1570e788b6..799387f21b9f 100644
--- a/drivers/iio/dac/ad9739a.c
+++ b/drivers/iio/dac/ad9739a.c
@@ -145,7 +145,7 @@ static int ad9739a_buffer_postdisable(struct iio_dev *indio_dev)
 	struct ad9739a_state *st = iio_priv(indio_dev);
 
 	return iio_backend_data_source_set(st->back, 0,
-					   IIO_BACKEND_INTERNAL_CONTINUOS_WAVE);
+					   IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE);
 }
 
 static bool ad9739a_reg_accessible(struct device *dev, unsigned int reg)
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 6d56428e623d..e44463f48bf5 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -452,7 +452,7 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 
 	switch (data) {
-	case IIO_BACKEND_INTERNAL_CONTINUOS_WAVE:
+	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
 		return regmap_update_bits(st->regmap,
 					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
 					  AXI_DAC_DATA_SEL,
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 4e81931703ab..29c4cf0bd761 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -17,7 +17,7 @@ enum iio_backend_data_type {
 };
 
 enum iio_backend_data_source {
-	IIO_BACKEND_INTERNAL_CONTINUOS_WAVE,
+	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
 	IIO_BACKEND_EXTERNAL,
 	IIO_BACKEND_DATA_SOURCE_MAX
 };

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240726-iio-backend-spelling-continuous-d6801c838fd8

