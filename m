Return-Path: <linux-kernel+bounces-437837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D69E9958
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04764282E52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E911B425B;
	Mon,  9 Dec 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgIwddtD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF91E9B2F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755678; cv=none; b=AO0m/b1mazPKk6SQLtabxN9uJqbbWixkLj8ZjrqgjWQwefhTr7O/H6DQRj7B1BseV7iSHX974vdxkShiD6OTD2BvBVljTjJbNFYkBs6vl80rb93tRn92VGzDRW8JoUlLC9H7Xy8GZOIlDHpT7KIwJlKBoej8kCPjN8ZeMZ1Hqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755678; c=relaxed/simple;
	bh=bQAv1UxQssB3tMoCrEaPaH8YhrV81zDOO65SEhBhWbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=f3pDrmD5Wygl0NYY5K87NcpiuLvojgDfYPepVIvyZNOguepkOWu4BQSfi8IpS++p+qru9BCO2g77C/G73D1ciu9ECSdJSfP7RY55y8SoHX8XytqK7f2uIuPas8X6G/GG3qTJz3UdOsVxb+vF9WUW+qj7TSrQOfV05tmbF+nkQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgIwddtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CKW1cKzOvQu3PHZh9xUbsjiPM1Bs37pILAwq3THS0w=;
	b=RgIwddtDutg+Q0EGqbK8ZQIl/28rLwf7o4CE3VylXYuVH4cu4Vil2Arm9xCq5MHVuvhvqn
	PiRaqnQLqwK37cyAxa/X7V4FcUGk4C0IYOwU5SNIRaNGq2vTSSgv6q1T5roBxVh1cSxtd/
	HGtpP2uATf5gWdM8/BJRPNO6VHi3LpQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-aedGucq1PdC4i2Yg68nA4w-1; Mon,
 09 Dec 2024 09:47:52 -0500
X-MC-Unique: aedGucq1PdC4i2Yg68nA4w-1
X-Mimecast-MFC-AGG-ID: aedGucq1PdC4i2Yg68nA4w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30911956052;
	Mon,  9 Dec 2024 14:47:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48068195608A;
	Mon,  9 Dec 2024 14:47:45 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v2 4/5] tools: ynl: add install target for specs and docs
Date: Mon,  9 Dec 2024 15:47:16 +0100
Message-ID: <0271f19ad8f5453d2fea5b0f05648b9c2667d771.1733755068.git.jstancek@redhat.com>
In-Reply-To: <cover.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Generate docs using ynl_gen_rst and add install target for
both specs and generates rst files.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/.gitignore |  1 +
 tools/net/ynl/generated/Makefile   | 34 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generated/.gitignore
index ade488626d26..859a6fb446e1 100644
--- a/tools/net/ynl/generated/.gitignore
+++ b/tools/net/ynl/generated/.gitignore
@@ -1,2 +1,3 @@
 *-user.c
 *-user.h
+*.rst
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 00af721b1571..d28509ac0573 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -7,12 +7,18 @@ ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
 
+INSTALL	    ?= install
+prefix      ?= /usr
+datarootdir ?= $(prefix)/share
+docdir      ?= $(datarootdir)/doc
+
 include ../Makefile.deps
 
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
 TOOL:=../pyynl/ynl_gen_c.py
+TOOL_RST:=../pyynl/ynl_gen_rst.py
 
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
@@ -22,7 +28,11 @@ SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
 
-all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
+SPECS_PATHS=$(wildcard ../../../../Documentation/netlink/specs/*.yaml)
+SPECS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${SPECS_PATHS})
+RSTS=$(patsubst %,%.rst,${SPECS})
+
+all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
 
 protos.a: $(OBJS)
 	@echo -e "\tAR $@"
@@ -40,8 +50,12 @@ protos.a: $(OBJS)
 	@echo -e "\tCC $@"
 	@$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
 
+%.rst: ../../../../Documentation/netlink/specs/%.yaml $(TOOL2)
+	@echo -e "\tGEN_RST $@"
+	@$(TOOL_RST) -o $@ -i $<
+
 clean:
-	rm -f *.o
+	rm -f *.o *.rst
 
 distclean: clean
 	rm -f *.c *.h *.a
@@ -49,5 +63,19 @@ distclean: clean
 regen:
 	@../ynl-regen.sh
 
-.PHONY: all clean distclean regen
+install-rsts:
+	@echo -e "\tINSTALL generated docs"
+	@$(INSTALL) -d $(DESTDIR)$(docdir)/ynl
+	@$(INSTALL) -m 0644 $(RSTS) $(DESTDIR)$(docdir)/ynl/
+
+install-specs:
+	@echo -e "\tINSTALL specs"
+	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl
+	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/*.yaml $(DESTDIR)$(datarootdir)/ynl/
+	@$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl/specs
+	@$(INSTALL) -m 0644 ../../../../Documentation/netlink/specs/*.yaml $(DESTDIR)$(datarootdir)/ynl/specs/
+
+install: install-rsts install-specs
+
+.PHONY: all clean distclean regen install
 .DEFAULT_GOAL: all
-- 
2.43.0


