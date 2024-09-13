Return-Path: <linux-kernel+bounces-328501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D8978502
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50AC1C22DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C414A85;
	Fri, 13 Sep 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNYqmg/V"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C80DF60;
	Fri, 13 Sep 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241910; cv=none; b=rtm44F6RK0RBHzegu/7yB4RwoCyLYXwmzeEJBhct82B+YdajO9gar/CYzYf3gwiQ3RKs8lkloTgNEGVnhFrlxkwB0Fxo2OPQY8F9lSYwWx4ayX7KIp3wjPHJSVWr/iUd5V1bu9H0H/21c/tWIE6yKuFTLv9iGmGmchqsQqid+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241910; c=relaxed/simple;
	bh=1oUBzH2Lrd/2lTjm9uW9rzeq/PFv9SuAOD4g7xOMbIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s38bjerkCbOuhn461o3oMASmcxJNSEjTNGtgSujOK4AEItIIhqm7/ULDiQDw0fbSK/h23tcEQY5d/cCZQpQAxjwnqmfW3zcmdO7lBzenP4bPVr4dg/G0ffGIG2PVnAQvEGNy5M4XuM0ciKrroQWAhA7EBtNnl7wdYawIFjO7Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNYqmg/V; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27b55c4b35eso368989fac.3;
        Fri, 13 Sep 2024 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726241908; x=1726846708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLfwHNRPQKjp8R+M0/7sXVhVRXpTNwRmME8gmf+riNs=;
        b=eNYqmg/V1INmGCtqussuO/urMFe9ELT3lxsyQo3pb4pFqUxVdblLG0OBWsAY5bTNvZ
         b71EAIaXs46AkQwnb67Zrc5oygpc3wukjjmgtPb3WZqqz218UI7eO96gm/YSTH+d8pb+
         q+TgWH0/l2n3DqIixSn3+5N2aLUkdtH91xxgmo3sWCShcFqhL5Momyg4m9vIZGD8WnMw
         Rf1bJ5ZIR/6ZSCqYy0kY9+ZNJQVsj3OQtGjM7kV07gjrB3DdhDMGb4+W2/T/LaIupX9G
         FyhNmTHBTyYKkq1RqvyLuEiS3lNqg8KULY8KYefcQ/hY0HrDjbV2/D71aZ+1LINkN1db
         9wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241908; x=1726846708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLfwHNRPQKjp8R+M0/7sXVhVRXpTNwRmME8gmf+riNs=;
        b=dGIVXXJ5cIyP3Lu5S8kpGUCUReS5gj7+OkEDdm4cbqK2OBwWXQXhIKCFfxVx53q2nt
         DQViAYMLUmD5EYKkqGSV4QKhlwnvDWqtXm6pKrL4H/oYVXPjo5oUqkauDML8cRRPlkl/
         akygvgH/DRHV6RlmjW9erMG6OrLsr9Asrc+Cu1Kp1iYzycAw2MVjmS49g3bJNTPEayFb
         Qh8sE+e17eSNtndNWKX7QfxxHk3IJLkhceKKOJOGS4GhfQauBZ1hSDIy/Em7Q+KZcf1C
         0Q8Fi/keotez2ymQ0dSQYk9bUgsZFoh85BotQ5wyyxfJLIloW5a3TD7oAFm779ruNI8p
         WP7w==
X-Forwarded-Encrypted: i=1; AJvYcCVZqsq5ubBtj6WVCMNg/cXUx98TByFKZZYuAr7FYEGjYO5x6E7CT1IrrzpBU3QZHmM0tURF/y6G66Ks@vger.kernel.org, AJvYcCWth4/qjBcmVwjLAaXc4gXUhNXld7BR+kIBvdp0nvZRy3vQATWxYsXb9acQN6C2dbvhVckCih0SB+w=@vger.kernel.org, AJvYcCXSb8bfzfAxqO98AbF8Lf2YAEjfDZ2L4F+Q1zCRVM63iR22/DKiJHF3gKVBh9/oIndAvPRY72JrDycHKsew@vger.kernel.org, AJvYcCXf1BmteCLVplCftNP8W9GIrPXUCyqBoXNm9AIbPIY14aD5wz/oum6phVexUbd8FED2bsZDRJ9daAJL5HtFfb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEJKShe5buUxUcGF1CV6+PhuekUA7VU4fI5Q2GXuWf08DJ4fd
	QybQjHvA2j8cyemkOtksm5TQMwUsHZfDMhKKntmvoP8RmK1seBJg
X-Google-Smtp-Source: AGHT+IFVVoW6JJ2gEx8dkL4ssj/046MJSupkqjqrm2dz5JDbRsSdE/E9s0lqYcl1CUam3uKpfyiFBw==
X-Received: by 2002:a05:6870:ac07:b0:27b:63fc:a2af with SMTP id 586e51a60fabf-27c68bf05f7mr1824173fac.39.1726241908090;
        Fri, 13 Sep 2024 08:38:28 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3f5356dsm3670827fac.34.2024.09.13.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:38:27 -0700 (PDT)
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
Subject: [PATCH v2] kernel-docs: Add new section for Rust learning materials
Date: Fri, 13 Sep 2024 10:38:24 -0500
Message-ID: <20240913153824.161150-1-carlos.bilbao.osdev@gmail.com>
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
resources to learn Rust. Reference it in the Rust index.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---

Changes since v1:
 - Added two more Rust blogs proposed by Dirk Behme.

---
 Documentation/process/kernel-docs.rst | 131 +++++++++++++++++++++++---
 Documentation/rust/index.rst          |   3 +
 2 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 55552ec4b043..b56c2adcb954 100644
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
 
@@ -220,6 +209,126 @@ Miscellaneous
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
2.43.5


