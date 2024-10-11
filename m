Return-Path: <linux-kernel+bounces-361309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5799A689
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA1F285E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8A126C01;
	Fri, 11 Oct 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j30VXZZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB48194C8F;
	Fri, 11 Oct 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657573; cv=none; b=Wp3oY1KmMQSdlNJRcqR5xPCyoaxZS9JoN6UvOpQvHwy3pq5O30CDltS0rIYZWvG2zof1vcWqjulHaW89JprHBNkGZT0v/DsQl1aqamPyQsLsM0TtzX/Y+HZ8n8tk4JzRBZQXvMiN46EL7swVvV3wnjYGkUPuGzt7AVrwdpQbe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657573; c=relaxed/simple;
	bh=8tSTm2TVIpuR+nPouNS+bDuyIwnTzkRZZjoUPOHgQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBBwE4yAJcnvFS70ecc9UkFh3RcS888AjSqMDBYYktusCDr7ZlSMc8do74hIcyjeVNNSO+gJ1FKhr4cAnplwRWNiKEKW8QiSlsuQbnfrjlCxKA7uBoPojJDfOeDSImU5VPQ/BlQhBNNMjQTEbCMs1n3uCX4N4DP/azeugZqQLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j30VXZZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6398AC4CECE;
	Fri, 11 Oct 2024 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657573;
	bh=8tSTm2TVIpuR+nPouNS+bDuyIwnTzkRZZjoUPOHgQw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j30VXZZVc6DIUj5UpwYkgFRRIn5zNdZpVkw3nXjfcDAixd1QDZIy7e2K8oXa2q/CN
	 Us67atlCU8/5ZzYxKMLosuzhVAjrXLfh7nsIu4PTPwxT3u5Qgo782ixaRS1jBHB9/N
	 glTZHBxmxhQWc+h9a+x8C2h4Hx1uBChefXlgm5dYDR6304GXGfMBEwAWadoGDVWSvG
	 L2XGtL/PvRKAC9zsVYWkEHnoQ1XSIAKtEcVPi6Ph1/YiH/RbbGYVZR3KUdtmmCQ0rB
	 RPd92Uj85Lm5662nDzW01G8iiIYbqG4aLK+Oo34m/CHXffRIHARsYkUGYJavUQQD82
	 pIdhtfX7VuyVA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/3] perf test: Document the -w/--workload option
Date: Fri, 11 Oct 2024 11:39:06 -0300
Message-ID: <20241011143906.1285675-4-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011143906.1285675-1-acme@kernel.org>
References: <20241011143906.1285675-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Wasn't documented so far, mention that it is mostly used in the shell
regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 9acb8d1f658890e9..e03c1cabdcd37594 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -48,3 +48,9 @@ OPTIONS
 
 --dso::
 	Specify a DSO for the "Symbols" test.
+
+-w::
+--workload=::
+	Run a built-in workload, to list them use '-w --list', current ones include:
+	noploop, thloop, leafloop, sqrtloop, brstack, datasym and landlock.
+	Used with the shell script regression tests.
-- 
2.47.0


