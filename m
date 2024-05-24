Return-Path: <linux-kernel+bounces-188269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308998CDFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C91C21607
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5363770D;
	Fri, 24 May 2024 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2OAYEzM"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739938FA3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521995; cv=none; b=Xdotfy1xQYu3z+9N+DIJ1ZzepjHeYZqqNaCXdMhVnHnnm/3CKvsoRQMrU2BwxDDaLlbxKwtYzTaHzz/OVWhXRkivW59jk/LS77tJdfSZH18LP75lcUDHrW9w+LydictiAiClu1J2PolO8RF8NdVsL+JH4WcQoGdnJwcNg9/o2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521995; c=relaxed/simple;
	bh=kBlmceXG6bhkrmUXIGJbMc35HmIYYfFUgN5tK4gjObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jA4nIgJ1S11tMDGtbYFi8VtN1/PasDLMJH6XUKwsNvXZU1BIpE901+5oxFz5nSa6upBZWinTvT0PrjYHt14z7GpHOwUUIXUnA2OdjxtPfqPmi3drBF8J92+6DEL/G3ZyPXtVp9C1nzZcZJ3jLPU6lJ5HkebALoa0TdcxLasn5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g2OAYEzM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6818e31e5baso391182a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521993; x=1717126793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pesQo+6XyB9Sz7NquWrLJtfwCa+DVcXbb+XOLlmmUJA=;
        b=g2OAYEzMp38m7n8GB//ncGBNaVPGIaNaj94Nwk2AsoIuFP8PhjypIjP8fWALYCe9EI
         61YM/fzluz3imdsxA2MPJkGgBKDPoyDEi2A4+aU8L83h8iqVmENSdMOHmLI5M2dCmBpD
         fmxIiO8DLKlUIHv5UIXCSZkSJzXBSeMxNfF2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521993; x=1717126793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pesQo+6XyB9Sz7NquWrLJtfwCa+DVcXbb+XOLlmmUJA=;
        b=ccGSmgISCF8wXN/cw/vYps6xh2NbQaFonkogriwnf37SB9Vb1IMxlr++7rO9+HY59L
         lbBSjWWF2+L5SGbJwbR7/zzTgnV5IKMs3Saf8PKdXMAuiAMB59ch0nvb7OAaCay9UKMs
         CAtrgZuriXkAVJyjxnp1PK92eWdLBp7ku+doPQABXnSc/xuPBzi50YiFW2XwokGbYLRu
         5Uu2SqVGJeHmzNjx9Y5m+S9iRMi9C+OLuw1L3V/8nWtbhgQ0NBvgWIfmE9zP8BtYJLc/
         wOpRckFrD7EbMqku1jFhEj/sxnWjIyOimnueoVq/ptj6+26Ga6kt7qdT4JLrjkKTrURC
         c8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdz9ART7cSviCXUGarhgDi2OLNqCf2hsb3vDOPtn4mHvBTXQ7TzjneC6l86FqODW4jXGy5j89ttxkCxbS9RHQkrWVeS2hlbo797ngt
X-Gm-Message-State: AOJu0Yw+rwuWIuwAK74w0TPuoFEUA3C6orLN55KGZQFDRDoQkh08QSBi
	NvthwxXghtg3g5/xe866elrqb4QWxCdTVlOAuVI6ratue9zRFp/6f5PeGcXJaw==
X-Google-Smtp-Source: AGHT+IHdjBENRrBcj6qYEjj9L5n5wO1aZ+m3thRvOckQZLAGNspYj6ieCFrZ+b+e26D15nt1k6EE2w==
X-Received: by 2002:a17:90b:604:b0:2b6:c650:fb54 with SMTP id 98e67ed59e1d1-2bf5f50a0cdmr948929a91.49.1716521992881;
        Thu, 23 May 2024 20:39:52 -0700 (PDT)
Received: from localhost (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2bf5f50c450sm406666a91.17.2024.05.23.20.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:39:52 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@google.com
Cc: jeffxu@chromium.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] memfd:add MEMFD_NOEXEC_SEAL documentation
Date: Fri, 24 May 2024 03:39:31 +0000
Message-ID: <20240524033933.135049-3-jeffxu@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240524033933.135049-1-jeffxu@google.com>
References: <20240524033933.135049-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Add documentation for MFD_NOEXEC_SEAL and MFD_EXEC

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 90 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)
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
index 000000000000..6f11ad86b076
--- /dev/null
+++ b/Documentation/userspace-api/mfd_noexec.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Introduction of non executable mfd
+==================================
+:Author:
+    Daniel Verkamp <dverkamp@chromium.org>
+    Jeff Xu <jeffxu@google.com>
+
+:Contributor:
+	Aleksa Sarai <cyphar@cyphar.com>
+	Barnabás Pőcze <pobrn@protonmail.com>
+	David Rheinsberg <david@readahead.eu>
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
+	add X later.
+	This is the most common case for the application to use memfd.
+
+``MFD_EXEC``
+	When MFD_EXEC bit is set in the ``flags``, memfd is created with X.
+
+Note:
+	``MFD_NOEXEC_SEAL`` and ``MFD_EXEC`` doesn't change the sealable
+	characteristic of memfd, which is controlled by ``MFD_ALLOW_SEALING``.
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
+The value of memfd_noexec is passed to child namespace at creation time,
+in addition, the setting is hierarchical, i.e. during memfd_create,
+we will search from current ns to root ns and use the most restrictive
+setting.
+
+Reference:
+==========
+[1] https://crbug.com/1305267
+
+[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
+
+[3] https://lwn.net/Articles/781013/
-- 
2.45.1.288.g0e0cd299f1-goog


