Return-Path: <linux-kernel+bounces-385744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC79B3B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B5DB21698
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242241DFDB9;
	Mon, 28 Oct 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlmsuizP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD513A1DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146201; cv=none; b=pi9iwUzAv5KwEqmYSt+NJSOBFpLLgfrCReey+aKDahNAIL1mxU1N8xyHwnqdyoFkhr3vue8Erwtvvz31XkxI9jAND+rUkmhfoG20lbX+JmtVVxg2ffUwD6F0FGamoxfOpjr35faknxJjpUwzWJWWAqEa744u4z3Yx2ZkdLJauX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146201; c=relaxed/simple;
	bh=Nszj2bTF/LeWF/ZvVoFaB9jQ6A+h+xeHmGhOqpeCHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnlngKE0tNpnbsh0KBzYbETx0YqsJc7875bdKA8+w/gU/dIXzPGlf7xIHBNo5HcX92Hj8NIHU3Rc1/hddOzeRYQT7+YNQ5cN2Emix6/WncmW1FaKfDLQeuvtCUBYyug6ILAnHw/LmwtYZl1UqPs+mK03YIpxuLawe6WtHrdMRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlmsuizP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ce5e3b116so31782125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730146199; x=1730750999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=;
        b=dlmsuizPlwV9Qqcnc/6iPw4SVFSIYVO9LZeGhATVM9ZhgkV8FZ3pd5uEh60G8IN7wN
         /zLZxLOB/h4e2szTmGKhkrxzdKVHOU7qVZcxVaRj2CKmQIOHnz7dM/r6VjPVzsXDevkW
         kjYwxm5keKFAo5bficAUSZjtc0K2SRFyPqhVdxJvGKyDkwza/1V3v1lp1ZIE/samGzdp
         vlwRkPdJhdDiW3Qcx+nU0riPT03UzLQAH+xkaDoL/CofH/rvnsdU9B8/Crfg2DMxkk5H
         Fp3vxaqUEZr5RYcb8qRUh8nYnLWwiwg14i59tIZ4i1ranTLAS09IZGJ6PBseADy6zSe0
         K1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730146199; x=1730750999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdxh3C7cyLc+pvMOkJsZtEXg7OSNH08UiCM146DnUPc=;
        b=onhbeFbBU74sQXxccYCVvHiJZkoDS+M30k5kQuxep/f4pr0wzDwTtEb6hgNNMz40JV
         TEJZuaHhj4VlWTCFEtYnNcVW9nGfN8MXoYiZ5P+u0iqteOor+NN/eCrmgHZylJISM7gO
         flbhy76jJbzT9Z/FzLg9gDz1exVvUEqK1PNiMi6QC9rRkvPgZd+yjoXJk6E7j405sK04
         1VP5O8/3jGBqO9NhxGNmw+DvCOj8OpHj2zANt0CVBWDfx4WsWfrD0WDLZXvSPojuT4f1
         +WsoF/NJnYKYX/OwSTuxQ/fxGDRB8rTgdQZoC6J3/4UhuwhyrZuMPo6Kuxv4tv5oixoF
         hVcQ==
X-Gm-Message-State: AOJu0YxaJujSit1yJdmdjpx64AD+lJCAD7keDK/g7mY6+rXrJtq8/15w
	BFZVLpz1qsI+sHVhmr9pKJAfCrp0gY+TzlmCTqHgkG2zYOZe46ILZPuzyg==
X-Google-Smtp-Source: AGHT+IGvOzliQHg8CJitZU7twZ1PNCTkEB32SQQP4x7dg+RdjIdVn/0eVAfWDcJv+3iAIOTyz8JsXA==
X-Received: by 2002:a17:903:984:b0:210:e75e:4649 with SMTP id d9443c01a7336-210e75e4c87mr23161535ad.17.1730146198561;
        Mon, 28 Oct 2024 13:09:58 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:863d:c76e:f6eb:44ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc045259sm53628055ad.266.2024.10.28.13.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 13:09:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: try to allocate sections from zoned area except file pinning
Date: Mon, 28 Oct 2024 13:09:53 -0700
Message-ID: <20241028200953.2010714-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

We don't need to allocate blocks sequentially out of the section
boundary. Instead of that, try to allocate sections from zoned area as
many as possible, since conventional area should be used for file
pinning.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..1d7d8744c32f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2711,7 +2711,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
 			segno = 0;
 		else
-			segno = max(first_zoned_segno(sbi), *newseg);
+			segno = first_zoned_segno(sbi);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
 #endif
-- 
2.47.0.163.g1226f6d8fa-goog


