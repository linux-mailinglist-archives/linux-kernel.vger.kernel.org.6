Return-Path: <linux-kernel+bounces-325513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A195975A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D94B24EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A991BA26A;
	Wed, 11 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfP+h2Z6"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508118C344;
	Wed, 11 Sep 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081176; cv=none; b=peZZLzdb0pa+00+f+xJOvjZN0BnThkJTk+UeC/IvwmOZc7bjgy+ZnBqqlwPnJthGkjE+qPN1uaciG3/Zg59C5fn7PQ4p/1yo8Ll0Q+forjiCSuyLSq13b/QPJGXbe/LZLDrB5vrXG+FUyPZua5Mg4yYLd0Sx1GF5gOInDVDKgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081176; c=relaxed/simple;
	bh=31fX0mqF11YiBkL12YdfveYdX1XS8aNbLaEy2k8GHMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WarIM9F4wu3BPp9il0OCc20SYxZpee8Fo1FrsXIDuqxGEcB/Y/lxlqUcwlbXG+AQsBRTbcM1PSkIXTYsFUJn0pYCSB4o50EDwf6obmFHb6GzMUsSX3ZO0hBYWUaIzqBzVK16gzo55ob4KcMHc9gq4W/MjxJigCFdx98qdilAOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfP+h2Z6; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e1cdfe241eso88563eaf.1;
        Wed, 11 Sep 2024 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726081174; x=1726685974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RSKooU1U1hQ/VIwbHIM1KYqC3Tngd/M3BbIpyV3X5N0=;
        b=bfP+h2Z6gZpQvWknNaYm7aLfuagRDbnuEleefT0ndVqSLIWX1vBiFzFf3ABiNf9b67
         +To4qgmZUpob1YMNSSznzoT45emqW8Be3aG/QK6+Imtj0yLeDqhUGLO1FjCSpIqTwTTW
         8QClxk1/FyjJlysEzd15VeWWd2PyO8U4wxGI3Ei/Dp0U1t3Ro5hv+MvBi1tb/+IGcZNj
         mGc7Gr8wIe/7Q27bGzw6fYkM/giclP9mHfVwjuedxXq7XGq7emiu3kqAwUWKpsEwnrMC
         XVE1Z6VqnBsbkakfeAlJaBQFCII5M3b8wbBy1Nb9NjUlEBFL9d7ffjmiCdo4A93s3b78
         HbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726081174; x=1726685974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSKooU1U1hQ/VIwbHIM1KYqC3Tngd/M3BbIpyV3X5N0=;
        b=r/eNA4OKFDWAUYs2f2PRuzd81vNbBG8TVS8KR1kx7BDU6RsVPBeM/NDjzEKFXTX1fs
         5nuYPPtZYK5HQn3lyDh9YLicGrA2IdEIvCLsOAX4MH7gEHDFVkTBQ3Ccf/uFfwmf0cVA
         +Uf31PigGqOrtpreN9mD0hy1K+xcsIf3W9MDRhaFYTZCAbpe7833251/kkturdUNkBcR
         xqY+usST6P2gfXIZzEGFwNr1fbbyBPt/0F4FSS5Tv/Yu9+nbXWdZojh8Tngh5sIumDLY
         S3/B25bz/4J4kSx8daXJ9+AHryHYHhGfOp+U45VVxA7c2n25ClU7K09BzPZen6EWMh5D
         p5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUuxq2UsGyRx9DF6c0LBUK7Zq3nLZZGst+e/GWY7K1XKv9XkoNg2UbMsZfgzJDacnTIgJfnkyVZQ2s=@vger.kernel.org, AJvYcCVoCThxsBp/ys9FzMmFKl7ivFJcb4yS2SVmF8/lGzDs7GOpClMUl8YX0Qu7ue8elX8MwTwR35dyGsL9@vger.kernel.org, AJvYcCVw3qqPZKjkk69deoPZmPe069QedFpNHvtIfVZAT2JVAGil9C10iSE597hYRRtqpkRu/frWeyqSJDQe28Yu@vger.kernel.org, AJvYcCWHKva5JcISt2QuxSeFGJhx2SfJ5eJK0GfX5V9CkxWCFAOXSwAN6F1OL15C+9QpbiqgSiToJTZoOCnIy+6KC5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29U6WZCmQxT19mScNPQEur9pGXBOJFj2oEoRWIt8P1+285CVl
	3SGvNUBn2I7hwbUqbe3nZX4Vznka7oXoiuwxG45yoNl/LoL2t8pU
X-Google-Smtp-Source: AGHT+IGFYrD2JsWDGvuTdxMxZqchPY23mKraBaSmrroUVisCVdQH8qxiNZMnli2UZNlAI3MPeGVniA==
X-Received: by 2002:a05:6830:3c09:b0:710:ec4a:b394 with SMTP id 46e09a7af769-7110957134cmr502026a34.29.1726081174149;
        Wed, 11 Sep 2024 11:59:34 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9db2ce0sm2440293a34.57.2024.09.11.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:59:33 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	ojeda@kernel.org
Cc: alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH] kernel-docs: Add new section for Rust learning materials
Date: Wed, 11 Sep 2024 13:59:30 -0500
Message-ID: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include a new section in the Index of Further Kernel Documentation with
resources to learn Rust. Reference it in the Rust index.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 Documentation/process/kernel-docs.rst | 111 +++++++++++++++++++++++---
 Documentation/rust/index.rst          |   3 +
 2 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 55552ec4b043..d917accd7fc3 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -72,17 +72,6 @@ On-line docs
         programming. Lots of examples. Currently the new version is being
         actively maintained at https://github.com/sysprog21/lkmpg.
 
-    * Title: **Rust for Linux**
-
-      :Author: various
-      :URL: https://rust-for-linux.com/
-      :Date: rolling version
-      :Keywords: glossary, terms, linux-kernel.
-      :Description: From the website: "Rust for Linux is the project adding
-        support for the Rust language to the Linux kernel. This website is
-        intended as a hub of links, documentation and resources related to
-        the project".
-
 Published books
 ---------------
 
@@ -220,6 +209,106 @@ Miscellaneous
         other original research and content related to Linux and software
         development.
 
+Rust
+----
+
+    * Title: **Rust for Linux**
+
+      :Author: various
+      :URL: https://rust-for-linux.com/
+      :Date: rolling version
+      :Keywords: glossary, terms, linux-kernel, rust.
+      :Description: From the website: "Rust for Linux is the project adding
+        support for the Rust language to the Linux kernel. This website is
+        intended as a hub of links, documentation and resources related to
+        the project".
+
+    * Title: **Learning Rust the Dangerous Way**
+
+      :Author: Cliff L. Biffle
+      :URL: https://cliffle.com/p/dangerust/
+      :Date: Accessed Sep 11 2024
+      :Keywords: rust, blog.
+      :Description: From the website: "LRtDW is a series of articles
+        putting Rust features in context for low-level C programmers who
+        maybe don’t have a formal CS background — the sort of people who
+        work on firmware, game engines, OS kernels, and the like.
+        Basically, people like me.". It illustrates line-by-line
+        conversions from C to Rust.
+
+    * Title: **The Rust Book**
+
+      :Author: Steve Klabnik and Carol Nichols, with contributions from the
+        Rust community
+      :URL: https://doc.rust-lang.org/book/
+      :Date: Accessed Sep 11 2024
+      :Keywords: rust, book.
+      :Description: From the website: "This book fully embraces the
+        potential of Rust to empower its users. It’s a friendly and
+        approachable text intended to help you level up not just your
+        knowledge of Rust, but also your reach and confidence as a
+        programmer in general. So dive in, get ready to learn—and welcome
+        to the Rust community!".
+
+    * Title: **Rust for the Polyglot Programmer**
+
+      :Author: Ian Jackson
+      :URL: https://www.chiark.greenend.org.uk/~ianmdlvl/rust-polyglot/index.html
+      :Date: December 2022
+      :Keywords: rust, blog, tooling.
+      :Description: From the website: "There are many guides and
+        introductions to Rust. This one is something different: it is
+        intended for the experienced programmer who already knows many
+        other programming languages. I try to be comprehensive enough to be
+        a starting point for any area of Rust, but to avoid going into too
+        much detail except where things are not as you might expect. Also
+        this guide is not entirely free of opinion, including
+        recommendations of libraries (crates), tooling, etc.".
+
+    * Title: **Fasterthanli.me**
+
+      :Author: Amos Wenger
+      :URL: https://fasterthanli.me/
+      :Date: Accessed Sep 11 2024
+      :Keywords: rust, blog, news.
+      :Description: From the website: "I make articles and videos about how
+        computers work. My content is long-form, didactic and exploratory
+        — and often an excuse to teach Rust!".
+
+    * Title: **You Can't Spell Trust Without Rust**
+
+      :Author: Alexis Beingessner
+      :URL: https://repository.library.carleton.ca/downloads/1j92g820w?locale=en
+      :Date: 2015
+      :Keywords: rust, master, thesis.
+      :Description: This thesis focuses on Rust's ownership system, which
+        ensures memory safety by controlling data manipulation and
+        lifetime, while also highlighting its limitations and comparing it
+        to similar systems in Cyclone and C++.
+
+    * Name: **Linux Plumbers (LPC) Rust presentations**
+
+      :Title: Rust microconference
+      :URL: https://lpc.events/event/18/sessions/186/#20240918
+      :Title: Rust for Linux
+      :URL: https://lpc.events/event/18/contributions/1912/
+      :Title: Journey of a C kernel engineer starting a Rust driver project
+      :URL: https://lpc.events/event/18/contributions/1911/
+      :Title: Crafting a Linux kernel scheduler that runs in user-space
+        using Rust
+      :URL: https://lpc.events/event/18/contributions/1723/
+      :Title: openHCL: A Linux and Rust based paravisor
+      :URL: https://lpc.events/event/18/contributions/1956/
+      :Keywords: rust, lpc, presentations.
+      :Description: A number of LPC talks related to Rust.
+
+    * Name: **The Rustacean Station Podcast**
+
+      :URL: https://rustacean-station.org/
+      :Keywords: rust, podcasts.
+      :Description: A community project for creating podcast content for
+        the Rust programming language.
+
 -------
 
 This document was originally based on:
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
index 46d35bd395cf..01f09216c229 100644
--- a/Documentation/rust/index.rst
+++ b/Documentation/rust/index.rst
@@ -42,6 +42,9 @@ configurations.
     arch-support
     testing
 
+You can also find learning materials for Rust in its section in
+:doc:`../process/kernel-docs`.
+
 .. only::  subproject and html
 
    Indices
-- 
2.43.0


