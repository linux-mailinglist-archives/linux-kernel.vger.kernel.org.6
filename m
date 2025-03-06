Return-Path: <linux-kernel+bounces-549631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88700A554C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793E817328B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABA274260;
	Thu,  6 Mar 2025 18:18:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB926FD9E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285105; cv=none; b=b9LVOHRLz46LCmyWnFMDWU75lTwR+EXy7t+t9w7Ot8nzlgXFWlyudiRa9OW5T2kL9fz5pXe6LFl+hEFzskK+uMZOqREjSIafqS/CSXpXBcoEE/7eo0cDRa6d+rGx337cNBEk7cM/o96LadyKC1Nfq1BwatmN/K2lTJLSJLXO7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285105; c=relaxed/simple;
	bh=fVbKN+wjjZ4pr7g4zo/O6vgNWA/C+DXje8FsI14Fxt8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oAZuvIHN6FIRvwW1+3yX8hTUG2xNodzQLaDi3D1LslIOwmHuTdwsB1Tsj6IiolD5CYsJERzTLkpdo/OwjBXZ9TmhBaWYXplovFECmTZB2VmXlJpwEqXW1uAetMhiqYziSzo+9RoFxpIGwsQ3WDpgj3ZFXrDaYj4iQ6XqXckGO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7A2C4CEEA;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFne-00000000PJc-3o1T;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181826.773344269@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 09/10] tools/rv: Keep user LDFLAGS in build
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

rv, unlike rtla and perf, drops LDFLAGS supplied by the user and honors
only EXTRA_LDFLAGS. This is inconsistent with both perf and rtla and
can lead to all kinds of unexpected behavior.

For example, on Fedora and RHEL, it causes rv to be build without
PIE, unlike the aforementioned perf and rtla:

$ file /usr/bin/{rv,rtla,perf}
/usr/bin/rv:   ELF 64-bit LSB executable, ...
/usr/bin/rtla: ELF 64-bit LSB pie executable, ...
/usr/bin/perf: ELF 64-bit LSB pie executable, ...

Keep both LDFLAGS and EXTRA_LDFLAGS for the build.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250304142228.767658-1-tglozar@redhat.com
Fixes: 012e4e77df73 ("tools/verification: Use tools/build makefiles on rv")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/Makefile.rv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
index 161baa29eb86..2497fb96c83d 100644
--- a/tools/verification/rv/Makefile.rv
+++ b/tools/verification/rv/Makefile.rv
@@ -27,7 +27,7 @@ endif
 
 INCLUDE		:= -Iinclude/
 CFLAGS		:= -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(EXTRA_CFLAGS) $(INCLUDE)
-LDFLAGS		:= -ggdb $(EXTRA_LDFLAGS)
+LDFLAGS		:= -ggdb $(LDFLAGS) $(EXTRA_LDFLAGS)
 
 INSTALL		:= install
 MKDIR		:= mkdir
-- 
2.47.2



