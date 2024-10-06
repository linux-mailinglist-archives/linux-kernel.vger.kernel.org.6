Return-Path: <linux-kernel+bounces-352655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D0992235
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 01:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E961F21569
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB518BC10;
	Sun,  6 Oct 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz1ITlQq"
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2318A936;
	Sun,  6 Oct 2024 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728255786; cv=none; b=Bly098nw9IR/mSqXbnMh7z7tgCZMO5gQWdT2vEEzCLgOYALCOXvrSGbVl0NBVUswMORqSKZz3uZS/E8+xefjB5dN1r3R0gxZKtTCepSLivpK/HBJy/oj+Pkzypj17UAFaCmvTin3+M3jp1bDCLidgr6nuwAjtt7YWH0OTsl0fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728255786; c=relaxed/simple;
	bh=AD8JgDXUleSPu87Hyv7wDXWcq1KuZUoop/qqEKl4LtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLf6xAIY3ygSyQ22rUsocd6y5PLzGzrQREzYK7BHus056viOlpVdQTRWjcGEqAQK+WAAeeK6xj08oPpcRRnp5527/yz4Z3ljIvd4a8IeU3i2HcDxH7gIBeqyYA4IM1Ki81bWHiDZzkXVgsYnDZ4BfxQt2zAcUZbOtadmYbauiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz1ITlQq; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-7a9b72749bcso333814385a.0;
        Sun, 06 Oct 2024 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728255780; x=1728860580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToAWl+r26V6mZckYwH2iuX+9zA17SvDjO0OOXTi8Ub0=;
        b=gz1ITlQq0sJLu0kEGQXOqL1iFotnGBiW//6iuoGcHOfguFsAx7+I+0+b3tdwBhi+RK
         hE5Gp9nOQCD5LknULJxuUc8+Ur68WdzKxT85Xr6ppJc6ieAr+WkwWK92r9VubUjFdND0
         a/8xjZaqd4wUgAJyzyMSuPFgZwq5U58jEDLd425D0WH+cTpjEJqk9KNBKtiIPms7bG0S
         sKLwdcJckybEUOkHIgCUi2/26f4GcfWwvXEfhXguLFBvujmTff8+xyYMvaRjkUxxgV1W
         J01ocDPtyjlhIcYLqocLiyRdE8LV1UyWpdzwjdQId5s5xx7TOPr1sATdXOWtswp4/L4b
         UnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728255780; x=1728860580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToAWl+r26V6mZckYwH2iuX+9zA17SvDjO0OOXTi8Ub0=;
        b=dTixSN6czpbfCtFezoqfj2lVyj3RTvBlLACOxgJRMT/ADeEj/Id+vahPQjCVO3eTd3
         PkHgO093gynzGjUCVvEsTEukZYxS+YA9oVkTbB0U/Knocu3XpyI9IT1fy9uOSz5z4ks1
         AXPcqai/BdTeI8etITmH46jgAkE0vZuGV9fwVTa5qloG8C+DX/tCYXxqZzc/Xe8MO9+z
         HQLdy0yI8XZ/W+kObENy1WGV4ItLT4urux0HxUET/aDfjPy7nOyqnKB3dotQqeYN6yMB
         PTdqzvllCbQ5dAlVN61+I7QZKpxNlJ/MKo2+oaC/to5MUxhjSfxrltdka5ZJgJjLsfcy
         oCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6PbOyg9Ss8KDOW2KCKQTtYwA8/KB8e33QqFOsqP1daegB+dNBOOCzJRg+mJr6xS8EZpobPrqob+TBL0g1cBo=@vger.kernel.org, AJvYcCXijwUnFMTwhiYbOhjXfSRmYhQKUA8HhSdUR50qGDkXgKgm8m2LK/gxz0ek96kh7u1jlwFCiXq04VPt2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAfWhtOeuneTJVgn/o64S5ozo250DSDCkIxX6x55RL5UHqcIW
	hl3HtVg+riSbUTfmtf8tyvTYp4BZmeAnuYIY/vkI9K9MVA6/HDlu
X-Google-Smtp-Source: AGHT+IEPk1/AfnqYbx7tIifN6X8D/5KFD9cpLu+2VwLIkC0rx17OlUsgiWO9PNZVdC9dwjTS6i7yEw==
X-Received: by 2002:a05:620a:2486:b0:7a9:cc4e:d205 with SMTP id af79cd13be357-7ae6f421d02mr1581788885a.5.1728255780268;
        Sun, 06 Oct 2024 16:03:00 -0700 (PDT)
Received: from eduroam-campus-10-36-135-174.campus-dynamic.uwaterloo.ca (wn-campus-nat-129-97-124-174.dynamic.uwaterloo.ca. [129.97.124.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75760df5sm199723585a.110.2024.10.06.16.02.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Oct 2024 16:02:59 -0700 (PDT)
From: Luna Xin <luna.xin.lx@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Luna Xin <luna.xin.lx@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: add `uapi` crate to `generate_rust_analyzer.py`
Date: Sun,  6 Oct 2024 18:59:50 -0400
Message-ID: <20241006225952.45012-1-luna.xin.lx@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the `generate_rust_analyzer.py` script to include
the `uapi` crate.

This allows a proper `rust-project.json` to be generated by the script
so that driver developers can take advantage of rust-analyzer code
completions when interfacing with `uapi`.

Signed-off-by: Luna Xin <luna.xin.lx@gmail.com>
---
 scripts/generate_rust_analyzer.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index d2bc63cde..61214fd2f 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -93,10 +93,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     )
     crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))

+    append_crate(
+        "uapi",
+        srctree / "rust"/ "uapi" / "lib.rs",
+        ["core"],
+        cfg=cfg,
+    )
+    crates[-1]["env"]["OBJTREE"] = str(objtree.resolve(True))
+
     append_crate(
         "kernel",
         srctree / "rust" / "kernel" / "lib.rs",
-        ["core", "alloc", "macros", "build_error", "bindings"],
+        ["core", "alloc", "macros", "build_error", "bindings", "uapi"],
         cfg=cfg,
     )
     crates[-1]["source"] = {

base-commit: f5e50614e39e74401b492a2fa125f2e2b6458bab
--
2.46.2

