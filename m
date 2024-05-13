Return-Path: <linux-kernel+bounces-177394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C98C3DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168721F2231B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE01487DA;
	Mon, 13 May 2024 09:14:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD661487C3;
	Mon, 13 May 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591663; cv=none; b=e7BsJpEzLqraFd73Xh3tCAZiy07dZVq8UIO8zikX5/A2WPdd8NoLxjOVgvYbc3ThJA3Kor/1IATo019iJUqrFQGO13qaw+4tmEP5V5Gs44pamotcoUSpMWk20UlXFbVORFs0xEWNi6TZ4CaAlG8xAJirjCrJSapiBeNm0tj55t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591663; c=relaxed/simple;
	bh=pfRqfjaevq5qrlxmLJfqYNrSyTOlHUEDdShE0HQSFfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byCjOm5oCi6doOGCH+MYUZXPZ/qAC9q2oTTWHEm7uQPuxAXdK/iao48O1yjJMRM75bjexZKpc5j6h8+7Ot58Dm5U+9o+slzcsQerqVSaVYw8zNYo5vMrxpWZGx7iTND9E70aFjA+CCdIoFWTR6hu6lpx2lA073/QbIsklgkh260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B931007;
	Mon, 13 May 2024 02:14:46 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92A293F762;
	Mon, 13 May 2024 02:14:19 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v4 0/1] Perf lock improvements
Date: Mon, 13 May 2024 09:14:11 +0000
Message-ID: <20240513091413.738537-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improvement to command line handling for perf lock info.
---
v1: https://lore.kernel.org/all/20231031120526.11502-1-nick.forrington@arm.com/

v2:
* Drop previous "perf lock report: Restore aggregation by caller by
  default" patch. Not required for newly collected data with LOCKDEP
  tracepoints.
* Display map and thread info (rather than an error) when neither or
  both of --map and --thread are specified.

v3:
* Update --help output

v4:
* Remove redundant error handling

Nick Forrington (1):
  perf lock info: Display both map and thread by default

 tools/perf/Documentation/perf-lock.txt |  4 ++--
 tools/perf/builtin-lock.c              | 27 ++++++++++++++------------
 2 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.44.0

