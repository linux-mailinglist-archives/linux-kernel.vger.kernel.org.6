Return-Path: <linux-kernel+bounces-175560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E58C217F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F53C1F21B08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7D165FDC;
	Fri, 10 May 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/iODyYK"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEE16F0C9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335119; cv=none; b=qmtWi7K3sCdAh7et2byl+B3dG79y6a1czaYgIx/L6Ad3ShkGEaoPqKlPLgFoJV05B9z0iVDISJ2w9j19uwJY85koZWgiylZkEKVvBcOZUY3/OhDH6M9SgSHjCslMbJWtfc85Or1CYLRVr9MSGPgGSV+m1IUTyhfCCLWLTgISnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335119; c=relaxed/simple;
	bh=bB491r35n9N4uzXZc1q70gTMtCa6mqt+ofgDXjFs3MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ks5BWZ/5l4ew9cdo/Pb3gj7jQwP7hVaDx+B2+J+JhNLlCctQdv7+d58scFUHNQ2BfboCPiWiSHpiAdgZLT6SSSXvmKiWuuOzR4dj82IYet09FC4ILAB9J78fSBX4vyHhnJjAcmlBG6HX6zJdW7tUpo1BykIW+pCJ6A1xipamWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/iODyYK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715335115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aJZjrayVmmqLyz6Ky6ChcOrC6sjpvX/LIO1l69Ryr8=;
	b=N/iODyYKTv6xAF8+nPjTOJa6CAmoLouxAjoxhfoA0TJudge6lBicKGj1CddBCibuFK0//A
	WrbwYOijJKVMh5OMczOZkwoy2FwZGhdyHnUbXIub8GhOgAOASpC0t2jP1GGbVH0T2DX41t
	yQpNIwfOH6cFfPCqsKNKSD+hZ4eIQ04=
From: kunwu.chan@linux.dev
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add a null pointer check for the serial_test_tp_attach_query
Date: Fri, 10 May 2024 17:58:03 +0800
Message-Id: <20240510095803.472840-5-kunwu.chan@linux.dev>
In-Reply-To: <20240510095803.472840-1-kunwu.chan@linux.dev>
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

There is a 'malloc' call, which can be unsuccessful.
Add the malloc failure checking to avoid possible null
dereference.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
---
Changes in v2:
	- Use ASSERT* instead of CHECK
	- Add suggested-by tag
---
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index 655d69f0ff0b..a5ebfc172ad8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
 	attr.wakeup_events = 1;
 
 	query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
+	if (!ASSERT_OK_PTR(query, "malloc"))
+		return;
+
 	for (i = 0; i < num_progs; i++) {
 		err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
 				    &prog_fd[i]);
-- 
2.40.1


