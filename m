Return-Path: <linux-kernel+bounces-321794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDE971F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB162B21C95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFACB16E863;
	Mon,  9 Sep 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0EKdzH6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4898376F1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900342; cv=none; b=cuhu1wPY9sjXoUS2Ces9brv7CVr0MLJ4SZ9lRkBXBuSbG3hrI1qFQ/MdNe6n0MoRfY8YltdxkkIkq/BWqHrJeNucQmOrm2X2I9DM/JEHea+p2Xqa9tiRQ0ZZPH+fEl/DbjqhKAUIGVrxVCZZb70FnADQKdwAlN5TR2CSKsO5ZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900342; c=relaxed/simple;
	bh=kVnFcNZOECZaaqideRC1BgIz04IzNKgOIR6ic418eFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/iwhRLBwypIzGLEE/JHx9E+FtJ2Uas8UOigG+s4UUsZcap99ODZMvnZm7eRDKEZ7HWI6uhUpVjJ6fAlPYSP4lj0XMccw5LLTOKRk4HpkPWk7/Zy2pWZCXQsSJ8zcB35WrZ0Cm3ccbaCSjgZWmGZfbBBjpoe2ytOFG6GaGEeask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0EKdzH6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso3662929a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725900340; x=1726505140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhF2unESHOHNXtsHs//IUH+u17vTyKFOAwToWScirFo=;
        b=O0EKdzH6dKPcKGu7oN0dbHtJaBCxSQNOo0+kKBa94rugFOlW4P8keaBw6EEBg2GB/Y
         RssCPImCRjBXOTb7p3U4ukgakkuKyqCm53UGN/JiBvHt/YUjDqP5YQQRRA34lo9qhVf2
         DrPOK/c+W83b0Pg/joS+vegmbtHovQ+ObhdwNZHxzljRrPJvjihFCN7bk21Gh7HTAgx7
         t6IxiDa2HHbaKgzxdPGhpbXHKlpZeqysOcSXenRIUwefu4tPK9wjTjHnX9N3PwRybgiK
         fBYumOnzr9mip3RbHQB4f0+bdGk9IQyUOWPoDg0XFUhXH4F8vQsU1CQ8ZgGCK6bxlAF5
         bomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900340; x=1726505140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhF2unESHOHNXtsHs//IUH+u17vTyKFOAwToWScirFo=;
        b=h47MEEsABvquhG/aiGfG7on82fmxDhhlGHTHi3SVnA6nw9Z1fD8wb/pMYGuPH8nWpY
         WWkbGQXryebr+HAUuL9YOM7hJD64crm4R61pLTAq0xtXKgpLmbhKr/FRcIwuSOR/bmU8
         6XZNoiZyY0CrzpG83U2kA9dHQiJq+5VFTcWiK1Y7m1BbStrARZ+FoSXiDf87NEmo2z/R
         /uQNlWEMPRPNNyD9zcL+uAAIAV2KLbLzN4CVFfTcRdrTMCsfz1LNibayUO0Bet5jQEKK
         nr9SA6i8Q3Y9pBmD2fShhoaEkhy+SanvBDfNqdDLBVauxNWEstvGu2ZSSzHmEH6W6tP7
         Sy/A==
X-Gm-Message-State: AOJu0YzaQj1Uia24DxZaKvnNzBDDFzzeSVer8lRv/h9qUaJ3Y9KdxX4R
	ha3JmeGA/DF6yxOhO1dqG5O5wkKa1ng+Bm0N25anE4JoMsK/GmKf8hUA6w==
X-Google-Smtp-Source: AGHT+IEr+bb071DTjycAg7TSxqG/Ztfnz2xO3//P7l7cKrCJY00ajS86UpgnKNvJg0cjU/A7X7KRCA==
X-Received: by 2002:a05:6a21:1706:b0:1c6:ed5e:241 with SMTP id adf61e73a8af0-1cf1d0acadcmr11707917637.15.1725900339894;
        Mon, 09 Sep 2024 09:45:39 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5968a6csm3718026b3a.125.2024.09.09.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:45:39 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] fsck.f2fs: remove redundant i_ext.len set to zero
Date: Mon,  9 Sep 2024 09:45:35 -0700
Message-ID: <20240909164535.1926830-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Removed a redundant code to set i_ext.len to zero.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7400dcf..f8607fd 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1400,8 +1400,6 @@ skip_blkcnt_fix:
 	}
 
 	if (need_fix && f2fs_dev_is_writable()) {
-		if (c.zoned_model == F2FS_ZONED_HM)
-			node_blk->i.i_ext.len = 0;
 		ret = update_block(sbi, node_blk, &ni->blk_addr, NULL);
 		ASSERT(ret >= 0);
 	}
-- 
2.46.0.598.g6f2099f65c-goog


