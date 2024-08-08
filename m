Return-Path: <linux-kernel+bounces-279708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9308D94C0CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB75B1C224C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98118EFD3;
	Thu,  8 Aug 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhQOojhu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B8146D76
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130195; cv=none; b=ICPPGGqluCkefkbMfuhYfHz7e6Ttmr4q7FMAvYKV+5lhNfS6xCfC1w1zPiggGzXkYEOaKOHPdsv4KuIi10CoJ3PzOpAYv4L6Q+9Rm4u9NP0o5Rd2fDjUrsJVwAC+nvqWxlMGDaL6ighB9VXbtHpWsUD86H7FL1RPPs9FkSx3HHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130195; c=relaxed/simple;
	bh=LxmeRR1hooS6bP5ef6QT8iyxmeFKOedEGsPmmgCNdzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D4OYbEanSRp2abtv3j3sSGHF4ZLhkN3chv9w6s5nwY6SPirYLm8pTLpC1gKfyT7FR/ETC+KMcupWmsT8f0spumRWOs/u16bamImwAZm9L1QcswtDPPSvhRyzwAagB3hGsaSFN5x81RAyCeAFj0miN12ALBj+e3ZFpJPp2qpCDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhQOojhu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723130192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IipFKB0LgLlzzgEC4oOmoqzapqAYwfuhgC4xhwpAZ88=;
	b=JhQOojhumD12bgubyu3oelWvgahZP3zC5Nf4t0E4ndvnb/OBvVJsO/CXXw/5roBFuIi18g
	zwo/sMLicGZwH5d/W+cnYg9aaq26Ev5fS0LlqvE6CCCHvq6hW+rFS8atloZ06dLIdGA1wA
	EThwhsAVgBTF66OQUeCUch08ihbcGU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-WbXnh7ASN6qPedA0aSCX3g-1; Thu,
 08 Aug 2024 11:16:28 -0400
X-MC-Unique: WbXnh7ASN6qPedA0aSCX3g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2FD41955F08;
	Thu,  8 Aug 2024 15:16:27 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 793331959164;
	Thu,  8 Aug 2024 15:16:25 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:16:21 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Artem Savkov <asavkov@redhat.com>, Chris Hyser <chris.hyser@oracle.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched/Makefile: remove relative rpath usage
Message-ID: <20240808151621.GA10025@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executables are run
from elsewhere.  However, the sole sched test (cs_prctl_test)
does not require any locally-built libraries to run, so the RPATH
directive can be removed.

Discovered by the /usr/lib/rpm/check-rpaths script[1][2] that checks
for insecure RPATH/RUNPATH[3], such as containing relative directories,
during an attempt to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/sched/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..0e4581ded9d6 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -4,8 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
 TEST_GEN_FILES := cs_prctl_test
-- 
2.28.0


