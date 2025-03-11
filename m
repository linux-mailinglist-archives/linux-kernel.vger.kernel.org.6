Return-Path: <linux-kernel+bounces-555675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D02A5BB24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F5B7A455F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D2F22A7EB;
	Tue, 11 Mar 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="rhQFcKqG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F42288FB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683067; cv=none; b=IiN9hjG+jFFlpYfikZnoRnYre6iSHDJpqyli4HszK4MX+0izNUEshMkZ8D2PMfgcvImFeZFsf/OQBRR5ayURIdMVPLabmTdKOR7d9kQBLjEP8LPoyF0JOJ1bGfhELWBRCOjQjldFaUNf1Q7uqQ9dkFcFrUWkM3owBuzH+UW7fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683067; c=relaxed/simple;
	bh=p57AsSdCyuAbESfbedFQezCRxx50/BKv2tVS78zloLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmGM9r8rqhl1qQMZQ11yUeV+Jy+5PjXNLWofNHLATimQq9NwigjMntgCkwzDN2gV38kvCJnLcdWEOABT+VuScYTUiFOCpZKfVKm0FBid8v/fNxij5erfuKbt91aHJ3p2XIiJTXs2dBW1GGA5RRMJcQoZaaWYxDpEeADsxb12t+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=rhQFcKqG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2474189f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741683062; x=1742287862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwcL4HYRQdZ2nKV+qcZFfYe/5XI6eU/BnWbOOOqZ4hk=;
        b=rhQFcKqGf5SZtgYbPYQVKViEbD0mnIHANQKzzr8hOG3ADMCJrfSo7LoQkvN+4N5ZIt
         SnmBI8DT5UCSdQM3Oe7pjV6hB5Sdp7j/CHiC1R4RVrt7Sgh86KUhiP04C8Mw4OoasUy0
         oKrEK2Wlyd39X+vA/sZ+PwiiMThFvbWzoXFzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683062; x=1742287862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwcL4HYRQdZ2nKV+qcZFfYe/5XI6eU/BnWbOOOqZ4hk=;
        b=sWyNZT9niBBUJAMKuW8RswfI/TVRRZORriksxPtNwBXZMzd62rXoVbj/ASdrPa3AJD
         Y1EW9KtbqZfE018fsoB6CuzV+EBBrtQaSeTYeiwDAOlP7LQpK73rmNb1A2dsv4CTCISt
         MmOc6GPwLGrUcrS/9fA5+CW6NgXXmAOCAJIXA+P3cE+meTluwBq8j2CfI3p0TxfexJA/
         8AQI5AjYiMauFGS6ElM0lLGMHCmVRfaHROBGDia/emvYqzuCFmSPBDm1a88U7nKDRMAv
         X4v8UvHEIIW87erT5Yl8P5/3le90du7SqI+zNFCcrtZ9Etc4V2i0rRniz5OaOtmVeYfy
         eNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUSqq5Q52LMk6AhG7/hC3GVt8oLjtQ0pJFsC3gj/8ueNUn3vIeNgArzd5Bx8ynJiYkZph3wBVCbnZI24+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUV5ng43i5/sccAsgWLn1remqaKcY2FDhXt3Wz0gqNsSWINjh
	sKIUCoK3Cmj1gedXq0klI9Qvi22biDvmygdOraFDNbc16rD+rL+M+QjseUDWYw==
X-Gm-Gg: ASbGnct+jbvCxr93QA2Tov5AvfX0u2hg2/QOxV5sg+uMz93mPhSZGfJ2E48J+DJkEZF
	0GoFY0gjzubfLvGopVH/tnin83B7yLFtL2HOYmXcbkSAkk5klviepF9wB21jiNiF2wI7jhaSGYZ
	N7sSNKUZ8fIXlYGFAxsknIfRMxpCoaBcw5aNA42rwLzlj/7t1DUrmkjL69StKdZU71ZaoQ5E0lS
	l5G9SooVvc9dpaTZutAsfVXK63mXma/ITlP6l7js86rQq3W6fu8FDmU0uGCT/x+G+bxhW6N/CMV
	olmGbMoM/ep/t3IXACc7dMo8nZcDKqa1li8O1Wtcum0WiGwYMLV5sfIuunxilPK3Xn448N4spKx
	e4jJRYAg=
X-Google-Smtp-Source: AGHT+IGk3N4ePEA8O4L8AME/TM7yCODZZG/WNCNcAMHPSuNIq2+J+9DDvIGH7pXqN6oDdgLo5zzbfQ==
X-Received: by 2002:a5d:5f4a:0:b0:391:22a9:4427 with SMTP id ffacd0b85a97d-39132d3b3ffmr11551870f8f.12.1741683062563;
        Tue, 11 Mar 2025 01:51:02 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cdd7sm17746333f8f.56.2025.03.11.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:51:02 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: jic23@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
Date: Tue, 11 Mar 2025 09:49:47 +0100
Message-ID: <20250311085030.3593-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---

Changes since v1:
* st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
* st_lsm6dsx_read_fifo: dropped check for zero fifo_len
* added Fixes tags in commit message

Changes since v2:
* split patch in two parts, one fixing st_lsm6dsx_read_fifo and one fixing
st_lsm6dsx_read_tagged_fifo

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..480a9b31065c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
-- 
2.48.1


