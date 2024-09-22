Return-Path: <linux-kernel+bounces-335189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4197E262
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2326E281143
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005341F5FE;
	Sun, 22 Sep 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nimBSNCH"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC9EEDB;
	Sun, 22 Sep 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727021057; cv=none; b=GImSk5BfjUJwh1X56RWxGch6N9OzB4i4SeKKonfgTvuO4w4yHC/YBFk/2cXoCKukBQYyNS5O/2vQgEJ996cO7I2N/SPYdcz3EicX2R240qh868YcxtXE/NNP3vounMoTT75nnzbC+E7e1Vd4t94wM0bQqDQLKs7Exwy2Ret1Y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727021057; c=relaxed/simple;
	bh=v47I497c9099S7GRuyki8vzh9uGwxmnc3vs0DCyoe/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zvp902W50sbJ/M6iCVoBGtqZsXCyTGY4jTqo2otVUY69dOq+LT07sPDdeRr7hetQG8Ayh+pFolrGA24krvRoCzyT5BLxiUpu2Dactsc2qkC65vpy1P9BeWp9BvR1n1LoN9gFc2Li5AR3mYWEeY6Blax/NuMHGKRwrFlKrFhyJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nimBSNCH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e1b35030aeso2193608eaf.3;
        Sun, 22 Sep 2024 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727021054; x=1727625854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+gNyCaAD+TOTnrO/NBqECrEAJIs7LcLi9tZJZGskPE=;
        b=nimBSNCHwtkVQupHa7LSS0eIEzNiP+sg07sXaLAQ3Sk6EYHxvuhPY9AlcTo0vS5oCv
         rgzDfLX1fxYm7V5g7tH0Y7IjgLXV9e8WZpvII7QGnxk3lHR+80qKjPPHWhTCeVwBf3WA
         7lyNS5VCK1pGjH6t60tAQSEqWvKs7nlTuMSLCEy7ZexCo6mxCPAZqmltel+YHP+oASP+
         7VkEmT4N/OW4tw4mD/qKQIn3bZNjHUzZ5RXotMvX2zepSBe8jck/R1Bf9m5p94PYRqv3
         85gFcmhdZ/UZwrRPATQ9HWiYuV6Jt447ufT02QqR0hHybMkr771BY22xPugu2DTmsgzk
         97HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727021054; x=1727625854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+gNyCaAD+TOTnrO/NBqECrEAJIs7LcLi9tZJZGskPE=;
        b=McNqLI/BuFpqPPfFadSefQV1KEb/o3Zqy84xjXqfzbodvInLq5C1QCghY4GNMCqT5y
         niMu7flZNBW0ioHPS8UmFK9JPN3pKAmu9im+vM36uysWg22lCdTpWrm45t2hjqZeFqig
         JQCWJhlEO1pf59q89yY7SZ3V7iSkpcpCxVfCitucA6a3KH6Dto7Tsh7cSI6Kbf00dNjC
         dwO+52p4eEUktJNMnylQseH2WAEjIYTluJQ1Sp1aBK15gGfMSbDlvAnX/vUpqRNqHNL7
         aSEiJLY/qXgHHy1w1x59fm43annC99bNhi3+yoaw/GNEHrMDguY1nBGFzu8mH5WBju6S
         iGcg==
X-Forwarded-Encrypted: i=1; AJvYcCUUtIWi5JsRF0Z9qSZXwF9uqaw2x+bvp/reD5tqnXFmImEGZQ+yQqsYXbysmTVnirpV+oFjrK7SS1c/Z9Eb@vger.kernel.org, AJvYcCV577LQaSeVZfPK9aAT39oNXbtm3R3fgTijozf9XWJqD/Ji3yH3s4rCInNdE58HpM+AN8OoJjKTNRA=@vger.kernel.org, AJvYcCXIC/zNHwfmPj1NVwdpaH2F6b3ryu7nW4FvEGMt2T9LM4Vuo/LWnoo///GVjZHH41dQSrSzFcnVo0BU@vger.kernel.org, AJvYcCXY2UmK/shTD85aSz+NVjQmSvfsfAlY4/PKzXfK27PKm4Cx2583ZVEOfmc0eC/qS7OgWTue7SieKSrXAM/s458=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiNv1qDkay96pbp9PzJN1pFGE7L9IaOrdr4WnmAVaRquMK1vt
	oDR5eORENZZP6p/pHHysufzAJC/jCRoGXeBHl9I9zY8C3kHz+ARL
X-Google-Smtp-Source: AGHT+IEAEakKH/ljxA/oUObGAy7miHpcONk2WzcXaRVIh3octTpny8DSbw1yQWXwtKfv82nEkGXFDw==
X-Received: by 2002:a05:6820:1628:b0:5e1:dcbc:218c with SMTP id 006d021491bc7-5e58d1b0c39mr3563032eaf.7.1727021054137;
        Sun, 22 Sep 2024 09:04:14 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389bb2dd3sm1679107a34.51.2024.09.22.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:04:13 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	ojeda@kernel.org,
	dirk.behme@de.bosch.com
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
Subject: [PATCH v3] kernel-docs: Add new section for Rust learning materials
Date: Sun, 22 Sep 2024 11:04:10 -0500
Message-ID: <20240922160411.274949-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include a new section in the Index of Further Kernel Documentation with
resources to learn Rust. Reference it in the Rust index. The resources
are a product of a survey among assistants to the conference Kangrejos'24.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
---

Changes since v2:
  - Fix wrong title and added date of LPC talks.
  - Add more resources proposed by Miguel Ojeda.
  - Add review tag of Dirk Behme.

Changes since v1:
  - Added two more Rust blogs proposed by Dirk Behme.

---
 Documentation/process/kernel-docs.rst | 163 ++++++++++++++++++++++++--
 Documentation/rust/index.rst          |   3 +
 2 files changed, 155 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 55552ec4b043..3b5b5983fea8 100644
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
 
@@ -220,6 +209,158 @@ Miscellaneous
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
+    * Title: **Learn Rust the Dangerous Way**
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
+    * Title: **Comprehensive Rust**
+
+      :Author: Android team at Google
+      :URL: https://google.github.io/comprehensive-rust/
+      :Date: Accessed Sep 13 2024
+      :Keywords: rust, blog.
+      :Description: From the website: "The course covers the full spectrum
+        of Rust, from basic syntax to advanced topics like generics and
+        error handling".
+
+    * Title: **The Embedded Rust Book**
+
+      :Author: Multiple contributors, mostly Jorge Aparicio
+      :URL: https://docs.rust-embedded.org/book/
+      :Date: Accessed Sep 13 2024
+      :Keywords: rust, blog.
+      :Description: From the website: "An introductory book about using
+        the Rust Programming Language on "Bare Metal" embedded systems,
+        such as Microcontrollers".
+
+   * Title: **Experiment: Improving the Rust Book**
+
+      :Author: Cognitive Engineering Lab at Brown University
+      :URL: https://rust-book.cs.brown.edu/
+      :Date: Accessed Sep 22 2024
+      :Keywords: rust, blog.
+      :Description: From the website: "The goal of this experiment is to
+        evaluate and improve the content of the Rust Book to help people
+        learn Rust more effectively.".
+
+   * Title: **New Rustacean** (podcast)
+
+      :Author: Chris Krycho
+      :URL: https://newrustacean.com/
+      :Date: Accessed Sep 22 2024
+      :Keywords: rust, podcast.
+      :Description: From the website: "This is a podcast about learning
+        the programming language Rust—from scratch! Apart from this spiffy
+        landing page, all the site content is built with Rust's own
+        documentation tools.".
+
+   * Title: **Opsem-team** (repository)
+
+      :Author: Operational semantics team
+      :URL: https://github.com/rust-lang/opsem-team/tree/main
+      :Date: Accessed Sep 22 2024
+      :Keywords: rust, repository.
+      :Description: From the README: "The opsem team is the successor of
+        the unsafe-code-guidelines working group and responsible for
+        answering many of the difficult questions about the semantics of
+        unsafe Rust".
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
+    * Name: **Linux Plumbers (LPC) 2024 Rust presentations**
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
2.43.5


