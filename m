Return-Path: <linux-kernel+bounces-531156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D73A43CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061397A3A35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE0267AEA;
	Tue, 25 Feb 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GOLogiGy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6D205502
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481380; cv=none; b=QCKDu+JwEKYdxiPy+US0IwXHxdHsKMl1kyWyF/2TLhYtEBIhQrvCnAVRDy9ezRCSPnxPrmz2iS5/3QzKpaUBYDvvRqr6kOI73r2YRtM+ML6LCE74YT8+u15FoGrAIUHEwJ3JTxhIZAu5sMFvxaaKO0SG8z7LEISiKOeJalXrOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481380; c=relaxed/simple;
	bh=gQc+M1MxzMAK4raon5GNtplgYSMzzyLfAB8UOS9YtMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP1w4jPurQ7NFA1nfuWU9b24AuGC94b26L/64jOXxxMs9VipbGWIBRqvWNez3q3AM2In4u4x3qYEz2is/8g6QR8h8sGEew6h5GNkn0rDLQwQP+oc8KfpfxayCdQy+MEXKgyO1t0hzPEFid1R1TDBxDTyE2/iq2XYwbtYYMcJPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GOLogiGy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so3182952f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481376; x=1741086176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyShyny9G2/yY7DkjMFQ2r6rzy1CSrizU536iAKhGig=;
        b=GOLogiGyWvjTaJcyC7f6K0r5ZP9Mb8CFXnYuEN/xjq2YpZhOd8sc+I2Zw9h6vSwuR0
         ZQBdgV+cGtoZe55K2jGhTsPTyFvYpiBbs3vB+wpa6f23OQ6qDHQ6kd3bPzjMg4HM/ZWP
         8F7UmYi5Ef/0VwI1ElmOMN19FY0Dj3WWHvBid2Tu7xwHaMorPxIEvHTJeZIubiJFipEp
         sXqEAxa/ymuT4dYYbuJvf8clH13U2ggpInsxz8XxcuABqvkBQiVTLnt9v5ofkSQbxA0G
         XLYrUhty4pWn5UjONMjugI2hREyDiHQ8TmSgczhn3OJKr8Z2PC3wH+z6o2KBwP/7PAGW
         /zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481376; x=1741086176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyShyny9G2/yY7DkjMFQ2r6rzy1CSrizU536iAKhGig=;
        b=rN+lb5j/hmiVEHzCJGa88oCTF9iKZA9RS6bbhR8Ya4XVhcmJWbWUvcT4DcuRV3usNr
         4bSaBn+uSTiVypcd9M3UuK+OaoaUPzRyPjil+DNyc9goQag5g/oEUSWNeTR0ctUh/Ttd
         y7IKCGX293OICwW/PWczpTpuim9QzQ0XGhUiPd8FWVDrIbAKDs1HduuhU7bFLn2FZ1WP
         Jm792PngfCXG3Qo+jb137LnyN7tx6GuJnAbwKuR5kOkcwt/xRgW9beop04uYQaxzuu9f
         q6rmjcWM4kZMzFVB1xKwB77VP8K5iWrDeaO/HZLFS+MU24hoEKj91gsiQU7f3Bil1AIX
         pj+g==
X-Forwarded-Encrypted: i=1; AJvYcCVXjVWkl73CithoHmHUnLk+pWneHt4K8UbaRL6PYlONbengRd7RW/t1mmCvi48/n4YtITzS/HptpLs8htk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrp0bGHTa/vOH8jAajtOtW6Uq2F7/1pUwq+L3/u43uXYdyiEL
	Tod1YOFSb3tiKxapCvM8/6b/n38Wf6FiX8veKcqJVVpV3g9JQDngzvt1su7UW7A=
X-Gm-Gg: ASbGncuSs86/0Q5FnMyGiO19j5kz7+1Y1oNKfwaL+G2cjaH9Cja31Q7pl7rrvEtB9Po
	DDqeVaEWKxxWUWKYB1+/89u5udC/5WsRaomrcajVLwkEG901nX7wsVjn1jf0rxhtLi1Jmh1t/VK
	Un1/c6bInIZSJX0nKCUwXiju8s8npXWcqamRa+oVu5kIXb1Lang4pH0dZo0eCOcWhRzfXlvZA9x
	IZqMVQC6c6pDiTO4ndcla1PakqhkjhUgYk/nPqdlRx/7ex/sgs/P8vdSJnb+8qeq3xnAhmoGirz
	v/v8lOf2kKUQPRpGyFxNmN+T3L8xZuZLd26vAMf1/3XjRXCq5rg0Hgo=
X-Google-Smtp-Source: AGHT+IHGZ6gHlw9kSoahDWlxrbg/CLJ26q2dMB3XznLEbdWlGW9T87Nbkw4gSgN5rUEuHOYL93HXMQ==
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id ffacd0b85a97d-390cc60a682mr2129316f8f.29.1740481376531;
        Tue, 25 Feb 2025 03:02:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532dccsm21972385e9.7.2025.02.25.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:02:56 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] usb: renesas_usbhs: Call clk_put()
Date: Tue, 25 Feb 2025 13:02:46 +0200
Message-ID: <20250225110248.870417-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Clocks acquired with of_clk_get() need to be freed with clk_put(). Call
clk_put() on priv->clks[0] on error path.

Fixes: 3df0e240caba ("usb: renesas_usbhs: Add multiple clocks management")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/usb/renesas_usbhs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 935fc496fe94..6c7857b66a21 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
-- 
2.43.0


