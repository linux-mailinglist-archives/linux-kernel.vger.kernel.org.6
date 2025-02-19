Return-Path: <linux-kernel+bounces-520818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A5A3AF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6225716D6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB513D62B;
	Wed, 19 Feb 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="W382tvEb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3F3F9C5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932321; cv=none; b=CjwGDwbYsnLAWoSoYH/eK5eisDjCORbWwQk0Yx7mCPgZf1nvkRIvpUgDwSzNvcRgw6tWPyOdhwkKaC1dSHv0L0WDYJN7ohbghXCzgwHF8Fd+8Na/742LjJxmS63QcizB743yuzs9uX7zxhz9bCpXjIqKPWzOzLax/xC4gAccbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932321; c=relaxed/simple;
	bh=vtNCEh2s4yfr7oWGmkL/KiyGBmJ7liD0fOsxJY8sIXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMk/sQ++P/qUJ3fR6CtUHV8ze78aneGDB2PgDSkvAIw7G4X2xZqUDGkfbF7L8sX619ZLzxpqmifXM5Kl5xMcAlYgoFh6ojgTOojnLY4StKvGKiWz646oqsid3hyeHkzbPukKRPDoqbLg/VlheDGlKv041K+FdE9bJaT8ymgieVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=W382tvEb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bff984a0so111190505ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739932319; x=1740537119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMbzBLa4cAlmfPQi7VUGkd1l2tBGQkhyu/SotgYTeck=;
        b=W382tvEbRN+kFgLq8NPF97Q9wZH/DhbJm6C81BMEkhGAf67QgwiPM7dk3fUA2nz/Cr
         XxK/meMY2QZGWZqK1XCIRZ0tr3DAivOS23sLowD0gcjvFUvMEykkOPnxELgFIt+91Xki
         7zCujvnRI4EqGptR1FRM+svioz/lMmPxS78gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932319; x=1740537119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMbzBLa4cAlmfPQi7VUGkd1l2tBGQkhyu/SotgYTeck=;
        b=hDcA57aQr4KSGWDE42kw9pJR1VxRmCfeeePwFoj8XaT+kE1vt8tHWKSn3SmngIs37c
         B3nn1BapLdvq4spwm+UD5FOcPo1dtgq9MYkBuzn0KBIpYtmd2njpNTMltDynoKSC6L6C
         fahwnok3nidzrdq02lxZmITuUHsQoTfH/Gv4gRgz+1gpiOvIpqRI79Fw58m91NOYczOH
         hvDk5fhWRKpUpK8/w+qKY0kE/tBawE8OefNu9XUYxutX6o0tufzYwrrF7aGRAJdn9vAQ
         pzsQvKNm+8otpKXFjfW1kLUwwd6cPk4ASwfnxnCLZp2QVFoVTrBt3eG1mu2Ou2RvgkJQ
         y46Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeL9xtUHp+jpll0PxWa7tdlNBkpV2gG3Yf6fRj7cskshwQrK7DC/t6WFcPLgKrtylzqmXg3YyjQDRZ12c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgQtEnKHO7Z3glGfNvG288tR8VxVfNUso/tm0BUULp6JWJhje
	ZO+s+bgMkMCGJgEJhJmG1jE8lldLXsblH/Tr8yFizboCmulgINSbe95l1wz+Rg+85D/2R+i9CBE
	W
X-Gm-Gg: ASbGncvcfndQRkSEBiG3BSgmogYEkxbvh/0IfT5VeY4wCu7z/yNG16HzWAgpRtNLQ0Q
	sEZEE/G1JqPtYURZVFu8K04MKc99G4MdOjm6guAW6gsN5OhBPkNVYWFChfrjM+iPSSwi5bRpBe/
	wlPYua7qo2qygymPWOV/dxnjd19Ji6ore25znF55CYquiHxfun44Q+onVC0HHXkRJ2Z21oVpLYQ
	0LCt607YLy65O34aZ9o8pI4KJWNwujD10x9Aa7tFHv0horUtGdAxxPoQNVnLW02LISeFHwbKQJz
	zAcK9ZmTwP54aIFuKffbVyU7fjUh0ZhQxr2hyQ==
X-Google-Smtp-Source: AGHT+IHW+XXFajOXMQh82qC+hUX4SWHOEwAm/IPVuoAhxDKSgoy8z/LA4zU9drz2cmOSG/TO1iilkA==
X-Received: by 2002:a05:6a21:688:b0:1ee:d8c8:4b8d with SMTP id adf61e73a8af0-1eed8c84dd2mr944002637.7.1739932319592;
        Tue, 18 Feb 2025 18:31:59 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546158sm11248290b3a.16.2025.02.18.18.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:31:59 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [v2] fix "NULL pointer dereference in gfs2_recover_func"
Date: Wed, 19 Feb 2025 02:30:44 +0000
Message-Id: <20250219023045.45240-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218093003.41966-1-chunjie.zhu@cloud.com>
References: <20250218093003.41966-1-chunjie.zhu@cloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

before checking WITHDRAW flag, we have to check inode pointer

v2:
  fix gfs2_sbd NULL pointer deference

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/gfs2/recovery.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 44806513fc06..8434dd385ac5 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -400,7 +400,7 @@ static void recover_local_statfs(struct gfs2_jdesc *jd,
 
 void gfs2_recover_func(struct work_struct *work)
 {
-	struct gfs2_jdesc *jd = NULL;
+	struct gfs2_jdesc *jd = container_of(work, struct gfs2_jdesc, jd_work);
 	struct gfs2_inode *ip = NULL;
 	struct gfs2_sbd *sdp = NULL;
 	struct gfs2_log_header_host head;
@@ -411,16 +411,20 @@ void gfs2_recover_func(struct work_struct *work)
 	int error = 0;
 	int jlocked = 0;
 
-	if (gfs2_withdrawn(sdp)) {
-		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
-		       jd->jd_jid);
+	if (unlikely(!jd->jd_inode)) {
+		fs_err(sdp, "jid=%u: Looks like withdraw is ongoing, skip recovery.\n",
+			   jd->jd_jid);
 		goto fail;
 	}
 
-	jd = container_of(work, struct gfs2_jdesc, jd_work);
 	ip = GFS2_I(jd->jd_inode);
 	sdp = GFS2_SB(jd->jd_inode);
 
+	if (gfs2_withdrawn(sdp)) {
+		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
+		       jd->jd_jid);
+		goto fail;
+	}
 	t_start = ktime_get();
 	if (sdp->sd_args.ar_spectator)
 		goto fail;
-- 
2.34.1


