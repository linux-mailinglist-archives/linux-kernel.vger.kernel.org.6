Return-Path: <linux-kernel+bounces-194648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EA8D3F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE741C22090
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680201C8FA7;
	Wed, 29 May 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpP7n7qw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81F1C689D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013995; cv=none; b=TZoYavcM3tmIEBSVVlC1Ir5B/ynVnhwkNXu8rkTNSYqQIlADjxUBEsvLwIaZxel6Qa5T8jp5iSUvHLczqZjYowmjyd3um7GgTLDmClpIW1bdhsnneoQCZrIiMeSL2RoXgdtFlWrqB31eB/QmMnbXb+8udyJze4SRp+gkDhgwqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013995; c=relaxed/simple;
	bh=y3GcMq9ZluqUW1sUBi+CcpJL5Dhf/CqcuOjLkAPEl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VA8voI6hsxXC0ZzkZeqYr4zdihe5UfoqYfaPRgb+J0fMCEATu/MnuY6AnfchSmPXmr1P1KBwegqHRjJAY9Dq7f8XLHMTDX0q0ftLXUQedR28aZcq6egJiByMS8KkitAPyo2JKPA0iz2i5JVC6Lk8Xyq5Pluprfp2P+zYvif2In0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpP7n7qw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717013993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NAmC2sHpZW/uyd30+ahP5F1fjRrkzir9nGwEyAcBFJ4=;
	b=HpP7n7qwRRJHas1dqbeP0tPkFyY9CfvF5IvKEGufMStutbbmoXQWw4HGDeD6e6wTzVa5+C
	8HRObPqq7her2Pkz+MA4+KuyzubSzFW5oUC0gsA0k4iPx+cEuFoP3ydFccbAnNzhKGyZJY
	QMiX6VkL6Qt3B0eCCuplB7O4Na881Hs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-DmCdbomkPdiGAttvQvWPfQ-1; Wed, 29 May 2024 16:19:47 -0400
X-MC-Unique: DmCdbomkPdiGAttvQvWPfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E928101A52C;
	Wed, 29 May 2024 20:19:46 +0000 (UTC)
Received: from sullivan-work.redhat.com (unknown [10.22.9.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD32AC15BB1;
	Wed, 29 May 2024 20:19:45 +0000 (UTC)
From: Ryan Sullivan <rysulliv@redhat.com>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mpdesouza@suse.com,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Subject: [PATCH] tools/testing/selftests/livepatch: define max test-syscall processes
Date: Wed, 29 May 2024 16:19:41 -0400
Message-ID: <20240529201941.13968-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Define a maximum allowable number of pids that can be livepatched in
test-syscall.sh as with extremely large machines the output from a
large number of processes overflows the dev/kmsg "expect" buffer in
the "check_result" function and causes a false error.

Reported-by: CKI Project <cki-project@redhat.com>
Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
---
 tools/testing/selftests/livepatch/test-syscall.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
index b76a881d4013..289eb7d4c4b3 100755
--- a/tools/testing/selftests/livepatch/test-syscall.sh
+++ b/tools/testing/selftests/livepatch/test-syscall.sh
@@ -15,7 +15,10 @@ setup_config
 
 start_test "patch getpid syscall while being heavily hammered"
 
-for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
+NPROC=$(getconf _NPROCESSORS_ONLN)
+MAXPROC=128
+
+for i in $(seq 1 $(($NPROC < $MAXPROC ? $NPROC : $MAXPROC))); do
 	./test_klp-call_getpid &
 	pids[$i]="$!"
 done
-- 
2.44.0


