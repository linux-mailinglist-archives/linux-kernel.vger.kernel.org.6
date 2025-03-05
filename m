Return-Path: <linux-kernel+bounces-546043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD9A4F580
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEB1188F95B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176117BEC6;
	Wed,  5 Mar 2025 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbGc6VDY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E62E3394;
	Wed,  5 Mar 2025 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146279; cv=none; b=C3UsU7VTP6rlSSSKsxNPAla6JJLn7X86Lgwxgx9qFMIHk+mPEnr8+NqHZ67Is/npQ4DL7eXY25OL2Nb0ThOjHTFMsZQVigWzkv4ztH5EICRUS+E/S7bXJXx0nlP13nSnyCTLq1gByqO/nW34LQEDBGreXZa2WHQrN2yVptD3J1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146279; c=relaxed/simple;
	bh=yEfzXlgj/fjBGD7g86podDUNwYc6SHpNLxtVt5MsQUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEee8z6TzgVUPHWBeezymLG2AM/z39VzL/kQAX8xtlBYXzUNGbJp55Dsdycvhz8rCXZEfM3W36CpP7sB9VKDqPiW+vqSxz9eQRInYr1uk4vK9Ul4X+Yh3UMhlMstw5G4z5YjZEfk12jtjqbiAsvDArgViTqwld+ANeaOqb4AwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbGc6VDY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2233622fdffso119430265ad.2;
        Tue, 04 Mar 2025 19:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146277; x=1741751077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+mPOlRZ4KjStxcBL3Z6AAydz8YkO5iSHIPj72E4lQE=;
        b=CbGc6VDYdi93CIqW0M+Xvr88WC7WG8o/Q8zYjLg1AFMFI2nHRaLGOnE+Me49um1evY
         xTfe0WBKBCnv1YP1v91t1olRLX82RpvNlX3uFGGO4qeSz1srHA96I60IN2MlyHs4SfuI
         LNW29smyw+vDACOGjxSx7SKeZsGklh94oOAclAuBSnCX+9sGVaU2ecQZsAr1S6kEcB2K
         FTTp0PC+3cowl0oQW+EPynX66GSBli6QKM2EgzX7IyLXX9JgOcaViJGmE1PonC2SRjxM
         FjHosDUHUIxTcM5WGOPRljobeGUgKsy3Uik/6bl2iiPZ3n9oyJI9YeFMfah7boirZdVP
         8mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146277; x=1741751077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+mPOlRZ4KjStxcBL3Z6AAydz8YkO5iSHIPj72E4lQE=;
        b=TWfwfWwE49SkbzRtQpym/fAlw61aqRItLWm46yUlm0MObV9HGEidvqYG7rvkvPXjVX
         Bdo/EHyCLzQTYppoeqmUa2wi7P8pRy6coKHRZ8JO4cEJM7YKxJC/OCSGtm5X3QklhXq9
         xj8Ff1Wk/pb8qhDzT6BVFyP2th9umOfHqAHWey/IHK+IFHZHum1vwTs/oCn8+GqCUjNL
         /50Xa+x0KjKLAppCaeVsaAFjoxpXW3TLlIVfIndqnFsrOKyrkUl5PgBjv8cnk3HNVQBs
         u9wpT5aVQglOJ3wWLZTC+2U9Z2oCcx6xmKRuHYJZva6r7lurUXWYD0hXfMa9sY3/e+a6
         p7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUZksgIJUtR5L+l/C9XMqJBj97oGbTzxAavwrTBoNDqo7byoAlWY3BxBCUpTG2Hv52H1dGQbYeGb1vF@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPbBkRgyEXZw5CnVMv7Xjp2+8eaIJ2C8GTMEASHGbCXd+30qm
	mR13+lflG8Crgttf14xK5fVDZe8gB90ZlRovJ0NnYBh/w5vk9f70
X-Gm-Gg: ASbGncv+j/UacdGrgi2kqW1Cq7jn8rzCIWs5vxp3dia5P4ZbhHcQvIhiZ5SlrWSDVAX
	KTkfD6GcOBiMqVDXZz4K534+hvA/2u+Cl0QLmkmR3JNTBNBbqY4o5Pt7mh0TmOSSPeGnzW5T0DH
	bW83G7J4mvrbEnA5/ba3zF5V+EDx4SMFqNFEVBPAKAviDASmvmja8lRxjNYv7p79BzVppwVfcx1
	JSRe6S0tU1VX26CoURW3NxS817BwnPLBx2ooKEQaKSMzC7iglsRKfccOpaTGArvFR/THtwvdb62
	A2hoPyeYtld8RfKnOCtieEsOWclHLoEjjnt+g0aeB3dTqbqU4oR9F2c=
X-Google-Smtp-Source: AGHT+IEl3ybxCxPWvhfjzdCxrRkFkwGL9AXhPPB0O84T8rMHBFkItUCVeOf84SGTH/VV798lvDQFkA==
X-Received: by 2002:a17:902:c949:b0:223:517a:d2e2 with SMTP id d9443c01a7336-223f1d548b2mr26251405ad.53.1741146277279;
        Tue, 04 Mar 2025 19:44:37 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:36 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v6 0/5] Add support for Nuvoton npcm845 i3c controller
Date: Wed,  5 Mar 2025 11:44:09 +0800
Message-Id: <20250305034414.2246870-1-yschu@nuvoton.com>
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

--
v6:
 - Define QUIRK when it is really used in the separate patches.

v5:
 - Add default driver data
 - Add helper function svc_has_daa_corrupt()
 - Revise SVC_I3C_QUIRK_FIFO_EMPTY fix and add comments

v4:
 - Fix kernel test robot build warning.
 - Add SVC_I3C_QUIRK_DAA_CORRUPT fix

v3:
 - Add more description in dt-binging commit message
 - Add the svc_i3c_drvdata structure in struct svc_i3c_master
 - Improve the do_daa

v2:
 - Add a new compatible string in dt-binding doc.
 - Add driver data for npcm845 to address the quirks.
 - Modify svc_i3c_master_write to be reused by SVC_I3C_QUIRK_FIFO_EMPTY fix
 - Fix typo of SVC_I3C_QUIRK_FALSE_SLVSTART fix.
 - Remove the code changes in svc_i3c_master_do_daa_locked, will add it in
   another patch series for common improvement.
---

Stanley Chu (5):
  dt-bindings: i3c: silvaco: Add npcm845 compatible string
  i3c: master: svc: Add support for Nuvoton npcm845 i3c
  i3c: master: svc: Fix npcm845 FIFO empty issue
  i3c: master: svc: Fix npcm845 invalid slvstart event
  i3c: master: svc: Fix npcm845 DAA process corruption

 .../bindings/i3c/silvaco,i3c-master.yaml      |   4 +-
 drivers/i3c/master/svc-i3c-master.c           | 127 ++++++++++++++++--
 2 files changed, 120 insertions(+), 11 deletions(-)

-- 
2.34.1


