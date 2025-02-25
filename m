Return-Path: <linux-kernel+bounces-532513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB9A44EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A87F188CE22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042420E71F;
	Tue, 25 Feb 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LxGYy4od"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E271A23BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518737; cv=none; b=skPFCwYv6jCizBeJ8zoxIu1JkSnX5qRD3cM4njhiUUfBNi+Nu5VizMYLf82QB0ahJDoh6YZUx2Mcdmf3R+8PQ9S8JKigsorDrHfCvb4R1vzia0hzQGKxra2OEpnslMK223SkAX6CRiViPhJYwkiy5JYtNf1jCc3qSQ5YTJfKOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518737; c=relaxed/simple;
	bh=6GRv5GkkmkDW85ilHWxPO1Q+hLJLxbHbMJxp7x7FbEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgU+Rm2JYb5B8+rAPsI9Eb6dCzocflmX3pFlZnOiNiKH7uKiMs1Kja+qMkWJ0fs2Baw2WNAIf4nHoSAO1QIwcraDtP7hjtWlwV8sfr8m+7eNpF2tcfXIFlkQrWaeL3GVj0aB5fVqDzoTJiLKCjNi5XOU5LWTUNr2sCaeKUvexEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LxGYy4od; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-855a8275737so18605839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740518734; x=1741123534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9HhlrRcc1S9btnxpNw0XGFY9bznftGZITEbOrMrW6Q=;
        b=LxGYy4odxGdpSe2QcnA2MHBd6dOEtHKous/iy3PhvIuqR4dEgDHVnLinQJ/IaP964I
         sHravzzx6YjLTO8AIgj2aNxD6h+GTwpFakVwI3BAqOxEBqnE2bKAgMzbfpe7nWA7/CpN
         HjNcOvgTcn0gnpEX3moggoJLDIDgQFjyDIABPceg1QBUusRTnBW4f6DbjnC5EPCSX7L6
         YL19jXFF0gsueFzsgpEh87iQo2UjQ10zr8AOU6leiN1KgYJ7FtoIc4cGKNShzfAAh9Ge
         vcMsObQa4eZZtpjhTZ9GmNqlbg8p8LplTUD1yz51X8929fmncL8K7h/PkKMaYlbVUmIu
         F2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518734; x=1741123534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9HhlrRcc1S9btnxpNw0XGFY9bznftGZITEbOrMrW6Q=;
        b=B5wbS8Wlkg9Ma89NyAb6UAmOgP1yLmnyJ4Q14L+UNfUUfe/UcOBIk3/cRkk8WJbWi2
         wi0sOiCjHsxTqVyLhmburR2RD2rZC+viIDxp2gDCbgWpKZJFf970JJ2+Bs/9fP0a/P0x
         +zlPWAbNtYjIIbRggiT1HXytM5Cl72kdyFjMPpdwDUmf+L7N7tTdZEgo4PH5jKo8GXZ3
         3+1BRbp5Zts5yf3nx6woAaJU3Sj0NzS7d/gS0O5jc73TcfklTQUHAs/XbeBR0csYc+lh
         DQrB8yMqEZEtnBD2cy1/BResxJUZp825G2URpP2ijGn/tFWBvTqVsUJWRXAYaroLuKzU
         Jr5A==
X-Forwarded-Encrypted: i=1; AJvYcCWtMTn/urmc1LqHho5MyHKas7iol9vfXNoMoVjVFtrTG2pH65Rbf3c9RvlsNeg0VaDXOoiksx+PVSFN7uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8mkivMhtA06pbGGrpiB7Um0vlOwZ3tHDeTU/sCYVDES+rRMd
	1oYJIU3cyW76f34DL4EU6QWXOemyGhmknUZeqmVaEjjrlT7nbnCabF8SrIZ1ClSzKtg0sd06tZ9
	PK0vv+Afg1DDBQz/BUmUTOS03xVBp0/uOlTCgwv1DTM5ezB/2
X-Gm-Gg: ASbGnct0PyUU6Ji+rd6Rr/Hk/P8w7VLaFbCT21LqwO4IYRC6+IjCFfNsKZyaoVzUXsE
	nOTJ+kDW92dnhlnacHDv/OpA1UCOqg3hEa/YGdQcdKCCRi30dl9EvhFWEGmOBeH0PlR4Em/nfHb
	C4sKiIW/8SORk4OsB/tKdUjo1kdU2YfUvNSUE5efghr2sAZFSc3qW9CtZuto6gTBXobhxe8i5Vp
	22yQgWvU1Rpbf+FO37a/f6XRyUE/lOq2mFKN3lEhLAt5oBylGLUACN+XOJWz9x4NtFk7FYZ+FNv
	LXdHdHZSDF9i+oakUGKs8OkozdHdBGMYLA==
X-Google-Smtp-Source: AGHT+IF8UXXeus5YhJoPJknmXIZkIyvq5oCcWhAwt/3Kp6Y5QgdoVWzlq85YfoBZmVtowwISRWeJmt6k6Kb4
X-Received: by 2002:a05:6e02:1646:b0:3d0:4ae2:17b6 with SMTP id e9e14a558f8ab-3d2cad72c9fmr50961595ab.0.1740518734315;
        Tue, 25 Feb 2025 13:25:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d361652f36sm1306645ab.26.2025.02.25.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:25:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 676CA3400EA;
	Tue, 25 Feb 2025 14:25:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 62B3CE4144A; Tue, 25 Feb 2025 14:25:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: complete command synchronously on error
Date: Tue, 25 Feb 2025 14:24:55 -0700
Message-ID: <20250225212456.2902549-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of an error, ublk's ->uring_cmd() functions currently return
-EIOCBQUEUED and immediately call io_uring_cmd_done(). -EIOCBQUEUED and
io_uring_cmd_done() are intended for asynchronous completions. For
synchronous completions, the ->uring_cmd() function can just return the
negative return code directly. This skips io_uring_cmd_del_cancelable(),
and deferring the completion to task work. So return the error code
directly from __ublk_ch_uring_cmd() and ublk_ctrl_uring_cmd().

Update ublk_ch_uring_cmd_cb(), which currently ignores the return value
from __ublk_ch_uring_cmd(), to call io_uring_cmd_done() for synchronous
completions.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 529085181f35..ff648c6839c1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1864,14 +1864,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	}
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset)
 {
@@ -1923,11 +1922,14 @@ static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 }
 
 static void ublk_ch_uring_cmd_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-	ublk_ch_uring_cmd_local(cmd, issue_flags);
+	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
+
+	if (ret != -EIOCBQUEUED)
+		io_uring_cmd_done(cmd, ret, 0, issue_flags);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
@@ -3054,14 +3056,13 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 
  put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
 			__func__, ret, cmd->cmd_op, header->dev_id, header->queue_id);
-	return -EIOCBQUEUED;
+	return ret;
 }
 
 static const struct file_operations ublk_ctl_fops = {
 	.open		= nonseekable_open,
 	.uring_cmd      = ublk_ctrl_uring_cmd,
-- 
2.45.2


