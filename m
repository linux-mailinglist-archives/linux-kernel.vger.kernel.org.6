Return-Path: <linux-kernel+bounces-385075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB19B3211
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4891C21CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABEE1DDC24;
	Mon, 28 Oct 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkdRhuFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901E1DD88F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123106; cv=none; b=GHNlt3KE7xQbJ52ZVS3Ss3mMl3Nq82Kcq/KI0HjgqDrV7lXo9x0scCbhwRZvpRjCM277jYauRg2Z9FzbW+3y8qNoJzchSuYKOQulTtGfKkIGXYlw0JdS6Lt4lfQWaXvdzOjOV/cAKf95maOanf85MDCEi6b1nB9OxcKKYiJqY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123106; c=relaxed/simple;
	bh=aEs7wkOs/9Tmtuzmg6k86fkOGprpHMB9+QFgot8mjSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMHVcdSyImEyOO0dhrOvsztTuKuc2rI2otN7Rox0GU0I3tdSCtFeyXkKtAASS53EHXFBzLxMADA1er0E1zenkcRr9pp+HpXmFr3tirzMbKn6MUHeyacGWo3Pm3GD1bY9UUQgUHOZWJibIXSg7vp8DlLMBnECs0Xjy/ni+PKOLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkdRhuFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730123099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
	b=IkdRhuFbA051yei2uVynZt2C59dh0b5EN4InXNxmndL/eKGoP1g7D5sGvH1j7G6w8Z4RfI
	7dM50i2h++R0IVY9ODdNXLSZyebcgg3EOzXBpywOunX98Fx0lidPtT00HMLtOShGhX+xnj
	FTuxHuKz63lh9KWUa1bG/LFfpHeZzMM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-k_cANhDHM6GpYi13mbtwjQ-1; Mon, 28 Oct 2024 09:44:58 -0400
X-MC-Unique: k_cANhDHM6GpYi13mbtwjQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7ac8f684d9bso912118485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123098; x=1730727898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vGL1SVZq+LgfXtvaR3j6jeveiqx6XHBU95MSTDGVg4=;
        b=wU21IpHW0kyr6kectGyfP0pMWUifIX8czTCdk1GI3/d2hyMw5KQ+3Tp5u7lDZuWg9h
         /Uo6ABamP8sXS25Iyi+nWjV+HXSRiVgooLSrttJsHEHVey8ByBtuNOtmtAF/crGdCTQz
         uqVY0+yUpIYSZeySbYVAMBkLRPIhFH8nLrc5Dpj5ACf+kMe/YRgN8OxHjDFz8709Wtg2
         Qqny3IL5ysB0pmHDxO+ciRmmixKutxqJhiaEli3/npCsrpHCisnDqqNxQfhXelFCudUl
         5ECCnprlWl2EqqZ/w2rhAwYGIZqxTppauvtwmotkeh2/Awgz7TUoovTaB7UAn/Vc6h0N
         rmbw==
X-Forwarded-Encrypted: i=1; AJvYcCUej4iC7P0Q1f/3hbetPkD4y96dzsD4H0AP9fkqyen+WAWJp0xd51qQNHazg7uKE5ChgG1/bsP2vfo+LaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAR67tJ07KWzp1c0DGIn+JVdObzxbBkgrnllFFYLiDOFf2BHr
	TfPZEvdU7KmVX3A8xMV/jiYtClUOSa4ENo4v7OznTe4tximsd4Rnp5ackVZtondOmomCgTAfy3+
	/ea2fs+pkj5GUDLk7TCw/qSi+GLZwWq93AvkJ7JvPUzY0qNrwzKSOe9rOFU+w5w==
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447475285a.42.1730123097800;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYDCoi09rdBp6AbuPJnFmwQMjbUbwDykG7M6wD0fUANXJfHN4wHVrUUk5Lqyj/Lt6o3xbXOQ==
X-Received: by 2002:a05:620a:1a1c:b0:7b1:44f1:cb6d with SMTP id af79cd13be357-7b193f3f2d4mr1447469985a.42.1730123097245;
        Mon, 28 Oct 2024 06:44:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17973d8bdsm32521456d6.18.2024.10.28.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:44:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:44:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <s5mhlz5szowwse52t6u44u3despluqb2ucudmmolx55vmtvs2l@eptqoed2qwmv>
References: <20241025154124.732008-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025154124.732008-1-kshk@linux.ibm.com>

On Fri, Oct 25, 2024 at 10:41:24AM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in vsock_test failures, while vsock_perf doesn't even notice
>that it's failed to change it.
>
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> tools/testing/vsock/vsock_perf.c | 6 +++---
> tools/testing/vsock/vsock_test.c | 4 ++--
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 4e8578f815e0..22633c2848cc 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -133,7 +133,7 @@ static float get_gbps(unsigned long bits, time_t ns_delta)
> 	       ((float)ns_delta / NSEC_PER_SEC);
> }
>
>-static void run_receiver(unsigned long rcvlowat_bytes)
>+static void run_receiver(int rcvlowat_bytes)
> {
> 	unsigned int read_cnt;
> 	time_t rx_begin_ns;
>@@ -163,7 +163,7 @@ static void run_receiver(unsigned long rcvlowat_bytes)
> 	printf("Listen port %u\n", port);
> 	printf("RX buffer %lu bytes\n", buf_size_bytes);
> 	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
>-	printf("SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
>+	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
>
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>
>@@ -439,7 +439,7 @@ static long strtolx(const char *arg)
> int main(int argc, char **argv)
> {
> 	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
>-	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
>+	int rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
> 	int peer_cid = -1;
> 	bool sender = false;
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..30857dd4ca97 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -833,7 +833,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1282,7 +1282,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>


