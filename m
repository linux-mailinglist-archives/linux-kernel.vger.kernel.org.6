Return-Path: <linux-kernel+bounces-398734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3669BF551
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120751F2589A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7920821A;
	Wed,  6 Nov 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCa2xiCe"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0E207A2C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918037; cv=none; b=VtPPBM4UuzsQ71w+FU+d5dwhZo4/6Ta/VYL2MucipOQ395hKUy/5yt75z1IJ2ACknSRpZVwWuinvv89hRg3ZINwJFQpegB5BtVnV991sBkI/SKZWjGaQ+jy59s/dEmVdj36HYhEeZA9j5g5Hncd8Xetjj8IKV1m+PmJbx/4JNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918037; c=relaxed/simple;
	bh=0Gc+JPVi9O0tZICMYNaPCrl3aoXp938+vWpDID6LlwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JASubp0aoRn4flzZwGqpP2Sf4RSxDwwfArYrrtghVMVDuuaoBvpSsNzUJexgi9bQDAU4h5oMAAAVPmCxCQRM1KVOX+8mebJBVgBNwlc0auMWLy9FVp01+96enr+czZFbaPADc3nrr0+cXznNYGceNzsGql+Ope1UAvGQTz4bhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCa2xiCe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9acafdb745so33660666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918034; x=1731522834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tx6X1YtADs2XT3Ox3Y3sdyzQo/0AxuioBEE5kCAYkwg=;
        b=aCa2xiCetRiLNp0KufJB21Z4PpZmJ9drvOdA0BiLJDMXWe1zs5qkp8q4H8k+2dY0xi
         YP88CMdGLLrCbbJrrBPX+jx995g0sE0poIfxuBF1naMeltGnfklUEDG4T3oZDlezzG7O
         v2ZQ2mQcDGzjiVEQ7YlirgVGYVR/8ze9Dr3RLjbKzv6bZJzrQDEZ2SEXamuxHU9YtT5C
         9JiBjC7tGEvLbOcA2XG/AndWuFue8/khMpSc6rTNdiywyVo164uDI10I6gy1hjCm/u8U
         v/7mQw03wCZe4fSrXwHR2cuwjuTtaWeFYzgNbofwViTT+vgloQSHb46jauKgBMWjXrXy
         aD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918034; x=1731522834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx6X1YtADs2XT3Ox3Y3sdyzQo/0AxuioBEE5kCAYkwg=;
        b=KEfzCVGnCy2llxgENwG+Evw8gMz5QsdPyvdENkziCrj7gqUq/wv3j64vAuq3gczjhu
         MrMbZjwQdxa5PIM5krvrp2VQUnHgD+pTaVpBHZ/xwLoM/n9qdWITQQslGLWDrGCwv0io
         24GEUhCwzbUm5moQ8aItvjDK1b135kvSK0uZhFc17JMVgWHk69IwQNh6NC359CPTFUYK
         SzlAZJpGISUCUYCXUMzQICbckZuxUU88mt9J75wQWslkZXIPcP+4+6U90YMmFbraDjP3
         YAoPiGJ9mhbP1myKvfe1+TGHKPD3DQ8P1DYNiFIn24fDNwXxWb9OkwsLy3YtbSUrWLXw
         PeDA==
X-Forwarded-Encrypted: i=1; AJvYcCWh7RLF2hJtPy7DUjQlzEVU/zHKzEqqEi8iwRFbJr5eYCpYWkCmtXreCKcqrtH8+a7TYbPzwm99phWE3AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX096JI7W10NvKlIwGH1elLcqN8jLZE2HUUf+TNccZ3X30JKW0
	nGn1Q5rlUy+U1kK7eoPXMSpC5YubPj8ztcqdoDnIn2Fwvr5XlRee
X-Google-Smtp-Source: AGHT+IGDWdUXEFRrR3jrnbt0tCF12f0An9+oAbEngtnkkZAAsRtEs+1qquwf2GEABXZvC8PGz2p8RA==
X-Received: by 2002:a17:907:c05:b0:a9e:85f8:2a3a with SMTP id a640c23a62f3a-a9ed506f2a8mr18888466b.2.1730918033692;
        Wed, 06 Nov 2024 10:33:53 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:53 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 00/16] staging: rtl8723bs: Replace function pointers starting with EFUSEGetEfuseDefinition
Date: Wed,  6 Nov 2024 19:33:29 +0100
Message-ID: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace function pointers with functions to increase readability.
Remove unused functions.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (16):
  staging: rtl8723bs: Remove function pointer EFUSEGetEfuseDefinition
  staging: rtl8723bs: Remove function pointer EfuseGetCurrentSize
  staging: rtl8723bs: Remove unused function Efuse_PgPacketRead
  staging: rtl8723bs: Remove unused function Hal_EfusePgPacketRead
  staging: rtl8723bs: Remove unused function Efuse_PgPacketWrite
  staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite
  staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite_BT
  staging: rtl8723bs: Remove unused function hal_EfusePgPacketWriteData
  staging: rtl8723bs: Remove unused function
    hal_EfusePgPacketWriteHeader
  staging: rtl8723bs: Remove unused function hal_EfusePartialWriteCheck
  staging: rtl8723bs: Remove unused function hal_EfuseConstructPGPkt
  staging: rtl8723bs: Remove unused function
    hal_EfusePgCheckAvailableAddr
  staging: rtl8723bs: Remove function hal_EfusePgPacketWrite2ByteHeader
  staging: rtl8723bs: Remove function hal_EfusePgPacketWrite1ByteHeader
  staging: rtl8723bs: Remove unused function efuse_WordEnableDataRead
  staging: rtl8723bs: Remove unused function Efuse_GetCurrentSize

 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  90 +----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 353 +-----------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |   8 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h |   4 -
 4 files changed, 6 insertions(+), 449 deletions(-)

-- 
2.43.0


