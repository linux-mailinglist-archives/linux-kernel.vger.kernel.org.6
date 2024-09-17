Return-Path: <linux-kernel+bounces-331287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D197AB01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D992628A812
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584E446DB;
	Tue, 17 Sep 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GEW9ZczD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701B4690
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551118; cv=none; b=rGVMXuz0IiWDc+r+GXw5HmmaRPf8w0NNGqVOoA7d+hvIluNZ5Wu96lROE3kpgsfMKWycmaY+n0zLeM4zNh07MOZrUgirR+QVtKVaIf+dQAXsZrclp3jqvN5Kx0Z512rZWKllSTTIg44dzxo9zc9QcQgwHzXhZhU0G8x1HL3x2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551118; c=relaxed/simple;
	bh=vB/6gPefa12QWCfO9e9MQ0H+EUnjA7We5BRFa/kPRmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvz+AQdVYewwJ5jAqKvm4GL2kcHD5LFGrdRvI8RZr2VxF1VDhwCVR6fJbOm6CBB1JMVIELlc7Iuy7Zpkl8Jj6VY/eW6wBdlb7c3JnM2dqSbYFmYnKEDB15/ZUCUlPW2SCw/306NoSVV4oNvAKaQTvLZfA0f3uT9HnYFfVny0B/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=GEW9ZczD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4147983a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551115; x=1727155915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4+rbOwWS2DJD5HVsT+VzMKozNo+bnQY21oBRpMmEKE=;
        b=GEW9ZczDPHhS5WPW2IST8vw6QQ0DuoP2F/5H1+0KOzzLKlV06e3c6pcwDVpnFZrE0D
         0n9EWxrC5l5A8v48lAIV8i8Mi8amoRFB7n+zqFF1DhhezGHDcoiiWHLEwSqKhPYGOCEd
         Pg5HEKCXY4esDnf594zCTK7XqV2iOdkGcWr5YciFikDejmZUv7fK91Zv1VSc6aTli8QK
         8pDfxUAUnTpaVww8xcUfRo0euS3ZYOL+uAh4Tda7M0Z/Udd4NxfDSzWgBUtVOBwFXJqP
         szjiHyyXGgWU/fo9PaneKxDFotIcvdA3PaM5P8igPXZpS1B599Lkwzn5LlZNu5hmszdE
         bnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551115; x=1727155915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4+rbOwWS2DJD5HVsT+VzMKozNo+bnQY21oBRpMmEKE=;
        b=R95TBrYEZGcFHntzmbWAXrEeWutyqOfR5AecBoh0Zg22COTfEf9n9vm/suqk8d15dy
         xK7v1AlL79pho6ikj2QYmkdPXqmY1LE4RDi03gTvIYNLSHJps3G7+kMWqhuiATG8/W3R
         Jax7vJeWnsXMCoNdpvx3zK7J7WJrhsIJgQQBe+M4R5Z8ClPaX2iv3GsLUw9fNzpbH6oR
         RZTcD7nHJ8ZEsekjDyGXgnAPpIpHIL9yNA7dRdW/Fj/Zzyjh2v3EigzAEzK0Rw+s1pqm
         ZSs1n4NcMzp5JTWNRNuWDf4fIlT8yNlKg6bNpeS+w9eNEVUA2H7eGY5MhWiJbvqfqqXx
         Sftg==
X-Forwarded-Encrypted: i=1; AJvYcCURFXwVtE1R8/ut4e6+KaCYZqBCPMpK4PJM700C16dgbLweV+YKElEyWDhQe9eNL54eV9nzaV9PzTFAG7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9CVJMdMIx7vRpQPCw5OVhOUlnnHBAsdWf9uQNLq7foejllOJ
	qdMnmNgP2Z98ZBq6aKJhji8lLRUCqReuI1d2uZkQkxASfCXk0HxTOqxUT6eA03tqKnkW20wzmZ1
	2
X-Google-Smtp-Source: AGHT+IEce3aewCe+0Wdm7Lx+Pv1FczWLHVBy3xP5BWihRV7NTQtpgjIcFBlcxur2cIxwgHHBt1Xjpw==
X-Received: by 2002:a05:6a20:d808:b0:1cf:50ce:58d7 with SMTP id adf61e73a8af0-1cf75f65c3emr26253133637.29.1726551115409;
        Mon, 16 Sep 2024 22:31:55 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:54 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/18] Staging: rtl8192e: 18 more Style guide variable renames
Date: Mon, 16 Sep 2024 22:31:34 -0700
Message-Id: <20240917053152.575553-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes camelCase variable names
Thank you to all reviewers.
~Tree

Tree Davies (18):
  Staging: rtl8192e: Rename variable nDataRate
  Staging: rtl8192e: Rename variable bIsCCK
  Staging: rtl8192e: Rename variable bCRC
  Staging: rtl8192e: Rename variable pMCSRateSet
  Staging: rtl8192e: Rename variable PreCommonCmd
  Staging: rtl8192e: Rename variable PostCommonCmd
  Staging: rtl8192e: Rename variable RxDataNum
  Staging: rtl8192e: Rename variable FwRWRF
  Staging: rtl8192e: Rename variable bFirstMPDU
  Staging: rtl8192e: Rename variable bPacketBeacon
  Staging: rtl8192e: Rename variable Rx_TS_Pending_List
  Staging: rtl8192e: Rename variable bPacketMatchBSSID
  Staging: rtl8192e: Rename variable bToSelfBA
  Staging: rtl8192e: Rename variable Tx_TS_Admit_List
  Staging: rtl8192e: Rename variable Tx_TS_Pending_List
  Staging: rtl8192e: Rename variable Tx_TS_Unused_List
  Staging: rtl8192e: Rename variable Sbox
  Staging: rtl8192e: Rename variable pMCSFilter

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 50 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 10 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  6 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 10 ++--
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 36 ++++++-------
 drivers/staging/rtl8192e/rtllib.h             | 34 ++++++-------
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |  6 +--
 8 files changed, 77 insertions(+), 77 deletions(-)

-- 
2.30.2


