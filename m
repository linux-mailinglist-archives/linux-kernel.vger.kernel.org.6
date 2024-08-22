Return-Path: <linux-kernel+bounces-296309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4D95A8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D683281F92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987BB6AAD;
	Thu, 22 Aug 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpWh6XuV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFE6FC5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286730; cv=none; b=V24/fVy+gCjAo0XeuKJqk+1s16pcrkwF2GEnKKDdf4o0MuVF/0VoHRYEQsqn0qWFVGt4BWKiODK/semiVtjkEg2GRYhj29KtPugX+jFHPQ+jFIRTi9mdBXMIh9oPuJw/AX6n+zxHQsEW2dyaJQas0qf0yNl4MWhUDg27FPbIink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286730; c=relaxed/simple;
	bh=Vr2owwfaggIp3VUywDxZaxpxBxEaCCsQ7ws0R73hY9A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=thXlOHvw6Wmx61wBbKvcKyOzuRZYAmOset/qX7m9c327QOeF2bGA6Do6AqTLkcudsR/qLkCUhZr/GoiXPzLzUSrVRciQ5kOP05aHUKzQATlUVKDvhZBeYsIeedbWJgZVpkHI3Gn7UFz7s/4t09MFLLZkobsQauEqCzBqquWU4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpWh6XuV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c03c13aso1798485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286729; x=1724891529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+hEoHL9J/nPYk5QLrqkOQS9keGcw/49+kaYJqoYRoE=;
        b=GpWh6XuVvuyxQ83lOcFyGnD+OAzuODfk88Us6uVMRJsz93d+0zJQdjeTmTkDE53tzH
         8TQyE1q/5amXtulTgcuaZED4vtb1h/OnpKyC7ukI36xV+ipYl0lpuxweIbal7vS/TB9J
         fM7K7fW42HYlQO/RQLl+RE8MDgeO7BKor4RK5pJpXdYPQMz/NX6KKCbqh3u6cPAtp/hH
         MdwFDMCitJqsiVV/hTxe48WAk17PaqXGN2TWBZcrqsRX11/yd07tZa84/8suZDB78d4/
         YTCtu7ajtGznCWbfgAG7df6lyx87iK+nFF3Yk1gyHP5PTNuiM8zDl/GvrR2fq3Lic2OR
         pEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286729; x=1724891529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+hEoHL9J/nPYk5QLrqkOQS9keGcw/49+kaYJqoYRoE=;
        b=eMLI0QRqx4KDaSCi+gsSlb9rZH6+Bg81VhaI1fbJK/0gw6c4RHO0ZVlGQ5LIehuf2E
         y5LPiutVNjrO/2DRsGI61DkU6uSiz8WYdbeGLoKMeMovO03FuurcUIXKfmrE0fvIQ6tn
         VxSR4ql3L+x13dFatKibbc9rDBCqV3gQW0aldxW1HsCpsMqRN6WDj+pGWy9oaDInvtLf
         GoUDo6jy8BsqaAfI+ZcFjs7TWZyiKQGIaabfX9R0kipLLnsKEe71ELgppPZhurwOCztO
         50LG4F70Op1YYbT0SKZxrL8a/pf/rBomCcE8seLr9peDq14RN3hVm9mFuJIQ+TakY1JQ
         Hy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSg1iZhA3r4+6Xc+1WqVXhnMqTZktE2i5ndiXGqTyNd330hwPreKeX93OgCOnyRwQ2HicecoJcOoNRaUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPKg2pswZN+KMT8/nbVL/49rrJGtKLMU01dOl6tvDgtQmVIaq
	v2s+MpcNlQdxAnZQudvCBLDH7xIO6GPkMOBZ0qVWUSNfa76nAG2n
X-Google-Smtp-Source: AGHT+IGpty3G24IJM5a8qRyiOXV6cIuDaUddjCyf9dwqsfyvXBpU3HRhqfnEk1LDQrJ5BvsFVnAv9A==
X-Received: by 2002:a17:902:fc44:b0:1fb:7654:4a40 with SMTP id d9443c01a7336-2037f9d4153mr16179235ad.14.1724286728492;
        Wed, 21 Aug 2024 17:32:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:baa2:9074::1002])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560dfaesm1684535ad.223.2024.08.21.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:32:08 -0700 (PDT)
From: Hans Buss <hansbh123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] stagging: rtl8192e: Insert spaces around '|'
Date: Wed, 21 Aug 2024 21:31:45 -0300
Message-ID: <20240822003156.141717-1-hansbh123@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Buss <hans.buss@mailfence.com>

Insert spaces around '|' to adhre to Linux kernel coding style.

CHECK: spaces preferred around that '|' (ctx:VxV)

Signed-off-by: Hans Buss <hans.buss@mailfence.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 1b444529b59c..e507593b939c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -229,7 +229,7 @@ enum _RTL8192PCI_HW {
 				RATR_MCS6 | RATR_MCS7)
 #define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 |	\
 				RATR_MCS11 | RATR_MCS12 | RATR_MCS13 |	\
-				RATR_MCS14|RATR_MCS15)
+				RATR_MCS14 | RATR_MCS15)
 
 	DRIVER_RSSI		= 0x32c,
 	MCS_TXAGC		= 0x340,
-- 
2.46.0


