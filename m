Return-Path: <linux-kernel+bounces-338185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E925985475
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA2F2857C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DA155301;
	Wed, 25 Sep 2024 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqULSzgw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEB25634
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250471; cv=none; b=fLjGHdrIdY/eKVdlO42wqeI6+NefZZAAPCVf8MJqfvxR5w4uufD+xTLKhbM+MAZGrNQ71HsqlymWVSJyptPqQwEpewwCs/YRErsmQGQYUs+K6i7xFKyrL/lu/Yn1ml76sJFcH4o2veUbaMBMGV6CvahnnBECw6seDot8kLVTAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250471; c=relaxed/simple;
	bh=9qLcIe47D/BBtSWlhkB891UL2f9u9sMOy9Ke54h2ZG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoBdLAQttBSY379I7+q6rewEUZ6Kksw3KowSyKKeSzmqWDxahGEv5mV1UF9dIW9yaci14UQ2uksIsIIgJfjganGn3TnL4nDDugVl1ewwv8WEdyCs/f0nrs2NBxDgrlu/TBS3Gkzr3vSkh20VUgDfeRgT1A/kkJKbb2oUiTUxYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqULSzgw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so8392423a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727250467; x=1727855267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEIa+ff0UHF5GkUgIM3eQxprKh3KMUPnI+yj2n3gGSw=;
        b=XqULSzgwrmvckt6Y2A6+4pbWf9ujyUvK+hf1fc4LQ+DTxuT8N3mKpCrnSKnZ0k9fz4
         6pPiiP4RGCCKSuGwL9EWA4xDt1qpRwf1aJY2cXSrC4M2UMmr2fIhYujfXZ4ddApgFFmm
         DqHaVlzLIhaHjsEwkRflTiaDy4Z76F3mtSz/xHBCwSuQMjL5HbfY7w/UW+xkVqNieeY+
         ak+fRDePfex5m6MPt6IDd0N6pIS2K5McGcK7sB8akhoCbR8/KQeoF3/JMwYN1zGBLKps
         4GkQGauZYuzkLnDjFjlx3z5erP4LymBvvWpBAQqdVtSkD319jMV0Oy7DlM/U3WNWVjx6
         WpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727250467; x=1727855267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEIa+ff0UHF5GkUgIM3eQxprKh3KMUPnI+yj2n3gGSw=;
        b=LKVQh06rX7fiXHQqwaA6XJ9qOMr3+EhRToWb8PWmKiCQFPsUlg1kEl88a10nyTisNp
         Of0iGNJmaY8NaO7fx9B4UPv2J+tsfVwH6+MTrAc02R4bMKl7KFfRzgEHqPolJ2HFIzRB
         MoNebEskJ2iUpO+JYqZ7DHwKTEenENTqZhOT1JV/+kYZWC3ZVS+1Y2nSd+XP2HFxzDbd
         yOSuMF+bqysWD9a9TBxXNMtYjr8Nj04E05lKnV7tSU1RlZzSy03McNRcBwrmMdK4KxMO
         gsRWBHxl31eMgaVB3iLQYuiciC3Hyv2GuD7T2LS/2hJVshl6IzjAOBY0kkSbbS3vO+7X
         p5aw==
X-Gm-Message-State: AOJu0YwT5+HGnFzE4kaYqlhjihc8Hjr9W0Q7fC7Px1wct1CcOztJawnN
	8oN8mKfiAoFUjR5UNm1In8P/qawhD2WbW/xSIYyVGAhmTs/0pz9W
X-Google-Smtp-Source: AGHT+IE+yMofLcPSThKPGn71VbB/cDMOp9nOnXrW96B78DTHB+qA2Kgks505q7OgwxREQ/z9GHI5Hg==
X-Received: by 2002:a17:906:6a03:b0:a86:820e:2ac6 with SMTP id a640c23a62f3a-a93a037e463mr204679166b.22.1727250467420;
        Wed, 25 Sep 2024 00:47:47 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.polito.it (wifinat-234.polito.it. [130.192.232.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f51e90sm179792166b.73.2024.09.25.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:47:47 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: jack@suse.com
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH v2] udf: fix uninit-value use in udf_get_fileshortad
Date: Wed, 25 Sep 2024 09:46:15 +0200
Message-ID: <20240925074613.8475-3-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925071355.t4w3thcfvfpou7gu@quack3>
References: <20240925071355.t4w3thcfvfpou7gu@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for overflow when computing alen in udf_current_aext to mitigate
later uninit-value use in udf_get_fileshortad KMSAN bug[1].
After applying the patch reproducer did not trigger any issue[2].

[1] https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
[2] https://syzkaller.appspot.com/x/log.txt?x=10242227980000

Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---

Notes:
	changes in v2:
		- use check_add_overflow helper to check for overflow.
	
	link to v1: https://lore.kernel.org/all/20240919195227.412583-1-gianf.trad@gmail.com/T/

 fs/udf/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..811a035b600f 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2215,9 +2215,10 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (!epos->offset)
 			epos->offset = sizeof(struct allocExtDesc);
 		ptr = epos->bh->b_data + epos->offset;
-		alen = sizeof(struct allocExtDesc) +
-			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
-							lengthAllocDescs);
+		if (check_add_overflow(sizeof(struct allocExtDesc),
+					le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)
+						->lengthAllocDescs), &alen))
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
-- 
2.43.0


