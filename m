Return-Path: <linux-kernel+bounces-290867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B19559DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DF0282544
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A871553BB;
	Sat, 17 Aug 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qh2rkMUB"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFF1AC8BE
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723931439; cv=none; b=hwv5DUNgyLrFrCw1S0nTI0Yww3mwIkqWedldB7xiDWO4aw+Sy/N7OPytjmKhw5lirHKlRQEOxXPkGM/DLvsjLzx8OheHeTsU6hPSRvBwHw05rYoZgLgQiaIoeO7EAG4ScMM/KJTqyfRzsueeXbw6g5YeJUzmvxcHh+NpsRoSbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723931439; c=relaxed/simple;
	bh=A0MCABEyH9WwZCS+LXvQM4TUgXYZxhYFGo/mUke9q78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8RPhcods8zFydw9YsOcgF9KcZG4fAJyu6dIHRImNlfnSq1UzS448NGz5SUtdpD4zDZMxcUZ9fM3/JhYdIOk8+DlmGPmcMNtJMTO3XZHN7fFIgXIOrnk9esWeUergqTLUI6ie0NxVtBBm74hyZ/Bj0RPrlEZMVwYR87DDflmcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qh2rkMUB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723931434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m9lw+o1lDJ02mPL9jlFTS3W+wJz8LSPltmhS9IpzRGg=;
	b=qh2rkMUBrcsBHdQO3N3VlHlxhR8D+f88X+zTNKtiDrGmdnkqRi3a2yHZW6MJydwFBxaOlX
	gNxNDys78btajqViKvFk89hJf0VhJv5v8ncfaAA9KnuAviIqwh2PPyFEfZOByUN56rsaxT
	UAYenlWuV6iDp4Wtd9li4fCoVadKC40=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: cmllamas@google.com,
	quic_bjorande@quicinc.com,
	xndchn@gmail.com,
	quic_eberman@quicinc.com,
	akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] scripts/decode_stacktrace.sh: nix-ify
Date: Sat, 17 Aug 2024 17:50:25 -0400
Message-ID: <20240817215025.161628-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

nix only puts /usr/bin/env at the standard location (as required by
posix), so shebangs have to be tweaked.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index a0f50a5b4f7c..ed9f914334cc 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 # (c) 2014, Sasha Levin <sasha.levin@oracle.com>
 #set -x
-- 
2.45.2


