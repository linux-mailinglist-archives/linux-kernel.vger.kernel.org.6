Return-Path: <linux-kernel+bounces-337722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36488984DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6726B1C23AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4D14D290;
	Tue, 24 Sep 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="goqHFmrA"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA81474A5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217708; cv=none; b=VNX/u38ntUtjkFBXYIyzlcA1k7iddN11hkT8dYNqj1tPZz8TfqezvxbcCM/ejGsFniakOqnG6h2as/+QyZtPeyglxaQlJ8vFc1bRQL9XREWsX3AQeWInj9puQgS3GLhrZFEb3cXqEea6oz8qbgdF/UyBGdAOmJG0EeZHLJMCYfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217708; c=relaxed/simple;
	bh=mPXnF7hMkUm99VEerNDvKssi7GoYEqx+nCfJxCNI5gE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUZxOChMuvac7ayvj/HxsfL/dztgOOz7CxCKGQvksJRDXoUYeUnztUVdYouY0dF118FU71sNDuO1WDR5eWxVng3LQG1LnLrHihqOWdb8Pml1eu8Zfmd4UB3nIB4Xxdzo0TwvphjwPWvq20pyZi9sCv8v6GOUanUkW7KwsUCtQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=goqHFmrA; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9a7bea3cfso383497685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727217704; x=1727822504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0a+dC7bPkvRCPdf1FziTYWIZO6MVoEFRBy8NHKXmB8=;
        b=goqHFmrATnV2YSdXvgE8xfdQPfP3hbgRrTHi6qbTIxLayVRc7RkN5GZbQFl4vwpKE+
         esv9xu3IipjrzGUOsWCRIz9gv7BQFw3kgIhvU4KcstS+n0qd0B25Za1OXTYmfONVRvPX
         m34jJLQLazIG7Jk7Q1ZzeCaO3gB2jK4G3/ouc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727217704; x=1727822504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0a+dC7bPkvRCPdf1FziTYWIZO6MVoEFRBy8NHKXmB8=;
        b=Jt9juObYfJaGp7ywzoNbwDlPTNA9HkZ381IR0CtU0+x3G967jxiQ2zVv0xzrhkRh32
         pJjgLsqcIyvtnJiyUO6vuPJ6QZ8GgSmba02HKlqgjzaZTGP6bL70bsoPalsE8iLU/juA
         ksVUKxuUPslreg8j4uhAfFm+QQVotFka9Jssp0oYxD0dtbWF1qho/RB7twkUZ1PLDlF0
         PfrQYyoPtYsoURyZKGLCbgLXRvmlIbZQJOJFSSd7XZZeDIxgkABA5dlPJRw64LdY5fb8
         RTl40QSSiz/XDC+a+6n9fBkXVoPnk+mZDf5A0lOheMmoR/DOWWyH/KBWmKgqJth03uDc
         ESjw==
X-Forwarded-Encrypted: i=1; AJvYcCUPfcRkVaSr1//qKyOX4pBuVRlLajEl3F66Spe8t45GSXzrLbnQbhDQo+RebcQMuaHVL2561Nyg2v9WARY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKSbcTW+CkCPTl6dtQd44pJv+iLJ//KAqN/2Q/oOkCskm2HQ6
	9yOoWvMzoAA2g/WoXJH9Q5Zu0QGNkexr+huMbrwNDXk9bkjD18x5TQA7z5fAww==
X-Google-Smtp-Source: AGHT+IE39ZVbpC2igbn16XZ30Di4nIf8N6wS8SaYUKMQBPWPMPJvDmLuOfL87RMesCOfEKAa+FbXJQ==
X-Received: by 2002:a05:620a:2454:b0:7ac:d663:f454 with SMTP id af79cd13be357-7ace741486fmr124086485a.36.1727217704498;
        Tue, 24 Sep 2024 15:41:44 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde53d6d3sm114843285a.42.2024.09.24.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:41:43 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: leah.rumancik@gmail.com,
	jwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	lei lu <llfamsec@gmail.com>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH v5.10] xfs: add bounds checking to xlog_recover_process_data
Date: Tue, 24 Sep 2024 15:39:56 -0700
Message-Id: <20240924223958.347475-1-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lei lu <llfamsec@gmail.com>

[ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]

There is a lack of verification of the space occupied by fixed members
of xlog_op_header in the xlog_recover_process_data.

We can create a crafted image to trigger an out of bounds read by
following these steps:
    1) Mount an image of xfs, and do some file operations to leave records
    2) Before umounting, copy the image for subsequent steps to simulate
       abnormal exit. Because umount will ensure that tail_blk and
       head_blk are the same, which will result in the inability to enter
       xlog_recover_process_data
    3) Write a tool to parse and modify the copied image in step 2
    4) Make the end of the xlog_op_header entries only 1 byte away from
       xlog_rec_header->h_size
    5) xlog_rec_header->h_num_logops++
    6) Modify xlog_rec_header->h_crc

Fix:
Add a check to make sure there is sufficient space to access fixed members
of xlog_op_header.

Signed-off-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 fs/xfs/xfs_log_recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e61f28ce3..eafe76f30 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2419,7 +2419,10 @@ xlog_recover_process_data(
 
 		ohead = (struct xlog_op_header *)dp;
 		dp += sizeof(*ohead);
-		ASSERT(dp <= end);
+		if (dp > end) {
+			xfs_warn(log->l_mp, "%s: op header overrun", __func__);
+			return -EFSCORRUPTED;
+		}
 
 		/* errors will abort recovery */
 		error = xlog_recover_process_ophdr(log, rhash, rhead, ohead,
-- 
2.39.3


