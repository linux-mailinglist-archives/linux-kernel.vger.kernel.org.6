Return-Path: <linux-kernel+bounces-365522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A5899E3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED65B225C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C61E2031;
	Tue, 15 Oct 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xq7ZBlNQ"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C201CBEB8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987556; cv=none; b=h7vTQ8rV63BiV+bXcBeG1PISDPVYyi/5UcmBD0rs3KOaOSNal9juSwIuCQ1EkWysArwlf8w/LbM71BdQ3kd/lhO9PQ5Zw4q3MftJqmVCcVd8jcNcSHWUja/TCjxZF83+1d+t5XFAUlubVKj/fUD96ZvO0E9n/khz1vaTQ06r7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987556; c=relaxed/simple;
	bh=9kxCMO+ZKfdLpSe3ykZ9428rS0DuSJXVQQ17j+vf3bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qel3nJKruCbFsIYxbbnKdiq9sOqSEfi7QT33GM7/tdLCz9xbTJ9gDkfHSV3w3zc6TvfHKVqTzMh9bHDwyqXxic3TSyv1jbp3UjZ2QYRA78Ra6K3gj3r/bNVCvmaoMRP/g6XLtjcNtdCwGSKGASf/7S/504YAlDpGzJkfkypm4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xq7ZBlNQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728987551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOwhazTNXJq9la23bs9AQS6qvy6I2WjnVd+IS9JBBEo=;
	b=Xq7ZBlNQnUigAHx8FZkA722SNh81nb3PNNCW4C0yWvWmKHPUgMNxAa0YsqbE8Omq1gd2FQ
	ukl0M0jVK2vyEklpEoDa2G2o9Wo8FidMd3smQb5H4DDUGWnuuL8qzo6gLFFo9OM2xnHAz1
	EXPPTqk5mWwTmcJwI6Uu1jmtzGhbPtQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with __counted_by()
Date: Tue, 15 Oct 2024 12:18:29 +0200
Message-ID: <20241015101829.94876-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..ec62d625c439 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -643,7 +643,7 @@ struct vmbus_channel_gpadl_header {
 	u32 gpadl;
 	u16 range_buflen;
 	u16 rangecount;
-	struct gpa_range range[];
+	struct gpa_range range[] __counted_by(rangecount);
 } __packed;
 
 /* This is the followup packet that contains more PFNs. */
-- 
2.47.0


