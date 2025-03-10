Return-Path: <linux-kernel+bounces-554414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757DA5976D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA1F16CD83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB922CBE4;
	Mon, 10 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMItmqxO"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A722B8C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616467; cv=none; b=OGwEQB9bOFJ9r+21K1cCMQRWE60SLIew/kuyakE0d3nSK+/2YO5LXPTF+pnRxmwYAdR+vxmP0dxM9wofDyV6p9OGmtdSy636/3107DIbRF6OCCPlelZ2lbk3Cdufh0GtvOnqZ4sc8XHEfjBBqwzaWEYArQOTJyLBxQgVpqNOIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616467; c=relaxed/simple;
	bh=aVMorMUiyrSnpjgp/0n5/Fu8Y14PnT/tyqBbuLhoxOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0+tU7mHXFmFRBO2UWpbMyI7e96nxitZf4F0opvFzO5YeXLMx+XY8M1Z4nRqTqOXtgCHWIrGwWE2pUwGZgarfw4vFE0120zfQtwKYIGWZg1EBDRLTn9P7jzjCVIYs5XAEoHf1F5WR1iTuAI1ycWHKYMobzHQAKabWRrDaeJVWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMItmqxO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741616463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tdnaKqRE25Nlj4kRDb0pUzwsk1xxSG4ugbiY1bif4c=;
	b=XMItmqxOZoE/imkSMs4uxBdrASELhaNwUAvEoqEJN+ljWnmDqyd54sMlWQnZSEKlm8Qd4Q
	A71y+ynbhTwx6A8EaZML9rNGngBbG3wIZ/a3pRLPwyQM2Oz9tbOxYxUghq17RDEIr65Fxo
	LenOjJR2TewFTlHjf2zERxkZ86yhlwY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 1/2] bpftool: Add -Wformat-signedness flag to detect format errors
Date: Mon, 10 Mar 2025 22:20:36 +0800
Message-ID: <20250310142037.45932-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250310142037.45932-1-jiayuan.chen@linux.dev>
References: <20250310142037.45932-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit adds the -Wformat-signedness compiler flag to detect and
prevent printf format errors, where signed or unsigned types are
mismatched with format specifiers. This helps to catch potential issues at
compile-time, ensuring that our code is more robust and reliable. With
this flag, the compiler will now warn about incorrect format strings, such
as using %d with unsigned types or %u with signed types.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dd9f3ec84201..d9f3eb51a48f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -71,7 +71,7 @@ prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
-CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
+CFLAGS += -W -Wall -Wextra -Wformat-signedness -Wno-unused-parameter -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(or $(OUTPUT),.) \
-- 
2.47.1


