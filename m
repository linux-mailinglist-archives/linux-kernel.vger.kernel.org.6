Return-Path: <linux-kernel+bounces-286281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3E95190D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B175B28185C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B71AED27;
	Wed, 14 Aug 2024 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvCiFc5Q"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4113D552;
	Wed, 14 Aug 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631805; cv=none; b=MqWCGH6VQfwCUaLxjW8oaSIWVHikxXihxoBskLtE+3n8qIh8HoLCEip905Npnb/6trLGAI6F41PBEJLA/uyFKMZtlMFK16j6BUG+3ZK1HnOwS+RhFIiNCFSxqdDH+DdOlAcVcoAcYMekcxAoOdDBJjPy0rQ7mVg8nz+vEiDqhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631805; c=relaxed/simple;
	bh=amRL91gygB4/P0TPPSgGnPoCjytd8MUXjBzW+CZiPho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpvPMCI242O2MCkCujCgrTUhdKOKOJVuvH+sfid9Na4z1+BRft6L8LuK6Jy8HfQmALWUBH243cLCBDeUrGtxqavOJC2a68yYFRJzACluQJqKJprgS0I2eEFIl1y6GeP5lNidMRaYUwb1CY7j0qyYCi+59BtSZBK/bRTSZ+25esk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvCiFc5Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fdd6d81812so64394115ad.1;
        Wed, 14 Aug 2024 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631802; x=1724236602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn7T/kg4NEOL/z2sN+LhprZZfKcDRIx+FAkUUGu9srE=;
        b=FvCiFc5Q0+etOU4xK7VCNJcYVhVrU5HvOtZLJ4kY6Kf+/Nsx5uQPkZW7Qgu45ebfQn
         9e/xRYaXGrH+j86cMesT/1UmbgCjx5gziAjqj5ksKYNnX1+8blwT/5t8C/R/rLJ/aiKw
         9cQd6BfFoZLpbmQLZQQcz4Jxa7tQMI2efCh9csLsg+eWMTayQoA/XYsikjahDshOhm5p
         RKFPhKaxr/WaUdkzW2C/TXdPer76YVOqpLyn2kg31O0gQPilUGLukUzDU/Hij4SMrmmL
         EEFbYyd1a7mi4fsfhtR/kedtWNpf+JSwyIiNtCV+EzaOkm6oxmvDdwWY+71oNqrTMxU8
         cfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631802; x=1724236602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn7T/kg4NEOL/z2sN+LhprZZfKcDRIx+FAkUUGu9srE=;
        b=LHAcZyHAGkN20TigZ1JkST8b+FueJ5MgTE8EAL0MKc1ABy4kSDi+0eV/eoBajJJJGU
         /htMxGasr0a1MC0fFK/30Z0djAqy06RIP5cNleZZTw3u0Hyzu/s5R1tnsWS6w14MeZxA
         5DESF7y8Ed80riwEa0bh1f+inlmpWm23KELydotpObvNEd5kFRRJnrnPVNIXWb2rBKjp
         TXuH8hv/2+L47SEr+gTqSIK7qdZza6iVrTtjmvCbHDwUj+xDCDtINzWQopPhS/ubsdWB
         zAxLziWo/1wMk/5/PGC73JRqoDF338q6eAGfuAFJXaF5jdzcX7x2fMsjQP5F4rDMIv2+
         QvLw==
X-Gm-Message-State: AOJu0YxNCWYI8hen1b7uZP/WLCKpD88El3x9BmqRH1OYMvUSG/eW1/LB
	nBLuiNaZCCK5OfRV/MujOmrYg6ZQsn19/dY+qBUJyqphh4sb65ptAkJW7bGV/jc=
X-Google-Smtp-Source: AGHT+IHlqL1ncolD0VQnHBB1Qt1WgiaK1o2412NyRhLDNkcwovnp20/WXPvNOWXHXmcFIcf0ht7LQQ==
X-Received: by 2002:a17:902:ea0a:b0:1fd:8f66:b070 with SMTP id d9443c01a7336-201d65c09ffmr29172775ad.57.1723631802339;
        Wed, 14 Aug 2024 03:36:42 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd1bba6bsm27159465ad.225.2024.08.14.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:36:41 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] LKMP(Bug fixing fall 2024): Fix spelling mistakes in Documentation
Date: Wed, 14 Aug 2024 16:06:19 +0530
Message-ID: <20240814103620.8912-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814103620.8912-1-abhashkumarjha123@gmail.com>
References: <20240814103620.8912-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch we fix simple spelling mistakes in singluar words for
the files inside /Documentation/filesystems directory.
1) "ontext" to "context"
2) "poiners" to "pointers"
3) "realtively" to "relatively"
4) "uptream" to "upstream"

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 Documentation/filesystems/coda.rst                             | 2 +-
 Documentation/filesystems/netfs_library.rst                    | 2 +-
 Documentation/filesystems/xfs/xfs-delayed-logging-design.rst   | 2 +-
 Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/coda.rst b/Documentation/filesystems/coda.rst
index bdde7e4e0..0db3c83a5 100644
--- a/Documentation/filesystems/coda.rst
+++ b/Documentation/filesystems/coda.rst
@@ -141,7 +141,7 @@ kernel support.
   a process P which accessing a Coda file. It makes a system call which
   traps to the OS kernel. Examples of such calls trapping to the kernel
   are ``read``, ``write``, ``open``, ``close``, ``create``, ``mkdir``,
-  ``rmdir``, ``chmod`` in a Unix ontext.  Similar calls exist in the Win32
+  ``rmdir``, ``chmod`` in a Unix context.  Similar calls exist in the Win32
   environment, and are named ``CreateFile``.
 
   Generally the operating system handles the request in a virtual
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4cc657d74..4f0acd1d7 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -515,7 +515,7 @@ The methods defined in the table are:
    the cache to expand a request in either direction.  This allows the cache to
    size the request appropriately for the cache granularity.
 
-   The function is passed poiners to the start and length in its parameters,
+   The function is passed pointers to the start and length in its parameters,
    plus the size of the file for reference, and adjusts the start and length
    appropriately.  It should return one of:
 
diff --git a/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
index 6402ab8e3..2a2705e97 100644
--- a/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
+++ b/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
@@ -219,7 +219,7 @@ The log is circular, so the positions in the log are defined by the combination
 of a cycle number - the number of times the log has been overwritten - and the
 offset into the log.  A LSN carries the cycle in the upper 32 bits and the
 offset in the lower 32 bits. The offset is in units of "basic blocks" (512
-bytes). Hence we can do realtively simple LSN based math to keep track of
+bytes). Hence we can do relatively simple LSN based math to keep track of
 available space in the log.
 
 Log space accounting is done via a pair of constructs called "grant heads".  The
diff --git a/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst b/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
index 32b6ac4ca..ce4584fb3 100644
--- a/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
+++ b/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
@@ -93,7 +93,7 @@ others on a regular basis about burnout.
   sponsoring work on any part of XFS.
 
 - **LTS Maintainer**: Someone who backports and tests bug fixes from
-  uptream to the LTS kernels.
+  upstream to the LTS kernels.
   There tend to be six separate LTS trees at any given time.
 
   The maintainer for a given LTS release should identify themselves with an
-- 
2.43.0


