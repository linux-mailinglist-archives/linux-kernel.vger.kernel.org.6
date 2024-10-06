Return-Path: <linux-kernel+bounces-352321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3ED991D99
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716B228398A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DFF174ED0;
	Sun,  6 Oct 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr1k+gLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24C172BA8;
	Sun,  6 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208870; cv=none; b=dvrohM/SJnnloxIa+W+cUXXq1st/BwAqVtrBew0tIt9qELJp19rLBlqSc5UYrLcZvw0xguV2R3gXCYgzNd/ypLXE7kLrQ67r/gnuZU/cIZSXFH7C845LFwjGYKZt6Imtz5kMZ0B2vW8avHmueiH2KqWiZ1FMZNFZh8xocUwy2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208870; c=relaxed/simple;
	bh=HMbT4/jYDStIkanL13c7g7bisXyK3wEpZjkJqmhvzLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFi7RmkLQMmZ6NDbymb4XEK9HHrLhn7dlU1Z91dy8qG0DOQ0SNbQEDjlxfSQGNGpkZmDTKhnA6F3LlTJmNJekEjl4+7Vi2qFEPhMgr2bVwvz9x91Z14zmt+Jmn+VJM9arIMWWWEkbBWE/Hc4kZpQDMzHynrgL5/H/qDo0duHlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr1k+gLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997D1C4CECC;
	Sun,  6 Oct 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728208869;
	bh=HMbT4/jYDStIkanL13c7g7bisXyK3wEpZjkJqmhvzLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qr1k+gLMxJsSyBBdVQ6BwRimxblAur+F5lGs645TvzzU3i3HTawqe5UOcbcyoUzrS
	 vpIQIS33b/s0fFJVB0YeNveeK0si9YE1Bt9k++SHI1ebN981VKv7LbgUunF63S/NcP
	 VLhRHZDr9PYAmjW81Zh5Mtq22JRoV7iwMJUkyhr7DtRoRUZywbAwi5FV2rUyXdjpug
	 Rf0rG1HGebDS/iIGxlrtBWUEhPPFJCrh3PgovpcDc6lcBVnhRtSYrZ/215ptTp+kJS
	 jgtV5rGSAxgWPD70wlOfX3ptEzdmv4shazDA1AdhboeJ0yhFYR5A2l5nQmz/WJt5cf
	 ylvE+Ly7q+5Vg==
Received: by pali.im (Postfix)
	id 24473CB5; Sun,  6 Oct 2024 12:01:03 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] cifs: Improve guard for excluding $LXDEV xattr
Date: Sun,  6 Oct 2024 12:00:44 +0200
Message-Id: <20241006100046.30772-6-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006100046.30772-1-pali@kernel.org>
References: <20241006100046.30772-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

$LXDEV xattr is for storing block/char device's major and minor number.
Change guard which excludes storing $LXDEV xattr to explicitly filter
everything except block and char device. Current guard is opposite, which
is currently correct but is less-safe. This change is required for adding
support for creating WSL-style symlinks as symlinks also do not use
device's major and minor numbers.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/reparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 41f91613e7f2..402eb568f466 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -578,8 +578,8 @@ static int wsl_set_xattrs(struct inode *inode, umode_t _mode,
 
 	memset(iov, 0, sizeof(*iov));
 
-	/* Exclude $LXDEV xattr for sockets and fifos */
-	if (S_ISSOCK(_mode) || S_ISFIFO(_mode))
+	/* Exclude $LXDEV xattr for non-device files */
+	if (!S_ISBLK(_mode) && !S_ISCHR(_mode))
 		num_xattrs = ARRAY_SIZE(xattrs) - 1;
 	else
 		num_xattrs = ARRAY_SIZE(xattrs);
-- 
2.20.1


