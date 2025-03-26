Return-Path: <linux-kernel+bounces-577087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DEA71834
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395D5188FFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7C1F12EB;
	Wed, 26 Mar 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+K0jFDr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950011EDA34
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998479; cv=none; b=rLxqqBew/yEKyr1CTTgypbhld17SONNgl+EGO264LBGrOmN7BawQQwwJSQ22/1Yk7xAOTqEsD9OFRNJdPddmAF5/4qkyB2oi5CWyMuvcnnjao390XX4rCfVJTbvlqIpx4/NMVTePB0tP8VaxqUYPaT7CbkNdk+QNgXkThdjvMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998479; c=relaxed/simple;
	bh=iLiiKX6XB+he1+5qj4K7lcdkVBffO0LVrE165P8Pa8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q++jjTQcZedpr7JJ0khYDvYutsnuBJM4xYnE3CPO0kAutV3QQ1ysyX0CXMeMRj+0GwcZ0ZGEP0+GUp8YfIPNiwUv3957JgFLpwKZlYIalxAMkBz8C6+iAjQd7SHjpHvb4yrw9A7Vt+3Lnsg5fM0VMOVdqtdJNcHwmQeFYqtmDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+K0jFDr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so133200035ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998477; x=1743603277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Anvf65kFlASXiYrhuvhmi9oEZJmpnJM1LPwfUNxcGpU=;
        b=Q+K0jFDrlZtBG0uxBEHjuH152LXf2EeJoVcfJqm3TGkG/iWOB9+F9wiCm5Eks8tGAc
         6VydR0Qls54J0jphI+MU01Ziq2j3AIb4yArJf6hC9j/A9X/B5keQFM2+qqUIt4+Vl3DS
         IqDYXWvBOKqs4hr2UQ0qRUIcwuVfQKTHNCfIxThYrLE8ChX+nELPf6Ch14S6SwqeASTo
         +dIw1GkLGCsNR6uftFzAqeZzlzc9et+4sMy4uAcjvabX0EoojNjV5//k/cnJ4gPg+jiM
         V3eB+V7bLKVFhQY9hBaBEq0KTklZPbAoTaAX0Nb+TxNrl/bC2pb78najH28k4Y3mY57S
         fgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998477; x=1743603277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Anvf65kFlASXiYrhuvhmi9oEZJmpnJM1LPwfUNxcGpU=;
        b=R/6l/BtnxtS8r10v/ZfefMehu9cQARAOxMjR3JRziUHglnc5paPCFEbc8rG9QSSM0o
         GLkdOVHI9O/9Kmx2Ruxexx2Cso9/uEv9stXe21aZ/Hx+tK+O0O0gzW7xvQheKppCb48d
         daQvbGoknSKvHZJA7qkWs55KDnNGOsI8oAPQ89/ix6BGfbcLjj0qI12OIKnNBUAlzlSg
         ++7XxjEtEylzExy4zhPcILrv1hA3N7BIckMz/1JM156cZPFEzptYNrRAsesAtV/QOxDf
         hJb7H15GrA4bvqdC6S+5ldLOTNYU4icX4B/zvAhdr7pF4nxcSSjF0ENlnEPL9hpb4QBy
         43oA==
X-Forwarded-Encrypted: i=1; AJvYcCWTeyd0Ti+jKtWNXrz4c501ZO4a5E5kcY9Hwy17RWwoyEZmouC/BbQjW4r8mJZqiQncZSYS7W/NnWY/dCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzQd6AnSarts/9UOmeWiwoXcw0pqJp8z6zX2NyeHhywthlKQT
	McO4UHRloZZBvzDaraVQMPEBk0hr92dY1Kqe4x5VqPRrCV+FB7FSV2r1ZnhT
X-Gm-Gg: ASbGncuIVL+sRRQaOsCoSrV437Zr2kuiZyJDCYnppDUH1jHEg2PQ3d88H3guUVZN+VA
	xdZmnCclw2ftFaGkwIOpomYlufFwe4NNzt4ovBgact31H9mwLGo0xboXkN3jK5RuUAY9zzdZxxS
	jExTGtw6GBYrhYtuJ71PZq6+TfGPEwyYnplBe91XbD9XInRambDgLo+puHFmGgvZHuPRxk+WwYt
	nW7T0fRpO624W3TkuDaYhGZ0X+VwlL2FLDU3E4Hxp0HM55M0aTpXIHmYFTKjJ7EyX5kxizYM6Or
	c1rXW5vFbLHGKFEpinjscY0SvT4oQDRDA1xKAzKgzRQDOIO3FIoN0elQ45Ryln86et2HHlmmyw=
	=
X-Google-Smtp-Source: AGHT+IGK01CfleCX2pzM5nt0ir3um7yD8M9syjpA5VmHgXO/F4LfW2P+UBe4DgFIy/ycLsbdmFIZ2A==
X-Received: by 2002:a17:902:cec8:b0:225:abd2:5e4b with SMTP id d9443c01a7336-22780d7fb22mr302208615ad.16.1742998476493;
        Wed, 26 Mar 2025 07:14:36 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227967dfe4dsm92323315ad.167.2025.03.26.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:14:36 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: prevent the current section from being selected as a victim during garbage collection
Date: Wed, 26 Mar 2025 23:14:28 +0900
Message-Id: <20250326141428.280-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When selecting a victim using next_victim_seg in a large section, the
selected section might already have been cleared and designated as the
new current section, making it actively in use.
This behavior causes inconsistency between the SIT and SSA.

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2b8f9239bede..4b5d18e395eb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1926,6 +1926,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
+	if (__is_large_section(sbi) &&
+			IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
+		goto stop;
+
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
 				gc_control->should_migrate_blocks,
 				gc_control->one_time);
-- 
2.25.1


