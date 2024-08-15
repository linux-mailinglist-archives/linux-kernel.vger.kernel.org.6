Return-Path: <linux-kernel+bounces-288064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A59532A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2A32894F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED31AE023;
	Thu, 15 Aug 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQG4LRZX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7291BA863
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730772; cv=none; b=V3Gi3Z8rYXDrjohVoK5Gxzjsb/LDCeTRbvDsJXY2GtqQI/jU0uDsJT4HhjGFfzHbRaLTVB76evGyw9eYH+2c0JYIM/zTIXabJatQr7ePlmAyr9K4XnbGjXFhg6HWSIdlDWEPX3RMISsmOrOpPrnhKP8NrkOQ5KvGLpPtAAhGJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730772; c=relaxed/simple;
	bh=LHZmH05EAj7Y9ETyBCWgBqu0Nea5LocJb6DefGXeMWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiImhLbxFWKq88QQYTMt/BcLiz7x9gdye7aCwUfKZlznPoeywBVbMyOvFtz9U+8HxsMnVqhShTvc/pxuvP+F94tdTFm7K1Wopf/L0FfoskWmDrt91+pHGEoVEQ7LBD2MoL/3mw3kCdSiCeu57cHPYwqkIZWvdDF3vLDAXQbNIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQG4LRZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723730770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPa3fVHSDQJdbtGAB1KpSwcW42sI80d1K7oYk8zVNdk=;
	b=HQG4LRZX9UcChW4t4Exk4Ierlmmu2eEl1kjC6tovoJrwmFMLQDyeQhLrizuWpUo8VBc6dd
	FTnmZpKpX/WLQCAbi/Q70mulv7CS8cBjKb+YQOC7FcnPd667bDY4OCA0zR05ZnLJpOLhnJ
	ojImrFD/SVQhIkQRd4KXylLpyrX2Gr0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-ICX0cE92MvWTYNuTPl3s8w-1; Thu,
 15 Aug 2024 10:06:07 -0400
X-MC-Unique: ICX0cE92MvWTYNuTPl3s8w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 159E01955BED;
	Thu, 15 Aug 2024 14:06:06 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FE3F300019C;
	Thu, 15 Aug 2024 14:06:03 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3 2/6] rtla: Add optional dependency on libcpupower
Date: Thu, 15 Aug 2024 16:05:05 +0200
Message-ID: <20240815140509.12468-3-tglozar@redhat.com>
In-Reply-To: <20240815140509.12468-1-tglozar@redhat.com>
References: <20240815140509.12468-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 0b7ecfb30d19..5f6f537c9728 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -42,6 +42,16 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+$(call feature_check,libcpupower)
+ifeq ($(feature-libcpupower), 1)
+  $(call detected,CONFIG_LIBCPUPOWER)
+  $(call lib_setup,cpupower)
+  CFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+else
+  $(info libcpupower is missing, building without --deepest-idle-state support.)
+  $(info Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.46.0


