Return-Path: <linux-kernel+bounces-537422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730FA48B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E733A67E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57921D5B2;
	Thu, 27 Feb 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvZZ10uq"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B32777F6;
	Thu, 27 Feb 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695453; cv=none; b=tSPOa41r4cGarwi0Oq8P6Qq591SVAlOABctCI0AtzLmyWIzn1yCuT9BuGEIPNFrlQ23QsRITcSNIVOSGgfdkR2CZrOI8YKlZgHURZ2X7LzdhHWpCd8GkNcKeRCA5CsL+0dJ/fo5aNyv79YfIhnkea9cTfJIw4H7GqWqae+pDO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695453; c=relaxed/simple;
	bh=uE9/49ldtLVWgOIkRTyh7MU6b9DNqHVRykrBZis63qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JG7XOBdR0CMtPHO/49r5UUtCxQ2ygcK6zM5H1srz6m3vW0NwrpTn0QXrws02xSQ5R7LAuciKbwh2nyNtn0PaauHZj7bf5Vl8JXn3dUSnNf2nIhKbXrYTC/XIz9dea+FHwhNLPJFiOId3m09ATyPTk7yGdTtj7ORAjOoWKDEDBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvZZ10uq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390dd362848so1145785f8f.3;
        Thu, 27 Feb 2025 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695450; x=1741300250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcRKzSB/2yPSFLC/yuaVKN3wLU16fzkLrF80SzPyqk0=;
        b=YvZZ10uqfi31txCKA5c6BNE1xAxeQ8RIhnXha1L7Pp9mCGoQ0C9ffxshfCb+5h6vhO
         e34fgdTRrJ+y5My8mss01L5MpXEexA0z8tBHiOWnAfhOQVhfrszjJs1JlxyJfHMvWAKS
         2FawrBV9CKFjJIaBJbmiIagAV4fgpBuHQR5Zvr7D51i90CJrMrPydhn1g0tuYrijEDpS
         u/lprMg8UbKI5NrEip8Bjd8fGNrksHtro9U8G3ygWEOxIjq94AwxTaX0eWHBfMhrmE97
         JNz4hYTz+7xV/LPA9xGPufXaNCm085bCCNIC7v6st3aB/oFUx+EPxMG/wR3BG7wmw5fX
         a49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695450; x=1741300250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcRKzSB/2yPSFLC/yuaVKN3wLU16fzkLrF80SzPyqk0=;
        b=hMcr+diAq6MapXikFQg7/CCFPFuAVVQtbaebRAciwHnNbSxAjHo1fOhP2J9qUrzAnc
         cT2yEH9E5kPltbVh9rGRpQiT18Uu/oS424ieF55BtUm4Co6UobSLXEdIYTN9l5Ne6hnj
         5d3KSYmWmk7lgmoRIxq2ddTJ3ACUNE/duT1WTTZMipQPGXpRyDX98b0Lm39Pr4FRHxvl
         GbJeJYH4LkEWt2d7wGCAEZBOp/9glX+6s7w1Heh3K+3HWeoAcPi6a674pthihLxXIo+N
         B0fAnRb8JMSnyxgQEhB9C9NLUijZtpWWowLYTYisM/9F+f5anqRZf9mTOjI8VaqmVgZu
         n2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEDyn/pw+gmZ86+he1bJSkz/+ANJJRLKWfhnqq19GSpWO4om44mBPL+f9V0HkqWVrURiIIISst3EIoC+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ffDySaDFXKCFe8sSRBM42glXyANMPaaB07NVZs6J1ltAImqI
	DomEYocRgtZXJJOM/NVjJ6bHOFt5WJOIPsfqwP4Fenrl3UDMFh8T
X-Gm-Gg: ASbGncvfLgxFjEhq6aoZBlBw4jnQmADOMWbEkt98Gc4bUzoA2apT2ASmCmI6ZIiQkEt
	dEiO+BldmXptW430rgc/DNnt/WyO14KCstlHsRs3I/712FhlfGL3XocLWmbGyuB4QkkSMjpBqNn
	WwH3r9YqeVDdpkcN9iDHCJ1qBz3Rgdp1bcWzH/wlZjgU8LLJcnjMVIte36zDrKBOrbN3Q1UKBhj
	u0mper2Fmt7sGap3UdLnc03ibWzkDpY2FAOZG+S71Yd5cdLXwzJtZkTdqYZ1HS4JYhrSYRo33+F
	ZRrusZATVCfktnVJSToxNaIGZSw=
X-Google-Smtp-Source: AGHT+IHZnNJjB6n1FrIv7bNTeIztKawFuFtQFZge5h5pQvXVo9m0pWHpuIzB0frMiVy6qLOpUKhORw==
X-Received: by 2002:a5d:5885:0:b0:390:ec1d:7e4e with SMTP id ffacd0b85a97d-390eca63baemr664341f8f.49.1740695449747;
        Thu, 27 Feb 2025 14:30:49 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b7a27ab2asm35806225e9.32.2025.02.27.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:30:49 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David E . Box" <david.e.box@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH][next] tools/arch/x86/intel_sdsi: Fix spelling mistake "Licencse" -> "License"
Date: Thu, 27 Feb 2025 22:30:14 +0000
Message-ID: <20250227223014.659189-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 766a5d26f534..0e12b59976de 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -315,7 +315,7 @@ static char *content_type(uint32_t type)
 {
 	switch (type) {
 	case  CONTENT_TYPE_LK_ENC:
-		return "Licencse key encoding";
+		return "License key encoding";
 	case CONTENT_TYPE_LK_BLOB_ENC:
 		return "License key + Blob encoding";
 	default:
-- 
2.47.2


