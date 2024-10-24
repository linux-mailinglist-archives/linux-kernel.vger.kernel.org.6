Return-Path: <linux-kernel+bounces-379501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D19ADF63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB041F2225A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC5D1B0F37;
	Thu, 24 Oct 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qvorgh1P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246B1AC42B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759437; cv=none; b=JUkxuAS9JCMoYmos3SC+c1G91k7etC2HcIRZ4BYjN6eo/0BCTvCK+yfBN/0s0R8+pq23WfW5OydTJWLKifdRlptYM6QCfyYUZTqi8h3UaB5qqg88JRwQZNkVjKfwRPriP+aZ9m3QHb8yNHYksjGv+X01UmRCrspmSWowXct/3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759437; c=relaxed/simple;
	bh=UCi5ELepQZZwWFe9oCjZrBvOZ/qfebT40DeKQbBbNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOWGPS4sXtaJ/xxfbw4lvMcU9RDiR9gBWp2H2fZqcNhSNgJmgvEMDTUI6ceroEYGeP6j3lh5E1lHp9+J4J06ur6QCPqfKXCVbr5SEb+xgy4dLgjOAf7pC8uS7+9cltpbTZBnYWS1yird+fEl7yhJ+Gdwn2RqwI380h4Txk5UOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qvorgh1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729759433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR9AjakJn4hoJuTZIbyhybHiqFDkYJYpjuoN4hxDG2w=;
	b=Qvorgh1Pq+uLYH7Aq/4BCgZCV2o+R7LppxPnn6Tek4Ko5TmWFhipVRmBPo4qYdSnjBdAXT
	E9olfwFtKb4LsgnTBlOBEqFSpkmg6BZKqEPWzM/seou/pwzZ/ifGuLtHUGXybTNWflA0af
	/04dPWZSmM9oimolyYlsKMBbtreV5O8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-whwmBOhyOwOBba6AKjDoBQ-1; Thu, 24 Oct 2024 04:43:51 -0400
X-MC-Unique: whwmBOhyOwOBba6AKjDoBQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4a4819de765so274888137.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729759431; x=1730364231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR9AjakJn4hoJuTZIbyhybHiqFDkYJYpjuoN4hxDG2w=;
        b=S9BY24l1s+HrHs+dO69rSfvik1uxBQ0x9sAsoab1xSsAmFzlazfnSzuHzIf3t5rUl6
         jBgtCadkggQR26UMp05PpCShgyCoOHHkSbR8LX3lElktBL1tvYx9JGTVdok5NPitKr7u
         41Tw9dITRM0P4A/f7WAeFNZ7G9oqId+8SoQhEkktiRTEztLuz2/DSc8U0LWc4vWNRhy5
         19HwndCQxtfRtaVkcWUzH1pDh/qE8iWGr+SVD8FNyCcZ10aBDd89bgOAUGmCOLFdaVWv
         TGzfcc7gzgBWLfYUM5fFgUCx1YpcMm8khUKbg1Wi2IT8I257K8srgIJ5yn13NcCeyY2s
         7y0g==
X-Forwarded-Encrypted: i=1; AJvYcCUqrguiAsTERgLnIHzYc4GpY9HX67JN94q17neUTqalwOEe4kmVN8p+dxDOq2I/P7WetlOGKaIF24UZk7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7preGdiE08AOaRhBaLIbEP+Ug+5578AQ5FJ+Jd1OkTWBnmP8
	gtuh4gUOgm7kGzh6OX6VWKKL7pA9eP0MB/DYX8cL9YAab4d2pMz68vs1HS42fFuFcq3Vt/NKhVg
	Xv0KoAspHNh2CC86dYd5q5w23R5+rYlDpgYwWnICYHfr1I2znbbpcyY5hRoaN+Q==
X-Received: by 2002:a05:6102:3f4e:b0:4a5:ba70:1c6e with SMTP id ada2fe7eead31-4a751cf131amr7794002137.29.1729759431421;
        Thu, 24 Oct 2024 01:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHiPWrknWvL/ANNpfbc0GJfbqV2BdD/Y2S5/yeKMxfEgmbao0nwYIWy04QhKvvoS4AizptAw==
X-Received: by 2002:a05:6102:3f4e:b0:4a5:ba70:1c6e with SMTP id ada2fe7eead31-4a751cf131amr7793972137.29.1729759430966;
        Thu, 24 Oct 2024 01:43:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb043sm49052421cf.50.2024.10.24.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:43:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:43:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
References: <20241023210031.274017-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241023210031.274017-1-kshk@linux.ibm.com>

On Wed, Oct 23, 2024 at 04:00:31PM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in test failures.
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.

Thanks for the fix!

Other setsockopt() in the tests where we use unsigned long are
SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
fine.

Not for this patch, but do you think adding a getsockopt() for each
setsockopt in the test to check that kind of issue can help?

BTW, this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Not sure if we want this with net tree since are just tests,
in that case I think you should add:

Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")

>
> tools/testing/vsock/vsock_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 8d38dbf8f41f..7fd25b814b4b 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
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


