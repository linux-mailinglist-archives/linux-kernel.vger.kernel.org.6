Return-Path: <linux-kernel+bounces-350423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4B9904F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA81C21FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F232139BF;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75E212EFF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=mJzTh0TuU/eesYulpG+AYBJBbpVNm2azzf1giVEwNTkcc3PrC5tyL/D1MeLfoj6hWgJoHIj+fpwIMINHLqLfHes2x58nv5LCZUQJk2pQZesAOQXS4tbunTz0u1RGMMZ2lK1CHcPAz5OvlF8omiDjIKAq4V0E5TaJvtkvo/yJiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=781C09YPnsjkINW3XIBNRX3vCRYJ04sGUh0a6jwoKjE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mE+b1yW87AKYaVbrXSnb7NbJjIQ6QIs5S2Kkwl6e2fez9wvRV5kyHHqxIPGYcbtzFiYUwR7n2rh9Y61A73/W/10ot+AZMBsQKiJvEL2+J0Le7rLTTy6tqZTcry7DqnKpwr2V7uGowHt0F67ta1HO2P0sz5PIpwYR2tDMK5+4d7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C16BC4CED1;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005C8a-1t6m;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135723.311401384@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:56:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 Ben Hutchings <benh@debian.org>
Subject: [for-linus][PATCH 2/8] tools/rtla: Fix installation from out-of-tree build
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ben Hutchings <benh@debian.org>

rtla now supports out-of-tree builds, but installation fails as it
still tries to install the rtla binary from the source tree.  Use the
existing macro $(RTLA) to refer to the binary.

Link: https://lore.kernel.org/ZudubuoU_JHjPZ7w@decadent.org.uk
Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla")
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile.rtla | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index 3ff0b8970896..cc1d6b615475 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -38,7 +38,7 @@ BINDIR		:= /usr/bin
 .PHONY: install
 install: doc_install
 	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDIR)
 	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
 	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
-- 
2.45.2



