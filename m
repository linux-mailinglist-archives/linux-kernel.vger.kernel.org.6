Return-Path: <linux-kernel+bounces-442954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C409EE48D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27AB18873B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF5211476;
	Thu, 12 Dec 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIPN0+5c"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440291F2381
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000991; cv=none; b=DU17t0aMdmo5Wq9cYPfQUS4LGuKCyxdzgFUALciA+99PvmeS85mSE6n4uyAKFX3O6VPV+4DSBpQ8SzMY8mble97gycqY4WsBXBvpdkuqwvj42DckI6eb1YsIciaiOKUGNdPc2+m7BTIJjOtOXcGOfqAF5ytAqazd5Bb0BWxnO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000991; c=relaxed/simple;
	bh=b2nbcvD8qGSqKbIfAD1hyPM3SXoLQQ/FCnXRLdwW7Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCNyCT8W5cHo+Q0Wq2FRopA4DEVKAFc5/D5WcZJmz8On9WBJVQNIaDLH4cMdXbw1RgFFZShbG4w64jj4C4Fv3NE0/dDCKfwSKpDum1ZiRViPhyRPq7fiWFxlyFSAF+zgFW7Byo+AQYMsR0OxW+8OmiZEzCGJQU0ecH8ryReuMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIPN0+5c; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso1359876a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734000989; x=1734605789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVIQo8NqWQ6SELkLfckK1F5HTaemJ2gPgY9CRh8/kkQ=;
        b=lIPN0+5cAkHcdjXkqZZ+491ypCuSu9bHD5GCyLHAdI5T9NCO0DCzQuVY1E52WPmj1L
         N+oZcc1IdPfR/HyJd2hZZSdilyPEXGX0DNNeC5IxlK8dpiMXVg1l8pUl/0vr40b62LTL
         D0HkYMdOZWCzQTeZ3rQn0u0NVBUlY+KUZJLuBARmS42TeH3w8G9SM5IOFXns7ejmuKGz
         Q7Bsp0hzLkC1yNiK32bjJYmOeYsTBCPaJMUW3Ji6ozgmk2VHJooaIpwfWAfTEG6n2thg
         qXS3t2gj2s5fjxwCQgAHPyk9w8z7PDmC/XrwTZkSz68o8vpd28vblrnf5H7ZyBMZ4PD7
         XvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000989; x=1734605789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVIQo8NqWQ6SELkLfckK1F5HTaemJ2gPgY9CRh8/kkQ=;
        b=mwXLV4as3NVNj6EZC5k0dtMHYk3rdMG/XZyDYHE5BdTVvqyUz3eHM8Qsfsb1BSIRid
         IZgj5iPtvoIBPQeN+LCvtzBa2Qvxk6dmHh3KWQZ31qhF2p1fk5YD0ZEO8uHIGyZkZ04C
         IrLhOwSBVB+M0vvP011I+1q4+UeLA9ajdfK+xB4kzqh4VqXFaAMEh5ReuUGuXm2hg+Ua
         UlUyvjGmTj1bCykIEQpBxITc0YelpAO4ZeMEv5G4WNMrdDTKowxUKQhssaqoiLEqGZqa
         D+uG0PTwvlZOnowIktWTyFEh+lw3l7fnrJAu+bVxUsNwVKWBw/GowHh7wCly/Gzjjo6Q
         XQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXIMwaJ7tIb15paS7g6UhJiCDaSUXFA4BvNEefgtP3MbnzEemwEQgngQcb3GKVwkm75opvnIP2FFCICC7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iE6D3sb+MyOtz0aE+Pzr8+15x2k5mEt1GYDSTvm2rUgCxlgV
	xnyNPxE2lyGji+1hCrpboHhgy+KuxV+iaSiJMthgHOTE8Mo+7snK
X-Gm-Gg: ASbGncswdRcjxpuWcb9ukTGYBZ2tdIFJz92hWYYg1WeNV2iAMOlqcrIX6GQ13DqEK0V
	8Pgs6kx8RRXDV8eVqJqGK6k1vi1kIWbJQUhzCGh0ymVYRMAahcugF+JgJioZ9Mp/OnW1N486yG4
	vVl+B5kaK1H4B32Axv3BO7IYMp4ITI4+R0aFrKQCvr9345ckays2yg6MlywdLDZo874TTMKUt4k
	9Xi9ApaeJVy1+uCSoKZP8BjleT0sxAQL41t4QpHTvIaggh1j6fB54rZf7U8BA==
X-Google-Smtp-Source: AGHT+IHR9YBy2fc9hy1FcQ+uJJ1iUSaXLspeZXS2ea9QTPKDUsicXHM39fumSQB2wALvNjSDERvIpg==
X-Received: by 2002:a05:6a20:4321:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1e1ceefcfb6mr4960965637.2.1734000989398;
        Thu, 12 Dec 2024 02:56:29 -0800 (PST)
Received: from HOME-PC ([223.185.132.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cf9f681esm9223571b3a.98.2024.12.12.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:56:29 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH drm-next] drm/amdgpu: simplify return statement in amdgpu_ras_eeprom_init
Date: Thu, 12 Dec 2024 16:26:24 +0530
Message-Id: <20241212105624.35877-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the logically dead code in the last return statement of
amdgpu_ras_eeprom_init. The condition res < 0 is redundant since
res is already checked for a negative value earlier. Replace
return res < 0 ? res : 0; with return 0 to improve clarity.

Fixes: 63d4c081a556 ("drm/amdgpu: Optimize EEPROM RAS table I/O")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602413
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0d824f016916..52c16bfeccaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1390,7 +1390,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	}
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
-	return res < 0 ? res : 0;
+	return 0;
 }
 
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
-- 
2.34.1


