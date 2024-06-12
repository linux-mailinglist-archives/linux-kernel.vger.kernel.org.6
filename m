Return-Path: <linux-kernel+bounces-210859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B69904982
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C33BB23FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921F208CA;
	Wed, 12 Jun 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JNUzJOPo"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC03182DA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162556; cv=none; b=WwD9DidL8xkz/Mu3MbZUBZdwCnQfOgzmHbgY3JUGhjVz7/QnfHDtPCmz5MNkboL/j3ukPfMbZTQlkq3Tg97LXG80Ynyozj1ynG1ZD4xzzHMXOuHGd5ZwTNcHtBY64B7IIms1fRyZgAP/yEfVZEZa/BnWqG6wvuwwnxYEhsWo3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162556; c=relaxed/simple;
	bh=3vQLJewM7A/Geq+2mtl9MG3S8/I7or5poldMVDHUffU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+2q1T+eD9QObjEpEzyrlRdaLbobP5FZWf6nVVWDvhes3RfXekt3ae6LpQplEK/svKPQTMkKK9paTSBjMs2NauP/H80LF2jXRO1G5ak1D9o5ITceNJBl1HOnZDtXdi96r8kKaWW7OOqtzYmi6BOWwZOaeKDoOXo03QUb4oZYgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JNUzJOPo; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b970a97e8eso3518032eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162553; x=1718767353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sPqlyzd37LZw//5daAriEEnJvbFkW2/YSHXEhmM+vM=;
        b=JNUzJOPotIq0YT+52nHSNaG65iAuwy7UJ6tPiss9QMhCUNEb97KITOpS2Is5eAE/v6
         WmHU444ey2YWRYd0hQkcDrTUtNkWVUcw1KFqMLioGo1EdARXKSwhjiMYmVq9TRw0ovxO
         nJgQwkfB2V4Nu3e/pCLTUVaVfd9jf7TCBo3ZM8kh7XANgUFdFIMGDazeoL1OjCeio4qr
         02V7NQEXTr9TOCmgixArt5sRyyvV3eLPrdxhSeMqGK87TNQfRCl1fd0miK7ta3Gl2Hse
         HoLkfSiU0EWRqLku0/+fByNMix1nOKoEMiBMa/JzL/tWyrhVP2SuDo4sfJUQxR2xRvZu
         GmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162553; x=1718767353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sPqlyzd37LZw//5daAriEEnJvbFkW2/YSHXEhmM+vM=;
        b=D/VhMdj4NiAoyQXFHrJ2TYWU1Av6nHN6R6k5mKiKWcPFyiHSOLzWmTg+7zNNjp+4Sz
         njjSicocWjBCN24vghONE+ZCEEdnDTtemv7nkJh2QDT1TF9hJBbJJgskiMcDQlEzUeuU
         BU6CsFVJXHee4F8lq/25DPL76cctFBILql+tXAN0eww4nZw3XHXgM+Hd2WduMBq7gmIi
         gPRtu1Od5RsYeaxqyzZuvmvwOVdXIC9kMYn97CpsrjS5ORViFrVmJKyNjFFDaQWrK68N
         qHSLP0JtpSC7Wdi4gt6q+uGz3VY7WaEoGxZ2a/mFfg3UWuUf/lTvJYk2SVC+SMqLynCK
         S3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyefTeixDSR5emH6QjAO3w59XcNzZzaNGoC1ofwpY+H6xO04G1RIi2cNQM7fFdAQ5m/1HEcLpJL4pOKaLsr2ccXpEXGmklBbIpPZyg
X-Gm-Message-State: AOJu0YxF33E7qSdu3hl8FqvQQ6DcZzXznG2SL/r+u4VXMpkXaWSGdNOU
	KP+6Lob11BXjrdz6VmKh+mGQqV9Ja5eDUqwolL9JMm813wFljBa2LrU/jbo4NUg3ykXNFFg5la7
	OF2A=
X-Google-Smtp-Source: AGHT+IEZA7Uc3m3GvJ4zHBQ4ikuHLoXEfVI/TL2RLEffgsJD0tQloMAFmjkgUtWpXaoLs8tr21M1yg==
X-Received: by 2002:a05:6358:5328:b0:19f:436b:f6aa with SMTP id e5c5f4694b2df-19f69d2a332mr92078655d.1.1718162553240;
        Tue, 11 Jun 2024 20:22:33 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:32 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 00/24] Staging: rtl8192e: Maintenance renames and cleanup
Date: Tue, 11 Jun 2024 20:22:06 -0700
Message-Id: <20240612032230.9738-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series v2 attacks CamelCase variable renames, removes
un-used variables and adjusts alignment issues found in
rtllib_rx.c and rtllib_tx.c.

NOTE: Patch #9 doesn't completely resolve CamelCase violation as the 
correct abreviation of megahertz is MHz as called out by Dan Carpenter. 

Thank you in advance to all reviewers.
~Tree

Changes since v1:
#09: Change bforced_tx20Mhz to forced_tx_20MHz, and update commit message 
#21: Update subject prefix with 'Staging: rtl8192e:'
#22: Update subject prefix with 'Staging: rtl8192e:'
#23: Update subject prefix with 'Staging: rtl8192e:'
#24: Update subject prefix with 'Staging: rtl8192e:'

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
  Staging: rtl8192e: Fix alignment to match open parenthesis
  Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
  Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
  Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
  Staging: rtl8192e: Rename variable bUseShortPreamble
  Staging: rtl8192e: Rename variable bRTSSTBC
  Staging: rtl8192e: Remove parameter bIsAmsdu from rtllib_classify()
  Staging: rtl8192e: Remove variable IsAmsdu from rtllib_xmit_inter()
  Staging: rtl8192e: Fix alignment to match open parenthesis in
    rtllib_tx.c
  Staging: rtl8192e: Fix alignment to match open parenthesis in
    rtllib_rx.c

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


