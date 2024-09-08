Return-Path: <linux-kernel+bounces-320370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62497096F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8DF1F210A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421F5178CEC;
	Sun,  8 Sep 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="TT5dq0p+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256862AD39
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823599; cv=none; b=Wk8jUrq97SqntEKWll2Yv7rf8f3IEv4bHxmQg0PRjjapswiPZ70mzKvi5JfcaK4KadA3PJn2WTdqYOYEQp0KT5VL5lqM8qBuZAGJ6gNRYTUchjuPdpmKA84Ki4gR4nCJ3ASk8FVW9gRss03AzdREOTXcif7eB9gWsA8bCr71T0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823599; c=relaxed/simple;
	bh=oh7xOrezfXMdj70gDloEJiPeQiqg9Utd1dlbZvZkL6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rv6jlQKIrQZZbG+H3n9EdufISk6lPbJELkRTl+rejd4uFU7uKdOue1DybKZOUhrEe3LG41DMBVqLKVG3d/G8HoEsHuYIoefq12o/BTd2YgLCJGDfvPVaQvy5LM5SKXVONfAfINGASwA4JeUN0Q5J/pYdZrWSv1D3dfzDWDBpjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=TT5dq0p+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053616fa36so38389815ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823596; x=1726428396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6OZwDJfzyuEIzacv15rMgDT3QaEj2vd9EVCE5bpQQ=;
        b=TT5dq0p+i1VOpYiaUXE1P9EMdPCGXOTdYEt4MUHIZ29W4xEEp7cuesxo90zSjDBVej
         0p79i+u++jpzgiVQa6bK8dVuML4hAC8vCIMRqo1QHlBbAPJtTboIcLnk+ISizTkYQiXh
         VnHSDlfE46Kgq8nTalZWE3uK1y/rBGNj/W/wsfjBe+LkM4AkGNnuwOWrdiSrFjR0pI0f
         NGj0bjBU2MhWhLNM1ajaLfMdImZ4wueQZatCzQ8q8fzHL8Mhe3tUI5kSdsqqiAHxjqIY
         /Y7L5v5sz5lByAWO2lRto48IFSZgfeltAXWTmbHU9RR+uZG51HnKX2utgMPIYloiEWdv
         r/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823596; x=1726428396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ne6OZwDJfzyuEIzacv15rMgDT3QaEj2vd9EVCE5bpQQ=;
        b=Sa5yOFOs8yDnqDrmthaafpfimMBcehoXuu4UWVR5zaQdPfS0ve/mGyTprVA5Zj7eW0
         fCRJA6BITUtXcLn36gox4SHTO81GuTJ3/r5tPb6oHwmN8AsoKr7MQTwn+YYEkQKFV4WC
         T32Qko3TN1JplUZueuH38IgG8CB9ODtf/v3vMScnHcXeHJMEtOXuB4Hi/1QdT/t3BlM8
         maj9BYvN6aXmkbL71CTh8XCdmfYvUPBT3WrfI9WYRTgHCsjmo+jqFh4J2At3DeJ9yogG
         7F4a1FqCHR31agGtGJEBDUhsGv7mGeHrH0GP6oYki7a/nAE95L190VvSfXQIhsBmliSU
         Kwzw==
X-Forwarded-Encrypted: i=1; AJvYcCWmZ89wMGc8DvWlRTmQqnfJEYlwbnEn6GmY452008aRJD/sqSYE79nBUFxACN98IuMYcGqoY7c2mu0mddo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyufwJRfyxhpzFwjjqaRtMQYONwvYAvkf8M5EhXEkIUonG3yRqe
	l+PPlIg7AhNUyxCAlvEGIyaqRvb4bmLDLzejiHPVCyJ13ueJmNm8oER+WqiAnjU=
X-Google-Smtp-Source: AGHT+IGmXMHK3iudCDKeF1n9Plkrrg7jMkPEXUB3BKTDnDHUcbjFCBO5C0lWmpQ6h08ASHTfH6OYrQ==
X-Received: by 2002:a17:902:daca:b0:206:994b:6d53 with SMTP id d9443c01a7336-2070a553890mr66411705ad.30.1725823596236;
        Sun, 08 Sep 2024 12:26:36 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:35 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/16] Staging: rtl8192e: Cleanup even more camelcase variable names
Date: Sun,  8 Sep 2024 12:26:17 -0700
Message-Id: <20240908192633.94144-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs variable renames
~ Tree

Tree Davies (16):
  Staging: rtl8192e: Rename variable pReorderEntry
  Staging: rtl8192e: Rename variable SeqNum
  Staging: rtl8192e: Rename variable SignalStrength
  Staging: rtl8192e: Rename variable pFrame
  Staging: rtl8192e: Rename variable bPacketToSelf
  Staging: rtl8192e: Rename variable Para1
  Staging: rtl8192e: Rename variable Para2
  Staging: rtl8192e: Rename variable ScanOperationBackupHandler
  Staging: rtl8192e: Rename variable Operation
  Staging: rtl8192e: Rename variable bAssoc
  Staging: rtl8192e: Rename variable SignalQuality
  Staging: rtl8192e: Rename variable isEncrypt
  Staging: rtl8192e: Rename variable nStuckCount
  Staging: rtl8192e: Rename variable bAddNewTs
  Staging: rtl8192e: Rename variable RxBufShift
  Staging: rtl8192e: Rename variable RxDrvInfoSize

 .../staging/rtl8192e/rtl8192e/r8190P_def.h    |   2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  40 +++---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  22 ++--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  14 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   4 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   4 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  30 ++---
 drivers/staging/rtl8192e/rtllib.h             |  32 ++---
 drivers/staging/rtl8192e/rtllib_rx.c          | 116 +++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
 11 files changed, 136 insertions(+), 136 deletions(-)

-- 
2.30.2


