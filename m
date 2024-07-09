Return-Path: <linux-kernel+bounces-245051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20E92ADB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC060282591
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEA2BAE1;
	Tue,  9 Jul 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/9KM8XW"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934B2AE95
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487542; cv=none; b=aOw6LIDutoTPd/sXCwfRmnNdrp4tTSYIe7XSI8g9x8CUxK2Hm/4mZjsZ/vGC2hEyMmT0qLIYvGDqVLqbc4120ruyIcBGW2MKOvVQvJtLHavitFlDXeWTrubiS2uSmbtcTu+tN9NhgwLSacSCzTV/8IbfJiKW5PU9RAy8JjuiLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487542; c=relaxed/simple;
	bh=oL/TbqX4j3gvs9TcjKMhI3mDedwFHZZN+/pwg98vDks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pudQKKtxYL9DX9NpVkbX0imWq8GOTxVlyKnx2IIN9COQabeDI1FtwNMJ6ZW8fi3MJI3lMcJvtQduXZSAhJKfK3mbPqNIi/hXlL5EEvOXTJOxmvcel7tlhbBgSsSijrUQHGVIl2QsTj7akOuzffOjENqVOOwL58uY7aulbX/bGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/9KM8XW; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kent.overstreet@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720487536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbuIxKQQ4S+A2myySSe8uwpo48kGeIhRa8Lb5m30vK8=;
	b=M/9KM8XWQT7HyulvOT5gxDYrs4MbVDJSP86WW/WnEGF1EKPNl18fKXoOkxmKsX7ecrKNSJ
	rKkvCdVsSX7r25EXmM6pbNOJ1JeuiecIRO88j0Komerf5F2P+eFlIlxI70vyXKH16svtnd
	OkoukdsZVKOshjNSsh760V00MQTgCTw=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <youling.tang@linux.dev>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/2] bcachefs: Add support for FS_IOC_GETFSUUID
Date: Tue,  9 Jul 2024 09:11:33 +0800
Message-Id: <20240709011134.79954-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kent Overstreet <kent.overstreet@linux.dev>

Use super_set_uuid() to set `sb->s_uuid_len` to avoid returning `-ENOTTY`
with sb->s_uuid_len being 0.

Original patch link:
[1]: https://lore.kernel.org/all/20240207025624.1019754-2-kent.overstreet@linux.dev/

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 3ea8dbc4d8e4..011ee5075a52 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1977,7 +1977,7 @@ static int bch2_fs_get_tree(struct fs_context *fc)
 	sb->s_time_gran		= c->sb.nsec_per_time_unit;
 	sb->s_time_min		= div_s64(S64_MIN, c->sb.time_units_per_sec) + 1;
 	sb->s_time_max		= div_s64(S64_MAX, c->sb.time_units_per_sec);
-	sb->s_uuid		= c->sb.user_uuid;
+	super_set_uuid(sb, c->sb.user_uuid.b, sizeof(c->sb.user_uuid));
 	sb->s_shrink->seeks	= 0;
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
-- 
2.34.1


