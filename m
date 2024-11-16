Return-Path: <linux-kernel+bounces-411926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C49D0169
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD582286B48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D0C19ADA4;
	Sat, 16 Nov 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="eozjnMTU"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4629A2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731798806; cv=none; b=i2+bPfUbLi5CDAqw1v+GcP3rVzXQ2KAqqVNW93z5iBl7uAQema+rKQqH+4mVBrw7hKw9utt4gdEuVUWP5o+Y5KHre1rg3AgzLJRFXmg7Ag6PdIJTUH0cEM0jiSOHjKYwZauQL/QIEv+ZQHhWD9LjO7V93RUDB9Xb/OLSEJBxJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731798806; c=relaxed/simple;
	bh=iQOZDeync45mRT21AaOIB2B7cZEhqQFJOS7003lkEM0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lqqr/EG82c144vrV7ItvJ8NN1o4G+YBinTQcdDACBdWGE8JuusuKgSKpSFV6mXp6S04Gy5u5TsLWp3xLbSsGWcWV08n/Hs3NQH0OCLyznPjh07Yh8MPSx1Xv3HZ3GKkE+ptSYkGlhPiqQXsqdZNpmfJBrW+jDZ9diI8P9Uy/kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=eozjnMTU; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id B5C7A177104; Sat, 16 Nov 2024 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731798803; bh=iQOZDeync45mRT21AaOIB2B7cZEhqQFJOS7003lkEM0=;
	h=Date:From:To:Subject:From;
	b=eozjnMTUcO+wn8KOypTSzu5yWHRXGFaFALEeV4/lLd9FP5/JTlPpkoVUyNaGt4/Ug
	 T6pKBSFCvwcfwGmFxmDYdPST22wOYZNR3Q5qWbEZ/lovkhBioxqZ8kDKuo4/sbnpCC
	 NSrxclteinbDG40WxdzxiwgtdOvNrlSAhubZE2I7fYlyJS7Axc8bIQvWBcyqd69xcx
	 3VoARs9IxDqND+wS+MmxceZkyiFnw6nQqxfXrZ7V8BcXD9J8sWjbZNHyCAmCM9POiu
	 aoDYtq8AjZ8NM+R+mBrvq6XooRMt6l1j0GvIcAX5/8SnHjnulmg0MREgz0TAaO+3LS
	 kFvqYwIuLtq5w==
Date: Sat, 16 Nov 2024 23:13:23 +0000
From: Nir Lichtman <nir@lichtman.org>
To: ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] exec: remove legacy custom binfmt modules autoloading
Message-ID: <20241116231323.GA225987@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: The search binary handler logic contains legacy code
to handle automatically loading kernel modules of unsupported
binary formats.
This logic is a leftover from a.out-to-ELF transition.
After removal of a.out support, this code has no use anymore.

Solution: Clean up this code from the search binary handler,
also remove the line initialising retval to -ENOENT and instead
just return -ENOEXEC if the flow has reached the end of the func.

Note: Anyone who might find future uses for this legacy code
would be better off using binfmt_misc to trigger whatever
module loading they might need - would be more flexible that way.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

Side-note: This patch is a follow-up for
the discussion on "exec: make printable macro more concise".

 fs/exec.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..f3975b0636bd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1723,13 +1723,11 @@ int remove_arg_zero(struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(remove_arg_zero);
 
-#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))
 /*
  * cycle the list of binary formats handler, until one recognizes the image
  */
 static int search_binary_handler(struct linux_binprm *bprm)
 {
-	bool need_retry = IS_ENABLED(CONFIG_MODULES);
 	struct linux_binfmt *fmt;
 	int retval;
 
@@ -1741,8 +1739,6 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	if (retval)
 		return retval;
 
-	retval = -ENOENT;
- retry:
 	read_lock(&binfmt_lock);
 	list_for_each_entry(fmt, &formats, lh) {
 		if (!try_module_get(fmt->module))
@@ -1760,17 +1756,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	}
 	read_unlock(&binfmt_lock);
 
-	if (need_retry) {
-		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
-		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
-			return retval;
-		if (request_module("binfmt-%04x", *(ushort *)(bprm->buf + 2)) < 0)
-			return retval;
-		need_retry = false;
-		goto retry;
-	}
-
-	return retval;
+	return -ENOEXEC;
 }
 
 /* binfmt handlers will call back into begin_new_exec() on success. */
-- 
2.39.2


