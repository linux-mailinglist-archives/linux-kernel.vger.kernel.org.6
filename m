Return-Path: <linux-kernel+bounces-332844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B048E97BF99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7907C2837CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75A1C9EAD;
	Wed, 18 Sep 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHm9fT3"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93521C9EA7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680066; cv=none; b=QeGnST2cgU8ZxgKMuaeEm1VYHk2Hb3AaQb3B35ju8QeIqyfpPoVmhumQqIkL+4/AGEhrqxbpguyXwtaReZqkujoxUKxrCrWEQqTveOQh93blQ92eMtaguMnfUvjvQJXlTS/2BxQlpbo3Y0kaGEcB0YXuktaNVvjOclzkuWMgF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680066; c=relaxed/simple;
	bh=wdJOrGs35uZAgenFPyRtZVhdFWiwxgcmCBPZMD7rp68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpS/5HpTD/5282WBn6VLZ81OHK8q0umHlO2ZZPSMzf5LTQfAOc8w3WCRxLkihfZnMMW9cq3NG+8eNDDWVkr4nDS0aFTV3ZRMDLTkA2jieUAYb2LkUzY6sP41iE7UJ8u3mhRwFzzKabypcSTYWQdg/74RIjIb/hHF6jx+rDS4ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHm9fT3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so5234454a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726680064; x=1727284864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qrVPgtc9pr0MYXVJUam6GnYq72ewYaQxAFUiuA/F6Y=;
        b=BSHm9fT3CYHsrEDbWbaJpBlcVG5UtBZXM5HU39EUzxCZfLaMvFNFsRCHzmOXGKw0JA
         w5twWIcCdlIC5SABN4aeI3UndP33eYHnjA7BwlosOeUQM2sAZZhIbmzHKEhXsNoaVphw
         7sfOoEtjnExht45dWMOs95XhhxpTKT2Sx1kO1T+7cKFeada7+LUghgPw2IW/cW/RpsTq
         VHa57oWEftaDLkt9tRqpycIvwh21QmFrmrZpuf6zX6Ccu6YU/XSbhqzwIl4rXrZwpMvy
         AY4sQyQikmGj01fdYfA/1d0TAdKS3q7LbhdknhwzpvCHBFM/ihfJCyFvQngEDjsudoPH
         aXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726680064; x=1727284864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qrVPgtc9pr0MYXVJUam6GnYq72ewYaQxAFUiuA/F6Y=;
        b=WtQfoArT5snNQqtyo4RL8zDEH+v5zrNTq5LLdORD9fnfZ+wG47meU8kuE3ngfH4CQN
         AhuUpzNoDcI6tSd3QYe4zXB5+zzbB/9aTZiTnVhs9Z5+9BBEHW8orLmr+1DAh7zeGEmU
         DdKNMHwr36SNtfz948wkSVYaaZGF8zaYS4uar5tIaQKTK9pjJrWQIn+o4Qvi5tt1/EW6
         oLUN8F3WTe/JLc/+YTzHK2lSwqPHuPK5kylshh+jLTiLddRzqrjoxQXvGn4Bbn5PnW6A
         DPGC9C39srdZ/qxPskSKBQ9gVLljRSoIYoO7/ZZrjAhQ+RT1ivuIJo8BgHeNyByK9QjT
         f17A==
X-Forwarded-Encrypted: i=1; AJvYcCWSTIO064kRV0zfe24b9dCJAImKrRDYO+54wf0tjTxYmfCwIUt9sVyi36XG3R6j2XQvN0/iaCKsjK4PidI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyf1RBvAaUV9kZU7wbaztGiVjHlaZ1AH3j8bFKzEvSwv/etpCp
	n8fh30uZdtBifer2MYW3V1EzE9TLLqB1zfeaEa/lw0fJwjKXloXt
X-Google-Smtp-Source: AGHT+IF04UxO5twV68LGB/UhP/cNf8F9nCgomakgymG/9B3GMBVg5E8jctBNna5xDFm6dp5UHVbAtw==
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:2218:1be6 with SMTP id adf61e73a8af0-1cf764b02aemr34176792637.50.1726680063771;
        Wed, 18 Sep 2024 10:21:03 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7aeafsm7186476b3a.99.2024.09.18.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:21:03 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Subject: [PATCH 2/2] osfs2: Fix kernel BUG in ocfs2_write_cluster
Date: Wed, 18 Sep 2024 17:20:26 +0000
Message-ID: <20240918172026.2532-3-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
References: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot has found a kernel BUG in ocfs2_write_cluster_by_desc [1].

The issue arises because ocfs2_insert_extent receives start_blk
as 0, which incorrectly maps to a physical address of 0. This
occurs when block is 0 after the call to ocfs2_clusters_to_blocks
which is invoked inside the ocfs2_add_clusters_in_btree. The block
value is then passed to ocfs2_insert_extent, leading to the problem.

[1] https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6

Reported-and-tested-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 fs/ocfs2/alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 395e23920..926ffeed8 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4843,6 +4843,13 @@ int ocfs2_add_clusters_in_btree(handle_t *handle,
 	}
 
 	block = ocfs2_clusters_to_blocks(osb->sb, bit_off);
+	if (block == 0) {
+		mlog(ML_ERROR, "Conversion resulted in zero block number");
+		status = -EIO;
+		need_free = 1;
+		goto bail;
+	}
+
 	trace_ocfs2_add_clusters_in_btree(
 	     (unsigned long long)ocfs2_metadata_cache_owner(et->et_ci),
 	     bit_off, num_bits);
-- 
2.46.0


