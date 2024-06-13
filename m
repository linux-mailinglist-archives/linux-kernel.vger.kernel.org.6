Return-Path: <linux-kernel+bounces-213980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1285907D47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A812836FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2113A243;
	Thu, 13 Jun 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQJNOo1F"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76513958C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309786; cv=none; b=bnsGF9WxIKF2uYITEjAFrJ7dPgFF9P+DxKRJLsJVOaQcQ79A8UL8hXs/7khwX3KgBW9VL6K6ir5RgqhszOH3vlFDxHH+bJETNqRMblWgKrIWWug0+3nT0AZqy7QmkhnGtBPFlzCO6F7Khg+H9zylZgrkTP8t9C08flAq6eFhseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309786; c=relaxed/simple;
	bh=GUcMC36tpdSJjeu3d8N7xG6wpiIC/XoAMNEzmVdie0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anppF3t++BVc2LG3Im7kMCYJzzS+zzjuZq+OiNTA258A/ARpwpMYlAvAA4oFlwGzr+woe2jYgNZIgg3zlHfu1GjkFHYTXjaL2hcvilvNrot6UCzXB9wJ2yC1OoHM5dAPuXxz1z7xAe+nXzOSneQC6f6/lGNS9snFPj0qNehy9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQJNOo1F; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217990f997so11401175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309783; x=1718914583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73Ywxe+wInveR8HhNyBX0TlhPQP+xFRquIiA5gYW96M=;
        b=TQJNOo1FUvvtMyDQDz5a7rX8T4VqdXqyWR6//V2KsvPD2Q6zJqHi7ES8+X0cf+3lyN
         /IpsbU3d1NkYLbbsd6aGEeU7KCEcznXs7EqJA8zM1GmCmQrm2IeUCmvBArws35HmFgQG
         huJiIJmitmZEo7eAIoR5inLWMBnTf01vpJNe2St9ttcKUxHTav6VM0WJX4XG0XAUTSoP
         As3rzCGUo59JHmkstEizSOezVEKWT2VBzEvy23jVn9P5Pr/gRz05UdUY1n4nT6075mKv
         9plWKhDOkQTaxqSgk6mvj/rvTBE1Xn/OdYq0ad8fyBRspHjJxrAbb1UeBorPzWPl8KJl
         LoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309783; x=1718914583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73Ywxe+wInveR8HhNyBX0TlhPQP+xFRquIiA5gYW96M=;
        b=hujtMLiDxm97S1fnzMVaDqHu9l8NLH6S1Oa4o4DKwi5MTinpkAjY/l6d8oNepWZbST
         pzZmnWMQZm4V6TrY+GnGU3u2NnoQ+5VHr8wDEw+JG5+KnOjy7S+FNz6aLEl9sCU3v0DF
         da8vemxBwvjClwcmZhm8Xg0AP7rfy4VG85scbt469pO2XnaKeHt6GrhMTQyAS0HH+OhW
         agcPR2ffH3eZXMh4bXt8ZEZdLNo/oOEJAlhHO4QKu8hbvyrg6T/OxVkUdXjnMIW8zTJF
         f3YHzf+cDcIenCEUF5V3q26nW0KFBNuQVGasKeYWEojv8vN3QNBO5v1FL30QwgDYDw23
         k6JA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5t04jgfv17C8O+D5AfEh060tjw9CwYuIVTxLw/uHhmiaylpOcnZJGauSY7pAeVSdaIbWopVmiub6xnvT6V4l51uDzYjzRHdA/nKw
X-Gm-Message-State: AOJu0YxF81SKr1kSRJY+iRkpvZDAFuwQelNwEtQwbEM1pjSuAV/dlZyd
	fzM2odCGHCQLQWO2RlUXFdR+3e7DLoR3LGEXpxZgPK9/BSfK+4b4cSsiIzmrK/U=
X-Google-Smtp-Source: AGHT+IE4lcWxBpQZAwuJHavl84PM9M87lK2v8B8FjG0I0G3OWtZcW98MRppDqmbvm9i6wNgeE8QJQA==
X-Received: by 2002:a05:600c:1f8d:b0:422:70d4:7e96 with SMTP id 5b1f17b1804b1-4230481fac0mr6907645e9.15.1718309783274;
        Thu, 13 Jun 2024 13:16:23 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:22 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 0/5] staging: rtl8192e: Cleanup multiple issues
Date: Thu, 13 Jun 2024 21:15:06 +0100
Message-Id: <cover.1718309120.git.engel.teddy@gmail.com>
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

The patch order matters - please apply in order.

Teddy Engel (5):
  staging: rtl8192e: Remove unused constants
  staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
  staging: rtl8192e: Capitalize constant RegC38_TH
  staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
  staging: rtl8192e: Remove unnecessary pre-declaration of struct
    net_device

 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 9 ---------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
 5 files changed, 3 insertions(+), 18 deletions(-)

-- 
2.39.2


