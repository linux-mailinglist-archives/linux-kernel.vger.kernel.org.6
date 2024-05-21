Return-Path: <linux-kernel+bounces-184423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03668CA6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AE81C20A12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499DBA53;
	Tue, 21 May 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="i8r4Us9G"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB73FB94
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261445; cv=none; b=gfLDmu4+sg2hAE3xH49PHWxF8JSKJtRB4YURjhGGO1pQ7DsBoFm88JAc53X4icqX1DvPJlLMc9Dpr6teZSiFIK22Qt2FCspkQYbZr7/MfNldC9rDelalyGbjkQnNN7U7gNND9AF6NWpIck0Qc/taexxjnuJv7xdX04UFC1sswKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261445; c=relaxed/simple;
	bh=rmQ4T+nGAvY9sCmAPKBpE2xvlymeLhT8/MbFVAM0HMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huuR02qKvJoYJeCkhOlegj7Y2NLjF/h/gaoEx8Nq+0vlntX1TEXnp1n3SHhXKen/ZI70hcmu+N28NHPzcjw80CQAgjmz0hcBAdDyk0UknZftZMfqWctf+Jf6b/w9vQPBfwoUZw56so7WHWmfykSu2BcmWrc7A/To3MUvj8DtYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=i8r4Us9G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd3867556so97637395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261442; x=1716866242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTRE2aAD7nMAx0mWWNU5WX8ozRRvU4vGs8kuCzV19R0=;
        b=i8r4Us9GRiyeOyVPSEt2w7a32KEbiOgy5tJ1XFvN4S3QdeLXyeG2+z6P8NpYPIq8Z8
         oKqnZCi6wqg7Ak2nESlXcfIolDWh/PckweczGSxq8hlWrGf/nWv/TaPc3m/Y5r46/TWR
         kKUUwWEbCI+UwMXAzdFbvuqzaeEsDv1W/MgmwEbBG/1Ts1CfaG8s4zDpx2kiNfIuTArD
         2SA+BO3G7EzYlph3rKpGBYyI/ZgVdvb3XDIiUxKiEAoY9WDhZw127wVJoSqlAqeK0fr4
         Pr1RsWRXtt0zt/w4AXiIitm+j7aWAXEk4M7D0v+otLmvC9gXE6YiMFMRsRhTBUSwiNKF
         0hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261442; x=1716866242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTRE2aAD7nMAx0mWWNU5WX8ozRRvU4vGs8kuCzV19R0=;
        b=gAX3y/sJGFepyn6emoASFBJ0FtufKM6TLC4bK0UkWZtl+t1Y++1xe9JbKFEFnU6Do6
         XvSt3OYfz1nQdbw6NFn3oszFH/l9WIQ6JFz20+QAm+ckWfpaU6wXB9uwcYfyx9HnN9cv
         HnHAsXKrWf72tCW8Cju1OIRSrOJ43sWPdD6VIpQ4T9hXPRsnPLnf0ZdgrnvjahRnFaAz
         iTwiXXO25ol7GuxSSLq3Vfe/vobiB6d0xsukqNzDK69kWVqrCNjeYYGgmv5QkNZZkeu0
         +XGzZmkyih1SyP9diA0aHOl590Bxvb6VimM9sg/H1DWkO1akfioTEeQxtq8lujy2S+fv
         FX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUCOsR8fZonqFpcUeTPUNPL+96ySBGd7HzU/YgGy5qGgshdb72XF48sb70sOourffFZngo32bmgP/vAfxW1tgq/gXRcc1Vk7r4SVljl
X-Gm-Message-State: AOJu0YypK8oK+dpkv3gjTL8VgD3TMZJIQN2J4hhlqIMwTUadPjfgsmtL
	5RiMRa493igHVwbaOQRzgDsEFCtsbBfcyDnHPXqlvAwjMlcQ9gO2VkQF0OtKo7g=
X-Google-Smtp-Source: AGHT+IFviQB0DFnx5N0Y7fin5e/l+PBKg41SVlyUvy91vBLvTO11XDubSEkoRXnQvu5lNy7nUz6N5A==
X-Received: by 2002:a17:903:2986:b0:1f2:f0a5:5cf9 with SMTP id d9443c01a7336-1f2f0a561b7mr82883635ad.50.1716261441515;
        Mon, 20 May 2024 20:17:21 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:21 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 00/31] Staging: rtl8192e: rtllib_rx.c Rename camelcase variables
Date: Mon, 20 May 2024 20:16:47 -0700
Message-Id: <20240521031718.17852-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of series renaming camelcase variables to meet style
guide requirements. Thank you in advance to reviewers.
~ Tree

Changes:
#16 Renamed plist to list
#17 Renamed npadding_length to pad_len
#19 Deleted ChkLength variable

Tree Davies (31):
  Staging: rtl8192e: Rename variable IsPassiveChannel
  Staging: rtl8192e: Rename variable CountryIeBuf
  Staging: rtl8192e: Rename variable CountryIeLen
  Staging: rtl8192e: Rename variable bWithAironetIE
  Staging: rtl8192e: Rename variable bContainHTC
  Staging: rtl8192e: Rename variable MBssid
  Staging: rtl8192e: Rename variable MBssidMask
  Staging: rtl8192e: Rename variable elementID
  Staging: rtl8192e: Rename variable rtllib_rx_Monitor
  Staging: rtl8192e: Rename variable rtllib_rx_InfraAdhoc
  Staging: rtl8192e: Rename variable IsLegacyDataFrame
  Staging: rtl8192e: Rename variable RxReorderIndicatePacket
  Staging: rtl8192e: Rename variable RfdArray
  Staging: rtl8192e: Rename variable Decrypted
  Staging: rtl8192e: Rename variable AddReorderEntry
  Staging: rtl8192e: Rename variable pList
  Staging: rtl8192e: Rename variable nPadding_Length
  Staging: rtl8192e: Rename variable LLCOffset
  Staging: rtl8192e: Remove variable ChkLength
  Staging: rtl8192e: Rename variable WinEnd
  Staging: rtl8192e: Rename variable WinSize
  Staging: rtl8192e: Rename variable IsDataFrame
  Staging: rtl8192e: Rename variable bMatchWinStart
  Staging: rtl8192e: Rename variable bMBssidValid
  Staging: rtl8192e: Rename variable bWithCcxVerNum
  Staging: rtl8192e: Rename variable Frame_QoSTID
  Staging: rtl8192e: Rename variable CcxRmState
  Staging: rtl8192e: Rename variable IsQoSDataFrame
  Staging: rtl8192e: Rename variable RfdCnt
  Staging: rtl8192e: Rename variable prxbIndicateArray
  Staging: rtl8192e: Rename variable bPktInBuf

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |   8 +-
 drivers/staging/rtl8192e/rtllib.h             |  36 ++--
 drivers/staging/rtl8192e/rtllib_rx.c          | 183 +++++++++---------
 drivers/staging/rtl8192e/rtllib_tx.c          |   4 +-
 6 files changed, 116 insertions(+), 119 deletions(-)

-- 
2.30.2


