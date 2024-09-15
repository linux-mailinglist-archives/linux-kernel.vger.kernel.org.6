Return-Path: <linux-kernel+bounces-329696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEE9794C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A0F1F22171
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05B482EB;
	Sun, 15 Sep 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy6MAaAg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E22E401
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382464; cv=none; b=IxN3UgDjIY6BNrhoGJQIksB7iQirPt8gL3LQVvg3OvOOaWka50zdlXU1865im7UWPKd8dV8x/ftjRnJt7XJnjPVgVGxIaqrPD0b4ueuaxv/jXQQevkygXpXQBTt/ohBHsF0YRfXRZYrl7mzFPCAlU3F+X7/xx9bx0/emvYT4UnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382464; c=relaxed/simple;
	bh=pFBLKa7eakDbJQvDx5GAJvRveZklRB0mvRHkGxKzFik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YypMQNNwPEVqiDhAdi9UXkE+bbkYcKdSBOafvSaCxkC/NZrAlUMKoR4x0EtRqRAYbs6GdM9R8Px5wv901X1t153hGSb0SQRrDuHJNk3ZfonVVgD1Z8TsWls9zQLO98j8qsdV0Oca70gNlgTf4UPz11/d0dVcVXNgDEEmrr972bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy6MAaAg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so580724666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382461; x=1726987261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3O7884USr5rmr1eBEbAXs5vHrzE6NgETmRQZwaRy8Y=;
        b=fy6MAaAg6wZpySAAbwaB4kf53vkpI90QIWCliVwiPCUijtnPYXoxdpwMUK6yiC0Fdn
         aZkdiNK6oQcDB8AxnezeatK/pbTpzC3WHT3jycJMOUYBOYDnOeOk5LlyWIsMA9ofZA/R
         Ad64Wf+YGQ/F4iTPJXvOTNaCnWzohsqoaTMHSxRaqehehrwGlLfxKy8VO0rR+EwmGQBW
         KY80IJWv+cG0MKIXdDwK815QDuR43P67kBLOeJtd4+xaoSix52L9XiPS6ace5Erga0ij
         e62MuMh5t9a6Qfnuz9h4gQ/WK8urailOiHfaS4yQb1jbKlax/9NrOHKkIYEeuSZ6cAW5
         k7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382461; x=1726987261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3O7884USr5rmr1eBEbAXs5vHrzE6NgETmRQZwaRy8Y=;
        b=OJNbK35ep6IYDHtbdMm0x6bZd7YcL6RH6lZo43kbUQHeOLwDbrZSWHlImw+1mBZvj4
         DMNaWrNQX/h4ip/LcaeQlmhtAqpT9LOLTbDI+YkRfOdQzwCQuaJAQdBhOD9SxI8hYc/V
         N69O2eT97im7VgrZes82vkvwClg1Zo/olq2eBU0JnuzckFfBLnjeG6FvWh5oHDZ6I8k2
         oUCyLRdjtmQEUMB+ejxQpYoyf/8PsZ1UvchgPcqpjUT0JwaFaPSZHkHTep/hV+YWALzI
         8uRvzL83pCwpZLA24BBU9/Y6Lf29dd14NoSCT2e0MBAM21SNOO2S+/lmNa77a7nEH0yJ
         4dSA==
X-Forwarded-Encrypted: i=1; AJvYcCXBKue+7Uy4NgY+vJLcl/GDbc1ZXQZtGvkG+UnpwAcz81wpIu4t7O8JXSNgyZDsawPDS4iO9sgS7FbwNYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOvM8+uqMVYwKGUcAawqDGY1b3ac/uJ2TPeP96neoNTdh8NIb
	DV62vgqfQXhHtlapnc8oKkWboqcNT7HUtVRF8swoaQnTkNHMUt8f
X-Google-Smtp-Source: AGHT+IGh+yadhr3UkyNRuLvLdwbD/v4caveq+WJuFsXtJJ6X9ZV6hphCFtdTRejkbk9v8+tNXBexKg==
X-Received: by 2002:a17:907:f71b:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a902949ac77mr1180375466b.33.1726382460935;
        Sat, 14 Sep 2024 23:41:00 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:00 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 06/17] staging: rtl8723bs: Remove unused function _ReadCAM
Date: Sun, 15 Sep 2024 08:38:20 +0200
Message-ID: <f8ce4d176c2aa1d312183263658c4683a23a1e4c.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function _ReadCAM.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 4eee324385a3..9bef4b9e2aca 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -435,21 +435,6 @@ void invalidate_cam_all(struct adapter *padapter)
 	spin_unlock_bh(&cam_ctl->lock);
 }
 
-static u32 _ReadCAM(struct adapter *padapter, u32 addr)
-{
-	u32 count = 0, cmd;
-
-	cmd = CAM_POLLINIG | addr;
-	rtw_write32(padapter, RWCAM, cmd);
-
-	do {
-		if (0 == (rtw_read32(padapter, REG_CAMCMD) & CAM_POLLINIG))
-			break;
-	} while (count++ < 100);
-
-	return rtw_read32(padapter, REG_CAMREAD);
-}
-
 void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 {
 	unsigned int i, val, addr;
-- 
2.43.0


