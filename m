Return-Path: <linux-kernel+bounces-249313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463D92E9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E831C22437
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6E15FA6A;
	Thu, 11 Jul 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="M6QZ591f"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DD433A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705541; cv=none; b=YJumdtI0/WbAK7RzSjO/dqvhJa1J6kb7TtaOM44aD/NjoW1tNKvcNvp+/980I75AVcnw0Q6urwvRtdDtbCLJrv/9iQdXdswzBGwlNmUqW4JP8FBGXD3RlkcO0drMiHSVjwtRRvOEk8W7nT6e6k8MSQe0PYcMLBIwGfeBB8gNAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705541; c=relaxed/simple;
	bh=LNgfPEONwz77obs5vu86+jwQLoPPcNzIkcXBF7J5Q7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUZuq7Q0qWxX19U0sW6t5lKLLfE5XSfPxhg90XP/SjVJyld/b2FlEA1KBedfZMcMN2M17N55Yk50D84cOFlkwrCCR4Rn61mpjcI/AFxpakG2bbxSTw7pyoOnj5QqyolumRe0deh0WBYrRZXVqpPcZvR0fXi5+F6qQVx1EwB65kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=M6QZ591f; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso10701711fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720705538; x=1721310338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/c+0OryQ/xDZXy3GXgibVWASMIq5wTTdQXB096fDbxc=;
        b=M6QZ591fkwKguDcp27deFU3Mye/AcsIkg7OuZWaN/VzIhgL4niEsa4VgMGdxma18e3
         7jxeZo0mtU6jKMSO4Lhd9hzYRWasVuoszXnGz1xT3tGYLUSsiY3tq9jKBmfqsW9CMhBA
         L8Jrc9thwAhCcoX3di7egt9Ij39dAKM9CGvaraRHCE2Zdmusm6wISK9cec6M1zke/ZLj
         Z4xhv8dmSpQgKv9V39ojiTrnTVQfEB+K42jPROaZha5iN9W8kZUpB2nVXHuvlU5/JxM+
         RxRXm2bImdyho/jfa+vCo5sdobzUTfCpYcS+tkNR5zgawUbAelbNifVcycpmfTFOQbbO
         6BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705538; x=1721310338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c+0OryQ/xDZXy3GXgibVWASMIq5wTTdQXB096fDbxc=;
        b=SPW/XllWpGJr7VvM0ASqL5rFUWlarMvpdS7qOsSL4m0RnJJq+561dhpz5zhBAi/45j
         h8o42Q9LwNEGhNoVOJiw6qJU63atVqiENKc1tP8gbTQ1LTXdbwuxulgxvFaUX/5lkwMA
         L41/W7wpLR8XN9NcHMUBvsWEgbUPsoz3CJG9EA8YoOmSRdO5XFSAy9lTTBgTow7bT5MV
         WYadWklfAHeVG8KRtKYiSzr/fA3KSL0Ot0I44RLTdrtdHxRG1CcVGDARf3r3wwaS/Jmi
         WodK+vFbQ9x/Pmq0SN8bQg8MV4BD4NH1XhG9j50MMq9MoeYc3PK4e13MnLmjLy3x68mX
         LUuw==
X-Forwarded-Encrypted: i=1; AJvYcCXetRgz4gKRtouOGzR270+wyzz0ANdgvV7/Oq+mjj/Dje3mSLyTNgXrmlDtnOVhHbjjdqVRZvCvJqzvTWEdoR1FfPB6yYyWyziQ4unk
X-Gm-Message-State: AOJu0Yzt0A8erehEmak93c4hg/P2ykPiMn7yENN59zJMT7tklOr0lz//
	cTCsRvQZrvUBW6HnRQDonKtb8SLIPukcxvNjV1ZZWuXyKXMdPFu9Lu32f8MPZ4nr18Q7jopkQ+G
	dKaE=
X-Google-Smtp-Source: AGHT+IEnRul6UAvbY364YlS50mTbM15zix7Loi58TE8dtn8HaiZFAwF2Qoz4+y294My1CpS5s27RFg==
X-Received: by 2002:a2e:8797:0:b0:2ee:854f:45be with SMTP id 38308e7fff4ca-2eeb30e528dmr54794621fa.12.1720705538039;
        Thu, 11 Jul 2024 06:45:38 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42667720667sm175476835e9.33.2024.07.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:45:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jbhayana@google.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] iio: common: scmi_iio: Remove unnecessary u64 type cast
Date: Thu, 11 Jul 2024 15:45:03 +0200
Message-Id: <20240711134502.168484-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable uHz already has the type u64 and casting it to u64 is
unnecessary. Remove the redundant type cast.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7190eaede7fb..ed15dcbf4cf6 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -158,7 +158,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	 * To calculate the multiplier,we convert the sf into char string  and
 	 * count the number of characters
 	 */
-	sf = (u64)uHz * 0xFFFF;
+	sf = uHz * 0xFFFF;
 	do_div(sf,  MICROHZ_PER_HZ);
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
-- 
2.39.2


