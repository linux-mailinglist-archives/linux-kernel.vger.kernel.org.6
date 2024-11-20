Return-Path: <linux-kernel+bounces-415464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B69D369A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C051E285E01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3418E34A;
	Wed, 20 Nov 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrwkreO2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8019B586
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094113; cv=none; b=p8sAzS3Sl7hx4eRCv1NLl4HhQRDlGxTr8EHWR0DlJ6jXjRmXABa3eJEEUjTh+4N/pfq+GVY3BpxIMoGALKS1QCbBIgjDCbufezYYPgyRaBEE1T3/uIV4xR85xgrWXEFk1vQto5mF4MhlfLNTmNLN4+3qwq7Gwul2JbG0nymERxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094113; c=relaxed/simple;
	bh=2hdAbT7Sq9ipOSToiegjJMfm1hDkH2O1SCc4PKB5D7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nERBZXihmlksiaT0ljFv0jXseRKKpZge7YDPo5eaRkVXwFiy0UYNnb7bN/2uq2cAfE6KbULljNaJzihSPzy8fmVFp5vUDc2i/RoXoA3X+nFH/A0dJcvQT8BP6BpyEaPNg8sO5oaSZ03RX7dSxY2JTfnB+GHOHbcZgX5Kuq3R6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrwkreO2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5111747cso51736381fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732094110; x=1732698910; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZqPJTooMuIvfQxCxUlIoLxMsIJNKGcrHg/Zv8d6/H4=;
        b=BrwkreO2me6Kg0w0t9CBycLmcioKk5bJoDqEjtHnPXP5m3txQarl9UjkCdEWDI3hy2
         muAk8GTFqdHwSK0SFbFIe9rcE8D3VAaFn4n8TTD80qOx5KJHtLIQrn2UVVusf7PIhYmu
         /tuYHNWUTtxVhWhPT9M/O60UAy7/BA9Sw1xxh3Jm1tmziOZjQ+NBoSUlRDNirD5SCn4o
         aKKNZ8kfQr1j94Jdh3Fb/BuJ3IHpeQPJ7+9eQ+2EYre2H1A/bR7H2yYGLfsgsupbBgAG
         CgL80q4u/pskeme61HFeYE3YBvzHxD6G19+kj3r7v1uY5ZE12OhQKmIjkbpis8rBpW07
         xSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094110; x=1732698910;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZqPJTooMuIvfQxCxUlIoLxMsIJNKGcrHg/Zv8d6/H4=;
        b=YlgZjePKsGlT+dh/UU5wciAwT6Je+utRTEo4MOZd9+Hm4Zx23H0Gpl6YKkOoo/Wlnx
         17TwxIgQx97E59EqD2JeWCtimvvIYKnSJhXFW/Q2fbFgTyHr1hq3byghwyXRwm4LfGkn
         0ich5Tp8yEG16042BFnRFxGaOmgxV8KLPMoXO0y13MgwfnifK72YdFm96vge2axBjhaL
         WyvXDI4ubYYjotM2ZG+kgCsAtjB7M6rxrhUCHAVJvIkIONoT45WIVaVS8yvflF+ebmaE
         prXvQP+/YDXQEKlcNXA4wfqvA2oT9OFJqVzCsTkSnZ++S39sGvdxvVprr3r65KCs3saN
         v4hw==
X-Forwarded-Encrypted: i=1; AJvYcCXjaRDV4TQhxVAsjReOZjjnfxw9u3mrTwno5wQxZoGO99TRVGG/8QX6toFJRKl2wNFaBqJOGx6k4qeDazA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhGW1TRu2co250+euFOuvBx97xkZlpwuN8xMNB+a9UhI3GXRu
	vXcRJ+YsimvbEqRPJH7ojy2UqkEFLIkoHC0NNP7TE7Gm6pLyikBc7QpZ/kKAa+zdNxxRSDyax7b
	H
X-Google-Smtp-Source: AGHT+IFpsEvlnavPKpISmZgS8ov+/Rflr4MbgvHBN0Ln88a6ToQBQhFBJg6MAGm+8dhJ0Y0wJj72pQ==
X-Received: by 2002:a2e:be2b:0:b0:2ff:4ce0:d268 with SMTP id 38308e7fff4ca-2ff8db6039bmr11228371fa.2.1732094109757;
        Wed, 20 Nov 2024 01:15:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f643e65bsm38337075e9.0.2024.11.20.01.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:15:09 -0800 (PST)
Date: Wed, 20 Nov 2024 12:15:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] io_uring/region: return negative -E2BIG in
 io_create_region()
Message-ID: <d8ea3bef-74d8-4f77-8223-6d36464dd4dc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally returns positivie E2BIG instead of negative
-E2BIG.  The callers treat negatives and positives the same so this
doesn't affect the kernel.  The error code is returned to userspace via
the system call.

Fixes: dfbbfbf19187 ("io_uring: introduce concept of memory regions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 6e6ee79ba94f..3d71756bc598 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -229,7 +229,7 @@ int io_create_region(struct io_ring_ctx *ctx, struct io_mapped_region *mr,
 	if (!reg->size || reg->mmap_offset || reg->id)
 		return -EINVAL;
 	if ((reg->size >> PAGE_SHIFT) > INT_MAX)
-		return E2BIG;
+		return -E2BIG;
 	if ((reg->user_addr | reg->size) & ~PAGE_MASK)
 		return -EINVAL;
 	if (check_add_overflow(reg->user_addr, reg->size, &end))
-- 
2.45.2


