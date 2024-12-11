Return-Path: <linux-kernel+bounces-441564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA59ED01F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3486286E73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EE1D7982;
	Wed, 11 Dec 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIDyKe+x"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EF1A4F22;
	Wed, 11 Dec 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931775; cv=none; b=Bo42SDVn/IwZ8hksXJMbiSdmxpOyKVDqQNzKRSRnKPZEJ+jeTcgmQTOwUy0SoZN0QdJPTWHjKafChgsBLE3F9vlZONYjsy8jXyyh4iK7/8Yb9ZVTz1vcvoKR/nCxfWJ+JtaYejRmAtXcWkLkfvOBbkBUxuIH1QEPwU895CGalJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931775; c=relaxed/simple;
	bh=bqxLJhYbzNRKK3bLRKJZKB0qQ6RBOAJc7oMGKNvLx/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiI4mZnLENF91SzCc/NbN3uU9ePQ2c8wAtc+zKMXYwE1scZXemNvvMpyQQTppe1dKJZbMbtErI1C/yMT0fBZTnXt8zfK9jBAIF/25tkqC2rlFi5A+xW0cX+dNMHucg96DJA1vipyPrGd/u48cddqYzLF/ooFs5xU2G2N7e+dGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIDyKe+x; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so3009532b3a.3;
        Wed, 11 Dec 2024 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931773; x=1734536573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KGUBHhnjd4qnZbrqeKDUHVXWr9PSgc+9d3ztnbFx1Q=;
        b=aIDyKe+x3oiM4GO00Jy5fxGkrXTi4TLfRnnlFWAqT5UVmX1xhhss290gphKLGkdYF7
         HWF0QGIn/GZ1JrZSv7JeTTrWCVhJI2r2Pf47kZazXXMqMtj0DaoMx09XavVDSYHuqSqX
         qeiFVQlmxy7M2gho6hprHX7AGfKdMaWU/AOHXryusQMAsGzaaZhbcrBFKmEciJVTbm86
         fyya8sJw1SPSTgcW4GlBRLHHUZ5iTErC9WwPKiABZ7H9UlCUQfpf9bogGL+CcR9DrIIS
         Ft6GABSwBhf6jDzllp+aA/WGlowguO5FF8iAZs5A+HIcZKK603BYaHDbx6xaRWN3+Ui7
         3SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931773; x=1734536573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KGUBHhnjd4qnZbrqeKDUHVXWr9PSgc+9d3ztnbFx1Q=;
        b=SIcDch0ohaPR+5w48EocrsUv2GfPPEBL0xRRAUuOJF2Rp3m/97P0l9ZTzOLj/RnpP2
         d9R1IB5rJQBNAhu1Ortq+No8HcTqwC7344eJqihyz0Ze6PSIoQqNKaCNPWhbhheDmxmz
         EYKTohFqYIZqQfV7TGXvkiVj9ks/89BoJh3hQTY7Hu7wFe6S7ErqxjriwQwmDUG1Ysjk
         fweMMSRHPJBzu/dU1TU2FowxiJZHsHKF/FklUHnBVeNm2Xbt0dpFlTO0hP+xK7QAVUpZ
         9wjV+kTch/9eohKFGzCwwubOrrCCW9Y+FokG20XTW2/pk4bhFWHLKFPbIr7kRANfTSKV
         E8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWJsLaW1NE488GuwzGoHglG+mNoLS8F4NNhb/mLig0p1mIomL0i7zknvUpmXzBdAeml+zjLU6O94DiVr8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaCcEmfLlox99RnHhs9PP6B+Nd7IfxnnaGkrPUJ393Ocldxua
	XebaK348+SPIsPRPZX6SlK966nMp2Ts5fnEsRxdop/6obPwTf+ZJ
X-Gm-Gg: ASbGncvsDEM+LF1FHxN6RN6qBXOGUWrZ5neLFAsboCOtQW91y4ApTDa55dR56BBUCTS
	d704RH0bmCYgP680zm6frS5xgYJ81uiafYazfZrvAVCqEwKGemCQ69DNVwgN1c0VYsvEnwqSmw3
	Jremi/ucwiIY9UmnvgLcZjHkFCTDnVuwKbTdutlN5AU1FD3abvXVVeMbONb8J11gGWJewphL6Ks
	GVHUWGlgYlLALuTDrUpEZMISWn7jCCIs/mPLkTqJM4WCy1nqxh4syejqTbr
X-Google-Smtp-Source: AGHT+IEUb0DKqm4b9cYTHkFv6h0rig/UszCq/5k8YedaAlPTW+Qqx4IIOUIa8BCQ1Pz45Y3XDdPhlw==
X-Received: by 2002:a05:6a20:728f:b0:1db:ffb9:f359 with SMTP id adf61e73a8af0-1e1cdaa3c3bmr622295637.24.1733931773118;
        Wed, 11 Dec 2024 07:42:53 -0800 (PST)
Received: from arch.localdomain ([118.107.9.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-728957aaf22sm3543346b3a.128.2024.12.11.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:42:52 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: gregkh@linuxfoundation.org,
	zaitcev@redhat.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@jeremyfiggins.com,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH] USB: usblp: return error when setting unsupported protocol
Date: Wed, 11 Dec 2024 23:42:43 +0800
Message-ID: <20241211154244.534745-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the regression introduced by commit d8c6edfa3f4e ("USB:
usblp: don't call usb_set_interface if there's a single alt"),
which causes that unsupported protocols can also be set via
ioctl when the num_altsetting of the device is 0.

Move the check for protocol support to the earlier stage.

Fixes: d8c6edfa3f4e ("USB: usblp: don't call usb_set_interface if there's a single alt")
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/usb/class/usblp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 5a2e43331064..ff1a941fd2ed 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1337,11 +1337,12 @@ static int usblp_set_protocol(struct usblp *usblp, int protocol)
 	if (protocol < USBLP_FIRST_PROTOCOL || protocol > USBLP_LAST_PROTOCOL)
 		return -EINVAL;
 
+	alts = usblp->protocol[protocol].alt_setting;
+	if (alts < 0)
+		return -EINVAL;
+
 	/* Don't unnecessarily set the interface if there's a single alt. */
 	if (usblp->intf->num_altsetting > 1) {
-		alts = usblp->protocol[protocol].alt_setting;
-		if (alts < 0)
-			return -EINVAL;
 		r = usb_set_interface(usblp->dev, usblp->ifnum, alts);
 		if (r < 0) {
 			printk(KERN_ERR "usblp: can't set desired altsetting %d on interface %d\n",
-- 
2.47.1


