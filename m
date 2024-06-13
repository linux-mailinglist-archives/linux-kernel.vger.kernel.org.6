Return-Path: <linux-kernel+bounces-213519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A3907664
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAF428246A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450B1494C2;
	Thu, 13 Jun 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIIpcRjs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C9144312
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291855; cv=none; b=GtihUtqIOewwUM5hZBewHx2BNBoCqJl93qCIVI6Jwje3Ti0n+Y8bNkHlrZ7m1pNUS5xFnJYfOV6VDKDT4TCYS6jw3dYDHYMhN2B0ojeJAUDFpVimVJIBTtAWLh3IIYoSQgC5OVtp56k3FpanTbaWNCJ3uxlxmd0gQ1OOhbiuO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291855; c=relaxed/simple;
	bh=kJFBG9EnhnvVx5BtGyWc4wfBumRieRFADNoy3amDwa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z50r03pmJrsOy1x6/7VXBj8yqxvvTS428ZKRogb3PYBzqbuZ//eNDfnDeUqBXuUFuytpn9RumpaKy+CNeQDu+uwy+VGbrS9JZZPmnA7rcwpq+isOsiqLv4+Rw2e3AiVU806sfF7D/pGn5M5J5IsMute7zU/YugY2FO2OEipD/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIIpcRjs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52961b77655so1245787e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291852; x=1718896652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWZ9jwhxEyNAmvATs50sdCbv0Ojx6ZhooJEx919ELJM=;
        b=bIIpcRjsu2tuM2pF6N4XBUas0/OhiwRX0DtnTkPnxUzD8JiSHebaLtAXamzTzohkpy
         7g4cOJ0RVm4LBR3UaTpF45haDe2mL7Fy98seF8nI5OKkHm+JctPseiH31NYxJHMgD1lW
         PN4p5i0bAigAlrjIaMGDOiQA1Z+GbhsLiK5xhnbi+Qf7nuKwQ4qkIRe7iRhyvS3s2aWy
         SDVDalO+dM4NwOtm954u+Lji4Dk/tqqlD9eC8xsyTqah+IScsijMeWw08+4DUF2upo4k
         +WKCrhKDV+YiPXw3SUeF0qcPF94Gb0JR4SOw2CvnrJ5TZBH9vmoGoWy/NA2g/p6s6ZDC
         xekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291852; x=1718896652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWZ9jwhxEyNAmvATs50sdCbv0Ojx6ZhooJEx919ELJM=;
        b=IjhS1FYl9DZGi2vNbZY2E9ifi2q6bMLfMMqxbx0BVxI7fEueoqd/DiwcsN2rfsf4l1
         sWTfGQEVFoOWl0k4TVO0qMxiMdR0+P5/Lp6C/DNxjZEmx23QhnmHS4YrBMGgBRGwLaec
         Se+BsNp9NthGNHLEiLW8xWFovZ2LAeIMqsjNWdn3uVpvDZZeODPXd5yYUcoCvnMDSh69
         Wr95MsK8rD+lZwwPyFnt4BWS5vqj2EJI7W7TFuSjw4SP7ShkGXxFzOcl4BiYKm61WmfE
         HcUdZeLihrOs7Rccz7Pp6zJlh2BL0h9KltIwjN/FPzxuLMjpGbSAnQjOKRHaq2N2BZMz
         dVTA==
X-Forwarded-Encrypted: i=1; AJvYcCXFwPaUtnKy2hOJqzIHt4rUnlpLIzV3wh8vNaTaIqBJYK3ze+YRveVEOUavs1UFknWFS1D3VGjNMif5ONH36x8WnDvhv4aLTfBSE1Yx
X-Gm-Message-State: AOJu0YzsjyRSh+wcXtPcDD+t9HCHRAJsDBPGU0+yHTFqh4I/B5ZqBCxt
	QKCxVc/iq0WurLVPQAHRNcK2XTu2R5CXgz0aHQLHlM1TzGdt/AeJt9hN1zV42+E=
X-Google-Smtp-Source: AGHT+IHuZh1G+bIi5eoLswQ+gWxOBBBqkEkfB8P5li66QJlx752XejcutCtA5HmkAxyskmhTlXe7vw==
X-Received: by 2002:a05:6512:4806:b0:52b:8455:a9df with SMTP id 2adb3069b0e04-52ca6e6dc25mr31340e87.34.1718291852188;
        Thu, 13 Jun 2024 08:17:32 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:31 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 0/6] staging: rtl8192e: Cleanup multiple issues
Date: Thu, 13 Jun 2024 16:16:31 +0100
Message-Id: <cover.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some unused constants, macros, and structs. 
Capitalize a constant.

No specific patch order required.

Teddy Engel (6):
  staging: rtl8192e: Remove unused constant IC_VersionCut_E
  staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
  staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
  staging: rtl8192e: Capitalize constant RegC38_TH
  staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
  staging: rtl8192e: Remove unnecessary pre-declaration of struct
    net_device

 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 8 --------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
 5 files changed, 3 insertions(+), 17 deletions(-)

-- 
2.39.2


