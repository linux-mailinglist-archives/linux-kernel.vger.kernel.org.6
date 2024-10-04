Return-Path: <linux-kernel+bounces-350123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D01990033
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0357E1C23A28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C114659B;
	Fri,  4 Oct 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfraqvrA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBC12EBE9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035379; cv=none; b=ZUflJOHk89TIxuo6ZNonBHnCpas58FJkQ+1epoaTEtZRp09PCWd5X+czK8go8qh1koFoOULQYR/W6uVgifyyPv7ScCIMOe4ITn+Qnql4UJWMcrvS7ObbkzCx4g/5xybVwCNCFJKlIQ6Nk99YbP1f8PIQkNe0aRLwbWtJ17LoyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035379; c=relaxed/simple;
	bh=QwrHhQEOoV6HwIhkdVUxUa+cK6xZUQ0Cwcm0Z1tT8yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDanQbdkoSEPYf9pf7/0IWMm5hjc4r92OhsJ6CrPIDk532XoBKGLmB3ZCGuDXyKHjdpofuuK1r/gl17CkMbTR9GsVs4Ip3wZ4v8gBkVX+L8FALRVHwEHO0vhD9V3Azm7cxOtu2d3JZkUa65+0HKMqlfe2iX5EADEthMd9FuJEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfraqvrA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso372767566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728035375; x=1728640175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5nno9AxmL4fjgx+Nmnu5E92l7a2IplrqZRTQzvBl+A=;
        b=AfraqvrAT2wy+5pnXho7VwPkF6hAuDaZ2+FNHuN5g6YvloaOkQVaGzz6PWxG4gBILn
         8dljOYAlxAD3Eb6yFUKdy+BNkIuNktA5YVEWLKa+mmlpS6akKylT64fTbi74aR8hu1F3
         SoPEpAnjl5wkT2Z+7W3cQ8FkqLzF84aLGPNlbwX9Dxf4MGM0DsUf5N4QpQQfTl+w2qtm
         V+oFZsx4c3jXt4z/lxuGER7e+XIK1u4e/WFIB7DiPxN50MDwu18VfuMffefPfjO0c4vt
         D5fInufs3LQHRzoPeiFi2jGW1Y6ehaDyJ8ipjBYmKI2mM1WVJawHarNrWtISfRAdfI1v
         F9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728035375; x=1728640175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5nno9AxmL4fjgx+Nmnu5E92l7a2IplrqZRTQzvBl+A=;
        b=wrt9TusbvVy2fbXK6vO2wkgmSOoBLD3ehAUb7SLq/AIML4R9ZVbynn0uOfNYDWrbYb
         961WZM9ikoDaNt4r26JkVZkAc71k0t0BubBlIXsifL1gHvIIx/UArqLsUg0+ojqcb6lY
         d8Wnk2FXHP3fuZamDxWWodv5wJO3f2SSi+wuVip3u1LlIvOvRLFqWr9rHTZO1r1YP5Wq
         pMD2TxECQ2HHB1fl4Pk4uPXos7TLLF35RUivYiYR2L5wzOjCgVJeg8IIU+4Lyjfyo1gS
         oDxMMO6pMg3Ee8kLYtN4OFslTmKEYZSAULbbl2KZ9HqGLrFhp82JueYWocJJuJG3FYZv
         xAXw==
X-Forwarded-Encrypted: i=1; AJvYcCWFyM3tgYS+3Wz9DIADn/E+LXhJaW2U7zBelmhpOj34MtWjkXG6FrR04c+/h4Z2c7/nb2LOehksSdNq3LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBd0TugTVPNBbnJFSsqPw9OYcIt3qferXlc5ZqAaJ/gqAjw2Y
	k0QN/OjawSd5doM5hJmkaE5j9uLEaOi5VTXXtObtB4GngrMhoGTwtVekU0Z5
X-Google-Smtp-Source: AGHT+IFAIkTnVxgaVsYwItgwlhdRz81oydUSOjUrE58NjeHPi/i2OCCkPp6Dc+RMaRzKLJcUw/JexQ==
X-Received: by 2002:a17:906:f59e:b0:a90:9879:582b with SMTP id a640c23a62f3a-a991cf3807dmr204625166b.14.1728035375265;
        Fri, 04 Oct 2024 02:49:35 -0700 (PDT)
Received: from azathoth.prg2.suse.org ([45.250.247.85])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99103b4c17sm201312966b.135.2024.10.04.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:49:35 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Date: Fri,  4 Oct 2024 15:19:21 +0530
Message-ID: <20241004094921.615688-1-brahmajit.xyz@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 15 enables -Werror=unterminated-string-initialization by default.
This results in the following build error

fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                         ^~~~~~~
fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                                  ^~~~~~

Dropping to match_root array and drictly comparing dir_entry entries via
memcmp provides a work aroud for the build error.

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


