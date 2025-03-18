Return-Path: <linux-kernel+bounces-566415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D50A677B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641453B9701
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27620E71B;
	Tue, 18 Mar 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVu5yFpS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6320E024
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311483; cv=none; b=odVk6oovuqwtf0cco6kcpBmgUknZxc9kqnFEjY4wtTJnwaVoiZEZwaa+XnYaMJX0UbzJGv3rwv1PP5Fby706ZXYHfmh6LgfsYR6C2QhYW6qIkO/EEvdpE7YM7tbxNkLo2Rknuj+ogH+w8OEYTE7674KYdCYKD6A0Tkuv9SQVwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311483; c=relaxed/simple;
	bh=nwUVJN4gAnpHbpMJTe6ZpZkbPRBWjH0WP7Gslu1wwWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOiRjzv5Gn11KMPNH/iCkdbBiMGRp+jozw6ZkKPXQatzhnS4qyz5S8hQG1ibNc6pJGMN+eTmmqFDl6bpizwMBX0u/EtTs75Bv5WTD4z4t59/QFx8hULCKsTa9hMD3kYQ8IS/v6vezDj1w+l7TO8a7Bzor/2a+aqTMgg+iHEHPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVu5yFpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
	b=iVu5yFpSh6YY/R2Y1T3vvDrSQhgcHHVW6N2yAz8j7fAiIxnlrhRkmTBRWmC5FwI43dPzq1
	2ozHuS8wcDoHf6yEqdkx/reVdtspJQJ2kt8I8nxCPX4YjepzSE9mvq7K/fBB1HpO1EWGkE
	u+P1g9pvyR56AFNllUTrw3i+2n/j9QA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-1YtoZJ42PnKdrpky1w0sMg-1; Tue, 18 Mar 2025 11:24:35 -0400
X-MC-Unique: 1YtoZJ42PnKdrpky1w0sMg-1
X-Mimecast-MFC-AGG-ID: 1YtoZJ42PnKdrpky1w0sMg_1742311474
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac316d639d2so536926466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311474; x=1742916274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
        b=ES3rXmrgWTLz8Sv33BwgoKR+JoAkQpi7KTYbnnJtkgrE68rWcurpQ+gZyhl5XCNLOX
         b40RRjUTJHXTRAG4EK/bVVukiyUDhe6iQD3bDNm8gX1m6Meadbp+dsRNCqQg2JTcwYDn
         J53ensScVUBLeAfYtFbr3S8UWCsMxqz1Etdg2bexKUGz2XBtr3Wjdq1U3+k+qj7kOZje
         KAFNVectCOMm1aq/K2aXWWV4CmiL6rSnbIUV5by+w4qW5l2LsU+h2TspxnVMPPUBNJkU
         zppzKqNdrYUH3gvSsFE3yJC86Eo97M55MmOwequqaooXJZnW+2utISrW9zt3hMic+da8
         mlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8/mFlQL7CXAXOrG1rQe0ePnEwjCt39+B6MRv3Yzv2alwkCo0r9EzS8kTg0KZT08LgDsYF6HUW31vEqVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuZGv/fYg/qWjqF7l9aoZ52fhG+3uK0x1ZzHfV2D/T15KuU8r
	GJ/3oV8VLkIwmr6pZVqz0v1IGBq+GW38STSIyxjWpj1BjTRWc+RrZKc3D/RG3zhaNGpWdJSvqXn
	ZzM4iGhlR+H++F7wfXsswizIWSX75/MZxEAoDTlR7jCdtCujNoyMV2UfZwtqfBg==
X-Gm-Gg: ASbGnctYFv0bjJTiOB6Oh3voA2TB1aBEs4E1ld4ZcaQxANjCpP4RYeeYEq3lmy58HQb
	+Oy7w74OBOYAHI3QOHCOH7vsq9GrrHqQCF9lrMElGDkzlbidddLOxr6zYQp91abfWcR8khCTt6G
	POdr8v0raEY3LNKOVbzIiCnRdsEHa6V+F0SCsg5MqBsICQvGjTG759f6VIZAQvrZP+TEGopgt6O
	uYveX8wyKZkaqfkffGilcv6J2VU5t+bROw8924AnwGfZ0hst/i6EqidjCMkEjJKg2JKuoEnw88y
	N78KO+tjZiPrcRq8y3I1HyJHoFxgFcE4UDQ6S2R8Ec2O4JQf0FYbsGHA3UMebENq
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889901766b.10.1742311473956;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKgdyBOe4N9SqzNdQv0/ja/tFgBWXAA/B9X5QxvZp4bZLbnQYU/EpiDkc3dvPqkEg8rOP6g==
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889895666b.10.1742311473178;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac37dc4e0afsm292211266b.21.2025.03.18.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:24:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <tjuxwbbkwyi2ggjv6744h27rkk3kjhdbkv6mnzflg22brhakzq@dvcduolqwhl6>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>

On Fri, Mar 14, 2025 at 10:27:33AM +0100, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur[1].

I'd add something like this:

"... does not occur. The bug was reported upstream [1] and fixed with
commit 2cb7c756f605 ("vsock/virtio: discard packets if the transport
changes")."

>
>Note that this test does not fail, but it may hang on the client side if
>it triggers a kernel oops.

In my case the test failed (I guess the other side that was still
working), so I'd say: "Note that this test may not fail in a kernel
without the fix, ..."

>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is safe to assume that the bug will show up within the timeout period.

s/safe/reasonable

>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.

The rest LGTM.

Thanks,
Stefano

>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>This series introduces a new test that checks for a null pointer
>dereference that may happen when there is a transport change[1]. This
>bug was fixed in [2].
>
>Note that this test *cannot* fail, it hangs if it triggers a kernel
>oops. The intended use-case is to run it and then check if there is any
>oops in the dmesg.
>
>This test is based on Hyunwoo Kim's[3] and Michal's python
>reproducers[4].
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
>[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
>[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
>---
>Changes in v2:
>- Addressed Stefano's comments:
>    - Timeout is now using current_nsec()
>    - Check for return values
>    - Style issues
>- Added Hyunwoo Kim to Suggested-by
>- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o msg_zerocopy_common.o
>
>+vsock_test: LDLIBS = -lpthread
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..d2820a67403c95bc4a7e7a16113ae2f6137b4c73 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -23,6 +23,7 @@
> #include <sys/ioctl.h>
> #include <linux/sockios.h>
> #include <linux/time64.h>
>+#include <pthread.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1788,6 +1789,101 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void *test_stream_transport_change_thread(void *vargp)
>+{
>+	pid_t *pid = (pid_t *)vargp;
>+
>+	/* We want this thread to terminate as soon as possible */
>+	if (pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL)) {
>+		perror("pthread_setcanceltype");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	while (true) {
>+		if (kill(*pid, SIGUSR1) < 0) {
>+			perror("kill");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+	return NULL;
>+}
>+
>+static void test_transport_change_signal_handler(int signal)
>+{
>+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
>+}
>+
>+static void test_stream_transport_change_client(const struct test_opts *opts)
>+{
>+	__sighandler_t old_handler;
>+	pid_t pid = getpid();
>+	pthread_t thread_id;
>+	time_t tout;
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+	if (old_handler == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>+		perror("pthread_create");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		struct sockaddr_vm sa = {
>+			.svm_family = AF_VSOCK,
>+			.svm_cid = opts->peer_cid,
>+			.svm_port = opts->peer_port,
>+		};
>+		int s;
>+
>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>+		if (s < 0) {
>+			perror("socket");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		/* Set CID to 0 cause a transport change. */
>+		sa.svm_cid = 0;
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+
>+	if (pthread_cancel(thread_id)) {
>+		perror("pthread_cancel");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait for the thread to terminate */
>+	if (pthread_join(thread_id, NULL)) {
>+		perror("pthread_join");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Restore the old handler */
>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_transport_change_server(const struct test_opts *opts)
>+{
>+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>+
>+	do {
>+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
>@@ -1984,6 +2080,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.run_client = test_stream_transport_change_client,
>+		.run_server = test_stream_transport_change_server,
>+	},
> 	{},
> };
>
>
>---
>base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
>change-id: 20250306-test_vsock-3e77a9c7a245
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


