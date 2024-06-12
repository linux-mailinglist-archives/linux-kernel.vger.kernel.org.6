Return-Path: <linux-kernel+bounces-211719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035C9055EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862F31C2246D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F44217FAC9;
	Wed, 12 Jun 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VicfPlrA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822317FADF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204169; cv=none; b=hlprQF5FpzrWO07ZzFC1uObZrhleAmkOtHb/H/LV+ZllcLQ1JweSXDHITHULL2H/CRF86Y6QOGtIcMvNZIbBW/ZRxoPBAdyR6KAEWIlnKdv/IKMEBVGlMDfOBCx9cTIFkzqhZnmQZj+ZgACfP+2nv7MrG/xJAcvSh6IwDW/GIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204169; c=relaxed/simple;
	bh=IIcVdAqmaOW8pjieI7wldk6Uea4Gpi3604HhIUuqmbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNH2F/trPE+ARMoxmWZFCiiLXT5PRES+lMSTgYETsqUn7hYtH6eeiYyBiduKJsoMjkheseXuhpcyj+PMJ7nkGC5MqIf+Z1fvAoAyLXgmEOC8xo5e2KU3Ew+wSheTORR4L0pyQwTZaAnALYafRy0jyr+MYKiO4Lgl4GRUIIWK/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VicfPlrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJUNan0C2AlKgNFgffgh9zDoO6nSF+BoZ31Zaf+PwhE=;
	b=VicfPlrAvnW08saPlwEVeYevSAcSF91LtNzswnjYginQI/ZXno1VQR/t6SPEp0S9qaPSY8
	49cCqpMHRoJJTovLX+uSGXA4RtTWovBQaoSOsmmR8XAvEZe5GFTMPSCMqTYBBIK4GxM7yI
	1AsOX0XH39QYThB1todV87EWlVgBpj8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-DO1enfHbPo-fesQIQwjLBw-1; Wed,
 12 Jun 2024 10:56:05 -0400
X-MC-Unique: DO1enfHbPo-fesQIQwjLBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45CFF19560BE;
	Wed, 12 Jun 2024 14:56:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F19F1954AC0;
	Wed, 12 Jun 2024 14:56:01 +0000 (UTC)
From: tglozar@redhat.com
To: bristot@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/5] rtla: Documentation: Add --disable-idle-states
Date: Wed, 12 Jun 2024 16:54:39 +0200
Message-ID: <20240612145439.206990-6-tglozar@redhat.com>
In-Reply-To: <20240612145439.206990-1-tglozar@redhat.com>
References: <20240612145439.206990-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Add --disable-idle-states to manpage and mention libcpupower dependency
in README.txt.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 6 ++++++
 tools/tracing/rtla/README.txt                        | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index cef6651f1435..7429e77f95ca 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -31,6 +31,12 @@
         *cyclictest* sets this value to *0* by default, use **--dma-latency** *0* to have
         similar results.
 
+**--disable-idle-states**
+        Set the /sys/devices/system/cpu/cpu<n>/cpuidle/state*/disable files to 1 for cpus
+        that are running timerlat threads to avoid exit from idle latencies. On exit from
+        timerlat, the state*/disable setting is restored to its original value before
+        running timerlat.
+
 **-k**, **--kernel-threads**
 
         Use timerlat kernel-space threads, in contrast of **-u**.
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 4af3fd40f171..6617b9911c81 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -11,6 +11,7 @@ RTLA depends on the following libraries and tools:
 
  - libtracefs
  - libtraceevent
+ - libcpupower
 
 It also depends on python3-docutils to compile man pages.
 
@@ -26,6 +27,9 @@ For development, we suggest the following steps for compiling rtla:
   $ make
   $ sudo make install
   $ cd ..
+  $ cd $libcpupower_src
+  $ make
+  $ sudo make install
   $ cd $rtla_src
   $ make
   $ sudo make install
-- 
2.43.0


