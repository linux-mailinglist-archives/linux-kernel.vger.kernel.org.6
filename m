Return-Path: <linux-kernel+bounces-331006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D697A72E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A51F259FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4E15B10C;
	Mon, 16 Sep 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcuQ3heK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312231547F2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510559; cv=none; b=K8uOgTEWQyvMOj13eq4/w8R9qd8T4ZqmYhV0l/ahGFdv6IBWA04cSZRcWl3L/yU6m192ByIc6D3urTlezgzoyN9Qi03DVBDT5xlDdHGy1G+IBtspOFV+hoVXNAqolnAgc+O5uMqkRinDozifuu+LqCa9ygHAtX/JqAzj+ywucG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510559; c=relaxed/simple;
	bh=4Qhsku91lFKJ8KjbB5aFPJSDK9oNgKbdpsT1c9CLkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTrtQtpmY14j+MEgpXV8SueW+NhrWuMdv/fzTCi5ZyKXVFkva5PIVgSXCpglwAvAR+b2MA007U98Ua09+LW1Ok2mYsHJaGAUEtmRHHln8ihZEtg7nK9t7YA6/wcPJRffclrfmTroTGQKA7Gd32ikebGDUzoaycMLEPdH9Tg26Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcuQ3heK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e2855479so3481130b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726510557; x=1727115357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tfqQDexu4Vmpn8wv3LnZmio6F6PpZY2ba5RnBulZUU=;
        b=WcuQ3heKQ6EQJLalSwuNBmaHB8MPZ624FVHts1XgaFOIz0vul3p5+cGyf3sF3ulCyB
         t34Q0D9DsNzlzDYjVh+8QGmOs/mOxGVybyX+K4rk4hoKFlcgswKpfJVlFeRsIulYM2NO
         j8wG3myIXCQqK0uNVBwnQieFOb8RI9YYgQQ2KiCz98khj1V8+Ockypsef8bc3SXOieUz
         bZqn/lNYcZ5S+NlfvdCTooZqiIp4+FPxhvX6g7g+XsxQJDWuyqgDQ6EouaZqLjQIu3ug
         jHqctRSVF+MeSHuyRaO5RJ28XeO7utSSp1pTGqUmDaSe17d2XHoekYMR6s+5wafIKc5/
         0cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726510557; x=1727115357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tfqQDexu4Vmpn8wv3LnZmio6F6PpZY2ba5RnBulZUU=;
        b=ePz/2+Z4pYrORbT5sV5Gsu0FAMzgqpF0KtsOxYPz1XUOk1iu6LOVmK7fmzMJ6pV5XL
         j4CNCjHYuVInSI37nwon1pNlXhNTb+v5odcqLVa3F+6xLlGVbmck9z4+b2U14daez+Uu
         Bo9R+XG5Hh3lcj6BkiuyzthaKRag7/EQb/2X7F/3fdBIdN22swkEpUM7ICu1mr1Rpv4B
         0u7+3K5A+c9uh4of3n2YbmL5UBxvrghlzrx8/IOSw//akOOKBusy5wd9t6Qavpc5qN70
         jFLR+PAZHdjssJKis1ML9qyIXxFISOXvnnT3eciorBm6CeUsEA6l5axc04p/rJ8nGBnA
         gb0w==
X-Forwarded-Encrypted: i=1; AJvYcCUUKeRBTuSgDv9SfytW7E8JVZPYcoAkQ0ZUAnlAYlQyMxJ2tzAfpzveaEtHP+5v508/wJlLuXfVlMSluUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybueppM2jPnybRMlSYZrUHAeQdzAa/wEaUYNIfRKa2Z28oPYEj
	bkpjHStzqYYMWFRHs/VYvGepjyJo5WiAkuDwbBEyCpAxkG7mVMAGbln3kMoZ
X-Google-Smtp-Source: AGHT+IH+J9oOULqskqZUCMfdC6hBDHP0/oiMJqDpk20h3oWKuvbeZz90Xb1HAyM+X6Kd3sQBdHSBgw==
X-Received: by 2002:a05:6a00:1883:b0:706:58ef:613 with SMTP id d2e1a72fcca58-719262066efmr23193056b3a.27.1726510557247;
        Mon, 16 Sep 2024 11:15:57 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9831esm4002548b3a.24.2024.09.16.11.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:15:56 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ntfs3: change to non-blocking allocation in ntfs_d_hash
Date: Mon, 16 Sep 2024 15:15:31 -0300
Message-ID: <20240916181544.6765-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_hash is done while under "rcu-walk" and should not sleep.
__get_name() allocates using GFP_KERNEL, having the possibility
to sleep when under memory pressure. Change the allocation to
GFP_NOWAIT.

Reported-by: syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f71f79bbfb4427b00e1
Fixes: d392e85fd1e8 ("fs/ntfs3: Fix the format of the "nocase" mount option")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/ntfs3/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f16d318c4372..0a70c3658546 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -395,7 +395,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	/*
 	 * Try slow way with current upcase table
 	 */
-	uni = __getname();
+	uni = kmem_cache_alloc(names_cachep, GFP_NOWAIT);
 	if (!uni)
 		return -ENOMEM;
 
@@ -417,7 +417,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	err = 0;
 
 out:
-	__putname(uni);
+	kmem_cache_free(names_cachep, uni);
 	return err;
 }
 
-- 
2.43.0


