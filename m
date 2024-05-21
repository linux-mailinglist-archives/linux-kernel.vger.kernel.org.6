Return-Path: <linux-kernel+bounces-184408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C48CA698
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358ED1C215B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE71B299;
	Tue, 21 May 2024 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bLvymVVa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4118054
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260542; cv=none; b=iSYRe3r2cHOqF61aREm6EDknbqFMhnEISADSl3VOmYq9MjTsgQXkg9J021H6JBTYf7RBdqUBPP2pLI+NGzD2dcIau5tNtzNXJyPbvW4UUt+2vG0mfssLaQuqdHG6jkEOwsh6evu/MJq/gq+ARaZhsTQW/tsyHM1GMPws6t3la1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260542; c=relaxed/simple;
	bh=rmQ4T+nGAvY9sCmAPKBpE2xvlymeLhT8/MbFVAM0HMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lq/SkFEPyfiihwTefmTNEkE3vkt8QMkCkizTEXEj4HaTp7c8512Fh1/N8YeYhHul7aVAMBvO2TG3gSwJUbdfTqDxb91+6/BFt5SSlnYJ7Q5H+qZBpAUoBeGKR6T/tioMF8CzDdtR8Tn0za8C7VvInciyZyA60cH10fnGkgphUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bLvymVVa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eca195a7c8so93050475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716260540; x=1716865340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTRE2aAD7nMAx0mWWNU5WX8ozRRvU4vGs8kuCzV19R0=;
        b=bLvymVVa/7EB+KQQC7oIuEejyrP3LaqfpRBQ42u08Qndmd3/KnkprZH+lR2aB9Cu+g
         GxFhMVWxeRNjlYMzICdxMh2zhGgBydrqIRn/Tj02NfCT0/Wi29RNwUBUU0np2rtbgVgE
         xrESXTe5wEQjOhcsMx3RpSfeBpAk73EE1THfV1+WO8esQiV8v8Xpb9cuwt3evlKZA4eB
         oKOpgHTxz1yB4nwXZULZgqFdlLcN3Qdg5KZ/HbChAJhlUoIcQdi85coKxSozU6wkYbSK
         O0pJHuYG7xsHqm3ZO7Dk3xUYEW9UUkbSmY5ZpOyRsIqbJn/P5eVjA6f1NgcgrSPbumaD
         UP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716260540; x=1716865340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTRE2aAD7nMAx0mWWNU5WX8ozRRvU4vGs8kuCzV19R0=;
        b=jj3YoPM7qYmY1JsTUrj0pVqVNIGWaMWjKoaidzIzX2AAjpVRurpK72G1NVZvgZiJ2M
         yk2JVXqi+XCuGUhf6Fg3vxt+Ksa//DQ9GmHO0xsI4gMFT539HtOkqHyQBQcdGLG7Hjqc
         zhm4xTLPyn/mYPI17Je8Wsh+fleZmpA+MsiDZOkyfBzFiW9dg+P7IKhPxRlpGtsnSBoC
         hFUUpJmWt+j4u1FmH0TeZPTubfKBKMiTS0aOu3BYy8dcFFT7pKX3CrJCEJ1ix0U3+eBK
         bAZ6ybpdLTsfz8TStJjXxaU4oLYfRtYOZzFciOXGeUxmTLENUIqStnHzlalwMGrpjmyf
         c7tA==
X-Forwarded-Encrypted: i=1; AJvYcCWhgrPrJHOa/jBLMFwtkj3WHHXinkJhZ3yGbxCWzxnQ+hfI4ehMgdvV1qGH/ISbSewDK+rUTrlOHeYH9548VWwC1gxozNR2iov+L5ET
X-Gm-Message-State: AOJu0YzjVtiSOfHLyzPr8FAq/sOOhwpSUGZ+/B2IUBAUcLHjUHpuA6aA
	YdQZ91o5Fsj/HUPrkBBY/9uiCVD7JCQvHgk2vlR5fHs2tZd2zJTFsbRUI64FKXE=
X-Google-Smtp-Source: AGHT+IHxVX9iKGp3mUZ7MrQHFcpj9+avbawMj0Nyc9UVoPpd9OzQp70+XukMmO0BFRk2ZOf0MntDCQ==
X-Received: by 2002:a05:6a00:18a0:b0:6f4:3c65:d05a with SMTP id d2e1a72fcca58-6f4e0384f7fmr34486334b3a.30.1716260540065;
        Mon, 20 May 2024 20:02:20 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134694dsm20213029a12.77.2024.05.20.20.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:02:19 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/31] [PATCH 00/31] Staging: rtl8192e: rtllib_rx.c Rename camelcase variables
Date: Mon, 20 May 2024 20:01:45 -0700
Message-Id: <20240521030216.16842-1-tdavies@darkphysics.net>
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


