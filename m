Return-Path: <linux-kernel+bounces-555676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26AA5BB25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1302A18945E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D6227BA2;
	Tue, 11 Mar 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="dFIVocYG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45300226CF7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683079; cv=none; b=gZtyH4cDPV+8c93JQTgsQjXDYrIFlm9RA4jSHfQ9PsjNa+2KXewpzGKjA44WKTHAP4KWvMIRVYPn2JtNawDiHhMsVU81NUEK4QautDMe9wXKrrLwoLB0qXrf+hkI++QHTUbobsZjCbatmOCnwGLRC27TD9CjppU2RbcSdJ/psZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683079; c=relaxed/simple;
	bh=epZ57SOX5YzHnFy/WkFcRwDgjbiMWrHimD4P10IE+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goaOGb2DDfb4a70ke0idYq3seWhbLitsJjWjsni/hSq1kBA8YYQ2PZfZGX3WHsDoEEnNT55oi4S8feMcSn73oYvKcoZ3H49edDinRJXKmG7T2Y0uWigmmQXJTV89pWH4ppc0WxAhtaN+caOqfYrt6N9b4HFxxIijkwp9Y4Sju/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=dFIVocYG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2768668f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741683075; x=1742287875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta529X7Ec9Pad2vo9YncNZsmhmxGAhn1X/QNcXk60qQ=;
        b=dFIVocYGa1Vyt0kXvyBJIFO6wKMX/V2nTVe9RgKQ9NZjZ8B1Fr8/YnxJkGP3gNtAbu
         zJ89TC4NRkeGREUvzDRtZRRCujsN3gYKDrGJflzlM3cMNglujkMgS6ZuDY/C3itmRaIr
         ZiufEgzKOuKmGzPGNZQVQ8kIZGWMqPOlwzicM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683075; x=1742287875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta529X7Ec9Pad2vo9YncNZsmhmxGAhn1X/QNcXk60qQ=;
        b=vcmkOvAjztMs0LZyAMHoch90Sk4RkYhpE2UIN1JJiPDkbFfIOf6bRPN/esVqag7BDV
         5ZAqbObY4r6tZFmEySYauRCb1pp5h6vX+RUPpkchaSKpenuCet6pDhMCGDpUOLNTwckp
         sKGxJrdn5Rdqhuqj12TmeE0O7fTK9/X1m6UQLx6kD1Wb7WbT6p9wDH+eui93eT+wgUSQ
         kLFWRwG3YOFkdgE2KBYKyO7EaBgI0M/aPRDTs8ymOsyMDw9qOHV8oDxonjIKKQcK0G0r
         NjITvqWEAu1Nlo1rxIi4DjFBCDLSjgubRBRbG6zuoQ0w0plQjM+JWQBdfEJFgG8u+Odv
         I41g==
X-Forwarded-Encrypted: i=1; AJvYcCVi5HkMLL1jKdcUm0PwRDjnyiHcsZt6UIViRs2R0mZ/64rm6Ugm2VWNGxL6XIsjEUpiKnkipOYWTJMdNhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMoQvo5s2N5YY8sSr/lwAjEMJyKRXJkjX0eUErFAW1pfRdaDyn
	pTJh7C+91JVgs4qwIteaGfmJpYOdAsYpAYRFumzW4XgWi1QiNU/ihY+Yi0DTDcrs+/i2UQwdXHp
	baQ==
X-Gm-Gg: ASbGnctkLzHTSaK9yTB0+nh+aKJurJrizsIOXo982lpAbg9nx4G/8OKGio1jfuo8G1/
	sbCkviGFyJJOIONk02VmRfaku0ZEpzmI9tLUoqcQ6bSirYyLM5xdIVVpIMXT5giQQk6H8QYpvzq
	AitK+mBXTtHwBx+qsx+vpf6032pZOiA1h5SAMh5NyXumTnCSN5SVQH7A1OtMe6uO8ZXXzPFA3Mn
	XSWJmbfXiVFkrzx/DYjQdfl2/5d2MUHLTCvIkDYu2dF+lza+fXqh9Ged8hBXv25/aWiH8TM1MH0
	Hbt6IjSYLavYB72ohDKvXGEvGzhwI0XfaT7Ubd8kzjHJ/JIkNX8Y5YK069A5ghw9hg4xqCq4VoA
	jYpSTADM=
X-Google-Smtp-Source: AGHT+IFdw+TlvJni9KvGZu3iaRvW4wpiEd8GOvdZeIqppNlFn1Z9pxj7+SuF2DYXmjUR1ceR3bTYEw==
X-Received: by 2002:a5d:6daa:0:b0:391:2d61:453f with SMTP id ffacd0b85a97d-39132d71099mr11193196f8f.24.1741683075439;
        Tue, 11 Mar 2025 01:51:15 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cdd7sm17746333f8f.56.2025.03.11.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:51:15 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: jic23@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo
Date: Tue, 11 Mar 2025 09:49:49 +0100
Message-ID: <20250311085030.3593-4-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311085030.3593-2-s.seva@4sigma.it>
References: <20250311085030.3593-2-s.seva@4sigma.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_tagged_fifo from falling in an infinite loop in
case pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
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
index 480a9b31065c..8a9d2593576a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -626,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
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


