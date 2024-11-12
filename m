Return-Path: <linux-kernel+bounces-405427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D799C513C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B77BB2638A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF81EBFFD;
	Tue, 12 Nov 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da4yR2Y/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970B20BB3D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401447; cv=none; b=rzAYfXpZBe9OLGQRk2Z4RXGp//WizBm/+WPOVNIqmn2do9axWMKFNdccLUxef6jnYUdlLpj/GUYg0/LfQZOvnfw3jQJ2qdPC8lgpCSYxhU0fc66WyESgG1x6b2pj6fVePTX4TtJS9KZtsizro7UINPRD6XzezmuxAxdYZ4XNPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401447; c=relaxed/simple;
	bh=luoFRSWcfvkfY1Y/zBf3awig2dLMcz5WWZVKScK/OSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUXVdw/GIp5fgLLalztAJlUjX2ABF4uSOn7HdZXGV2I6ZXDnrQjizeGraddVIvbCM5CfbL52vLwAB2jK1LRIeYRGhVo125p/yf+2/6+TVCjdFLxQEyUaZOz+wmF/EIqytKKFL5dP54KtVRl+MfN5MM7qvzdbjfeZCIdbla/3Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da4yR2Y/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731401444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nXJbGAvBHX1lqtvBc3YXqwLY83vC6FhyFyUNvjUgI8=;
	b=Da4yR2Y/b9LNu6rWfAtFQQWA9RNoV6V+QlThZqNtqZ/eVvS8A5j0eqL1GQkNHf4ew7+B0v
	e+fnTKlsL+q53yrHLnpea+XocUetWl3Z4PLsxu9qPOU1vqRnjbR21GHF1/jBYbTLglSIVN
	Z0yLku2X76fFwHFEkyrQEFAInWtXIVE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-qi14zxJDMOyTbgy3y4w6QQ-1; Tue, 12 Nov 2024 03:50:43 -0500
X-MC-Unique: qi14zxJDMOyTbgy3y4w6QQ-1
X-Mimecast-MFC-AGG-ID: qi14zxJDMOyTbgy3y4w6QQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c937403b2bso3855270a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401442; x=1732006242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nXJbGAvBHX1lqtvBc3YXqwLY83vC6FhyFyUNvjUgI8=;
        b=pa95PBdBdGQI9W50swFyovO0a2yB4QTFt3w2XWHvP7XaJaUoZhc916SfoGE5iFB2KY
         Sysjg5P2HcQw2rOLPcHF3MgfW0B8xSXYPIvOddKE3Mg9z18IjJz3Mjd/cdYszlOwAvYl
         WVzVAqyZqWBYvWMPf+KXyshdSWuO4Uw9zjvmQcMfMtgeZz7HslvbBtl/+u51qKeJzi+Y
         Bu8Nu9YLL8hVaEkc7vdpruT1awz2PTarvI9g9vixiJpS7/UXxxAi1Gu8tml5pNXBeI1L
         2n+UdgylrlpF5sJzAcJfa6vYrnUdjPslrQjf487rhS3qQDOv+9EOD+CwZSu4zrT1HTlu
         pMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hFCR4g4lXFrfcwIfTluaEZF8HxkaWtE6SvroDfAJzQormgN/BmYlwzU8gxK08S+Ud3UL5fdOfrUlPAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywelht9syRxRQ3zkMchYaxalIFBeD1nu/SObpzmUXpPohRNmJHn
	owi9G9ihfE5pjI8V2X+OovNFuQnguhuoi5iJJk9S0tINWuIL/KTI5fM95JMbbgXjN4syUVFnr9y
	sGrR0GqYKBT9v80t6v/XWgS8QouLZfG54AzqNmehyp6WoF8xO/mO1XPG8fdgcoA==
X-Received: by 2002:a50:935a:0:b0:5ce:fb4a:6aaf with SMTP id 4fb4d7f45d1cf-5cf0a3247c3mr9930447a12.20.1731401441872;
        Tue, 12 Nov 2024 00:50:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsLia/7hEIlYxDqgzc5l9QRSITxhqmo24fGLrFFIlS4C3vrg9AnfPGQp34D8VxeyfudIbKIA==
X-Received: by 2002:a50:935a:0:b0:5ce:fb4a:6aaf with SMTP id 4fb4d7f45d1cf-5cf0a3247c3mr9930421a12.20.1731401441149;
        Tue, 12 Nov 2024 00:50:41 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d7dasm5806136a12.13.2024.11.12.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:50:40 -0800 (PST)
Date: Tue, 12 Nov 2024 09:50:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 2/3] vsock/test: fix parameter types in
 SO_VM_SOCKETS_* calls
Message-ID: <vkhtpmsywr5rmahhugqf6vpltrab35cmf5i3j7tlss64tncoxy@kohxvui2dmlc>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-3-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241108011726.213948-3-kshk@linux.ibm.com>

On Thu, Nov 07, 2024 at 07:17:25PM -0600, Konstantin Shkolnyy wrote:
>Change parameters of SO_VM_SOCKETS_* to unsigned long long as documented
>in the vm_sockets.h, because the corresponding kernel code requires them
>to be at least 64-bit, no matter what architecture. Otherwise they are
>too small on 32-bit machines.
>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Fixes: 685a21c314a8 ("test/vsock: add big message test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_perf.c |  4 ++--
> tools/testing/vsock/vsock_test.c | 22 +++++++++++++++++-----
> 2 files changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 22633c2848cc..8e0a6c0770d3 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -33,7 +33,7 @@
>
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
>-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static unsigned long long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
> static bool zerocopy;
>
> static void error(const char *s)
>@@ -162,7 +162,7 @@ static void run_receiver(int rcvlowat_bytes)
> 	printf("Run as receiver\n");
> 	printf("Listen port %u\n", port);
> 	printf("RX buffer %lu bytes\n", buf_size_bytes);
>-	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
>+	printf("vsock buffer %llu bytes\n", vsock_buf_bytes);
> 	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
>
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 7fd25b814b4b..c7af23332e57 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	unsigned long long sock_buf_size;
> 	unsigned long remote_hash;
> 	unsigned long curr_hash;
> 	int fd;
>@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>
> static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	unsigned long long sock_buf_size;
>+	size_t buf_size;
> 	socklen_t len;
> 	void *data;
> 	int fd;
>@@ -655,13 +656,20 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>
> 	sock_buf_size++;
>
>-	data = malloc(sock_buf_size);
>+	/* size_t can be < unsigned long long */
>+	buf_size = (size_t) sock_buf_size;
>+	if (buf_size != sock_buf_size) {
>+		fprintf(stderr, "Returned BUFFER_SIZE too large\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	data = malloc(buf_size);
> 	if (!data) {
> 		perror("malloc");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
>+	send_buf(fd, data, buf_size, 0, -EMSGSIZE);
>
> 	control_writeln("CLISENT");
>
>@@ -1360,6 +1368,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
>+	unsigned long long sock_buf_size;
> 	void *buf;
> 	int fd;
>
>@@ -1371,8 +1380,11 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>
> 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>
>+	/* size_t can be < unsigned long long */
>+	sock_buf_size = buf_size;
>+
> 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &buf_size, sizeof(buf_size))) {
>+		       &sock_buf_size, sizeof(sock_buf_size))) {
> 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> 		exit(EXIT_FAILURE);
> 	}
>-- 
>2.34.1
>


