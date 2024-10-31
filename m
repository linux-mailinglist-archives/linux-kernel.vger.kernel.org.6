Return-Path: <linux-kernel+bounces-390633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC09B7C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8BF1F223E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595384A52;
	Thu, 31 Oct 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atALYINk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FE442C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384213; cv=none; b=INRPZxzaY+Ebx3jU6up/NkvwzWtI4dJXTouZ4Li8FsFC4jibP2J9P16H7D0xQDBaC9fL619zpHfjtWXiXS0y79Jcs09MHbaZd2QipxOVePbKhEA5/nXGE4MNmCdyQ1Kd5H3ny9EbGJu30/kSgyrZv6JxeTD40QqlFjuyvgCczEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384213; c=relaxed/simple;
	bh=cKLbfvOMqKQEtZ5qclELN1TR2T2jcygPLOGOX/rPHAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftDM7SSS4WWKRTAX6qF6SLne2xTOkY8/cHdfgV479w7W6p9311zyztwVwL3f12U5CoeTmeTRfxyQVUmMWtr5VSee9zeDYdabHFbjK7fs80/8537yTW/WfuJFggh/CJxRqCa5oG54tAytGchef2EUYTj/rmkQbiUVdVCA9v4zZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atALYINk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730384210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ovEB1StOJ3pznvYEcRDlXSyCfUgSPoZbfcLdse6q8W8=;
	b=atALYINknt7RqpmCCZwAq7BMbWnVZnUlyUd2sRLL4jIw3O0pM0kW6/bEHZpTIn1p2cvXxI
	Wfc9FpTx25MK65A+ABjNp4FXMpThId1xMYRLCURND6v8YxNsn913VZFb9l6qMLd6jZQQ2q
	tzZ5+HoPovI0Fhbak9uMLF62tjIvE28=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Wj53-5pNOvmOCrGwMscclQ-1; Thu, 31 Oct 2024 10:16:49 -0400
X-MC-Unique: Wj53-5pNOvmOCrGwMscclQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460c73093edso16053231cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384209; x=1730989009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovEB1StOJ3pznvYEcRDlXSyCfUgSPoZbfcLdse6q8W8=;
        b=m2DdH4nTg8KZA1heDe/SRdhVbuyW/PlzAu7pItvywllSoZ5wDgOXwg8a7bvhuDXoU0
         tAXtLF0YfTksm2ZouWDIS26cnZeZnaHdHBGHXI9f8/sWXyTop5ooWN+N7GI03sIwuEnh
         /jGsZcZSi7sCgoK1BPusUxfYbHGwXNp1mcZYLvxcbhVl5SYc5nUdXtzemadeC4v/n1gr
         V3bNctvHbXgwXfwOP5bIw8m883G71KK5rMCkMLjtM8766BtsjS53Mjq2DklAICtH1BAc
         jDsncQagrw3WP+LzcaIUcTVuRWzIZVvDCNIRXxodDanq291dE2QgHLh51RHXwo6ypW9V
         QcaA==
X-Forwarded-Encrypted: i=1; AJvYcCUs2Z7YMyaG721IS5ZHRCfO7w3UwFmw1bslxHX/Ol12c9HJyK5WXCbth36oIqQoAjyFUunursFga4bKAAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8P7PvFTsuTjqqMMnHHupKWJ+jtHEYLX/SYUFnd844F2A/C+y
	f/JL3+ScLDQxP0ktjUHgkWBdHZyABPbj+Vk0koQzCR0LYucZfsqxAjZP/8Z6OT+8Pq68ynysBc7
	dE355UmJKVd4bNZ7lba3vNgW/elAH2u/W2bsdSGVVN0DXEWTg9Q5MMu2BL1nKMQ==
X-Received: by 2002:ac8:5f54:0:b0:447:e769:76fc with SMTP id d75a77b69052e-462ab281dd7mr38992671cf.34.1730384208847;
        Thu, 31 Oct 2024 07:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3kzGANbJFLZsZsBNtKFVvhMspBrZjxm8HkCv2R3gtqqOdYfj7lK8iIiAbmNobSSw7VhuhVA==
X-Received: by 2002:ac8:5f54:0:b0:447:e769:76fc with SMTP id d75a77b69052e-462ab281dd7mr38991981cf.34.1730384208150;
        Thu, 31 Oct 2024 07:16:48 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.173.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad1b42ffsm7879231cf.93.2024.10.31.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:16:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:16:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v4 2/2] vsock/test: fix parameter types in
 SO_VM_SOCKETS_* calls
Message-ID: <7o2b3ggh7ojcoiyh5dcgu5y6436tqjarvmvavxmbm2id3fggdu@46rhdjnyqdpr>
References: <20241029144954.285279-1-kshk@linux.ibm.com>
 <20241029144954.285279-3-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241029144954.285279-3-kshk@linux.ibm.com>

On Tue, Oct 29, 2024 at 09:49:54AM -0500, Konstantin Shkolnyy wrote:
>Change parameters of SO_VM_SOCKETS_* to uint64_t so that they are always

In include/uapi/linux/vm_sockets.h we talk about "unsigned long long",
but in the kernel code we use u64. IIUC "unsigned long long" should be 
u64 on every architecture, at least till we will have some 128-bit cpu, 
right?

>64-bit, because the corresponding kernel code requires them to be at 
>least
>that large, no matter what architecture.
>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Fixes: 685a21c314a8 ("test/vsock: add big message test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_perf.c |  2 +-
> tools/testing/vsock/vsock_test.c | 19 ++++++++++++++-----
> 2 files changed, 15 insertions(+), 6 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 22633c2848cc..88f6be4162a6 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -33,7 +33,7 @@
>
> static unsigned int port = DEFAULT_PORT;
> static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
>-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+static uint64_t vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;

What about using `unsigned long long` as documented in the vm_sockets.h?

Thanks,
Stefano

> static bool zerocopy;
>
> static void error(const char *s)
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 7fd25b814b4b..49a32515886f 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	uint64_t sock_buf_size;
> 	unsigned long remote_hash;
> 	unsigned long curr_hash;
> 	int fd;
>@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>
> static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
> {
>-	unsigned long sock_buf_size;
>+	uint64_t sock_buf_size;
>+	size_t buf_size;
> 	socklen_t len;
> 	void *data;
> 	int fd;
>@@ -655,13 +656,19 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>
> 	sock_buf_size++;
>
>-	data = malloc(sock_buf_size);
>+	buf_size = (size_t) sock_buf_size; /* size_t can be < uint64_t */
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
>@@ -1360,6 +1367,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
>+	uint64_t sock_buf_size;
> 	void *buf;
> 	int fd;
>
>@@ -1370,9 +1378,10 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	}
>
> 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>+	sock_buf_size = buf_size; /* size_t can be < uint64_t */
>
> 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &buf_size, sizeof(buf_size))) {
>+		       &sock_buf_size, sizeof(sock_buf_size))) {
> 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> 		exit(EXIT_FAILURE);
> 	}
>-- 
>2.34.1
>


