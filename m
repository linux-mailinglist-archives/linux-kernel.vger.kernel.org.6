Return-Path: <linux-kernel+bounces-274753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0516947C49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B35B216B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2297FBA1;
	Mon,  5 Aug 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuCJrkUg"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C077710F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866193; cv=none; b=OloYDboaRRarCgBldaR4W+NJgJR4lbEP6fvpyF75FDAKffUaTNWkBnb3KkMykJ/DAFUQ9yMffnJphIXrgsNNQVnBh+eWE9WrS/Q9xjjuOkZklgKSMikH9UmSavbBNPEjAvgXCfstxY7BTuLLrH1ngQgt9KfLuz+sXfNcKnqa0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866193; c=relaxed/simple;
	bh=OljTUfGwA90xVwkaazPlqm/klEykXw3pbmjz7iJfWNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj4bBDZjMf5rIbqYLP9GV67jzFKwKWG4gt/yYtxPlMqvIKR5sVXhRyUJigLl2/VUl5MRXxv6FiXVxdsXMwMTqon0xkc8fgrK6OztyzptZnp1lcTK7664fYlQQltXYGejViMZ8zCj++xjD7C8AS38OYT8w0xVMb/YsBfABVgN/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuCJrkUg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd65aaac27so38082895ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866191; x=1723470991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLBfswTvbMFwnT4wTWUCcUwfcddXXu4lc4bwZmWOOv0=;
        b=NuCJrkUgQmp1sce6ywqwM/ZLHYbBFTaphdEZJzpFYYbMJOW4qWXbqKlP7SUV+VOSNc
         dqzUjzumi4q9drVlRC2fHLWtxwNKTN51NBmAZE2MmaA+mybR1gKBWl2ASi6YuTVTA87m
         vDe6i9JnMg280uuKNTkbXbojpiE0zX5QcBpiAJKlqivh1/LPPa72AU86Z7KZok5WjcCO
         L/AF43s3IeXiPLgslkIwg9/U0tMrHP4c9OBwQgCMrUyBdUz+Li8or9va6D7vcpLZipJx
         do1r0EQpZycrxDyNWPHJHJB8s4UzZ48w2hBtuDhrFtQKTQJ3oivtSS843pkp4DN4NukG
         kyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866191; x=1723470991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLBfswTvbMFwnT4wTWUCcUwfcddXXu4lc4bwZmWOOv0=;
        b=JNVlttxJQ6OaMrytHw62TybqnIyq2m/OgYn5ZmSPea7179B+2iYeaD7PvAx8EzeTka
         wG7Ic16jmWYUnejBKGBdtD6FjgxsfNRNCRsg8uW3KZX06lH7pjE6en3AIKfnC/+8RbD7
         62XvlTyrT5B+4NBMDLMv2MSwdn/8eMO40MSooVAnvLl6k1nVu7qT3fZ1+XmL8zAD/KDo
         Q4LZZP60ca1ql3FmCj+7C4RrWFqVm1C/UVQxIhJgOb2th7FcsaD3zz4OViv15hTqg6gY
         sYjYBEqJ2MTRWc8MlEddjbdjbG+Tazfow95BCFiqBuvYLTskYXkMHTFlo7nVUNSbqHvE
         uLDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWsxVRp+QRXHJfkRH3N8hYFYFXEepEy3j2zpUCyGY2GQEy3vfLilksb7WWyqTMAsIRMAYgopEAD+pNzjysvM/l/NXK6nFVSmfOlEA
X-Gm-Message-State: AOJu0YwRhopomZJVS7UHI51rpTHjNhAtRwARmZOQdgGf+k4/pNDY31OW
	uwIGvmMWf7QybVMc4InDHofw5MtVoaqBX1r45LEgm1SF1QgdcyyelyrmKshz
X-Google-Smtp-Source: AGHT+IGXmDZ2mlMh05F5BfNwBnZfnSpoMLulldjoltWc1fMBo2dURjbMQarr/2bglm2UDw4FBdLW1g==
X-Received: by 2002:a17:903:246:b0:1f9:ad91:f8d0 with SMTP id d9443c01a7336-1ff5240a35bmr214467345ad.8.1722866190502;
        Mon, 05 Aug 2024 06:56:30 -0700 (PDT)
Received: from VSUS.11svbebsuybebf4lhlhk4eftnc.syx.internal.cloudapp.net ([20.39.190.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590600e4sm67950535ad.144.2024.08.05.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:56:30 -0700 (PDT)
From: Jiwon Kim <jiwonaid0@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jiwonaid0@gmail.com
Subject: [PATCH v3] staging: rtl8723bs: Delete unnecessary braces for single statement blocks in xmit_linux.c
Date: Mon,  5 Aug 2024 13:56:23 +0000
Message-ID: <20240805135623.2069-1-jiwonaid0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete braces {} for single statement blocks to shorten code.

Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
---
v3: Fix subject
v2: Fix subject and description
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 1eeabfffd6d2..e0736707a211 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -144,9 +144,8 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
-		if (stainfo_offset_valid(stainfo_offset)) {
+		if (stainfo_offset_valid(stainfo_offset))
 			chk_alive_list[chk_alive_num++] = stainfo_offset;
-		}
 	}
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
-- 
2.43.0


