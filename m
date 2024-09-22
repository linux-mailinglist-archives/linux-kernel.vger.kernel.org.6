Return-Path: <linux-kernel+bounces-335037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1097E02E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 07:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C44F281789
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D7155A26;
	Sun, 22 Sep 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L/LLS03U"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775A2C9D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726981390; cv=none; b=kMo1E9MsOhYv4s09XKLuCygH/H21vq5on5EyVvoxr5qnGFlY9HkHNgUfWplwOcSjB49/4N6xZRycHxtkb7zfQglip7OMOYTgocXk7bjWwgi0pr+wTcXP8vprq1+NEFDoz1uEb98w8sZHmt7Ca5NWnOc9DYH/gvvHsdegsDr6A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726981390; c=relaxed/simple;
	bh=MrGgYU52955gu5WxHVvH9OxvSr9R1ccxeJRD9f3EFMA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fYcBod05Pp+Zt9THze+peJvduOiG1K+zEOdli9nCKoQlhjfg1EoEWKVrQBpydMnW6s04jI/XNResy3XVwA82Oq6ki9L61eboMl3kRa+s0Xf+J1Br3EI+CWvpSxKO07fhgZNU62PNxk7pvOdQljJUNLczfOIzJJ2tCadganSYwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L/LLS03U; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726981380; bh=rLIxChQwuio7BiJpebU+iR2qcqd+AgwdA5rqzEAqN/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/LLS03UWLG4IKZ4fIPZN3qGal8PRL0SblLs5lxqOAnwVGGFfNAiX84kg/unfg9vZ
	 5b+IiThQ7q5PWSG16+XN0abtxL3o0NlGtq9tIyUmln38luY9jmqUpAUgLIcqgxbtiB
	 oqqkcFRokzxaCL6AdD6O5e/WQ1JKYaaC9f2xF5BA=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E3812C52; Sun, 22 Sep 2024 12:56:56 +0800
X-QQ-mid: xmsmtpt1726981016txcnhlvza
Message-ID: <tencent_8F67C9C6DBD2F6867309802EEE2ED84C8406@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaGd6CTsWuwfQ8F9Cin5XGTQprHs7HZHq9C8ajSoNOsyntra6A2V
	 ykTEwyL9drf1uzI6uHTFFlY7qi81c2mYpeLzpVsrY0Vznaq3K8tQS+lrOttNL9bmvyA+0M2bzgF2
	 vQJSApBs8TauUBaYNbedVoFPSUr02xSe8GGIF0OdAYt+qdlgHfFLs5TxGSfVrxDFTAiH8Af5NK5B
	 ob7xuVw4EtkSgq8ofUdtKnKG8F3WRpQUXlwzyM6XZgpH4dXcHvwFDRrOws3WHs3kT+a+eNsvSAHI
	 Z/bRwxSEHcEFHtMfmoCdOFE1lx4QsBAPPsU83GmEgozl70vS1lU4fbvG3RSBgLuFJzH6PypFtmFo
	 ewY9JoR3aLKfop5zM3LSO+I0/rvRnWR1gWPAsZE8eveF9+6UXzMLqIa74JnJWzscQja3jj89Hws2
	 +JTsvphrDZEAapdgsnuOhYjg1+GsuOzZQ1wDE03AXw9mK8gJn0W4Bkq6op/2+paVNF0cDIMn4PAu
	 y+GFmGnuFQ3CSnG75Y76YrJVKk5/cTSGWAhjkCoOAUM/IE3vKA2wPsiiEpHv+3hFDxp4rgSM4L4B
	 0lYWS65A8oQ0lhuqEGJg7XQBHlNhfAAWeswdDNFkC/t/8t9CrCM6yEvcv3cd70CkT9HYY5ab4EhH
	 28LSpA7OEyPlHY0WsMTj6+MT3nEHhnRg6SXZOJXxbGpGy2qQ0MJIQl6bsG/SjN8uRh4ALHfF8piC
	 Kwl+bXn/If5pnP79tNA/jE1SsqOSzb/6z/HofLkrwoyAcfhqnWe6blSqvfRP6mKTZNuVETjjHmNt
	 +ltVxd2PUQLxbjd/YA2JN52Jz7/knq/JubbQUYkpLfnjZL/lKCn1o9OFaFlv48KM4ZeDIvVde8h1
	 g+upfCTTLrCVfJ3OunrYbGbS7gLNqsVxWCGkSQz7LnE8Y+Nfqg7NNROL5zR3XTdA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
Cc: jack@suse.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] general protection fault in udf_read_folio
Date: Sun, 22 Sep 2024 12:56:56 +0800
X-OQ-MSGID: <20240922045655.1723197-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66eefd0c.050a0220.3195df.0061.GAE@google.com>
References: <66eefd0c.050a0220.3195df.0061.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In erofs_bread(),
	folio = read_mapping_folio(buf->mapping, index, NULL);
file is NULL, it triger this issue.

#syz test

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4726a4d014b6..fb8121edee8f 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -220,7 +220,7 @@ static void udf_adinicb_read_folio(struct folio *folio)
 
 static int udf_read_folio(struct file *file, struct folio *folio)
 {
-	struct udf_inode_info *iinfo = UDF_I(file_inode(file));
+	struct udf_inode_info *iinfo = UDF_I(folio->mapping->host);
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		udf_adinicb_read_folio(folio);


