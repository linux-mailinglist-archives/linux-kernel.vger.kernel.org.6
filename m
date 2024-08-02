Return-Path: <linux-kernel+bounces-271953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC178945561
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2909E1C22EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777A134AB;
	Fri,  2 Aug 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iezjY47u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AE28FA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558258; cv=none; b=YW8ipWyNI8QHynZJXPj0Xm1n4qgqF8Bo+IUJkK0eixj/332UBGYjJKXFV+ru8NRgtruseO3+dMQWsQDKawTt1VQTQK8kh5D5A0VvP+9I19SKXFsM72ms8I7BwBFt/NWaeV1PVN2OS5y4/TJpDOxl7G1bhX7PTgn67bA99TiTLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558258; c=relaxed/simple;
	bh=50HRMlFn7fU4sKteemyoduW/x0fxG0K3KmjPbkKmB7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io7EupRPMvxIeDWgcOYlYSaRPjHhDUoqBAYIX5LTlh2wlU44b1wLPLvigYHu5i+Txsw0ZnO2zu/qBJ8skKfGnMWKcqPussblXfUbwUNtQ8pZBmiDaaulU3xMN4m56wtyCz4Ig3Dy9EEQzAYN3yR9RlOIqOArEgBS5QAwtH4xwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iezjY47u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96184C32786;
	Fri,  2 Aug 2024 00:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558258;
	bh=50HRMlFn7fU4sKteemyoduW/x0fxG0K3KmjPbkKmB7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iezjY47usqnQT15N4fb1UNa0NaIDpcuZmNW3Skr6JxRh1Nw60zyNKOpkOz9HJiOkx
	 P0ls3mTBEX587tHRdkEaM6dHzQ4P1+jc1+rGU372z/jgc715BzNpkadkWzh3ms1bba
	 AuefX0g7fQZdzunkn+lG2gEYhOxSGXwZ6cK2qf8aP3zjqD7tjpdfqCEf+9ed9pqilz
	 wepB+TrM/QNSaV6sqLKLYo1CVoNIdYDrabsp+1ED8Rbstnej25pPgB0C1QDKv9U2cH
	 a4S4vLK7dhTOsZDB58IQ5TD9TIdYC+8ITd+Mld7wWxzj1Vkd5izUylP+AN2Z9EIw9k
	 eII4R3TZhta5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46AC4CE09F8; Thu,  1 Aug 2024 17:24:18 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: elver@google.com,
	andreyknvl@google.com,
	glider@google.com,
	dvyukov@google.com,
	cai@lca.pw,
	boqun.feng@gmail.com,
	Thorsten Blum <thorsten.blum@toblux.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/1] kcsan: Use min() to fix Coccinelle warning
Date: Thu,  1 Aug 2024 17:24:16 -0700
Message-Id: <20240802002416.4133822-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b5ce4d12-e970-4d84-8f89-fd314e42ed30@paulmck-laptop>
References: <b5ce4d12-e970-4d84-8f89-fd314e42ed30@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

Fixes the following Coccinelle/coccicheck warning reported by
minmax.cocci:

	WARNING opportunity for min()

Use const size_t instead of int for the result of min().

Compile-tested with CONFIG_KCSAN=y.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e42489..53b21ae30e00e 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
-	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+	const size_t read_len = min(count, sizeof(kbuf) - 1);
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
-- 
2.40.1


