Return-Path: <linux-kernel+bounces-555369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801AFA5B688
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5861893EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18081E47C2;
	Tue, 11 Mar 2025 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bhwMc9I7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAA3FD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659200; cv=none; b=qCZoyYfjHNsjm0mNn+/GQcpSclaEXpiaKNRwlinQsmyMktHsIyw2UKO+bXbTQWuTBC1UgbQKT/4DrYi8MUzPfW4KHo/4x7oOi+HdPWBgN7N6DujAX17KlneX5h4bp3sPD2OiCnY0rtdPEA9afskBqj+WxPwZASyVBSbGAWiUr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659200; c=relaxed/simple;
	bh=udy8jRbGI1xRGhqFWBbV+CYLNO8MxK1GHbq47bU8y3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfPLYsDJTke0xL3zvg0xB0Zl5ARlzwBPH0jCe5qLiWD819+GRPY4EBlnYakCf8+Qd5+64npIncXNKkIHf0HuZ5Fuw8ILfV4mqm8HpTCOYcZVTfRG6f/a8I12qGJqVhiUxlyAoT0ylU+VyE/EIiIG2qoGF+7JzWejD+ejljMgaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bhwMc9I7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239c066347so85925365ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741659198; x=1742263998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEx1nNscCBpj8PvDfq9jNWOzGRxlbE/gLhvOGDUNIIs=;
        b=bhwMc9I7pKKyC28TA5/PVy9ed3bcLQ1DSTLEolKAnI39CIRIZ5szwnxaWp5qI7TXhb
         IeDd1BplwJVnmgm3DpGuxoqls3Io/Jd0WVA6z7BMWeuVXwODT/1KuNoUtGJa03XK/ba0
         lglqr4X0xiYVD+1/+IOBwC7GeEmC0/odi+Rjf8JDICLbZ/0zGL4E1qe1H8hWgYrPA6Cz
         1K2Ul4NTMaUf9yrIEKsPLRMdIcAcrfQWB/DrDm+hH+6HMxhWZpAkLlRRFNPGaomQvdaR
         v+CEy7iL0q8N8KrXdcNoBRozJjlCmV5cWwkgQNh8x7zriYPZGUMexsA07FBoi+tgmX/6
         BHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741659198; x=1742263998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEx1nNscCBpj8PvDfq9jNWOzGRxlbE/gLhvOGDUNIIs=;
        b=V9dQp6SvthAsDOlnTBPb2cbK9CdBxOH7XjZIq+8B8+v1yRh4TOPn4MXI+3JYhGa2Xo
         0gWUzGAWc+04SEV840yaCTspC4DWvfilQh9KyJkipGcYm9/M/BogEStdUom3dqhNnyxz
         hZNJu9YujpB0k0RLJLgJGIg1abTcJ3TRgmQF3au1JF7Ueyt4gfIOqFC6b8lF4BOojOxy
         kp7KQlhqVYQULmGs34z93ijFC+YKTcAzh/hwIsbK2KJTMdJ9jQUyAIhe3xHXJRTu0+9u
         ToH2vkgpek1Vo5e1Wm7F3E0siuHFVEY/GpkYgYEGdESmR4XG/IApwwK1pbiTRLmGRpZ9
         N4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVXonmvel1+7BQkXyhLdHWzMKHTq8k3B7EEPsmTk+JZL8G89mgd8A97mN785S0FhicduVfG5/GCSKeNOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfO/mBm9kCYFf54dvq/K2ovavVTDlKERQSGidLx2ZdGAG2S4Td
	ZMC45BCeg+aQvL5bg3vaHFvXa15wNNYe0y8ZPtYmgZrGYZ1DQyf0Kp3yWcf+EUw=
X-Gm-Gg: ASbGnctDj1+kQ4vN1+PpfiRaJNPFFhEg8MfJwXWTDQ40K1gj3xKsSFqQsF3Heg38tgL
	DrrV9+rXCVHy1WudwPOiafzxRSxj9hh2pcf2ZIFfjH5l9T57VoRrj5y2PTieb/gxfGPpDPPZeS3
	OGbpH+jxpMJ7OpwKRBwpVlJkV5EFwE/qCq8vbLbvlW5VPwWy6JOZOqaXD0Mwux/JNQrTwkJL/le
	so8qkj5vlyvF/OGOKtHvf4sgXYTgu2ZYZT92v4ou1qlilJmp8M2rN1GIhH8C0JFeGYR8Xmu3uRA
	i3onuE0fReDS7Pdvzc+ai2ooVaDAcN/iHCESiUDZG1gQ9/sB6I/uTySWde3zszibtg==
X-Google-Smtp-Source: AGHT+IEAV3kSCGbgGRfNs1o/R+ErPgdvcNrYhYzTSAbHfjdRjgn5bgiqiwCUDib6f5F0APcd1aFqXw==
X-Received: by 2002:aa7:88cd:0:b0:736:621d:fd32 with SMTP id d2e1a72fcca58-736aaae44efmr21428387b3a.22.1741659197793;
        Mon, 10 Mar 2025 19:13:17 -0700 (PDT)
Received: from n13-144-013.byted.org ([36.110.131.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698204fbesm9132193b3a.36.2025.03.10.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 19:13:17 -0700 (PDT)
From: Diangang Li <lidiangang@bytedance.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [PATCH] ext4: clear DISCARD flag if device does not support discard
Date: Tue, 11 Mar 2025 10:13:10 +0800
Message-Id: <20250311021310.669524-1-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 79add3a3f795e ("ext4: notify when discard is not supported")
noted that keeping the DISCARD flag is for possibility that the underlying
device might change in future even without file system remount. However,
this scenario has rarely occurred in practice on the device side. Even if
it does occur, it can be resolved with remount. Clearing the DISCARD flag
not only prevents confusion caused by mount options but also avoids
sending unnecessary discard commands.

Signed-off-by: Diangang Li <lidiangang@bytedance.com>
---
 fs/ext4/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a50e5c31b937..1b4d8475a08c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5616,9 +5616,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount9;
 	}
 
-	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
+	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev)) {
 		ext4_msg(sb, KERN_WARNING,
 			 "mounting with \"discard\" option, but the device does not support discard");
+		clear_opt(sb, DISCARD);
+	}
 
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
-- 
2.20.1


