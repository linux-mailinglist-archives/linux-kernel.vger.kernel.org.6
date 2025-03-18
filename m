Return-Path: <linux-kernel+bounces-566488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EDA678B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECC619C1E68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE520E6FF;
	Tue, 18 Mar 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CsJ2y7iT"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38020D4FA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313929; cv=none; b=OgYVSeNFUjp7Xjb5msMmthKhrKzCvHgXTyEMHIVUf44ONPTQR4mlZuyAoyFZzQkatRTO0HnCLzNC0aUraiOF9LDYnTX0FKk4zbOGdMfhEOdlZFanWDxcGUB/6LkQ5jaHExrnWP3gxp9sxHaF+S/Z1bijG32GivTJ/gMUrHCl3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313929; c=relaxed/simple;
	bh=xFt7kmIS8Ntmp/8Qz7sg2769FdIilHhYkSWjqOvYAyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXDoiXfCuXhTur7cQlRPhmr50ul3naK6ZGAts14FCJP0ArMcmjeOl+zDG14ra2hIfeL0sXxg3IThR2PPvODiaN9vMotPE2bKKmJD87Ugh5fePcSzR6EGT46tXMA8IJ/G9c4GyFLjP91mDdszTB9NKtvEiVbLDSfPT0Iv3Enxvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CsJ2y7iT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742313923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ge48uC4pTgYnaysr0akTkHFJx5SVH5p0FJWtLdLgWtI=;
	b=CsJ2y7iT6HWtsaUVRnUKTNU/FhVJI3ZXYNLH29t7nr55lMtfVo71fe1U5LZfV7eRYrJjOJ
	bLk/j0l9UbuZGB/UcWrmuxnoDr1UTiunNUMX0RdgOA7RAqOlINpXsV0yu5zwPBJMtDULM6
	yTMgu9nDsp/J6zKeWHtCLHVlytWxb5k=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH] selftests/run_kselftest.sh: Use readlink if realpath is not available
Date: Tue, 18 Mar 2025 16:05:10 +0000
Message-ID: <20250318160510.3441646-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

'realpath' is not always available,  fallback to 'readlink -f' if is not
available. They seem to work equally well in this context.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 tools/testing/selftests/run_kselftest.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 50e03eefe7ac7..0443beacf3621 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -3,7 +3,14 @@
 #
 # Run installed kselftest tests.
 #
-BASE_DIR=$(realpath $(dirname $0))
+
+# Fallback to readlink if realpath is not available
+if which realpath > /dev/null; then
+        BASE_DIR=$(realpath $(dirname $0))
+else
+        BASE_DIR=$(readlink -f $(dirname $0))
+fi
+
 cd $BASE_DIR
 TESTS="$BASE_DIR"/kselftest-list.txt
 if [ ! -r "$TESTS" ] ; then
-- 
2.49.0.rc1.451.g8f38331e32-goog


