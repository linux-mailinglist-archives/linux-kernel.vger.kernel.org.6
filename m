Return-Path: <linux-kernel+bounces-351364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E81991083
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8CB3162B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AE1DAC92;
	Fri,  4 Oct 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVZHy+Bo"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DE231C91
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071505; cv=none; b=PqkSS/3Z6DOLUbKXh0yDSYTZg5YGK980kTbRW6HkkHSePeRhAxboY4Ik/mxqg8tYhCWp1w9SOutq9gHXBYSFhdz83lp252cJx9UWehkgHwrKchr1G8D2zfuAGR46OuY/qwy0LQpsQzRt9gD7BCgOeiCPb6+KTqTCcTN23RUiyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071505; c=relaxed/simple;
	bh=bzVY4oLhiUvaPvPZJvjsoD+ueWk4FOH0nwbjN4VWr+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfBc0rnUgZdkAyY+lmOZfT9scVl5h+RfaeIxK9z8upYOCJT9ONN74RTzr1nm4RBCrR2j7XwCk8daWQHep2M9Hu9nRvY9LJfni/L2nxnVzGttTVnw5PWwdRLqVqoAORswgbtvhDqilulHzf1bgW1t33cvmT77JoxtinZkRkjOy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVZHy+Bo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d3cde1103so314848866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728071502; x=1728676302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OAvHUpolebuIOw9EXSJ+sr6FDBYi/qKxGtk4yJNJ9g=;
        b=OVZHy+BoZi+Mn+OGSH+coDbr9QIarTxkeerg+aWQnf+BwUQGAb3q0MTTaTHk3p81oM
         0Op5PUcVT5GQKI5BlpsznCve8UL0nfu9wVTtERE2t3H3TdMcgOpCmRCTpfNNeDI+GipC
         xWOL6dZ6+TVGno/scbtkBrt/pteC0xMXfW5CcHq0LW+Cm3/Yb8G5zN9WYqlJXQtbezNW
         Vb9zO8yLzwnu+0hNX+T/DIunBl3wDubzY9jz4dXjs0BQcNNN2L+gdcCsidEDWRU46Snj
         BtmABJlQl/R42JOgG3ggDnYREkIBt01eZi9oNaqJljbCtgeBJguY3RNp4mHUXHgcZgmK
         3HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071502; x=1728676302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OAvHUpolebuIOw9EXSJ+sr6FDBYi/qKxGtk4yJNJ9g=;
        b=rf37VVMZeWsqjgZQEi1kPy/PCbGPbD4nB3i0x/+zajuo6rPjLlHnGNGmkBLXSQY+oF
         WoFSOw9TSVRow9IdumE0z+d6KrtUJ9d8oGowH3a264e78BUDzKJHMQ8j32vzASikQ+3Q
         nX85N3upNE781Ovf+UdpMpEEnAN125EcOW0dcMlf8r+BZH0MjIIvnq0vMkmJDShSSjB/
         hG7q3vAFXhTZ5N2T8ELRVDkd/99ebNhusF8IULoRlglTvBoOrgEB8FqZ/WWPPIt4IJr/
         q9QLg94SHi/Obk7GThPO3hEmfyZujTAmKaf3BHRh4gRi1X+Jptj/HFvy0MfKAZoZX/ho
         hUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdUH/IVz0FpCdXq55tknyXi/oBRW3mx4gMrPuBFeoPFcZsO+elydfZjU/jaa7k6UMzLHbGQbvYPHfFc2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlF0dvZy8y0NYGD6q0eujl3T5QZjRliZuBHK80I+ZjSAkBHRdW
	VJ4Si8H49pDpk/PheJk2IGXGXKJUmIK8PbERnGMPLvmtKu0FEVBWkM0TVFU+
X-Google-Smtp-Source: AGHT+IFrOCZvT/ERMarX5FM1A2zaXE7D1ehwOzwz5iqgHT94MjbzAOOJaH0tTt1qlM53Bzl+Nn6kkw==
X-Received: by 2002:a17:906:7303:b0:a99:22e:9658 with SMTP id a640c23a62f3a-a991c031334mr405570566b.40.1728071502139;
        Fri, 04 Oct 2024 12:51:42 -0700 (PDT)
Received: from azathoth.prg2.suse.org ([45.250.247.85])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e78757asm33917966b.102.2024.10.04.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:51:41 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] fs/qnx6: Fix building with GCC 15
Date: Sat,  5 Oct 2024 01:21:32 +0530
Message-ID: <20241004195132.1393968-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004184440.GQ4017910@ZenIV>
References: <20241004184440.GQ4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qnx6_checkroot() had been using weirdly spelled initializer - it needed
to initialize 3-element arrays of char and it used NUL-padded
3-character string literals (i.e. 4-element initializers, with
completely pointless zeroes at the end).

That had been spotted by gcc-15[*]; prior to that gcc quietly dropped
the 4th element of initializers.

However, none of that had been needed in the first place - all this
array is used for is checking that the first directory entry in root
directory is "." and the second - "..".  The check had been expressed as
a loop, using that match_root[] array.  Since there is no chance that we
ever want to extend that list of entries, the entire thing is much too
fancy for its own good; what we need is just a couple of explicit
memcmp() and that's it.

[*]: fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                         ^~~~~~~
fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                                  ^~~~~~

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
---
 fs/qnx6/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 85925ec0051a..3310d1ad4d0e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -179,8 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static const char *qnx6_checkroot(struct super_block *s)
 {
-	static char match_root[2][3] = {".\0\0", "..\0"};
-	int i, error = 0;
+	int error = 0;
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);
 	struct address_space *mapping = root->i_mapping;
@@ -189,11 +188,9 @@ static const char *qnx6_checkroot(struct super_block *s)
 	if (IS_ERR(folio))
 		return "error reading root directory";
 	dir_entry = kmap_local_folio(folio, 0);
-	for (i = 0; i < 2; i++) {
-		/* maximum 3 bytes - due to match_root limitation */
-		if (strncmp(dir_entry[i].de_fname, match_root[i], 3))
-			error = 1;
-	}
+	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
+	    memcmp(dir_entry[1].de_fname, "..", 3))
+		error = 1;
 	folio_release_kmap(folio, dir_entry);
 	if (error)
 		return "error reading root directory.";
-- 
2.46.2


