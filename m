Return-Path: <linux-kernel+bounces-337699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA899984DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDE0B20FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851F1465BE;
	Tue, 24 Sep 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GGnG6cQW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8913212A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217093; cv=none; b=Pm6fliBcxOT7KSa4PgzWtydJmFKuiJe7aGevO6xPCE/aO5IyVvJ+wa8Nc6sYe379GLj2zq5LAP9BGnlt38+KHEAMx3HvKaAwpnRegTbOT2GHb8jOk9LQSiZLKQqkTmAdndsqJ9LAgMz7wAu9/zlsXfQwVF/L77YeqOmgSg9CnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217093; c=relaxed/simple;
	bh=mPXnF7hMkUm99VEerNDvKssi7GoYEqx+nCfJxCNI5gE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFfkbxka8IfMfJEe7juj9NwT/W3SVUcJedrNgmqPNMvUot4HUvjVfd8E+LVKsfBBbkwKeBvwP9b/ySjZZcL0L1YdyHrA6S0LIg+UNzpywSM9jL3BwzNvrYvIHfERa/YAOfBxG/LYeBJWPWPxTiKflIU0c5iQHF58LqinwuTaGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GGnG6cQW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206e614953aso59751795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727217091; x=1727821891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0a+dC7bPkvRCPdf1FziTYWIZO6MVoEFRBy8NHKXmB8=;
        b=GGnG6cQWO05rVlpCLaxt0RN2/e6Pf5achfuaU+7ZsA+UvPYtNLARQ/Pxex4hPiDjnT
         0aUG6SAkIcH6sj45lEQjobsV+QeWI43CHGhNwqns+sU7thgaC2jLj7fbkgd5Sj56eKK/
         QbjupLyN4W9E+Sf3AKd0i10LLXfh76fXcyYU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727217091; x=1727821891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0a+dC7bPkvRCPdf1FziTYWIZO6MVoEFRBy8NHKXmB8=;
        b=P3aUEqd5OlX87Rv4UnGq/eyei/Gfj1/66JydjJ9q937c5VrY6HfUKAvA5Sw5IntyZ7
         2BDIOuKGVK+EgSv7lQfDzKBOT7YXfILtJm+xz3aWWt9bb0uhfLsUnMsdFu+Ke9FghSUM
         8OUQfursJCzY0YvWnEZbj5j6yxOO/9oGTM0od4WOnHdgncDVeGH62lEbCwqa+Na/jMWc
         RsnHG1+/B5MMOaD0jqPOplaYV36AduEA7qnt4rTep7ilnyVkvWIZFxwGtfhmQne2q1Xu
         BVccF8QAKmwCYEsAnmotQ2PHrzbWif8DXDX5oF0eOmF+Brg7vJr6w5OIODQ9UY91/pmf
         grqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6cMWzRgpsJDERlecaRqYtpKpI56CcEOwKg3OZJ/OTfrvzH792UMnL9H2OJwsBhcJV7Efr6aeIi418+d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSixpXpHU8+yHUA12LF2MH7cS+HK5tWut3HKdPj7Xjkz1/tsME
	ehXx+8/M/Vh7Pgt8CkLgOMmLSDTlzp2psm7hWgTk3CQYVkIRAoSHzmtAesUU2Q==
X-Google-Smtp-Source: AGHT+IEi9k/FbY6zEWEIa9h9GpTHhnlsJzfXToS3+1LZrx9tg8QQC9qwAH5eBkvFqZmBKD0Zi/wz6w==
X-Received: by 2002:a17:903:11ce:b0:205:8a25:904b with SMTP id d9443c01a7336-20afc66e1e7mr10761525ad.57.1727217090765;
        Tue, 24 Sep 2024 15:31:30 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af185471asm14234215ad.257.2024.09.24.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:31:29 -0700 (PDT)
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
Subject: [PATCH] xfs: add bounds checking to xlog_recover_process_data
Date: Tue, 24 Sep 2024 15:29:53 -0700
Message-Id: <20240924222955.346976-1-kuntal.nayak@broadcom.com>
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


