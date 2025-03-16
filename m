Return-Path: <linux-kernel+bounces-563095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA5A636F0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C1A16DE37
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A81F585B;
	Sun, 16 Mar 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+DiE7TO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F11F4179;
	Sun, 16 Mar 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149166; cv=none; b=iaNkH0kTSv6DpVuOBnlhVGiZlqikyhJ7xFg9EWSghaMk1DYukMswGj0WfOc3iXAL3z7Zb59Z4VC2y8+Bvkc5k5ffuPDTzan3vA5UoYQX5ylwMTYpmljlDDwtUqP096FyVHbQlscmNlvmdigfBLo9HmKTct8XdLDCdpm6Ek3C8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149166; c=relaxed/simple;
	bh=shsY8picWdauNM7HAi5QIbN1+/obURFOkQY2q4XNRbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qz3N4WGLwISmLXXFX930PDQQnvxClh1T2kp1UL4+SmwCM43vCFG8ucuvQlAIU/Xp8wZfANx1F4WBb2O5hp7exRQ2f9T21KzB4aRmOu6xEPB2Y1k12YRQeFaNnSj5JlWGWdlFaxwVnsEJGlRxACKohNT9/Og4ESnbrFnt3QhWkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+DiE7TO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ed007aacso732042766b.0;
        Sun, 16 Mar 2025 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149163; x=1742753963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xva56AKX2brNKS42OhnyZtYq2t1leFGV1oKmYOkZd/E=;
        b=J+DiE7TOSOGpxIH+zOdU4RykXlyBNYo3KnDJAEPQ0KH6Xz46qvKsf7H37p6+kQ8+a1
         cDPzQ54HXvjX4mZNiLS2O+th+IgKztkXa4oaUqM52BaEKqA9UtRWpaN/oSr0cmF52zmA
         DKAnSV3Xd87MzAW88l1JZEwGWsosx8TgwmxczAgWhKSS2zpwivNX4B1/PRasLiif6H6n
         ItvCaxV46u/ENH3gsJ7euhnXAjOW/kdvIQ0tWdnUY/IC6tS31EG4dJ4GJk1cYoecQkAj
         pCPumS1PqrHOKZRdFWIIkYApQN5dr4pF/zwMGgO2wNBl6V283GzjQHofaff0vDffVT9u
         RJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149163; x=1742753963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xva56AKX2brNKS42OhnyZtYq2t1leFGV1oKmYOkZd/E=;
        b=mUlfywEVtX6KFG1tLsGuSJJqHuh5W4DiA/jNfdjxEx3vLcVeNFa54fJGw8X3era/R7
         Ro644Sqye3y3HSHEFQSWnVNfZnFufgK3CnJUFujwKgsv4gcp/Mc//ALvTu5v0qSD+hm6
         iJzDIl/1uibYd9B/zWSYOYM359+0SSJ46Ulbj5gjGoJdGiLyy4RW0zxFA7wPGNBzP9km
         2iGbd5WTp1TO0Qhjosc2Ab/5Vw/2cfb+sjOnkp+qBTbkPhk22/6OMdvvO4EOPscNVxjy
         c201e4vjdkzapRU4yRf6IRCqSeyxADoLpPqVz/TUinBIzZZ3HP7kguAol00bXmFahJFk
         BNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTURfCS9tnlvTe40Iovt51sZYjgOw/D8vRFI9orOEUZaBlQ2vOtP+IY34efXLm6tPg0mvK8Spg9TfJ6nzO@vger.kernel.org, AJvYcCXERKDHIEIS3GJbCV5WmSnfkuHVTCvnEq77dTBYVDyIpBlx7tiyWYAO/LQFsS+gaSmrsVxs+28l9nbH@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/Gys+wAYRLlvcMN8TmbXCnZOkISDWKUIPn1R2CfvebMeg7E5
	H8nBHKNrvmFbqJOCDw0ilRH4QoYOzJYU6qFKLlUJ2bl3l6vZOLLd
X-Gm-Gg: ASbGncsjPG5FRLgiDBfIUmjH+DhyGijt109RL8SbDyH1YjbfQzwtG8Ik2g7DLdjNeF0
	drad1NnJMal7C942EsOIN/cgDQ4+13Bpga5L9GAN3acP8H7zhrwLWzMMRGO/XORNiKpEP9uWfRI
	EOs6lKiAGkX74OPVIPkE9SG+b8aoPik3etMaiy7Tl8YWQfIP/yXrKsx5Ow2Djqv/wXpMKxrusuD
	S1Pg9faZiA7SntXXEttnQD+8NmWRpziR06GLF8naIi0RPlVWxhGevPva1Az0i0rLeWLj1HGyKA3
	6X+cVunts2nNMYuqbGePyJeipp6n8cJI+iteZCOmQpEofptCVC/RBmXPfKuMAf/DSfj2fBB0TUr
	DevBRbDDxoD82rCFymABkfJQbVFc1
X-Google-Smtp-Source: AGHT+IEW6mwbZ0mIlUOCzUaC2OsZ+OTum5RA4mVckjatFCdtgV+nmDBy9x3IRRsoTUB+6DxdKM96QA==
X-Received: by 2002:a17:906:5fc1:b0:ac3:3f11:b49c with SMTP id a640c23a62f3a-ac33f1203bcmr672618066b.7.1742149162583;
        Sun, 16 Mar 2025 11:19:22 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:22 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:52 +0100
Subject: [PATCH v7 04/10] mfd: bcm590xx: Drop unused "id" member of
 bcm590xx MFD struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-4-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=805;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=shsY8picWdauNM7HAi5QIbN1+/obURFOkQY2q4XNRbc=;
 b=rDbh+AGUMQmTqrTWquPXt0bGmiEn//jNa4ylElnxOs5ntrSzd4IpDqsafHt4svb6BYQbXBycJ
 S4LJMyByqXFC2UnuVmWhYPaos/F4ixaCnRYxz2qv11xVBAMggZd6toO
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The "id" member of the bcm590xx struct is unused and will be confusing
once we add an actual PMU ID storage value. Drop it; a replacement
will be introduced in a future commit.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Add this commit
---
 include/linux/mfd/bcm590xx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index 6b8791da6119b22514447bf1572238b71c8b0e97..c614d1b1d8a217ac2f212908a4c19ae71fa56f63 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -23,7 +23,6 @@ struct bcm590xx {
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;
 	struct regmap *regmap_sec;
-	unsigned int id;
 };
 
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


