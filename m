Return-Path: <linux-kernel+bounces-516426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29228A37151
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55933AFDCF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543D71AAA05;
	Sat, 15 Feb 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDSJC2u+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4A1A3168
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662653; cv=none; b=Q7BMVykEEASKEcLpXRjxs+nSWgttLN7pt2qTsjggiVrRyxmodVBJRSDN7H6ztII/eVClyWgVFucYLPOr+9p7DRzpt6Hyg4QsIDxjqwDGa3OKBCr0AvA9mUiKSlFBVovjkGrbFPEo0jX5bv2DIwxy2xkVO2NVD14jn5PVFDh8ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662653; c=relaxed/simple;
	bh=XWlsf+isIAxAkohHLrQkZfOvNu2Tmap8/2AntAcdZhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0JMGsmh8ft7KcVDOukv2ODGymagavVMjqHsg1BKrT9vvBTutGtfCkiaCyx6NAkX+A0Xh/pUrfJPKEJZcQ//ypX2QXq78aivLcTtJdQmRzO1qNGyxzHjyVdFlVcGYMRyPWah3B/MRZsJBtEO3+16NHvMaOhIu+qjW+JMJvQLYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDSJC2u+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so57197575ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739662651; x=1740267451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=TDSJC2u+R/CxeKyVdIcZAjGW2xusz0DHJtVrZF9shkwgNkm3CGuBy/Xd/Bn99eSnkK
         223lc6N3a1Cak5hLkZ2I9lg8rDOeH8RpxFvgCtxzygzn99joUhNpgRpnmzUAsi++++Pu
         HcvxObvyTUSAkEPiAkW3TSSfW2ENpGtXQylhvPxJlgY2+Ba6ITaMgnIhvWH2Ic+Ldcxb
         FdeZfl4JGDCM8cTnlCEkoqJBNjiG2Tdewh8ifKtA1MkKHof5mheup4c4KzERFgCeLGvk
         D/eyHSjnNNGat/E9sUfbyeg82wtr0vKL3+BqGlcqQAGOWpYPAnf2A0knlH61I07h2k2l
         UUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739662651; x=1740267451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=aJSf7uiIbr+KrcNsBjbaREAz2/ywfBSoKdsUC0sDewR3yBgLluGzCcgG06KLr9hWpW
         +csDFEXKBehDNV9cGvtPis8e9duI8GfdjGg+UZ76HvWD0JvMPGFtB7Z1URYmcz+gbTf/
         tX9fvQKGwVy1t/IKcmjSLmaNmz9Et5Rdh+1FFl3NVr/XSWS1tEMLp7NdTEMiFsw8KG9c
         EPjH59fY++uqn3UtKZKOgcyEt94IOobmO1pKNhIHJjXotNBMPxOGrcrc4UHz8XGQpLKw
         r3u5KNWOgYk+h7fnP1nyqQVBUAaV/SV6RCNhiKQaIToKB78Jb2H1w/JkhBenC/0QV9P/
         w3bQ==
X-Gm-Message-State: AOJu0YxlQfvnrYTYAV1Dr+/K3Nh0/viPpf3dhPUpDSbdiutun7HRNKG7
	rKZbaxp8oh/3WR/8tx/NOUHN4Hs/b9c0z1WPcW8lrTTq4bRobAUdCv3hUY5+hxw=
X-Gm-Gg: ASbGncuxksave+/lKLq3FUGl5FpgCg0BHQnz+W07rwb4teNpKQj146JoEzLTbczBuuB
	Ag28zX1V4KsljhHnCAgb7mqSO6PVPGmUrBo06vV9y541Cwdvs+VqKKXtVFonQngd94q77cNloZL
	FPglJ9x52u4zmVV5QZqj2R/zDtPU6KYWoUeScDjOxO6C8aK2SCOWsOYWDMZB4hg4+M9JZ5Wwuy9
	FpEVKlWkYQoB3qDGDsqFlRfgIb3KUsi8/1NW5qViG4n0TA8wqjaGD6Ik88r1g7ZCuydu/MYc3j6
	a9WnG8uORcpJTFHL+LONNKkZm8vVaMJ4aGLjrbNbipMAHQVvoxjbZkj8ptnxKGSRndDmv6VxteT
	WNZsdOlp/
X-Google-Smtp-Source: AGHT+IG2LKs6woD5TyLnFoYIsBYFpCkjYvuA8UaaPDh3Ii2gVkTK9vXSj6cxeUmj+XZFSqphuSGlsw==
X-Received: by 2002:a17:902:ce89:b0:21f:592b:b4b6 with SMTP id d9443c01a7336-221040d8281mr79338725ad.47.1739662651257;
        Sat, 15 Feb 2025 15:37:31 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d66fsm49165565ad.180.2025.02.15.15.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 15:37:30 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] docs: Fix typo in aspeed-lpc.yaml
Date: Sat, 15 Feb 2025 23:37:27 +0000
Message-ID: <20250215233728.105709-1-surajpatil522@gmail.com>
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


