Return-Path: <linux-kernel+bounces-411613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443B9CFCDD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF12287F03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3365191F6A;
	Sat, 16 Nov 2024 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="g2hT+NKJ"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357B12EBEA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731737581; cv=none; b=UzB1wpNtzTSZFagpJUHTX9toFyoUCltG7GH26OG+TeYB3BhT68t+PKEEFKvexzXDrf+Zr4TFYumqpb7ELnz+tXXiEN+pScdi4wtAQznr8ztl3kAPMKvTR2HLV5+v1VDZ7l3DZf6SM0zOLcvapuJK0AuFt2vW9ky+cMO9uCbAtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731737581; c=relaxed/simple;
	bh=rOqFNyAnQW5m6Rsc/Bc/OPJweQgPs66o5oEiEvizEeE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tXK4IzFBGdae1ghGl7Vsw9P0tga34q2Mg4zG+y0+K/kDQv4TwyKJillhp4RIMVWerr8dtJiewiUApbjMHIH1VIjG9laHj6HfeVwTg7QIlbZQHNeFWql410vMHybmo/YVVXFMjM7zTDjnNGGCwl4ajJHTYkYlzcyovp29hOgE1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=g2hT+NKJ; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 962BE177104; Sat, 16 Nov 2024 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731737578; bh=rOqFNyAnQW5m6Rsc/Bc/OPJweQgPs66o5oEiEvizEeE=;
	h=Date:From:To:Subject:From;
	b=g2hT+NKJ4TxU0YJQ3axpKlUk6XpdP0tUYTYKYUx5UzT4Z1WnMnNU8NtWFNV2ymKTN
	 FwtpYRQ1jqzNFKRWl8JB5roXvStqlqM3sB94emT5wa15icneJGpCD1jD+AdmSP3K1S
	 KGc2WsdrTdpSAs7z4gB/x2ZI5e8/vljG5husZ+uNKa3nUcywwhvym0PcC6mgkg8i3E
	 pIMoMH3ahjK9PB2cIQbmcWmgl+iuuR1BtzH6n1ShSOlPKV0sAhqyl3MvxyD0iUqbvP
	 h9hVpzwwYA0glcKsTahh4PxyQGEMXCGb3dyveTe+ogRBTrMya91RV7QBmjX9upAPMi
	 XpAUfU7cYzqtQ==
Date: Sat, 16 Nov 2024 06:12:58 +0000
From: Nir Lichtman <nir@lichtman.org>
To: ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116061258.GA216473@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: The printable macro in exec.c uses custom logic
to determine if a character is printable, even though
the kernel supplies existing facilities.

Solution: Refactor to use isprint and isspace.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

v2: fix to also consider space characters as printables
Side-note: I called the previous version "refactor an invalid
executable check to use isprint"

 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..3b4c7548427f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1723,7 +1723,7 @@ int remove_arg_zero(struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(remove_arg_zero);
 
-#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))
+#define printable(c) (isprint(c) || isspace(c))
 /*
  * cycle the list of binary formats handler, until one recognizes the image
  */
-- 
2.39.2


