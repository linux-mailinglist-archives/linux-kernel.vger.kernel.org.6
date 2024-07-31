Return-Path: <linux-kernel+bounces-268714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBC942837
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1FCB2449E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD11A76D6;
	Wed, 31 Jul 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp/icNjX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A921A721B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411559; cv=none; b=Bh4fv6CdCl3NdR4KGCUZ51XP+K0veARKE2duSS3LyW5E/+cv+tT9hU40VXL9I90LLy3DP8HBsgr7UE7LkuSPzWctxLP6MtYT4e4+8pJLtKX8//w1ObuyWpvvQZOT9izHEecBEKZKX/JyKSDWBflGcdgaBuIJo8rv9zuI5HxTAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411559; c=relaxed/simple;
	bh=fFZMF3NiaRR6TpVbELAswq4kkn1Pf0ZbDbb3nw54F6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A22hFrONCItLW8+BiQYGDiz1FIaxsmohHgJoYlQM7hs+bAhnzGAV/sdqA7Qlt/vQ+UEOOjPccv8wAQ2UNPTS1itqdG984VdEhMbV/3hE4rwlUK3JA8XWLpeQ8Eow2bhQw/eMzBQojI4HT+TUZuXSL6aEzP9HLlvhq91BytHQDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cp/icNjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t8p7PLZp26QdCSQ6mdeX8yU1Tl2ZcAQTz+tPUUyqyK8=;
	b=cp/icNjXTqtWRO2WQMshfuPlR8WhPBqZIuv7swJxiQirGS4jTgwYHmbt8MhrU8B9Fkr8tv
	rquusHDyF7VgjXKHXs7RAgJrjRiutbnJJg0z/BWy0XBFlyFyvgj54MA5kHl8xZRPzdYDMs
	OeaP5iugKpI9WC3rZpO2GuQwe1qH+6o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-GIVr16sBMEq9e9XHyoVT_g-1; Wed, 31 Jul 2024 03:39:14 -0400
X-MC-Unique: GIVr16sBMEq9e9XHyoVT_g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7aa5885be3so490314466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411552; x=1723016352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8p7PLZp26QdCSQ6mdeX8yU1Tl2ZcAQTz+tPUUyqyK8=;
        b=hAdxowa/jvg2p93FoxWgWFIK9+KD2BLkgH2Lu6v1K78la25ZCik9e57bDQEH7KOqJ2
         fQfpFsbAZksoesBJVThpoQ62s3vibi8UMozV91oSfzkLLK+oFYqJh2biVL4gMUEPT1PY
         e9QhEnskqYYL3u4cZnNvikywbt4a39rJL0xGga7UwsGAGUWtfoOOx9yLfrc6ftLr82n/
         bnkrZFwTQCMrTk9pkhBmWUktgVXF5RMZhnduX4HnwqOoacGPDks8AEO3fS5x2hvU0a7I
         a7v9ed0ZTauYAhhvVbfxt1iKxrderXnsd5RZUXe9NNNrdmPwGMKFeSJriGj3lht5/NC5
         zFJg==
X-Forwarded-Encrypted: i=1; AJvYcCWTWSntF4ewVGi145++MAwaxFhR+fk7d0pwZLrVvmv7xCMKEyBwIOev7oqh/2WkI4b0CCvJ+cSn8QXBd1V8YOxL8uI7lVy9VoSK4MiW
X-Gm-Message-State: AOJu0YzcHRgIe+kL7ITJ/g2EIWZ+c0vRSo/KEr/cRu/B9dTKO4TKeVPI
	qC2OENwx0ObDaxLCCf4sAiK7GS9RDzh25N9wVMUsPm6GMSb/MQ/s/nfVYqTS8AYfQIVO82UP79E
	ijJITH9q0C+1Ao5YaZ1xHNT2U5mbPqk1kfgFlzieMTaQLiSfBTVIbi8DcBQ8O+w9/do+Rwg==
X-Received: by 2002:a17:906:6a0f:b0:a77:dafb:2bf9 with SMTP id a640c23a62f3a-a7d4017958emr935768166b.49.1722411552491;
        Wed, 31 Jul 2024 00:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtcaFjOt9xSfQUez2BWgFX52e9aHax58DcvCguPN8jHiEXgVGDi0rjSjC1wDm9eFWQJzoLUA==
X-Received: by 2002:a17:906:6a0f:b0:a77:dafb:2bf9 with SMTP id a640c23a62f3a-a7d4017958emr935766166b.49.1722411551964;
        Wed, 31 Jul 2024 00:39:11 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23704sm735377266b.3.2024.07.31.00.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:39:11 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] netfs: clean up after renaming FSCACHE_DEBUG config
Date: Wed, 31 Jul 2024 09:39:02 +0200
Message-ID: <20240731073902.69262-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fcad93360df4 ("netfs: Rename CONFIG_FSCACHE_DEBUG to
CONFIG_NETFS_DEBUG") renames the config, but introduces two issues: First,
NETFS_DEBUG mistakenly depends on the non-existing config NETFS, whereas
the actual intended config is called NETFS_SUPPORT. Second, the config
renaming misses to adjust the documentation of the functionality of this
config.

Clean up those two points.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/filesystems/caching/fscache.rst | 8 ++++----
 fs/netfs/Kconfig                              | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/caching/fscache.rst b/Documentation/filesystems/caching/fscache.rst
index a74d7b052dc1..de1f32526cc1 100644
--- a/Documentation/filesystems/caching/fscache.rst
+++ b/Documentation/filesystems/caching/fscache.rst
@@ -318,10 +318,10 @@ where the columns are:
 Debugging
 =========
 
-If CONFIG_FSCACHE_DEBUG is enabled, the FS-Cache facility can have runtime
-debugging enabled by adjusting the value in::
+If CONFIG_NETFS_DEBUG is enabled, the FS-Cache facility and NETFS support can
+have runtime debugging enabled by adjusting the value in::
 
-	/sys/module/fscache/parameters/debug
+	/sys/module/netfs/parameters/debug
 
 This is a bitmask of debugging streams to enable:
 
@@ -343,6 +343,6 @@ This is a bitmask of debugging streams to enable:
 The appropriate set of values should be OR'd together and the result written to
 the control file.  For example::
 
-	echo $((1|8|512)) >/sys/module/fscache/parameters/debug
+	echo $((1|8|512)) >/sys/module/netfs/parameters/debug
 
 will turn on all function entry debugging.
diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
index 1b78e8b65ebc..7701c037c328 100644
--- a/fs/netfs/Kconfig
+++ b/fs/netfs/Kconfig
@@ -24,7 +24,7 @@ config NETFS_STATS
 
 config NETFS_DEBUG
 	bool "Enable dynamic debugging netfslib and FS-Cache"
-	depends on NETFS
+	depends on NETFS_SUPPORT
 	help
 	  This permits debugging to be dynamically enabled in the local caching
 	  management module.  If this is set, the debugging output may be
-- 
2.45.2


