Return-Path: <linux-kernel+bounces-577250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C44A71A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2816F3B35A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4051F3BB6;
	Wed, 26 Mar 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7WtAonl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23411F4193
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003162; cv=none; b=qvrgLhumvsemWGoTq6/wofYPHjojawWAR5XJgFFcj1vm6eCK//r9TWRJo17KjhqDYO82X0NXiQGRcnhVwPRcGCu1Fym85kxNPcC35NXkDd97ukv6Djf55DzZiTOBNMgvP68mz8+XEzi/zap9K73thI+zDv5WSA69lzIIMpOuJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003162; c=relaxed/simple;
	bh=3FJc+P6b3zzJcpkV8eK+FP3TgtJw7jYvpWP0TF2ajgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTocDMDeLW30ynSsNzrfXnGIwaZpPcfRfvjp2PzZFv5Y6xaLtEX19/3CUsa/DjCrHOqNYuxGcdVbtAe73KaM08n8MXHFJSej/dXYVLbssO9+nJ3Zxo+THhcMNTDFYz6h+FhPtWAAu+jWvFv+3hj1Totom34OwnhsBgZzTvxALIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7WtAonl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743003158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
	b=N7WtAonlr0t1Sl2SXdAVEzVAqyP2yHKw1ltaWCGcxqs5lrK7zIwCGXbwvdEVAsbZ+BOJee
	fQOOobfVWllsWPExOy+hNvMaWxps/LMZhJN/ShoAt/X2FAFMgdrZzJDyzjah9SNiSWwnC3
	UB8E7Mr3wbJygr3jbYvx4x9Ab2mAAAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-s1LNed1rNYmQWzo7Xzy9iA-1; Wed, 26 Mar 2025 11:32:36 -0400
X-MC-Unique: s1LNed1rNYmQWzo7Xzy9iA-1
X-Mimecast-MFC-AGG-ID: s1LNed1rNYmQWzo7Xzy9iA_1743003153
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d01024089so51731075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003152; x=1743607952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy6PJe0sMeoJhLcbhlkwSjbydSqh6/me/pxc/YeYWRY=;
        b=NE4f7pNgnlvOTqHAyqzepxy32f4vtO2rxA6x87bC58wnlXWDE4l1bIHkQ3ZRI0F+fH
         rEAEFcAP4c08gljGq2fWL1YDaxejpFzlqYVGfAfa50ktZ/ND4+wRsr1bRIeqvNk1A0id
         lnKZzi9i+67UjoYKCG1w5sE8tpZgrNqnHygXbKEsFpqkIssSRY6q8peFISFKwGZjZHUq
         Yzuebe5mF+MX6GGchxrmsz+MJd/oXZLN9ixcw90hW5kN5n3MgVJCgjiDL3opT6YrrrZo
         n7e3y6QZfVN0x+jr/MqYSXX7WVCfEZSXfa6+cmKDxAQMcwa1P0VPMkFNiYcPHWKLV1md
         oYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAIG2CqRhc4VWwG4JGEOY8UwogJMutxBnw48s70625bWumlcarlslkvG5snGWKY0UsXFZg3Ts6cP4vWfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMauwZnsMDnXcoxOi2Tjqf56mLqjHYmubO/7p3AmmT6AqItNdD
	zkfoS1p1bNcZsKc5IVxAUCB2ohA974K3uyCcoPfGh5SCLKONM+RZJv+DRJVcdrhWQc5LSKIxoWd
	hUQYgwXY2+Uo4Qhmm0Pdia1u2Pg1agq+6LPfWNYAeI+NAbohUqVZkGYIqCM3WUEuqz7ZObAy+
X-Gm-Gg: ASbGnctCqlGYSqv/UDxdE/uyti4J8XRIJeh0GFeesn8wcljPC9TT7win9V10u5v70YU
	hvppjKnsl+58rBuZoBphEggNgV6yU7O4p0dfGqbLV5CQPvWPUVcg42AhG46IwI86pLn4dnpP3Fl
	izU+VJybkRPNJ4rNEiL2E92VfCO4j80nBNQLFoXifoFEVeEChza9Zv4XcGBEzsOzgd4bKaBQFPh
	C+GOtAFjFxy10i5S4rjyb0QGJqtjmi01J+v+MQJVwXl6q7BRPTIRhBcTWfQ43DlZVD27foAkkZQ
	JmsHpal7l2wFiMDYt6OjL5R8KP5BUcQI16OMsHtiKIyy/Mla/NKPRnJ6ZXb2jc9L
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517305e9.12.1743003152356;
        Wed, 26 Mar 2025 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRLuNTDcftGdYLrF6TRN76YPNKGjROf60zN8Q6h9HxP9LzdIxTJHT5qWOkTTFeksKVqeo81g==
X-Received: by 2002:a05:600c:3d93:b0:43d:300f:fa4a with SMTP id 5b1f17b1804b1-43d58db553amr142517035e9.12.1743003151832;
        Wed, 26 Mar 2025 08:32:31 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e834a5sm5891945e9.13.2025.03.26.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:32:30 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:32:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <7ursz6zrffsljkvo25qvgaa5vroflpibtrgnz446ga36kzqtfc@l7v62brwdvod>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
 <85a034b7-a22d-438f-802e-ac193099dbe7@rbox.co>
 <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ghik6xpa5oxhb5lc4ztmqlwm3tkv5qbkj63h5mfqs33vursd5y@6jttd2lwwo7h>

On Wed, Mar 26, 2025 at 04:14:20PM +0100, Luigi Leonardi wrote:
>Hi Michal,
>
>On Wed, Mar 19, 2025 at 01:27:35AM +0100, Michal Luczaj wrote:
>>On 3/14/25 10:27, Luigi Leonardi wrote:
>>>Add a new test to ensure that when the transport changes a null pointer
>>>dereference does not occur[1].
>>>
>>>Note that this test does not fail, but it may hang on the client side if
>>>it triggers a kernel oops.
>>>
>>>This works by creating a socket, trying to connect to a server, and then
>>>executing a second connect operation on the same socket but to a
>>>different CID (0). This triggers a transport change. If the connect
>>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Just to be clear: that's the splat, right?
>>
>>Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>
>Yep! I'll add it to the commit message in v3.
>>>...
>>>+static void test_stream_transport_change_client(const struct test_opts *opts)
>>>+{
>>>+	__sighandler_t old_handler;
>>>+	pid_t pid = getpid();
>>>+	pthread_t thread_id;
>>>+	time_t tout;
>>>+
>>>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>>>+	if (old_handler == SIG_ERR) {
>>>+		perror("signal");
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>>>+		perror("pthread_create");
>>
>>Does pthread_create() set errno on failure?
>It does not, very good catch!
>>
>>>+		exit(EXIT_FAILURE);
>>>+	}
>>>+
>>>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>>
>>Isn't 10 seconds a bit excessive? I see the oops pretty much immediately.
>Yeah it's probably excessive. I used because it's the default timeout 
>value.

Please define a new macro with less time, something like we did with
ACCEPTQ_LEAK_RACE_TIMEOUT.

Thanks,
Stefano


