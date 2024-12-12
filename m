Return-Path: <linux-kernel+bounces-443245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC99EE923
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD80F1669F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AEC223C7B;
	Thu, 12 Dec 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVZZjhwy"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749982210E4;
	Thu, 12 Dec 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014349; cv=none; b=axoY/xkzvA3kvqOJj0AIwTSFEMruKLAwbyDqAI3wfc89/8Xw2xSAqzpAO6FJgyWB/akD2sSizNgw0lQ2rLNPpi0vxB0Oc6XB/rdPkfi0XesbITvEkOxi/MXQbxiZyjLWnFwrj6sYf/OFK7huSsAJH8gCNfAjQerzjb4fFYkugu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014349; c=relaxed/simple;
	bh=F3NFcJVNBahppTx72+IvPeWkk84z9F6bfhgCRU8Rhws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsU/wdUk6eHK/Fg9CjwOqgT08tjp1PqjSuaSpdgG/k0NPhTaX34yudxunuz9hWtHIatcsO0Z/Cb8sn6gpuuwKhHzK9SuNUHJs1kHAUmnuO7hewLspAJ79Lvjh5C3v67xu4BfCd5svrr1tn5F2XxkbANLL0LQRrMBONNdQ61DZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVZZjhwy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21145812538so6804005ad.0;
        Thu, 12 Dec 2024 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734014345; x=1734619145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HyRvZmKwgHwaYC2S2C/r2CF0ULpN9j9Judu9YvPi9s=;
        b=eVZZjhwyGn2Fk0YKQkrP9nZ3Yj+xrY06NeN3C7gpd6e15A/92klvB8WMrWVxj1ZjZz
         KSBZqAdNsgGW1kJHcmetV4DTX26d1LWFOBLxiXm9zg8PC20h0t5C9B+0lsolbWOiprVL
         glXTDE5YckbUasaPTdkS3Z/zKDSrdiY5gCQR9dXNe8n9/UY6PBhf4fPhon8G12HGGv5O
         rD2ftF91snlbLpkWRXWhupbIfESK/1L+OjQTOoG5nbsLn5LNbuF+Io8y8oh2rp+YFuHE
         hhRll7USyTnxxZkTLWXkkzgdzSfPTsu0Nj+KG1TRwQ7QuorPwLEhm5DR8XuZKcqYPqUS
         NYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014345; x=1734619145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HyRvZmKwgHwaYC2S2C/r2CF0ULpN9j9Judu9YvPi9s=;
        b=ksY/cpQyEuU5aAbXCqHu31gXXfpzajFU4x4YMp/5cm2bu5qUPvApqUApGxHPX5mvIO
         3ZDpw1ZCxA636XzVzgBLLRecac+a5jNYUU3JQMa0inrrcjBCW3/ZQqCT253zV1kM/r/i
         oub5450vVjojXhmznnKiddV9eqmKe86KbheHqAgIlT5BeY9oUOeqD2SLUTeizZOuo0VU
         P8eV++yau1KnuA2M2MsW+feLgouZmeX7pDjYY0jmAYBwPavs4zdQJe65FDh95JjZRqgK
         WwSeYNF4kyY37CpmyS+RCe3LRPWjPcYoG2tYRRn7o3cn7b0m4LXyhzzmSvvb20ZbU5iS
         LcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv09FFXrPOZ+a2yoej88h+ljxcHYetPtRJA8/XV+rLw9c+w2685bZHvrocYI/+eT2KFcZUERq7jRaeWZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGhUlZhMcfX4MgaQiHwMiHcUXhcQXaeCVsb0YS9qftCCTbSGf
	5mO3ztoNBxUtruHj9fw1h0WyiQAMbazDJQe4iEqEPwfnqdD7ixke
X-Gm-Gg: ASbGncsxfZ12UPEu2mhOP7AdUpAxi4r92hAXQ7srheapaU/XLTsz5+2DefeXApBOUrb
	M6qGyhmjcKoV/IRL/5+8JCHtxJ02vxS2a8C5y14AnJr1V1odIL6uRj4eZDfQgZR1eksYjNh+tQU
	kxKa64R921iCH3GpYuuOVWV9YeJ5qxANvhkhpoK6OdX+tTntTBKTN589aT2GtuqD0wUPKjhG8mg
	SDz19DQEGD51C5mqyotLY0StsX2Miy/NuA789j4hUjjPrOm0SRQsD7QIoVLwd993rw=
X-Google-Smtp-Source: AGHT+IGsOPKBIjvvRJiex+JD96hn+/rDmKMaPtEImRUUt8pVDpd7d2lC7vFTq/OLgdkwVJ12UOvdsA==
X-Received: by 2002:a17:902:d491:b0:216:4b5a:998b with SMTP id d9443c01a7336-2178aeeffbbmr52144505ad.45.1734014344734;
        Thu, 12 Dec 2024 06:39:04 -0800 (PST)
Received: from arch.localdomain ([134.122.133.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f24esm124276125ad.83.2024.12.12.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:39:04 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: gregkh@linuxfoundation.org,
	zaitcev@redhat.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@jeremyfiggins.com,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2] USB: usblp: return error when setting unsupported protocol
Date: Thu, 12 Dec 2024 22:38:52 +0800
Message-ID: <20241212143852.671889-1-jerrysteve1101@gmail.com>
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
ioctl when the num_altsetting of the device is 1.

Move the check for protocol support to the earlier stage.

Fixes: d8c6edfa3f4e ("USB: usblp: don't call usb_set_interface if there's a single alt")
Cc: stable@vger.kernel.org
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

---
Changes in v2:
- add a line with Cc: stable@vger.kernel.org
- correct the typo in the commit message ("the num_altsetting of the device is 0." ->
  "the num_altsetting of the device is 1")
- Link to v1: https://lore.kernel.org/linux-usb/20241211154244.534745-1-jerrysteve1101@gmail.com/
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


