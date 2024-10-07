Return-Path: <linux-kernel+bounces-354305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C05993B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA01F230BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580C6AA1;
	Tue,  8 Oct 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="AJaihXU3"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABD382
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345810; cv=none; b=LoWEqI7+p7DPVy5AghGqIfuz06Il/XaGFNOGtwN99O2RsXw5gHu7T7X4y6ZyVVrj6NL8w6cgHTabjgkv/S1985qd9d+u25TCkGDu6jh1tv0h4d57sZ+Teua0wcGpr0SZPeI6Xbu2yE84DE/2B8BLdL6Ub+QR/8BvGY6aGPIOkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345810; c=relaxed/simple;
	bh=v/cGjRKPEtXmv7RwDeyzOSBu/wmVaWL2ZuBnO42bLf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lm7G26293TAbEoUHo7+3P8XG63gUNDvKU+ZUI5BfyhPjtUfEWq8vJpgNHYg3WH742i4Euqry9TsfKjny3Cp9FnLtl2bW9hUke0ljMBJImq2iBTIocEoYr0C364/1LYNNmOHQo9jXeSyEvX+oJvwdyFw0ZuMdfRhXjFvUvF9ol40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=AJaihXU3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so53640686d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 17:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728345807; x=1728950607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUhSEJ0yAaeMQ5+BVSRaapV0sFetukkSF95MlT02JR4=;
        b=AJaihXU3hl1mR+ywM7s4r6oByM0BQgArnjAk3i+CnTU47w0hIYmKtyCD9mlzd0+PF3
         D/CbI52KSpx2weCNeJ06HWdBLnQid8BYkBnuJJarzo587M5sSfgUT0GegHkHWt7yk29d
         EnWglgIXffkjmK33zQPqHdsKtfiTtHl3n9Aof0Cw33zMIQJ37YdfLTO0PEgH0zDnYncP
         dZIehlt92SBzHC4mBzwYrIKrAVfgTziXaIlPgjWJDJ1qABm2aU/KC/bHrER2jP1VhqES
         MTxpMnnzW1TOTfShcmpd24EWqBc/K0R5r4Z57wIoFnl3Xx08EfrJlIIFtgknRTPBKGKb
         UafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728345807; x=1728950607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUhSEJ0yAaeMQ5+BVSRaapV0sFetukkSF95MlT02JR4=;
        b=E8bwbjA4WO5fMmRDkjZqvwwLfgmxk2t2cfJfU6UCibMjxVXiKAqLntN6tHyEvGzuI/
         Z+RsoJxlViaDzsVU3bjqQh+aqrdh3w3e6CMwQBdDdKcT0diWi2lRtsn2RZ6e+pSEWnj+
         nwQB99RuhkQdUfiaiJ0VWt/VHT/jIqczG2Ps/dsnuRNUTzOCrqqJV2F5tQ9cwCwPbybU
         PJAObWroeC3dygBpDEvm68Wgocucufr/I3eJ2LwUAVKPwI8jyPi0QvaPnPNyesd0zgKZ
         Cs8+jGTy6ck/Vt7wXYe7ezXExopdUtA3alJb4/cOfZUDlmW+xwtz1lSkXvzVt3PgetiA
         eC4w==
X-Forwarded-Encrypted: i=1; AJvYcCXZIRp68mOMtK1n+wZWMpfV0at0kRI88/LtaQim50NmvG2NbLu9ODrinHO9HykHdVFPLlWrpmV6gCT44fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxjk8s4nfZlzFFHFQOq2s++X/Gw99P6gKv4HSmPvnMwYl2Vy6J
	IZBDfdoCl3rD+5D2BBOjSwF6DX2b+yLe0vHJ80zdw11Aa+Qu0PBNXU+YsYhUtgE=
X-Google-Smtp-Source: AGHT+IEx3bklsQStYmee6ZmH3DEMApP2qVX1WSbpsnNhNBWyboJaq2oNlhHvvvoCROpV/zglNNL0Ew==
X-Received: by 2002:a05:6214:3386:b0:6c5:8ab0:60cc with SMTP id 6a1803df08f44-6cb9a472824mr193319236d6.40.1728345806863;
        Mon, 07 Oct 2024 17:03:26 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cad28sm30487096d6.18.2024.10.07.17.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:03:26 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length
Date: Mon,  7 Oct 2024 19:59:35 -0400
Message-ID: <20241007235935.6216-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name len field of the CMD_OPEN packet is only 16-bits and the upper
16-bits of "param2" are a different "prio" field, which can be nonzero in
certain situations, and CMD_OPEN packets can be unexpectedly dropped
because of this.

Fix this by masking out the upper 16 bits of param2.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/rpmsg/qcom_glink_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 0b2f290069080..b534b88db3f8e 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1204,7 +1204,8 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
 			ret = qcom_glink_rx_open_ack(glink, param1);
 			break;
 		case GLINK_CMD_OPEN:
-			ret = qcom_glink_rx_defer(glink, param2);
+			/* upper 16 bits of param2 are the "prio" field */
+			ret = qcom_glink_rx_defer(glink, param2 & 0xffff);
 			break;
 		case GLINK_CMD_TX_DATA:
 		case GLINK_CMD_TX_DATA_CONT:
-- 
2.45.1


