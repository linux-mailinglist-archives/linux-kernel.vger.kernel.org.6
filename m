Return-Path: <linux-kernel+bounces-406495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B428E9C63BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B343CB3E31A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DD217910;
	Tue, 12 Nov 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHO/f9HB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24463215F72
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435036; cv=none; b=UwjlbJhM3KSvZxSaDzwv35T5BEbWK7UrSwGdQg0IyKoVl+o8wn48zYlE4oqGL5RDgzxYGAoPuRISa2XgQnoZUF9TJJQ55AfxIZieTQPJ0gdnFkc+W5Grqu1eyGcDV/p8+HxVsWEfVPXC+cTiSKQmx1ds31NjbU9sORahhyZx4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435036; c=relaxed/simple;
	bh=U3/I+P/PE+eG7brE4N+kfK95FsISeERGixMLe9GatDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFEuNLS0pxagxW1lx1VNkCtrFxYMFYXykTsd1ZMzghquG8kMp58a9QPOY28MyuBhPPaiT5eIl0kVa3BR5aH5zo/8Ad7OMZ4Ns9jNeq+IgiNXN4jN0tthu8pfIdRIdr4TJoeA1iWAjyA5ML5/3/mb5ZNi0ZQzqfi3Mj8edh6ylgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHO/f9HB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
	b=KHO/f9HBp+Nrw6gJ4JOC//MnFHC0ulUDTOIMORgMGHhdvvcDIrLOouk3E0Nkh7uBREbeMl
	obZWN4TEr2Pdmwc4Yd3OZBW2ABgS0/R+0C89b+LfSVpXrG/2Wukli3lU/8UQBpcfwbTMjq
	e84fiImPhvvFck5vpBWn8UOJyWQyVoE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Em4vLAbOOTCNV2lCSBJJsQ-1; Tue, 12 Nov 2024 13:10:30 -0500
X-MC-Unique: Em4vLAbOOTCNV2lCSBJJsQ-1
X-Mimecast-MFC-AGG-ID: Em4vLAbOOTCNV2lCSBJJsQ
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4612f6f4fd8so108148051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435030; x=1732039830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
        b=dSNHd1ZTcLhNFjKwezADIWSa8WMe4qd21re1hN3H6gpcq80wX7OXMFkA0cUlqukOEG
         ztniViJXtSX04GXL6CgZgE2j1HbiMRTGNkqL+6GUbls8RzGvIruYd4DhGyS3lzfzEH+m
         Hrmt0IxlkiOSOU4oZJPhGsMFLgmTGm6b+UnHtxqA+sGXdmiU3nCUDf5fAwjMNNmC0xWk
         QR1VJzG1YD+qStk3OgWi20zR3kFwefuQrejucchVGIUQs7nz03cMY5w0GikSGgEQatmx
         oqZUeEeXiJomVkb0TzQ8W1V6V7CxKFN+8MUIjqQ+boHRio03dSjmaf95DK88s9bTtmSS
         /ydg==
X-Forwarded-Encrypted: i=1; AJvYcCV4O9l2MAnjkhg9xd1mJqmC4ncPxFIEAJRLgrle+wKXwCj0WCppApKYRxNwnGLeelsbuJXTpXzKb/rJjo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPx8Np2WbSs94Sq9vsWcOcSrhmTkyGuCkeHv/B0eDQHW9DA25H
	6oAaba9J2UfUvSiCIftSJijMFPSw6ITkyaFVX4hm6TjxkxN89IySLW6+kqjsuZ6Rjo9a6AsPh7T
	2jmSvVcBoMz9ej4oPNyTajGOqc+YIMVPRorVu3oxJt2s6/06sWkGLxmrW4O4owg==
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369591cf.15.1731435030244;
        Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2Qp7c2NiUDCWdk07hfTKmombDRkdlfJtECCErL4H/pgBQu/FzPw04LHhOd38aCVokx1KvdA==
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369061cf.15.1731435029722;
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff41d949sm77813861cf.25.2024.11.12.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Date: Tue, 12 Nov 2024 19:10:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/3] vsock/test: verify socket options after setting
 them
Message-ID: <jjplqknxiasru7oukfrz66eryfhtviukwchxkh4yq6woj3m7qw@augnv6adwrgc>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-4-kshk@linux.ibm.com>
 <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
 <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>

On Tue, Nov 12, 2024 at 09:18:48AM -0600, Konstantin Shkolnyy wrote:
>On 11/12/2024 02:58, Stefano Garzarella wrote:
>>On Thu, Nov 07, 2024 at 07:17:26PM -0600, Konstantin Shkolnyy wrote:
>>>Replace setsockopt() calls with calls to functions that follow
>>>setsockopt() with getsockopt() and check that the returned value and its
>>>size are the same as have been set.
>>>
>>>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>>---
>>>tools/testing/vsock/Makefile              |   8 +-
>>>tools/testing/vsock/control.c             |   8 +-
>>>tools/testing/vsock/msg_zerocopy_common.c |   8 +-
>>>tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
>>>tools/testing/vsock/util_socket.h         |  19 +++
>>>tools/testing/vsock/vsock_perf.c          |  24 ++--
>>>tools/testing/vsock/vsock_test.c          |  40 +++---
>>>7 files changed, 208 insertions(+), 48 deletions(-)
>>>create mode 100644 tools/testing/vsock/util_socket.c
>>>create mode 100644 tools/testing/vsock/util_socket.h
>>>
>>>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>>index 6e0b4e95e230..1ec0b3a67aa4 100644
>>>--- a/tools/testing/vsock/Makefile
>>>+++ b/tools/testing/vsock/Makefile
>>>@@ -1,12 +1,12 @@
>>># SPDX-License-Identifier: GPL-2.0-only
>>>all: test vsock_perf
>>>test: vsock_test vsock_diag_test vsock_uring_test
>>>-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o
>>>-vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>>-vsock_perf: vsock_perf.o msg_zerocopy_common.o
>>>+vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o util_socket.o
>>>+vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o 
>>>util_socket.o
>>>+vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o
>>
>>I would add the new functions to check setsockopt in util.c
>>
>>vsock_perf is more of a tool to measure performance than a test, so
>>we can avoid calling these checks there, tests should cover all
>>cases regardless of vsock_perf.
>
>The problem is that vsock_perf calls enable_so_zerocopy() which has to
>call the new setsockopt_int_check() because it's also called by 
>vsock_test. Do you prefer to give vsock_perf its own version of
>enable_so_zerocopy() which doesn't call setsockopt_int_check()?
>

Yeah, maybe we can move the old enable_so_zerocopy() in vsock_perf.c
and implement another enable_so_zerocopy() in util.c for the tests.

Thanks,
Stefano


