Return-Path: <linux-kernel+bounces-318908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AA96F4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDC1C25468
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8C1CFEA7;
	Fri,  6 Sep 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chX/6Yrs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629741CE6F5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627670; cv=none; b=nvxm4Jp+TWi0QYiXrVwaDizAFm9O5ySHa8NijQO8fyhHYTd/pyDlYUjxqsI1oocJXu9Je7yI/R6metzjJbGtMGrAU5Hau2/DVAlhoGqHUZYAnYJQzt+Bj3rBhNSB5zLBHmmcv+FNYYJcfsyYM7m9244m7Mi4CfCjEethfBXlw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627670; c=relaxed/simple;
	bh=m8IdfLpm6dBD3gYM2Cmv0JkyJXkh7XoqGviYibjpFcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdbzFEufaqNDIxcJ6oZCVlRwefnDDeEp0ExtQ8UbCXdoRCB450/tmECphWrhSiMVM01a7cXTBwSBDJi5P+cPYtZhgW40BvyfklgLGgMST4+MXoPdBpM0K5gogqmpzF0nR8Ph0RxFoasqCFSN1ByNs+SNdk34eKK37PjiTpZ9lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chX/6Yrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725627667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CiKqAroYWdf43zkRcfKQYQltrVb+7u4tENXGnVB3T94=;
	b=chX/6Yrs34Q9+hnR1Qecc9LpdryiljwRVaxEUE05NR/Qta693EvpzSLtXF76UUBFugm3Rs
	l03EMHMDnwRxI9qX/nvcHlCtN6pDzLMi1c5uiUCMVCWRIcsJHKfrLOgpvrXn7Whcqf0D0b
	uH+z7rMBdxA9oqQOZJSpYMdtQ6t0xZY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-6cBA3GnrOFe-AlCOo2y_JQ-1; Fri, 06 Sep 2024 09:01:05 -0400
X-MC-Unique: 6cBA3GnrOFe-AlCOo2y_JQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a809183f6fso295163285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627664; x=1726232464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiKqAroYWdf43zkRcfKQYQltrVb+7u4tENXGnVB3T94=;
        b=dhUWuULHBfeh4zOTv+lR9ZDioua3tEAn9mfiC7cGK/RrCbynW4mxoYjDKC/fBh0Np0
         yGGZNnfcP8mzySArJ9L9z07rgOjVlM804oPFY4v89mwPQHrfVqcI1ARH56xwVwteluh8
         6YXnCAaGPpOxHsHFNNFVaYpSVMtQh2qvy/HCXoec5xuhNu/FV5CbAxWRBfE4NzRb8DY1
         TlqC5nx3O3s/xltEARLHuT2i2o7mrZ/V7lF0z+g8l/zeNbdr9Gg2bqci8TTMEzEYnU71
         hkraJsCeBMvqnmNrRCfB+D+D4vIXi4fnPPZimQdJ9NZEpUa2n2toJ+/F9mlwHKisrW3C
         vHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXlc1j1OgT2jCLUJHCrs94LncufCJmt8PBkyAxRMxQY1ABbRd0xi/4mylqs0CgyenOa8BHDLeHbQDMIVl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/vkdu6K9k4Cica3MO966AQTeHxI48ADNZQSgX6UgJd8N2pmW
	fwMYPvs6T5dKRCYwgKIjn04uAtpFXmxeS1sZD6j5ViQU9BIVvq9s97n3Ck2dJPHEMlvGJ0baq3V
	5rbLjsHWL/aXmUFiPWR0Bk4Ta/f56NF+DajaSJ6Q4YK2V6+lXDjUNmzGcnbO2hg==
X-Received: by 2002:a05:620a:4693:b0:7a6:5d39:39d3 with SMTP id af79cd13be357-7a9973307abmr339556585a.24.1725627663044;
        Fri, 06 Sep 2024 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZTY7wG+sUUKJ10NlP7XuB3LjDNGb/R+TOag6TwkDr3OPxHFxDGi5l6ZtOPbIEoOShkCSxg==
X-Received: by 2002:a05:620a:4693:b0:7a6:5d39:39d3 with SMTP id af79cd13be357-7a9973307abmr339553285a.24.1725627662593;
        Fri, 06 Sep 2024 06:01:02 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a15441sm15930351cf.19.2024.09.06.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:01:02 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 1/1] pm:cpupower: Add error warning when SWIG is not installed
Date: Fri,  6 Sep 2024 09:00:06 -0400
Message-ID: <20240906130010.93773-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error message to better explain to the user when SWIG and
python-config is missing from the path. Makefile was cleaned up
and unneeded elements were removed.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index d0418f902795..dc09c5b66ead 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -4,26 +4,28 @@
 # This Makefile expects you have already run the makefile for cpupower to build
 # the .o files in the lib directory for the bindings to be created.
 
-CC=gcc
-
-LIB_DIR = ../../lib
-BIND_DIR = .
-PY_INCLUDE := $(firstword $(shell python-config --includes))
-#PY_INCLUDE = $(shell python-config --includes | awk '{ print $1 }')
+CC := gcc
+HAVE_SWIG := $(shell if which swig >/dev/null 2>&1; then echo 1; else echo 0; fi)
+HAVE_PYCONFIG := $(shell if which python-config >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
+LIB_DIR := ../../lib
+PY_INCLUDE = $(firstword $(shell python-config --includes))
 OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
-OBJECTS_BIND = $(wildcard $(BIND_DIR)/*.o)
 
 all: _raw_pylibcpupower.so
 
 _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
-	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
-#	$(CC) -shared $(OBJECTS_BIND) $(OBJECTS_LIB) -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
 
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
 	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
 
 raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+ifeq ($(HAVE_SWIG),0)
+	$(error "swig was not found. Make sure you have it installed and in the PATH to generate the bindings.")
+else ifeq ($(HAVE_PYCONFIG),0)
+	$(error "python-config was not found. Make sure you have it installed and in the PATH to generate the bindings.")
+endif
 	swig -python raw_pylibcpupower.i
 
 # Will only clean the bindings folder; will not clean the actual cpupower folder
-- 
2.46.0


