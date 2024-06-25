Return-Path: <linux-kernel+bounces-228313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD81915E08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A21B22451
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A331442F6;
	Tue, 25 Jun 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcMV9OND"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72F143890;
	Tue, 25 Jun 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292414; cv=none; b=RC/eLUfRoPvu3TssCns2Ul+oYjiPYvGJXuiRwG5eo0+xDHPEPOfr51Gt4xvIgpABBwQQw7N0xQknsDOdtuoJQsU87L+EGck8ILFsXzKl2zv2MECJ1OgTigE29oTJ7NpG9p7l8mqgsttEbGCN7zhyGBRKrIcBq18zGGw5ojFRoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292414; c=relaxed/simple;
	bh=Q9aGYIPCuMwlU4N9dfgFAvA2v0LYahldotocCyc3UJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDj03XM/lc40Ar9VYVwqDEANG/qvYrR/yzR/41q+7s9RgHVFcZ794vMOcES6N5KRnf0GBAaZs7wa835jdFjEcDnqvlr+bN4zJj/HtuqgP1+6VaEoFHce5ZSSvE3a3Xe5fXeH7pRQPCFbSUxL7mucnQUq2I1x//WMAObOBI0gkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcMV9OND; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa78306796so79845ad.3;
        Mon, 24 Jun 2024 22:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719292412; x=1719897212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3gUea5Aoffm179ncuYMoNOKtj3N5DPxd+0seKo+VGk=;
        b=TcMV9ONDSgEMfCSoDF89EE0ExlmIOs5ySmh1j5Y1YbEICAneS8pHZcrcDUkFRpRn8U
         owo0m3fnZlwTBpG3gvzqyy5/8UISkLWdvtARMHXsh5zhQ9X3/dRx8Tcfd1hCMBYffsAP
         kARYYeAdjWEhPGxqOGVovF0/3ltNVtlJTE3AHU68r6cJQrOdVK0OMj0wnZByxIofOojg
         iDXiQ/mqb9HrIIXdFiv1kOfQ+INUZyt3/IrqGHuJtQAQmb5fh0Mf6IngxXlwbWeZJJ2z
         vn2X9h+n72MNi5+yM+14M9K1hS7Zrs0SU47siYZmYJy1K/kVMMWJsl9iDHEm6NLWgYQk
         jTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719292412; x=1719897212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3gUea5Aoffm179ncuYMoNOKtj3N5DPxd+0seKo+VGk=;
        b=jLmUmrws1kz67plrS2uTHEXxgHroHP9cs2qjKaZXX3hxbc2qO06Yv6z42Tl2OMybt0
         SkV4UsF2vc/mHQDaGfTtghnF5ZIxvJppka70NZju6H+ShGE1PWU8K0w+wipJVxISJKPC
         MDE7DRZqrgXyFX8HsWj0B+o7eK8fa2PTXZzPBEq+a0TlzrRqque9bPcg+bE+EnIiKWUK
         KSQAwLhxt+kdX2l5KH8W+CKFQfr1rWS5X7k7BoP2K2NWGrLjV3Kxv+itVQPmKSp+sWgV
         0AHfLwjbUXX8RD0Thup/zHuCCDEKIPmYl3Ag62+oRV0I2CHX2A5LUk2mmjwhDZEovGar
         X8eg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsKzAubpwIRJDqyuRcLc+bkoHYe92YR1t9eXDrd1Q9t/NY1vizeBlLllgFVXgnxCeBHdyeOYrsi94U/j9WDdsIyi2P6MMw6kF90EOdanCYSeBrbnZH+GAu/1/4d4NPCIXRpC7ZHCR
X-Gm-Message-State: AOJu0Yx7un59UwRihqJ/RsMmOkJ7E0Yj4zTaQJ0Upr/adUr3eCFzPgHn
	/Bb1L4JrArWs1ofCV4/4ouJjlHUjV+ZmH/mc6nHRxkNPYBNVss1A
X-Google-Smtp-Source: AGHT+IEZbkIVg7DFlcKvBMX0AEM9rSF9hJOREpYypR14dVygVdoD2R0ctSMh2O3mMx7aivr08bajpA==
X-Received: by 2002:a17:903:230f:b0:1f7:2135:ce6d with SMTP id d9443c01a7336-1fa1d4d9bdcmr82340015ad.18.1719292411829;
        Mon, 24 Jun 2024 22:13:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-95-11-209.ap-northeast-1.compute.amazonaws.com. [54.95.11.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7003sm71531175ad.295.2024.06.24.22.13.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 22:13:31 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] usb/usbip: remove unnecessary code
Date: Tue, 25 Jun 2024 13:13:21 +0800
Message-Id: <20240625051321.63761-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both if branches assign a value to the `cmd` variable.
We can remove the cmd variable and use `pdu->base.command` directly.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 drivers/usb/usbip/usbip_common.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da125..74a01a265 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -568,17 +568,9 @@ static void correct_endian_ret_unlink(struct usbip_header_ret_unlink *pdu,
 
 void usbip_header_correct_endian(struct usbip_header *pdu, int send)
 {
-	__u32 cmd = 0;
-
-	if (send)
-		cmd = pdu->base.command;
-
 	correct_endian_basic(&pdu->base, send);
 
-	if (!send)
-		cmd = pdu->base.command;
-
-	switch (cmd) {
+	switch (pdu->base.command) {
 	case USBIP_CMD_SUBMIT:
 		correct_endian_cmd_submit(&pdu->u.cmd_submit, send);
 		break;
-- 
2.34.1


