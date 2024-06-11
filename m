Return-Path: <linux-kernel+bounces-210698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C91904794
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D131F243FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FD156236;
	Tue, 11 Jun 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdJyANb6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D3155CAA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147657; cv=none; b=jc1pJoFyfOTDoPeCBR1lqAJkCVA4IXKjcnrXehxckfjV6GdigVjZ52ZjHLzxod5T4iTE+ZgAnw9RdeVq8OfdMexRtqhA+rjCXPYc3OInSYIzNZbD2lMHFliJPvQg7cUSc+RK0PLyCCF+zgDQyk/E9E/9nO7U5/mpHzRSVXGUHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147657; c=relaxed/simple;
	bh=uQQqqX3m7pbIn89WtFxaUm8ZlR7ATsRfgOQIrXwe7KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UR15YUFKf79lVLS4BSJfYp9UZ5HCWc0xgThZflF/NUNFINiYfSXAEEE0lyneEPIhAEHJP2d9yd/KaTV7ruVKYoo8IfYPevrUI0P6mw9sfHFqqsqE5yHZwydHcW+21zpX7zE73qj0m4/+2opFwgXYZv2yTnZlTD4GmeZkA8zJcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bdJyANb6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f4a5344ec7so3104775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718147655; x=1718752455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4NKRSzRUO9zxmE7CyGeus+0BBDnvcGxcOkVTXBxNh4=;
        b=bdJyANb6vHr0U24erJ5E33PvHrYqH/9Lkpadn97M0les/+2+AJV5rupy3ogUVUs6ot
         rzFgt/TkZa4FfiuNmymMEYh4Y4F/H07WBnnuSRKJVYdJtC1JGP8oUVZ2vogGgg4KceTt
         NOsbxOvnQCMhyzzoiDiLc1jqDGRPbemUzjUHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147655; x=1718752455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4NKRSzRUO9zxmE7CyGeus+0BBDnvcGxcOkVTXBxNh4=;
        b=McuKf/xumic/lJFntqFHswQwBgOCd1yKLXMjO7rt9ASyo76elFqUA3lSF2e4wcR//c
         Av2iqg9HQOdIpdp2HkHYQuLFHjvejqtUzcuj5q1AsjCjHqYSxvAoOHBj9TMX14/hX3Vy
         IvImt7XOWrjoMQqtIpeEVPanFfGHlChFIdqmBXZslfeduQoN2CAq3ZUKyjGK4mWqRA4t
         KTfnTX7TBkfWgOofeJU6nmL2RHqg2i+ZhzPeltDG2hZCF5/Xu/xD/RMxHwrXJwt1wzpt
         38MNYzWmh9U+sMVYiHf4YUxbXQx2aWLDB00bn0q15b1T01AD7jcSK/05v9/NUCt5AZSQ
         7Siw==
X-Forwarded-Encrypted: i=1; AJvYcCU/weTjPUu7seaIWBdqri6G6iXNrf1UFV0jHBuu2AszS63ToIi+ricdbAURiHH/v+igE3rOYaVr9WxykGuQQIIGTUacUDKTbXKCZ6XL
X-Gm-Message-State: AOJu0Yz7a0fvYq2ZZweKMOIdyIWHn5z9XX1Cgct/YfOIiGVkuYDJtr/6
	Qlfgp91MVrvhH26DwAzBid9G23BRaDvYEv72ufnC5A807Q33eeDDfY21IdG7/A==
X-Google-Smtp-Source: AGHT+IGdNDtP3xIWxdgEuCn8jEyOCrtFBh2iITQjh4/VkBiUCRHSlUbcVmBovHOf4FNPsfqHXh+PRA==
X-Received: by 2002:a17:902:dace:b0:1f7:126:5bb7 with SMTP id d9443c01a7336-1f83b19c2d2mr5260145ad.21.1718147655552;
        Tue, 11 Jun 2024 16:14:15 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6e1ba23c7sm85924185ad.29.2024.06.11.16.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:14:15 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Date: Tue, 11 Jun 2024 23:14:08 +0000
Message-ID: <20240611231409.3899809-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240611231409.3899809-1-jeffxu@chromium.org>
References: <20240611231409.3899809-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
and MFD_EXEC

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

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
index 000000000000..7afcc480e38f
--- /dev/null
+++ b/Documentation/userspace-api/mfd_noexec.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Introduction of non-executable mfd
+==================================
+:Author:
+    Daniel Verkamp <dverkamp@chromium.org>
+    Jeff Xu <jeffxu@chromium.org>
+
+:Contributor:
+	Aleksa Sarai <cyphar@cyphar.com>
+
+Since Linux introduced the memfd feature, memfds have always had their
+execute bit set, and the memfd_create() syscall doesn't allow setting
+it differently.
+
+However, in a secure-by-default system, such as ChromeOS, (where all
+executables should come from the rootfs, which is protected by verified
+boot), this executable nature of memfd opens a door for NoExec bypass
+and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
+process created a memfd to share the content with an external process,
+however the memfd is overwritten and used for executing arbitrary code
+and root escalation. [2] lists more VRP of this kind.
+
+On the other hand, executable memfd has its legit use: runc uses memfd’s
+seal and executable feature to copy the contents of the binary then
+execute them. For such a system, we need a solution to differentiate runc's
+use of executable memfds and an attacker's [3].
+
+To address those above:
+ - Let memfd_create() set X bit at creation time.
+ - Let memfd be sealed for modifying X bit when NX is set.
+ - Add a new pid namespace sysctl: vm.memfd_noexec to help applications in
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
+	an app doesn't want sealing, it can add F_SEAL_SEAL after creation.
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
+The sysctl allows finer control of memfd_create for old software that
+doesn't set the executable bit; for example, a container with
+vm.memfd_noexec=1 means the old software will create non-executable memfd
+by default while new software can create executable memfd by setting
+MFD_EXEC.
+
+The value of vm.memfd_noexec is passed to child namespace at creation
+time. In addition, the setting is hierarchical, i.e. during memfd_create,
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


