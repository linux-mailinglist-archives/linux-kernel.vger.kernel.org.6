Return-Path: <linux-kernel+bounces-212238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048D905D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D307D284A04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F384FDF;
	Wed, 12 Jun 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yvax15Fc"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215884E07
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225613; cv=none; b=ZzC31DE3gfB4XpQTFkVObMXS1vh88ULv5BjkB22KXND+CXcwoBh4Ol6/Z5blVH/8Xw+Ja8wJe9kDTAhYODkSDC06+nLY2wArkOQpUustojbarWqDcLq5iGbbr6vXPcfDxrs69qIqc94aTCHsr3tuQB8AmtMgzq/YSQV/2B7NW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225613; c=relaxed/simple;
	bh=x2snBHhVt4z5TOb+zscUiPsECWC11ob5QWlrzrhqK2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrUjmgr0nU7FrwFup+Rwm4mvDSWt1+p6VMvfKvc530/15bvitpX8sRocArxh6nKFGfvY4xaPlc4YPuPs/ZkKRIOKWeBen/z44OO6M3zMa4Ashep9zkrcV0TYp8U66kBbywWzsAho46ZUeUgL1TvvIn3MbTxLjgsPgQh8M6SRXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yvax15Fc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c2d2534c51so26706a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718225610; x=1718830410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSYIXvgTjBjLjDaj5a+Hbq3RRIqI54cl6LplLVVHNnw=;
        b=Yvax15Fc5ecUSpmvr5w7oAeQ75G5RfwEmSCbkQWwnvhsNBZDzuNG/KeQPBmqZ5YswP
         E9KtTx74pMdd9x1rRU9SfiQD+xuaCAA+RDr+11/sIP/2Ot6elidH4ASU5unijca7V1/R
         ixJq0kQ4YbrlLEaIuJJx9usiNtt+AMfB30AtsCLx+MnQFqoLWn3bFKfGbvTTsdaeb9Tt
         e6cm1KRyyEsZ5xPTaBSEidAatsEkklKSt0IYasBMx4GxfEAeAzlDsZ9LIWIvvfZ3aYN7
         a+2WAT4/CbrUR+MWRxkEM3vkLiBatI3cyCYWkq6U5VXCvOYN/vxLJSMZ7GaCCj5AuRl7
         x12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225610; x=1718830410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSYIXvgTjBjLjDaj5a+Hbq3RRIqI54cl6LplLVVHNnw=;
        b=S+pUrPW4n4WYqjgcz6oIG2vWZyx3kKgGcTaZXcD/Qc0lyWwHl1mMB5rjTptYJ/Yvdd
         yHCH2TknuWyC1m7bV27KOe/otdNf4dl+qUCbJvjTIY0WWKOJxCa611bbdg7VR+vuv5+U
         lejRwHO1IJo8PSXYCnI2D3pKJgAqFK0wCNGj9FJRcMfLtNOmr85ryToUswLljst7Rt2o
         f6eyhV/RAfHcfZly7pC4dWjHp4UyaU90g7QNrOw39dGZNwsJ5wSnb6+T7qESySHfOEn0
         aoioSZwFrjAIC/K3AjeGv90jtNr7uOxgze2gVyH7zri5zoOnG2iX3723aQZUDEkGZYo1
         BoUg==
X-Forwarded-Encrypted: i=1; AJvYcCWsGmLfpwLQe3QFDTENR+zsKNocnIkPO7shtoLCdQ36UiShR3qV6bfAaVKtGGTgvfq4A6L+kjdyXNIXVls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTAFK5FIu2IvLBu05aRHYlUuK+3AtA87NKNMs6hiLaFU8jdUy
	tXiATHqhU0pvGyOTfD7ucibApGu8WYcEffsHTWOEK12YFERSQKCedK7pwXWvBb2VNBSB6qksj10
	E
X-Google-Smtp-Source: AGHT+IEBnkgvit8R/o/lYAcC85W+TBVXxi4/XDehB+eDIJlB10T7guKWGrixXTji//T7/aa9IA3sKg==
X-Received: by 2002:a17:90a:8186:b0:2c4:aab0:121e with SMTP id 98e67ed59e1d1-2c4aab01640mr2667270a91.1.1718225610127;
        Wed, 12 Jun 2024 13:53:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::1466? ([2620:10d:c090:400::5:728])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f3035sm5983a91.25.2024.06.12.13.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:53:29 -0700 (PDT)
Message-ID: <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
Date: Wed, 12 Jun 2024 14:53:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Avoid polling configuration errors
To: Christoph Hellwig <hch@infradead.org>, hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
 <ZlrQCaR6xEaghWdQ@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZlrQCaR6xEaghWdQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 1:38 AM, Christoph Hellwig wrote:
> On Fri, May 31, 2024 at 05:10:15PM +0800, hexue wrote:
>> Here's a misconfigured if application is doing polled IO
>> for devices that don't have a poll queue, the process will
>> continue to do syscall between user space and kernel space,
>> as in normal poll IO, CPU utilization will be 100%. IO actually
>> arrives through interruption.
>>
>> This patch returns a signal that does not support the operation
>> when the underlying device does not have a poll queue, avoiding
>> performance and CPU simultaneous loss.
> 
> This feels like the wrong place to check for this.
> 
> As we've dropped synchronous polling we now only support
> thead based polling, right now only through io_uring.
> 
> So we need to ensure REQ_POLLED doesn't even get set for any
> other I/O.

We happily allow polled IO for async polled IO, even if the destination
queue isn't polled (or it doesn't exist). This is different than the old
sync polled support.

It'll work just fine, it just won't really do what you expect in the
sense that IRQs are still being triggered. The app side won't wait
however, it'll just busy poll on the completion and either race with the
IRQ delivery or find it once completed.

So I think the bigger question here is if we want to change that. It can
indicate a bad configuration, but there's also risk there in terms of
breaking a setup that already works for someone. You'd get -ENONOTSUPP
rather than just (suboptimal) completed IO.

-- 
Jens Axboe


