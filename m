Return-Path: <linux-kernel+bounces-559754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF20A5F922
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82208173F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918826869C;
	Thu, 13 Mar 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi4PQOWE"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733A1D8A0A;
	Thu, 13 Mar 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877812; cv=none; b=PpYeMG0/lEs991oyPitF8pP90Cz1zpMq2XREbmfnLMZkytULYeyEtmqcJFcpobW9UedU0zwDhk9tfH/FrWP1bg0F5rdqpgEnW8sBxPFTkjtwHGlyyIibmWHRZ4e+pTo0Rw90/NqasC03iMQgOM0Ct/TbtAx76P0r7cjx+G9oFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877812; c=relaxed/simple;
	bh=Nb7YpWYdVOV6czdPvgHKjfiOdipG3ZUYghYBZEEs5CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcRZUpF2ai3k/bk38hmd2dja0B6hjYOqqr/nHGWidX+nLNhrnVzitcElIi3B6ve6XlA+8XB0KWlE5na5WtEaH3yaQqVtUWkMcXupvYplcQLDxRJmFvH6luIqeAYRH3GaILj3q0RBMqZJGJvBWz7rqoak4xSZA6KOSw+v5fKqCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi4PQOWE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso2317141a91.0;
        Thu, 13 Mar 2025 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741877810; x=1742482610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWtsDv2PwaZIy0jH/4j4swKGRqbAqUCruCxKBmTDVu4=;
        b=Mi4PQOWEPDNiXnJ57LxtjY8zfc157OXf2UAEgsl/9dNS02MxrsF6R4+pJSJABt9QTX
         qNdZQm+paTd+qX1nuiOWDrtGvcTcudNlmj+BmCsHvM0AIa5X9S/cYp2sG4qn80DetAZK
         EI2qttI/sZxpZjnM7iygXEkTbPS6wk7IM0bX5Owt/Fp9JiLx/4EnRQhfkkoYcqSbJse1
         jmhbCFSChJYzEpQzgpy4KaJ+9yTc/WtAHrTVYHVmKzhXEaL5wWn5i2l8IZeq9MatiwTu
         G8vXrEevePC2v9sTGY5hcM8Fwh9sTkwkVCsnrYVoDrgx+fF2VProQnoG4oTKizEGPK+Q
         mL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741877810; x=1742482610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWtsDv2PwaZIy0jH/4j4swKGRqbAqUCruCxKBmTDVu4=;
        b=mczvyWdKxlES9Xfowt1MdhHijJkhp8psXutJKcw6zH523x1aWajRGGK+XC8teyZqFh
         CuqEBkuHd3fY3hiXuVmPJb5LYXWViQCfVV9104HT0JOVi/5T9IUPBW6Bw5TU02Pn/Rdl
         6498L0K5kV4XOHMJWpfZ0Wqa/ruH2HAUAFe9deZdW5sPFh57hn1k+LlDv41aZICB55Ai
         Ft5Y8IlHUx7SPbl922A+cu3ezHTYRGIeIwkmF43/SGPO6oYNjfKCKlABbpG14V5DxrxF
         noZBK9MvajzAtSsiIt4o6gGmofvBM9/PdEAVCajpkJ9ptJeDeSws6niEytwFgS9vdntl
         UE9w==
X-Forwarded-Encrypted: i=1; AJvYcCWfwXBFM3vk3PyS48dfmq1G/qoUSHqtfVemNQy9hd+Uue1jzR465a/0jaSiPv3CEnVV4vtXwzUesjo=@vger.kernel.org, AJvYcCX2fjus923hyzqtt2dhJMlKaDE5b4FDpd91c55s5hV1ZSvYZCarbpSl5csCtuHR5HR7JyeHJmhVE8BQloYp@vger.kernel.org
X-Gm-Message-State: AOJu0YyV38xQhmgnvnWnYJfYm6adhNjTAKVX7c+piunBvxl9QPFJhWP8
	GGtLe+qemhIA4Jq32BbJdFFkz95iG6CVM4K3cyVWMSJ8xnvS8vab
X-Gm-Gg: ASbGncti6Uqb9eZYMy7lfR+uoPGynC/ELKqk5Lo/VxVtsg4UbWXEErgVKC1+kUeR41j
	C4CH1HI64aKABgPf04BufipinG1BHuBQlnfCyBtpNrdTTkZqxIsa38U7gZz6XeVXglcg5OTu1aE
	mAoPkD69eYggz6dzPUQ63LhzQ+g4VXCi/zduK55JGEwofRS0tpyJYJiLuAGG0V6leeBGms++Z5v
	g9pTFHqVQbw/pVpjzfbHfgKRga9PVxzhbgBo5sPdDdwR+DSKwRlGn556crwc7YJ/ifl3in53xi7
	3Naspzf1TVji8pR9MmVFaFv8hYanUo5M4Hq+hTzB9uzj
X-Google-Smtp-Source: AGHT+IEsXM2AGZ/ve8s72f99OYq5B6SHooXsYQ7juZUlVrFe2C/oCd/JoOqrJrKuDw4eAbuhGoRmaw==
X-Received: by 2002:a05:6a20:e30b:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-1f5bd955035mr68768637.37.1741877810206;
        Thu, 13 Mar 2025 07:56:50 -0700 (PDT)
Received: from arch.lan ([103.6.150.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96e58sm1356841a12.78.2025.03.13.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:56:49 -0700 (PDT)
From: kth <kangtaeho2456@gmail.com>
To: corbet@lwn.net
Cc: willy@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kth <kangtaeho2456@gmail.com>
Subject: [PATCH v2] docs: Remove outdated highuid.rst documentation
Date: Thu, 13 Mar 2025 22:56:50 +0800
Message-ID: <20250313145650.278346-1-kangtaeho2456@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The highuid.rst document describes a transition that is outdated and no
longer relevant. Additionally, it references filesystems (ncpfs and smbfs),
which have been removed or replaced.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
---
 Documentation/admin-guide/highuid.rst | 80 ---------------------------
 Documentation/admin-guide/index.rst   |  1 -
 2 files changed, 81 deletions(-)
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
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c8af32a8f800..259d79fbeb94 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -187,7 +187,6 @@ A few hard-to-categorize and generally obsolete documents.
 .. toctree::
    :maxdepth: 1
 
-   highuid
    ldm
    unicode
 
-- 
2.48.1


