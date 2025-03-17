Return-Path: <linux-kernel+bounces-563355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C02A63F76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4714189022C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49782192FC;
	Mon, 17 Mar 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvClAWsS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78202192E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188806; cv=none; b=tmVh2v4cl7v1TV1ZqWC9UWAXTZ3ZoPCIVsBjyNV++JnbvC1iY6qzvrOck1Etxak+nwNyj8fqq9RrLfjfj5lzqr+E3sodwqO49ZsaKvLbWfFb/RSWsFKj2+wEJDmlbdxBQSTT2P+GQcMkPhkVVQRFNQJkx8Jbo26FZeZ5W5LKYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188806; c=relaxed/simple;
	bh=tm73wRGCtj2/+L15dF+oTxK0gYdTwD/VikeDQ7qKsDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Leuc3RpER+YMB80AR1mX5LvOjt05L1rlUgImt417KydJJsoOjzfOU4usdgKulRuNymCrMOV83FxLfC0KFwXqE9/k3n2nKClYDNWZc5w7NXcel5ZKjOCWheoiGEN6S3/COBPdNVACvlsLtQuvU910t4CfAOjSBwR7u41RpAMd2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvClAWsS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2235189adaeso65345565ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188804; x=1742793604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T18/LmksYiI2JDaALAx8F0tVbVplhY6o09bZJuKtckw=;
        b=GvClAWsSw/rNg49bQnvwPu6Ie2pEjLVHRSWGEHjZJzSkm0FT1/39eroeDB0FyrR+Y5
         JX4k7I8BuZsHN2dAE0rGB5ysXVfLWftF0WttrKc1w86jU/r8JA1kRiKvUPF3OBcKq/gI
         fBvzU9mwyb/1hDfnS+CLNKbLdRAj6/VaCs4lKqaG6h8+JGIR25IX3d85P/VRENC1v/AE
         j+oxIz6M9buklO8M39R0d6ik7f42k9+R0/jIVCHiL+fJU5h68xD+4zO53pNS+lLvDOvG
         MgMuUwOR+g3iRPo+tmPd2gzoQfD6Qa/1inqV/Q2w/w0Ob5soHyxNFZX+8yD95/zbiNhx
         UUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188804; x=1742793604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T18/LmksYiI2JDaALAx8F0tVbVplhY6o09bZJuKtckw=;
        b=UTU/7pv/XsrvyvQCbInKPirhHAN1CFdefSWR7B1GZB1HmvlfuDDI9cvA7xFpe205uA
         k8B89b5Gdr9F3cVUbIK8U0lBva42mZScg1u0/oXegfnJolqJPKdKfxetogCUy+PjjAwF
         wD8MZrdBhdIp03xxdLSOgXO9TSXS0kTjaDb3s/PpbN7lKofZT8t1oYtgJUIPYO6W8BCp
         D7Ari5Nl0U/GnHwD9ZiEqSQf+t8gQeiM9+GqIjqUSDW2zrNcAP/tSIwwFdRHj0yfRzfg
         lX0YTGZdFTxn1Juy5P4iEcIFxFPPvv+iuz9syBrEs0NQ8b0LEdhvDRfcjpGnLrKMdSLp
         918w==
X-Gm-Message-State: AOJu0YxwdfIwMUrMb0Qh6m0/WonB1fJnvKRxaD+/WrQkOBbX+6GPy8xk
	vHY64/XZdunPsk5QPYx2/PYsFOkVZMxX+rMj9kxHP/JlAOnS/Wsy
X-Gm-Gg: ASbGncuytsDvYHe8xVZfJCaMX3tlPah7yOYciZbi/tD4Tn5a9DP7rKTdCoB6rocbqxH
	YFQnM7t+ECbQPaQBkMJR61ScfS/AtZZBfntrftjLnZYs6ISpAWvG0PlKkKzCmY1ruFbmS3PWITN
	uC0T/AvwdSGdynlXlUFHxrkQ1aMmVPkPUQr7ftSPyUGo5pscyVhzREbAqLvVzsGm5fEH3wntNis
	rzZX47UXOyzC+XGMku+BwXvOlOfs6JztZa0V20h5P/VIEi20QtwbASJ6KpUxlMELJ/gkkJe8IR1
	aBFhM/3gB+2NFGYt9OfdwXl8LBRyyEirir6cX0oqhVTSZEpLIqtkfvg=
X-Google-Smtp-Source: AGHT+IFAseff1yIkZHzc1rGdhQPKl7uycYfsnTrI/GVu4JilKm2nddWrecFI4sABECPAMNZYRmECeA==
X-Received: by 2002:a17:903:41d0:b0:220:fe36:650c with SMTP id d9443c01a7336-225e1782e22mr164178955ad.23.1742188803960;
        Sun, 16 Mar 2025 22:20:03 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm66029975ad.149.2025.03.16.22.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:20:03 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 3/3] i3c: master: svc: Fix missing STOP for master request
Date: Mon, 17 Mar 2025 13:19:51 +0800
Message-Id: <20250317051951.3065011-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317051951.3065011-1-yschu@nuvoton.com>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The controller driver nacked the master request but didn't emit a
STOP to end the transaction. The driver shall refuse the unsupported
requests and return the controller state to IDLE by emitting a STOP.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 57b9dec6b5a8..e0cd3ce28b7f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -592,6 +592,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.34.1


