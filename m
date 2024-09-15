Return-Path: <linux-kernel+bounces-329691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E409794C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437021F220DF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CD18E0E;
	Sun, 15 Sep 2024 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGTnQOrK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A117BCE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382452; cv=none; b=fLAu5I42xTEK64lziI3n09G8VRjjGJIU23dAxM3F1aAb2hDutg5BoftXuWYbb36QBei2MkPEf66S1GN1yiAvQlzC7+BXhaVQ9kIOHmi3l+pGDwqm2+drHuCFaUpoOD/+kVSUgvoCoEV5EFzblzLzGvKM/szu5t4Yy93oF4Vql0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382452; c=relaxed/simple;
	bh=map9OqAqlhHdp3AyeG30zmc8rrWcD32kRYETJOholq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAjdqjbf/4kJrIqWohVNfJq4HM3oh1xblFVRZpJ070p3ux+PWsaEDPsSnS84tqbRqRamkGTHAlds7/fiFJ2DR8R29vwMoTzcx/1daGkXC8o6sVA3VUvvCe9/GejAja0PB0Wbbmzf5UFQL0wLufQ1xB88tLolBPbArzq1WGADE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGTnQOrK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso464888966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382449; x=1726987249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJWrJsnaH56i3Ai65QAPyR9wjb9ssl4jYtrKSQ32fSk=;
        b=ZGTnQOrKqYKCle06OO2kaqWfhd0yJl7xBTCcx4WaZoAcrLTkALEDYCyNCQ+GT+srbj
         rvdcg6bo1rslWx8DlQUkb58cw67K8MXxa+xVBnZLeNWMvsjsGtoRWa/gbkkKiA1fLqpR
         txf9/A/GVzDKtWF8Yp6t8yHVuDxLhNON8as5sBG7CZyzUYFic88PAufHAUTIi4DF7i9m
         55sWqhjRL8UKo/58LIppQeCUysqJGRKgLvyU7csDhyZFKUwULzOxxz5gVTQYQ1Vv4i00
         Z+yh5bUrPscncplN+Z98W57tXMwhAUiwzKcz7WSA5oik2WXl5rfdhIItpTuPvpvXNjhT
         q9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382449; x=1726987249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJWrJsnaH56i3Ai65QAPyR9wjb9ssl4jYtrKSQ32fSk=;
        b=mgKuqMSUYeT+kYtU4n3lvqFN/UkamI2GvQhVQFy3KxBe/4OUK/yEmOvnaHYurskxTV
         7fZ3ICrK7l8GSZqzLqKztYBPreim3jfsLS+0j1xn+6pYOmHSwK5kXvnDs9y6H6ZTOOe0
         yCtzcU24s2hM9Bv/TGh+f+j/M29WHk5hHVnudEtB1svVsfIzecadCLcDtIVyte2WXrAg
         z6/RxSiHs2r66pPV2AmMhksujhI3RmLNGttfvrduGOSkn7cycPPjQAnv+a6yQ0OgYYIe
         c32v2qljG+nQBOqslZUeSUmoe7EfrDwaM1qoGu8uoc+r5TUmryceiMoe0hhEUHtgo/YJ
         lBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWQdwdmWsrk9eC1OFRWt+ST1LqUTHWs8Q6J4GBVunN4UsM808hFYhzWHnt8lVwYr2sxyuXpeqfmZrLiIsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XzbGtR0iluRTW3df/Uzn8FDyukiWoJqdbIwMXO4lPKEP/z6C
	CIADsP6ov/NdlxMPutRXuznkuaaUvDNzAEgEUIcImASP2zGkXUIWl+Yvqg==
X-Google-Smtp-Source: AGHT+IHkiIYQJMF61aW8pW6xiR50hEB5C33k3GbqB75AhLB2g8jrrvySSA5ogj8eQgPtcxjEyQSlNA==
X-Received: by 2002:a17:907:6d26:b0:a7a:9fe9:99e7 with SMTP id a640c23a62f3a-a90296174a7mr1163444066b.41.1726382448911;
        Sat, 14 Sep 2024 23:40:48 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:40:48 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 00/17] staging: rtl8723bs: Remove unused functions including read_cam
Date: Sun, 15 Sep 2024 08:38:14 +0200
Message-ID: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused functions, macros and one enum.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (17):
  staging: rtl8723bs: Remove unused function dvobj_get_port0_adapter
  staging: rtl8723bs: Remove unused function rtw_search_max_mac_id
  staging: rtl8723bs: Remove unused function read_cam
  staging: rtl8723bs: Remove unused function rtw_get_oper_choffset
  staging: rtl8723bs: Remove unused function rtw_get_oper_bw
  staging: rtl8723bs: Remove unused function _ReadCAM
  staging: rtl8723bs: Remove unused entries from struct hal_ops
  staging: rtl8723bs: Remove unused function PHY_SetBWMode8723B
  staging: rtl8723bs: Remove unused function PHY_GetTxPowerLevel8723B
  staging: rtl8723bs: Remove unused function Hal_BT_EfusePowerSwitch
  staging: rtl8723bs: Remove unused function rtl8723b_GetHalODMVar
  staging: rtl8723bs: Remove unused function GetHalODMVar
  staging: rtl8723bs: Remove unused function rtl8723bs_inirp_init
  staging: rtl8723bs: Remove unused function rtl8723bs_inirp_deinit
  staging: rtl8723bs: Remove constant result macro is_primary_adapter
  staging: rtl8723bs: Remove constant result macro get_iface_type
  staging: rtl8723bs: Remove unused enum with first entry IFACE_PORT0

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  3 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  7 --
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 64 -------------------
 drivers/staging/rtl8723bs/hal/hal_com.c       | 34 +++-------
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 20 +++---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 53 ---------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 15 -----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 13 ----
 drivers/staging/rtl8723bs/include/drv_types.h | 10 ---
 drivers/staging/rtl8723bs/include/hal_com.h   |  4 --
 drivers/staging/rtl8723bs/include/hal_intf.h  | 14 ----
 .../staging/rtl8723bs/include/hal_phy_cfg.h   |  5 --
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  5 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  3 +-
 16 files changed, 22 insertions(+), 237 deletions(-)

-- 
2.43.0


