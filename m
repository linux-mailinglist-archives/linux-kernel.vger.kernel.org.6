Return-Path: <linux-kernel+bounces-267103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BA940C66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B3F28201F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944D193091;
	Tue, 30 Jul 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ed3Fpw9x"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF301B86DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329797; cv=none; b=VE8cLzadwP4nXrXPbsLkwQHykIJJ/1CticG56fvfoHG6n2hT8+iBVw5oLRZalgOHL171/blUDlLN1xptT/zCXRlhb9FgOUw9+s3/NQVMbxWFZ/yvrOKtHbIHkTls1dHwt4vkT/znfLRaLROKyHhX9R5p8hH1KYV6Oe0FjKK8MSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329797; c=relaxed/simple;
	bh=WNHEC9BtnjIe6KLwcXkm0yvicK8UGyiSQ2HxvUk5PR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpjSp7TVF3i9idHZEUN625BhCwkVjhNZXGiC8xGjMXiCn1D7P3iBJB41eWP2BStiPvs6Qw1Cy9IreLc0d2PRpSnAHH1FbInMXddj136Ouyl/qyuJOLC9mKuPK8dcQr2hkSqqGqHw0FR6gxNjPeTVg2wxwbMIl+plMS/XaMEbKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ed3Fpw9x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36874d7f70bso429430f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722329794; x=1722934594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgtHQjzcSzhXJxDV9mdj343ETcHxolzhEYRr9t1Zx5Q=;
        b=ed3Fpw9xUqguqmpLVNWMmlewhJVoAg32RidI+mb68i9BDLA56F55EOj1FWLakSP90K
         5mli1L3xd03HdpqPWanZNI8xePg+8E/CtDBjnty1y39++wC0ei4+MOz9I320rG8Hbs3C
         85N6pa+k/hjA4c/W9CttiBN7LPn8+L1Bl8JYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329794; x=1722934594;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgtHQjzcSzhXJxDV9mdj343ETcHxolzhEYRr9t1Zx5Q=;
        b=GfnRVbOcAgJaK8MBqHNLWFBD1UukIofVLHxMzJfKfe5qOO7wZhBuFb2qUk6CzAK5xw
         pyDghJOcNjn6hjU/Yia5WTdjQEFGJq8kMSfJwYWlV1Xc/4VGADkTBjoUtZvJnfFQHgSD
         0SL4EnMLMXOA24i960m3L8wSCobCqyqgFesPvo+JurzXocWxjyKz2KANe47y0mOUFIPD
         tWOXtWb0nDga05aac89cBI0Zcyf0ykRZDBpwhv3c5IuMKthLN8YMXclGwcZ7HU02yFBP
         fcnCyeO1y4RkmkqKT1KIx5RWxayiG23+9LpI5U/JiT+0Hk9eTa4rk1rZJ5IVufLsY6+X
         TSBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/G1fISo2LFiEWPc3slnEAtcJ3h3n7wO98MOmD9SWIMuurxlamJqjjUasDYtKa647+jTm/FRjG0xCNUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpACZdAtKH0iw8SKU8uN/iGnHUz+g+JjJn7ZLlstJgZEpVvTc
	VSOqSvCMpmkOAKnyoINhG/1KnhTxfSDlS3X0gbUrzBL3fGRmUz1ugLUf7TrEfbk=
X-Google-Smtp-Source: AGHT+IHIY4OWsp+8at+vnJLgPPIkNjmZcLBJITV+uKHf3I0BGxZGznhKnrOaDTRFuZSQOzI7tUwvqA==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr6470380f8f.4.1722329794226;
        Tue, 30 Jul 2024 01:56:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c028bsm14070438f8f.24.2024.07.30.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:56:33 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:56:31 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Huan Yang <link@vivo.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2 0/5] Introduce DMA_HEAP_ALLOC_AND_READ_FILE heap flag
Message-ID: <Zqiqv7fomIp1IPS_@phenom.ffwll.local>
Mail-Followup-To: Huan Yang <link@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
References: <20240730075755.10941-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730075755.10941-1-link@vivo.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Tue, Jul 30, 2024 at 03:57:44PM +0800, Huan Yang wrote:
> UDMA-BUF step:
>   1. memfd_create
>   2. open file(buffer/direct)
>   3. udmabuf create
>   4. mmap memfd
>   5. read file into memfd vaddr

Yeah this is really slow and the worst way to do it. You absolutely want
to start _all_ the io before you start creating the dma-buf, ideally with
everything running in parallel. But just starting the direct I/O with
async and then creating the umdabuf should be a lot faster and avoid
needlessly serialization operations.

The other issue is that the mmap has some overhead, but might not be too
bad.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

