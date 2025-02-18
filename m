Return-Path: <linux-kernel+bounces-519414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2FA39C96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E814169CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813F263F5A;
	Tue, 18 Feb 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kj6KxWnu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A0264A64
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883460; cv=none; b=Ai7+evzUj/IUc+u+IW7OK9t+eTr1Ng4ZFeH2/bj4BA+pf29s99N/npHNzJlg1cwuXImcL+zl3fyTikLsON63BWRhpiS+VqMtHZV7iNHXewKLjsR42dILD14cg53c9pe8W59/o4S/Zd3ooCZmPohc7aVxyEuuoDIdnKhHW7txsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883460; c=relaxed/simple;
	bh=kyA/8Z1Zw+2QLjWBcOuMcus8AjU6fwuRtQzes92TK9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=saMI3TRUl7Ang8fPfHhqpnvp5j1EcntRSCywcOZ3qckl1BLgURzsJUXZMjLVcepZyBt50xHMmbaQq9D+Cq2pvikp5gwQEf+Y6Wpv46be8Sy/90xJK9tBZHaAq1QraFlOqeqU/rUF4KkQqRsxY1ka3FRTlYYWGuezJSw3z6YVUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kj6KxWnu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so13825615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739883456; x=1740488256; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyY3cdE11o2Hq1NrWpk3ftrZpWXzglM3zy/nv7F8T9g=;
        b=Kj6KxWnu46H2X/O+hwrEJM6tR9HktWL6AqIstt+cr32Ks1outeNe4ds74OdCSEKsqr
         isF1rHePmqihMHLCF9S2aZL90H4EbgVTf4L/xTAbCFIqNVwu0jDXN06wgx6lr7hwIP/l
         3vQx+fW4v/yF7upTh/DPqNQ9WScrM4H00cag92Y7KH9/YZceEDJBdjT1YaDBFUbfHfGT
         zKszgDFw4yRKdRu0OIozq8dkPwiU+qWyRtkCD8f8efaeK/cZ23O5giduRre6IdKycvLM
         +MZKKjIWSe9x11JvOlLOQfuY0SPpfLUzpe4/b5RhmV3LSN0s8eZ/oR3Uyw0rEKUaVU0E
         QCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883456; x=1740488256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyY3cdE11o2Hq1NrWpk3ftrZpWXzglM3zy/nv7F8T9g=;
        b=eas3Wj8Vo7e65gV32a9G8rG1CLKMpIkc2AOpLajuNyMSuVSrIo8hcesrRC1RnXg5zI
         E7GHZlNQnTxFOnRaPpm/WEJnY4cHI6JWY3W8et6Wye2vFpTuyLLbOVL5pvNQJnlurHVi
         6G7CkbKoB9Nt4LopLKbyWuFIZsqT17ZU4zAd4HbtH+FoRlqYdQQD7hayj4SEHlaWMJ0t
         I1jhdYtOi58gzJRtYlIbh4rJl69Z6Etiu49ytdc6LDb4Tz/XSh9lIEpzlHTRNa5ebmMi
         QLJvMMxUEsgega2EqE9LCAbqY9txkwBjap+1bzd8l8dDC89WMRbJurptjcsMnG4plCTV
         GmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1GxQoJmghhr2B7ttdJJYPUcq6ZS+rnixXkOmrhJt4A0sxf7yRLcLG8nE60VxaxSViuP38TN5i4EyM1uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7I2/EKUrrgZTluKE2MAVNWi6VPYKpixEwAWfR2D15YPduGEuj
	LI7t1/qvNcOVcGSzFpFOO11lafdhOVe6ND9u8V1hibkwlTuNkSnJknttlZqHHFo=
X-Gm-Gg: ASbGncudNR+kzIRCA1dCbFfq+h+yRjRYMnpcyBWahayp6m8Qq8cvEpFdt8oiRW5IsIi
	gM5wbjpWqoIW3c1zbIhUJEJbjQVp1Qw1b7iuWIhfloeIOQ2ioUqLcLdC3CsL6LB6BVaM7E94xhd
	J9loc2SpiUtLueBhL70hUdILkAQg2gB0CSZpTuOXtZ3Q53lBc1GERS8UQ1W0hbSarmsf+/OnJSg
	uMCFcOOklg5JfT08iIGVeze8cTcJUUxvELW0UtvBlq7yYPFtSOm1bFwvlBuooidcD/q/APgZGZJ
	yEKjiOBTHQPREgDuU9w=
X-Google-Smtp-Source: AGHT+IEtE+TYwufyBI6Y+xikUzOIEu3Qh2/mlCAbkWqlJNQx7IkfumfWZLkaerK2JUgf8XedhMemIw==
X-Received: by 2002:a05:600c:3b12:b0:439:96b2:e9b with SMTP id 5b1f17b1804b1-43996b212d9mr15246635e9.9.1739883455734;
        Tue, 18 Feb 2025 04:57:35 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:65d3:d915:ef89:ac43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm50009405e9.31.2025.02.18.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:57:35 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 18 Feb 2025 13:57:19 +0100
Subject: [PATCH] firmware: config: ti-sci: Default set to ARCH_K3 for the
 ti sci driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-ti-firmware-v1-1-7a23aacfb9d3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAK6DtGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ML3ZJM3bTMotzyxKJUXcMk82TzNBML01TTRCWgjoKi1LTMCrBp0bG
 1tQCUwUg4XQAAAA==
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Defaulting the build to ARCH_K3 for the TI SCI driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Link to comment done on last serie [1] we come back on first version of
series[2] to not use imply but set deps on ARCH_K3 in driver directly.
An other patch will be sent to update Kconfig.platform when this patch
is merged.

[1] https://lore.kernel.org/all/20250123-timodulemailboxsci-v4-1-b1a31b56f162@baylibre.com/
[2] https://lore.kernel.org/all/20221122202245.449198-4-nfrayer@baylibre.com/
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 9f35f69e0f9e..109abe063093 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -215,6 +215,7 @@ config SYSFB_SIMPLEFB
 config TI_SCI_PROTOCOL
 	tristate "TI System Control Interface (TISCI) Message Protocol"
 	depends on TI_MESSAGE_MANAGER
+	default ARCH_K3
 	help
 	  TI System Control Interface (TISCI) Message Protocol is used to manage
 	  compute systems such as ARM, DSP etc with the system controller in

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-ti-firmware-1b7c7f485e5a

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


