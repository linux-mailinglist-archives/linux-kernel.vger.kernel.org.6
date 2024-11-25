Return-Path: <linux-kernel+bounces-420927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12E9D8474
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F328A16206A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22232199384;
	Mon, 25 Nov 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i77TUixI"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4161993B5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534107; cv=none; b=ljMPR3BhtaiGQn4knSWXsEqHMPUHlZ3xl+A4rxM/eIIuqd2UbKyXJeElMdDkX51BAzveBRNZ0I1pCzzyHNVFi7KIaDdxX85fzUapvgwrxEmqB+sWsoczK9+PIHE2Fvjft+Rd6fTEfkZ9sKvKf9L2d9rxMCXcRu+FNJpVaUDEOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534107; c=relaxed/simple;
	bh=+VuaVobFp5Zisv4ECgsSim05t9k6TMIk+ZPhiGNsSlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QeyWywzYsKkvFF/Bv1uLGINFH0yXIApsYVyNc8X6g4FUC4gdVXJQ9UoARsULPB4iIxF9T8/zquVtU/et0znUWyfapZ8aVXmW/RMvIxakyNE12pVYOt0ZmfzpPwzeb1/WYAXTqNXlZq/eg6eQrkXuOivj9NQ4aieey7glzlV6bVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i77TUixI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732534103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8VQ+ccQMha4i1JocKsS0xwAjEvTSkx+heZNfF1J0jX4=;
	b=i77TUixIr00q05uDs475DK8ORDEg7j214HQKMUu8SJHoI1X1BOHrvXxfoH1+aJVugZ9uxy
	Vdgl2H+qTL2UsirtSXejU/zt/FmTxzDE8eII6TaZKYXii7d5E0r9zFv1AmwdUkYs/NWAcJ
	0reSh6FUEH6n6Or+cZTacUy+KJ0IQN8=
From: George Guo <dongtai.guo@linux.dev>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Cc: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH livepatch/master v1 1/2] selftests/livepatch: Replace hardcoded path with variable in test-syscall.sh
Date: Mon, 25 Nov 2024 19:28:11 +0800
Message-Id: <20241125112812.281018-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Updated test-syscall.sh to replace the path 
/sys/kernel/test_klp_syscall/npids with a variable $MOD_SYSCALL.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/livepatch/test-syscall.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
index b76a881d4..9cfa17b6b 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -24,9 +24,9 @@ pid_list=$(echo ${pids[@]} | tr ' ' ',')
 load_lp $MOD_SYSCALL klp_pids=$pid_list
 
 # wait for all tasks to transition to patched state
-loop_until 'grep -q '^0$' /sys/kernel/test_klp_syscall/npids'
+loop_until 'grep -q '^0$' /sys/kernel/$MOD_SYSCALL/npids'
 
-pending_pids=$(cat /sys/kernel/test_klp_syscall/npids)
+pending_pids=$(cat /sys/kernel/$MOD_SYSCALL/npids)
 log "$MOD_SYSCALL: Remaining not livepatched processes: $pending_pids"
 
 for pid in ${pids[@]}; do
-- 
2.43.0


