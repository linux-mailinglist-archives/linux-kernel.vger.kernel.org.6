Return-Path: <linux-kernel+bounces-535662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F048A475B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D593B0D27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5221519B;
	Thu, 27 Feb 2025 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao1d9D2T"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB12E403;
	Thu, 27 Feb 2025 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636107; cv=none; b=P1ux3a9j3ZByP86j0EaBTSyH1+pNgAyKHZ2vFQDe/2y7IpTdQ6iPJSmQ1jeGe8OiDNAa/qUM8ImAYtZ7oTvVgrv4hYRwXQvkXr/RbKOGwfcpQh0i9L7zCAUL+Dlc9QRurgQOVUwf3wi1fM9cGabYjmXys9rhVis7+4qw3f0UWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636107; c=relaxed/simple;
	bh=rPsLXSIlQSDCrhzxipSR0b90z+AZe/txP8doGIMPNLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GyzescKGNrnSJ5wiACqgz4IdmPDLPnOYBPWBAHHmU86DzmsDidthCuooDJDtk8jD391tX+EwICPElpUqJV4FCcGndSZmgshEfVozAjq2uvXnqQ/IRTXLRuPceobT/OCKkxrjpyBCoarptRptXW9WOlj4SqIHywKC1aPTBDYGBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao1d9D2T; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so1005346a91.0;
        Wed, 26 Feb 2025 22:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636104; x=1741240904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mQOD6qMSjdqWtzCTx+pFa0M8XN6p/c/XrJV+5EOBBM=;
        b=ao1d9D2TuVrpFCHqBSTxaepvAelyhYyt55Wn0U8OSBjPcx7jQA0el0NqELvaHw9GVw
         IjTAx1hylXDq9Y6/jghmp8EeJnmvyBlxwyD0FXE7NiWxwnoZrRH5lAjY6eT1h9qOCype
         QXuhRJcBqNznj7TPD1MO/A0uRPlAyjr+22iM/I8aRIkfJGDUwK7VbTVu873Ydn/36f8D
         UcA1hudiqTp8VEns0l3KguwhukM8ZTENnAqHAvhi2YduFio4ng1qxw4DO6v1HXZC8Ynv
         D/y1d2zU/q1cQ9xahSiLblEFoFBADptyYEyXlhPvMsT+AJFmSf7GM/T9GgBQSt+NR+n/
         0jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636104; x=1741240904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mQOD6qMSjdqWtzCTx+pFa0M8XN6p/c/XrJV+5EOBBM=;
        b=PZo3yfHat3b3dF7O/oNc+Psn3IVOJ/mVsJBQN5yvc6xfFYU5CNeBl5JEzoeScnWweU
         L4kS+ftdI5BDmESJxhE5KgOD5y28C7L4SrIbE5Ms7v1kFnLGIskaZGo9Iqd8nZi1Yrq5
         NTrNrT22XqgM+8o4hpoQ3rppjpzNDxe7cBxFyBDaDUpBeSrxWJ7KG2/W33iynftOrQ2o
         i6k6gVblJiagC5W33YXFrBMX41KZUujBpfqyCQNLcLF/xr76ozi93ke0hQyZGTHyz48L
         LxdFbZDDvCh9oHpQfFvXPHH0kMxe3ernihRKT9sgeCvXkJGsvz077S4QXObOWYM2DdD0
         LlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1+QynGzVLcq61x8erR8Mix+SduOhSMlbFSzl6XMpzyg1xPiJPkajdzmWVPGZdtW58hwGIkZ5Ypqii@vger.kernel.org
X-Gm-Message-State: AOJu0YzudOOujiDNrRuKEh6XKrAvE62G2yp7I5BXFU3LSq2AlfodFDFn
	x6Y41PeFL+84OKA0/5Bduy+jdpt/CcK2BT45SpKG0mPq8AlkQebk
X-Gm-Gg: ASbGncs3OxyRlPo9ESAUUxhmf16aTgatKcRhRD3agZAvXi0wqQc6xXulWryyVN8sgYf
	hpylxfNX7hkN6su5Je75nWY5PmUczW206m8aSkkLa1xVa0+eX/NMZBH+1cLauIu0J0g96b49kQ+
	ilqSi1AX/ImcEuvLeMLzlMphtaBwGctEpDLlUi5DbCv8xt4pFQeMw5zEmjhlOGDB15DedWxAkpH
	1utRLx6YXfGUm/ZnFYBxbYFlsNDLs7OP5lg2yz6+ASc6dRhkiUAB7ii8q3G0bwfBQSenc9pz1Nk
	Uft6C+zEDnST3Va6L0iLBk4dOkf/nmYEbOr0
X-Google-Smtp-Source: AGHT+IFuEs4AAjjifzVRpqGnWLY52CMxLXiU8hn4T+n1HgSLdz6Z6rVMv5YZ5DGLwtmkw/hJmQTEUA==
X-Received: by 2002:a17:90b:2588:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2fce873af65mr39994730a91.24.1740636104120;
        Wed, 26 Feb 2025 22:01:44 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:43 -0800 (PST)
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
Subject: [PATCH v5 0/5] Add support for Nuvoton npcm845 i3c controller
Date: Thu, 27 Feb 2025 14:01:26 +0800
Message-Id: <20250227060131.2206860-1-yschu@nuvoton.com>
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
 drivers/i3c/master/svc-i3c-master.c           | 123 ++++++++++++++++--
 2 files changed, 116 insertions(+), 11 deletions(-)

-- 
2.34.1


