Return-Path: <linux-kernel+bounces-523034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9FA3D12E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36D33B445F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A221E3DE0;
	Thu, 20 Feb 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avif8N68"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FED1DF960;
	Thu, 20 Feb 2025 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031875; cv=none; b=mvuj8ydzaWitYidseDsaHth6L9+M+C8J+mJ3bGp7pb/Nqat9+uJEDQy+g+6V/Sl0kcPK7n+/f9E0yczQx3ECpyPETsQ2CFBRusPo3fpyf34B0B9IIALnESlq57U2SmGj4hwY7bYFBHYCkgFfLFXWnh8wmdIoe1c2+3Krn1fprOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031875; c=relaxed/simple;
	bh=Soe1paClsXr97ESMLlXDmT4qTYNBUNJwcL8thnWLQ64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPnx1whEJ7T8Q5Zgp1q33B/4AqaUQrKiTIvQKKQkl1tKcA0Xj1PdVURgPWJK5gX3o/1hT/7zi46ttbs0H9gz++jft0WZHFWcjqbsWR1sul8E4TShMjaN0HnYd18Qp12EWIjKEuU5doL1p5ygcNOX+ez/Q7vpY3FZF8gGyiixe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avif8N68; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so7824145ad.1;
        Wed, 19 Feb 2025 22:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031873; x=1740636673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgZldDq/yO5VWimSLneZAx8qBmg/WC4f9EIjy2qwa9M=;
        b=Avif8N68/Zm3e749FAJIBI07AXigeWjXbfVEFNob940FAYlgB6JEFGDbPSK+Qemtqd
         T8vVF7em6mHgtOIy5y+5R7f2Tt8JtdDLP7tSCWYF40KYFruSC0Sxco1qoIfwA1vJ10TV
         nkW03Y5t3kiQsVg7zCVzgt8NBZOGohbcJYM/4aelwprH7o1Ofmgl3/I9Bd+I8UmCUNJ0
         2bfw8Wocx25lIJ/GNk/my0W8yt5A7crwG4lrd5n1OMbGblPz8rxirXoLagrGEO6vXzCe
         2ZYTofyKS7uhQw1YwRKYKF2hbFWRSANSgbFg+LJf0YOvHh+uI0/8zknmi5kv8ZdxJqIr
         BHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031873; x=1740636673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgZldDq/yO5VWimSLneZAx8qBmg/WC4f9EIjy2qwa9M=;
        b=Q66Shu5/dMP+2sJKXuhtuW+uQaTbBRrx7Itd1IoKnNNPFuHNmacelrypD4PPaWd8fb
         rLKuNQeXuBedLrVtFQNsApYC6Aie7W7mVcX/220Sk/8r9L9zM7otnv8HdQ4GyALkHxjn
         Q1J2WztnzTYybvtncyvqSALskrboHaj7MGzz/ZPyNLvfO0cgemyeEhwFgGMv6DDSS3Xs
         A3XkrzX3eJvN80O6EHPLqHn4CaldfES5Pd4wlhBAu4sagnIkQeRKDnMiihAQ2LShiYAk
         6zhNboQ95vCJFP8wQvIoYdo+8ch3tzUY0jCsyVDQwl6H/rZX+Wt2o4c0wQF6IusWFfnJ
         2vRw==
X-Forwarded-Encrypted: i=1; AJvYcCWEgsVMkNfEgSqOmeVcG0QLDVt93Hig9Fh1uwZPVUdK96k173z0/p3kzpnOutsqOZik9k0WYii7bT5E@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29r3MBisUIZbANpbhUCGj0iFuXZXZL6dA9VT1X2hxQAaH+SXN
	GOT2T95ZDD/75dKFzTxwsK0ODDP62j2/sgwPqITnLmaroRIFziT6
X-Gm-Gg: ASbGncstw+AalgwqtaUokDS+G3hElThUeEo++tbLMM0BaBTVVm9LRyhHAEtdLVhmZet
	NX3JsC/eMTis4aAM6n3QUvtRP9hHeKDVQjxTyqzi1Z9gaw2aeSL6FNkcUzuGY8zIuyRPEBZQhOC
	Nb2HM/QiBT6skQq2E9bA/EqQ4cUeceGlzwS6o6sFpkyyFqRLDxo1X+FB6HzkY0YapdWdULnyjgv
	aN78IIX/hC/MIGuLaQX589MewnB/6U4EKVYgrwXKIRkEBw1s9Xyh1DtgO7sc3NRa+foNBx3dRb7
	QO+3C6h79dWO06eB9UhPGKRM8g==
X-Google-Smtp-Source: AGHT+IGMKCnN108R2DoHpoWY5glP/ASNjPMMLynLcJzPcLDqzL438UYtbPahDYUPbY2rfSfR/ZgzpQ==
X-Received: by 2002:a05:6a20:d497:b0:1ee:c093:e237 with SMTP id adf61e73a8af0-1eee5c58d62mr2325033637.12.1740031872911;
        Wed, 19 Feb 2025 22:11:12 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8226823b3a.107.2025.02.19.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:11:12 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH RESEND v2 0/4] Add support for Nuvoton npcm845 i3c controller
Date: Thu, 20 Feb 2025 14:11:03 +0800
Message-Id: <20250220061107.1718239-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the Nuvoton npcm845
Board Management controller (BMC) SoC family.

The Nuvoton npcm845 uses the same Silvico IP but an older version.
This patchset adds fixes for the npcm845 specific hardware issues.

---
v2:
 - Add a new compatible string in dt-binding doc.
 - Add driver data for npcm845 to address the quirks.
 - Modify svc_i3c_master_write to be reused by SVC_I3C_QUIRK_FIFO_EMPTY fix.
 - Fix typo of SVC_I3C_QUIRK_FALSE_SLVSTART fix.
 - Remove the code changes in svc_i3c_master_do_daa_locked, will add it in
   another patch series for common improvement.
---

Stanley Chu (4):
  dt-bindings: i3c: silvaco: Add npcm845 compatible string
  i3c: master: svc: Add support for Nuvoton npcm845 i3c
  i3c: master: svc: Fix npcm845 FIFO empty issue
  i3c: master: svc: Fix npcm845 invalid slvstart event

 .../bindings/i3c/silvaco,i3c-master.yaml      |  4 +-
 drivers/i3c/master/svc-i3c-master.c           | 57 +++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.34.1


