Return-Path: <linux-kernel+bounces-516145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED785A36D61
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68CC16C8AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C141A239B;
	Sat, 15 Feb 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8rEA/tP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D54A08
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616782; cv=none; b=B1PeSCsXGWvYBmCkr3Dt67f5vJwoB5N07DOwc08NXzI8G8weKW7B/L4AV3yKqXxzjU1jMMlUIzJrxO9k6TzBcCHyMPIeGz3kCwLFZrC7I6OSJagQfVhs94ZCfoQb5RBFcUE2zn9wGkDAuaHYSRV6MwwLk952qk+guIW4bJPgfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616782; c=relaxed/simple;
	bh=GW3Ao7SQL4ys52aJGhP0R6VrlhAskxfTRqusc8mRfC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L355V5EHHPPUDc1VUIC9d01enVr3uBkjyJ/JMneZgqifqnLCy77p9OvjNaXmjNyWFWkgTDQoaNVjKL3rtYcHYYf8QlbdSNHBfHwvzzGOyGLZ7lycPMy8Ou4Yru7nHyxgFWvwDFsWKkZRs+42Iwps8cJ5nz8g7YlTeN/UU0LkwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8rEA/tP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f3c119fe6so69217365ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739616780; x=1740221580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Layaixs3B1OcmVPuMaTx3gySzB0tKrSLZ3zAq+CtE=;
        b=E8rEA/tPCz3zWfdI9M1FvNN8RtD/kpoo7Rt5GNesV8TdN8aC+Qla+Xhb6g+nlQX5f4
         osTvLkbwboD58/mT737PCq1qaPf+GnfY2jPXSdySgiqNqbQqADCbf6u2wGfR/HOW45ke
         JCr/3KfHD/5CC0zUM8PTQ+7XumpTG+vQBciTLSKiFrit8T6blW223Z2BtgxIWTSjwSRO
         1ncbmwENOFwykzFqaYG9wk7fOcCs2sdF3hHxfTZiz/xz5LbMZhta5cz2Mi6MhnYtLenj
         SoQt++xY/YXB5aZeFDgNNr06CGAES0wCRmL90VvgTqkJdcbUV5A1dzORGELIi4OB8o3q
         jzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739616780; x=1740221580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/Layaixs3B1OcmVPuMaTx3gySzB0tKrSLZ3zAq+CtE=;
        b=vFlPYqoB8H+O55il8ighlzzEgvfg0unlt6+YcjjqJ8Zi6bh8UsRdw/r4YkbctBmllJ
         mZIK+qcsaF2LledQhgayqcThu+6X2sIKoBCA+mrB1tcZRljMJ9hIRm0pJIbQfMcGQZaF
         9bsiefp7CWuoLp8yfuYjccTvhjpi0pJhmRryiXhHGpR3E5IQuXT9OPKFrPo+asi9Gl5y
         T84dDDWCS5SZJFj+g3hOuLwsEE8Lk7rtwlZUi2u82nyaYXrGkTZXMooZlB7Y9kPq3pzG
         nKkP16zohRS98iskUSU5uBJeSqQbyzhHYVbwaVzXVZHuAfLTgdHnfscWHhyp64csObaK
         dBBw==
X-Forwarded-Encrypted: i=1; AJvYcCVnbHFWP46ts6afQOLFiuQpq8WA7jgsxmOUtRJNA3iKb+vJFjfiethqSKIt+XZStRkVQkD2WpuI9GYEfNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE96Xv2lTaVpofePBzO35QWHhaEhS1ybquM1mH+rdH9VoaM7mI
	QDeaeEUDnDkyLC5ytB5OJVpwdP7sYMRuufEOm09BTP2tU8iAZIg=
X-Gm-Gg: ASbGnctXVE2bprucDhU+5W+NYFF+svoxfaUQOeWfWOFx0WFJ5tySSpAEIlMd2IMM3Hl
	B8X0UUyRp07Y+5hcLpOb42aKGAKZ9LHS2GLPrHsx/krTKdWxApKMvwg4QaGzRRKrukq1icc22YF
	JwQ6L31Ao/WU79N34lhf38OB9K8vybC6SfHn3meUd97cMroF805aG2XNUdjcJJsPZLhkzlmaP3L
	fArOsVo7+8YYrkpjue6sMl+HTHSjG2v8Kztpvf+XKJmg8Lc3TqFH/YOIQDWuO2K2xAOByscKF0E
	GewLFnjBT6dHSyGFAKDVHMNB
X-Google-Smtp-Source: AGHT+IHroPD8HG+LaR6k9iig/6lCqGqttnidextliyEkaeLe1/DZM+2WnYz6Ec5fngmsnB5WrBOUCA==
X-Received: by 2002:a17:903:2341:b0:21a:8d8c:450d with SMTP id d9443c01a7336-221040d11e4mr40633455ad.53.1739616780528;
        Sat, 15 Feb 2025 02:53:00 -0800 (PST)
Received: from debian.ujwal.com ([223.185.133.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm41280505ad.170.2025.02.15.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:53:00 -0800 (PST)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix doc link to fault-injection.rst
Date: Sat, 15 Feb 2025 16:21:07 +0530
Message-Id: <20250215105106.734-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect reference to fault-injection docs

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 Minor patch to get used to the contribution process

 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..f509e91f058c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2103,7 +2103,7 @@ config FAIL_SKB_REALLOC
 	  reallocated, catching possible invalid pointers to the skb.
 
 	  For more information, check
-	  Documentation/dev-tools/fault-injection/fault-injection.rst
+	  Documentation/fault-injection/fault-injection.rst
 
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
-- 
2.20.1


