Return-Path: <linux-kernel+bounces-516417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624CA37137
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00133AFAA5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BB1EA7C0;
	Sat, 15 Feb 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOMKiMPJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70811624D4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739661603; cv=none; b=d4tivNk29qowpUe5kkKqt0yVsOfBTQayjiU+4mbnryBF0WOaAEQcLCNMcYIh8/YjZIQ26ZEY2XPwz+rARppkYNIhf/92GK5vun6K+peiBW2oubihflig8OPwZF4zoiHaBX+UHYebCDnwVofTE5+dOJ7H1IONlZyu24K3Nsar5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739661603; c=relaxed/simple;
	bh=XWlsf+isIAxAkohHLrQkZfOvNu2Tmap8/2AntAcdZhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgdIafrcsPJT8L4Aog6J+elPl/Prxg4MJ0jMCiLnbKsa3DZBpauZmdVN9lH5fjW6BLIZs5kETB1M8bFLuP9uy1/rX6FvqQp8fJXdhwl1xO8O4mD/7oAz7Tsna5YUGS7Dxhcf44Fq5Y7KMYgw4WLYMQ4MV1EXXkTCzKQK/BEJ4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOMKiMPJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22104c4de96so13010575ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739661601; x=1740266401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=DOMKiMPJVoTpDoNJ4d1w6GmWzjbwGUehEXe3H0tfg8aws9l0EAgepUO2xUl5ffxnl5
         URNpr8K7dGWg8PKA1OKak6RKgCmDPTtztgeJw92SeGqgMDdKUHgungEoolGroIhtZR2y
         2VC4LeM0h3at9HJHLVOEzndnoejgecVihY8b/voafE33e3M9a3FjBV1J60Bfw+B0zNfz
         v0bhOUuceLR2ffDGi7+jX7mHV0+qdpZy02CduQrSMrf6yqiI2qFtQz/aAyVcTISkIPWI
         SWirW5JN27iNCngHKoo3mKe3hBy4QLfOPcFiKK6zBtw2sx9w+GctfKdayIsr9Km8h5P+
         6l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739661601; x=1740266401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUTuJeqyZZgiPtFS10sZTnTPWv3qnMdLOMr9WEQY29k=;
        b=KLscwReEAxyTS0jDSfrWgFuyzrFwzm0BBUayCx92GumIxdAqT3C8sr4GV7wi0Ubj9n
         PUVh4nRiTBYiuywt1SAjVZv0SzNPmwj+z/9/6FgVNOB8V4r6uxGPpV7BCIY/osAvgwKN
         7awENdK/wr7RJTF6UAn3ibCE2wPKuMpeSNdrrR0xNNfWKBciWAsPq7S9jGxakAM9OyS5
         2QjnlJLxuE387agDtgBwNSNDN2C8l8HqcnknSefpUgS+acEf9Okyrsj87h1XGu/O68gx
         eCYcP+K0+Dv+EFf8pJHTLduk3kawiGkEGZ5GweqoMEbiiglnRambu1J+JmWh6kMqP1YG
         kd6Q==
X-Gm-Message-State: AOJu0YwOxNb2hqoriAThWd8WYPQq6ut4wGEz7MiTdQOeesbg9x4Uod3D
	n2OQjabP8rU+76vYeicoWfKACGJNunvO5hquHYMVa1w1XArtW5Q6/B9d0A==
X-Gm-Gg: ASbGncu+Q+3wudMD6Z0MFvWpt9t4LHBRmPu9bNWr0RrRlQQUOlVPFSjf8AmXRoBczl0
	H6X4JhebD79EE24vSC1qDkUyoag7EWOyOM08KVK9JgGHNkfefume2R2JZB1DkwP01P2nUIQvQPF
	Dtb9ESq9KFhKPTOFnjFox/eaHmFfvbTMgOeb43oLRU1rLI2bfFyIN4+XwoO1gUDbwczlVJklAVA
	6ba099iTCteVh4dPjTi2B8fx8oVVm4vLZUpXd0fLJldqIwYnLP2pmlTBuYetVg+qz9rx0YaASb1
	k4I0At+0nNJ20gqY6Re43h3a9xoN+GxDhF9qCb8ZGGmcU6Ni8HZ3zeW44CepC7Z0HJI/1jbW+DL
	rPdvNuORq
X-Google-Smtp-Source: AGHT+IGwLxyJpAx8ujHWyq0SqWSXK0dcVemx5vQxZfB+KutWHwgw3ykSamlZaE+/1DbAQrgDETUgrA==
X-Received: by 2002:a17:903:94e:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22104034f86mr75295795ad.17.1739661600597;
        Sat, 15 Feb 2025 15:20:00 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349019sm48810395ad.36.2025.02.15.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 15:20:00 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] docs: Fix typo in aspeed-lpc.yaml
Date: Sat, 15 Feb 2025 23:19:57 +0000
Message-ID: <20250215231957.105232-1-surajpatil522@gmail.com>
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


