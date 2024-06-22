Return-Path: <linux-kernel+bounces-225833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48E9135E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA1B21353
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D54C634;
	Sat, 22 Jun 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVzap3aP"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885722D60A;
	Sat, 22 Jun 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719085657; cv=none; b=XSSWhJe7vKJ2lojtVikuhzTdH/CMuND8GKcFY3mDH1YBugBtpi14MIfmfewAexQNxemh8Vj78sZK037ZKQBQkO4fQL8S+NG1WnK1vPwxb0snMPdFnjEDyb8EeBfPLK4F4SxlJ4GvQQ+1dX3qdqWAROpcAbJSH7k6EknmhpH9+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719085657; c=relaxed/simple;
	bh=fOJ8yCpCHplSJzF+bbNEoDHLb5LueJRYPBLaT3HxFJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz7gjW+EfOQbhSAAZeZSIkmyliwMZnIT7L/Bkylt0rjHjQgttYAzJ3bVJnwxZHTwp7aYB1tvup+tMBcpsebzEKGQDCdqcSCcqvOaZRTelFa850IxVlK/k/N4HAwtNGkup9rfmYxWHqrVOU86r4V2ddLy+UZUbJGzF/OlNoih1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVzap3aP; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c1bf0649a5so1514679eaf.3;
        Sat, 22 Jun 2024 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719085654; x=1719690454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCLncfS6P/B1enc+NAFsnswlkxaK1lwPBF8eb/PUHMU=;
        b=HVzap3aPge4910B8czvIeLHCSSgbUGgziF7gCIPBHH3wXtjQ7w/rJBuCV5bDzamY6q
         4Mq9HzLWtKNy8QjgaLimbUWd93utIEUGdFtKxKMsIk2sGBdU+oPPQbSfj8aHIFsG1u+7
         s+r39sar2qQiXdvb4amMcFoh88rrswyiH2LcnckmodxIJGmS1XGcSHIppeT7NqMn0jw/
         QCsJra0Kwxx9T/WfL4nv3J7OOBNwJjP8/Xhr6qKo94aMLUXxUsbvZPuXVQ2zAddCHRP8
         mxkYXP8rnGfgSk8T7KIblgggS4BlmRwiZNyukZAGBm3K8szg3aWEWEdwcG+mB/+uKW9l
         5RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719085654; x=1719690454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCLncfS6P/B1enc+NAFsnswlkxaK1lwPBF8eb/PUHMU=;
        b=wnd8+bW0IyDBU0eoYrhi87Qmygybur6eqYO+KQTYontU5bdCzymAwtpc7VkXO7iCcC
         MQDLaa2qfUQqpI6yddHA+w3VGzWFCKm9Abvyqo5OKRCo2UEzHHiAPB1mpGCkea7P5d3X
         3cjXDnRvqqMr99SfFDwSOv0Zv8AOMJC/OPFOzAdV0PxXq5bq0OcrIY9LXN/PaaC/s/VI
         FHbBbE4MhPfppcW9fm7GbM2HqogaKHjv/U0Pwu3x6tHiaTWIsH8G52IxNCck16a00LL2
         5xdoGDKu9iXPxYc+0OM39IoGy25Rfkb2RV+LQVXtMOZyAxsERmClY0a7kOvtP7hvjGwH
         q+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9Q92utmgFIdSihAQ1k6mObArNl3JP6U4biZU5P2azTVYF+OK3XOFqBsTeA/xOXeqCn6znjRIzm7u7pC1tvXKFFGGAkHX2Ie+lTSTdJcp5EsQLUeVbAMAQoqwBQSmVQNkgIDcKRu5
X-Gm-Message-State: AOJu0YwdzgeJekySB5WsbYD7NMwMScfqwFz55+Bf9O3GxMPLr2yvXZDa
	8iCmo5ZNJXHP/wmOdJ37uIeHBPLavAMhWXu6vULzglltrKu54ac5
X-Google-Smtp-Source: AGHT+IHYEAmkHnbpVCpj58jhVH+k2d9TGG9Wf8bF44VXPTok33mDSW71Rf9mUC8EqG9swLNTLrEozw==
X-Received: by 2002:a05:6870:1694:b0:25d:8dd:a6c3 with SMTP id 586e51a60fabf-25d08ddae29mr426408fac.2.1719085654467;
        Sat, 22 Jun 2024 12:47:34 -0700 (PDT)
Received: from pipaware.austin.rr.com ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4b80bd7sm1011209fac.42.2024.06.22.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 12:47:34 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net
Cc: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH] docs: Extend and refactor index of further kernel docs
Date: Sat, 22 Jun 2024 14:47:27 -0500
Message-ID: <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
References: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <bilbao@vt.edu>

Extend the Index of Further Kernel Documentation by adding entries for the
Rust for Linux website, the Linux Foundation's YouTube channel, and notes
on the second edition of Billimoria's kernel programming book. Also,
perform some refactoring: format the text to 75 characters per line and
sort per-section content in chronological order of publication.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 8660493b91d0..6f3e290abd22 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -3,27 +3,27 @@
 Index of Further Kernel Documentation
 =====================================
 
-The need for a document like this one became apparent in the
-linux-kernel mailing list as the same questions, asking for pointers
-to information, appeared again and again.
+The need for a document like this one became apparent in the linux-kernel
+mailing list as the same questions, asking for pointers to information,
+appeared again and again.
 
-Fortunately, as more and more people get to GNU/Linux, more and more
-get interested in the Kernel. But reading the sources is not always
-enough. It is easy to understand the code, but miss the concepts, the
-philosophy and design decisions behind this code.
+Fortunately, as more and more people get to GNU/Linux, more and more get
+interested in the Kernel. But reading the sources is not always enough. It
+is easy to understand the code, but miss the concepts, the philosophy and
+design decisions behind this code.
 
-Unfortunately, not many documents are available for beginners to
-start. And, even if they exist, there was no "well-known" place which
-kept track of them. These lines try to cover this lack.
+Unfortunately, not many documents are available for beginners to start.
+And, even if they exist, there was no "well-known" place which kept track
+of them. These lines try to cover this lack.
 
 PLEASE, if you know any paper not listed here or write a new document,
 include a reference to it here, following the kernel's patch submission
 process. Any corrections, ideas or comments are also welcome.
 
 All documents are cataloged with the following fields: the document's
-"Title", the "Author"/s, the "URL" where they can be found, some
-"Keywords" helpful when searching for specific topics, and a brief
-"Description" of the Document.
+"Title", the "Author"/s, the "URL" where they can be found, some "Keywords"
+helpful when searching for specific topics, and a brief "Description" of
+the Document.
 
 .. note::
 
@@ -72,9 +72,29 @@ On-line docs
         programming. Lots of examples. Currently the new version is being
         actively maintained at https://github.com/sysprog21/lkmpg.
 
+    * Title: **Rust for Linux**
+
+      :Author: various
+      :URL: https://rust-for-linux.com/
+      :Date: rolling version
+      :Keywords: glossary, terms, linux-kernel.
+      :Description: From the website: "Rust for Linux is the project adding
+        support for the Rust language to the Linux kernel. This website is
+        intended as a hub of links, documentation and resources related to
+        the project".
+
 Published books
 ---------------
 
+    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
+
+      :Author: Kenneth Hess
+      :Publisher: O'Reilly Media
+      :Date: May, 2023
+      :Pages: 246
+      :ISBN: 978-1098109035
+      :Notes: System administration
+
     * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
 
       :Author: Kaiwan N Billimoria
@@ -88,9 +108,9 @@ Published books
 
       :Author: Kaiwan N Billimoria
       :Publisher: Packt Publishing Ltd
-      :Date: March, 2021
+      :Date: March, 2021 (Second Edition published in 2024)
       :Pages: 754
-      :ISBN: 978-1789953435
+      :ISBN: 978-1789953435 (Second Edition ISBN is 978-1803232225)
 
     * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
 
@@ -118,15 +138,6 @@ Published books
       :ISBN: 978-0672329463
       :Notes: Foundational book
 
-    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
-
-      :Author: Kenneth Hess
-      :Publisher: O'Reilly Media
-      :Date: May, 2023
-      :Pages: 246
-      :ISBN: 978-1098109035
-      :Notes: System administration
-
 .. _ldd3_published:
 
     * Title: **Linux Device Drivers, 3rd Edition**
@@ -201,6 +212,15 @@ Miscellaneous
       :Description: Some of the linux-kernel mailing list archivers. If
         you have a better/another one, please let me know.
 
+    * Name: **The Linux Foundation YouTube channel**
+
+      :URL: https://www.youtube.com/user/thelinuxfoundation
+      :Keywords: linux, videos, linux-foundation, youtube.
+      :Description: The Linux Foundation uploads video recordings of their
+        collaborative events, Linux conferences including LinuxCon, and
+        other original research and content related to Linux and software
+        development.
+
 -------
 
 This document was originally based on:
-- 
2.43.0


