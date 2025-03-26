Return-Path: <linux-kernel+bounces-577223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188EA71A13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252213BA4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831E1F3BBB;
	Wed, 26 Mar 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVTDW/zh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C71F3FE4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002074; cv=none; b=hhu9fJ84y1JMXvtbeGlH1LLrhWRrpBG8c4Iqa5Og7oDBJbFJ3HKUWUUR50YtXworBZZjiHY0eCajVCAoTv/Grpf9xiQ37OIaB1YFoCfVoUU60AEVyLJ3kKE/uo7X0gF7V1Z8jrqEybbXSSdNfR9rGGTEc8CLpv4bT8iNbMlksoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002074; c=relaxed/simple;
	bh=HQUnbYOHztWJlIEUmRKH75bQVKxvC05Z8Czi7nqAq54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkNfMEf2Qyifnev3vJD1VkGDwl+SJ22zBQGprMPbMUz085VkLOBs+65GoRI/b3HZRbOzX5mprisQkeSk1ruWmwxoFp1abcR+CkLP6ckpX8WzFDdEyJHxZpMOg2Y5YIwZxWsfQtmzLhBgXFc98ZMnE1F9nu+UADznNtoUxXHuxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVTDW/zh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743002071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
	b=GVTDW/zhf6/841cMVC7hl7NH4bv37HoMK5xQlYndV7D1YbfyM/Tqbx//kpgvtUJr/NSI0M
	Fgb/yK10+tCwLfZFtPCvGw4lpVVTpcwLO2jtUlJJG5gUBtRkW3slKzweMXEnYEpx/adqEk
	BhbeG/33j6ItnfIPCDNepqjK1R22374=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-XL-RHwYyMwml1m_ipFtqrg-1; Wed, 26 Mar 2025 11:14:29 -0400
X-MC-Unique: XL-RHwYyMwml1m_ipFtqrg-1
X-Mimecast-MFC-AGG-ID: XL-RHwYyMwml1m_ipFtqrg_1743002068
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso1304180f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002063; x=1743606863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPLJoTpj9mwt9aNlegdCeCagVemKudQjbGtSj2yURtA=;
        b=hgNP/NnXWS6NgqJYaN6wu/p9UXMEw7nCXYfTzZnt+BLhK8kpMNLxJWIhoaK1tYXlJS
         WJm2VznfT042PowJwy5jrTkVZ2vrF0p9aVRsD2rJAGp2QJ/l2W4d6I93ogCu4kOcLoCf
         8hjn/t94rtvQk4GiHKd79SnGUA2W9DfIapLud7gccoiNwuDfsO6Gz9gxw/GUCZL7JKt2
         QSKNuf7/mNgdpXKbq55bICpZnlUotL/w6ptrDJyJZbmmlKNKAbpJkwILNV4K8IgD1mg9
         MrLdvw/w44kf/fxNprYlkCAQzb06eM3gTPLZyMXSZe4RxNgw7wJwBh0hR7uQfcmPMUYD
         aPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJnNp85ptZalxkEyIkeMtV7hlnxl3ioKUTrnFhcDLzRBDOuFlXsnRwrz6dj0BRFThehgeeGGRgyUVJgg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5Ivp8QEoiJg/MR+8kU+iC4iuGEXqJGpvIsHW91gEXZ9hy+Ki
	QTbHOfHNi5yJBK13OA8Ux1A9osYnTwwbxnSJYCeomGnFu7H5pNGI30qHHQdLBIDgwxBrKsJ9OLw
	Zeh69FY1aFKb7H6J5HnnkcJYr8a22ztMWvx02IBf4RwmckkfwlVSQBOmk3p+INeSQQavfqg==
X-Gm-Gg: ASbGncv6w1ij13MbHW/UgagHn2oVDtrA0D5h8F1eFrLR3coHDSjbq2DnowZOmBfxHQa
	oWXctYvOxKrYxnN3ZPycgXmqYXDb8c9gg82HgxNWRhjJef+TYXhYIwh/EDOsnyN8ZOBVZOO1rXG
	osukd1WH56jnKbfSClEOQT9Ggt4cDxhVp9J7AMbb1M4yfo5DP9FJwa28brZkO4un6inFBPFjgvE
	L19MZprCvo+iMX0/iWaupeDGrPQZ8gRNONwdwdV6rV+Nz9ZUBRACc6pzwiLYiXKasUn/CQ9abe+
	UbGnZNJSYLvBKrEMDw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794408f8f.25.1743002063259;
        Wed, 26 Mar 2025 08:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDszGJVF0UQWbzTWPDs66IMD9GSVlTSXE4mrjhgf35Uxdu3u5FMnMzdvDiVttQywI4kT7Hw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr21794380f8f.25.1743002062777;
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm4960435e9.17.2025.03.26.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:14:22 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:14:20 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>

Hi Michal,

On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>On 3/14/25 10:27, Luigi Leonardi wrote:
>> Add a new test to ensure that when the transport changes a null pointer
>> dereference does not occur[1].
>>
>> Note that this test does not fail, but it may hang on the client side if
>> it triggers a kernel oops.
>>
>> This works by creating a socket, trying to connect to a server, and then
>> executing a second connect operation on the same socket but to a
>> different CID (0). This triggers a transport change. If the connect
>> operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Just to be clear: that's the splat, right?
>
>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x44/0x70
>Call Trace:
> virtio_transport_do_close+0x68/0x1a0
> virtio_transport_recv_pkt+0x1045/0x2ae4
> vsock_loopback_work+0x27d/0x3f0
> process_one_work+0x846/0x1420
> worker_thread+0x5b3/0xf80
> kthread+0x35a/0x700
> ret_from_fork+0x2d/0x70
> ret_from_fork_asm+0x1a/0x30
>

Yep! I'll add it to the commit message in v3.
>> ...
>> +static void test_stream_transport_change_client(const struct test_opts *opts)
>> +{
>> +	__sighandler_t old_handler;
>> +	pid_t pid = getpid();
>> +	pthread_t thread_id;
>> +	time_t tout;
>> +
>> +	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>> +	if (old_handler == SIG_ERR) {
>> +		perror("signal");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>> +		perror("pthread_create");
>
>Does pthread_create() set errno on failure?
It does not, very good catch!
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>
>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
Yeah it's probably excessive. I used because it's the default timeout 
value.
>
>> +	do {
>> +		struct sockaddr_vm sa = {
>> +			.svm_family = AF_VSOCK,
>> +			.svm_cid = opts->peer_cid,
>> +			.svm_port = opts->peer_port,
>> +		};
>> +		int s;
>> +
>> +		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +		if (s < 0) {
>> +			perror("socket");
>> +			exit(EXIT_FAILURE);
>> +		}
>> +
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		/* Set CID to 0 cause a transport change. */
>> +		sa.svm_cid = 0;
>> +		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +
>> +	if (pthread_cancel(thread_id)) {
>> +		perror("pthread_cancel");
>
>And errno here.
>
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* Wait for the thread to terminate */
>> +	if (pthread_join(thread_id, NULL)) {
>> +		perror("pthread_join");
>
>And here.
>Aaand I've realized I've made exactly the same mistake elsewhere :)
>
>> ...
>> +static void test_stream_transport_change_server(const struct test_opts *opts)
>> +{
>> +	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>> +
>> +	do {
>> +		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>> +
>> +		close(s);
>> +	} while (current_nsec() < tout);
>> +}
>
>I'm not certain you need to re-create the listener or measure the time
>here. What about something like
>
>	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>	control_expectln("DONE");
>	close(s);
>
Just tried and it triggers the oops :)

>Thanks,
>Michal
>

Thanks for the review!

Luigi


