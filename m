Return-Path: <linux-kernel+bounces-265654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E462393F40E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8707DB210E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB63145B16;
	Mon, 29 Jul 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Xh1I36du"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5A1422C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252639; cv=none; b=kmZ+VXas0a8EUe1/tgXkHBwxcb8VZJPAzTFPhaxdDoGmT8vKaaeAbjpS+8ea6WyeFS99QMILBk6kt/PDi3JLvBqU5VJVyvOwZ57xcuxdSTr2OKS5ICbEAvSH6HqYRgyJBVbig855Pyyc8x5vdkvBIApgyyhFKOiSW387InX5WS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252639; c=relaxed/simple;
	bh=pjObBwxxiFHux+NXjbaAhUXpRgJOrYS8GRm5NvagPLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFdJGeiN1/oNXbqhQzlkVtMC7z6lMq/1qVdNyRr4eNmZeXT9tRZeYgBIWqfX1uUsDksNP7q6M4jkNJeD5jpaRYNHgnOYq9lUGy6EOY2glwaOmBt7QA4Di7k0mlmF4yLQLP7bHrBjD9IWRbycRf5+e2TFQq6QNudEGrMJkb1emQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Xh1I36du; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281abc65daso8914505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722252636; x=1722857436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwXA3dD7SAZsbhApPfN7AfejG+oDqK2DgA1HjnsQ1MY=;
        b=Xh1I36du0EI1G22t6ZhEKZUd0vk+nFhyBiRlAVKtmPdcl6lQiI6ozLicL62xWu7qxw
         dVnggqWJUa59TNIQj3JjI/+phmK3mABLsUhwfFHPg2TeVa3foAeimVnDpKGC1hgWzLLo
         RbFdHSNI/zXPsJGRXe7RXbgnVC3NxRfTi+2oCrcPTs2YVUjWfPfBLJJMxjM3G422E82g
         zayELY4PZCpWCndFxiKiqPmAXs9Y25YqV2X+kq6+hCiRqv8k6ujesd+q5cZASovFtJjA
         NbretkzflV0+mg8+HzFXMLcuYFZodOwsU2RkCAiJF1w7n88jZaEhJ/6ROE9yiYoSNUOR
         rOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252636; x=1722857436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwXA3dD7SAZsbhApPfN7AfejG+oDqK2DgA1HjnsQ1MY=;
        b=BrHQYNeTd7fKf6TnHxr2yq0c5pz4TX52cEgvQqDzw7uZGxfZTx67mbfYtBmh8bWW+n
         7neMMDmYLwtRJA6u3eu5wYt521SmCvUD52FMYuLYiRmND6QYlfw6YBXantx7jHiK/pT9
         BIqM/DGrq/DVdS8jtbwUo0vMeAZditxE7s7yXjyzAr78jy/9AqHv/qICgjNXS/BvlaQ4
         nEvKe+HliXsDT4kBT8Aw64sAUWxWPNQx7IxGBMCzluY0BCIZymwvA3GwIQHUe9hj1q5n
         2wDg0xiuQC3ZT9xQCSX7BhxdvcQ6AjN9CesaiB9FCPCGLEHMPJM8732zpnHmWvrQdHTq
         NUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNceNXKEdPoT0l2OY65yciSRRrdejtzN/r9Rw5CF42xhd9bZBa/wEs9Lv67gpoCa50cEIK0aZBYKy84M+2DnVwOsdCUZkwgIKir+z
X-Gm-Message-State: AOJu0Yx4tTCPGw0Yqnpurowc5Q0YlqlheopE4Z63VCjgltAbG5vDot09
	FyyCV5lmNe7IdH60P2Nnqzu9T/vTqNZ0NjtTT2aizd1Pq2cUqQ2TcIgrOEzXC6xl/d5w9osY3Gg
	e
X-Google-Smtp-Source: AGHT+IGjHB30wevbTXYBKu03d2S8jAWUf0rPrsqnjpTSyTPyWNnUBy5LQUpZyVzyw3MY9OFVpUWL2Q==
X-Received: by 2002:a05:600c:4f50:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-42811dd19d8mr41565735e9.30.1722252636324;
        Mon, 29 Jul 2024 04:30:36 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm174041615e9.0.2024.07.29.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:30:35 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Mon, 29 Jul 2024 13:04:56 +0200
Message-ID: <20240729110454.346918-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ext4/xattr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2


