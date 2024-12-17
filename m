Return-Path: <linux-kernel+bounces-448871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CC9F469D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADDD18893BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538AE1DE891;
	Tue, 17 Dec 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wzzcfwRe"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEA1DE2DA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425751; cv=none; b=qHTUzOeJApa5ZqPX6FeB7S1fBO0bPRQiYEqDHDU2bJAT6SldtQilivaIszBMgnTxWTOpsff/ZxzFECQUVzgu6GrpNFyowWVDjOk1UEJ43FUxmoQLLmsSj9QPJShS73Wu0LFFObU642OaPQe0xO+g/3sYTxt9vT/emzv7W6JinCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425751; c=relaxed/simple;
	bh=+A2wJykwKZjn1fqLiUWDchhJWr8DQFGSe4G4GiO6L94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJG0JgF//eK9Qvnht+TwGI2PRLb8MyElsKiqRCB9SPHL2KCkEMoR3Y9CNsTn4xb3xnB9U46NNtFTKPU69gPymKAgSuZhU0n6+CvNrS7FxhKO6Ss1IMHxdJCAhZB2LZTUCJmQmQ3PF0cKx4tdWJtRdd8Pjw97isgZVT5pdg7vZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wzzcfwRe; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734425746; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4A3j4D/qkXXSi7O+ZvvinsCXre0P2/UY3O6e9ysEeDU=;
	b=wzzcfwRenA/b4qYb/ko3X9mw5sX7LrIo28KKsM7kI488ZyvBwxFmSL6UTJu0tGxphdhHWt6wN3uKR89d4rWLmlsAj8uejXLxYYcTvgSq/a0wI6Xrv07dZ4OG1eb84y1ftoHhCNglAIZ3ac045IhwthLa5VGs+OT6hYUtBJwizyc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLiDqOo_1734425744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 16:55:45 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: mm: fix the incorrect 'FileHugeMapped' field
Date: Tue, 17 Dec 2024 16:55:39 +0800
Message-Id: <d520ce3aba2b03b088be30bece732426a939049a.1734425264.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '/proc/PID/smaps' does not have the 'FileHugeMapped' field to count the
file transparent huge pages, instead, the 'FilePmdMapped' field should be
used. Fix it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 156a03af0a88..dff8d5985f0f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -466,7 +466,7 @@ AnonHugePmdMapped).
 The number of file transparent huge pages mapped to userspace is available
 by reading ShmemPmdMapped and ShmemHugePages fields in ``/proc/meminfo``.
 To identify what applications are mapping file transparent huge pages, it
-is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fields
+is necessary to read ``/proc/PID/smaps`` and count the FilePmdMapped fields
 for each mapping.
 
 Note that reading the smaps file is expensive and reading it
-- 
2.39.3


