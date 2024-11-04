Return-Path: <linux-kernel+bounces-394228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC069BAC25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286DF1C20B08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3F18B464;
	Mon,  4 Nov 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIwwqojN"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59F16C687
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699086; cv=none; b=OpYPZKItqyup54LPtjsm/cqPrdWzd4dV2KRPKHpjnFluy1FUpiM9XoDse4TSwDQzH5+wcvJnprMJSkQbj55wH8BXItC1ejPCg4qJyvgdN2pApPAHLA/BC8BTSeOKJqTHTDKVTuVjm8VTiquG7zP6fVPCqm4MjNJa798y51hq03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699086; c=relaxed/simple;
	bh=U4dJt/854Lo371XlvYWyyrvEVZ/WthGp69JP1THJPyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBpH3vSpvLQYXu7luEmc9KeWjozPIR6LqsHUQFt65V9R3k3yjD67979w2l7FuAy/K7e/S1Atiae5fzxLfTbI8vNuanRT1uB/O8SuGdoh7FanMRdIqFEat11wqJewzCe1RgQaiNiWkzn3OhHlxIZfEMLnBSc9hs2bXJJ+DHHfNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIwwqojN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso2618154a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730699084; x=1731303884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8JEGZNGEHHKnWUjnAm6483hn7psRurtTNGsAmTYM24=;
        b=TIwwqojNM8ofRYwMqKngT61Iyl/NM+89lFByJylXkI5OMstVJJgf79qePrT0ZNwAt2
         X8AeG/PUqChh5QcTvH9RUbnzm7frlY75n9Ph5KsxjvTrw9dvOzbI12peUFX/5fkkbwBh
         1TjW4sNaBa74spdzzOXw9noGubjeiU1QPA0sQ8niG+3rngex8q2ybzE3MTNmhb6SwH2Z
         9PcfFsP6sznrXzF1TBsMv122uozO5LgvviLi0tSpFtYx+l9NzGSRV39TGTRW5jk7x+X2
         TCBPhtOm2XJc3Dz7uSS7ea5Q12BZ+Q0KjaVZz3keRMKFN71MyHcFrQyhOFJIhLet9Ydw
         teJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730699084; x=1731303884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8JEGZNGEHHKnWUjnAm6483hn7psRurtTNGsAmTYM24=;
        b=MOKkanhZ2zoXAUxxbu4TGyunUYReWWgqos9+SkBl4b84uyMKIjomM3LFIO2/0HO8bJ
         BaV5eGh3pciKN3drpqOWWxz1D7E1RlCPHJztSOY+75enzwevSaFe1CMAS2lI2iUoNXt1
         ZNHwBh87K9iFvDcw0k0PNR+jkUnEse3RXAF1mj2SwPp+9FsJeFT7OrBOM77ZFE1u0D+y
         9aYjt2VZ93kxrKUxGsPRWPW9vpN0appXtK1JRCa14HOxaNH2l6HDo+6FDbFgr0Pwa6r+
         6KsCUdOPj7py/DrohW2bfmN1kWQTkN/0GNSpo3ytEV4LrfT6TVzYOZiOiCQNCOq5phc6
         tsQw==
X-Forwarded-Encrypted: i=1; AJvYcCVNB87zZbab1+j6wVfB+/yR4r3V/NHRkk4uyDu2Pcj3z06XrFQfOiwBEdh0qF8ZijfFIK3dAn6y3DUtQwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNdvIq0qGZSsogYs/ry4/hqPeayG3BBHHA6RWmo0S3tARXt3h
	5IDSAZBZus8h7P9F23UQBCtGFGo+ujWnxD8lAduY9ciq1kCk69qE
X-Google-Smtp-Source: AGHT+IGtQdWkAPmNGq6pIivYbN8gqfKg0JQNyfzn9BHSgmNlUjDLjurKpkDels2h5nhhr4fmzCLAZA==
X-Received: by 2002:a17:90b:380f:b0:2e2:8bce:3d02 with SMTP id 98e67ed59e1d1-2e94c50d452mr16313819a91.30.1730699084272;
        Sun, 03 Nov 2024 21:44:44 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e93db430acsm6576634a91.55.2024.11.03.21.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 21:44:43 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: "GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Cc: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Subject: [PATCH] fix: divide error in qnx6_mmi_fill_super
Date: Sun,  3 Nov 2024 21:44:34 -0800
Message-Id: <20241104054435.291037-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for sb_blocksize before dividing.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
---
 fs/qnx6/super_mmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index d282c2c73..57f34320b 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -65,8 +65,13 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	}
 
 	/* calculate second superblock blocknumber */
+	__u32 sb1_blocksize = fs32_to_cpu(sbi, sb1->sb_blocksize);
+
+	if (!sb1_blocksize) {
+		pr_err("superblock #1 blocksize 0\n");
+		goto out;
+	}
 	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
-					fs32_to_cpu(sbi, sb1->sb_blocksize);
+								sb1_blocksize;
 
 	/* set new blocksize */
 	if (!sb_set_blocksize(s, fs32_to_cpu(sbi, sb1->sb_blocksize))) {
-- 
2.39.2


