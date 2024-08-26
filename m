Return-Path: <linux-kernel+bounces-300609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3095E600
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C72B20D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BE10F9;
	Mon, 26 Aug 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="SnPSJi0N"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D21C3D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631450; cv=none; b=aRT7rYBvBNcDN9dgeVNRTwDIKRrj7E023WbHextCFFrdcR6qUdiTay173XtomPcoq+PkMoN/AjC0Suq3N6AGuNuNSeX/rkN242lKmT8SGj/RQGMASCThVaeDrJ934ItwiriRKEvvVl0NF3AnwFkilLBc6ilbTmZwjFP3xe+nrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631450; c=relaxed/simple;
	bh=NAchry0aDCVtnJjkkBy+w8YQSt5OWV82Os48Ej37PTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNfce3bgJ5S5WLOGKLrAdjPZ6xID0S1OkUX2KBBlSM8b3WMIJazhwM4ptuCZQ/M8u8JYwgCuELbmSUpqB5x73SvTZd84/IN44GJagCHm0CAR/Z254PyWdYc81nNTsmd8oqDONCo+S1MWpftV0tqap2n8LOdeC5V9qOiwIL9lQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=SnPSJi0N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71423704ef3so3021783b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631448; x=1725236248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxwrIexHDfQAJvt4m/cxS0b+MNbREQHM2nv/b10F9zw=;
        b=SnPSJi0NojM+JQG9hjCjlmoqjbcjnTafCux+sd5Y0BhmR5HnW1gCb3lSzr0fRm92rQ
         U0z0ixkbUnNvRZsPw58SiuZAHIAzs193ByTo3SBP3UXp0bmJt9gDXTJAqTIaFHFrlA5E
         8a8Mp3/vNeu4SRa+qBpHZaiobcF3/m/Rcfv01q14TIm1HmOQ7hRvY09P2E8Jd2qfAXlI
         S/bvsc4IfFu0BJ/EgAN3lwnGVc0Igppa08C2Oxar5mTIHm/BEwXjzCtPNHltGJlKrwQP
         nDVTzSLI1U/M/Y+8WmYoV+j+uTO9dlKjdWwGTT98gngYTiWO3xtpTJNCE0jQd7mBEWJy
         4j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631448; x=1725236248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxwrIexHDfQAJvt4m/cxS0b+MNbREQHM2nv/b10F9zw=;
        b=SK3BDBA+6MUf6/FFN2pRNolPd45AgvpQzjImRd6YKkfBbrDnt2pL4oZBdZmvS709uL
         Rc1yyQbxhfgmTMZSbCFiyb3OPYc/68peEHDlmpikVqrxV1gHXSv7IJwG+P7Xvi3L/02y
         CQu9t9c0VOPzb6+4j4MOkuy4gPm/YCFfgqnV/YepLdH9/XJ6o7zCs/i2Witrl5BbZeD8
         GV9DDTpMXcIzX3kbBfvpogJ20LGeG3qGPdD9GPbVh9c8NB2dBS+/NZMmYHNNysx5U8aC
         WBjFhk4yNfDtowSCG1YrC04QC1c4MZhGWeF88LwVS7jmiwwbhE6gu0/lNg21/0jgVwS9
         cm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCULPhbRJd4VA6//uJAjxIGS2jAI1KlB1OKZQgNSqxlU20+d82TBET9Scpae8fTmAeiBmOR8w8ENTjm3YCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMWNUdc1BxlUkZIjVW/Zjwz65U4obGUHvUNDkpXNsuihmaubq
	wwTxCd2R6WnixmkPmNdSOre7KTlF59YG3hRO/7yB8PSvIyQ38vAS1JtoYb+XKd0=
X-Google-Smtp-Source: AGHT+IGp+p5DxtAbqeUrS5pPr1JMjSHySSu21bUTz52Q9QYdWlE/PcqzSKUqH/bORi4aCeSCzfqWTg==
X-Received: by 2002:a05:6a21:78e:b0:1c4:8bba:76e4 with SMTP id adf61e73a8af0-1cc8b61b54cmr8913801637.50.1724631447732;
        Sun, 25 Aug 2024 17:17:27 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:27 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/6] Staging: rtl8192e: Rename vaiable cleanup
Date: Sun, 25 Aug 2024 17:17:18 -0700
Message-Id: <20240826001724.274811-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleanup up camelCase variable names

Tree Davies (6):
  Staging: rtl8192e: Rename variable CurPsLevel
  Staging: rtl8192e: Rename variable bLastIniPkt
  Staging: rtl8192e: Rename variable CmdID_RF_WriteReg
  Staging: rtl8192e: Rename variable CmdID
  Staging: rtl8192e: Rename variable msDelay
  Staging: rtl8192e: Rename variable bCmdOrInit

 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 18 +++++++++---------
 drivers/staging/rtl8192e/rtllib.h              | 16 ++++++++--------
 4 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.30.2


