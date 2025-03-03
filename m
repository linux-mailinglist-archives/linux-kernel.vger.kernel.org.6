Return-Path: <linux-kernel+bounces-541803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E744A4C1D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F8D3AE22F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66384212B2E;
	Mon,  3 Mar 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="nDt6q4/K"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842920D4E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008167; cv=none; b=rIsMwx+0hsc6odoMmdb7qotGmqJEcPVT74Krg+lkrcew93yFYko0qFXRLq0KYTCQMg4/XmNu9V8cDwCe3ba2vTyAf1biULL6vC96nox+CQ2y55rkFQnvTatb0f5pZTp+VUztv7yJdlUSdvMjIEsj4uWDdLkxZ3e2MbZYituPtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008167; c=relaxed/simple;
	bh=5i9uP2Ze50hwz43llaF1f86tTfk7p6fywziSf77roYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgaeOvATE1a8dFrC7UoDMTPUGVhaLAzXaQTUz/KEpN7dCR+6S7jGT4kmiPB0oLYf5/amPiKY/7uc+DK7MUve8bfaKuiTKkm+VOPSCpwAzqgIFYcEbf72ypTITAjARTas4ER/qSIe9gGDhrd8HYP9E14x49PEiMeVmY6DCTmMiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=nDt6q4/K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4399d14334aso40859525e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741008162; x=1741612962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd7n/EGUmOy5J+E/dKH2tzC4YWX/xlVp74bjlxoPQg=;
        b=nDt6q4/K0N8xzRqLxFMqd6p1ibGHiV7xxPWXT+usVbOPibIx5bWm7/n/dn9DYCj9hj
         c2H4VCsB/m13egqj5b5paRRnZK9yUobXj1xIDb7HDEuTJ6Dx51+xV7isuyfBODiDWnli
         NeDXt2m+BisCAEvycr6XqxaD/0VQu9tuMYZFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008162; x=1741612962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECd7n/EGUmOy5J+E/dKH2tzC4YWX/xlVp74bjlxoPQg=;
        b=D15uM038hP5FfZqIUs7XQsfOQZLBDRJ2ro3sIjax1rQZ+x/djzW2byP7mvSJJJO6o2
         f+1UpFGoHpV3MqaO0bRmvGvd+bgfokby//oVdZaJOMStyKWQ/ot5Y+8Ngo54SYP5e7il
         y/QxThZAL8Wt/f3akBWVET+w73HQuKbAH3+HmeC645GgfHX6Bu9S4cGoBeicSmmBHKzB
         67pjXqTctilRBOPZGr1JSdHIxRunrOz6gvkD6sPdbt7EIsO6qfSO2nkkkbuyHz9HvPBL
         wk9OR2B4QSAwxaaLiyEHyHdBm/Amaody+UqlJquSqBa9R7YS1DBxuNKd1cVi7QhXA8qj
         jBgA==
X-Forwarded-Encrypted: i=1; AJvYcCVu+8jGGKMHVoHc/y5Jb1HdXaxLWCpnqqPKTJVOS7tYlqGBzRzVlwXZvL49vnRfUcXLmNqLMv55U3vKQiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuJe6nVrDEC67+UMawctI1f2O+dsl9XG8OZN7dw3YcV0djyNv
	L1dyQHaX4LWcQJkO3u13KVv+OyJOLhJXLudgh49L4DfRQ73Qkh/Z52tfeKZ2BA==
X-Gm-Gg: ASbGnct8bhUiV/5RWEf3RODVaaeaLiHuWxE9b02E1HGwc/SfJwjQ1/v8LHoEmVkFI1F
	1Jz8AS65+yuoaJlNEvkiyXZ+v32BlRi1pK7bCGHd1gKz0U2Yb9j3ppg+XM22O7eRty+JjAJJrBL
	Y9VLdI7vs9iZIm3xN2YroB4GiwT3pZ7L+fz6b3lWpPP702//Qk9RzvOyULJo2anyip2purCX3f1
	hRM8Q+pnVBQGV6xt32ASw2xHKqJta5HEMUJ3zfzI0vvDLo3lePbSnqARmb5Y7DoChWvrsuXU1rH
	U546NTPCwtrSgbySfW3gs+HoInL7KTe1JYG7Klg+P9H1C0jmBhy2HeglJgOyfGhzLZ7n9vQyQo9
	kl8Z5rCs=
X-Google-Smtp-Source: AGHT+IGakxsdP7cssVmEZsfodi7ojWu3CfAaSJKH4e/l+/9KTp9+UWQBz14kFBtrP7h34XIaqmym6w==
X-Received: by 2002:a05:6000:2a3:b0:390:f9d0:5ed with SMTP id ffacd0b85a97d-390f9d007fdmr4858802f8f.1.1741008161601;
        Mon, 03 Mar 2025 05:22:41 -0800 (PST)
Received: from marvin.localdomain (94-35-64-90.client-mvno.tiscali.it. [94.35.64.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f770asm166769265e9.6.2025.03.03.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:22:41 -0800 (PST)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:ST LSM6DSx IMU IIO DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon,  3 Mar 2025 14:21:25 +0100
Message-ID: <20250303132124.52811-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
from falling in an infinite loop in case pattern_len is equal to zero and
the device FIFO is not empty.

Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..7f343614f8a5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
+	if (!fifo_len)
+		return 0;
 
 	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
 	if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
 		ext_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
 					    hw->buff, pattern_len,
@@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.48.1


