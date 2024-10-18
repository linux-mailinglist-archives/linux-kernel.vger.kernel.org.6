Return-Path: <linux-kernel+bounces-372485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CF9A491A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D61C20D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD918E05A;
	Fri, 18 Oct 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEmQIQAX"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0B18858C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287949; cv=none; b=uaK5GI3ANERzm8qsFO2/s2W7VbqTzxdHQ4+BrBRgxaYeaymRs0PAQmZ+Q3a2vOgTDobub+j6Cg3X1ybQBRxXj4KZv8dYgdqQsA0Ms5f4o6dJY6IVWvSYW5K6gdFb7UQvTLCBN4ZvtlGkK/GbO0q0JVrSdIW6FuiGGBMShBOte/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287949; c=relaxed/simple;
	bh=tOA01gs5nPhL/vmNbtW+GIMrz7TJDXxOicvU7S/TnUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8/7cV7JJyUqaGOU7mlIG6MtSwU6Po8ZmmyQlRUmXy1okoMv63zHMGIed+onjLtYBCDTKQvzfeGn/a5akwmN+TVP4dq3aDVnVTwvI9oaWOWK5JrEIYYL4qc0GCwMcfUsCcC8uB9ePfKPDgVKnat79BdfsD+1JD0LjqCriJcOlnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oEmQIQAX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729287944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R9I7quaW8/F+28X0/jjvHTMqunMj8YXAmloyPwoMZ/s=;
	b=oEmQIQAXrKhG6Gtv7DgeTou2NPrJMFRi6Azoah+bii+k/NFmHetdBEYX3kBZbNslB66OU4
	k8NzDLGKaAtZafnf0EIldMLvFGfnUS5g0SjViXC3665n718hr/tBdgUP4D3uW+eD5DkJ7W
	yIXe4yQ0xz4CxwP1pzPuMVXrYSiSBmQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] apparmor: Remove unnecessary NULL check before kvfree()
Date: Fri, 18 Oct 2024 23:45:14 +0200
Message-ID: <20241018214513.163269-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since kvfree() already checks if its argument is NULL, an additional
check before calling kvfree() is unnecessary and can be removed.

Remove it and the following Coccinelle/coccicheck warning reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 14df15e35695..ce1c96cb2aed 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -103,8 +103,7 @@ static void aa_free_pdb(struct aa_policydb *pdb)
 {
 	if (pdb) {
 		aa_put_dfa(pdb->dfa);
-		if (pdb->perms)
-			kvfree(pdb->perms);
+		kvfree(pdb->perms);
 		aa_free_str_table(&pdb->trans);
 		kfree(pdb);
 	}
-- 
2.47.0


