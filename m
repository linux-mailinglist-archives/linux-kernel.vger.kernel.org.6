Return-Path: <linux-kernel+bounces-179406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF18C5FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401C41C2100C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D139FED;
	Wed, 15 May 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MnjLmRpP"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDC20314
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748757; cv=none; b=AA8O6RYLvYATSOfYbPk24+ezi9MHTR+Y0N/SfQvCZsrNZ9ERJlWUr3A3u2t+Ub7b6ZZpBFmiT4H8+b7/1ltNbD+8qza2Pi0JPICMDsOZzd1ka2tKhNQ+qqAGnXk4CX4E6W1j1efHBcMLcjQUorK2jOVtj+Mg+e2eOczYmIN9Dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748757; c=relaxed/simple;
	bh=qXSzaE9bVH2Q8DDXlnO3VvXrcu9RLi+wQbEvYhWZFao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9r3wOFN4VQ7O2rGojX25c1a0sM5ZmnkkIGhiBxIptKQEpuW58vA/lW+z763KrnklPlgKkQxIwkK3YF/2pEznqAN357XY0GX7/I+Zrwze/0kznWK4SY1QWwpgkbT4pTnfW+dL4vRFjIUHhWLq9+x788huOtg0sn0UhI9QWWh5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MnjLmRpP; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ad2da2196aso4110416eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748753; x=1716353553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGK0Y+Ay79UTLYMwgp4ltlyyvJGTL7iwngRnNpkI1QM=;
        b=MnjLmRpPBSzrhNDkwu2OeA0rTEWkjb/ddtjGxZYt634r67CCG1C9YooAW0GBKe6HYH
         qMO0tgwi5Bv3EqAGBuxvYs7wZ4WV7rc3TZg1lGFhMBy4obj7DwuGwpSWEcmVK0h4HB55
         ZWqiD5X8P9acaz3a9DvbpA0TtCRq7Tau5Eg+YwOL6E9zMhKxfYGFKRaMHteR1/N4omkO
         QUENAohpOUbeyJzMeNL/gayAnJvLO5O6O4RzMudFwz4/zWk9GgycQniYR83AWwetOzW4
         xPt4XRI7lX/T1xdg2p6FA4mT+m6LCiqmQepGTU+zF2LjUR4n1/HV22njeFoVoiA8HchT
         y4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748753; x=1716353553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGK0Y+Ay79UTLYMwgp4ltlyyvJGTL7iwngRnNpkI1QM=;
        b=E+/EI8SqTPvxUeXXYsBslQiSZNp9jWS+Xy2QaKFu7qpODEPLhECct3wa/rVKlFwuIv
         F+Rpm7p51pL515qR4F7nbI+RKbuAlsO6PNcFT8zqZ7ZsXxlvdmlzf2vEWQzf2Yh9LeRN
         vzLBGMIpDzFj6kX+ytOJe34oMga2ZAyPRkoRQtFh9av1vXErS09Q1YaL7ZI+asv+3+KO
         7nOhLuYxounnd/LdOlnDzrG+CeOujEErC/al7CcDT5C9JJ9nOrxtVavEMTo/4pnWXLbF
         dB3MR+sGxTP6EYQrZ8V4B2bBRdzYaDeaMpaGjZRDokxUSez9w98VcLPxzuplJxbnCIc2
         E3yg==
X-Forwarded-Encrypted: i=1; AJvYcCUSVc08HMK2+PYDQ05hwbTjHKpPJE9LxpWnGQeLWU1qv+27iPSNtMROpyt/vlM6Ct60OWHcnz4NzMO5z9vtLv9tjXb4D7JFDEJ3kYhk
X-Gm-Message-State: AOJu0Yyh2Ax1raZaDrCeN7XPNaM4Fyn19A5fTgTzzxDxwZOxTAmgqQx8
	aTxUGai1XFwjqqg3ZbhLW02GIwoFiljnZUreEyqBvT5kM86hi/LkDgtFqpdBspM=
X-Google-Smtp-Source: AGHT+IFxuM53qOVs3ZUC+MFrcNzBV3wB/ku0AmJDncPC0wqaV/WkA3xgyK8oeZ3c9x4vTfzd6YGnBA==
X-Received: by 2002:a05:6870:452:b0:23f:dd5:f89b with SMTP id 586e51a60fabf-24172c2fad7mr17839507fac.51.1715748753515;
        Tue, 14 May 2024 21:52:33 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:33 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/31] Staging: rtl8192e: rtllib_rx.c Rename camelcase variables
Date: Tue, 14 May 2024 21:51:57 -0700
Message-Id: <20240515045228.35928-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series renames camelcase variables to meet style
guide requirements. Thank you in advance to reviewers.
~ Tree

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
  Staging: rtl8192e: Rename variable ChkLength
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
 drivers/staging/rtl8192e/rtllib_rx.c          | 184 +++++++++---------
 drivers/staging/rtl8192e/rtllib_tx.c          |   4 +-
 6 files changed, 118 insertions(+), 118 deletions(-)

-- 
2.30.2


