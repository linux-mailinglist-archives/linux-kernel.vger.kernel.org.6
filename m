Return-Path: <linux-kernel+bounces-440665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A39EC29B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C05282C08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355741FCCFF;
	Wed, 11 Dec 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b3FW6Uo+"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310031422A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885837; cv=none; b=taw8HQRu3KYMlS/twCxP6xFole3NkxHmh5N+Xii5moJ56DA7YUj21O+uOX55H3KeSEyjAUeOo89m5vmwgN7XYHQ0J3P64p1oP+WKdO+rWglzeifLHDoef+L0a6lEs+PAPfx5INVqGZ6/K/GMk/frSzeDoG1dGQnWlFejRrOGfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885837; c=relaxed/simple;
	bh=g+w2dbuNGXHYSKY1K3AJerDV7mUkhMd7dCT4wwB/eYk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oRikg4IVRsZUYNIo5ynaM6md6dz4vt0O7IqTjDxhYx/HR0Mxow8yzwXwKOYS4/vldaDgEu0k3WX8VxW/PllApDBZ2u+KrdT9pZubI8rLvyTuxMXyx/VX00WNn7yJp1TnJhwtABjRu38vwRxsn57yqPgQU+fGDxelvtL+4BEHQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b3FW6Uo+; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733885828; bh=N1Y0Ewuqgf9QZTIQBfmdJXWoO/SIWBVGgwDuKwe+MZ8=;
	h=From:To:Cc:Subject:Date;
	b=b3FW6Uo+UlMg0oe953bJuojB3pC7Qo4RCW+ekN89eEFdAgfBw9bcjNj/+9XqDqfSs
	 VcjwdhPqD8EQGkl9bIYEwZ46cNv/PRW6cUbPPc5n04xkB0S+zF6OghgYd1Gt1KkOqr
	 MvDWP6vq+uo6P9stu4uLNCLJun5JF/STH6u0a/o0=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszgpua5-0.qq.com (NewEsmtp) with SMTP
	id DB40C0FE; Wed, 11 Dec 2024 10:54:52 +0800
X-QQ-mid: xmsmtpt1733885692tpipzqu0p
Message-ID: <tencent_FEC6C2E299EBF3F95E516ADED98362A4F805@qq.com>
X-QQ-XMAILINFO: MaFEdJWNc83lhEh5TQ2KMz1yyRXFPVfkEE8kvYKybM5H0OUQEC4CLhSaKqvwNI
	 VYIfXkNARoCu5jJgA+ProgXh/XTFiaz1zezKnVZNierSkORNtf5286BAFrZMK5JiS1IEg51CXxzB
	 xnMmkyQfEYijvorDGQ6Sx+CK9RJyqmwYVVhXhCQzJTLJRGfaM6iEF0HWRQztyoAsDXZrA7TDDazM
	 yH8fMnFslhJ/ciqzFqPsNhLh46gS7UcKuSmk6WyU1n1jM++U8eFgq3yxyPGzvT1MRZD5m6YyiQao
	 GVrxToxK4J8LhlimsT5jmguMYmUwo2I1sSSwLwtufjLiMPAvcWXM11Iam3ofrryruBkO9z7XJQBt
	 r/ohndy+PVQXha5o4FK8u/ZaOWBJPcOeHJlkDLnrD7jOtrrAsQt+/AU52RydjJGzaL/rhC55/EPn
	 t/h4zOPTOAAlScT2QUohHagy5PYKUilVCr+z8F1opxvTC07R8FnqxwMdkn9fvBhEIwFx88cWj1T0
	 9NAsHQqbW6IR2ww5PcjEF0gK0MNw+z7DE/FezYhqhJIT8k8AYhEW2OuimMzOBwpJWxxBWrEEZPzI
	 o9l9bbF7MXHjJcWvfp3V5lDHxmtO8hw4vRnB0u1aikbepdsy1tPzqM4YXNX/45vAs7YccQKGhiN8
	 RhQ7bXYrloOoBpCLpKBlTNseU6z+SIjPt74H6FxDlO0Q3Jd+fXfhZqRJ8dZ16xruKqa+tQBTnete
	 6ZsASN8nr3TYup3cI9cjp7rgnYzJtvDbANjDiaELXxdI7drqT5D/+jlALKTepV10Sp7JTOKaC2v8
	 mG8BNk8d9id+iLTQx9RRFxmQR41U8ivvSaoY8Agdej5sxgADlrteLDzlhxFhs/ii7efFIR/PO/po
	 GobM5mkJXYVvn899Orv3aPu0kQ+lzDAz2vQjGxeBlHdHonVsTB3NuGu17tAbIkHyg48vva9oH9AT
	 MjXaw3p9wDA+oYL/2VpWExT8y160f34jA8ZOtIBF71cDERSbBZTT8xrkse5GM80V0xfHH4X7C3Yr
	 LdOW51rM6Ym66MPMBwgnsDKb64Azc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Junjie Fu <fujunjie1@qq.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	sj@kernel.org,
	Junjie Fu <fujunjie1@qq.com>
Subject: [PATCH] mempolicy.h: Remove unnecessary header file inclusions with no test failure
Date: Wed, 11 Dec 2024 10:52:30 +0800
X-OQ-MSGID: <20241211025230.514570-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to my previous patch not including pagemap.h in fs/aio.c, a test
failure occurred. In this patch, it has been fixed.

Previous patch address:
https://lore.kernel.org/all/tencent_08B979048FE091821B290B18AE97E70DC507@qq.com/

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 fs/aio.c                  | 1 +
 include/linux/mempolicy.h | 1 -
 mm/mempolicy.c            | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 50671640b588..9fad51dc823f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -39,6 +39,7 @@
 #include <linux/compat.h>
 #include <linux/migrate.h>
 #include <linux/ramfs.h>
+#include <linux/pagemap.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ce9885e0178a..d36877557b00 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -12,7 +12,6 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/nodemask.h>
-#include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
 
 struct mm_struct;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 88eef9776bb0..5297e0df4e3d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -99,6 +99,7 @@
 #include <linux/swap.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/pagemap.h>
 #include <linux/migrate.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
-- 
2.34.1


