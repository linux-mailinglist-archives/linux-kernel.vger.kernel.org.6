Return-Path: <linux-kernel+bounces-561075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D46A60D46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A32E3BAC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FC1F0E36;
	Fri, 14 Mar 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9NNkTFS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDF1EDA04
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944467; cv=none; b=O64tSuNQBNYgSaLQhmj+6KAOQcrPQ5wgGG9D5WCHuCEO5cH6eGwfA2nihgW9clCQzpQ+AcYzeEczRf07GH9vXVBvazVc/V/dEMOIskd73l1kCqoYmJUnO8nCpzND4v5Ww7C4/EJy07GgRv1Y+g3QwEOPT23/gmH61K7m1U2Ny7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944467; c=relaxed/simple;
	bh=/t0P6BIjsrspzg8W7rJyW+BbEb9bKSj4FEpCyA6N3Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KM4Uvy+t8M6BecYvd0ggetcVM9w6NHsS+dOsbMrhSZBSOHqWbenmHNqC6fCP2mf8XAfNhfPdFcfEHF3CceuKwW4qAf9fjYGD6OlVBQuEPxvOSI5L8aqUdcmf6/icV25YykYzTBGiy8+39K+wrhbHtpW2k5lJYZvIrQg1gIP8c7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9NNkTFS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SWIpivWMiiOzlANWVvS6TOJ0c+yC3px3JHXjQpmv1s=;
	b=X9NNkTFSCFdEKVdkNSlvyk6eB9YDoZyQ/HUuDq4fNge/OZbzfwbvkd4rZc+jevinEzYHf3
	mOE6Xht/Sx6u+pTmKJxNVz4gdGz9ToZi1uoWmETkAtlce6U0EnoGxEH6+WpC4cRl0rptnI
	4tCJIwaoa/u9wRRQpWPHKF5avX5O+Cw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-oVKpbcDfPK-YHbZ1YQg2jA-1; Fri, 14 Mar 2025 05:27:41 -0400
X-MC-Unique: oVKpbcDfPK-YHbZ1YQg2jA-1
X-Mimecast-MFC-AGG-ID: oVKpbcDfPK-YHbZ1YQg2jA_1741944461
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39141ffa913so1119105f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944460; x=1742549260;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SWIpivWMiiOzlANWVvS6TOJ0c+yC3px3JHXjQpmv1s=;
        b=omNy0QqsXMSdR4MZ6aEb25Kj43eLO5kDEe12zReFM9iQIpnJ0uBH5/T2P0F4f7GZoM
         nra48NtUNrJYna7rDRlxmcH09r+dsd1dd6TyU5vPqPAivl5onZpF8xNvfY2U1W8nz/ru
         p0PXJCrsDv5OvMvc+/qnSMWoqot9m7HS0mvA7rSk6TsVNCFDYH+Kl21YqMKFXvZ9RAZN
         ksgVIe9uJqyzpsmGjmUmEel7ZElrN/AqHuiZe8Y5VX0qCr1ydlaTnPBJ/+YIhquP6DwE
         uoKxurr2O6mh+wrLvBaCsu3Uy8KK/hsn5vyvMTnpGDoSqigyrDbnymcZC7ZpzqpCa8F2
         DBzw==
X-Forwarded-Encrypted: i=1; AJvYcCULLjjZ+lJBZvW5F/XxrH+NwX/YdKlGVmXYXQP+2+ku/1MzEc6KDZ/0vVT/u+IRaujsr7kIK3cNMbbrbQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSNFn4H+fbPEh34xxBgPQRkYAR2IusGq9AuORqCdBT9igZCE7
	DpbyvYfkJxgmHZlsqJ+NAPo2PipB7UVTQapiYiF9Q+mdAYx2pwuZzzFMpoIFera7eairnaN0NZF
	mQau5Uyn6NkkuZjcEHLF6u85Ce6JBYBPhnyvBLJWZYsLqd1STdKd4ng7JNuUgeA==
X-Gm-Gg: ASbGnct+bQJnW6d7yEZrWyj614O/R0PjoIEPW+GpFvfB0MEsIXfSR13BAhvKA7DbH4i
	At+RwJnNKu+mFHGy3/qnwUIQHXuDvuVRklZkl2ggL9JPQTtU4zCLyJ3yNQyoMikHn66PF3nQGxK
	N/wBKev1cFXsjwz5j+SyuHx8jiIa3O6jUlRiSs1/jx9TIOT9I476YVQ8On61jLlQKrqzrhaIxeV
	foqiZOB8FFKhUlvuQKeK8ZKlp3Z4P2nOUEYB3wFIqSha6+CC+RcAg2FQl8Wxaa+P9P368P0fPdy
	acg7e9Jhya50/S/ZjV+Wt6FeAMR1StY+JtBXPViMoe20
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr2176204f8f.9.1741944460599;
        Fri, 14 Mar 2025 02:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhOnfd8xQf89hKnxHM2+ss0zqT2fuewR91h/7320v0CwhxN16kbkeKvrNPnSiljEvdGmJmwA==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr2176185f8f.9.1741944460162;
        Fri, 14 Mar 2025 02:27:40 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm4860356f8f.23.2025.03.14.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:27:39 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 14 Mar 2025 10:27:33 +0100
Subject: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
X-B4-Tracking: v=1; b=H4sIAIT202cC/22NwQoCIRRFf2V46wxHM5lW/UcMYc6blEjDJzIx+
 O+J65aHwz13B8LkkeAy7JCwePIxNBCHAawz4YnML41BcKG45GeWkfK9ULQvJlFrM1ltxElBG3w
 Srn7rsRsEzCzglmFuxnnKMX37Sxm7/xcsI+OMS8Efyli7TuKacHEmH218w1xr/QEfz40MrwAAA
 A==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>, 
 Luigi Leonardi <leonardi@redhat.com>
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

Suggested-by: Hyunwoo Kim <v4bel@theori.io>
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2].

Note that this test *cannot* fail, it hangs if it triggers a kernel
oops. The intended use-case is to run it and then check if there is any 
oops in the dmesg.

This test is based on Hyunwoo Kim's[3] and Michal's python 
reproducers[4].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
---
Changes in v2:
- Addressed Stefano's comments:
    - Timeout is now using current_nsec()
    - Check for return values
    - Style issues
- Added Hyunwoo Kim to Suggested-by
- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
---
 tools/testing/vsock/Makefile     |   1 +
 tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

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
index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..d2820a67403c95bc4a7e7a16113ae2f6137b4c73 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <linux/sockios.h>
 #include <linux/time64.h>
+#include <pthread.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1788,6 +1789,101 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void *test_stream_transport_change_thread(void *vargp)
+{
+	pid_t *pid = (pid_t *)vargp;
+
+	/* We want this thread to terminate as soon as possible */
+	if (pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL)) {
+		perror("pthread_setcanceltype");
+		exit(EXIT_FAILURE);
+	}
+
+	while (true) {
+		if (kill(*pid, SIGUSR1) < 0) {
+			perror("kill");
+			exit(EXIT_FAILURE);
+		}
+	}
+	return NULL;
+}
+
+static void test_transport_change_signal_handler(int signal)
+{
+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
+}
+
+static void test_stream_transport_change_client(const struct test_opts *opts)
+{
+	__sighandler_t old_handler;
+	pid_t pid = getpid();
+	pthread_t thread_id;
+	time_t tout;
+
+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
+	if (old_handler == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+
+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
+		perror("pthread_create");
+		exit(EXIT_FAILURE);
+	}
+
+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
+	do {
+		struct sockaddr_vm sa = {
+			.svm_family = AF_VSOCK,
+			.svm_cid = opts->peer_cid,
+			.svm_port = opts->peer_port,
+		};
+		int s;
+
+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
+		if (s < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+
+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+
+		/* Set CID to 0 cause a transport change. */
+		sa.svm_cid = 0;
+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+
+		close(s);
+	} while (current_nsec() < tout);
+
+	if (pthread_cancel(thread_id)) {
+		perror("pthread_cancel");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Wait for the thread to terminate */
+	if (pthread_join(thread_id, NULL)) {
+		perror("pthread_join");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Restore the old handler */
+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void test_stream_transport_change_server(const struct test_opts *opts)
+{
+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
+
+	do {
+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+
+		close(s);
+	} while (current_nsec() < tout);
+}
+
 static void test_stream_linger_client(const struct test_opts *opts)
 {
 	struct linger optval = {
@@ -1984,6 +2080,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_linger_client,
 		.run_server = test_stream_linger_server,
 	},
+	{
+		.name = "SOCK_STREAM transport change null-ptr-deref",
+		.run_client = test_stream_transport_change_client,
+		.run_server = test_stream_transport_change_server,
+	},
 	{},
 };
 

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


