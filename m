Return-Path: <linux-kernel+bounces-554324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81AA5962E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCED1634E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B022A4E0;
	Mon, 10 Mar 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="KkXeiQyz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30380221719
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613145; cv=none; b=JgCFHKJk8qykhjfz6QD+ssWvFDxrXNCrTEgEC49Yh7vpPDrW1cS212Xl3U9EcMRA4ho1dG3V/YXymGbi5RUc/gIAO65v/qvrZZmNk+vpX1DrgDnNdlzSA9KmtGxXzxbvJ9byZJNFXRTNWZgMsoN/LknMsNMpd5JDfdMhn7z5yPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613145; c=relaxed/simple;
	bh=YrADBiheJchAyAdCNqc9RprXi1WRoKmHkKStj8Ms0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8vIdccXH9d/zxaguYJoSFuGYlb8hOC+M+qMEXkagxPrKaN5+MIOmGMr9JJrGdb1xBr4ryU4xFQBqh1wK92csNdo5mp1Y7vhLOVIEK29XSkoOfuYPNqkw9BBzk9Eh8r09hu5e73aIKyC4xtrRlbSW3LU99O33UgKjEJQ5TD8N0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=KkXeiQyz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39140bd6317so1121701f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741613140; x=1742217940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB3e94MFj8rTJRt3M09+UlwEYAG3T1Bpr1A/4vExtqY=;
        b=KkXeiQyzopcCXQNeo2U0TbzRbbq8ee6zYhiivpaO/ED80LSlWFQivRylJyXsFHRWRD
         /UnC50Wr30JfGiRyjPnktZiJrbjjxLEkGuQ0CG7AY0ck41uSiJZxxWuqpliIlQp5xWML
         mGiS6zBeys0dEWLsfZ2A9sRUqYktVxpyru3+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613140; x=1742217940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB3e94MFj8rTJRt3M09+UlwEYAG3T1Bpr1A/4vExtqY=;
        b=bVOu+bl/wdX737UGEYTa6g6cdCx9P1FzRUKOuoybrr/rNdpeggmUVGOdrmZn2e5cEI
         Q5uE7+37EmlutdepIAVDq0xVJFQV/O32oned3gpHdLON2E8lFyM0x498jXk/mrM1r0jH
         Ub4H8+wqarkDb3kF2Y9x6X9YAPLvqB8L1iVYBFu2O4xjzTNGva5AL8CXrWrAOjq+d/hv
         K1Ih6FTVlQFZAS5QAMuY0Y9bXxp8FA2pZTBXZYopMAg9lWuu+fqhwX7W/DBEaXTh1nFk
         Jvl7gnWfwedQtAPT7CQSe3HW9HuyTBBo0PwrDlwWfcdnIYAhOaUQPonPDgZSCFM9+DSR
         U+7A==
X-Forwarded-Encrypted: i=1; AJvYcCWDMi7onAAf0urPaVIDMVdpWg2Ygbycx9gn0QsOjexVA3dG6Ob+Ek6Flg4Xe2QSvt4yXquXQm98I3ODeDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyQ/rpF3LfspfhMGJX5XtqS1F+GdlI1UJemnsxMrHCXFXPZ0C
	zXLJbfbDP9RSb6UYiBDNnNwvWa3+mAW+sadM3324WcAN99yBAXCf1NK56MgvGQ==
X-Gm-Gg: ASbGnctTMteGbmLDl7i3ma7PUP441m1UuMg+LF9+XHOBnB6E7h8VEcp58IFQImB5AgO
	P9VT+jWlWVH8GSXQGEX9jY7OyMsRR4ydPzeShT1vVddfXewazvtWRbfE32GDfRivxFDZ08hyRdd
	UqrKsByAZqBoBfPQ6jUzalSJS4/6AA98nleylAjTKgfoTjHA1uBWQ5DpLkpRtRL1P2SgtCRE4cY
	t/bTwbd5VAg8ecPehaGFiAJTEdo2sOXOF2MBDrV0I/JyQfO88a5ETk/jgh2MV5vetoaDP3dIlGo
	rS5kIB11bIu2obFnBhbIBA0ywrMKxGqIOHpIV6gTQjxBdjc14FnW7fivzLW6IF1BdkMOb5f9L9t
	kXmnD/yw=
X-Google-Smtp-Source: AGHT+IE9sjaOWti2nWlnXm70Bf6OEGxgj1h0tw7FKu5GsXjvCPFTORvOO8LpxkXl9SJv0ptxnOkylA==
X-Received: by 2002:a5d:598c:0:b0:391:45c8:3829 with SMTP id ffacd0b85a97d-39145c83c49mr3312166f8f.23.1741613140359;
        Mon, 10 Mar 2025 06:25:40 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcdasm14638099f8f.23.2025.03.10.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:25:39 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon, 10 Mar 2025 14:22:37 +0100
Message-ID: <20250310132508.24660-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z8sFdGG4bDyALrsi@lore-desk>
References: <Z8sFdGG4bDyALrsi@lore-desk>
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
index 0a7cd8c1aa33..39a7e15ae9ae 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,9 +392,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
+	if (!fifo_len)
+		return 0;
 
 	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
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


