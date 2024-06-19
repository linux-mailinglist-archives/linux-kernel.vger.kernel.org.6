Return-Path: <linux-kernel+bounces-221869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E310A90F9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AC81C21745
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB515B55B;
	Wed, 19 Jun 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EH5eDPgG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B615B150
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840655; cv=none; b=WQykSKXM8iyJc3EyCgO/NYQPg+O+1gyifRPf8h0MXoduj4fYkV0UjnYL05YDiOKSAA2wWPjlH6DLR0oKMqZORsNXvFw/jJMrZysNZu26PKGd2PuDwQ1JlLW7xKAx9mbw8ECOogsfoZp4osM3brd5SfZPzyfjz9HwyVmzFC53M9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840655; c=relaxed/simple;
	bh=Lmp5OWOGhZ/GlM5G8dZy1KY3BtfOu4lYPqUFse+007U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKAngXH52pPFBzqZxupRR9+KReY7+StpnA1ocFLRv7wALCTH0PKSqsAiOxg4Fx/uUSaHqWcU2FfPgi4PXx1BXx3JQb8r7IC5T458sLCleNXnGuOuav0MkFG3k9nm86E+tXAoBUxzVFFGMneP5mRSzAHJyF0bHjw4uvcU3FFfXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EH5eDPgG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d0dso2496955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718840653; x=1719445453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVuyMBsomRXNkX2R98ja5jKpLJqdqT7RYzA90IZHfwg=;
        b=EH5eDPgGQH5P+a0Y5Z47sNj9puGOyM/Z/qMz8R6okCb0P7KhgPqhoUSWunjx8OJph5
         Zn+/5rjHiyAk1/l/NONYNxPNPuP/PkRHMH+jL7XFdCp/96u2oq9Q9iubgUE6WRt37XSv
         KSmDfuDMH0LfxalrysUFG0xRC5F/T22Xnk2x04JqQvqLzhslPl8yk564aLiqzOHZasAA
         BpA/11xPlnZKsScACyT6ivL/9dFCzPyt4FW1xy6yZTgPHFuGQDSzmkHda3p+Ruz7hvKU
         TxyTIk3M503GQMoamSVRB160k8CFyNrZpI2ZKa4hoDONw9IBvu3JKywqtxgVedUlCCbl
         uGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718840653; x=1719445453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVuyMBsomRXNkX2R98ja5jKpLJqdqT7RYzA90IZHfwg=;
        b=qDxxquUfWheYwZS70ZRWrT5CR1GhssAv+kQ1HDuB8EYO0jFz5PTkcjgkViCo0TJw09
         NLMkFKzPsFFToVpzWlz+NLvX9Pwx4EaWb9+Agi61Gygi1AufIjEQAuWJqEazDbj/FTMA
         H8lIXqIJgE7H/4t6jzIj/P6YzVyNcoZT1PH4YOXgaPgNQEXeABjpPvoK5ptXYWMAvyBw
         yKlDN7W3hpk+EEZsE6SC7wkIf0MfKGCS6OcUWRlofMcLU6Z4beIYgPnjWt0zk8HBkbA5
         6I7s3BHJJUjne3ajvUFwO4ye6dEvQFtPrE5hPaZ20EcCXaG3Mh9+QgTIlBHg0WNXX2Li
         CNnA==
X-Forwarded-Encrypted: i=1; AJvYcCUeSRHTdy+jlqpPALvPEb17Qh5wbY6lAMhRGNIkIS4gQw9UHVOkWvR+XqbjxZpvqg0hCuSaJttdVjCj7jxGYuJShQI+HgXMRCgyrs64
X-Gm-Message-State: AOJu0YzZwD28mU5s7QHLwekSsu8dfR5gQ4vHP8fNOo7vg43VF/dPf7FF
	hsC3lL+Y0p32WmkdFHa9JLARkd73PVuu9DAzv1yT4bipUW7+A7yWPFSpmnzO5A==
X-Google-Smtp-Source: AGHT+IE7pOAJJI/XOEokwNnsCQ5KampmES6DsxKfRJL9EpWNcm0iI48KuBz+ru53srEhdvCThHg5JQ==
X-Received: by 2002:a17:902:daca:b0:1f8:67e4:3985 with SMTP id d9443c01a7336-1f9aa45eaa7mr48743025ad.49.1718840653218;
        Wed, 19 Jun 2024 16:44:13 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee9be0sm124270525ad.176.2024.06.19.16.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:44:12 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:44:09 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v4] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
Message-ID: <ZnNtSVyBfb_4HlVK@google.com>
References: <20240619113841.3362-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619113841.3362-1-liulei.rjpt@vivo.com>

On Wed, Jun 19, 2024 at 07:38:40PM +0800, Lei Liu wrote:
> In binder_alloc, there is a frequent need for order3 memory allocation,
> especially on small-memory mobile devices, which can lead to OOM and
> cause foreground applications to be killed, resulting in flashbacks.
> 
> We use kvcalloc to allocate memory, which can reduce system OOM
> occurrences, as well as decrease the time and probability of failure for
> order3 memory allocations. Additionally, It has little impact on the
> throughput of the binder. (as verified by Google's binder_benchmark
> testing tool).
> 
> We have conducted multiple tests on an 8GB memory phone, kvcalloc has
> little performance degradation and resolves frequent OOM issues, Below
> is a partial excerpt of the test data.
> 
> throughput(TH_PUT) = (size * Iterations)/Time
> kcalloc->kvcalloc:
> 
> Sample with kcalloc():
> adb shell stop/ kcalloc /8+256G
> ---------------------------------------------------------------------
> Benchmark                Time     CPU   Iterations  TH-PUT  TH-PUTCPU
>                          (ns)     (ns)              (GB/s)    (GB/s)
> ---------------------------------------------------------------------
> BM_sendVec_binder4      39126    18550    38894    3.976282  8.38684
> BM_sendVec_binder8      38924    18542    37786    7.766108  16.3028
> BM_sendVec_binder16     38328    18228    36700    15.32039  32.2141
> BM_sendVec_binder32     38154    18215    38240    32.07213  67.1798
> BM_sendVec_binder64     39093    18809    36142    59.16885  122.977
> BM_sendVec_binder128    40169    19188    36461    116.1843  243.2253
> BM_sendVec_binder256    40695    19559    35951    226.1569  470.5484
> BM_sendVec_binder512    41446    20211    34259    423.2159  867.8743
> BM_sendVec_binder1024   44040    22939    28904    672.0639  1290.278
> BM_sendVec_binder2048   47817    25821    26595    1139.063  2109.393
> BM_sendVec_binder4096   54749    30905    22742    1701.423  3014.115
> BM_sendVec_binder8192   68316    42017    16684    2000.634  3252.858
> BM_sendVec_binder16384  95435    64081    10961    1881.752  2802.469
> BM_sendVec_binder32768  148232  107504     6510    1439.093  1984.295
> BM_sendVec_binder65536  326499  229874     3178    637.8991  906.0329
> NORAML TEST                                 SUM    10355.79  17188.15
> stressapptest eat 2G                        SUM    10088.39  16625.97
> 
> Sample with kvcalloc():
> adb shell stop/ kvcalloc /8+256G
> ----------------------------------------------------------------------
> Benchmark                Time     CPU   Iterations  TH-PUT  TH-PUTCPU
>                          (ns)     (ns)              (GB/s)    (GB/s)
> ----------------------------------------------------------------------
> BM_sendVec_binder4       39673    18832    36598    3.689965  7.773577
> BM_sendVec_binder8       39869    18969    37188    7.462038  15.68369
> BM_sendVec_binder16      39774    18896    36627    14.73405  31.01355
> BM_sendVec_binder32      40225    19125    36995    29.43045  61.90013
> BM_sendVec_binder64      40549    19529    35148    55.47544  115.1862
> BM_sendVec_binder128     41580    19892    35384    108.9262  227.6871
> BM_sendVec_binder256     41584    20059    34060    209.6806  434.6857
> BM_sendVec_binder512     42829    20899    32493    388.4381  796.0389
> BM_sendVec_binder1024    45037    23360    29251    665.0759  1282.236
> BM_sendVec_binder2048    47853    25761    27091    1159.433  2153.735
> BM_sendVec_binder4096    55574    31745    22405    1651.328  2890.877
> BM_sendVec_binder8192    70706    43693    16400    1900.105  3074.836
> BM_sendVec_binder16384   96161    64362    10793    1838.921  2747.468
> BM_sendVec_binder32768  147875   107292     6296    1395.147  1922.858
> BM_sendVec_binder65536  330324   232296     3053    605.7126  861.3209
> NORAML TEST                                 SUM     10033.56  16623.35
> stressapptest eat 2G                        SUM      9958.43  16497.55
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
> 
> ---

This looks great, thanks for the hard work!

Acked-by: Carlos Llamas <cmllamas@google.com>

