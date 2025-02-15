Return-Path: <linux-kernel+bounces-516429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2068A37156
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82704189345C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D371A841B;
	Sat, 15 Feb 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y25SENsj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EB1925AC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662958; cv=none; b=AtaeLOw6W9IUyLS+aycbontBtdcz833/JtOl0PIynhdWtbTBDQAswyvgQUzDrcGLEvoOMQB4LiKtNgkg/6dNp3RD2/hOXlqP4Uk8Du+w4aY/l0oGI7dSmweCOGFTFSz8cY4Mr9fwXFMU/rdeJQUYUVDqARmNx9bbWnk/hC16ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662958; c=relaxed/simple;
	bh=XWlsf+isIAxAkohHLrQkZfOvNu2Tmap8/2AntAcdZhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neTn2QnDAl0GDLiBoMVoorFKFtH5wE3NvjTXeyHpnnr7FYjsjYYT7r7vp74daG3Pq5/D0hS/5uq8fsP3zLMBkQoiTmGS4GTwoDpEabiIpJSJ/QU9TtopNaQu7PiXPg1vJ/6R1v2td48N8B/GLd/38ZcOgglL0oE03XVGswxpz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y25SENsj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d398bea9so45392335ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739662956; x=1740267756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=Y25SENsjbU4JgIf7VXq2CXqkHNWUKoepTbfEBCJyqBQsPnzHKFDTZUc2KOot+Fbc/+
         aLfwEkny9etrx/INc/1QFS7RMOILySKDp3tKSMf3zPERf36SHb6ZcKZ3xMAC8Hp8XmgQ
         FoCLHHYk36uldeMzNaYrxP9LPOO1sWE5+0Jxs+X9og7185mhojQ38Hzz/NciinYCIPw7
         zIa4b5j/prOjG4eyhvAgd24iJ+uYJbQ9Z0lnXGcoX1MEXRxCGw1FbxIBWwrDwOuw/V3p
         j275CNX41XoaTMHJMvqqXylHyXM0wArCLkB5SoolGKs9/UQrdpYpKtXomWSmNfjKmOMP
         3CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739662956; x=1740267756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=rZeNfdwZYG42d0b+8CFtcpuFsCaVg8k5u8o7v4Sf18mVsbj+EEDy44Iq3yR2YG0+cK
         mSkfdR3d7+bj0zLd+AkuWEJ0P8Z3374IeLkM/9hLXRPeBhaI4Gu9Xh9qCAcUAIHaj4Ve
         CEX6YgDNlHaGBbfdVTls/9tnx9QLVFZCRQn5CbT+FTR0CgRRTbswlbtDPmDDB2WdWupm
         /cTurF9FutvGHxjEn24KGiq8aPv/jZEge0cwMp+r+ivG/v90RreAiAIEeOrvmDvV5brX
         Hs14i8rwLqqFIfWd8Vwtl54KgG5HYqBNwNzoTZ9LwHgYMuRNR7198OSA3ydH54B29wEW
         PAAw==
X-Gm-Message-State: AOJu0YzYgLrZnmVKIOnE3/1iHcYRvToWp4tyIR74pOXHwxtm1XMYV+Sh
	edfFfIJeFgbIod1m43uWuLidfQaWgFWzRf5iUAKUrNMEHxo8QepopORbEZA/Vnk=
X-Gm-Gg: ASbGncvm1LmWJJNjikNVKf3WSipQHR0IF5tV/1VARDvmZIXl0I8q/FF40qo0RDN4NUe
	hYtqAhEhvMlAat7E4dDs4VXGHZVgRquiUDkhlDfHai5mIgiiVFs5I7oDBA7FVdaCX1otJFooevx
	Ad5BU4g6n49dZXC64jpjP+Q821RA6YvrJY7O23pO+5Vh4w+h3lBARocEYPPtKfiNwBcABs1vxsT
	ekqMbZ+KWxIkNiaObkFwFYp7ADP/pyj1zhx+9/6B3QQ3xijVVSPKfTVt8lO3Xz1PKaexNLqxDTL
	Ro4s2ECqo4oeQso61HyDjeS6knLjXU3RrndeelbR5l6omX+UAdzOxdVdyzLzfRRtRXsyIVDgFIq
	jd7aHU5+C
X-Google-Smtp-Source: AGHT+IEnVrlROO8cC3oI6xPROwB0JlQH9ggrs3v02U/Su4Oua7Lb4ZNLtwP58FuZFDad5ska+yrqJQ==
X-Received: by 2002:a17:902:f802:b0:221:1c2:2012 with SMTP id d9443c01a7336-221040d8543mr56065895ad.49.1739662956360;
        Sat, 15 Feb 2025 15:42:36 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm48803145ad.11.2025.02.15.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 15:42:36 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] docs: Fix typo in aspeed-lpc.yaml
Date: Sat, 15 Feb 2025 23:42:32 +0000
Message-ID: <20250215234233.105867-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct 'Tehchnology' to 'Technology' in the copyright line.

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index 5dfe77aca167..d88854e60b7f 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# # Copyright (c) 2021 Aspeed Tehchnology Inc.
+# # Copyright (c) 2021 Aspeed Technology Inc.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
-- 
2.43.0


