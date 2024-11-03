Return-Path: <linux-kernel+bounces-393736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6E9BA49C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0369E1F210AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B756915B992;
	Sun,  3 Nov 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB+7CW8g"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729612D1F1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621695; cv=none; b=hTxrIGPb/foC2WnvYoo60EvhUVFIaFBIOpmRCL+ceoxjsbEIKANyc4Gv3e8Ss4KW9+CqR/AdsiquKS6OoVVzrJ2i3UZ1MJleX8Z9m8OAFYHrZkgVMyE3td68QBAhGssOky5HMfVkxfY/VRKAYCUy2bQdpNp5NQuyCNnWL5iXTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621695; c=relaxed/simple;
	bh=tGyWjiAJbZxq/gN0M7wjwAgXTCkZu7rn9lglOUWEvDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUQS5JW4mSeYAg9E4M+EjClC6d8dtEuuGVX8ZHP+gZT4wWQZUzPk3Z3+QENXhuOScuawarau+BWuJnWppzayuQHh/oPw8gKhaL1kavcPfVR36BXyJLywrfWwufV6fKgYMzKv/zRTr1T12EqObGJ0S0tVd4okblh21XQhbAXfskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB+7CW8g; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a0c40849cso554280466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621692; x=1731226492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6htMrnylFQ5DMO55G9HZDuKW8oHvcVuvmDwZaXk8jY=;
        b=YB+7CW8gLCu2AikjIYY8CgCADyZVi88i+xNtpdLQM6rN+OaRfdfYQNhl0YrVEkGIeL
         0QltVRDamTGNdx8ZG8N3ulqkrg9fccf+rcwz/Qrpy4dXQ7+ZbFdPm1d1h8QgR3lAMZnI
         y/aZKVUy9RRUyYlVvps2nCJZrDEFM4Fm13W3gLqIsKz88FURheHZTQXtfnQTWbrl1ghL
         +ORNd6INdTVjbzJqLfBzj5ldpnlaW3fXT1lPWEMrYSG44+ZCwn53EHzFdW54yCZ6OkdB
         TCV7+t/6dxyZ367L0X/8cQe1j2ehfqPNdD284eEUpp4l8LLE1Q8F8RCMZxJj8t2uF96u
         iM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621692; x=1731226492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6htMrnylFQ5DMO55G9HZDuKW8oHvcVuvmDwZaXk8jY=;
        b=TPzbxD6tIRadtam33H0ZpVQoAORlZ+iEM6Uw4MvutIpvDUs5FuFcamukRhgZvQSNDK
         1R/fuOys6n31lIZNgL8Ztdcf0FBJVJ+cltCY6x02aVJV0qWMvUp3zlZG0QtwUu2pQRyR
         7pFS2mg102/OtG4KRaoYx1V7zBYBw4zfBfGo2dRQw/p4fbDppGWfEemSvMm/jqjsEH68
         GFgNHJL59ylXvW9HivuLy+/4zRxHKFjRtYFy+V4b/9oKPJim/1aPUTsCk+ePhJVjKvS5
         +l/NqBXIhtbua2CHYHv9mgRcPNHQSU8XA4fQGJEXueVQCn4tCkGT9+5mTW0UjufKdLkm
         z4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVrK8AssI4pnS5a+TDOup7dyDKU/Y2PS1W2/pRgeqefw0jUJEClGlivcKetQI78b0RS2h5We1YbwBgi6AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN19a2CsO72T9mPAgVtgShfVY2a0sAXWS1tuHdCeLHYOOOOunV
	88iOzGTz9Fi1103VP89t5nvKMCO0ARGLIqmVbMi3Qtz5Jx50iXotpfg0+A==
X-Google-Smtp-Source: AGHT+IHtGFMxr/aiUCl4Ra72qgRMg0tYZtDJrt/wjc8HKWPsenfaF9Vcb1xKm8oQkVne20M6McdNCA==
X-Received: by 2002:a17:907:7292:b0:a8a:6c5d:63b2 with SMTP id a640c23a62f3a-a9e3a5a049emr1654792266b.18.1730621691688;
        Sun, 03 Nov 2024 01:14:51 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:51 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 00/13] staging: rtl8723bs: Replace function pointers and #if 1
Date: Sun,  3 Nov 2024 09:14:21 +0100
Message-ID: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace function pointers with functions to increase readability.
Remove dead code resulting from #if 1.
Replace one function that just contains one line to increase readability.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (13):
  staging: rtl8723bs: Replace function thread_enter
  staging: rtl8723bs: Remove #if 1 in function
    hal_EfusePartialWriteCheck
  staging: rtl8723bs: Remove #if 1 in function
    hal_EfuseGetCurrentSize_BT
  staging: rtl8723bs: Remove #if 1 in function ReadChipVersion8723B
  staging: rtl8723bs: Remove function pointer check_ips_status
  staging: rtl8723bs: Remove function pointer SetHwRegHandler
  staging: rtl8723bs: Remove function pointer GetHwRegHandler
  staging: rtl8723bs: Remove function pointer SetHwRegHandlerWithBuf
  staging: rtl8723bs: Remove function pointer GetHalDefVarHandler
  staging: rtl8723bs: Remove function pointer SetHalDefVarHandler
  staging: rtl8723bs: Remove function pointer hal_xmit
  staging: rtl8723bs: Remove function pointer mgnt_xmit
  staging: rtl8723bs: Remove function pointer hal_xmitframe_enqueue

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  4 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  2 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 40 ++-------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 85 +------------------
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  4 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 21 ++---
 drivers/staging/rtl8723bs/include/hal_intf.h  | 22 ++---
 .../staging/rtl8723bs/include/osdep_service.h |  5 --
 10 files changed, 27 insertions(+), 160 deletions(-)

-- 
2.43.0


