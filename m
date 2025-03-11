Return-Path: <linux-kernel+bounces-555976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14664A5BEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521833B1400
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A2254859;
	Tue, 11 Mar 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xu/hxnBb"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC1224244
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692539; cv=none; b=KqTPB+aPoTtjb+iKQW4UA1doBnFI4tOnb8dLu4v1RuojMDM2Chysw94r2NSvq63CGuMl//PtLIaGRYZBH9u6dzOd3d1BAiUwY8dFOVH7W8fOv/Md3TwUO6F24561v65O9zI6giy5Hn7ZG/KZs6CyQxwS8Y92eM7XyXqmd0K5aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692539; c=relaxed/simple;
	bh=a+bHNngOwlgLll5artqJrztI2r1EeaeuFA7stDqXwT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lymu7MvmbEo0dmW3yAyev3YHdchozy2eH4AoBux3RohB5eAFOzrxmK57qm3j4OUwAqsnrpXceEIX4Uu+YnNGxlApH4hXwQqLxmFdFJONlkAx+oSTQgg2gM4Kjxh0tVEggOTPSIELooi0wbWfJ4tu3Om2wO5Xl/Cs7nNfuASVDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xu/hxnBb; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741692534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTtt46i82o+OCH4JLbzJzzO/BPLNVLs/178Xb4EMJnc=;
	b=xu/hxnBbQ6tKElmp0H0hsC5l/Yx6f2BeQAy7HmNmqtDx7jc3FhT9ddHFOsrtsk+VWTsNR+
	88OnDRWJqRFIJ8YDnFngOdMWUybkLOsuvQ3bN6G+MekwprVYGiNDuh6ZhEbkfVDvV0TLBk
	oVJ4v+1NzFbksob64jkZSpw95V7Eoi4=
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
Subject: [PATCH bpf-next v2 1/2] bpftool: Add -Wformat-signedness flag to detect format errors
Date: Tue, 11 Mar 2025 19:28:08 +0800
Message-ID: <20250311112809.81901-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250311112809.81901-1-jiayuan.chen@linux.dev>
References: <20250311112809.81901-1-jiayuan.chen@linux.dev>
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
 tools/bpf/bpftool/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dd9f3ec84201..efe867dd2821 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -71,7 +71,12 @@ prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
-CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
+CFLAGS += -W
+CFLAGS += -Wall
+CFLAGS += -Wextra
+CFLAGS += -Wformat-signedness
+CFLAGS += -Wno-unused-parameter
+CFLAGS += -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(or $(OUTPUT),.) \
-- 
2.47.1


