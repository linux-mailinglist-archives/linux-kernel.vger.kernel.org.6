Return-Path: <linux-kernel+bounces-426763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF59DF785
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD928178A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 00:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF16AAD;
	Mon,  2 Dec 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7NPPAIr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78D4A03
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733100092; cv=none; b=VMWEbR74BcbZyIOpiWxDD2QwaPeNBWh57ZSWaKGo3dfKkNJT7XDBbUD65ipsQIy8+DxplTdpnnI1nWy0ENznu+kG9SAugxugJ6egYONQluh5lYGTtB9tNf4Fj1UrOnfbtXal6prdBdh08OlhRBEedSGuvd9ybx6vx1l5GEHip3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733100092; c=relaxed/simple;
	bh=ir7/tla0b+ZabwROvkW7Dxgoa1c/qQ0Ece7wmhooPAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnhRM1b0NMvViiMhTi9XIC90zNu34VXdbyBUIpiCWLzm2iDd/ujLM2a4oKopSI9XwiUqgV9ly1zK0c/+s9eZ6ahPlbBK9oHfPLB+fujQBJhYMkH56HZwlTp6bENyuqrg+2IVUTMBk9VCell9W0RO2ELvERY3+RKaKPGeFErvR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7NPPAIr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-211fb27cc6bso27219465ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733100090; x=1733704890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOrfUj30PkfpFffW4QyGj+KbVwTGG9LbuH2bLnyjq+U=;
        b=T7NPPAIrjySWzEEZzvybnWQY/zGezJaEQYmHU4VuPNKQ90wcsZajRhN2+L8PMNORAk
         QOsoiAPtgpWOdcFX1ZOZG+sJ/eiWgXKLP7GBKeYblM4lJxa2SZQr3u69Yb8w7XBqcOzh
         rpqubJG7BocURY69yAWYO9n+pBqyPVticdjb5mPluQ75auKOQ42oh3IOaY9iOmPbs6bz
         IvdZjG/Bj1sDW6SfMVqswKhL8idqjmQPQnuZm7jHtIcnqTrNrePnf/rN72mXrJzp0jCY
         D6no3TrDBVvTt+ApPXhl9BI42Ff3RFEJG6XGpn20hK8Kz1+qI9lxy0k+wm50+ipJ2CDQ
         VALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733100090; x=1733704890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOrfUj30PkfpFffW4QyGj+KbVwTGG9LbuH2bLnyjq+U=;
        b=oIkzhI8vKUkRpIcIvjTXAjP6+RAl/vBw06AWgyO/Waw4LKE4r9fTq3Z/MJlks+7syU
         YiNZFyFHw+NJxd74BEqpx+MkPy0IvMkFoKa20hVnL349/Fv4WJNy12MlpTX+2qlSoeiu
         vvnYU0SkIHvZ+ADreh/k9OCSS5h2f59SWiBcqx441dkKXuRg/ioXnMDO/PWEEIsm6W28
         P+J8jvgPzOSutmoePbPdzvBTbLdI5pHL3CLaloVwh2ghVvSqA4Q5dvQ+OYUNvJsvEhri
         MpJFi/0arjowdseByLkQ1Dsez4oYg85d4JdxuEdhMD/lmwPcF5jgaSjLqbJ+1MqLf8t5
         xE1g==
X-Forwarded-Encrypted: i=1; AJvYcCUL2lSVWk8JouVCUZGEYm2xZc0MKKdot+PmNnYWaYVQZVDTgFuhK3EKd6gOOx/6VfAD3M/ZsS9hlaafE68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexox3bgazd3AYMZcdfPuRI612rvGfOf2FdSte5APu+YtlhOk0
	bNnGII87IfnVY4b+altb0waqTbNXNfLfe8ysE3zhkw33lTP2WpRm
X-Gm-Gg: ASbGncvipP40Vu6IppoV+CHjZiLG8U/GEPvfyh1OgTapF2w1qLGh3wxdw+xUPuQMyV8
	5GD3NuRuHgih0QFikntr7Mi5oOeNoI3jwkW3hTe7fbz+YIXgzcuENY3tDO4naBL51Enggi/iMmd
	BVd5IY7zCPm3DgL+tlUtM1AB7Fqt3jtiSaPHHX+mMvNHJdO+wRsgeDAKZjhnyfA6KdWJy23tbn5
	828KiLxWJMwzOJBBelkkQy3r4fEqEvmn5PBIf3py8+evMK1/kXs10yFfARlwo5e/w==
X-Google-Smtp-Source: AGHT+IGMMCn+7DBumH12tP3g4kg2QXBoDhN2tKhD/uf6CchdckcRLSIZWYGuylJCq1FNcWX7Gruy5g==
X-Received: by 2002:a17:902:e841:b0:20b:6624:70b2 with SMTP id d9443c01a7336-2150109dca5mr259927325ad.19.1733100089982;
        Sun, 01 Dec 2024 16:41:29 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:43d8:5d67:da98:78f9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f47aasm64703295ad.20.2024.12.01.16.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 16:41:29 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com,
	jack@suse.com
Cc: Leo Stone <leocstone@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: Prevent rmdir of deleted directories
Date: Sun,  1 Dec 2024 16:41:02 -0800
Message-ID: <20241202004104.20604-2-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6747ce03.050a0220.253251.0066.GAE@google.com>
References: <6747ce03.050a0220.253251.0066.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reproducer mounts a UDF image with the undelete option
enabled. It then creates a directory, and eventually attempts to call
rmdir on it 65 times. Because the undelete option is set, the
directory still gets found in udf_fiiter_find_entry(), and the link
count of its parent directory is decremented until it triggers the
warning in drop_nlink().

Prevent directories with the FID_FILE_CHAR_DELETED flag set from being
deleted again.

#syz test

Reported-by: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5df2d3fa14f2d3e49305
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 fs/udf/namei.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 78a603129dd5..0a577b7459de 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -504,6 +504,12 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	if (ret)
 		goto out;
 
+	if (iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
+		udf_warn(inode->i_sb,
+			 "tried to rmdir a directory that was already deleted\n");
+		ret = -ENOENT;
+		goto end_rmdir;
+	}
 	ret = -EFSCORRUPTED;
 	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
-- 
2.43.0


