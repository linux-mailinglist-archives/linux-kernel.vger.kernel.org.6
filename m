Return-Path: <linux-kernel+bounces-577188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C91A71979
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4667A1B33
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181721F5423;
	Wed, 26 Mar 2025 14:55:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948931F4196
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000918; cv=none; b=VFagxnTTqw7oxdP1mmiXUShV72LZeLiGp+2pqu2oa1vRJSDKbJ/S+DDkIzVg+Vspe+eb37OWGrgOs0RuMMAA6MZlzCrDmEjrRfSo8Nqs3F9pGsP+Jo6mRGiO2iET1d9wDZtEfz90CV5FfdSqi9469gSGtHgRkl18CHPBB+OGfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000918; c=relaxed/simple;
	bh=o6iNGj42Opmg2oegJQ1Tw7Jv8z8jcOYi8n6UQAgaqHs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=btO36xdQKdmvBk5qBRiUhj10TBBI6JXBElM6D+nxcVIdVrtBaqY10y86d9Ucrc4G99qNDQOiJx/A1PwOgv+HfG1ht/XgjRKpG8HW9sSbOxjTqPE/l9XJ1hZa+nvk3SBtkfBngJxcW+7CgWQtRqYu/m+vGhgekH7WSNLFVgB2gTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA6CC4CEEB;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAn-00000002kGa-1LK4;
	Wed, 26 Mar 2025 10:56:05 -0400
Message-ID: <20250326145605.168984535@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>
Subject: [for-next][PATCH 9/9] rtla: Add the ability to create ctags and etags
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: John Kacur <jkacur@redhat.com>

- Add the ability to create and remove ctags and etags, using the following
make tags
make TAGS
make tags_clean

- fix a comment in Makefile.rtla with the correct spelling and don't
  imply that the ability to create an rtla tarball will be removed

Cc: Tomas Glozar <tglozar@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250321175053.29048-1-jkacur@redhat.com
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile.rtla | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index cc1d6b615475..08c1b40883d3 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -34,6 +34,8 @@ INSTALL		:= install
 MKDIR		:= mkdir
 STRIP		:= strip
 BINDIR		:= /usr/bin
+CTAGS		:= ctags
+ETAGS		:= ctags -e
 
 .PHONY: install
 install: doc_install
@@ -47,6 +49,18 @@ install: doc_install
 	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || $(RM) $(DESTDIR)$(BINDIR)/timerlat
 	@$(LN) -s rtla $(DESTDIR)$(BINDIR)/timerlat
 
+.PHONY: tags
+tags:
+	$(CTAGS) -R --extras=+f --c-kinds=+p src
+
+.PHONY: TAGS
+TAGS:
+	$(ETAGS) -R --extras=+f --c-kinds=+p src
+
+.PHONY: tags_clean
+tags_clean:
+	$(RM) tags TAGS
+
 .PHONY: doc doc_clean doc_install
 doc:
 	$(MAKE) -C $(DOCSRC)
@@ -57,8 +71,7 @@ doc_clean:
 doc_install:
 	$(MAKE) -C $(DOCSRC) install
 
-# This section is neesary for the tarball, when the tarball
-# support is removed, we can delete these entries.
+# This section is necessary to make the rtla tarball
 NAME		:= rtla
 DIRS		:= src
 FILES		:= Makefile README.txt
-- 
2.47.2



