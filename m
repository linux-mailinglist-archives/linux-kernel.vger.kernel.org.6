Return-Path: <linux-kernel+bounces-523037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13CA3D133
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7334A188CE16
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5C1E7C08;
	Thu, 20 Feb 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTIV3Jpa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE071E25FA;
	Thu, 20 Feb 2025 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031882; cv=none; b=Ooz0B8sx36Hq/qhrHfkTv79nOcAs6+OvJ2XHdBzfrkqlXpu7JKzuZYVDNNWMoLDgU3GlaS7Lp5u7Ihq6u4Kznf8O9hozcXQ9STAgImzrGFbd+9gGQsKSw94RAOHIHwt2E5fXhvELDlhvPa8lV6ei5ZHtUNi8FwtLL+5rePhcFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031882; c=relaxed/simple;
	bh=zKY0RPinE6Is/VtilEnqPd6rIm2aGTxiz+O6yjvOxdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Goyktefd5r9UnFbQlwAvF0+ksU9+QRyVzk6jHrPLnQXttAwwVnlmKBjpIULbJAlmgtjCKNmHHgNqwx6sSD+hCnvpVE2TO3tGbv1axzM68os1I2/+lky95LfSA/qqrm/kcPbEX9d2Fl8JhdxztBgbg1elzWQ3g1EKUGPl+PjCDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTIV3Jpa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22104c4de96so7611775ad.3;
        Wed, 19 Feb 2025 22:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031880; x=1740636680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jyCgdWDKnjZQEA9Y1qdWuHJCZbETxV6ANCbypcoIhQ=;
        b=cTIV3Jpa6lRAdbPDRq62N/j+6NNgYehHPexlskArN6Bw+sPZPCRIQqwIG04/XHbT84
         0NRXyEDI5nzEsSL97AqFbnGDjdKtWR951xGTAtalTGmX6FfFiVq2tL5RM899kIW6Hqum
         dhu2YdWnuXRcgmwcPPu42JhSylqVZxsxY4vAMAnw7ywUv9ew5VcZIfYvU/OO2GY8aJRZ
         hmxuCimCxAgYtZ/Pp06dFGbmVvtu0E+bcfzGZu65ldPqSfO5c7iib2RDFyc+JxuSD+oY
         BJAPjZkVlOhMKn37ZkKVo8DccIvY5Mq/kG3zUl9x5cNuuSfr+3assuz5o+2ClaFxdWen
         F/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031880; x=1740636680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jyCgdWDKnjZQEA9Y1qdWuHJCZbETxV6ANCbypcoIhQ=;
        b=nK0LRdFrwFKr/Q+fQIGOtrnmntzLRq1Wg0RRM/fBNqrOA9zBgvbcdYV98UvNZASDwh
         eX+dPlTwiK19BnBthF8P7rcZu5sQgo5N04l7xixg/JsLXGGeJacAnHFW6Q5eDY7cl5lV
         1kcfmqVzlqLHGPl3dqf3NFLai7G7+pZK6VqD7P7hCdgnOxTEDg0Ro7dA0J1il9u6hHmr
         Jats6VosofrF8FAH17koXGM5C085NlZGfkKOBPjx3KPtASaOheLTqvpYeyXzW+CQQUED
         ST2xNmyDiUA9TBxT76WJo0yyzSf5sVVcFylFOcHVZOdgrW9RgYw0x06QRGULwcnuYjjG
         qDZA==
X-Forwarded-Encrypted: i=1; AJvYcCWAMQdxWkte9dtIxQvmmzeYAQpW5gk6oYliwfMBHOD8yRli2YmaZNwGlJpLWR0uOXTxqTs0826f5Mga@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaB5kg3QtWtGJgHfxL+dZsFz9cOhQeOL3+vPXUB6RUcX4A4w4
	6bksSpYXtSkogsP6cpK3xVbQm1OuFzXkek2z8iPWNR+uB3TrzXLjI5LSfA==
X-Gm-Gg: ASbGncvKQGSXgKxpt1alubGzRDWdODoeLZGxXMS0LpL6TJKwwzIDi6FibMAdgZ3hT+p
	hWLfbuWGeWKLYayj6O5PZgBZevN3uNJxqWDo2IAylP+OESavECsnLHULh6XOjVTQWTEtr3YSgwW
	WYWFcs0WOBK5RkqnueXe9x3CeWGFK+sBeSNjXcANKQfYQSSIsUChIqEvgir1gYRw6wnDAqT436h
	hngZYvGE5OnKH0A+J6Ox4Uls1JZs+LWnJFsosBYhXheRGHKkyVApUOaYrgXv8dS81mfHSZsyZHA
	TQjfXcNtFIXBduixD58Q67WlXA==
X-Google-Smtp-Source: AGHT+IGobtb4ADu1SMowtReLDdqa/0G20bTrsNjtMYphroDuWxjEnuqenicfClU6Q1Oum3yt+48EaQ==
X-Received: by 2002:a05:6a00:4f95:b0:730:794e:7aca with SMTP id d2e1a72fcca58-732618c1c26mr33817817b3a.16.1740031880466;
        Wed, 19 Feb 2025 22:11:20 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8226823b3a.107.2025.02.19.22.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:11:20 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH RESEND v2 3/4] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Thu, 20 Feb 2025 14:11:06 +0800
Message-Id: <20250220061107.1718239-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061107.1718239-1-yschu@nuvoton.com>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but the
first transmitted data bit may have the wrong value.
Fill the FIFO in advance to prevent FIFO from becoming empty.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c58440061d5a..2140da3f5187 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1196,8 +1196,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 	return offset;
 }
 
-static int svc_i3c_master_write(struct svc_i3c_master *master,
-				const u8 *out, unsigned int len)
+static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
+				unsigned int len, bool last)
 {
 	int offset = 0, ret;
 	u32 mdctrl;
@@ -1214,7 +1214,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 		 * The last byte to be sent over the bus must either have the
 		 * "end" bit set or be written in MWDATABE.
 		 */
-		if (likely(offset < (len - 1)))
+		if (likely(offset < (len - 1)) || !last)
 			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
 		else
 			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
@@ -1245,6 +1245,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
 
+		if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+			unsigned int len = xfer_len;
+
+			if (xfer_len > SVC_I3C_FIFO_SIZE)
+				len = SVC_I3C_FIFO_SIZE;
+			ret = svc_i3c_master_write(master, out, len,
+						   xfer_len <= SVC_I3C_FIFO_SIZE);
+			if (ret < 0)
+				goto emit_stop;
+			xfer_len -= len;
+			out += len;
+		}
+
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
 		if (ret)
@@ -1306,7 +1319,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-		ret = svc_i3c_master_write(master, out, xfer_len);
+		ret = svc_i3c_master_write(master, out, xfer_len, true);
 	if (ret < 0)
 		goto emit_stop;
 
@@ -1333,6 +1346,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
-- 
2.34.1


