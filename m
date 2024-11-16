Return-Path: <linux-kernel+bounces-411620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E39CFCEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27FAB21EA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EF190063;
	Sat, 16 Nov 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="AwZpMXdg"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3D219FF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731739190; cv=none; b=V0cjIBlJ47E1Yo7YWmySXNHI4WA+hntFkkzASQpalH33kAjhsCT78J7fjbcimpcjNuj0cBpeC+lRTXEN/dXUqkDOlBMEEJNTpKxtk80zNBtnT+xIZ+dtjrPfaya2tTyXcflTjWjeY4ptPwuuhrqdgcRhVSCcQfNAb4ZgAYSjJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731739190; c=relaxed/simple;
	bh=jI2OQrETtOufrVGyftQc1j1Mp2GukRTF8Gn7V7LB6rk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y4ZBqEFzgIF/g+uekkIJ0ZFSre2N5LUane4ohMI8pONLJv6ew12+9acstRJKJ+KuAet5/ZTgAWOG0Ada/12RlW2koB3ywTk8+sA678C2j2kHd+eVLmCQXrY1fY1m/NAb82dx3PbaR/3KfT5vsk1/tgdlJ2Tn5CcCutWrn+lUNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=AwZpMXdg; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id AA291177104; Sat, 16 Nov 2024 06:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731739187; bh=jI2OQrETtOufrVGyftQc1j1Mp2GukRTF8Gn7V7LB6rk=;
	h=Date:From:To:Subject:From;
	b=AwZpMXdg8AUCx6Q536mvSqigF+YSc5Oo3VtQv6ZQku28X8cLATvQAtks5hbFQv/Tg
	 Pe8ohDlFjhTmerQp+f/jYRQDmpl12k3etWE+LuanTQj5+MOiEtlh2ozV8KO2tP4kkZ
	 Akz0hOMwyRPaywY/YzdXIXrqoLaMj936XEs1HnjKjBv6D5xvgrEbr7gv3C9QwprQEa
	 8RthefMwTxf93ZQTog9hkVZLKg2E8dUTrvoWeZXG3ZlUcMtUec+C5QeQOfRPUW//lO
	 mas8wlFxxUUXJ9bigxcSmoAnSq05O1uk+QOa8K91NErs5H6PbNMjbbcS8EOlDidDyb
	 aw6F3hNQMheGA==
Date: Sat, 16 Nov 2024 06:39:47 +0000
From: Nir Lichtman <nir@lichtman.org>
To: ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] exec: fix search binary handler to have more clear retvals
Message-ID: <20241116063947.GA216691@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Preamble: In case no suitable binary format is found,
and the enumeration itself does not return any retval failure,
the flow either goes and attempts to load a kernel module to
add support of the unknown binary format, or just returns.
In both of these cases the current value of retval is returned.
Before the enumeration, retval is initialized to be
"No such file or directory" but can be amended during the loop

Problem: The current situation forwards retval as is in these
cases which is not necessarily suitable for the flow, for example
when no binary formats are configured in the kernel, the enumeration
will not be entered and retval will be returned as -ENOENT which will
lead to a very misleading error of "No such file or directory".

Solution: Refactor to remove the initialization of retval ot -ENOENT
and clearly return suitable -ENOEXEC in those flows.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

v2: Remove retval init to -ENOENT entirely, and return suitable
error values in the relavent flows instead.

Side-note: This is sort-of a v2 of
"fix no kernel module found error to be more clear"
Even-though I have sent yesterday that it should be disregarded,
after further research, I found that is still relavent as explained
above.

 fs/exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3b4c7548427f..28755088175f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1741,7 +1741,6 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	if (retval)
 		return retval;
 
-	retval = -ENOENT;
  retry:
 	read_lock(&binfmt_lock);
 	list_for_each_entry(fmt, &formats, lh) {
@@ -1763,14 +1762,14 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	if (need_retry) {
 		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
 		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
-			return retval;
+			return -ENOEXEC;
 		if (request_module("binfmt-%04x", *(ushort *)(bprm->buf + 2)) < 0)
-			return retval;
+			return -ENOEXEC;
 		need_retry = false;
 		goto retry;
 	}
 
-	return retval;
+	return -ENOEXEC;
 }
 
 /* binfmt handlers will call back into begin_new_exec() on success. */
-- 
2.39.2


