Return-Path: <linux-kernel+bounces-512583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF1A33B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D098D1638E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3C20D4FA;
	Thu, 13 Feb 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="KDjKOm6/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87E20B7E8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438644; cv=none; b=PdtNGLoPlK8ukqtaJz3SnNhpG/RAeVBSHvJpyMvFjQ/mslD7apIzoLRK29BJvTiGkCyAPGZLPVuQDYcYWsWkkkHoLdYNz86N+wsi3jIs3ZFdptXH+f1UrWtw1w9SJRd4Y9LvxBmmO7h6otvItAGHXDMNW/XCT1alkf978fVoyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438644; c=relaxed/simple;
	bh=mfXNeTj+Q8ZX0NBisxbi4QQyQ/0LK4y+WrTTR40VPyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPvjlWcxIgfaqaed6hZbeZ3bxHaFlVGYBfcDZP7D1qnv4AiI5acYjmNlalqNNotAHDM9lT+GoLIzIJk5zZfXD8uM2XVBqhUFIAu2q1+pK6drp7sLgDRJb2s/4EMukSrNlIS8MErHHUh4Xncxhf6RtmMbJdBv/gvl7Xyna3KCbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=KDjKOm6/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f40deb941so14334595ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739438642; x=1740043442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+g1corMoWLkqgaHyL0dUry18PBH1WwZj6geDsmEd1Y=;
        b=KDjKOm6/0FJ3659nApC3mh5Qz2KfuRT+TelHF+ecr+t08t0h66scPICfpH8q36dDdg
         QNpyYENQ5hApsce4xKZYWc/6l7lwDw2r288/mzMSZmM2UxvpTjK75ljeTzV7dVByqdPx
         /867R5Ei2/PaBSNEp/Zm6k3AXDyisesc3wjyzdVOAYEUdQpIIs7TjXWlfFeDZMbsFLCJ
         CVv8SbBjU49ezKqdbXe8QNlTxp1p3no2ssUvpPSNsstvHvLmw7r9lIrAaqXlBpobaS/R
         NwxC17uCq2KpdNFKZkZubeft8KN3u3yeKSIGiwp0FVQZSh49q1RyQYbPtIiJL11XeB5H
         jegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438642; x=1740043442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+g1corMoWLkqgaHyL0dUry18PBH1WwZj6geDsmEd1Y=;
        b=ggW9VgDj0j4dhV1M2X8wXpYWnfPZJo5guyVrTIXcpTBqCKj9i+H2SE6x8XYZYiV4MU
         hUSaFEd/Ffw/0SSe/8CfOWa+rlMvyJBuLKaYFLJW5Y2l5vHEHxU33QPgn0wCAXz02vd6
         JQMCI//dsWIphUivv2iUESpmN/pDXoN6iwTsCIycWwp0aM/Quqa507dAOYZut+FNpkNo
         noRlp6LuhkXbrLv46W6nAK1UQo1aix7wqw0j/qacafp3M3C30fm5U+g7eGj4yJKOrBNc
         zt449NCbx6MES51+MkzX6Jr6jCgdK4C0SODDDHuOYc7ynagtAk+PR697Ho1IYUnrScyw
         uqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi0cIFOUUSADY9OsiWuSZhgk+zkexQcwIjcbn81hB2RcZa3kMx3ZO9t4E0xj1qpWQdD2jpUGD3Zc7sUL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAPfeV8Skdma0GCkWmDiXpvZdHTb2UthqwPNNS+m9E/oPQ/ha
	IEqYhsAtpeEWt6qmT9sBPOwCiv/pw7I52+TGB+6tVpjk2bg66/ElwXT/pngXWFE=
X-Gm-Gg: ASbGncv2m02iF5xAlrhQMAEsjao37KnQ3qZEUr16i6l7/NQDl87COxrUET/nEpBj9XP
	4hDXr9jawMsVveO17zsgj4cE+12OHdfbVq255GRo+Nurrm1gABirPEV+3a+BZxjcdjPTlP1v8bO
	kp3HTsltI1NOHVnnBzXgInaDRvKGhDJHzEG7zfwfRpvjuI7vCoGrgyZwfnMltISrkM/ptbC2FGl
	R3STgvKj2THR6t9mdxCeA7/2gzX4yawVvKosroQR3iQeSPi7p9vQpOGwQK4ddhPBxUY2QqTyZbp
	qPDtpsCDP2vrRwgRa/Ptz9VDlR8J
X-Google-Smtp-Source: AGHT+IGF+4e3Af2SCI8Rg8n4coZI7ErejXVy5bxQnzx65sHDQNZjtZ7hhVxDzaYqpoDifzZ7gAKFSQ==
X-Received: by 2002:a17:902:e950:b0:220:c813:dfb2 with SMTP id d9443c01a7336-220d2153077mr52167375ad.44.1739438642097;
        Thu, 13 Feb 2025 01:24:02 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm805579a91.26.2025.02.13.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:24:01 -0800 (PST)
Message-ID: <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
Date: Thu, 13 Feb 2025 18:23:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: Pad virtio headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
 <20250213020702-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250213020702-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/13 16:18, Michael S. Tsirkin wrote:
> 
> Commit log needs some work.
> 
> So my understanding is, this patch does not do much functionally,
> but makes adding the hash feature easier. OK.
> 
> On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
>> tun used to simply advance iov_iter when it needs to pad virtio header,
>> which leaves the garbage in the buffer as is. This is especially
>> problematic
> 
> I think you mean "this will become especially problematic"
> 
>> when tun starts to allow enabling the hash reporting
>> feature; even if the feature is enabled, the packet may lack a hash
>> value and may contain a hole in the virtio header because the packet
>> arrived before the feature gets enabled or does not contain the
>> header fields to be hashed. If the hole is not filled with zero, it is
>> impossible to tell if the packet lacks a hash value.
>>
>> In theory, a user of tun can fill the buffer with zero before calling
>> read() to avoid such a problem, but leaving the garbage in the buffer is
>> awkward anyway so fill the buffer in tun.
> 
> 
> What is missing here is description of what the patch does.
> I think it is
> "Replace advancing the iterator with writing zeros".
> 
> There could be performance cost to the dirtying extra cache lines, though.
> Could you try checking that please?

It will not dirty extra cache lines; an explanation follows later. 
Because of that, any benchmark are likely to show only noises, but if 
you have an idea of workloads that should be tested, please tell me.

> 
> I think we should mention the risks of the patch, too.
> Maybe:
> 
> 	Also in theory, a user might have initialized the buffer
> 	to some non-zero value, expecting tun to skip writing it.
> 	As this was never a documented feature, this seems unlikely.
 > >
>>
>> The specification also says the device MUST set num_buffers to 1 when
>> the field is present so set it when the specified header size is big
>> enough to contain the field.
> 
> This part I dislike. tun has no idea what the number of buffers is.
> Why 1 specifically?

That's a valid point. I rewrote the commit log to clarify, but perhaps 
we can drop the code to set the num_buffers as "[PATCH] vhost/net: Set 
num_buffers for virtio 1.0" already landed.

Below is the rewritten commit log, which incorporates your suggestions 
and is extended to cover the performance implication and reason the 
num_buffers initialization:

tun simply advances iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This will become
especially problematic when tun starts to allow enabling the hash
reporting feature; even if the feature is enabled, the packet may lack a
hash value and may contain a hole in the virtio header because the
packet arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so replace advancing the iterator with writing zeros.

A user might have initialized the buffer to some non-zero value,
expecting tun to skip writing it. As this was never a documented
feature, this seems unlikely. Neither is there a non-zero value that can
be determined and set before receiving the packet; the only exception
is the num_buffers field, which is expected to be 1 for version 1 when
VIRTIO_NET_F_HASH_REPORT is not negotiated. This field is specifically
set to 1 instead of 0.

The overhead of filling the hole in the header is negligible as the
entire header is already placed on the cache when a header size defined
in the current specification is used even if the cache line is small
(16 bytes for example).

Below are the header sizes possible with the current specification:
a) 10 bytes if the legacy interface is used
b) 12 bytes if the modern interface is used
c) 20 bytes if VIRTIO_NET_F_HASH_REPORT is negotiated

a) and b) obviously fit in a cache line. c) uses one extra cache line,
but the cache line also contains the first 12 bytes of the packet so
it is always placed on the cache.

