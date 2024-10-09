Return-Path: <linux-kernel+bounces-357796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8160997630
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FD2B20BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301331E1A1A;
	Wed,  9 Oct 2024 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="EYTWaAxy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57011E1023
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504407; cv=none; b=IOoSs4MGzQM2j1kczsdMTOtF+w+sbUkd2BbieqoTLYq0BYd3cG4KA2jVqvaBDH++UT5MaXFBM9694EGF4O0rEHAZ9Rqgktk7PPWh7eogu2vUMxVENuto8H7Q8Fr8jT2se0owKXK7duhKfpIVy/geTLzTz6vJtNymoiMrzKHKJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504407; c=relaxed/simple;
	bh=XFi+RqFT5+j80M42gY/7c4z0iCnHBg0JREA8YPoKvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFNaBOOqeHg9tSRQOeZYOTc29bu1IL9hKyAVIzZsVIiqJaXmg9UKbs2+c9HTb/LPUc27RILRAZHSZffohblnlmV/+vPZ/dVtb6XXSiAHbVj69QNBdrSlIAEjw6Ed4nWAzp3fiz7me3ieXUWqsu3jQ2vSU15upXzyqAvX9ZuumjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=EYTWaAxy reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c6f492d2dso1466095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728504404; x=1729109204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DjaCaDp/okFCfeMJXA4A2P6cPB6rstyymwpNX601YQ=;
        b=EYTWaAxywweOjp68+2I3kKlc5k/cuqvjfy47mM67UoFFSX0EZwpzJaWL8wrgKGUOL0
         uicGDCSfUreH3vs/K2shfDjcmmyiilOc48uELby5BBb9Eomv90tJk2h/Q4CyJeI3B7Un
         Oxx6pvQAKL8SkevRx7HwvKtvJs/i9WmBW4V7QJkkTJmX/WUELXX+K4dFMTr12AqpBaC/
         Ym9bcE/FCCVclTdjIVBcr1rtbMpAki0LxG4s17KRs1jmag6Jr2fAC8/iATxJ5hoFRdHl
         tJBZEqzqSgVgKUsoLYzytyqIUPFGVEa3d60tfrhsm5e0qukGWmZ1gqdC+gl1yPCpsE5l
         7W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728504404; x=1729109204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DjaCaDp/okFCfeMJXA4A2P6cPB6rstyymwpNX601YQ=;
        b=cR56VNNtGNwLYe9XXUlU4oHybaA4KRM3IROVMTtNr70AJxtDlipVoztG9nc4FQYAdZ
         +dzt8xBo6WP3eqpeYHBHfC3/7yg1Po9zqMENh5tkDcXCZIX+tCNDZKt/f8FOgAbEdS7K
         vnJbJuLJ6tfHVsaLf+mw5vOqNMF0ETLk6hbd+Ry9GWEKRngPaILopXQUyzudy3IWhsVq
         sUj2Z4B+3PDjakE3zokXzsa4A55XCjI0GltKuZC8IBCDbYtoWfiHVOMgqaMFgb1lGmoP
         rI7KrgkLrz8MWHWSs06LdAegkw6Bxu43Jjn76eTvYasuelDww6j3v43pqssCOjUmtVqY
         w0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWauuuaBYwbOtLbfGuRUhQgRwwJAUijXR9aJWC9ZXtqWJGZEB3BS27nsiTSbZkB4/tZ0unjLdTf0c+fCWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk34h+ZRSn/7rApRC4VW6h9LRkQjbs5imon1hqqjXTLP8DQlPk
	ORbKbX9gvBdPbLB45XeVD0Ta4TFEpqmSZt47/ps138etZqg7qlACBTbPhggUCmo=
X-Google-Smtp-Source: AGHT+IGw72IuCgKZTon0L4NG/cp8LBY5FD+t/9q3IAT29KYNY7TgAB5WSdK+rvKnlxikbob5YYdwdQ==
X-Received: by 2002:a17:902:f650:b0:20b:7a31:4522 with SMTP id d9443c01a7336-20c637f781dmr54819615ad.42.1728504404159;
        Wed, 09 Oct 2024 13:06:44 -0700 (PDT)
Received: from localhost.localdomain ([81.17.122.158])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c7e8a05aesm3504825ad.54.2024.10.09.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:06:43 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: Fix uninitialized scalar variable now
Date: Wed,  9 Oct 2024 14:05:25 -0600
Message-ID: <20241009200528.36343-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable `now` is declared without initialization. The variable
could be accessed inside the if-else statements following the
variable declaration, before it has been initialized.

This patch initializes the variable to
`inode_set_ctime_current(inode)` by default.

This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 fs/attr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index c614b954bda5..77523af2e62d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
 static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
-	struct timespec64 now;
+	struct timespec64 now = inode_set_ctime_current(inode);
 
 	if (ia_valid & ATTR_CTIME) {
 		/*
@@ -293,8 +293,6 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 		 */
 		if (ia_valid & ATTR_DELEG)
 			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
-		else
-			now = inode_set_ctime_current(inode);
 	} else {
 		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
 		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
-- 
2.43.0


