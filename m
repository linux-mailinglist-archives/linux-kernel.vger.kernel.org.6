Return-Path: <linux-kernel+bounces-335099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0F97E104
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E0F281327
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093117C211;
	Sun, 22 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5WCkMt2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897B1420DD
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727002828; cv=none; b=htvUcOAioui47zNAvLtRW3DKUwmkVuV6VZ6ZIywcHXBxin8mAU/n6HemjdogEOglFWgIfjdlm/I2v6lPKomP1LCpOvqntKeIb60s0yvH/bjKDyEoltW7OVOPWlphLtO8jwa3CQA8WiZgdhor/TucVpAAuTWwa9SxSnYGBDnpNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727002828; c=relaxed/simple;
	bh=zFWWK7iXy+FO0pUvufpsTYOARFH2121JKMin6Jk3CzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gq9TF83ZckzfXoKp6fqBKEagZmzQmxShUvMfS8+TAhirgrTEjLRpdY8gDDHCAKGba+gePDLPlEZk4GivA5GczTrTQvSYm97wRnmJ3Q8Y8T2fmGAnIdvZsGrL5TsM9hWCbRA+o6z6ACjHCQwlGOZOn/+6TxsBqEeaA8HxFaBm+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5WCkMt2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7198de684a7so2642313b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727002826; x=1727607626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoPgHByHk8gdB8thDbB1F+WogZQcXSZNhRbe+cOH4n4=;
        b=X5WCkMt2MteYpwWaaXE13+Fc9E4qv/vNr9S3iQd7fbWQckIbN0+FV/E/N4RzfdGPXt
         9O3udCASEnXnnByc1G/VFem8Qoba0c9bLbKvxVdjt/SXg6whJEQMsLOGPFRMAfIoyeLy
         S8KJUB2JRh7venMT6mU5gIlG0+eMczS0+SnI35LRoD6GkFBS5E6qP1On06hYqxpepIti
         fG6lB4ZwB6oEKznMtNzjJ1EWYW7usWNqZ8UoXkR+VmusxvwsCcloGjsU17+bKO5RnAip
         eH2zuGs2SQzDwYOU9nY9j1aFUn75WQBE18po1GxBnPQfH4ZXbnU01krPIIlGIRFyuvDZ
         FLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727002826; x=1727607626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoPgHByHk8gdB8thDbB1F+WogZQcXSZNhRbe+cOH4n4=;
        b=SS4gcMaTmc8yGvrfdHuO83pJHdFQdt41hz7j5ByXN1wn5YsCJOoY4RYsH1UTecTE4t
         tgyd8R0qMGbprwkAOy/u2634dapWCnUlOhQqjWQszcWNsMXabvoCYtc1rZJoRhKzDNHJ
         qc11OOmjQ1weCpN8yzcsNmzNhQqPaxuiMylaNyI+QQM8Z/K+ELO1LFewFKDeHBQiQ7YG
         zGHZhivyiXiuVPmAHRQeVs7RF7maq0/jU1ZLixFHmu8HTiVcA3Z76x8FPcumnfQ4LoOT
         Ax7aMIVFHeojPdpxm225FYzyPcAfVQG3a8wnBglncGWDxDBwOBRq4X+KR1O6BaETjPqL
         TYpw==
X-Forwarded-Encrypted: i=1; AJvYcCVxLIvgkKPkjgPxpKOKQOiuW2ARzeJ0Kmz95s7E62PzUTeEyv0y5YsH+oVaaWz4pUk6AbXyxmdu0PkpccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElRyNo0APU9v+KKs4ExCSr0/dWdCYY4YzOEvs4RGeGbYge9TL
	PMkhPU7Fd/L4iPUM9YV43LKEMLoUZ2lLqAtwIBzeUvu1sNPxX4qy
X-Google-Smtp-Source: AGHT+IGossLNZkMQxzfHLzMnk8m3WoRtwKO4TXSuFpWFMgk40orALSczh3+WOkZ/jlnhXDAoQ7tDUQ==
X-Received: by 2002:a05:6a00:3d06:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-7199cd8e815mr11598352b3a.10.1727002824206;
        Sun, 22 Sep 2024 04:00:24 -0700 (PDT)
Received: from dell-xps.. ([2405:201:3036:a902:be73:aa56:3bd2:d713])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9cab5sm12342033b3a.5.2024.09.22.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:00:23 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: shaggy@kernel.org,
	ghandatmanas@gmail.com,
	jlayton@kernel.org,
	eadavis@qq.com,
	brauner@kernel.org,
	ghanshyam1898@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds
Date: Sun, 22 Sep 2024 16:30:00 +0530
Message-Id: <20240922110000.128650-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, dn_numag may be greater than MAXAG which may
result in an array-index-out-of-bounds in dbNextAG. Added
a check to return an error code before we crash.

Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/jfs/jfs_imap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..5088da13e8f1 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	if (agno < 0 || agno > dn_numag)
 		return -EIO;
 
+	if (unlikely(dn_numag > MAXAG))
+		return -EIO;
+
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
 		/*
 		 * There is an open file actively growing.  We want to
-- 
2.34.1


