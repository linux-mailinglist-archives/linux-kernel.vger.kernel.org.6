Return-Path: <linux-kernel+bounces-512385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC215A33899
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E6F167B24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C320207E14;
	Thu, 13 Feb 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmY4EG/j"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805431FAC42;
	Thu, 13 Feb 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430933; cv=none; b=VL/a5tgR4uOd0NQ8247oAMjyWL/YCmI/x1lrXS7rnQ0ruG42/l9IDaw+21DIfgLQ2gOP1yOzVXp4yViqcNHIyHzGgqv6WiCgwXJYJ7KTjzEuUJN33bav/hOaDjGvO7aLdvsXiahuvjMQhr8rctsYTl2O/d6YDsrWbJ2KtjJVoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430933; c=relaxed/simple;
	bh=YNhJ633Uu5JY/VB459x1ZUs/aM+9WIpG3XO2+Tor/5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O3aPVgRYUSEIe+LDiXe6xiNw7DnVDEsdFAOA8f0XM2usfRNg1wZBFqHIZC+Z+0pxjiib2pl0SKpGEJ4P7RiSJBVD5TIdowqCIzZESY7TYtUcO3wPSeIF+7Mz4niW97JOyRVIQFw4HiCZdmRaNxjYQKarpVW/aDR58oUG83ADxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmY4EG/j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d601886fso4259895ad.1;
        Wed, 12 Feb 2025 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739430932; x=1740035732; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUcgyWCk+u8Dn7f+PhxtXY5uOs2pwYWI0aCmIl9K7zM=;
        b=bmY4EG/jSturUEZ5w254CwMh47g0I7vmgyNK82xlZde4JRJkeYO1FgURa2Jt/pn+HK
         q8aPm0SMAg02o3vN/Rpt4g1+Q/lGXoTE6zhz80MssQedZ5+82mpgmdLvSyC6huiJ7wkn
         BWtjBShxo5ze6NWSfUZCZCNnPgeJcZr7/1Ip9B6EEsBDeiPZduNd0XH37+cI+F2FcFS2
         ajeX4Hd4GgSrZHnqYIAwMNNVbHAV5PWTSAcmDzBMM/iCdoHBLr+xMHxZeit50gBuJd5D
         fcRQwqtMuqfHhC/2hFmw0Z+ZtLVkXgv6hkdX3Vqrn6Iz7SrwTmJutU0qKWY0LRqmvNx6
         vPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430932; x=1740035732;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUcgyWCk+u8Dn7f+PhxtXY5uOs2pwYWI0aCmIl9K7zM=;
        b=HmE+ZpykuV55UN0dJn8VV/l96TD1OtXeDBYSdoNByAwvFj37AAGqKXHDAcSJa3te3Y
         0D44nysVIOLOnRz66vMOsLVGWpKyzPzmkauN0NC8/c6HbakfNfROWSlA6zNmIdHyp170
         gS2uhAOwO4zWo50EGntC/b6fw6hMc6sRfUCnVo3qRvxhffUjm95mRx39iL0CGfYkDF2R
         L031t8Nrv3jQDJEslz+GhflVNmHUeVr7jB0Wz6uxgvf0XnLBTu3eX0R4jS4wPXZ/YFQY
         Zb4XTOXHxQMEnI5N8IHjfpsOF/+hcF9dL2+SqZFNuYNZ8CZIHBVMDSs4aSh36ppx0MOf
         uSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrzkNsw94ZPdMGSkOI/nh77zlOzY2IPxcZZ89Kkp3DWMkO5dj9FfyHe/F5tNpxqdKDUnh8Xi+LuzBvVgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Kfavln5PyFsvcPkCIMbapfchmfdSbuGulMpI0Klv3w/SM52S
	Y/V9iXTU1AjkKqPCNHPZqfibCHcdNYVgBnha8Z1rkcu0DLLHzIXW
X-Gm-Gg: ASbGncv19zkgkqxWjatGuSxdfi88orc9kKVXtlQqnIERDyht1jWz/W44vLpw97HbGFS
	9oOn6N8tOgDIbKjkJTzmLKuO2O1L7s/874BgFqr6rI+oLosh1DS5slRMrMW4Ku2V+Vag3tyynOA
	ZLTZWbBOiL2CVjTa879vNkEeLUoHYQmvKMZgfMUcviGh90ecwIYNEcegAbFr7vH4s1pCZv2wF9i
	FF2eHSA5K0Z65KFAh/HanTjYOSvEvo63ckH+Kixzfk5l4L660lasUw5bhdNc+Mi83GRt9kTQqEv
	Skiv3T39qKd/s/Yw1HqB1lduVE1Nt8IZ+j6K0Ia6r6mjlX0LiNxx9MPbLcFIHfEgeYxj
X-Google-Smtp-Source: AGHT+IESUUVzPXXPdZpzlDh8rry+98kDAJ3u8IwfE9kokPUoqbExS0rk1/6ABl0gHCy/zI3w64Nohg==
X-Received: by 2002:a17:902:d508:b0:215:e685:fa25 with SMTP id d9443c01a7336-220d1eddf52mr33675295ad.20.1739430931635;
        Wed, 12 Feb 2025 23:15:31 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866f9sm6024805ad.230.2025.02.12.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:15:31 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 13 Feb 2025 15:12:58 +0800
Subject: [PATCH] ARM: dts: aspeed: bletchley: remove unused ethernet-phy
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bletchley-dts-fix-v1-1-c953315eb894@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHmbrWcC/x2MQQqAIBAAvxJ7bsGUJPpKdDDdckEsNKII/550n
 IGZFzIlpgxj80KiizPvsULXNmC9iRshu8ogheyF7BQugU7rAz3ozowr36issVqT6wdtoHZHoqr
 /5zSX8gE4Bp75YwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739430928; l=1236;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=YNhJ633Uu5JY/VB459x1ZUs/aM+9WIpG3XO2+Tor/5o=;
 b=pZ48Hnh2P1YAIok5bEXIzdHYHBpzJ2kH3ypTFBISHRz7bwesAYGD463j93AuFRLNoAxYZOdbC
 2gpTfAfA22jC4TQQXT86BmoPCGX6rap4V5/pWjOcy/76uXjjozbAwUH
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove the unused `ethernet-phy` node and the `phy-handle` property
from the Bletchley device tree. This fixes warnings reported by the
kernel DTB checks.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
This fixes warnings reported by the kernel DTB checks.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 5be0e8fd2633..21fafa4b2422 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -52,10 +52,6 @@ tpm@0 {
 		};
 	};
 
-	switchphy: ethernet-phy@0 {
-		// Fixed link
-	};
-
 	front_gpio_leds {
 		compatible = "gpio-leds";
 		sys_log_id {
@@ -285,7 +281,6 @@ vbus_sled6: vbus_sled6 {
 &mac2 {
 	status = "okay";
 	phy-mode = "rgmii";
-	phy-handle = <&switchphy>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii3_default>;
 

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-bletchley-dts-fix-3cac66ed586a

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


