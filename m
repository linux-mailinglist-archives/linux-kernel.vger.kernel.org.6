Return-Path: <linux-kernel+bounces-528425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04852A41798
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382BB1896E29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F41DD874;
	Mon, 24 Feb 2025 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoQm54JD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012A19924D;
	Mon, 24 Feb 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386385; cv=none; b=XQnW8XvK9yGEg1f3vb/terddleKxVuZ7xCk9P1hdwuqES62HUOX3Z25BEA4KK4segr3qmub629gaXVrgtW3zcfDu4rDgtmZfMFrsp9LpejFLkBlOOdjFv/JBcGJyDFHWLzenMdlpGOv1sws2RRzZYAH/PQlysQTFm+NHWrWuCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386385; c=relaxed/simple;
	bh=LJXNlb8VuJl69ju1cbQ8GeEKDu056jhl3Fkj+aCWgVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXnARgjZRBVFi3288heHzwricTisWQZGuBHGpBiYI1gC8j276x8bHw+xu/sl788a2Gqi0DX1ZFJ7IITnwYUWrF/na8rnARFCJfM+hi8oJ322iJdb0j3z/R1W+wIvOHQSxtGn7ooqMLvE9tk3z/yODR520WUXq7lmqHYZmRgKCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoQm54JD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220dc3831e3so78355825ad.0;
        Mon, 24 Feb 2025 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386383; x=1740991183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zgImrHd0RRBAL4u0fyRPwzKU4+tbk6UR0vRrSIGp7oo=;
        b=ZoQm54JDfKDWZ8XHpCkksr3WaLfHZhizWs9bw3LydT1pmoUZP/TaPN39AFXd5Ojkfp
         dJyAb7UEo42O/6stMVTcMERAJEDsOXLH6re6u+YRsfUksVlI8PNACcmFxtgTQxIqLbK0
         Dgo13g719t9oHiUlKDyabrF2ZkCLIVKMsO/Pcspmy+8LnKZEdyGkg7ZUERzSF1aOPeyK
         IcbS1pgNq+vLWh8BOKUDjXsGSorMqQI7HxKjRDo+wsfn3NfWpxNoFMpwsGO/33S/Mj4i
         EqOBYbnJYfuZE7IJEUmp0gahC00CrrmCH9YBsG0n+bS1c4nzJ/4ge+akdSEPjTpTT+ko
         mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386383; x=1740991183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgImrHd0RRBAL4u0fyRPwzKU4+tbk6UR0vRrSIGp7oo=;
        b=fm8GXRx4wu0XCGuehl7WrIWvz2EJlPFa21ydvRGQjU7KZmpgFCaJwujm94CWHYR2mc
         HdApwAUBzqspOW7pFk1U4N0IHlfZ+qzrhPRhZN0BcyZxgDCXnAhPrsHxFZo2tZa/wR93
         M8oIOsD2MuVqCgM2I33oOD2mNH90IqxNlrX8p8KAxvgEoTT6MpGS7+BqffceW63e3FB0
         8RVOCwsN9LRFMnI+rEpR9ibXtlYZSY3GehMVGwAai2fLDNvLEYzwBdxF/Q9pBDreALCd
         EJMdpZTTkygx+F1y9OTYKfjmaW1A4zKVMm51uYTDVTV5ZNUwCKc1K95FXzag3ZaE2cAQ
         6h/w==
X-Forwarded-Encrypted: i=1; AJvYcCVM0ICjClwVgVDeOy+Klq0saVGfa2gLz/Y38qNIR3XmbVBS2UUYNyR2RoxPhUMGOLCyR3vzRpa1GX0y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7Q+J1Ekjvwbolfx2/MOVciGoAPBeTR7iBRlPQhNEtegF578r
	IdY1c5TD+XQXhJ3gF9h+lw1JGrLhFXoz5/C0zGOaJoQLMTbyqHYZ
X-Gm-Gg: ASbGncug6oMzXpGv33QkuT61yVUpfwQ0S3GGTcJHIksottwQPZYhcNlC+tfLXj8Fwcm
	BSkoo4NwikUGIp7ybHalujWs2OjhECx41PHbMBHgtfiPWe5Q64K0961VE2XC95QPNiVXQGc3pqR
	b90lGrI7KF4F8JmC0b459ZnHyxPigJebTuc5+HtSDlY/v/gphi1SZ74Gjhi9djPJatHKwrf0qBP
	ZMNLJcOtkzTlPaqNcG+GTFwbSwdldiP9ecqpaGlFCr8U7yHtjdVseCPr7OupABqWnD6UG/EOCcd
	TMX95Ya9ArcMiIDNj5EIpAJ3z7gu01zADQL7
X-Google-Smtp-Source: AGHT+IEcb6Vmiu6r39Ib6PZeI+7bMy0EHmy7fhM6DiJP4D28MgnS5rIX2n3fCefV4ha1sPe28cT4dQ==
X-Received: by 2002:a05:6a21:6e47:b0:1ee:76fb:8eb7 with SMTP id adf61e73a8af0-1eef3cbe982mr20076936637.10.1740386383559;
        Mon, 24 Feb 2025 00:39:43 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:43 -0800 (PST)
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
Subject: [PATCH v4 0/5] Add support for Nuvoton npcm845 i3c controller
Date: Mon, 24 Feb 2025 16:39:03 +0800
Message-Id: <20250224083908.1880383-1-yschu@nuvoton.com>
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
v4:
 - Fix kernel test robot build warning.
 - Add SVC_I3C_QUIRK_DAA_CORRUPT fix
--
v3:
 - Add more description in dt-binging commit message
 - Add the svc_i3c_drvdata structure in struct svc_i3c_master
 - Improve the do_daa
---
v2:
 - Add a new compatible string in dt-binding doc.
 - Add driver data for npcm845 to address the quirks.
 - Modify svc_i3c_master_write to be reused by SVC_I3C_QUIRK_FIFO_EMPTY fix.
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
 drivers/i3c/master/svc-i3c-master.c           | 115 ++++++++++++++++--
 2 files changed, 105 insertions(+), 14 deletions(-)

-- 
2.34.1


