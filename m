Return-Path: <linux-kernel+bounces-381269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21879AFCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1FA1C211D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234D1D2794;
	Fri, 25 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5UdfXNZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B281D2202
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845482; cv=none; b=S/EAnBfkZDY4zpnU1RZ1tmES3U3dnjsVatLxyhlCKYeWpH9QmRZmaQ2AI0B1QuHEijt+ffFWOUZyRMzDhJli4Y7POYL4Mu1UE3s73PKn3FmTWfxDOeFehTW9cIyUALOVvc7wVlmB4jfpXAM52HLJHLNvd3oF+34XQEjjPngxlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845482; c=relaxed/simple;
	bh=nVtFuA3MUXFT6qe5Nc+wclnoMmIuimggNWMscKvWImo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAx2kvFIJ92uPRBfE7aEG0GmNHqPh/PtxtVH0DBC3zzmfjebQaxQ+bBbTQpEnhmm9MATdxuKZOLLBYJcP+5nb1Hkr18PGsLEMSg8RUmXSiZM/BStVPZldvFGn0koGWFm4dLi0tEyykV6dnj+bolMza5x+YPlxfii7MctfSXWMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5UdfXNZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
	b=R5UdfXNZw90azajGd/J1HlGi6d6EgJ5+0qJpC/RNU1DoXK47U9BfZXIoo5wt/utScg5r3U
	P762HXpp6+9cmKyRg7XAXym8ViG1rnZG4GmNIHZKjglgafi+5PQvuvlTc5J2S/kSCflEt2
	ybHthbpXKxlt8Dhjwj+yHuVyNNwpZO4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-NtyhmgKTN8GhOkwKNdRVSg-1; Fri, 25 Oct 2024 04:37:57 -0400
X-MC-Unique: NtyhmgKTN8GhOkwKNdRVSg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15c3ad7ceso223196885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845477; x=1730450277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
        b=ahv44nDa3SLHXDKXvn1uQ1XczTQgQGT7QFD1vxa+6qB6OeT7CmDLLq8eyhe6pOf2Xl
         Xm3h9sw+Ws5ZFZmIljDcERQsnj5Cal4F0LfDLplR4EF3wv2Y9BW2YAYJLKL51m1nsG7U
         7oUgANv2JciWhurNMNvfqozjj0HAVQMcrErOrqWpdCw4tlpr3pLYQdgUygZl1XVojZh3
         HGJ5JthwRw1DshbE/xAWiLyqVIC6e4ezcD06x8r5A6nJcCVnLg7HTFZQ0XmRrybfuKYP
         +dukUin/VdbijAuzLJkh2KNceIrHZ3PiXO0eL2nJ1mw3L2WFPaWynB4ayY4Q3PomuevP
         CLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU12Z85eLe+V7Jc4lRDkKDKdBuiHK9RIZHquieVIBTjAvxX7/7xmrk++S0cVvvO+ifFPWfxWZJ9MfQ6VJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+aEWPsOk0Bso6yZ+xvMcPey3Qv+iekD0DbrwWuTfufhLQzuj
	wYf1WtAjiloKYZQH2Yxil0LT1vY0Prwh2lAFKkFrpVDOgoT3K4oMz7jXpEDLDFo42t6ILnR6sZB
	9fmkIe3OGcofkAHKG6g2ODoHXFm7nH5CwdFoAmVC59ky4/sRYXCcv4KPS4HfFpIzAGBQ4OA==
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614541685a.59.1729845476855;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuQEjcQhlSNMj30aQpJXJBOGKeqEjdKKGecMohH0UZa9AyzJnLZNXjh+x9iFwZinN8LX18HA==
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614539785a.59.1729845476495;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a57d4csm3713716d6.132.2024.10.25.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:37:55 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:37:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v2] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <pdgrhpta6qqwa7r6zexqikcybkllootq7qwbe36i5uf3fpbavb@v4vyiclg2cis>
References: <20241024161058.435469-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241024161058.435469-1-kshk@linux.ibm.com>

On Thu, Oct 24, 2024 at 11:10:58AM -0500, Konstantin Shkolnyy wrote:
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
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v2:
>- add "Fixes:" lines to the commit message

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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


