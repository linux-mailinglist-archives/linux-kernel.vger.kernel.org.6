Return-Path: <linux-kernel+bounces-353348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75029992CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343AE283536
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F751D359A;
	Mon,  7 Oct 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="giuipzxN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8218BC14
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306484; cv=none; b=cNv5QmfBauuBbnr1RI1UV+gWL+uvSfLYzBZVpg4n8+XtBSoSj/jkNEFYHYOVweOnRjGZdF/fseuuXq5jX0lDnNa3BNqtZbSLYdDGn8wal75Nqa10/7xScoaOlKS0m5KES2scm3jH2oyVYhvFQ384oQyMIThNNOYWAQIMazDwc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306484; c=relaxed/simple;
	bh=KYZdCfC0G0TJf0tBV4UmKxSBuXIDsk+eUUerAygPEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xykz62He3FxsjlEMqJCG1w6EzcCK7pZvOICxPSi4t1TBmC5PGKrw7xcTXYvP1bkwAKml1/YdZgBg4m8SOuo6qLcyLzdH1IEzcfY4LQfwUxfMBiFVe1PiRPMixpEkg++8XM6tQBbH50Gjs6WE5YLFhNUf3VrNQXOBhWQA7wnZfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=giuipzxN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdae9e107so337315f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1728306480; x=1728911280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnzLtnFN9tco4+Q7+k8LRZ84/ndqz1jYrt7A2OLgTL8=;
        b=giuipzxNZ2QUJBrrDgDyuIRgXTX1m7/lHJASPXJvXG/NHGRSzrx0qnYAFoiomS0dop
         njqZ7mtWHbP6Bcyzc5Bje3kPnHaoa/4KYHhYhoLuPDsD7g2vAyY18lElg0Guiw6/f5zn
         F9nP8LfQIUrZUXBvdCRilFt+4JfnmNx6Zj19+EaKmK0XJ8SMojq1SfXl1PqZlWk6CJwp
         g7wo3xOu1ppb+P2kG6qjHr7USlREUetmG/DPlolv9dQkPeezq7VWD61Bfhuyq7dAx1WT
         h+fRPuTCELSSL2bXySB6DB+Z4RY64P9xGMH9DfzVGsEpI1y3Pwts8xaqBLmdU4q/lE6K
         7ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306480; x=1728911280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnzLtnFN9tco4+Q7+k8LRZ84/ndqz1jYrt7A2OLgTL8=;
        b=Qp5MvLLa/M14Kfj7oo1s5y4++ML4nvnPfDMWvypDmfzuQeG5ufq42+nGk5sIJfmbIo
         yrHQeKa2DrZs7DzT8IKG2x7S2919z/KwUU6k0+edKtuKHk5D++zvPETyYJ18RH7/Jpzp
         cqzXyjSkpLPNp9raP3qVmJ2lM7U9/lEVF7o6yuheMUDVZA/lKuGMkXnsZADYclIJYcNh
         yUafjW45wuZYA/lmtbdytkHeszF4OzppE6J50M1gcZMgxKlZ/8c5kUxVOc6uH3mnnMDq
         Nx50aMeopwhqyAEDcAXpipzEpuhb5dxmQmHVdXr4jqTrSJwIzU7t5dl2Psr/Qx5tUJV9
         sxkA==
X-Forwarded-Encrypted: i=1; AJvYcCU0niIWrFKPZZz0Uqw3lZxkTja3OEZ2JZB5B6bhhJ5ozZHGq9gYdHPUwdVsZoQQmcSLK/F1Kb5J4CDSgcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws78TqgFT+4ZhMNOy519HcPUgFU43zqi6xe5inszHdVQooyeyy
	O7FwMtBPjvI7QewDz0seXXwo5pauutTohuQQsym6L5Ac5+S+Nj8XADr3eZ7ndGI=
X-Google-Smtp-Source: AGHT+IFKomC1GoHgGz5NqJWTmdK3mKrk/2NM18HnZpDqf7JGIgfOX+Yoshy8dmLmPM10rEY56FpXrw==
X-Received: by 2002:a05:6000:186c:b0:374:c800:dc3d with SMTP id ffacd0b85a97d-37d0e6f362fmr3112919f8f.1.1728306480338;
        Mon, 07 Oct 2024 06:08:00 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-206.dynamic.mnet-online.de. [62.216.208.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695f113sm5679931f8f.80.2024.10.07.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:07:59 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] ext4: Annotate struct fname with __counted_by()
Date: Mon,  7 Oct 2024 15:07:16 +0200
Message-ID: <20241007130716.3442-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Inline and use struct_size() to calculate the number of bytes to
allocate for new_fn and remove the local variable len.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef6a3c8f3a9a..02d47a64e8d1 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -418,7 +418,7 @@ struct fname {
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
-	char		name[];
+	char		name[] __counted_by(name_len);
 };
 
 /*
@@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 	struct rb_node **p, *parent = NULL;
 	struct fname *fname, *new_fn;
 	struct dir_private_info *info;
-	int len;
 
 	info = dir_file->private_data;
 	p = &info->root.rb_node;
 
 	/* Create and allocate the fname structure */
-	len = sizeof(struct fname) + ent_name->len + 1;
-	new_fn = kzalloc(len, GFP_KERNEL);
+	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
+			 GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
 	new_fn->hash = hash;
-- 
2.46.2


