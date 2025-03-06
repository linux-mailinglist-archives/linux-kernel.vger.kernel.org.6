Return-Path: <linux-kernel+bounces-549283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16385A5504A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A0174D79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D092135BB;
	Thu,  6 Mar 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR/9pTWb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA4211A29
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277437; cv=none; b=HjxZfNGwp/1E1Yie6skoEKw/OdSpgNdBSosNUqpaHEba+TxmZLPgt/R4CZn9wgps3f1WHZVLR4QMWXqFwdQWmp7MbSywBkzQtCDfQNkSTx41m5CrFF/eSobqhk2Ugw1Bz/mbk6RzEn3ogaW4T5VhfIYjyIbV0XaFyPWvq7qiTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277437; c=relaxed/simple;
	bh=dH/liky2S790rXQUDoT6Q59xxP9nXr32e65ycj/6+SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fp9pefUAnXatJLs/jJLcx32wS3k8lR3mUYQ/Y+xDI6IeIvN9SfUWM/VHYxwyhiNyYLictF50qKqzEefxgJ8ag8AKnCk6l08khEZeisDAgmWzda/GrOv2PEXvk+nhCb7QcgjPyVykQ8kE8NdJRrLcPTWHDbqnW/+oifJ+ldjhBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR/9pTWb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wmiDwuO87WXvvjC7I5fkwx86eSsk3osWKrPxbBFPG0=;
	b=VR/9pTWbis9m8iTxoOw0WA5Y2CZQLOiTCybJt46RsTMepx6e/m5rv+rRSFT/bUa9nABdRe
	EvycaIupBosPpiEngy6pBHADDSakkqSo1+Lr+fMj7CNSV/Tq9xyPK3ku4Gs/mTVc2A8sCV
	cNg+NJkuNTFxG8I+QkfVz0ny9xr3dKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-QDyC1pWOOrKEr6gC3D759A-1; Thu, 06 Mar 2025 11:10:33 -0500
X-MC-Unique: QDyC1pWOOrKEr6gC3D759A-1
X-Mimecast-MFC-AGG-ID: QDyC1pWOOrKEr6gC3D759A_1741277432
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390de58dc4eso918254f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277432; x=1741882232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wmiDwuO87WXvvjC7I5fkwx86eSsk3osWKrPxbBFPG0=;
        b=gfH/Iuho0appdUzGZvxN2EQ+CUpM3Ie47rf6rAE44kmELs5h2LxZquibumHuxYYd+x
         xCOwS9zmKOKogxXJ4+T1HwdvOCHAogF3H4H3zK/ovTIeyOVHmb4QBe1vmMKIDHyXXCQ6
         OGNRCpQxifZEc58ntUh1C0TxISQjZ4ssSkx+oeHnnI1qrh79Zcdd7M7qSc/mKVJ5z3m4
         CuhkH5DA+lLYIJcmtBVDwXVs5SpEjhwevuTG2FFsN9SeTAz2DCt/iPb0i1CtVUA8Svau
         IgsnL5D8ClY9lBHLd9msDtvPWgROGKFZRY07biO4FffKB5VYs6sHKHBvEMNMc9CImbU0
         PgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn3ihSij8QXbRM8Va8rtw7Ov1SnSfu5YOukWto5i+5ma8Lfwgh4aay7Q38N3ngWKOaxecvkn+0YklQUoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJDTxl8Id3oeGEnSK4ZgeuYiFpvrXUMPtN0iDSY9cnkdOeWtp
	TKXZDVxp9KC8jVsNQKEfnZcuuJeaKprs4O6+ITfg2eMzSE6HEgSGFCIwHix/5Kv+CbPycnYjyIU
	L0Am2tV8JPUGMdC1kYF8W7MSQw4mTSsw4rXFWfCv/MmDT6GE7pBENmwHzOlnbVdkfZ9eciH+HZB
	BRz9zFYF+YW5N2h//XnxLEEbInuuxRuJICe5sWXP4sFZrdyw==
X-Gm-Gg: ASbGncuD2p+SRft+8nT549zvb9sEea6lNQiUD6S+ymLh4NAHsfzv/CaSGpvkJJl1MBJ
	BWpVyv2RJS84OEuqLCzDSIBtRnjcZFvwlzaW5ev3SFjgoUJIc1lq1NjR8WzLYctSzHkfwLRHdWP
	CCD0ufxReMfqu6VcC56m49AAnCaRhqWdjBngvnzuTz+oa081mBFNwQXr+GtXopXLx44V3yYxpK1
	Puao39eU2TNtqYN1CKBU6Im97I16sGMPj+ihmCHOaHYxXFBPpwpl+WYo+Hag2KNsgP1834CLleY
	Qppvsi+fnhGoRRWptPqJiPv4S9a0dCTwL2H89H4Cm87O
X-Received: by 2002:a05:6000:4009:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-3912d76bd8amr2989269f8f.46.1741277431948;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExwfJ06CMtW3KsVMBD+eH+joBC1GGZThpXp/juD50SY5XTPBpyNFwL84JMOfifMG26Ysc25A==
X-Received: by 2002:a05:6000:4009:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-3912d76bd8amr2989207f8f.46.1741277431517;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 06 Mar 2025 17:09:33 +0100
Subject: [PATCH net-next 2/2] vsock/test: Add test for null ptr deref when
 transport changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
In-Reply-To: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Add a new test to ensure that when the transport changes a null pointer
dereference does not occur[1].

Note that this test does not fail, but it may hang on the client side if
it triggers a kernel oops.

This works by creating a socket, trying to connect to a server, and then
executing a second connect operation on the same socket but to a
different CID (0). This triggers a transport change. If the connect
operation is interrupted by a signal, this could cause a null-ptr-deref.

Since this bug is non-deterministic, we need to try several times. It
is safe to assume that the bug will show up within the timeout period.

If there is a G2H transport loaded in the system, the bug is not
triggered and this test will always pass.

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/

Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/Makefile     |  1 +
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
 vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
 vsock_perf: vsock_perf.o msg_zerocopy_common.o
 
+vsock_test: LDLIBS = -lpthread
 vsock_uring_test: LDLIBS = -luring
 vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..1e00cb6e117859d5c18fb3e52a574444b5489173 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <linux/sockios.h>
 #include <linux/time64.h>
+#include <pthread.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1788,6 +1789,80 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void *test_transport_change_thread(void *vargp)
+{
+	pid_t *t = (pid_t *)vargp;
+
+	//We want this thread to terminate as soon as possible
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+	while (true)
+		kill(*t, SIGUSR1);
+	return NULL;
+}
+
+static void test_transport_change_signal_handler(int signal)
+{
+}
+
+static void test_transport_change_client(const struct test_opts *opts)
+{
+	__sighandler_t old_handler;
+	pid_t pid = getpid();
+	pthread_t thread_id;
+
+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
+
+	pthread_create(&thread_id, NULL, test_transport_change_thread, &pid);
+
+	timeout_begin(TIMEOUT);
+
+	while (true) {
+		struct sockaddr_vm sa = {
+			.svm_family = AF_VSOCK,
+			.svm_cid = opts->peer_cid,
+			.svm_port = opts->peer_port,
+		};
+
+		int s = socket(AF_VSOCK, SOCK_STREAM, 0);
+
+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+
+		sa.svm_cid = 0;
+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+
+		close(s);
+
+		if (timeout_check_expired())
+			break;
+	}
+
+	timeout_end();
+
+	pthread_cancel(thread_id);
+	//Wait for the thread to terminate
+	pthread_join(thread_id, NULL);
+	//Restore the old handler
+	signal(SIGUSR1, old_handler);
+}
+
+static void test_transport_change_server(const struct test_opts *opts)
+{
+	timeout_begin(TIMEOUT);
+
+	while (true) {
+		int s;
+
+		s = vsock_stream_listen(opts->peer_cid, opts->peer_port);
+		close(s);
+
+		if (timeout_check_expired())
+			break;
+	}
+
+	timeout_end();
+}
+
 static void test_stream_linger_client(const struct test_opts *opts)
 {
 	struct linger optval = {
@@ -1984,6 +2059,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_linger_client,
 		.run_server = test_stream_linger_server,
 	},
+	{
+		.name = "SOCK_STREAM transport change null-ptr-deref",
+		.run_client = test_transport_change_client,
+		.run_server = test_transport_change_server,
+	},
 	{},
 };
 

-- 
2.48.1


