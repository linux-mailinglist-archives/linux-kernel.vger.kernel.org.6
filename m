Return-Path: <linux-kernel+bounces-204398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2A8FE83B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB2B24242
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19263196446;
	Thu,  6 Jun 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJDibErN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4C195998
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682043; cv=none; b=enmasmFFxz0htTEhehh3qrXult9Nr+FDZ8HVL2/RDdZp+StPsQx+LnOgeTHP8HythlPzpfxrY7M5uNBLB+/4Ty7EtrtPD3wZ7SsCu20c25EuSkH9aahJW4CgHYp73y/eB8PWOg1L++jo+neoz3KbDeOQFhKZJy9Ym/6l/QxlMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682043; c=relaxed/simple;
	bh=y3GcMq9ZluqUW1sUBi+CcpJL5Dhf/CqcuOjLkAPEl0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlwsFEST3w8/z14DNDgyASXEQO8Zvd98LMIsfGZnHfBwaD7HVwOUPIqT62E5IBtEgU1FOli5ux0m8k+5M3NEcuPvRUFT5wTBkrXZYz1QiCUdqcoWHsR58qLHXFADMKzRGdGRgb/y+UnfewkCpzBwAeafDJoyIEA37ez8NXzAn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJDibErN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717682040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAmC2sHpZW/uyd30+ahP5F1fjRrkzir9nGwEyAcBFJ4=;
	b=PJDibErN0KnpITXpF13r9Pn7N72/3sm8AbSxiP1i9jX03e02C+b1XyM/I9IW1PGWMHMOaj
	HHTS0mP1bC9inqE9oYOTP4xg2WU4fB8frkzOk6P07ZbjJnURl+pffuv0vLDTzSi5dIMqPF
	lqa22M3klQx/2Gy6O0sqtJGO4o1p8us=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-Py2nbBFJOOOxKaczvQIzLA-1; Thu,
 06 Jun 2024 09:53:54 -0400
X-MC-Unique: Py2nbBFJOOOxKaczvQIzLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BF6E3C025B2;
	Thu,  6 Jun 2024 13:53:53 +0000 (UTC)
Received: from sullivan-work.redhat.com (unknown [10.22.34.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8132166B00;
	Thu,  6 Jun 2024 13:53:52 +0000 (UTC)
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
Subject: [PATCH] selftests/livepatch: define max test-syscall processes
Date: Thu,  6 Jun 2024 09:53:48 -0400
Message-ID: <20240606135348.4708-1-rysulliv@redhat.com>
In-Reply-To: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz>
References: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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


