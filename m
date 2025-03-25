Return-Path: <linux-kernel+bounces-575083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8772A6ED56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C525C3AC254
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D711FC111;
	Tue, 25 Mar 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWhfVvFe"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721D1A2389
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897525; cv=none; b=LmZfov+hlBkxr635/Tm4JPRmuSDjVwQdCY2abYQSJwyX0TwCtW+O8Ufmvy6+i7Eegc0kFwQB+cgYUjWEQAkboF7fPaQfjZ2iYYJ+1PcBuRJ7OdGKNIZ+kT+zji37KKGc2Y2cBZCXI4FWnSAbVTnlOqatDImeF7V/kNAamtYmDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897525; c=relaxed/simple;
	bh=KpilHOOJo67Z4VWOQXgm4x9QaziC64Nge4Tp+ZLbApY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2bQx/36qumhULiLIVVZxdMT4ccVlk3P7NbZPJPOmLryyFnIubiDfLdKB7fH09Ej8Bb/D7NfPidiFzoqf4H0zAZCF1zYVgC6Jb8lAifWSxFNFPJF1r1fOMvHC4jp2Qvt54wyletFIjVPwKFzdcC+RV+5OHsEF6poM/VmnSjMw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWhfVvFe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so7811363a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742897522; x=1743502322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUyR3Oe6iYVQ9/r3ijgRJfklg/wMi4nHhN2lq9dus2Q=;
        b=cWhfVvFe4B7T0MBJVPYnYJm4MtPLuZSGYTPFEFfHJkcLjJF32itPHOp5ZCNRCVUQue
         iJvIoEXfmbQRHLp47OFZpp2TwTU1myDnxTo5mQL82yiuV6lh80pn3w91KWXEcMkYOWNV
         U/IeoLdsvlSROmCzn/iG+wlunuyWUXBjCBvd9SkGeZIBMx7ZHzPB+NOOGZc1EeQqzKDZ
         khn5Tqvn+nawleyU4KaUvh07CT2pxfZD4EheFc6ImAYE3Jzv4Y2nQDl59Z1TAhOz9UQH
         hK0TMgDfY2+lqzltVQ0zQ6aWym6XeixYg/NDqYPVqtbC/htHvXROMJDTgv6PK11yEIGU
         yTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897522; x=1743502322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUyR3Oe6iYVQ9/r3ijgRJfklg/wMi4nHhN2lq9dus2Q=;
        b=vul6aCeOgZBuC9qSaYIl8Ye629afHaUICMpZpAnmp5UehAEm6yNHuBafbqUzi0OBX1
         Twe6XhnDyPzef+OOthuYm4a336tKJZ+RPEAN7vrR5PtbPYX3anuIceGHJyXYd0RKWyHu
         xA61DaLo9ggbCy9m2dpEGhxiFZZIFHXxkb0xypflhYhricsHpO6f4CngC3jGgFC5VkVb
         LFcOFbOhs77/npfmRrMAfOcIMfVWyFEmADX/WOdC4wOPhFhdjVvZdV3ZoVYfQXuSWgYV
         lb1wdu0XxPU28Ia/AkXPojzRdc9lZbg8UKdp0SUE0OEXtrLxBbzUU/VdMCql60/macIA
         LkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXC6rYyd2PDK3YoxkwVAQedW79PeQY3arKN62HLrHpMp43YlOls2rwcd0lRCi0HMQ2LbZMNjxzX/S2zA20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DXeGz6a0hC14QE6uCLm8EV44ubNQ30zqpwv0T6D5kGhkqN7H
	YHtO8TyKC+m0djV+ohuG5h/KmOxShwZmj91UqwcOWuE/H/uYCYeb
X-Gm-Gg: ASbGncvhqQdAJj9UAPzSP33Iv5arGcvDhNoykccSQ5L7UotqIKPrEy6u6NBI82Xd0cx
	R3gx98rjpAH31yD1V5Jl8CttXNkOtrDH6N5wFtrllsihwV8LijuX6ietam4hQQjrUtqS3qLXIlK
	BE5sVs5CkIrIUNn1ypE3nJgcGIlO+iS3vqozZ4BgboMxA6H4Q8uzq6I/Czvd8ZPPIWf9rBnYCVK
	MA4Wsnp7NTmhbHwdHstLIlPYorYIatPIoHoR+pz7Pvm/NMo5HL9fwi1DaKONi5cnpOwFcFTrxHG
	/ouB9H3mou2kdfcrGPMK619cgq7PnlVghjgUBWUIKr3X2OEVz9lvqw==
X-Google-Smtp-Source: AGHT+IGZ3tbJNEZfEAj8nuAD8spNiWrpR+xPBxDApkcc/3wYUXEYlvHNuM/ofGxTCSCpXV/bnwY4pg==
X-Received: by 2002:a17:907:c1c:b0:ac3:422a:76dc with SMTP id a640c23a62f3a-ac3f22b52f7mr1747463166b.34.1742897521258;
        Tue, 25 Mar 2025 03:12:01 -0700 (PDT)
Received: from localhost.localdomain ([41.90.66.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c6f47sm7429284a12.52.2025.03.25.03.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:12:00 -0700 (PDT)
From: nancyenos <nicymimz@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	nancyenos <nicymimz@gmail.com>
Subject: [PATCH] staging: octeon: Fix unused macro Argument 'x'
Date: Tue, 25 Mar 2025 03:09:52 -0700
Message-Id: <20250325100952.2956-1-nicymimz@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

warning found by checkpath.pl

Signed-off-by: nancyenos <nicymimz@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 44cced319c11..0155f3c41657 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -8,8 +8,8 @@
 #define OCTEON_IRQ_WORKQ0 0
 #define OCTEON_IRQ_RML 0
 #define OCTEON_IRQ_TIMER1 0
-#define OCTEON_IS_MODEL(x) 0
-#define octeon_has_feature(x)	0
+#define OCTEON_IS_MODEL(x) ((void)(x), 0)
+#define octeon_has_feature(x) ((void)(x), 0)
 #define octeon_get_clock_rate()	0
 
 #define CVMX_SYNCIOBDMA		do { } while (0)
-- 
2.25.1


