Return-Path: <linux-kernel+bounces-335655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0697E898
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEB2280C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56865194A6F;
	Mon, 23 Sep 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXjGR0sE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09849649;
	Mon, 23 Sep 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083592; cv=none; b=rUCV0G5r2X2xpOOfodKyPD5MMjoYjvvspayrQ67tNep266C9AkRFgRxV3OFTPqFcQi5vtYPtyjQhtJ6QcZfdVXj9Q77N5qgANe8lPwDFuqiq6j762SjJMUeddR5HrEgH03ua4cdd7funWXrn6o5h5nUBCDPhB90jHlD8wjWr/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083592; c=relaxed/simple;
	bh=S1up5lkRW9QRalf19GpjfNed7GQaI+egFG7lTr+ICFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9cv4XKDdMoI9HmpLK7G6+crh8Np4KEbp0rOEuV8RpwRQNPsOgiBNfNRBFi7g+q0/d43PVDKY1njppiMJpL6xjdlK8B6lVnC5mjZN0zU1kf/VtZGzqimlp/nM5VS88xnXaEPAB3vGBZGtyG9UgIBzi00k1D8EqpDo83of2aJHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXjGR0sE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059112f0a7so35748465ad.3;
        Mon, 23 Sep 2024 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727083591; x=1727688391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dOKvq5sK3chOPZqSUs73Dh4rYzc9HljqeogIORX3dY=;
        b=AXjGR0sEuonQiYZkl908jiGV1NmZUN4MiWGVVUPIF3OJRbb0q6sRuVrcP9ueWTWSm9
         uW38hZHX6JlCyvhhMniRlIoRF0mv9P+u9oQiaSKtgYtDSjsMOFFbZN/O2az7QbWI5nCL
         kMAdEfceL1QfH1f/d2IX4+aHC++AidMjCtfj5izknNM0VwIaREPZlD7XHpSJQXxgtqLb
         akNeRsiM3htZUdXWaN+rXbCqoayd3KGMwUCxzDtPxhj86H817WXVHBQppSM66VMgyY0a
         d9BqRoDFq+M5PeLP7Iu4IORp7PaK2pgRnkYx9pIj90kMUZNi8H0LNNwgWIvk7907HwKc
         i1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083591; x=1727688391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dOKvq5sK3chOPZqSUs73Dh4rYzc9HljqeogIORX3dY=;
        b=caTXznfjzcvvWvfzoyChZDjfYheeSGYKlcevCq1ucrrZEzxiNfN7a9qSSnaf7KTavL
         15GOOx7lf4xiDJG1fCly4u/y7HjxJPxINJHS8wEBa017Xn45nJg6K869QHfmB3P4B2fd
         ZdRf4QCRxF83Tiq+nhNuRYJHqBzIqhrWNg82gHmTK9ifLQ0MvXCKO+vsP0knSEdmoPxy
         97Vt4zDVVadYlOoca0aCeaid0BBXZ++GHamE/xCtBidZDgQ1ZgW8AHC2iM+wahXRGk1H
         4FeHAp58jxso4I8OfnszA7fKNXFRqg1UFv0ujYPzMLl1t8CZZMmrsdGil9l8sx7n/Ciz
         g3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV48eMbRL1jlh68GEMOY/WT1VFC++Dp6hLC6h26B7SUHI4T+BiUgVsV5pMbhjI1T354oXPG6Opm77he@vger.kernel.org, AJvYcCWcFp4gcsFiSCZd7VBa0eX3IAnNwPUPN9B6tZWBzF8WITmXP9tnmxcpIVOA6/wM7wVi7zXJTtE27nY/Sck=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGhChz7CdX7TFSaUFM72md+kf5rFUF1kAzJLtNFCG/EEoXxqG
	M8TC6fA/E4zYqY12OC0WEwiKm0nL1PUiY1bSIPHkFiQgg0hrZyKM
X-Google-Smtp-Source: AGHT+IFtAzwYm8z4tBSxUndNMddatVmlI7wJjSRNkQRBia7HLCtsla+2ptRdtvUXOR7VYYQ9B0v2DA==
X-Received: by 2002:a17:902:ef48:b0:205:8cde:34c3 with SMTP id d9443c01a7336-208d8423fdamr170755805ad.54.1727083590721;
        Mon, 23 Sep 2024 02:26:30 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da8c9sm130427475ad.17.2024.09.23.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 02:26:30 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: typec: tipd: Fix dereferencing freed memory 'fw in core.c
Date: Mon, 23 Sep 2024 09:26:24 +0000
Message-ID: <20240923092625.2673-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported dereferencing freed memory 'fw' in tps6598x_apply_patch().

Invoking relrease_firmware(fw) just after checking ret.

Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v2:
 - Updated patch subject.
 - Updated patch description.
 - Added Fixes tag.
v1: 
 drivers/usb/typec/tipd/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ea768b19a7f1..70bf8023ea35 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1191,12 +1191,13 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 	dev_info(tps->dev, "Firmware update succeeded\n");
 
 release_fw:
-	release_firmware(fw);
 	if (ret) {
 		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
 			firmware_name, fw->size);
 	}
 
+	relrease_firmware(fw);
+
 	return ret;
 };
 
-- 
2.43.0


