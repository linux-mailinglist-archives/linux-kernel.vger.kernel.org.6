Return-Path: <linux-kernel+bounces-350467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D413F990599
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE431F212D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E90215F64;
	Fri,  4 Oct 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+KUJA/r"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976E2141A6;
	Fri,  4 Oct 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051125; cv=none; b=kBHxeaJXFYWm3bkmFBhpHBDlm3MvjyZ0GvN7qQmOI+Orz3LpGCPL5nwtMCxXCb9xz+TOyqETVxPS6ao5RrwEHRbIhiSKC8EW1XOoMkaYsJs9HF67TBmtNzUheHTu+n2/EeMg+1erIrdP8yiaeMZng88YpFNAIAA7V6gGFTW/33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051125; c=relaxed/simple;
	bh=JdjbWCNs9HSDwNomcMZLr1gtlmkTXlP0362CHD3PlNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxaINnGr9+a/+V41a6BYhK5LpbwH8JN/69shtMGMNeSIOx1fqwMw29UNZjmP8oFCz8MZEpXYhsU7eRmw0peqk66SsGQmofc2D7tm6FSYg9w8uFvOGEIjLwBunCzlEigcoqp/jjyHTLwZEd74f0Y8TMVC3O1Moj8CfwjD3GuMBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+KUJA/r; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7179069d029so1697574b3a.2;
        Fri, 04 Oct 2024 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051124; x=1728655924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmn1BFNwXGqOl6+56extfgMvomg8Ok9tR9eOonSIN9M=;
        b=C+KUJA/rTSZ5FNALqZMLBjhIVCZNdABLvMKvYQcXmjN7G95bukWLoc3xTUJnQAsK/1
         Aonb1A0IngABeM7/Mmo4PvzWCz7us3z3nbQm0KKt7l++8qM+BYq5EkDQXg4YJVJeZ0K9
         g+k54/z2re8UoE2/UO0uOuWVyS7oIPV29iWlX6FzBDxmJhXX8z1dHFa/3Bi3xMe5Awjw
         mezzc71HXDZKq2F1qZpiiEEUEq+UwlhJeVJzTs6vgVtyEKX/0SM7mf/7N78iM4u0YKki
         f89aIHvnCqlLzPugwIfuYIeJH650P/C9w0MMqIP5OA88IxBJfOct8SfWPkZKcwZVJDRW
         ycvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051124; x=1728655924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmn1BFNwXGqOl6+56extfgMvomg8Ok9tR9eOonSIN9M=;
        b=g4lM/Ly5sLQ8kHUYexu9ET9dVgAQuYRbU+nt8YoznhoENAEfwDXY3rtw3SEp8IrNtU
         2ORlPDUhZeAbLmeiv2IQYPFjl9I7suB71M2iMjGhKQrVz4q1JSc4FA46HNDJhuqNUqtv
         POyF/MV6iTtnaH3oWhzHW3eElmq2scC+KzRg6YOWjEq00RykDA3efyQc10WbZ9SfWqeg
         kGMZZa3Lc0npAZf0zuN+Nw4teJ68cMO9mgVaJwtX9R6XFOlVKBtuf83EVFvPuYcNEW3Q
         FxQCNAMGTC43y8H6uiZ2fL1jcND1orvndL3gwXNuQlcDabK+8I1VvQbb0zZDyQIFbEXU
         QbPA==
X-Forwarded-Encrypted: i=1; AJvYcCVPIGYTSC4NvAMgnU7NhD096hvdP2EOQumK/dkIm0Nuy0ZIran/0fgzNqvEPBN241wg4nPBY3HZp5gulqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdt4D81eqhegwCBQJn7ECQhWGxREallRaRdh0T7R0RlVGTTRDu
	3LDxgp08vfPsbzk6iS0SoRASZve+AB/KeeGlmLhtMoB+HNS8D6XglZJt0C/J
X-Google-Smtp-Source: AGHT+IEzp/k9I9VGTFTkiRnfgVGk6LxfpPJFvf1uBXP5lRhL4c7kf8ATnE2ic1+eSy7lqfbTFrEtsA==
X-Received: by 2002:a05:6a00:3d14:b0:717:88b6:6b1e with SMTP id d2e1a72fcca58-71de244c676mr4194040b3a.18.1728051123622;
        Fri, 04 Oct 2024 07:12:03 -0700 (PDT)
Received: from vishnu-pc ([117.252.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71de5b8af77sm1361640b3a.15.2024.10.04.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:12:03 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH] docs: update sysfs docs
Date: Fri,  4 Oct 2024 19:43:04 +0530
Message-ID: <20241004141303.46592-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update sysfs docs with documentation for all the subdirectories

Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
---
 Documentation/filesystems/sysfs.rst | 57 ++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index c32993bc83c7..b455ab32aacc 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -302,43 +302,64 @@ The top level sysfs directory looks like::
     net/
     power/
 
-devices/ contains a filesystem representation of the device tree. It maps
-directly to the internal kernel device tree, which is a hierarchy of
-struct device.
+block/ contains subdirectories for each block device that has been
+discovered in the system. In each block device's directory are attributes
+that describe many things, including the size of the device and the
+dev_t number that it maps to.
 
 bus/ contains flat directory layout of the various bus types in the
 kernel. Each bus's directory contains two subdirectories::
 
-	devices/
-	drivers/
+	bus/devices/
+	bus/drivers/
 
-devices/ contains symlinks for each device discovered in the system
-that point to the device's directory under root/.
+        bus/devices/ contains symlinks for each device discovered in the system
+        that point to the device's directory under root/.
 
-drivers/ contains a directory for each device driver that is loaded
-for devices on that particular bus (this assumes that drivers do not
-span multiple bus types).
+        bus/drivers/ contains a directory for each device driver that is loaded
+        for devices on that particular bus (this assumes that drivers do not
+        span multiple bus types).
+
+class/ contains representations of every device class that is registered
+with the kernel. A device class describes a functional type of device.
+Each device class contains subdirectories for each class object that has
+been allocated and registered with that device class. For most of class
+device objects, their directories contain symbolic links to the device
+and driver directories that are associated with that class object.
+
+dev/ contains two directories: char/ and block/. Inside these two
+directories there are symlinks named <major>:<minor>.  These symlinks
+point to the sysfs directory for the given device.  /sys/dev provides a
+quick way to lookup the sysfs interface for a device from the result of
+
+devices/ contains a filesystem representation of the device tree. It maps
+directly to the internal kernel device tree, which is a hierarchy of
+struct device.
+
+firmware/ contains interfaces for viewing and manipulating firmware
+specific objects and attributes. Here, firmware refers to the
+platform-specific code that is executed on system power-on.
 
 fs/ contains a directory for some filesystems.  Currently each
 filesystem wanting to export attributes must create its own hierarchy
 below fs/ (see ./fuse.rst for an example).
 
+hypervisor/ is the mount point for hypervisor file systems.
+
+kernel/ contains various files and subdirectories that provide
+information about the running kernel.
+
 module/ contains parameter values and state information for all
 loaded system modules, for both builtin and loadable modules.
 
-dev/ contains two directories: char/ and block/. Inside these two
-directories there are symlinks named <major>:<minor>.  These symlinks
-point to the sysfs directory for the given device.  /sys/dev provides a
-quick way to lookup the sysfs interface for a device from the result of
-a stat(2) operation.
+net/ is the interface to the networking parts of the kernel.
+
+power/ directory represents the underused power subsystem.
 
 More information on driver-model specific features can be found in
 Documentation/driver-api/driver-model/.
 
 
-TODO: Finish this section.
-
-
 Current Interfaces
 ~~~~~~~~~~~~~~~~~~
 
-- 
2.46.2


