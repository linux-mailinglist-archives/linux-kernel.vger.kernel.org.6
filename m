Return-Path: <linux-kernel+bounces-411048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F19CF379
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA09B64E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C091D54D1;
	Fri, 15 Nov 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="qHYC794z"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF55762E0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689743; cv=none; b=iKCGCB+7BkXAcoiZlxe2WwrMIoEgQ2lEJRMUFlnaQv8TPkd0IcAciNnFyFZn/LjrYgFE6rjl+tcpDWghBWKXD/x9LHTAf3jNrPv7DmJyzmMuDC/OJI/DJLhM7yfsDTCZZmtpjQEUSFltrwqMpeRQ1gc921pdvPLrdzlQV7fHmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689743; c=relaxed/simple;
	bh=b7lGpWdm4rz58yr3GDepY+GoJDmX40WkokM3hkmIl6s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tFXzkVTGl0EOgeUv0TSMc5hQJ90VeRTlYV4cq1WzxAfwJatQ1v49jymmfbampFQl7CUYmxSGqEyLNsBpeNWOJv6gH1rXdI5z2NlGvpA6h9RGRm99IpuIxqjLwoXFaL+s4A0xPjmSOaVwddepSc/qF9DaVGw69vy0bvfkO25eX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=qHYC794z; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 876551770E5; Fri, 15 Nov 2024 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731689741; bh=b7lGpWdm4rz58yr3GDepY+GoJDmX40WkokM3hkmIl6s=;
	h=Date:From:To:Subject:From;
	b=qHYC794z9fSe+3YxtW0slwOcoBY4AwWVOeHbySRA6BrbU5uLiUhObR0zVrDlRi59A
	 es7I/ux5X92IAxgcbJmf625ODM9pD2jQh+82w3SpsGftzPVPpfwiqYkKZOH4vQqMvf
	 pNWnlpOkLoanxzMTh52/G36x/k9dXRp0XkMgQApMrnBcKGLnnO0Xum3UbYrCW96m3l
	 CwIl527Cm+rXW7xPnU7o+lQm/Dqz73cPzsUbelmMblLtI7obYvQVSBHhBZN7lYajh4
	 SDW8D+j530fyJCB2NPQzqajlqxWSnviXFHLekP/+h6aBwlJCDJXyj9uQSSY05Klvr8
	 XBaRc43Hx+uGQ==
Date: Fri, 15 Nov 2024 16:55:41 +0000
From: Nir Lichtman <nir@lichtman.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, kees@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exec: fix no kernel module found error to be more clear
Message-ID: <20241115165541.GB209124@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: Before starting the enumeration of the supported formats the
default return value is set to no entity which is misleading since if
the kernel module of the binary format is not found, it would return no
entity to user mode which is misleading since it is signaling that a
file was not found, but in this case the more suitable error is that the
executable has an unsupported format

Solution: Refactor to return no-exec error instead

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3394de5882af..6324f9546b09 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1740,7 +1740,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	if (retval)
 		return retval;
 
-	retval = -ENOENT;
+	retval = -ENOEXEC;
  retry:
 	read_lock(&binfmt_lock);
 	list_for_each_entry(fmt, &formats, lh) {
-- 
2.39.2


