Return-Path: <linux-kernel+bounces-545437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD523A4ED5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A993BCC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AD259C9C;
	Tue,  4 Mar 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9GYfE+g"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96196204874
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116050; cv=none; b=DboNDFNbu0hcL8T4ToTc7CSStWpAPS9gH8+f9BhS4wPyUqCdiyQQKbrtleLHtpkyfQJG8ZYqpZ6JJuBxltqTlx4PlHvKCZOZWvHySuuj7174KdpqMGwRNJmjaNMxBk/QjNgUcsbnNh3c1IqUDK6a6da4s0lbcmuL5G47fjHTv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116050; c=relaxed/simple;
	bh=sCroFOj5gIG939wW1MBEN05QRv/2HsiEtX+DCRCeyRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWD/QtGRPK1vbCpyLedswcEgckkdi8FGOqdBQbkOaEex0VZ4mo2koYOHWzkd4wJS/Ed+Lf3MTQNslH77+rR9H1LWHSbd7mxLT5blcy2CmJNzZTkRjx38c6e+g2lNYnV5DOP3lh7p5B5XLlqyzfV3WnBR5lMaP0NwK2v4YBWBH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9GYfE+g; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223785beedfso75390665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116047; x=1741720847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/dXSi6xRgwsWQ1SiZXMUsL2CPHZOkxLFICb2229Usk=;
        b=X9GYfE+gdvJkXefzdWRysmejWu8JQvnR+12zCFkBfW3iJwhtRASNTixXjId6RwW1Es
         toEFIwUq62iu8NEAESeXAGAUR2ui27sYoON5Z0tP6oA82dC9uEmMsK0KQv0hJtAqtMA7
         7uiYYH32nALbB82MI6E+XtDOwzPmq67HpeEUhk5S03c8dTtrrK/CeEM/zCCtzSN3YdfL
         R4MTdfXBFbC3QT0Uv9BLP++lUhSv+xOmbL5OtiR+Pnu5KGlj12KCC5SrmkzEwVeJAFI9
         zNwE7Q9GGPC//hfWBSzKiZW0UI6nqe+Fb7XZPSU33OcsMHC1MG2creXJkWDHnakQxOZz
         hyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116047; x=1741720847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/dXSi6xRgwsWQ1SiZXMUsL2CPHZOkxLFICb2229Usk=;
        b=Z5L3uHk3/Rv/3YRF/Ip2On9DyLfvCZRzmG+AsofafHxTGTIwnFZi1gtZdffkAHw0vH
         Rbk923aUetpdlovfVWzbjYgmrDY4cfy4N9WJ9R2l5OgDixOV7jhLRcKlWW4Owk181aGS
         dtclfy/nAXWR9xEfvJG2aqhlLDI7+z9mxkHAJ7oRFYkwACof2k8esdhBr5f8YGIOEYIR
         yRbzHL+XmkuzdJ1eJncIavhwXRix5veTG0QTQqu6ia5ZJw1pUqVrJR50arnzNrAvHUIl
         kJhiyWIjhbRO4jioZul1/RuvGgTlnCGPBDxy7JmVR+NQfOMJdunrOQLJc+GpCO7vj5d9
         uOMw==
X-Gm-Message-State: AOJu0Yx5JVxC4HKuNZpQ/5Ho0fvDDnsKmJB2pASxIzMezNF/fxDBWLw3
	oCV2ufIFxIoISNeDLVF7ShSATeZF9enagBBaRUTkQURNp6jOjYa2/gCPVg==
X-Gm-Gg: ASbGncsdYL9sCAMF1eCqKEkdusjIcQp+9LvMoHFWZlgRjzcjjGX6ro3yGOoDSIFcLie
	f5+HG7CAn4a5OmywB4OK5haDWoOd20bvz/9lnot3z6hjPPP0RQNsFD8usCJxcNGwHqk9hmvMQYc
	R71eLJ5bb2xHQpD0oG6zsmh7FdzErhP1QYpYVsqon/mG7hVy1iZddNp7B6eEB+6/K96EZ/Lkwlk
	4a6FAOKVHvOzgIcRAFon4BCefZzmex61/BkUQrNrPRV3PFWYPq7YyVrhzm+pja2HNOGOQT/7zKj
	KreSut+DqYezCEuSIjs46MH/ED4ILpxePhn9v/mobpgaUQx542UbeeNuEwKfHBhSTRiyc6jwt09
	ofqEGz4YcIwHpgei2Qh6WBxwrcseQ0mbMSyri
X-Google-Smtp-Source: AGHT+IE/izDo+2T2PoP2W0Zud9dEe4n8vIruh1o+XbAemCyGlSIAuwSw6HV5IvFQ+4u8lDGh5rcUkQ==
X-Received: by 2002:a17:902:dacf:b0:21f:93f8:ce16 with SMTP id d9443c01a7336-223f1ca9026mr4913365ad.31.1741116047417;
        Tue, 04 Mar 2025 11:20:47 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ae36:4619:1aa2:117b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363d97dcd0sm6602610b3a.54.2025.03.04.11.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:20:47 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: subtract current_reserved_blocks from total
Date: Tue,  4 Mar 2025 11:20:41 -0800
Message-ID: <20250304192041.4048741-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

current_reserved_blocks is not allowed to utilize. For some zoned
storage devices, vendors will provide extra space which was used for
device level GC than specs and we will use this space for filesystem
level GC. This extra space should not be shown to users, otherwise,
users will see not standardized size number like 530GB, not 512GB.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19b67828ae32..c346dcc2518a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1833,10 +1833,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_type = F2FS_SUPER_MAGIC;
 	buf->f_bsize = sbi->blocksize;
 
-	buf->f_blocks = total_count - start_count;
-
 	spin_lock(&sbi->stat_lock);
 
+	buf->f_blocks = total_count - start_count - sbi->current_reserved_blocks;
 	user_block_count = sbi->user_block_count;
 	total_valid_node_count = valid_node_count(sbi);
 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
-- 
2.48.1.711.g2feabab25a-goog


