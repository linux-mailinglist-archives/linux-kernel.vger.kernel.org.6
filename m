Return-Path: <linux-kernel+bounces-197904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B98D708D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370611F2147D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607815253B;
	Sat,  1 Jun 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVHiqqGe"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0D15252E;
	Sat,  1 Jun 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254196; cv=none; b=KBhoy/bOdv8E9Qo00/6Bpexj5KY4lwU+Ya++8EqLezO8VE5jwxiBDowEnHdqcNTZeNpU8vHzfAOrRDCA7CQe27Z8i+HBC5Giw/MuzmsWH3VCJJaMtuWOgo3BevW5mxMLAWgnqjZWONKqWE9p2kk3ZJrHjYPBrnY2GzppFmslMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254196; c=relaxed/simple;
	bh=KLwdFDWoiBNLrDlb6jDOXX3QO4rfSWw4/hRf8ofFSgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1tf45KblT9NFz1Cvnp+amdnIPfSCl7rNffwO5y9WyieTClK23y2Ge7wQLNhy7JIXuX2dkmCz1gVF3RS6p1nV06DKwKo23AdGCYpCc0KgW0KjCdwodd016wgFguCb10fg4hmQ2gnv8Txb/6qJ4TBmhPLNebc6XQhykrbPq7F+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVHiqqGe; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b9706c84e5so1818687eaf.1;
        Sat, 01 Jun 2024 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717254193; x=1717858993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH6qSbeOIforRd3zhbUXZJKoVlYrK0Q+h1ZY9PtU0gI=;
        b=jVHiqqGe+QtfFt1JAFrdQ1GtfHr4bT2VAKD4oxduYxYg293qoTpc1DnNvCYkb5rz66
         GRo0xoLD0wITzIzw/C+sokWOAvFUtTV02CcA2efYDbT/cEzSRrFwFKIG1WoiiC8DQ1Q6
         rKyyvBoxzJjFkPerJUCTxbr9O5+Bx3rWXBuqjJJvaen8UICN4e/rMoMRa08gEMLZYBq1
         fjyqUkPfw8fU2tFb42VazQIsE22q/JM7540vUWsiI4NkRnzL4aNNylLS+95pK4hNiQV7
         q/yZd1SQ9ZG1g//Fg8/KJOncVg8jPBaPSfGywrZsMszRTMzLcIH6nxmJ8pq52nh+Ym7/
         LhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254193; x=1717858993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH6qSbeOIforRd3zhbUXZJKoVlYrK0Q+h1ZY9PtU0gI=;
        b=OexcJMO93IkKhXnr2CC2OkttaNOzETZVU/8pdpfyiYBJIMOff8T+Tub7HZzJ1v49TA
         VF365lzDnbR30uzv2ZUGSbjRHurGcw/3IcwrI2LlG04cR6bQPbJzWx84ecMtb6m3+r8I
         A7UdyrjoPLidPhIv9ygqFeGuAO6nD+7HFMgTaw37Ij4DbI34t3HLryg8NHDjjRCwlqNI
         Om8pFyMagFmxFKW1RevMgXouNqufeJ/Myh7idFSmNh7SdRZsSkh4wLkX93wkfApNOxqQ
         ku690U/hAsYdMnpf7iccHvvmndbV73tc1T+VSAStFDtP/OBj/ouh/feIMDAVULu8IosS
         7ypg==
X-Forwarded-Encrypted: i=1; AJvYcCXAI7QnmBIb9lM8aiWsOMvlf9+UvZOVGUtz6R4qhJNa/ll6OP6vK4qLZ6Twf6PQQPcQvdDADFrxAgHUgvz54kWhuITzKZIDtTUd/1zu
X-Gm-Message-State: AOJu0YzUGd4bbW8rfd9xiR11wuvONyzS3d9TqIY+//Kzgmf9/saxSDWc
	LvFDqLFa8pmDU+YcSMuugTWPqs3RJiEgMrXlsg/qbTRflJLk1ppLcgkcwqKY
X-Google-Smtp-Source: AGHT+IGwUO9COhBHyPVEMrDEU9y5GlsLUcH+M+riIxGJdfJz3ESoPNwHkgswnLlbOtVuBFB2pqyEkg==
X-Received: by 2002:a05:6820:1518:b0:5b3:3080:14c6 with SMTP id 006d021491bc7-5ba05df4c04mr5006857eaf.9.1717254193446;
        Sat, 01 Jun 2024 08:03:13 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba004b3d54sm844449eaf.33.2024.06.01.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 08:03:13 -0700 (PDT)
Message-ID: <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
Date: Sat, 1 Jun 2024 10:03:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] docs: Extend and refactor index of further kernel docs
To: Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <87ikyvccwc.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the Index of Further Kernel Documentation by adding entries for the
Rust for Linux website, the Linux Foundation's YouTube channel, and notes
on the second edition of Billimoria's kernel programming book. Also,
perform some refactoring: format the text to 75 characters per line and
sort per-section content in chronological order of publication.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst
b/Documentation/process/kernel-docs.rst
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
 
+    * Title: **Rust for Linux**
+
+      :Author: various
+      :URL: https://rust-for-linux.com/
+      :Date: rolling version
+      :Keywords: glossary, terms, linux-kernel.
+      :Description: From the website: "Rust for Linux is the project adding
+        support for the Rust language to the Linux kernel. This website is
+        intended as a hub of links, documentation and resources related to
+        the project".
+
 Published books
 ---------------
 
+    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
+
+      :Author: Kenneth Hess
+      :Publisher: O'Reilly Media
+      :Date: May, 2023
+      :Pages: 246
+      :ISBN: 978-1098109035
+      :Notes: System administration
+
     * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
 
       :Author: Kaiwan N Billimoria
@@ -88,9 +108,9 @@ Published books
 
       :Author: Kaiwan N Billimoria
       :Publisher: Packt Publishing Ltd
-      :Date: March, 2021
+      :Date: March, 2021 (Second Edition published in 2024)
       :Pages: 754
-      :ISBN: 978-1789953435
+      :ISBN: 978-1789953435 (Second Edition ISBN is 978-1803232225)
 
     * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
 
@@ -118,15 +138,6 @@ Published books
       :ISBN: 978-0672329463
       :Notes: Foundational book
 
-    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
-
-      :Author: Kenneth Hess
-      :Publisher: O'Reilly Media
-      :Date: May, 2023
-      :Pages: 246
-      :ISBN: 978-1098109035
-      :Notes: System administration
-
 .. _ldd3_published:
 
     * Title: **Linux Device Drivers, 3rd Edition**
@@ -201,6 +212,15 @@ Miscellaneous
       :Description: Some of the linux-kernel mailing list archivers. If
         you have a better/another one, please let me know.
 
+    * Name: **The Linux Foundation YouTube channel**
+
+      :URL: https://www.youtube.com/user/thelinuxfoundation
+      :Keywords: linux, videos, linux-foundation, youtube.
+      :Description: The Linux Foundation uploads video recordings of their
+        collaborative events, Linux conferences including LinuxCon, and
+        other original research and content related to Linux and software
+        development.
+
 -------
 
 This document was originally based on:
-- 
2.43.0


