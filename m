Return-Path: <linux-kernel+bounces-554421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEECA59780
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DC716A176
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E222B8C8;
	Mon, 10 Mar 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="dty+Ss8l"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6042248A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616720; cv=none; b=tuylBX1GeBe9So2zEAP9TE0oI6AUFGqfV2+AG+NBwgiTH3lztequOfafo+5BloeemHZggGgn6gc2+zRI/10QvKIlKTMOgQ5kzhcjLtqAebsIPL+W93F/7TB1fuZyAc3IsiGX0yQ4retrgAh9wdFiAA31HVA9kmetdvbJMWxrBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616720; c=relaxed/simple;
	bh=RvgBhmSVcfRiCq0Lux2A/AMSwo9aNXNH4wQ3F3+UYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfZgkW1O3mB4Popi072b658m7F92RWgD0tDHIVoQyGYqyZcPST758MyM0QDD7htzo78mRwiSyzE5LE3B3hKrI+aNDAO572VGViT73tdEPWIFAW6UgCasdYhak07hAPy9HB8pPRkCv2XCD0tGnx3NBkbFoLwGb3OSQ/kmWy9XdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=dty+Ss8l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3911748893aso2678852f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741616714; x=1742221514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kW/pm4MavsZmqqFiY6ttCOniK97oiQCgMeDYqCM9/LI=;
        b=dty+Ss8lPPcfuPySSV6m8vpXVLdwP+T42El5fBz7sq6c/PP2qm658I6OgyuW1pYlMY
         ZUEriS3Jmeaj0zONyY6K0vwr3WJm/YWPTaDGnep9i3S0j3TFUDmHNSj6pW0pcMZViCkV
         jsWThC3KGKtpAkZ4BU8KhwhfpFYEPAVBBGhls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616714; x=1742221514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW/pm4MavsZmqqFiY6ttCOniK97oiQCgMeDYqCM9/LI=;
        b=mm6jWMTgpG6VE57glmZqpeSkkf2W042FiG8lULKDRtKTTsZT5ccRit3+Nss2pOVJld
         aTOqBUBC6LSHJ5EP/5OIGqUk0LmpKrTh0gV94GzKn8Br7s9HRwXgBC+mr2BvK0hrQ8RV
         rT5e1hzJWKNgefaDop/8HY2G+JkrEjcZg3ddUxyBDI0npeXzPgGHtcHBwRJYhrBkiPOg
         MDsHTuEIo5wubJ6M5h+UTYwTuhBsaYf/Iuf2PFI9JO7HDbin8vo+UCcCQ1XfUpKtyoQd
         vdak5ueS+3odGIQ/OpioKD+7IHpFr2c+8xO7QygzRoyv/Wwek2ZvWTBjFLFmt+aTbhIG
         kFwg==
X-Forwarded-Encrypted: i=1; AJvYcCVLbainl/Jze6fsHE4DYjEPotIOgFt6uguvFUVZ1Lx3EsFDLPxYFUkoYprCZeaFzz9f/X1wKxP4/ZDsSOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuhtF/DoJeLYfOYc03/XzYXHJVi4KegwrGPxUf2zNVREgNKis
	us86p+s/eaceC81T+Yy0K1uw8HZNXzvTPAqsSscq35H0cKqHI0Z3a5ec0wj77u3qdOMJTjzOwCc
	v5w==
X-Gm-Gg: ASbGncvriltzJq9psY2u7rN8ayj7X7tuhG7/8cLe0CFFA6StEGGL1RuS6SoQX8uERbp
	Mw58/MkpEe7oAaPgSHcBRdXzoEo9XUEf1UNhv2/NokytRjG3X8zzT8HmZv490ggWyGWw7tibUia
	vcmNvAMxYrJZTtztmajokK7d1cP2epw3EjwuTVu4TfRTlaKrV3aWEvoJFErxcB2pO4yJuUcXWcS
	Qa8QUGElDrUUEP9hlyBfVoDJ2IbaXV/jUNTFVh4FWbOF5KQf+AytAayrMrR0yMYyysbf2QQwxTd
	SfvmPp8oZ3RuJxVtnlKesaXGCviT19jLKiArjwDBjeSDDvTvEkIZ0fOMQIfVB0evzE1SrGix0mp
	nmZ4Tj2Q=
X-Google-Smtp-Source: AGHT+IHVGeWNFLhTxxSByXr4IsPKYCfOogvrHznEpaw7DcTPiThSqxKiTivX5c0n9iRBv6Rs9+WbZQ==
X-Received: by 2002:a05:6000:4103:b0:391:39fb:59b4 with SMTP id ffacd0b85a97d-39139fb5e40mr5830285f8f.27.1741616713993;
        Mon, 10 Mar 2025 07:25:13 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm15395492f8f.53.2025.03.10.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:25:13 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon, 10 Mar 2025 15:19:17 +0100
Message-ID: <20250310142501.29535-1-s.seva@4sigma.it>
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

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---

Changes since v1:
* st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
* st_lsm6dsx_read_fifo: dropped check for zero fifo_len
* added Fixes tags in commit message

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..8a9d2593576a 100644
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
@@ -623,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
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


