Return-Path: <linux-kernel+bounces-286344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43969519DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD21F23C63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DEE1AED32;
	Wed, 14 Aug 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL+lnvOk"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3A22F11;
	Wed, 14 Aug 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635024; cv=none; b=PM2uw+lwFD/aecmUkm0UohvnML4vrHEeeytWoN7XkUTBRNJtXMVGKBvbrNtAH7/SYyCRvuzDoXBXTMkTscY8r3KCOfCr8K/rA6oKXoZRB6oLOubS/74dScydDImC6hlJRjfFMpqbH0eXP6zAe+LiM5NML1WOuUR9qLj1ywe8460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635024; c=relaxed/simple;
	bh=BBSqAm9f2OIGDmZt6NjthLLTgUmjT92nLpXGcYhp0Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Up0uSw+VB8Yv4n2NWNvoQsFuCK7CG/42q6Ytm5sHbPDXo/MauWUz8LiNU3C7+PMJtkjuIL1QAQMaDLI6g44ooUhan62py/JiuSsULqNzY0rNLgbid89CYbEokBg7Kw3RCS1nMB+ZZX7g7ogj1H8FeGAHlpGU0sQyP/m2Jihzqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL+lnvOk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c6b03c414fso28064a12.2;
        Wed, 14 Aug 2024 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723635022; x=1724239822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9phJMT8/Tbm8SJpPaswoaMV7FB484GThIWkV7xEV74Y=;
        b=EL+lnvOkQxPqHvlcoYeVsIiiS/6BpWw9p3DYcsXoPo/2KzlejkZMLrjYak18etWgCp
         BNgHLSyE6Dn9EQAzQtyhAFiyNbNEvrLGIbgQB6BYfq8izSSynHkQaPsgpD+2BQ4DiLLe
         xAoUf2icTYjCIN0dStm8Y06nY7yXbVjSNwp1dINUJ05LaWjS920Trfc5fBocl7vIvKgF
         ggJff5K60XrpjtKMiohx5d7SdbRQXL7Gz85CHjv1TWEUB/Egs0sLKYe2OwPY9gUdi25U
         6EyA/OLo8bXSrPoWsgGiwmh7SDFW0CpAbbd8FEAfuTaH8WvhNCCxdJbKAyXvmtCWVrZ/
         uvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635022; x=1724239822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9phJMT8/Tbm8SJpPaswoaMV7FB484GThIWkV7xEV74Y=;
        b=o784eza+Za+JpEJzoQ3U9hWQAlrJy1sPve4hjww9KVSn46692QpjtVX5ZFLpEKcMnh
         vwiHAIdBDkWrZmsIgLyWLacZTT6WKzV2B0mOxtpDWSq1Q8dBzk6rKpFxt9A0C1M7OQD6
         5aPy2AecUi3bHTxEnFvzDGsuIAdKvv4lCiFpnmjfqZrZ0keIo5DFFhfTlM7WhVy3i7N9
         Gwq8HC8WZ24xBU/bsUE8366ffvwz6jMRJGNoKDs7KsL8VgH9Vs0nNJO0bNTHf6b24iD9
         2UxS/qeEtG/ub97YOzaCAUKdcablKtGXW1NRLNkzOnEG8LFEqZnF683VUmuAbzdSxtwr
         wfjg==
X-Gm-Message-State: AOJu0YxGH1CIUEWwfZuUBbuKx8Sj74DyyB0dc2OHfjU15E0eW98Tm0pV
	6S1051LCNn87TqMZYWg6dOONnV2G8OoPAnbO2RciT3dan+lPdDKeUXxBExU49UY=
X-Google-Smtp-Source: AGHT+IFJ6vAedq4LBnhSQ+nIGgea569Ffr3qerfG3y9kIXM7Zw5E3lGBvrHmCFfegmmZOJmZ2PwIYw==
X-Received: by 2002:a05:6a20:9e4e:b0:1c8:d98d:6006 with SMTP id adf61e73a8af0-1c8eae4dd3cmr3086268637.4.1723635021481;
        Wed, 14 Aug 2024 04:30:21 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd1b8ee4sm27808975ad.195.2024.08.14.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:30:20 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2] Documentation: arch: Fix documentation spelling errors
Date: Wed, 14 Aug 2024 17:00:03 +0530
Message-ID: <20240814113003.14508-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit we correct some simple spelling mistakes
in the Documentation/arch directory.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 Documentation/arch/powerpc/ultravisor.rst | 2 +-
 Documentation/arch/riscv/vector.rst       | 2 +-
 Documentation/arch/x86/cpuinfo.rst        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/powerpc/ultravisor.rst b/Documentation/arch/powerpc/ultravisor.rst
index ba6b1bf1c..6d0407b2f 100644
--- a/Documentation/arch/powerpc/ultravisor.rst
+++ b/Documentation/arch/powerpc/ultravisor.rst
@@ -134,7 +134,7 @@ Hardware
 
       * PTCR and partition table entries (partition table is in secure
         memory). An attempt to write to PTCR will cause a Hypervisor
-        Emulation Assitance interrupt.
+        Emulation Assistance interrupt.
 
       * LDBAR (LD Base Address Register) and IMC (In-Memory Collection)
         non-architected registers. An attempt to write to them will cause a
diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
index 75dd88a62..e638cf9ba 100644
--- a/Documentation/arch/riscv/vector.rst
+++ b/Documentation/arch/riscv/vector.rst
@@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
 these interfaces is to give init systems a way to modify the availability of V
 for processes running under its domain. Calling these interfaces is not
 recommended in libraries routines because libraries should not override policies
-configured from the parant process. Also, users must noted that these interfaces
+configured from the parent process. Also, users must be noted that these interfaces
 are not portable to non-Linux, nor non-RISC-V environments, so it is discourage
 to use in a portable code. To get the availability of V in an ELF program,
 please read :c:macro:`COMPAT_HWCAP_ISA_V` bit of :c:macro:`ELF_HWCAP` in the
diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 8895784d4..fd7999c4a 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -12,7 +12,7 @@ represents an ill-fated attempt from long time ago to put feature flags
 in an easy to find place for userspace.
 
 However, the amount of feature flags is growing by the CPU generation,
-leading to unparseable and unwieldy /proc/cpuinfo.
+leading to unparsable and unwieldy /proc/cpuinfo.
 
 What is more, those feature flags do not even need to be in that file
 because userspace doesn't care about them - glibc et al already use
-- 
2.43.0


