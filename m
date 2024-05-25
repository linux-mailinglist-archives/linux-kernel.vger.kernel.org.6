Return-Path: <linux-kernel+bounces-189371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD228CEF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EC1C20AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE594D10A;
	Sat, 25 May 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1QyG3oC"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22910B652;
	Sat, 25 May 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716645247; cv=none; b=PCLrBRP9JKwe5bi0sNKVxkebxiM0blG70frXbfw4o5Hbu8hpZZrwnUxh9/HOu4JLaoX/7MiI3Ve8o4pdy/KYFa+PhjNIcKshkktBLO5bTacQ/Eniq4XN/gd2AIZJ8+FPugWiVx6OclM0P7KFTjip2oF4mNBgSkxw+6s5+IrXnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716645247; c=relaxed/simple;
	bh=ruK3wQEwWqaODhBtOr31xJg5h5bkdQKL436XahBqOMo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NLXTn1YVUndfSGh+1bvy2uYkE8pvp1lr47cfXN/RMw++edX5eVcrgE8Vf3ZgJUpdIK6RalH5/8m7SHqLr7TPJwXDdsCmWuy2r9VCWRhigYBMfi8lgfWTj/ByocynAT79ukDczblKa5QPhwryp7UiK0dZep9KzcshiAUK4GARtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1QyG3oC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f8e18ab76fso131811a34.0;
        Sat, 25 May 2024 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716645245; x=1717250045; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng3YmWPDGEXrfzaDc1gDBUS5Ta9ALFQytwSKGz8W95I=;
        b=M1QyG3oCsrw5AQ6vb5gTwzmCQf9s7ZR0ZwjJFKR26A/m/hQT/O3v9RFE/m+MoEiBpV
         X2Dpy6XXylO9hJgSBq2t9U1jkMg1Rot8ejzRCSmu+0icEjj636OV1cQMLyRzF/84Nd5c
         mLdu/Jcfdm9wHAD2Z5m9hbPy/tguOww/snniKvMXvMDt90cgiSrZDErFTpaxmV1fxYvJ
         MBYK4+VN1cIMLCI3Xb5uO0yY8VHoEKedKdTHhG45JrWodNYz1gYMmASoIk/FaLbdndTT
         AFLZtQ1HQZ8fh/5VYcIDQTetFaBmO6LOByEAcqOJSjrvr+qoypf1jII/q+SSqiHJlCFD
         KB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716645245; x=1717250045;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ng3YmWPDGEXrfzaDc1gDBUS5Ta9ALFQytwSKGz8W95I=;
        b=JuPl/XLBBSFltAx34IpregcjDzrfyDyAxvV3dvMZUOj6KuXtpDur05AAzJyLbffInk
         Yrb+TQaD16wUWaZv8HauZ/QURkRI9kBrqCUDfp85HHiP3Z8GArLnY67gC12UVNE8opSl
         pUxZJbPghaOqsrIkuU12LgU1Gu+R22BuNzToIkoLZWRJDLVUhfi3SDowjpUUb69I/QIY
         FOk5WxvpnHbq2pL2KmofOOVna+wDLHlM+gl9f77A6P90GffHbZZfFv3TzaEa8Y1AynnB
         xSQUX+aC3kTQVeQ0OAJjpvjAxzkIFv76jauoa70HFWcbYzx1HD1ae4cJTVvcs+ZLVIeI
         wMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpcb1H0v2aYrfhDPS7p+/TCOKgxK4Ers++MH127StKSniewc/Y12Aal/LNh8vbswmab0PqnnxuUAc7pkwHnTBlYQN4Zcj77aaQdfI9
X-Gm-Message-State: AOJu0YyTrDIBJ/KrS96+43YD9cptfluuX6UquA2zsmLfpuET23nnww/7
	vvMOmc9vvzd6ouo7T2BpM4+5JNDZZ7N64PAe3PPcOsVFzMsaNtwo
X-Google-Smtp-Source: AGHT+IGxirhhSZbiBNASwpswudlkUSWqwA/2U9s936TfXxExMC4IVFdBsMFaeiWypCDwTcs+MgBr3Q==
X-Received: by 2002:a05:6830:1b66:b0:6f0:ad78:1b75 with SMTP id 46e09a7af769-6f8d0a86ccemr5407477a34.22.1716645244977;
        Sat, 25 May 2024 06:54:04 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0e7fef7sm757413a34.77.2024.05.25.06.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 06:54:04 -0700 (PDT)
Message-ID: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
Date: Sat, 25 May 2024 08:54:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH] docs: Extend and refactor index of further kernel docs
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
 
+    * Title: **Practical Linux System Administration: A Guide to
Installation, Configuration, and Management, 1st Edition**
+
+      :Author: Kenneth Hess
+      :Publisher: O'Reilly Media
+      :Date: May, 2023
+      :Pages: 246
+      :ISBN: 978-1098109035
+      :Notes: System administration
+
     * Title: **Linux Kernel Debugging: Leverage proven tools and advanced
techniques to effectively debug Linux kernels and kernel modules**
 
       :Author: Kaiwan N Billimoria
@@ -88,9 +108,9 @@ Published books
 
       :Author: Kaiwan N Billimoria
       :Publisher: Packt Publishing Ltd
-      :Date: March, 2021
+      :Date: March, 2021 (Second Edition published in 2024)
       :Pages: 754
-      :ISBN: 978-1789953435
+      :ISBN: 978-1789953435 (Second Edition ISBN is 978-1803232225)
 
     * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and
Kernel Synchronization: Create user-kernel interfaces, work with peripheral
I/O, and handle hardware interrupts**
 
@@ -118,15 +138,6 @@ Published books
       :ISBN: 978-0672329463
       :Notes: Foundational book
 
-    * Title: **Practical Linux System Administration: A Guide to
Installation, Configuration, and Management, 1st Edition**
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


