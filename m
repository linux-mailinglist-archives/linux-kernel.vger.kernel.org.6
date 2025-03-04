Return-Path: <linux-kernel+bounces-544393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F19A4E0DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2F33AEA80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2165E2063E0;
	Tue,  4 Mar 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VluNGuu5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FB205E34
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098203; cv=none; b=NrrfyowJUO7lXjnZ/+RnxWphPBDrs0DS7Bwj1hW8uyooOcttbMiUgQRJjgItVc+vXwJdRQUymZ7LrjyHvHQHgd8LDT4s2X6CidPdzJIH87L/Nu+jArU0BVbgUOBTyO0jB1GHtu9SLjiAy9geBxpVdPxAaCkP6GduQV4pQBgPEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098203; c=relaxed/simple;
	bh=o0nIP+iK6OAB30vRcT8cW4nyCWpwPA0CBIu37QSA3C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyOEubsiebrNNSesKnXdQsnC314KdVJ2XL7UiPuFPoHktM3grNJ++mR017Z/66M5CcK3qO0Bp+Z3dSjxqlX5CRzVIFoxLo7DJGPrgw/VCLwHoHoBtVGhrAo0FJAY5Ej37hHku3m3Q0U9Z6VRFePwrr72cErn7CCUhEngJ8L9TKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VluNGuu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741098199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8Y3blARs8HOt3v7nbGnlDEcPvZYsitdJvmKLOEigGQ=;
	b=VluNGuu50yqvSTk97jr34brkFjcX+2m2PUPcilvFzdM9WKT58WgkrqdBotLWMbeSMaEoAu
	AbEQDreuCYqkoY5k7rTygJ/SqK8YvxdmisI8UtUWFtVhqfy3vA1yh6eX9egJZGl1D0vTj3
	4Y4W+4pyMenCIW1DMquI/3inaSw9nj0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-DZRwrSqoNNSecsA6bCpr9Q-1; Tue,
 04 Mar 2025 09:23:17 -0500
X-MC-Unique: DZRwrSqoNNSecsA6bCpr9Q-1
X-Mimecast-MFC-AGG-ID: DZRwrSqoNNSecsA6bCpr9Q_1741098196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DC21190ECE0;
	Tue,  4 Mar 2025 14:23:16 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7953C180087B;
	Tue,  4 Mar 2025 14:23:14 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tools/rv: Keep user LDFLAGS in build
Date: Tue,  4 Mar 2025 15:22:28 +0100
Message-ID: <20250304142228.767658-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Fixes: 012e4e77df73 ("tools/verification: Use tools/build makefiles on rv")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.48.1


