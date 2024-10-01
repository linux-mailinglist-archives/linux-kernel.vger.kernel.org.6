Return-Path: <linux-kernel+bounces-345604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A354798B801
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64CEB2411A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5219DF61;
	Tue,  1 Oct 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="n3O+NARF"
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126519D07A;
	Tue,  1 Oct 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773872; cv=none; b=NT/Sr6jPbMVSxahl7Zgo3gmPhJDSwW3Nlo/SSzn3ScQrrOFS1cPl+FASemZYvAV8r/tyq3DxE/PvB0wpmHlSMF+Wjug5NOWqcGJrXag8Xf6CcDjtWDNZP2P1HRGB5PPTc4aCeu2BvdYUptPGuq9VeLqqfhgelN9I6H6LHgFnJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773872; c=relaxed/simple;
	bh=PXZWLLFPWp/92qDLEEuKXg3jIukh0rUF6VWNzKglr8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6wo/aOT2yEnf/y/sGMOoQGgZaYQFryltW8NDTjMDUTzQu0shFd7smVD/MDz2RZh+BKYz/Qdmi62p0aBqq9apsC8/EUOJE9gFauSAqPdOsIlZyzRcodqaESuD8P6rrcmfVUy0Vqdd7gQaUoj6mdV2Hi8MockGx4T2Xc4kK3MfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=n3O+NARF; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 140F721B6;
	Tue,  1 Oct 2024 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772832;
	bh=iKaPySfEN18SNnEH2EvYXCsXO65BKve1de0WsdZe3eI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n3O+NARFD1NJnlupRJRoDOZU4cHY6zKYIhQ5CSMBVm7XcNYbdqUXTssJWU0AGVPUv
	 OXLDtRmFWut5fItxd3UC1UuY44pcdb5mATuVRHVuLtS3p3DoNTN5h3ctBb7f1o34Kx
	 LA28CDtX3xs31tNJDy5+KY9di+Gegj+cnbuMtzmg=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:25 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
Subject: [PATCH 1/6] fs/ntfs3: Fix possible deadlock in mi_read
Date: Tue, 1 Oct 2024 12:00:59 +0300
Message-ID: <20241001090104.15313-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
References: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Mutex lock with another subclass used in ni_lock_dir().

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 4c35262449d7..abf7e81584a9 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -81,7 +81,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
-- 
2.34.1


