Return-Path: <linux-kernel+bounces-279704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEC94C0AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8533B26049
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9C18F2C1;
	Thu,  8 Aug 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtQzpOKW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24218DF75
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130031; cv=none; b=k/jDGWINuWCFKjj1nHZjlUzczf5vJpDLO1XxjX8EnEyAM8CnevvOiNk4qDpM0npA5rIW+AkrJasXW8hvQlQc77xZjdsSPZtzj4J/o0bhW9QVHyVdNArBSSNwJ2Rq+tevaLzat2h1FOLEQDymV8ctmI3pQN6AOp3/1WiLpnx0Ckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130031; c=relaxed/simple;
	bh=eqXF/iva4qGU+Q8HS3uwQf8py3MxoDUmsRFkoMpN5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWTe68+nQesdpsnU6Em9M6bzzhZ3IdQOeUfBN5fccMiWJDSZ/3QSRQuD5FsqZrLwf+MbT4dNWZeFsfGIWhuhR1s13pvWiI+MoBrN/fTrD7l6Yyi/hg2OdHaE/Dm+yDR/Ci737fcDilVXY5sa5xZdwH+LAoqQviegUTuTfYBeXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtQzpOKW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723130028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uoaG0PKMNSxBaZ2aPgzhq5VUPOfhSfefHdm4kUxUj5w=;
	b=UtQzpOKWG4FVL10knLEBsVvhgGrgYKEb4+QwDvYdYC7QpuO2wqJreatWBfELJF7F3xMyZz
	5sZGBAN8L2ivS8wPDlJf/RNIwqXoQaXxUTXXKv9vce5fPS5hYxEtX1d3tA1l5NuMvgGhLd
	5joJPdHjnUCBmH0+t9lxWZ8j15o50rc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-r-wqDeBjMjKTlNAkqEu76Q-1; Thu,
 08 Aug 2024 11:13:45 -0400
X-MC-Unique: r-wqDeBjMjKTlNAkqEu76Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B652196E033;
	Thu,  8 Aug 2024 15:13:43 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D175F300018D;
	Thu,  8 Aug 2024 15:13:39 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:13:35 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Savkov <asavkov@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/rseq/Makefile: fix relative rpath usage
Message-ID: <20240808151335.GA5495@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executables are run
from elsewhere.  Changing it to $ORIGIN makes it resolve relative
to the directory in which the executables reside, which is supposedly
the desired behaviour.

Discovered by the /usr/lib/rpm/check-rpaths script[1][2] that checks
for insecure RPATH/RUNPATH[3], such as containing relative directories,
during an attempt to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/rseq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb58..27544a67d6f0 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -6,7 +6,7 @@ endif
 
 top_srcdir = ../../../..
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/ \
 	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
-- 
2.28.0


