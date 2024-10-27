Return-Path: <linux-kernel+bounces-383611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B09B1E00
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29663B210C0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25815EFA1;
	Sun, 27 Oct 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEpumwWh"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43751566A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037951; cv=none; b=kA08PDh+1O+ybZLMAl00tXVDIuZcMeKRoM+u0RUwCIYIxiaHY63/4PWNJDVXAPlrZC+AmIVFTeKpOfnhr+IINJoMl+rKmnA7OnQCRBSNck6QZ5u1ZrxrJDLdmhw0dz5q6nN2JVcrAF34OfYii/jMqPRr5SpcMl+gMpcV/Fzk7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037951; c=relaxed/simple;
	bh=v2TiXi4kMsL5jVfOCV2N+udvg24OY9EPDiwhobekUpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPjufklR6V+Tf9mmsd4KE78Dg7khISICHPK/uIe4vTBahKzjZzb+4SWgpHS3RmaeZXk3N71w248XiJeeMlDS5alFctSIrIU3zzBuGCe6+kozzyBxAxzyOAWcV3Uykc34lf7a3PDNr93BuY/4Q3J5HB0ROeWwVZFn3wdpTxZJArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEpumwWh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so530621a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730037948; x=1730642748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inUlyowWmHbKIgkrvQKpFNZUpYaWGNlLNHHuURxrFaQ=;
        b=gEpumwWhx6yX+R+eVgdlm8Lna4355+2pHsFbhnjfNd4nOFgetm2Pfc5TCokkd+BlwS
         zKFXjjQIsszI8EYo4HKSc3XBpgD+kTuv3/a6IgAJWPo8E1OQeeJmG2xLfVG59gMjsX42
         GJukPPeAu1MVP9O3K7YcsCMLahgZ1XSViZfbxziohXMVMWEo0IybuvoNH+xffgBxRBQ9
         xmlaD5fOfxiXSakosJyMJ5xothmYKmh0cLMmb/aoEf6eOv800HTnVml+XY6YyC58Hme6
         IHpQUJPcUTURoGVthD8pWvcZHK4gDhyOX18HtBk6iCBBC0+AntXyHo6q2kcVeDAICmTl
         CJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730037948; x=1730642748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inUlyowWmHbKIgkrvQKpFNZUpYaWGNlLNHHuURxrFaQ=;
        b=rDS3UEb9jLRgjfi4Ls5UTCPtqwtE4eoQ18ihsEWMYiDM4T4A/R4XgetZxJX5XyjSz4
         26FW+z8FSwPzj9sD7eWYxqvnkdwmyUYG+wKO3pzKYaxp3pviy6ZFzwUDB0I64l0zhiH5
         BQ3TsJWMhSAtLxAlDVtouMw6FG4zP/HOzcH8bBe2jdbapQy7RTse8YVaMY+i2XHjkhMA
         kDV+BcGbVu426psVoF1sn+kGWlcJwVW9CxwdfeSnbGWsWB/lzr6ZlHMVfSkgFdmtrgve
         L6M2gBMSHcUajbDUT8x+eqDk54JOYTXONtmoKoNeTHYYg5Z5uAG35TC5PCkEhRGeYl5S
         8Ang==
X-Forwarded-Encrypted: i=1; AJvYcCUI67D8DlXwAn1hyi5KOMM6wmem3rXLXab30NbN5kbKjWGEKPMHnk+pVmL4YbYjWNd00yCmAdTxg/f6/2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVMpl3DYDsvrq0UrFtV7VN5jAQk9vLyqJmufw97+UUlTgNuCm
	V452zxb/tpbOzE/JjrexbsRDuJl1ZL6WzPUPcwtDZXEvS5JqhXUz
X-Google-Smtp-Source: AGHT+IGGNqjJL9YvkD2i6GYBKc+U4ERHnLWaoG3c4mRxIeiWd3tUdnjBw5LyISpkvUSz0YGMGu6Slg==
X-Received: by 2002:a17:902:cec3:b0:20c:f648:e388 with SMTP id d9443c01a7336-210c6b01507mr33589745ad.7.1730037948460;
        Sun, 27 Oct 2024 07:05:48 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:1331:92bc:956d:bb87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02ee2dsm36111905ad.218.2024.10.27.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:05:48 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	tao.zhou1@amd.com,
	kevinyang.wang@amd.com,
	Hawking.Zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	luben.tuikov@amd.com,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] drm/amdgpu: use string choice helpers
Date: Sun, 27 Oct 2024 19:35:37 +0530
Message-Id: <20241027140537.503264-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string choice helpers for better readability.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410161814.I6p2Nnux-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

reported in linux repository.

tree:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for str_read_write(read)

vim +145 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 35fee3e8cde2..8cd69836dd99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -200,7 +200,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		dev_err_ratelimited(&i2c_adap->dev,
 				    "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
 				    eeprom_addr, buf_size,
-				    read ? "read" : "write", EEPROM_OFFSET_SIZE);
+				    str_read_write(read), EEPROM_OFFSET_SIZE);
 		return -EINVAL;
 	}
 
-- 
2.34.1


