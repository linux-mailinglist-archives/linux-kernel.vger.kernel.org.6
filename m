Return-Path: <linux-kernel+bounces-568358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D1A69469
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DC319C345D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3161DF26E;
	Wed, 19 Mar 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y+r2+hEf"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92091DE899
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400453; cv=none; b=kQYmk/zS9Sxt68NV72s9clGopaQ8z2vRgf6zmgYff717d2aD0irYG6pqaJKZg+Sv4+4tTKjBRPOtFNxBEdhroFrYgtEBb+IwIsMdhfV2ClJ/6jRHY5tVkLQt0LzgIU4tmk0KvTwEU+5BPOAj1gcOk/Y9Ij0ywaXKpvQ8DZqxep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400453; c=relaxed/simple;
	bh=n24KzPzMfIDbuu7S5CaFyw0UePwN7haHff4RjRQuRy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n1dIcZTws5XhKF+L3oSIFCCggUXYgK98uZZCx1EHR6xhDxy0hEe+O3E//btZKksZcFI9lsHg2xDPLBc79twR+e+NNSFh2gYOX9Za7wEguCFTGO4mktKb5G1Witlsw4q3bC5N+o4JulUOfW8n5N19aNV64JimwqwpvzLLLDkT9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y+r2+hEf; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85afd2b9106so619242739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742400450; x=1743005250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=y+r2+hEfjU2Zz7ALNOq5svFqzJiE9cuXQdmJA+P20x3ThNxa4mu8TtLObqNVlmroGR
         OlmZyYGQuf90qEw4W3uFuM+qnOHzzxc8ucTo7UpOKYtNKkyBbOReAsQhAQo3E/IP7leE
         E9wx4qFx45Oa2aV/2THQw+dab2TirOSA0A+EQ6K560wTR4bka8wphawWRyI/d1vJFHr+
         qzQXF+jXmP7T7oWdIYtu4AfbRAkJbRlbzJRgprCtUulnirrdugfhtvRDW6HS5GWmBfRc
         krNJStKgc3sx9SLXZLXnd0wZOcaGEL7gXh4wuw7XqjLN2dft+wd5LxMmSpHgutBnovf3
         PLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400450; x=1743005250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=B93JvXgKw/nbc0QQLE/MLZW2wPj/TniKR8IaZub242NM8qzgVd//qK3Cj9wbaw9ebh
         xeaNNgwUtk3ZTrDGboOQKvkMGstDLB2jG6RdP6+DFNjWBfVkSwvjjBejZiEpSEscmLpC
         CcMpui4mfwzI1OI1BOaYME55AkmdVH90H57npzRI2V0E5g39ZOYrSEbIn/f9eX8K4Un1
         FCBSOoAamq4EfQNKV9deoUmvtq8F+uHKk/xwuwwEPfCp4uRVEvj4N1oURA/tFrhQoML9
         KIry7QHs+P15H/k3yEhDQ/AyO9O3GJjEx5jbW4jD8+bzKlhScqI4QpYO+DLDDY74OF2s
         gsyw==
X-Forwarded-Encrypted: i=1; AJvYcCVNkS0MfWVkN7BhWbBwIhHQsibmEFtLk/kfoVb6+FViT1L6WtSbvoBcEaI0GEfNR/66pPIc56/qxmCrhZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ffrnvXrEt2BlWsq33HvYRnEKm085Ufr2LYvVcOu5Li6QuEP3
	gzyWSi3bzXswHZPxeFSTldnB2mkfJ1QOIoNNLr0MeMhnHtaE3hfHl3YeOwEEhzw=
X-Gm-Gg: ASbGncvJR0i3OFr8nmsheE8LdY5nih+RdU6w69INcrQBD0wqdQ9tYwrzHkGudLH8svz
	qLd+7odNwlYqfY39l4ZvsiKVQN/HRnTuBmdTBy1R/z46bv5PhwwgW6OLVM3WzlveOzxt5/YyBsf
	qVTgDuEqxHTgg+eHVSi37ONn7t+iFhLD2T8OgnyEyV7fJEcrIJKUOWL4ElLdCZEXR4fUsf4NxDt
	dzMiqbaWnfIG92rw2MX5/l4RK7+MmZHp4AT1bR6KN+FvOPFx4kPHMr2L+z1tq86lmhs6MVt1je2
	tgtc5sbAuX9Y0bssWpnoSs8XuNUhcC0J9XGE+k6mv3FR+vrqMyY=
X-Google-Smtp-Source: AGHT+IFDBCFWtf4DEWZHOAZhQMfKg6BVxtB70LM/11gT5po4hUy91hL9GfbCfrY2dAmweb9btJ2fRg==
X-Received: by 2002:a05:6e02:1d1d:b0:3d4:3aba:e5ce with SMTP id e9e14a558f8ab-3d586bb9f32mr38295495ab.20.1742400449657;
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719730sm3269768173.36.2025.03.19.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Message-ID: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Date: Wed, 19 Mar 2025 10:07:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:32 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>> extensive work done by Pavel [1].
>>
>> What is a "zerocopy notification" 
> 
> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> to the error queue. The user app can poll for these to find out when
> the TX has completed and the buffer it passed to the kernel can be
> overwritten.
> 
> My series provides the same functionality via splice and sendfile2.
> 
> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> 
>> and why aren't you simply plugging this into io_uring and generate
>> a CQE so that it works like all other asynchronous operations?
> 
> I linked to the iouring work that Pavel did in the cover letter.
> Please take a look.
> 
> That work refactored the internals of how zerocopy completion
> notifications are wired up, allowing other pieces of code to use the
> same infrastructure and extend it, if needed.
> 
> My series is using the same internals that iouring (and others) use
> to generate zerocopy completion notifications. Unlike iouring,
> though, I don't need a fully customized implementation with a new
> user API for harvesting completion events; I can use the existing
> mechanism already in the kernel that user apps already use for
> sendmsg (the error queue, as explained above and in the
> MSG_ZEROCOPY documentation).

The error queue is arguably a work-around for _not_ having a delivery
mechanism that works with a sync syscall in the first place. The main
question here imho would be "why add a whole new syscall etc when
there's already an existing way to do accomplish this, with
free-to-reuse notifications". If the answer is "because splice", then it
would seem saner to plumb up those bits only. Would be much simpler
too...

-- 
Jens Axboe

