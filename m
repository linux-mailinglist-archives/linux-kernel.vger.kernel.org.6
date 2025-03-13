Return-Path: <linux-kernel+bounces-558766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9ADA5EAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440341781FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE331F91C5;
	Thu, 13 Mar 2025 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCuVx3h3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630277405A;
	Thu, 13 Mar 2025 05:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842795; cv=none; b=pTqzKNWfGYg1SRg7cONDbHqtV3dKlsMnf2nQuLs9gPjbrT10TAUs/CkvfMPIjSLHjAwg4qtpZ5eRZXAzkSrnZ1C985mohBO981jJiUlzZme5A7zgnvsPUYet5gF8SYAg+sipO5b51/UOLf1IP0Yl+yGTnLCfNFyX6Lab8JtyRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842795; c=relaxed/simple;
	bh=u0S5u9HXGDzXHLZIZ8CHvfoe7NcGoZAT0EXdNgGAg5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs57eF3cC1vw4SN24dSLcrKUh4otHQ5PkpK3lFbgTG0W3+V3ArNahy1NFoznUfmsFrjXSc1bNqlcuFNf/Yuv5yyrq4s3VdLgOwHRlM7LNbpWV23gImR5OXLMtOz6qsAK1SNUOzaz1QQwtrl7ntvsv5n/tEckb8KKAsc2UXA4PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCuVx3h3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2255003f4c6so10117895ad.0;
        Wed, 12 Mar 2025 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741842793; x=1742447593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSQC7zli3KhrVgqbzqlSM+mXSiyb9KDVfJzLF6ozD5s=;
        b=PCuVx3h3N/QLYPTRXhYiNjxMSAkFzVTQj+aef9W/fFKuwDylm9f+qB3cQyrpSMs+Zy
         HQckfmzH+oO87Tew4cttyD8lxyEt8dLmOBS6yxlIYAkQrB/BMG1ysl7ttiHJ+5kc2SjE
         4VUoPDn9MYP6XgcF9RQWG+y1Ep3bF2raj9ILlc2uEKg8ZwCUuUbJqr0L8jspUO5hnbQ8
         2l6f3p5ub42FEmx2Q5g9hH9Ql7sJpcEBz4ENo/e09RLBRegB7P9P56WDonUvsaPGHr+h
         AgVG3A1Ag9qV6c0pHZ3SOusCnthDAJt5mnoFdzP9VqHOwy6QprjmD6Gq6sMILbKNIq5i
         /NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741842793; x=1742447593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSQC7zli3KhrVgqbzqlSM+mXSiyb9KDVfJzLF6ozD5s=;
        b=uKQiaovsrK9R+V6oCcRuPcQVfdh8LYLvYMAFW1Qn1NQ8mRgVtbBMdWivApKJzMMslu
         tcDFpXJ1PD7Q3Ih87nYJhHKQB/gXCWb2PzyXO4NYbRhNJc0of+UVo3a56O4lxGyxeO3q
         SrNOYwvIwJF8t6hNsjdlPDtg7cIUL8dcJsw/MutlEqLKUEXEtJyQ+lUDVFbaEbVfNU3Z
         GRlKdMV2mZsEH73O0Ppzy/pPFqCvzsIc+XS0pNXnj4SDD6Jh44YtJ/pE2av9Y6q2uAll
         k+l/RxLbJDMj0ZgeT79y7AyJeZpIF3mNrl9Oli15tsW6UX+4Sb7eSbO/PFaSe5qsFOU0
         VU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpvYmXNFuCknTJaz16j5LRXPkAzSFCER+VVQBVJNbOVSkWoomujSYAGyqpQYjJjjGfr8r3UsGFh9S436U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNY9WkYhSQkrB9OtHVRfc9KZbMpz/aSWQK7cN15+/+7Up90Mq
	t42ndR07sfr5kZtuc/d+VM52Iflei0VyEZegPrHfV2/nwCE+xckF
X-Gm-Gg: ASbGncvGRSQj/Duuz3TRIgel1M4dN3WMrHOO22OX1hf+TEuBeRvoyknHe6PKcs0YXbz
	vnxfRUZ2br39LW51BpZubf17K4rDxHUc8q78N/vtqWsc9qfBVQqQet9qKawoLQNJxjjnNSafwD4
	UBU/TH28gDzPyNEaV1erJtNntZaW5RlLx8irAul+rv03O2VLjYXvRrsf5GkozNWAxxlfE9cHGnh
	D1kbzG9g4nynS9DcYzl3gyVNg2bjjspsYc9/YdtdBxPDGc3vUrQGYrv+myuUkNkD8voKEBebbC3
	ETom6J/159MCIePZF2XGAHxtXQaJw63Qg46FkKpiMAc+
X-Google-Smtp-Source: AGHT+IHmQvuACRq6YCisnlXOZGelL/6fASR3sO24eVS8ORIygfQrmoN8FSbxnqPPbjts7Lz8wB47wQ==
X-Received: by 2002:a05:6a00:2441:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-736eb877699mr13710027b3a.21.1741842793190;
        Wed, 12 Mar 2025 22:13:13 -0700 (PDT)
Received: from arch.lan ([103.6.150.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1ed7sm445043b3a.176.2025.03.12.22.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 22:13:12 -0700 (PDT)
From: kth <kangtaeho2456@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kth <kangtaeho2456@gmail.com>
Subject: [PATCH] docs: Remove outdated highuid.rst documentation
Date: Thu, 13 Mar 2025 13:12:52 +0800
Message-ID: <20250313051252.18471-1-kangtaeho2456@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The highuid.rst document describes a transition that is outdated and no longer relevant. Additionally, it references filesystems (ncpfs and smbfs) that have been removed or replaced.

Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
---
 Documentation/admin-guide/highuid.rst | 80 ---------------------------
 1 file changed, 80 deletions(-)
 delete mode 100644 Documentation/admin-guide/highuid.rst

diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
deleted file mode 100644
index 9239067563a1..000000000000
--- a/Documentation/admin-guide/highuid.rst
+++ /dev/null
@@ -1,80 +0,0 @@
-===================================================
-Notes on the change from 16-bit UIDs to 32-bit UIDs
-===================================================
-
-:Author: Chris Wing <wingc@umich.edu>
-:Last updated: January 11, 2000
-
-- kernel code MUST take into account __kernel_uid_t and __kernel_uid32_t
-  when communicating between user and kernel space in an ioctl or data
-  structure.
-
-- kernel code should use uid_t and gid_t in kernel-private structures and
-  code.
-
-What's left to be done for 32-bit UIDs on all Linux architectures:
-
-- Disk quotas have an interesting limitation that is not related to the
-  maximum UID/GID. They are limited by the maximum file size on the
-  underlying filesystem, because quota records are written at offsets
-  corresponding to the UID in question.
-  Further investigation is needed to see if the quota system can cope
-  properly with huge UIDs. If it can deal with 64-bit file offsets on all 
-  architectures, this should not be a problem.
-
-- Decide whether or not to keep backwards compatibility with the system
-  accounting file, or if we should break it as the comments suggest
-  (currently, the old 16-bit UID and GID are still written to disk, and
-  part of the former pad space is used to store separate 32-bit UID and
-  GID)
-
-- Need to validate that OS emulation calls the 16-bit UID
-  compatibility syscalls, if the OS being emulated used 16-bit UIDs, or
-  uses the 32-bit UID system calls properly otherwise.
-
-  This affects at least:
-
-	- iBCS on Intel
-
-	- sparc32 emulation on sparc64
-	  (need to support whatever new 32-bit UID system calls are added to
-	  sparc32)
-
-- Validate that all filesystems behave properly.
-
-  At present, 32-bit UIDs _should_ work for:
-
-	- ext2
-	- ufs
-	- isofs
-	- nfs
-	- coda
-	- udf
-
-  Ioctl() fixups have been made for:
-
-	- ncpfs
-	- smbfs
-
-  Filesystems with simple fixups to prevent 16-bit UID wraparound:
-
-	- minix
-	- sysv
-	- qnx4
-
-  Other filesystems have not been checked yet.
-
-- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in
-  all ioctl()s. Some new ioctl()s have been added with 32-bit UIDs, but
-  more are needed. (as well as new user<->kernel data structures)
-
-- The ELF core dump format only supports 16-bit UIDs on arm, i386, m68k,
-  sh, and sparc32. Fixing this is probably not that important, but would
-  require adding a new ELF section.
-
-- The ioctl()s used to control the in-kernel NFS server only support
-  16-bit UIDs on arm, i386, m68k, sh, and sparc32.
-
-- make sure that the UID mapping feature of AX25 networking works properly
-  (it should be safe because it's always used a 32-bit integer to
-  communicate between user and kernel)
-- 
2.48.1


