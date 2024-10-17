Return-Path: <linux-kernel+bounces-369930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0A9A2494
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BEC1F27531
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849461DE8AF;
	Thu, 17 Oct 2024 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNhtxnpa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9B1DE886
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174192; cv=none; b=X1L7KwVMnu/Tml28/3H/r4EbJK7qmqAX04OYSAQONXzR3VVkP0m96BMog0c5khCMrq9g9nYEqdtJn5XhTFTkgcfr3GY4Q+QgrjPANxKwVKOXDyaJLZaHw1dHmW3Or4KpnlPmHido/1VHGNIkrzeAV1XzYYWSuEXV7FWQdYA0q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174192; c=relaxed/simple;
	bh=fpsNDktc14b0ckCvAotPLv4nVyh12AovWbsyvyfgFUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCfPvzYcfhwaCd2x+Y90ghUxUHnZ3OF18ZIQn0jW7lXmq7Y6u35kpL3HmrLy7iHifD7jkoH6H+IcplMkb2U0zQE9o70FImRmDjnWvPeLQgfVBeE4l0ykU9ENqEDpYYZT9Hs7UY5nIQKD8P2BEJHQN6xfEolrBOP8cqUwIFxIJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNhtxnpa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729174189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDLRixScWQpZ2c7FxI8xmtz7xuGPROsFYkm7uQJOZys=;
	b=CNhtxnpaTiHzEq13kBQEixuHnvdOOfjEAoPNH05hiyZoSH1mM8YLL1llChNm9rR77jdhS6
	ldm/tAvqTAGRufd5u2rbtHljE6AevF3xNOtoromEC67z708aOKI+2BaAI6Eyzz3oWsHhE0
	j8CWsX38moCPnINF2eOkxcB3UESWT5I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-7tg85OZ6N8WAZDdgQnaDBA-1; Thu,
 17 Oct 2024 10:09:46 -0400
X-MC-Unique: 7tg85OZ6N8WAZDdgQnaDBA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 730331956096;
	Thu, 17 Oct 2024 14:09:45 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB03E19560AD;
	Thu, 17 Oct 2024 14:09:43 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v5 2/6] rtla: Add optional dependency on libcpupower
Date: Thu, 17 Oct 2024 16:09:10 +0200
Message-ID: <20241017140914.3200454-3-tglozar@redhat.com>
In-Reply-To: <20241017140914.3200454-1-tglozar@redhat.com>
References: <20241017140914.3200454-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

If libcpupower is present, set HAVE_LIBCPUPOWER_SUPPORT macro to allow
features depending on libcpupower in rtla.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile        |  2 ++
 tools/tracing/rtla/Makefile.config | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index b5878be36125..a6a7dee16622 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -32,8 +32,10 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
+FEATURE_TESTS	+= libcpupower
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
+FEATURE_DISPLAY	+= libcpupower
 
 ifeq ($(V),1)
   Q		=
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f8c286712d4..92a6e12e42d3 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -43,6 +43,16 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+$(call feature_check,libcpupower)
+ifeq ($(feature-libcpupower), 1)
+  $(call detected,CONFIG_LIBCPUPOWER)
+  CFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+  EXTLIBS += -lcpupower
+else
+  $(info libcpupower is missing, building without --deepest-idle-state support.)
+  $(info Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.47.0


