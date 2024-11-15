Return-Path: <linux-kernel+bounces-411045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49B9CF396
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98ED8B2DB1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E331D5CFB;
	Fri, 15 Nov 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="IbvlFdm0"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C321CEE9F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689639; cv=none; b=DCrkljLRSIxtHTSMy9IrGYdS72ce9mpbmJVtfTtCEGW5UaqoGnnO/8RWxnzHnwaMd/bf9n/HbXu8CEQz8jTZh+9H0mk/US6oxbJ5HnWLPjgvhheZnzX5uFQI3Xtj2RE2wKnH72HAieA63h+/cYbJKqOP3bLzVbF5wy9L8Ihf+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689639; c=relaxed/simple;
	bh=mX2rZJoPnwCyrtfOox6/dpwfZeBGey3TBUIBsAifwQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R1x3vYQve1VmJvsbKXnulLHWIhh0/9vTrUQ2qGJnfjJiBoTgmGHxsec0Hk1Io0ZcLSJNtabggQDDhpPc7d5x9L1Eu+1xwdzBrlnWkoay1cynsfpINRAu1GTTfy/GthT3IMQ6D8dj6B5DP0cJzy/1fXBHKYPvgRnToX5UaPT5fPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=IbvlFdm0; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 951ED1770E5; Fri, 15 Nov 2024 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731689631; bh=mX2rZJoPnwCyrtfOox6/dpwfZeBGey3TBUIBsAifwQQ=;
	h=Date:From:To:Subject:From;
	b=IbvlFdm0CfICQ43f7Rt3QCQyEeWTH5QQIzABLwB7I5LqdODqHDUiwaGMF0WQH8/cM
	 CAiYtaQ0XB3RMt+K5DXwJTG4TT32shbp09gkOTnnNV9lGR1qJCmAI0XBuVlB/DId1q
	 jcgbvPjCDrJv7guw8r4tiOa9SHHhPgTEUuytvVo3EyY7oBbPNNRs7JMI/0FbUzU1g3
	 gYApKqJLSN7DXxb8fHN55A7E+bbax62QVm51UDB1zISjQFug/lyeyDYLMvbLq/Rscu
	 md14XiryPimR5LRrmiA1sPv4u5o/saWTVhRhlbqV/NwmGGIkLoaBGP5yW6jYayjax0
	 0fYcYUcg1D1Sw==
Date: Fri, 15 Nov 2024 16:53:51 +0000
From: Nir Lichtman <nir@lichtman.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, kees@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exec: refactor an invalid executable check to use isprint
Message-ID: <20241115165351.GA209124@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove private printable macro that is defined in exec.c and migrate to
using the public isprint macro instead

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 fs/exec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..3394de5882af 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1723,7 +1723,6 @@ int remove_arg_zero(struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(remove_arg_zero);
 
-#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))
 /*
  * cycle the list of binary formats handler, until one recognizes the image
  */
@@ -1761,8 +1760,8 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	read_unlock(&binfmt_lock);
 
 	if (need_retry) {
-		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
-		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
+		if (isprint(bprm->buf[0]) && isprint(bprm->buf[1]) &&
+		    isprint(bprm->buf[2]) && isprint(bprm->buf[3]))
 			return retval;
 		if (request_module("binfmt-%04x", *(ushort *)(bprm->buf + 2)) < 0)
 			return retval;
-- 
2.39.2


