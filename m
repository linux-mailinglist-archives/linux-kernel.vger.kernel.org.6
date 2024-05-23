Return-Path: <linux-kernel+bounces-187405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A28CD155
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C31B21506
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89DF148314;
	Thu, 23 May 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PAmyg3Sy"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D813D2A8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464216; cv=none; b=toh6zYgbsMraGa5xZ6DMlad6DGjbrwULZdF3NZKH7ZUFjJpTfgQfToPNDMqeXn33a1PUireNkEOzkZ/4cIyEhFhp/VFyvh+N+jI0f0BoraKEhAsNj8g3tOA3yOb2bpd3NZi+QH1Ec4pNiIWPmoWcBf1kTEZNRfVV+ey5mcEEMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464216; c=relaxed/simple;
	bh=DeCHEBXm84fTHEnuhvrdvxZpyAECRARMruHiATa02mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtJU8TEEkarIqX79V3RM07i8HH1RCzti0CdaiSxM6b1tGYZ9HeIv/5kGC/NCe0D9yU7WmSTQnNAzq9ax4a2iOpHd1nRJ9eBdsqKSnQ26gqsrKpyNRNH1kJPmHu5CfAzNMpSJ/Ks/FDSau3g/Hbwh5Mc45jH7yaIZKipTKAmByeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PAmyg3Sy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1B47614C2DB;
	Thu, 23 May 2024 13:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716464211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60Vvdeh+op3+l9xDGUiU5JwA9pJlLDPkUP9yCEgZNBk=;
	b=PAmyg3SyPRLIxnMZRiSX5HHM0yzmUdw+5SROQqW9yJX/FMb9qwIbyaZGcfGInZNgBTO85m
	B0bLvomo6+Wr1pj7Nq9psXsrNcF65fqGy7up0MNeZk7i7Uomfz3qhgNQ3WKakHM/STCplM
	nvJT8RIIvFOtrfTvCgphOl7No7fenPRHTR0RFVkXZ6BS8rZ4EfHXo4+OTlj3neJbci7eAa
	y/epKXxdrH362ggKNotyOXKyP5C+s5kTjy7ltbVwwiXwXDMKmiSBG3Kl1VxWb/4RqmOKAz
	lPcPmh7KG3reHgjoKR0/ur9m0vm+KTuvbjwBlcl84y3scjyJtSFMEOr6LhV1bg==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id b772ab8a;
	Thu, 23 May 2024 11:36:44 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: v9fs_fid_find: also lookup by inode if not found dentry
Date: Thu, 23 May 2024 20:36:38 +0900
Message-ID: <20240523113638.1196299-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible for v9fs_fid_find "find by dentry" branch to not turn up
anything despite having an entry set (because e.g. uid doesn't match),
in which case the calling code will generally make an extra lookup
to the server.

In this case we might have had better luck looking by inode, so fall
back to look up by inode if we have one and the lookup by dentry failed.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
There's no hurry with this patch, I'll just queue it up for next cycle
in ~2 months, just sending before I forget.

 fs/9p/fid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..c72825fb0ece 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -131,9 +131,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-	} else {
-		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
+	}
+	if (!ret && dentry->d_inode)
+		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
 
 	return ret;
-- 
2.44.0


