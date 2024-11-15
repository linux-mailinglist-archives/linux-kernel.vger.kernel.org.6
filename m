Return-Path: <linux-kernel+bounces-411442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB99CF98A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDC31F28028
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B101FAC45;
	Fri, 15 Nov 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Jwu9VcWR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5D1E6329
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708124; cv=none; b=gnd+VsOa9/FeGjLh+AJsEc/HTmqU5LmDu/tBLMT8DynO3FR/7CQcNSlvl7BbqlLU2wdXb612d1NuAkglSyYbe5Vna7XOuhTRcVk0+Mc+z6+wOi5ntjA/NeMKd3VoyTkAsHhPOA353qcz+nCwdVay844dSrpl9+uiriSm4eWsJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708124; c=relaxed/simple;
	bh=mjXdxM/krU+P7U58TYMn8wwGLeOHGr9wU0Hfmf9pmZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOL+eIHZCXb4avKwCminZ4UjANbXA0PR0AB04g/njT8XUoBImgfog1mg11uhZRWQQcRua1MEIeA2eFNIZYRepg+eRsB6im2j4S3jz1h0sHKma+gzHOIADo6yY/Rqa/V4XP8Ia1TeLmOZAmoyi8QKC+FMSb0YcRLqMQSOwfKsQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Jwu9VcWR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38221306992so31523f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1731708119; x=1732312919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7BXM9uHlPL6jMEU0OEeFrxwAP6qySqgpEWYWoYZaXg=;
        b=Jwu9VcWRN4CQIEPopY8AW7jgr+bsbJoJ0Q5t83X3YoQzYFiBzhUwCdPbS8hrajwgGe
         51fk9KCmxsuRZNOLCXeXh09sel02Gl9GoqpDTNtlnQU70hVH79HuFW/IExmExIhALtxr
         moolgVJ0Hq4pGTobVV1AAoP+ubuk6cT4HqgKHv5GYUtEhoRJEBKZ0K7YAW4s7z5eV/se
         cdGl+go7O5c1VYH8dsGT62o68WAuD0nP4Qt9V1j+cJ6Dn3byeeDME6ZIosM4/xtp+LJp
         hxaZemGg1I0MGC+aU8kooM/aRmQ7PVk7XyR6pclf8ZIzC9zQ5iLDzIsXq1xMXk2Zk++y
         deuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708119; x=1732312919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7BXM9uHlPL6jMEU0OEeFrxwAP6qySqgpEWYWoYZaXg=;
        b=lBf7pZtEV1Pepg70UK9INrMzEZH1oCczI69bdYhFs1Un8ikd3Zeigaev1cUgPS4PJl
         AIxjCo8qZDauUMpRQhJhtAwG3OrJHU4gvc9esVlzQ5pF5g8Gmvpr5/nbo+gc6q1c0jgp
         MDJmoayoURX2jk+ZFOLMpexZf9SYn/5oXnRH/UiN77jaUi7Hp+bvYB1JYV0MdEBgU4r4
         97YZOcaVse2awGTZHiBbRZtxUFaJ7xQFzqA0Cm69r//3gSbVpKCxjUmSVgymZ8M5Igw2
         5qK/Olan++MSSKemI/JDgouYT5zE/30FoxyOv6l3PG6LBteXmIiD7UQljbU0I/7/qI6K
         KU/g==
X-Forwarded-Encrypted: i=1; AJvYcCU5k6U1PSY/DV/+zuvC1A388JsK1otPSnqoeOvSM430swFz9c419lEf9fnOWa5trO5v+Xs4+251uDCuw1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/CRA2bMR2/xxYtzn/Jvel6ZV4MZXyBxSq1NrZ4P7peWF/h72
	pgzX8uCgGYMkxky6cw+ku7HN3ZoI05uePQyd4I3flurJCe1KSDXjML8n/5oCdeM=
X-Google-Smtp-Source: AGHT+IGjkzoAQXFxARiQrL8p/xLqSrw6wqKEEJ3PXcTvMHBD/NA7oyekerT58FzZoi2a9uv8ptBRRg==
X-Received: by 2002:a5d:6d83:0:b0:382:2e9e:d68c with SMTP id ffacd0b85a97d-3822e9eda85mr2141749f8f.38.1731708119172;
        Fri, 15 Nov 2024 14:01:59 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1b94:c354:f504:96f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2e35sm5470537f8f.5.2024.11.15.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:01:58 -0800 (PST)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-spi@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi-imx: prevent overflow when estimating transfer time
Date: Fri, 15 Nov 2024 23:02:02 +0100
Message-ID: <20241115220202.31086-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The words delay is computed by multiplying two unsigned ints
and by adding up the result to a u64 variable.

The multiplication, however, is performed with 32bit math
thus losing data when the actual result is larger than UINT32_MAX.

Fix the operation by casting the first operand to u64, thus forcing
the multiplication to be performed with 64bit math.

This fixes 1 OVERFLOW_BEFORE_WIDEN issue reported by Coverity
Report: CID 1601859:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)

Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0b6b0151b3a3..eeb7d082c247 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1685,7 +1685,7 @@ static unsigned int spi_imx_transfer_estimate_time_us(struct spi_transfer *trans
 		words = DIV_ROUND_UP(transfer->len * BITS_PER_BYTE, transfer->bits_per_word);
 		word_delay_us = DIV_ROUND_CLOSEST(spi_delay_to_ns(&transfer->word_delay, transfer),
 						  NSEC_PER_USEC);
-		result += words * word_delay_us;
+		result += (u64)words * word_delay_us;
 	}
 
 	return min(result, U32_MAX);
-- 
2.45.2


