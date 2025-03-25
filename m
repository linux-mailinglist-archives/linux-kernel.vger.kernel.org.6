Return-Path: <linux-kernel+bounces-574894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFDA6EB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A316BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59B204693;
	Tue, 25 Mar 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HT/woCYX"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224C481C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890463; cv=none; b=shPiAkEp9uvNsceELdYBj0l++7KdSJdPL9I5gAQMKsvFyCX+ELkGNniOmNk+5P/uXPnNfpapjNyzPh1MFpuVuikx2nIPnRmrhCJv0h10M8kO38r11ST4xtF+Pj8q4oun3LNsVktqqzx2V53/HUB+HvAZTEJOaJSFsthhjrHkvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890463; c=relaxed/simple;
	bh=otQXdpFdlu2BChfhwuQRzaNNK0IsSAk7WEEMHeNI4TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9G0aurKYqwAitCSrqQ9OU8FyHum0JNHrUmNHhomn4tA/0PgcGDTmkk7LWwFrfjVRTbGa+VNevp2AexZSdpoFXtS0qZwef82qEE7grr/CU+NS+ZOvpYGU1WaLe0tH9baw9mrlU5Tu8DfF+TZl54IM7J0j/V79PpD6tVtZjTtUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HT/woCYX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so31730555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742890460; x=1743495260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNYXBQpFyPKAPrC63ak+6Lghv9itCVCrzkPP9piyvFo=;
        b=HT/woCYX7bdqjuYF3gXmVf/YJ102qpupCux0ZXtnWEVeH9sgAxlWOFItIkMCutLLeo
         gR5xFNmVMtBNulRP6e3OGoML8cvHU28nN1nyNgTEVLhl/g8wKibhhFl4lwDKe2Ge/ksZ
         Agzw+3sj6or8Psad14BdYL5a87fr/MKXCebUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742890460; x=1743495260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNYXBQpFyPKAPrC63ak+6Lghv9itCVCrzkPP9piyvFo=;
        b=JiEzAgTjr+X454KxbteaHim4r/9z88n0mbiY4hDKsUwZFJuq3DnlKTR6r4T+6U3WL/
         m9rh7qtpG/De0Pbx8bNm3HFlawsFTdHQP3s/FWYUumwMz2ilvd6YkWZ0tCbFpJBMyUA4
         0ezzzFiz7ij9o0S2NUpX+vJNnVeEyowMdLJBwr1WZ+8oYrgoEC2kfEx9xiy9EBVPMnL4
         QHW1D3ONAv7tAQhsB3N99o1dR0oTtA2J1BK0mfM3B3MUQMQYwk7uTvxqyN+LqCUTwADu
         kG1eYhUu2RjuoLqOyJ85E0ZjosMwCKyh6TpRMI1A6Z/gZoBY5bbM7cymU9bJo9hvLk8W
         IEbw==
X-Forwarded-Encrypted: i=1; AJvYcCUfIJ+8zYTzipJpSf1Oh7KntZ//KRC2ETn0EZLrFLbGkx/7nwgKn5ehYgXN0LPR5F26XmqBb6S1YCpxHkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy667CTLwoOY7a8odeOuSqok8PmFIuANR+30ZN+AWdQ+CS7WYlv
	sYj8f1+m1o2aswBEoQ2a8QiVJ81l6r0Gwts5o9y1UdfQoym4M95+L8Jppm1OwA==
X-Gm-Gg: ASbGncvASKRLdVYrlSneEm9kFJuhuzVMDBpw+/Tb3IjWxfe5QmfQBgc/gTMW/ky3ifz
	eEhYJ7eLvTAA8cu1AYuI8XrlElpR5EMF+VZ1V5CaDhYYsKBqz/rhvcycqNOIARkTs1sxls1OeA3
	uQZDfKfWveB06tV8bw39h/y+SCOsLURX0DHTh8y9EYUIHGE71jOQ4NvNBgAMSJA3TfKUSw3lrkR
	LQIUikEFQ8AXBFI8HoVllb9sAOvEcxQ4thGVM7GAYeBe1GrUTADkAA/EePu0hmhXRwteUTsl42W
	o/ek+dZjoTDV42IOSo4gpuFizdbquCcwI0q98J3KIflyhQtdgCcl+lCsAR36jwNg
X-Google-Smtp-Source: AGHT+IGDbB2izvu+t9h4n+6kBg4rcIhVYj9jR1WRlX4F5kfsit9jrFvvckdmOs5NpmzKyk+jgcasxQ==
X-Received: by 2002:a05:6a00:3c95:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-73905a54b96mr28430513b3a.24.1742890460358;
        Tue, 25 Mar 2025 01:14:20 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:d83e:63a8:42b9:7425])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618c056sm9457156b3a.163.2025.03.25.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:14:19 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Xin Ji <xji@analogixsemi.com>,
	Fei Shao <fshao@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Simplify INTERFACE_CHANGE_INT reg clear write
Date: Tue, 25 Mar 2025 13:54:43 +0800
Message-ID: <20250325081331.1965917-1-fshao@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply clear the INTERFACE_CHANGE_INT register with 0 and replace the
indirect `x & (~x)` pattern, since they are logically the same.
No functional change.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 0b97b66de577..df2d1dd95d01 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1586,8 +1586,7 @@ static int anx7625_hpd_change_detect(struct anx7625_data *ctx)
 	}
 	DRM_DEV_DEBUG_DRIVER(dev, "0x7e:0x44=%x\n", intr_vector);
 	status = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
-				   INTERFACE_CHANGE_INT,
-				   intr_vector & (~intr_vector));
+				   INTERFACE_CHANGE_INT, 0);
 	if (status < 0) {
 		DRM_DEV_ERROR(dev, "cannot clear interrupt change reg.\n");
 		return status;
-- 
2.49.0.395.g12beb8f557-goog


