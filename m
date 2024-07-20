Return-Path: <linux-kernel+bounces-258049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F09382B3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D05282129
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE79149006;
	Sat, 20 Jul 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YYPh87h+"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B01148850
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721503524; cv=none; b=PbRDsmFKrUjQB5sx7WTfMFfrfoOyqYaiUcGGh7yBevVikYeXl5ebXvquwY+jv2PLj+CzTdVf93aaO2OcKjIpLDkYtlcFYjpUNaqV5fgz33z0kGR7r+DmBfP9uqnf6xrFSPECQSz7a8yKr43YoKtjQZX3MzKRqrp8Fp7Qu4X+tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721503524; c=relaxed/simple;
	bh=VEU2wW2CNQWp8qy7HJWV6PWRDd2jLh3bbohr2W6pt1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0UdGx94L2KHen+y19+X2TNpjJWY+9HZWyriOW+bMpmzturw1I0+XTjCbO3YCMELKdXIxPZjB6Vi9Xn9NHhape+o0D+sQ5covkOgTnVgUnd9PCYz0AkEOS2YDKrMxitMpjaF51Q7JQAw7vxdh7XjGprX1xQGJ5fpl4D63Yg/RnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YYPh87h+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3dab349467dso1689461b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1721503522; x=1722108322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0B1/j2S9YNCbXOf1SbkalG6laXdSW5w2tqTb+E6OajE=;
        b=YYPh87h+RjuSx1lV6LRuo1C1rjGQaeGnPWo+s9sfUTmsrUdjwPvOeNCGMDAgRqKEXu
         Nz6gg9/NUU3tHUhZs8rCa34YTvgQ2hF4IUCRNsvn6RKaq2DPAbYJcQ3Yx8fmRmMeIY5w
         JvRgcbfnhK3FxEOiKDrayR6UhXEpn88T98vco3WsEkkbWpTUf3aq0ULwHmumG1sbMAKQ
         FzO5sQwi6NU2v1SZIJSasWSxo8skp/nQnjDOnuzYal7dPysXQ/rxwG3OMtnadAV9h4cj
         oJmdtSICx0yB8Ip3pbN5e6RpDC44WcYUrev6Hqhy4jVLDdR+N35iDbxyoO6cdfeTi/T8
         t9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721503522; x=1722108322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B1/j2S9YNCbXOf1SbkalG6laXdSW5w2tqTb+E6OajE=;
        b=Gahk/CVGWQl11wmnXiJqpdjLm63ZYxJkCu93Co8MhOqNyhIU82O2KHhru9k9xillF3
         yUaT69cCM0armUvAQrSjI0AVd/dz8LkDMp+m7P0lVHSSBsEauzMHM1w88I1CoiIL0Sno
         noopxdoa4h1/kYxB0ODbtbLf70nqx6refoZDbBRumgGh/VhjUY3VZfdngC+UcfMVtylX
         JG4JGbiIo4+pJiADEh9OfKsCaSzWhnzn8jk+YGyEEq+QYNNfJlTf9JiTe5Bb2wTJckNT
         v6vhKE6Gh9AUGO8U/33M8kKL9rpbBAFAzkYruyU3SGHf2KkbsElIhghZL6tbfI0snvzW
         mnLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrMn934uz28D8BY0PyNEt/PH4+dD3rtfl2fEx/q5wT7YHc6epTMamrSglyZIuL3wP3ZC5yXEpDld/vGFZ7+xBrb5cxiui3jNefMS0h
X-Gm-Message-State: AOJu0YzUyeQ+Oi9ghJTGdLOnN7ydpkBHNsqq3SIPzHa09CCqIYytsL44
	SyhlMj0z39HlPzc9yxDdLVeAfkrhSkIuC8f9Pka1bfoO583dYvvb5pSYuJww5WU=
X-Google-Smtp-Source: AGHT+IE6nOiiMCHIhVmF7v55luSs/74wKNhm3JBn76ZhsMZRVw06pB/V0iQxbYpv9EMerga/hsjaeg==
X-Received: by 2002:a05:6870:972c:b0:261:1af1:ee9e with SMTP id 586e51a60fabf-261213a4f3emr2928937fac.14.1721503522559;
        Sat, 20 Jul 2024 12:25:22 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a0de7abd43sm829256a12.23.2024.07.20.12.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 12:25:22 -0700 (PDT)
Message-ID: <6b8e2001-7f4a-40aa-a760-a4c709675fb6@davidwei.uk>
Date: Sat, 20 Jul 2024 12:25:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
Content-Language: en-GB
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com
References: <20240717205511.2541693-1-wei.huang2@amd.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-17 13:55, Wei Huang wrote:
> Hi All,
> 
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
> provide optimization hints for requests that target memory space. These hints,
> in a format called steering tag (ST), are provided in the requester's TLP
> headers and allow the system hardware, including the Root Complex, to
> optimize the utilization of platform resources for the requests.
> 
> Upcoming AMD hardware implement a new Cache Injection feature that leverages
> TPH. Cache Injection allows PCIe endpoints to inject I/O Coherent DMA writes
> directly into an L2 within the CCX (core complex) closest to the CPU core that
> will consume it. This technology is aimed at applications requiring high
> performance and low latency, such as networking and storage applications.

This sounds very exciting Wei and it's good to see bnxt support. When
you say 'upcoming AMD hardware' are you able to share exactly which? I
would like to try this out.

