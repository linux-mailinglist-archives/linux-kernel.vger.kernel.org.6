Return-Path: <linux-kernel+bounces-323282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D0973A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D61B255C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2801192D71;
	Tue, 10 Sep 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pfHKzftx"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209D19580F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979986; cv=none; b=EtjDkrozfy07QQYEvDf3mL9C3cWvW8OLjBOLA2WW7rzZKe6vUbQSWl72BT9KX2BGXxKLtA4BIH1f9FPLT+S/IPL9c7A8bADrhPvn//PsVeISq+kPjlZdtXlSVSWPofEFGnu/v4msS9dGiIWFPR1TWiwX/RBcNQI9GIDS+JLvrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979986; c=relaxed/simple;
	bh=3OPROinPYG66BAUMLz0K2W90EqZSjrxBstxfOOMxzAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo4KS+pRG6sp54yVrTo1IEdLbnqKezFiD9HeCj8nUasi1nK6a8sEHzaUtt3ePC1x+tRZMgAoMo7ow1kLYh6P+o570kle7C748MvbclOKVA4rSKhNPiTAUmjFW9z5NEPRYM31ln1KWYyLB8eRhXuaVKme2dniFeXfocj8+t6/lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pfHKzftx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so148468539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725979984; x=1726584784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5Fc70nClVNFClBK/d7N6FBEhsUoSgP+e799qj2/mYg=;
        b=pfHKzftxq5+KkWdeMti08Ynm9mD9AnulORPkphYudQZmHp12KHYdoENMmOmBKKgC7F
         dG4gQVskAG8VIbgovpWx/qOTT2BwzBrU0R3Y6FmgDy+FDp+zx2Xn+vt8iRpT4h2MMSA7
         eGkZ7eSSIgLMQi/+vPp23hblkZ59UcDPxpbP8KmyyloRtwOEfO4Iia2ovrvCoA1Tehpz
         ycPiEjCV36CypGlNpRjmrm/Ew/A/6I3hGZN2aIoiDYXtyw44SBZxUZWbGunapDzSe6AM
         IQ696Jh8kB4g6MuN0p2CmGJCVMKtgBMyJy22uUHDG5Un6EpTGmkJMfzYTwOuZoYMtNHB
         HuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979984; x=1726584784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5Fc70nClVNFClBK/d7N6FBEhsUoSgP+e799qj2/mYg=;
        b=EKSjmHJKOJxLK30gUo+JhSF5YjA2sZKlfArTPGX0zkaVYI/5uT3Akjh5qSO8mgS5R9
         CqVnNOs+OQc1oUCoiGDTQDj9R0YF9VK9mowj3B/GBby8S2n8JJ8Ym+KJIJW/nmfB0olU
         UHrZ/8Q46btjAcf83WIpw0BT+2x6QWa7lnEE6lLs89Sz0aY4mHSHauuWbGRa4Dbij6km
         RyJXAPLgzRcgiy0FiDXa59KfjJ65tYHLHJb81YDCuxMqMHvRkcZZQurhGNkq+GtskVhq
         DhDBR3SYsns1SaOckoek4G7M+QiRtwd+goOPbBYTQqY+YiKYIAj2hsS9NAQSbmrIV4pO
         /J3A==
X-Forwarded-Encrypted: i=1; AJvYcCVjhThTGK8GymeWz8k2zEBTCdBOdyq4s2MFXnqD0AYmt5P8SYrHuUfcdPMOvrDo6qKVIiz9T6JcgwLjGT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQIskLFMohITFbrCkv4IHCNhfl0Tl8xEMCT7ESadApTewkgp2
	lAR08KKQSKzvIA6w+pnxv66sv778aAfNRUuY/0hn9L2YKXku8SQgLZJaFBQSptI=
X-Google-Smtp-Source: AGHT+IHaKWfN4cqnAqZaqt8tfammQulEh3IZTlHKZSFgjb5rfigxJT43Fj1kclLEAXBReBPQ+dXhqg==
X-Received: by 2002:a05:6e02:160c:b0:39b:3894:9298 with SMTP id e9e14a558f8ab-3a0521a7f5cmr146307485ab.0.1725979983722;
        Tue, 10 Sep 2024 07:53:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe556fsm20400425ab.36.2024.09.10.07.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:53:03 -0700 (PDT)
Message-ID: <ec01745a-b102-4f6e-abc9-abd636d36319@kernel.dk>
Date: Tue, 10 Sep 2024 08:53:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] io_uring/io-wq: respect cgroup cpusets
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910143320.123234-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 8:33 AM, Felix Moessbauer wrote:
> Hi,
> 
> this series continues the affinity cleanup work started in
> io_uring/sqpoll. It has been tested against the liburing testsuite
> (make runtests), whereby the read-mshot test always fails:
> 
>   Running test read-mshot.t
>   Buffer ring register failed -22
>   test_inc 0 0 failed                                                                                                                          
>   Test read-mshot.t failed with ret 1     
> 
> However, this test also fails on a non-patched linux-next @ 
> bc83b4d1f086.

That sounds very odd... What liburing are you using? On old kernels
where provided buffer rings aren't available the test should just skip,
new ones it should pass. Only thing I can think of is that your liburing
repo isn't current?

> The test wq-aff.t succeeds if at least cpu 0,1 are in the set and
> fails otherwise. This is expected, as the test wants to pin on these
> cpus. I'll send a patch for liburing to skip that test in case this
> pre-condition is not met.
> 
> Regarding backporting: I would like to backport these patches to 6.1 as
> well, as they affect our realtime applications. However, in-between 6.1
> and next there is a major change da64d6db3bd3 ("io_uring: One wqe per
> wq"), which makes the backport tricky. While I don't think we want to
> backport this change, would a dedicated backport of the two pinning
> patches for the old multi-queue implementation have a chance to be accepted?

Let's not backport that patch, just because it's pretty invasive. It's
fine to have a separate backport patch of them for -stable, in this case
we'll have one version for stable kernels new enough to have that
change, and one for older versions. Thankfully not that many to care
about.

-- 
Jens Axboe

