Return-Path: <linux-kernel+bounces-342693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DDE9891DA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 00:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108CE1C2331F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79F18A6B4;
	Sat, 28 Sep 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqGklTFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CE18754D;
	Sat, 28 Sep 2024 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727560848; cv=none; b=JDmQBEiBteIfcFXmZbnJnShRR3Q1KWndXrNhH3fEsZymLLal4RB8+/j/MgLI3KtdTFytqsnmJfrPCiQUWqrfr2fRqhSmJ37XnQe8EKBAeWXYX/l3uLBFCt4OQAdFV1QCDd/324wh/IYug6o8evLh6qS5CfhF+NvNE37o+M+4fMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727560848; c=relaxed/simple;
	bh=yafdB9R1iS/MIPawy5b6gSA2MMikl+1Y9iR4oZxhH0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNZS8jJ911ztJvSH/Qdhh7WDwX66nvd6aBHkyLh6RVVH9O2rXs68ChUAk0CLL6ciR+rI/gZ5YjHvI34e6zo+AFylMqfoNSVQqv+XRtMfSmTj3vs3HYdn32XvTstKe8lSgZo7dNGCXYloXR8DosMTFi7BH+awefP3azjFphqKhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqGklTFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D97C4CECE;
	Sat, 28 Sep 2024 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727560847;
	bh=yafdB9R1iS/MIPawy5b6gSA2MMikl+1Y9iR4oZxhH0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqGklTFYYorgtFAQtQrttOJoheU+LqSrmOlXvf5Pi5h+GZZ7fZGErPRnHPybPJwNx
	 EMB9//b/EjTw0OxmlH/+vu1g59QUt+GXo0TX/u8s/aVSQa7UPqTw+oigemBLI3IVVu
	 7a6rfdAr8f1zDzpPv8Gvef1h9dCAxB3/VVfDE+T9jxKEo9ivIHDmsHl/uaq5qGy694
	 nCPtQTfRm4l+7bg9UF0gEuC7JYgBb6st1V9XchclCPqluVklrGOnKQwVS3aSVmTC1L
	 cIBnsQLRm/FuRRPIrATy4xVbuCHWBxcIV3fx/5EFmjw+GafSq8Q0tutW/JoNRSQfto
	 R5zok+GBwXYDA==
Received: by pali.im (Postfix)
	id 6A215C46; Sun, 29 Sep 2024 00:00:41 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] cifs: Do not convert delimiter when parsing NFS-style symlinks
Date: Sat, 28 Sep 2024 23:59:46 +0200
Message-Id: <20240928215948.4494-7-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240928215948.4494-1-pali@kernel.org>
References: <20240928215948.4494-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NFS-style symlinks have target location always stored in NFS/UNIX form
where backslash means the real UNIX backslash and not the SMB path
separator.

So do not mangle slash and backslash content of NFS-style symlink during
readlink() syscall as it is already in the correct Linux form.

This fixes interoperability of NFS-style symlinks with backslashes created
by Linux NFS3 client throw Windows NFS server and retrieved by Linux SMB
client throw Windows SMB server, where both Windows servers exports the
same directory.

Fixes: d5ecebc4900d ("smb3: Allow query of symlinks stored as reparse points")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/reparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index af32a7dbca4b..e3cf7ae516cb 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -335,7 +335,6 @@ static int parse_reparse_posix(struct reparse_posix_data *buf,
 							       cifs_sb->local_nls);
 		if (!data->symlink_target)
 			return -ENOMEM;
-		convert_delimiter(data->symlink_target, '/');
 		cifs_dbg(FYI, "%s: target path: %s\n",
 			 __func__, data->symlink_target);
 		break;
-- 
2.20.1


