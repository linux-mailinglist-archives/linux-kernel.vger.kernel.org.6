Return-Path: <linux-kernel+bounces-180801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28B08C734E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85943285787
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6E142E8C;
	Thu, 16 May 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="JL7Lbu9v"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26372D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849724; cv=none; b=eFCHfexyxsrWOOihaeUVGrsHSdOl/XDSR1/XnBJr5Acita1y1CWhXwYr992lUWc1g4jWYb8z+/H0IoP7git5/Ms8dH5VFqIWwaS/Eyoy2BQEwjmcoX0EcKMosh15iG/i5cYaekiJ1xJXLYYmzsD59T8zjvxRO8b4Iq2CWhJTnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849724; c=relaxed/simple;
	bh=4JY/y7h8IbHZgWQLevKtmE00BGUusK/OlIJOpKQdFk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2jvI7WRkkPnS1QAwoApoxREa2qbgWYssj8OUX4mskMO3KV843NUlwF4F1PwJ1Xa7S2TBJjxVSMYALBvS+DC0Rd35DNdsYSgXZaGFugUM7nipc+rJABVuE4NvrYDArP/EMLK+7dWBeCOTqwqoGEQaz6GVw/ybneCtcbiYXlLolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=JL7Lbu9v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed835f3c3cso67779165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715849722; x=1716454522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zZvSaNtWmUeNxkI4ppv185+1yoxkOhOT++YkYnKwwU=;
        b=JL7Lbu9v1haPR50FptcGfGXnSvB7p0mJYJiXW52gzXeFwNaBNOwYQAh12MZLqqqPkB
         GpBqmcnGZhge5kCbSIibYLpV6riS2yAJLQ2X/H5ifby2XuwwIgOPlRnujuBm8g1qpkEz
         MXkpGUQQqWXE8wTakrdmHKuVFyka/185r50XP8VI+HXtjXq/RiZe7w14erG1OlAiXjld
         Kk9+N1f48XAZX17/NAppAPwkvfd1lWNGvqiP8RCBcbLSN2aQrTnb9P2p8OvlVdNGeDir
         l62ue4w6gxWBZdXFJksMpjHwkTjlFHs/fAQ7Ta65/ieCvWDjhyebUXkU5kXWuB8PYSCE
         M6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715849722; x=1716454522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zZvSaNtWmUeNxkI4ppv185+1yoxkOhOT++YkYnKwwU=;
        b=XR7w8Ql1LmiGd3HwptKzHr/xwXaeOhncTt5nzi23idtLwyGttSS0kbuk0KjhjdVJ4Z
         TesbVKwdQBO5phEJWUNpj9sZPDZbnlAJXkOD70uWVSnkFjwz5/4MLUZqvfVTCF9bx3jz
         5lyZjsWUO1Zmg8FUjj82HcWZsWMzG2vPKa67SiyejlA+viSvhrG3AQM8Ij2hmLmcw6J2
         LLcrxesBQZeHy7HxeBTFj3KR7APGaCBAxF7gUzVBBT+ENoH4Ydk2czXF8JWnjf1a/D6R
         KkYHyRTQlYMQfuaXnTX+8kDpcEBJN9j0UlG7gXHBnlvFTgEw0wL9kdXxSjA7TW4bL2+f
         Lc7A==
X-Forwarded-Encrypted: i=1; AJvYcCXOgHL7lNuI8GlUX6TSXcIvHwVBUEhuWW+4fq/2XJCt2PSHJ23WjeftRvfdG0OVjePxVwK2P6a7abX1Eqjz2od/RfzbNwqNgzGDS67M
X-Gm-Message-State: AOJu0Yy0GuUPsapMEMB8ta2eLwg/ajt659UMhufS5YMu6M1y9JLu+27p
	tMEFYjeiq/Eji/Av+X9z0ZGqr3Of5xLZYtdukke9NPdxrQWr12U7ePRQev+RxKtfW4QQiC0OuS3
	/7+c=
X-Google-Smtp-Source: AGHT+IGm3lxBHFLAvKaI79CGN2/QymiEVySGur5nnzPFjC0fzWOI2djjqsS9XMe6a56FMT0cnbqKqA==
X-Received: by 2002:a17:902:930a:b0:1eb:7dc:709a with SMTP id d9443c01a7336-1ef43e2966fmr207153695ad.40.1715849721881;
        Thu, 16 May 2024 01:55:21 -0700 (PDT)
Received: from sunsj-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:e2be:3ff:fe61:8d24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf33021sm135588635ad.124.2024.05.16.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:55:20 -0700 (PDT)
From: sunshijie <sunshijie@xiaomi.corp-partner.google.com>
X-Google-Original-From: sunshijie <sunshijie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: sunshijie <sunshijie@xiaomi.com>
Subject: [PATCH] f2fs: fix panic in f2fs_put_super
Date: Thu, 16 May 2024 16:55:12 +0800
Message-Id: <20240516085512.1082640-1-sunshijie@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When thread A calls kill_f2fs_super, Thread A first executes the code sbi->node_inode = NULL;
Then thread A may submit a bio to the function iput(sbi->meta_inode);
Then thread A enters the process D state,
Now that the bio submitted by thread A is complete, it calls f2fs_write_end_io and may trigger null-ptr-deref in NODE_MAPPING.

Thread A                                          IRQ context
- f2fs_put_super
 - sbi->node_inode = NULL;
 - iput(sbi->meta_inode);
  - iput_final
   - write_inode_now
    - writeback_single_inode
     - __writeback_single_inode
      - filemap_fdatawait
       - filemap_fdatawait_range
        - __kcfi_typeid_free_transhuge_page
         - __filemap_fdatawait_range
          - wait_on_page_writeback
           - folio_wait_writeback
            - folio_wait_bit
             - folio_wait_bit_common
              - io_schedule

                                                  - __handle_irq_event_percpu
                                                   - ufs_qcom_mcq_esi_handler
                                                    - ufshcd_mcq_poll_cqe_nolock
                                                     - ufshcd_compl_one_cqe
                                                      - scsi_done
                                                       - scsi_done_internal
                                                        - blk_mq_complete_request
                                                         - scsi_complete
                                                          - scsi_finish_command
                                                           - scsi_io_completion
                                                            - scsi_end_request
                                                             - blk_update_request
                                                              - bio_endio
                                                               - f2fs_write_end_io
                                                                - NODE_MAPPING(sbi)

Signed-off-by: sunshijie <sunshijie@xiaomi.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index adffc9b80a9c..aeb085e11f9a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1641,12 +1641,12 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
-	iput(sbi->node_inode);
-	sbi->node_inode = NULL;
-
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	iput(sbi->node_inode);
+	sbi->node_inode = NULL;
+
 	mutex_unlock(&sbi->umount_mutex);
 
 	/*
-- 
2.34.1


