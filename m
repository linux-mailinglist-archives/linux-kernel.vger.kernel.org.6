Return-Path: <linux-kernel+bounces-421498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C519D8C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A6B28504F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAB31B87EF;
	Mon, 25 Nov 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5L82hgK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9E1B85F6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558695; cv=none; b=FKhDdvmSP+/YToR9tkymigjDiSphTWiOO+RhUADuqIv+Hc/w3GHTLYaIIVoldmqcS/G2Dq4sPEYj4ehP0f1QSyOgBFYW65EinQaQArhQ28vNVXnWyhDZYPN146x+nL2H+B3/U8Z0BxIzfYmo84A3LOEcatoKn5jroNKFLnAREBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558695; c=relaxed/simple;
	bh=vHUrN6KaMC8V6+4NtMOWs1nW4Ry+ynEyHCgD9VvbB0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSvh86FHSvZUXuzaWFRBpKoz2HOb9/a2RajtMMJcIu7hmg1oTyrKgYLruOFQdq9fbSTUe+91Xu2QxR8Gv2UPDkNnvOO2hinnfdhY1YGFTUkGidN1dT11r4BbS9UWjFnTXcf/2n7+iJ8F9uRnqMPsjGeCXZFZt6Ed8uMPhSXl/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5L82hgK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so1818325b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732558693; x=1733163493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldJd5HmPlYA9vRJ3waB7JY0x/C5bJVvNHMbZnqNh4V8=;
        b=F5L82hgKZIwPPyynBGEBPrxbJo6hKiPUDzKmrzpWHj2R5o0x24oBjS9WZxQV6x8vEf
         vxEeRe4KvsscUm3Wz6Li1OdnmgSAnnx8a+AVj2cgj2Jq4yhzMDQSq5sXPBuMAdKoUUA+
         sBqOn4rZlO2U6+SZTDdcDWtpoTN+Qo7C8KeY/X5+H7lG3vpoq4uso6F/X/300KmZ+pFU
         2nTcXkD5OTWRfwUmqI8OIL/b3KeWHDXEYNiInyApSay+Wqbx87tCPQrmUDyDGUurkwzG
         XCGzHKecuLTx/oXG8RweG6ov7/0wQei3LK4/TqVFc4gSpQXym9BzK5z2JiopQrSPJgAH
         wmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558693; x=1733163493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldJd5HmPlYA9vRJ3waB7JY0x/C5bJVvNHMbZnqNh4V8=;
        b=EUI7aCMfqFUR2/Pz6wQNiFOPVihAYvzvbV03v5U5k7HwfDx8kFH3tF8AC0cfTeoO0k
         AOBVPrtstNJxCWQK7ctkcHV9qMa/NALCKr9eF6KjSK8ZSYyI/g6Ngkx4nPokV4vh1R7w
         5r1ed9xTGRQlWh/pKdxmkVUu6xbLPLqZXNiETexWzCzZ+2JqP+yH/jPVc08ggX4TOH0e
         YjsX08S8wzPj6fIH+EZT6EWoscXvvXGQUdseN3GpueKTvttjBXRYS/HTOKNjAjgTf4wu
         GR31C62K/7/YTa/hzC/b45aHuFHKWbgV6LUPVYB1Po9oEWDQL+K4WMCZP59Tic8i0uJW
         hKYA==
X-Forwarded-Encrypted: i=1; AJvYcCUwDX+8JEekPS50qIN6yN1ICsneZMRp1/0DmKMK8BGzcSc3cj5yfRE9+Cp6WgLP7YhzKeEQD8WY8whxF1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vZQxlvbQDOS8SVDt5bx5Gbe0q0moBEX7xnGvFlgddLyx7m7H
	ZHmgMR4H+SNlutcooMfdW3T9c2UWiKQbbpd3e2aWniwisXN84tYL
X-Gm-Gg: ASbGncvTGd0KETgOT9NUorVYvYqHcNmppiZeiSHsZNhbk4iYuj8EpAKZbsM+mSs5MgC
	OHVaPo/gfs5/zAXcYeHJErvKl9oYWH3XiEqLoSmsz22ZD0sjkhIk6FP4pLDp9I0YSKsxqXnqajH
	JPIV42PVNJQ0FML1z3QlWccry/Voj/YgKfU83gXRLXQG/y5I/VSDwM9Qi8dT0TQjEN6vQ7LDtWz
	31z16jzAIEfwz8c+Aj70CbQx0kCWKi318vX+Tf5DG0qvyPcTqjMKjog7K+OynwN
X-Google-Smtp-Source: AGHT+IHqEcIQqXHxqa0100tDdVvYAO+DYT1SBu7yLiqvuZikuC4XnVPIO7PeJRv5/19OhYr67h7wjg==
X-Received: by 2002:a05:6a00:17a1:b0:71e:7c25:8217 with SMTP id d2e1a72fcca58-724df6a4ac4mr17569909b3a.25.1732558693364;
        Mon, 25 Nov 2024 10:18:13 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:2d2:ed5d:17c9:e364])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454aa1sm6753629b3a.4.2024.11.25.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 10:18:13 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [f2fs?] WARNING in f2fs_delete_entry
Date: Mon, 25 Nov 2024 10:18:10 -0800
Message-ID: <20241125181810.190792-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6740a00c.050a0220.363a1b.0144.GAE@google.com>
References: <6740a00c.050a0220.363a1b.0144.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the same exact image as in:
https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83

This is the diff of the reproducers:

diff --git a/repro_f2fs_86.c b/repro_f2fs_arm.c
index e9473a9..b96d52f 100644
--- a/repro_f2fs_86.c
+++ b/repro_f2fs_arm.c
@@ -1,4 +1,4 @@
-// https://syzkaller.appspot.com/bug?id=ce049cbd95a443ac6ed3f6f4bad09498d3692995
+// https://syzkaller.appspot.com/bug?id=64df843cec772943672cee2084811aa72fd41ff8
 // autogenerated by syzkaller (https://github.com/google/syzkaller)
 
 #define _GNU_SOURCE
@@ -24,7 +24,13 @@
 #include <linux/loop.h>
 
 #ifndef __NR_memfd_create
-#define __NR_memfd_create 319
+#define __NR_memfd_create 279
+#endif
+#ifndef __NR_mmap
+#define __NR_mmap 222
+#endif
+#ifndef __NR_unlinkat
+#define __NR_unlinkat 35
 #endif
 
 static unsigned long long procid;

#syz dup: WARNING in f2fs_unlink


