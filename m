Return-Path: <linux-kernel+bounces-180785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3A8C7306
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EFD1C222BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CE1411D8;
	Thu, 16 May 2024 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="F6zIZN9g"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09046D1AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848869; cv=none; b=LC+wmCl36UsP/UhXuJw1Kb8GjD25kUA3e+wjuKp/wn9elHdJbD80eXYgw8WYXN494Va8Z2ul6MR70el+x2S5Go6zJNu+V+lny+HkHKmRGFUexVdq+doDwJ82rYkvlUgkovxosMYilxZUwO2t79KV+ynSOBkD+YuacHuv5njlD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848869; c=relaxed/simple;
	bh=WxEuVF+8Xo/zBaVK5S2RnnJzubEG6wFM93qbAiMkUYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FEAaqZ4o35EjmtIax8Iv+3jA/kp0b+6TV2rVjJLJ8t44L1gf+8CROYua0nfNpN8mIBvMK+AVBEkK8sUUIxJJ3XXrskdBgcinBM1hw9sW14dPIVqSXuc03EUYPrGXUtaFVWt9O/7EFoL8wsrZreKqu96EWp6PHUC41QYS7DK8o5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=F6zIZN9g; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so5947302a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715848865; x=1716453665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Esd0GZmxioawR/DRCed2mayNi6h1PjS6WdNf8dc77p8=;
        b=F6zIZN9g1sZi8JkiZfFNjutjuu3bDNYVv7m1bZYtGZ5L6Wvbp/QNkE7HjlEMDSshrw
         gnphjTuGLxBM+c4FO85Kn+0TkiC21VOAdmofoSr3x0RZSw/8QtppmP+tdB9mfemEQTvT
         2fD+JTQhh/eiZdHL4+RxnLjZ4XK5aUWTvXvW8+XcRAQF5sI1mEdEEoQbRBU5uPdHkyQu
         Wfft4AcG+T+84wOFXFqeRsLGxzyD4iONJonTCTOAlYQL1xdd1dI3xwn2rTPmc17JSIXD
         vGdDCsfeN+HHebARZjBQz2nP1/loRBxIVUH0DySo1iJQxWvIT3XXP1s7ciVQbodPRFVt
         2PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848865; x=1716453665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Esd0GZmxioawR/DRCed2mayNi6h1PjS6WdNf8dc77p8=;
        b=lB2+DHwBt/SNR83CF/61EO5u0nod9TcVKgHfiAOB/DA8zZctEYDa+CLaSCJgJXN8tj
         Wmb7ieaesfHEbNKkc/NNvwsbKnTk4oNdpHY2A4AcS96wktNVLjIxYYOaqQP/mAr2y+nu
         W4sv4KXmghVf+QA/5nAZ1bypjUn4FOYXP6IyVYxKtSTgzrx31IG7YPMgDQkYWIwFcMGX
         HXZHB8+xB1+vJTMLbBMiaQXelanCkrLwRu94dNQMA+oK5ivd6kUL8+rVdCXChpGU+l9L
         Q8MKeTf/tP4/VIZKncpfgLxUHJoNMJ9rTUXGRAKI6sdKNhMLw0OP1Ud8gLNaCLh2HqSI
         Vfaw==
X-Forwarded-Encrypted: i=1; AJvYcCV8kENBUbD9W75OgVcKuJvAMvHsYbawMEyktdRDaynuiTtRenQBhr6n4J97TtSBMlhB9GH4I9/ma4m6RCpyOcwC/xML7/+7Yg7prvje
X-Gm-Message-State: AOJu0Yxj07Pez/TOALbsGi9bdcUK9T6R+XdsUOPvVWyD1stOc3Yrcj6A
	YMBBSUP4lm8IWRDfF5WjZSCHn+OgUvx4Dqg2Kz4bZhj86tNyoxr2fy1KoiXz7OwaWlPAntBNSio
	Wq1w=
X-Google-Smtp-Source: AGHT+IHwfBvimhF5iUOb/bPZFTDnoArKyh1m/EcsmmDegZRq2brLO0Tbj5+711rFvFuOKFt6EyUqzg==
X-Received: by 2002:a17:90a:428b:b0:2b9:c9d5:47d4 with SMTP id 98e67ed59e1d1-2b9c9d54b5fmr4835214a91.34.1715848864827;
        Thu, 16 May 2024 01:41:04 -0700 (PDT)
Received: from sunsj-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:e2be:3ff:fe61:8d24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886cf36sm15062990a91.30.2024.05.16.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:41:04 -0700 (PDT)
From: sunshijie <sunshijie@xiaomi.corp-partner.google.com>
X-Google-Original-From: sunshijie <sunshijie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: sunshijie <sunshijie@xiaomi.com>
Subject: [PATCH] f2fs: fix panic in f2fs_put_super
Date: Thu, 16 May 2024 16:40:56 +0800
Message-Id: <20240516084056.1081148-1-sunshijie@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When thread A calls kill_f2fs_super, thread A may submit a bio to the function iput(sbi->node_inode);
Then thread A enters the process D state, and thread B may also call kill_f2fs_super and execute the code sbi->node_inode = NULL;
Now that the bio submitted by thread A is complete, it calls f2fs_write_end_io and may trigger null-ptr-deref in NODE_MAPPING.

Thread A                                          Thread B                         IRQ context
- f2fs_put_super
 - iput(sbi->node_inode)
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
                                                  - f2fs_put_super
                                                   - sbi->node_inode = NULL
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
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a4bc26dfdb1a..adffc9b80a9c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1618,7 +1618,6 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_release_ino_entry(sbi, true);
 
 	f2fs_leave_shrinker(sbi);
-	mutex_unlock(&sbi->umount_mutex);
 
 	/* our cp_error case, we can wait for any writeback page */
 	f2fs_flush_merged_writes(sbi);
@@ -1648,6 +1647,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	mutex_unlock(&sbi->umount_mutex);
+
 	/*
 	 * iput() can update stat information, if f2fs_write_checkpoint()
 	 * above failed with error.
-- 
2.34.1


