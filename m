Return-Path: <linux-kernel+bounces-397411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F519BDBCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EDD284416
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6E18F2DF;
	Wed,  6 Nov 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1URcbfF"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66D18E025
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858866; cv=none; b=dJR5G6W03r9M/48llHXG4PaMkMG/31wHN8/yN6jkEiGmskN+aeFqww1171ehVOatakRaweEZBF0aLF66r2UB/aEWglQM+0pvo/8+LzefA8EO5439/9gY5KD9G3Tt4pv0SknE5jfW+VCF7rW2oYiwCUi6q7vUiJ86+QQEvV+ITYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858866; c=relaxed/simple;
	bh=m82MDHrS9PALjqUvuB+6kUUQMgAEA9aGmJ/0r7/wLaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RqIBRRR5JIdpQ4GWi0QRZrTLPbNULcy39A8m8sHT+Q3btIJIqGWBRjgDwhHtH9wplVqUUV7HXRPGrhduLnzEsR/mDZQyvp5YdiyV19E0HO6Aq/bzggQMYqXFdMGBpoVPpjVeSlo5bhxnJGY2uGcrI4Km37sp7/aQ9zztReX+fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1URcbfF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e6005781c0so3360073b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730858864; x=1731463664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4opClqkmd8U3SUNnMTG7gpwqhf3SMRoHCVmS47wBaQ=;
        b=h1URcbfFvPYck6VU6YjsGnSDFoosJkce0qctH8d8q2CPdafKrbPnaOfuQQG9qNFcnq
         2lRR1nj1YscpdVH0aF+z68wIFMWfakdyE0jaS/KOY1+xg+rhFO3PHrGiK3Hmcv0e044l
         12nE8JbIuPMUmfeUjEexYgzvo4Esn15R4I7ar61Nrak+cwfxSfjyTxNEtKILBR+ejEqT
         VAgelRLyYu5MyiSJrlNpZiVW+c9e4W0Bg9yq5PGs9W1qqTAbeVNh7g5ujgoj+ozPRAVT
         tJtMff+YzchaH/SDobcp2CyJDaejinLlEVOYudjdQ4RYW0oMbrDB/Ml1HPo3JAhj1rBR
         iWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730858864; x=1731463664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4opClqkmd8U3SUNnMTG7gpwqhf3SMRoHCVmS47wBaQ=;
        b=Zxv2pujW2In0d0ENw9lQoPYdmPrhSzHWuUys6AM04OUASEh2kNTNemsLH570VVT4Jp
         yr7TceZ5G6+AhmEGT6TVn5nKcrxvy+bIvHJC/uEHnfr07YsOB1SqP+ktazkMgAxqhs8c
         SHcZir18TGbAj70vdPaqRALLsyXVqDT1ylfV/a1c72QPrrrIlEcY78408oDvGhaJOLxx
         KTORCL1TADoJPmdFnLveQe8VNMgj2XbPq/VTKI8Mh13c7bgRouLtygGo8QDnhKcbjDx4
         F567vA8ggmaIBqso0NxR6o1cCIGn4fJmV9SM+bPcgP/bX49SlXogv66nJf5vPqAjd50d
         WyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLAgbpdjsr8DMPpTVWueaKNZciPKBNkYEgGeIKSiW3YLS5wexJ80WRm8p73xN0WvQaoZi3R2XbEM4KQAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9G+SDoY+lWS1KVD9eRFHKM1NxkfAFE0A1wcA64W4GMS7oL6c
	ahNAjFbdHdMFHPS7QORgI7T6b6O+S8N4PFvm1/xudaTFcjt0XIdG
X-Google-Smtp-Source: AGHT+IGhA8d1muOaq9OOqeYmpnOTC26hhX4FB9uRMI/RJcCBVUX4c0EAgInbmKZVyUQT6Gmyug9xWA==
X-Received: by 2002:a05:6808:150e:b0:3e7:6468:1fd5 with SMTP id 5614622812f47-3e76468380fmr12324531b6e.34.1730858863881;
        Tue, 05 Nov 2024 18:07:43 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee45a0de9csm9801286a12.78.2024.11.05.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:07:43 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org (open list:ORANGEFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH] orangefs_inode_getxattr(): replace deprecated strcpy with strscpy
Date: Tue,  5 Nov 2024 18:07:28 -0800
Message-Id: <20241106020728.491501-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strcpy() function does not do bounds checking. strscpy() is the
recommended replacement to the deprecated function. The return value of
strcpy is not used so there shouldn't be issues here.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 fs/orangefs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 74ef75586..d27ff38cf 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -150,7 +150,7 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 		goto out_unlock;
 
 	new_op->upcall.req.getxattr.refn = orangefs_inode->refn;
-	strcpy(new_op->upcall.req.getxattr.key, name);
+	strscpy(new_op->upcall.req.getxattr.key, name);
 
 	/*
 	 * NOTE: Although keys are meant to be NULL terminated textual
-- 
2.39.5


