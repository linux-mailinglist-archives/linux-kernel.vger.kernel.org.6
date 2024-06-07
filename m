Return-Path: <linux-kernel+bounces-206728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF3900D13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FE01F27348
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B1154BE4;
	Fri,  7 Jun 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftj7s3hf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8514F9CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792558; cv=none; b=BrB1Y3vr9QDHFPdFiqrpRUb2CJZb3wBsikWr67QqSa9U9oCwaV9k20Gv2E10oviyh6BNgjHFPMFEVi9jsEnSpuquptg0ytpT97tbYPL5JB+p9oaSzbesMrJ1kAAQfgButWOjW0ARpe6VXUfyI/gkZyVlm7udDquRyAnOED8cjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792558; c=relaxed/simple;
	bh=g6CX1AvKNa0Ad5jlGLH1uQ8N6quEUKwY01IZWX3Kczo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU/3PXSwkXUIRh88jth9HEBvTPqNdVJoDZDwLmFPhenzpvboNAP7ldPADbiuxZyrg3jX/PISnsNcj03T8Pti1DO96iPBiwAHiaeDBoYeMENSCcL/0KFsFjuZMNnRapnfjpoeG0jUayx4ac4bu+my0qbWI+LzXJJnd/kkDIp+eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftj7s3hf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d10so23968845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717792556; x=1718397356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oXWJ5Wemf0IINqz67lVh3TgdBP0Qd9snz/STsYYB+I=;
        b=ftj7s3hfA85GTj0475K0nRtrNghdGXdns5BTKw618i5koK3qmf/rmT5lksG5EkThgI
         LAd2OMcqWGLw5fn3gVT0o9Rgz4iZvKM0xnpdT4y+44OVwzIqI9qNKJ8ILqWcRktdS3K5
         Es7HAbOGFl6xphRdwo82KggtazMTzJSSwALtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792556; x=1718397356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oXWJ5Wemf0IINqz67lVh3TgdBP0Qd9snz/STsYYB+I=;
        b=Sl33rz4u8WihJy2Gf91sieNM9cBk1iMfG1M4j1x9ZCXeQrXLK00m9EP9h4gP74ZYlr
         A8c9aPpmlp7oaE1CgxfTpQgYtn6pK/kPQoNcEglN55jq534MapH5E72u+E4D7amoa3tY
         Fp+V3V9MW8qp5CFaLz66ZR5dJttcaIBpQcCUzprEFKz04XHqOZ1Olj+T3xrzs64gGkGQ
         yfMvOJvUGlcXIKJGJ1IzIqUHR1ZaWVOtyZCjKrx0Mc0x/ivY6MNhRVd+ZcelK5gJlXlJ
         PX8IQb2oeKKy3gIoj7htcju15Cb7k63VLmk/9CzNkiKMlgHRsFVwOOxTuTac0UgMJGKf
         l7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyy8V6e5CV4OXSjoacPdo3F9+XOZO1F90BXiwvsCU99poeccRnym6xfXJAtZq5kVX/WSazbLq36wZwMzY5JArVXiIEuu2gt+uD/2v1
X-Gm-Message-State: AOJu0YzA0daEBlFgzCyf6M2Zejd4oaRaCv9GOqE/6oV2CM9qlnNZ3pL2
	qU3UFqezolbAn+tXYvZkYWrJlfIerKDBP8B0jZPJiGq4kXbFsB1MXnrJTtzeqg==
X-Google-Smtp-Source: AGHT+IFnrQY/Ai8Uk6udhcAWbv2t7ZCDY3TRPvTN4XQwhL+Rwb7V0TBa2XUWwrA1IeeDyrYAYKBOgQ==
X-Received: by 2002:a17:902:c94f:b0:1f6:8a19:4562 with SMTP id d9443c01a7336-1f6dfc426d6mr25813685ad.24.1717792555893;
        Fri, 07 Jun 2024 13:35:55 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6bd7ccfd3sm38538225ad.132.2024.06.07.13.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:35:55 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Date: Fri,  7 Jun 2024 20:35:41 +0000
Message-ID: <20240607203543.2151433-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607203543.2151433-1-jeffxu@google.com>
References: <20240607203543.2151433-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for memfd_create flags: FMD_NOEXEC_SEAL
and MFD_EXEC

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 5926115ec0ed..8a251d71fa6e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ Security-related interfaces
    seccomp_filter
    landlock
    lsm
+   mfd_noexec
    spec_ctrl
    tee
 
diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/userspace-api/mfd_noexec.rst
new file mode 100644
index 000000000000..0d2c840f37e1
--- /dev/null
+++ b/Documentation/userspace-api/mfd_noexec.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Introduction of non executable mfd
+==================================
+:Author:
+    Daniel Verkamp <dverkamp@chromium.org>
+    Jeff Xu <jeffxu@chromium.org>
+
+:Contributor:
+	Aleksa Sarai <cyphar@cyphar.com>
+
+Since Linux introduced the memfd feature, memfd have always had their
+execute bit set, and the memfd_create() syscall doesn't allow setting
+it differently.
+
+However, in a secure by default system, such as ChromeOS, (where all
+executables should come from the rootfs, which is protected by Verified
+boot), this executable nature of memfd opens a door for NoExec bypass
+and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
+process created a memfd to share the content with an external process,
+however the memfd is overwritten and used for executing arbitrary code
+and root escalation. [2] lists more VRP in this kind.
+
+On the other hand, executable memfd has its legit use, runc uses memfd’s
+seal and executable feature to copy the contents of the binary then
+execute them, for such system, we need a solution to differentiate runc's
+use of  executable memfds and an attacker's [3].
+
+To address those above.
+ - Let memfd_create() set X bit at creation time.
+ - Let memfd be sealed for modifying X bit when NX is set.
+ - A new pid namespace sysctl: vm.memfd_noexec to help applications to
+   migrating and enforcing non-executable MFD.
+
+User API
+========
+``int memfd_create(const char *name, unsigned int flags)``
+
+``MFD_NOEXEC_SEAL``
+	When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is created
+	with NX. F_SEAL_EXEC is set and the memfd can't be modified to
+	add X later. MFD_ALLOW_SEALING is also implied.
+	This is the most common case for the application to use memfd.
+
+``MFD_EXEC``
+	When MFD_EXEC bit is set in the ``flags``, memfd is created with X.
+
+Note:
+	``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
+	app doesn't want sealing, it can add F_SEAL_SEAL after creation.
+
+
+Sysctl:
+========
+``pid namespaced sysctl vm.memfd_noexec``
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+
+ - 0: MEMFD_NOEXEC_SCOPE_EXEC
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_EXEC was set.
+
+ - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_NOEXEC_SEAL was set.
+
+ - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
+	memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The sysctl allows finer control of memfd_create for old-software that
+doesn't set the executable bit, for example, a container with
+vm.memfd_noexec=1 means the old-software will create non-executable memfd
+by default while new-software can create executable memfd by setting
+MFD_EXEC.
+
+The value of vm.memfd_noexec is passed to child namespace at creation
+time, in addition, the setting is hierarchical, i.e. during memfd_create,
+we will search from current ns to root ns and use the most restrictive
+setting.
+
+[1] https://crbug.com/1305267
+
+[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
+
+[3] https://lwn.net/Articles/781013/
-- 
2.45.2.505.gda0bf45e8d-goog


