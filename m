Return-Path: <linux-kernel+bounces-175556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241758C2171
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555EE1C20CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58A165FA2;
	Fri, 10 May 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Km3nXF/p"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AB1649CF
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335101; cv=none; b=iDpi6Nfo6LnKoslCIpc/AlrqL6pAVaqkhn6Or9wKuDUOtavxLZCBOJ4kzDM5LYC35eiSMLBEf2BYLCQ59AryGNpv7Tt3UI5DW4DrcaQvF6gvnXEjdo7ZT3k1qAobSa6PWgo1Ej5QzDH7RDoF8JnoRMvj6/LF8wiW3qNz5pCdngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335101; c=relaxed/simple;
	bh=dc5X+/qSmxzC1WnaveQ9yTUgWMgYD6IWrs8np6LgqgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B69LSiSpViuL+Z5OtvMAyKwnjiU/o/xSVjIUmqW5UdP4vR0tx0/Rl3XGc5B9ZjzG9gMRlFhx1o0oTaltbdKBU+YDOB0wcqQXRg6eQhGn8U/tVJf+40NQ8TQ9Ot1PaxDUif92UsdGbpdafYKRB7Pe2O4yLwDIVR0MOX/SB62iNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Km3nXF/p; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715335098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ynoBbmu7uH9JiLyBHsFJi2Dy06OCsFnk/vBceNe8s+w=;
	b=Km3nXF/pgC8IMHmoffiLh6DSKVfMWUCuqK7iHRQ+Xj/El0URwTxSOjXITmULoRHkq2/1+Z
	NnvONNnHO9NNY/ZyNj2E66iFs9FXmq8+dQUacyAx3kZAnDdRgkNzPUp1IumpyG3ekdeshN
	3kaEfEYN0RlAX/xEw29iOMjuHbxIzlM=
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
Subject: [PATCH bpf-next v2 0/4] Add some 'malloc' failure checks
Date: Fri, 10 May 2024 17:57:59 +0800
Message-Id: <20240510095803.472840-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

The "malloc" call may not be successful.Add the malloc
failure checking to avoid possible null dereference.

Changes since v1 [1]:
        - As Daniel Borkmann suggested, change patch 4/4 only
        - Other 3 patches no changes.

[1] https://lore.kernel.org/all/20240424020444.2375773-1-chentao@kylinos.cn/

Kunwu Chan (4):
  selftests/bpf: Add some null pointer checks
  selftests/bpf/sockopt: Add a null pointer check for the run_test
  selftests/bpf: Add a null pointer check for the load_btf_spec
  selftests/bpf: Add a null pointer check for the
    serial_test_tp_attach_query

 tools/testing/selftests/bpf/prog_tests/sockopt.c         | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
 tools/testing/selftests/bpf/test_progs.c                 | 7 +++++++
 tools/testing/selftests/bpf/test_verifier.c              | 2 ++
 4 files changed, 18 insertions(+)

-- 
2.40.1


