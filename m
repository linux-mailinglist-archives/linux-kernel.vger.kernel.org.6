Return-Path: <linux-kernel+bounces-548376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8AA54403
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E331712E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083F81DDC18;
	Thu,  6 Mar 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3h3oMTu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32011DC9A2;
	Thu,  6 Mar 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247678; cv=none; b=ntfH/MIjh/oNaGMySU7NBMBBUKjArZaOlVm/14DXwmqM4qEXwIuXhpx+a6PAODLW2hPdIN8bDV5YQBs/RuarGhjMqoiKUAWhBLzLrdg3fJoRNAWaBHxXGS8HgSc7KzIxKOGKfoyRtTbYXf/s8613chLKDixkCWH6lY0uob4mTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247678; c=relaxed/simple;
	bh=rLvSj0m7lt9GSmkHEVmYftlYBxfKuzUISvzOImEt8sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7YtWJwf/k1XoD3ikCWyWjQyMCfKABPGJJW6lVCRayfETZKIB2h/u8/Lsx1ZCEgfdcftzNUIju3FCzHdH44d43ugFNg/4Z0mAZ85I2Y+bRG7+EOn3NAICqF5m6wpm744TURbcra8hLuXuAVDcAPnNf5h73ZEB1wBCANIU4U8mPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3h3oMTu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de12bso7210195ad.2;
        Wed, 05 Mar 2025 23:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247676; x=1741852476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EoWjrryM3cnb80aR51wUjGslugRyRcpKgUlsMR7wQo=;
        b=R3h3oMTu3MlcJceEprt3oNEl5FIZAX2ypCbS59aGpmdQ1ItYMiwnzMJTZ4vEGx26dC
         EyPUNHDnA8VHwwLLnui4QQKJSWprelIZkB3Z9nzFfM+6J0I8MDO6rAP2aN65N7SvnAW6
         OsU2zM8xGg0FoZWFlqZ2Z9uozil03YjYhDlc2vahOnbUBq7zQ0VgiORsdNHwF9pZePOT
         KjWsUwAAGYwL8rQ0+xMGYTECaOnnsjCV1v6amyT5oKoLCqi2RijBlwIvAEYVzw3aMwkc
         2fD8+sOZNB88q3hMxsa/DicWaApuvcVcUTrJ2o15jTldR4Hri/t4pDE8VgpvGGuo9jjy
         ukkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247676; x=1741852476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EoWjrryM3cnb80aR51wUjGslugRyRcpKgUlsMR7wQo=;
        b=cz8Lc0JhjIB3So8xWjvxyC6rrhipUFlqCO84pr3wv5WtipkXmYAHviVeVpT5eNxg9m
         mZrs5XGdm2OIy1BlWhozYTkncIOswwoTf9YYUi1yZWExnuT+rlttJRdB1zhecIjKjR+4
         ra++6IjiEPRRLjgzfzxjPK4rzkSK/EIASLPwfVVtiOsD7/OjFSFx7gRBm5CL1tj+fnpY
         71EobADordyhKsGK4wVinzp+8twHCcOWsUzdsNsBNOHvwM9DVv7sIeP09B32x2804AEr
         chyzE9X8GHJEtfYKqAP0Rv1ShjVU37EtIrAmyvxAcEIlQp3nrR/f+Ga0aumnpTD5wLeo
         oa7g==
X-Forwarded-Encrypted: i=1; AJvYcCXQZqNPWuuldng2s5i/fkeobxNQ7t5J+4HdIYrfLPmGG4BkcPgNYxzlbCUL/g1Es1kNUKYTm4T/RZ9M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywywy70liiRbJF6IoKINYyxB2e5upCFk4XeDrKGZHpkx0YzN7tm
	hga1OWrm/ZQT7ctqrSrjDVq/TXL/0ST5AJYocsLYuGKTpFCWwcxW
X-Gm-Gg: ASbGncuHBMkAa4NcHXjY2k/gvZT6m6SLj6LjNJhCuORAT2vN69SkJCfLg3puMlGjOfB
	HnIh9OzZvc6DvORsdH2qc8FpX0kaXWAxafiBNcgBn7d+3X1QjJXBrpcdf9w7jV6yb+DFkDpoc6O
	KULwNwGpAyBESMFpR9/Mr7TqbC88XHjLOiLVTaQQYDzEPhqYexDP10DQJxfyzRIVs7IWG7r81Qc
	CAPD2MQ6uBzAUtEE3h4YucHL0bhXGykRGcTid9Rtk/p27MXLv4pn4QArzzA3gdfCi5YVFUNqCKd
	nR9yrZ/uvqjj30PAePVhkd83ucpkw+n747RAlzF2aQbzzdMWfwCACUA=
X-Google-Smtp-Source: AGHT+IFkTNb1TU8QOGhJBLtwLetrv/CPBoiu/a8Jxcw799EbGPWM9Mv0kQTZHRXkBK37PQl1oBhQbQ==
X-Received: by 2002:a17:902:ec82:b0:223:5c33:56a8 with SMTP id d9443c01a7336-223f1d26109mr108359395ad.35.1741247676124;
        Wed, 05 Mar 2025 23:54:36 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:35 -0800 (PST)
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
Subject: [PATCH v7 0/5] Add support for Nuvoton npcm845 i3c controller
Date: Thu,  6 Mar 2025 15:54:24 +0800
Message-Id: <20250306075429.2265183-1-yschu@nuvoton.com>
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
v7:
 - Fix kernel test robot build warning.

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


