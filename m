Return-Path: <linux-kernel+bounces-180891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9F8C7475
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3ED1C22960
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AACE143897;
	Thu, 16 May 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="AZol+G6F"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429614387F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854426; cv=none; b=nhO1CiypAIg5iHb+uqVl7m5XIccgZiYngiaYA4+lEy3rMxE+xOWZyEY8XVsDHkznKRvq6D/p6yLsmMm+skkCwJO4+9VTqLgJE5x1IsIqMjrypEybj4NdjQWKmvOaQFjHu9CjHo4K0bvtTJ8UEkEyLu6gZGk3FTydtsziJMO4NM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854426; c=relaxed/simple;
	bh=+PjVUndjZGvkd5Ya2aakBHr/tqpTphnHvJ2OF/15nlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fgl5V1a1R3y6xjFyXcAhljb8MRQ1xBT221al3sZ35tUKp2wqsJjriEZ6neEfvjXIois6cl/zFE9sujpoFOi3UX7Ee+6ll77HB4j1DqkAT9FX/xj4nlPJkxTzAIdhjzHVi9/0LNIRNolbhUkuxYT/cmkD7HysPN6OGzkLa6qDWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=AZol+G6F; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b290669b0fso3842393eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715854424; x=1716459224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5sj1HRu3Ig+X2qOqXlWio1jhIvbeRRxZ8mV6Seog3I=;
        b=AZol+G6FWGk2q702mhasvp9kQHkkavU3kqF8IJV21ja0PvPt41kboBfCZ0/sV0m7qt
         Hj0t+oAZ4ygARL9D5XDg7sB9ULaGyv4nWCJks9c1Eb2Nswit3PFhGRIfLLh6vrAfX185
         g9i8vr4jz0QfgM9uSNynZPQEjDchCgvfpKkn7SWpx+hDjPPdENYvw3Kk/Pd7pUpw8/bF
         QgmmFhEWoa/i2kNRQBHkfpQ9ydOHDn9pa0JlE6Wk7eOEUq9B1SUYA0lEZ3hmuvjAb7Xw
         KM4oDmQB2eCOCwj78fHctI1tTPJ/YjuTp9/6d2wScy3JGz6TayRNztGdAh1+o9gtov7U
         JL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715854424; x=1716459224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5sj1HRu3Ig+X2qOqXlWio1jhIvbeRRxZ8mV6Seog3I=;
        b=mJI1OhUtg2YXxSSEsmkCXW6jCKC5qeP8+MRhctp6PmrfMIhQqWXO7Faxzsv/ZnMv91
         N28TrdD6AD/DIvnFtfs2tgapDOa4fKV77wqIgLKmYZmwrPR1T0IFwXqPVFEcR0q7chIq
         0KThDxWjBdd1TDdaznrD/TvyXP7OivNCR7KiawoH7btMVLpllt7h3w9ffWaLGku9rmMw
         C3UEUI+wYhS43uWWXzuH76SFqHrFwBRFLH6FzOdse8Q6AaVRrVB+79EkjocWmQSzKClO
         6Ufow3kpu8ZdLVbrEcucUIBU8lGkj8oBwHHkpjgcaDizRzzy5SfPStxwhl0JBsZA1O6D
         2htw==
X-Forwarded-Encrypted: i=1; AJvYcCVwuFUxMbvNsXn0KQcNRLWQxlUsxtln18QpKIXj5YIlPNl5L9lbkrECV2ycvAglsOR+QyH50Vc+VgUZ9H2T0sCPOY1nJoNEgLCYxnKK
X-Gm-Message-State: AOJu0YxNiOzMBhgiSaiURQMwpZv+pBV3pkNx/nrE/i/tiBqr8uBuAK2W
	jpM4pt2sOg57EbYIOO17+P469fGb8r4wGKj+nXV/NO7qLn9jcuQhljObSJVvewk=
X-Google-Smtp-Source: AGHT+IE3kPBO4KARlWFqlg5xjD0vBi1340ru39bDDQj8/8OAoLZYk0G/aVFKf1PqkgXqNSw6i5E54w==
X-Received: by 2002:a05:6358:9494:b0:192:75c4:2edc with SMTP id e5c5f4694b2df-193bcfd1c27mr2539152355d.25.1715854423624;
        Thu, 16 May 2024 03:13:43 -0700 (PDT)
Received: from sunsj-ThinkStation-K.mioffice.cn ([2408:8607:1b00:8:e2be:3ff:fe61:8d24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f28asm11355948a12.26.2024.05.16.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 03:13:43 -0700 (PDT)
From: sunshijie <sunshijie@xiaomi.corp-partner.google.com>
X-Google-Original-From: sunshijie <sunshijie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: sunshijie <sunshijie@xiaomi.com>
Subject: [PATCH] f2fs: fix panic in f2fs_put_super
Date: Thu, 16 May 2024 18:13:38 +0800
Message-Id: <20240516101338.1089140-1-sunshijie@xiaomi.com>
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
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index adffc9b80a9c..62d4f229f601 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1642,9 +1642,9 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_destroy_compress_inode(sbi);
 
 	iput(sbi->node_inode);
-	sbi->node_inode = NULL;
-
 	iput(sbi->meta_inode);
+
+	sbi->node_inode = NULL;
 	sbi->meta_inode = NULL;
 
 	mutex_unlock(&sbi->umount_mutex);
-- 
2.34.1


