Return-Path: <linux-kernel+bounces-207663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25E901A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DE281352
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039511CA1;
	Mon, 10 Jun 2024 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="X4L0ESC3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32D18633
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998540; cv=none; b=mlEJgJqJnXeQzN1araEdf5N85I1Kqb3HVQct85F837bYlL6ymjRp2engkfL4MiUT4482HeXCQ1Rih4OENCnRgshol1Hh1SNd1ORSH9wSyO/OlssElTuOydntS4izspoVsZ4RJ/ZsgsR267Xm4D7eHbB93/BqpNne/2kjJow5AjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998540; c=relaxed/simple;
	bh=bms1Ws3k7s8Pn4nPyg6h+fF059moWEuj8WzmZ/gedPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLQ5cxtfyQGDbOjFmS7Mv+wWsXlQ1F4+KQnei12LuEfPlKhEN5wv6RriL370QDIh1SIQK6QafFX62RclkFQLZW5qQ1i9kiI1Sx3a1IWGKgp0Maoo4vgVSYT92Qi1T7cgLHryeRFVeyWjaCoXbky2CYxK4homzOQZY9IhuzgH3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=X4L0ESC3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70509b811so5910245ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998537; x=1718603337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGXyZQ0AhWdPiVFf18ve/MIj+b/D+nKo1h7kD/lhLtU=;
        b=X4L0ESC3yBtbOneQ9/GHrHdZXoyQyAnPN2bktyHs2gHd+hk301z8b7WCD705p07Gyk
         cncQdiuM5aNMsFbaAT/UnFe/Zr37jczAz9aE/6Ks/7sQdVaj9nGGRU98ddNQiKDMoAtJ
         kWqJzfRU302ceb1XWeuAG8GR8Cwg2gFLIuCFp/oEIvt0gX7qg+rJjQnS8hP/FyN4EOb3
         dvH2WCJ6CnMTDQaG/dOwZCdGtCvt+SBFjNngGFhY80zh9DhKViTyeIjWx36P6RZy1ZIV
         /X7rM8cZDkbaK6lbnkOlCJJQz2Gc70taMH0aYCtOKvih2XqFG+8BkQqTGs/bu9IbKuss
         7Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998537; x=1718603337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGXyZQ0AhWdPiVFf18ve/MIj+b/D+nKo1h7kD/lhLtU=;
        b=WYUUPSszUDpZIx8XkUdFzZGl11y+3LZMuPEAac9P3WJ3p1FhOmZcQa7SzFeCo+yt9x
         aDeuR6+9p0HgrkbFcZa0Gj2Udio3tYxEGkuDFv+yU9ZqxI5e8bNQUDgJRGcMrepwj2D2
         PzR4p583S1aThFvGYHaX+MfuGJJFRWEgSpLgNj/T3BTaFQcX30UQn9l9IPdU8g3kvS/L
         wD7Bqxg8o4wOfy0Rhq/m/O1FignynpIcIpeUuZmqXL+T7fUBRvIxapdmGmIefaPi44/U
         3XQB4eVxFhrmvGJFiqpo3uQC2bLtZ/1geWpz0kC+xBnw/uagYyj2NawA+uCiFsH2w7fN
         kFRA==
X-Forwarded-Encrypted: i=1; AJvYcCW/bgOvx5Vn/xww43q2p1IcLNeMK6NVhVDoE1tjLJPMQlzfv/r45dbTsOuiqwPyGnfzrbv3cIGioSTJdYsPRPe9G+U33B0j3baMuQFI
X-Gm-Message-State: AOJu0YzSzhtA5U+9DM0Tj+fNzXAwB5NP7UK34wtNwKcdmsPYynfqePsv
	SUegqJDOCH8L+bMrlYffLQDOJQWRJ1mlhD1wwlmR4Yi+P+I16OcqVm4q6/XnXPZPITJSQvvlslS
	X8SM=
X-Google-Smtp-Source: AGHT+IFMxxwA/HgDSWHBK0vQ0QSReULjfORoxLkKeGsZKml2iVYQktdR8yJZIilL5zEqPi0X8+l4jA==
X-Received: by 2002:a17:902:c408:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f6d0388ea1mr104816145ad.52.1717998537417;
        Sun, 09 Jun 2024 22:48:57 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:48:56 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/24] Staging: rtl8192e: Maintenance renames and cleanup
Date: Sun,  9 Jun 2024 22:44:25 -0700
Message-Id: <20240610054449.71316-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series attacks CamelCase variable renames, removes
un-used variables and adjusts alignment issues found in
rtllib_rx.c and rtllib_tx.c. 

This completes the last of the remaining checkpatch issues 
for rtllib_tx.c.

Thank you in advance to all reviewers.
~Tree


Tree Davies (24):
  Staging: rtl8192e: Rename variable bHwSec
  Staging: rtl8192e: Rename variable bIsMulticast
  Staging: rtl8192e: Rename variable HTCurrentOperaRate
  Staging: rtl8192e: Rename variable HTOpMode
  Staging: rtl8192e: Rename variable bRTSEnable
  Staging: rtl8192e: Rename variable bRTSBW
  Staging: rtl8192e: Rename variable bCTSEnable
  Staging: rtl8192e: Rename variable bRTSUseShortGI
  Staging: rtl8192e: Rename variable bforced_tx20Mhz
  Staging: rtl8192e: Rename variable bPacketBW
  Staging: rtl8192e: Rename variable bBroadcast
  Staging: rtl8192e: Rename variable CntAfterLink
  Staging: rtl8192e: Rename variable bUseShortGI
  Staging: rtl8192e: Rename function TsStartAddBaProcess()
  Staging: rtl8192e: Fix spaces/tab alignment to match open parenthesis
  Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
  Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
  Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
  Staging: rtl8192e: Rename variable bUseShortPreamble
  Staging: rtl8192e: Rename variable bRTSSTBC
  Remove parameter bIsAmsdu from rtllib_classify()
  Remove variable IsAmsdu from rtllib_xmit_inter()
  Fix space/tab alignment to match open parenthesis in rtllib_tx.c
  Fix space/tab alignment to match open parenthesis in rtllib_rx.c

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  16 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |   8 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |   2 +-
 drivers/staging/rtl8192e/rtllib.h             |  28 ++--
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  |   4 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  10 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   |   4 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |  45 +++---
 drivers/staging/rtl8192e/rtllib_tx.c          | 131 +++++++++---------
 12 files changed, 126 insertions(+), 132 deletions(-)

-- 
2.30.2


