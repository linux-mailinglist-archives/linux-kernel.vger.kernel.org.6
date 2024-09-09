Return-Path: <linux-kernel+bounces-321328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACD9718D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B28EB21126
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D271B652E;
	Mon,  9 Sep 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Spocuizj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56301B5ED8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883127; cv=none; b=W7oiTx+eAtemCkrUCzrhTR+rg4y2vdbOFEbyigoFnIeIyDOKrlD081j5sWJTa+6LzEhoaaYNrwaqZOcwYs9vH/GA9iyAZyaV3pVg8Hr9VqRYCJTKxqAbEhxQCU8SjUjj+FByHdT0ZyP+Sxkv9TXDpJ/vFGmzIaD9SjdQAiSwkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883127; c=relaxed/simple;
	bh=KZWqYeH1sPiGAK5yRVktibDLxR9hM0fYJlVAHQqAHL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V82AqfwD4s9Gz34VQd9wxDHley8fHaOxliZ/qr9T83Qry9SlgrMvqbiBNLlue9Gu6aeAr36FyD49l4K49HTZRH4J89oF49URLa9waGqgQ7KLtNzPgQHaT7ay2OQONw5LGs9zcyIMFd3fq/aYzoaCLMk+lMn40V7VIOYhXqLPq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Spocuizj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725883126; x=1757419126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZWqYeH1sPiGAK5yRVktibDLxR9hM0fYJlVAHQqAHL4=;
  b=SpocuizjL9UZzxQeSCJ33O7s1TbjTjknPmrYZwOLRoW8rEAmnOHoVsAE
   CG+Fh0hiO517B174IWCi6E9P5qmssdoyG3+Rw+qwxID6KV0u/9TJD2jE1
   B8MQKiivhKqeAffe1+kZMP+NZTyQ1ZOS9DyadQ1PxG0vv0qJej/ooKYWi
   YaoaQJezqSrYEPSXgwAmPbAYpkB0hnYXCddj+IG0fSocj2R0OyWvjHH12
   XlczxzUFCVvK+mbVdQmrSUVQZL1GKHxv5e0NluIe4k1e2r49wKfRrTS59
   +r++4y59GN9cgxR9jeMRWFbdIdQu11hcPEZYGxTzH8VTuJbZM6Xtz5xQF
   Q==;
X-CSE-ConnectionGUID: qVkGvGU9SbS++BGg2VpP6w==
X-CSE-MsgGUID: 2in3tCoBSeKsy5S3tzc9bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35717231"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="35717231"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 04:58:46 -0700
X-CSE-ConnectionGUID: lLYquAG8S6CKOh5RdbRVdg==
X-CSE-MsgGUID: NSbl5qCtQsCKjIarP/rrYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="89938352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 09 Sep 2024 04:58:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0E0C4321; Mon, 09 Sep 2024 14:58:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] locking/rwsem: Mark inline helpers with __maybe_unused
Date: Mon,  9 Sep 2024 14:58:39 +0300
Message-ID: <20240909115839.1022530-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When one or more inline heplers are unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
  187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
      |                    ^~~~~~~~~~~~~~~~~~~~~
kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
  271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
      |                                   ^~~~~~~~~~~

Fix this by marking inline helpers with __maybe_unused.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 33cac79e3994..c098567e2c68 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -184,7 +184,7 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 /*
  * Return true if the rwsem is owned by a reader.
  */
-static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+static inline __maybe_unused bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 {
 #ifdef CONFIG_DEBUG_RWSEMS
 	/*
@@ -268,7 +268,7 @@ static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
 /*
  * Return just the real task structure pointer of the owner
  */
-static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
+static inline __maybe_unused struct task_struct *rwsem_owner(struct rw_semaphore *sem)
 {
 	return (struct task_struct *)
 		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
@@ -1508,7 +1508,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 {
 }
 
-static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+static inline __maybe_unused bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 {
 	int count = atomic_read(&sem->rwbase.readers);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


