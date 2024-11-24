Return-Path: <linux-kernel+bounces-419316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB899D6C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB12816B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 01:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80ADBA2E;
	Sun, 24 Nov 2024 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chg+fh11"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E81FC8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732410320; cv=none; b=Vrpi+z3LXHVdkbAmQDWHgqWVJxYmpIhAtD4ckWmTuDet4754QIQTtH+c73wWTqvd1sMjkrzBzjFc3kFdjJuUBV60JaqZHTN3kVTx8DwteUZuDXhYZLAQXoZ35A2kTNTwGD6mVmPxy08MOgfAGGdo4m+EWYBtwG/fbdt2tySf8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732410320; c=relaxed/simple;
	bh=Gh7q6HjTKO876keVSIn2YiK+4YAPjUAegfnAlT9dGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBHNUES/EcE0/bFexRJFhJ8GZKTIm+VTBym8qFWu5HVUxhxUqGbapMr4jHjmavXr3EOFeIhIaWggcvVqtvd43avXbQR8+w6wVKbkD4NmBaNRgyLGCe8EjAV4HiS0zIKC7+GE61uyTw953JlaGscdxNN0plzF2B2tpgrJRqUhyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chg+fh11; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so2921018a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732410318; x=1733015118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAwEK8ckYP2jo6LfWW1LjFBbSTo2ZwCKFOg8+ckdSD0=;
        b=chg+fh11N5E5omUM63j2vDetzUG6RnRgS5iDF98s/gsqrwyzxSRhvVs8OcGAN4j5z0
         2qQLL2qAeYXqqpFOtfZQj0aqi3pI1Qx6pt61GeqqRvplqfbnUJHoMW8dtrJPH4QDrc6c
         2YirV5sbsdtSL2wmmGLRtFbWKakEuJDEHmOlGktp90UJwINdLJrfK4uUDX/InFhF3zdW
         aDHDB4bC1+K1C9yiY1CwR+5hLM8j+4FSK1X+dN++oJBurTNEHxREfYSQ7S25C+7MdaYl
         VAVYeYIfU2V1J9dSXeG2lw+A9r6rTyZW+j4/KTTcl8W7NYxWMRY3gS4mDgf7mBF0nQ4z
         6mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732410318; x=1733015118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAwEK8ckYP2jo6LfWW1LjFBbSTo2ZwCKFOg8+ckdSD0=;
        b=pEyi10yzBUcZazwuvL5IxDvGjHX8WmyAXBuBN2lxPFGgqfO/UawMxeB8DhfekiA8YL
         53OIDGGkmpuf3GewknBPQMjIZluN9EpcRztYBy+Yvi5Fwu5bkN73MwlYKDCRBwX0W83h
         aGOupjED0qspbs+BQ4coXeA+e7YzonS9ICJOkCKVW4amoa1gLTL+3/zvFhz1T7R9Vfun
         KWJRSLOOi6y3CvTIv4qlSaQrGf40pdDy8e/dktJ2pWF7f/oMPUVkRNZ+VnTIPotqbuVV
         DQkJiW/LE0SWy1AsKubDuOUhhjRyKwPZspSIZfi14JCKuX/fsbCKTR2W1Q6fzYgC8e7o
         jBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJV0Tebha243UDm6Aytq6f/IuIEQtW8cUkasJf9RUQJTtlr4tNbQ+nl1wBwrRT7zIpMVZ5E1+0CHAFaiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/E+C+LDIKTYkI91DtQl76bs5rFkIiGwP4l10K0zsUHfcUwGL6
	dI3BoO/KPe1pgOZ39vrZyZjmRMMIbCMM115wuyQHaSmejjxqKOaSG4AwtmMPXhQ=
X-Gm-Gg: ASbGnct3O9E8KXrBSZPTjkkQEEiXX8dRstmQnM/94O5X0qTWyktxdxu5nfgIm6hv/dy
	94pkVYeOjdC7CepaenSzc9ObNkbMrmNH4HIvfDs33Ti2m/85QNg+NIU/P0MCEnsKWx3N0QKspA9
	EdBnX6PEpniLllnkZdJWUCZSdvYjpLLAJdZTBhYKlit40kTENlR+5w98V9RSsIdhtxBBTGOCOAR
	KIor9Sdk1wTmTKfH97G97+mnDzvpaFni/GD8sSERzFOAkUqeRJ+g9yC1EHoZddT7w==
X-Google-Smtp-Source: AGHT+IF89OxBOuRBB9ZUdI9OCWFJ9uXfDxkS8V8O6OpzKlAmvgQ8cJW7GVdnY9cTbMAsgtRvxroHgw==
X-Received: by 2002:a17:90b:4a92:b0:2ea:4150:3f80 with SMTP id 98e67ed59e1d1-2eb0e330d8bmr10102168a91.18.1732410318077;
        Sat, 23 Nov 2024 17:05:18 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:86c6:5b62:b5b7:ec1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de479102sm3855532b3a.45.2024.11.23.17.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 17:05:17 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
	jaegeuk@kernel.org,
	chao@kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] f2fs: Add check for deleted inode
Date: Sat, 23 Nov 2024 17:04:56 -0800
Message-ID: <20241124010459.23283-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 6740a00c.050a0220.363a1b.0143.GAE@google.com
References: 6740a00c.050a0220.363a1b.0143.GAE@google.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

#syz test

Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ed86df343a5..65f1dc32f173 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.43.0


