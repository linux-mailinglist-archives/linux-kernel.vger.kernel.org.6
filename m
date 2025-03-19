Return-Path: <linux-kernel+bounces-568477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C198A69611
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3C188D822
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3221EE029;
	Wed, 19 Mar 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cy15NsXG"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA41E22FD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404212; cv=none; b=XH1qb7yZu9S09+J+MsKLl/1+phmXHJIhjL8eG9d0+9dEC9f4s1mo6aZdnpkUxNfkdOTJma4dIIMbK8AptIIvRk2EXvMrrvQP8czlHmKSrrX/uVnsU5PGzaKzZFX/FPqIw3LNWaaRrMDOVlOC5ro1TkKcM+9XHQKyKb0gqQV+p98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404212; c=relaxed/simple;
	bh=5d7upz7B/l6U5x0NMnEBfrZij8ioogDhdiOywgYsZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smVWjkWEQU0q0SST3mfEsNe3D0fTzP9Y1K1m8jk5IzO/22L8JaJ5argawfXooSAxgZnQfJKU96eZoYfvxifVxRgZdsWVhJRb3ySgZAR12em3d4gHmZlZDCu9SUpMeGW8shVSiwXJsKBvx/2ck1gqc9z8zgLEpo3tJrFJu04xxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cy15NsXG; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso49267585ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742404209; x=1743009009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvKPIfaaqvxeP2gFs1lsUm/HPuI7R2LP+xgOJBg1ojE=;
        b=cy15NsXGNj5lfba15RiqSl6+7Aj8QajiGwtvKmLTVdFUfi4RqJHrRknjXdvlSIglBq
         E7FSZygjeypE5VVRjqZenj5ozOmRz230PqFKD1fsDkQF8A45qDvzzblB2k7+bt0/NsGa
         uVIoPgjh+I58CZ9ysGGSNeDrwTP9VpNaK5yK/SqfcB09nQsNDj8H2OhDoyTOi7B9esMe
         OEFCtY4WHtzXs0BZVBe5owm3053ckMyS/NOWMrb4mVJMJzfJi06o2CqP/JCdoHZdcUrp
         pCCQs4jl+berbgYY0DH5Bv7RHrZl9YyqdesuSWoMdOpSeXt90apZbKaAn3+SASZGIga/
         9m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404209; x=1743009009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvKPIfaaqvxeP2gFs1lsUm/HPuI7R2LP+xgOJBg1ojE=;
        b=EoWaCKWxTN2rNKez1x1Z0Dh4bFXTSp1cj5Y7VbISw9bOvNKMVQHGY67W1tjJ4WJw3F
         QhlLFS6/zFEztgwWhsSNBZYLP55ytWeDEA2yLl4OMqSPOOuD1qSZU/k5UQ89167QM2Ct
         3hfmI2LV9BXWe3tHBIViJLPKZvM3lGqadEMz6De4q30WSd2aYI9+oP58NGbnF7om4ApQ
         Nk4zsahzEIHx46SGeCi5AFnwcXKdexKeRnDKL7OBRqEYXNJRp9xVE5Mrl+zVah9bBFMe
         kevjVGC1X8rehsWcEzN6wO4uTIzHodszem9Gmb1dDmrKPBa9fh1A2cocfeDHNUoCxjTd
         7oog==
X-Forwarded-Encrypted: i=1; AJvYcCWbE9mZbnZZcvrOc5m1NyDnQbTOvqk960ssxUElZfwZMbCWNRs3QjE6/uNjXTIQNn3bnUenG3298Uro2YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywC0uf8bCXfhoAriO1hvZYwPqNKzQNlqYyzy/nJlRhkBd8uld3
	+OE3hJ/FDdY6/71aqhVyBE8a1icy8e2us1uv+8Yn40j49cpNumw5DYe0aTK5vts=
X-Gm-Gg: ASbGncstpF7sOtmlJQgROfXTEi0IZD4agzMgCPR2Afamj2oTPF3+k6YjPRQj/Ni+VhB
	h+Ms0jHuw1dxLWKTiKv1yanO1YjhOLAyIff6DxZ16n9rvbQh5q5+r0ftczURKcyRtCQSYa17fba
	itFK3+nGbwV11RSN42snaZA4canih3Ovs9dkJnJnMPuav3NMqrLmsh2lVIK5Jl68iIpGdbQKw98
	AnFQsmgsBi4mgEIqGCtQSfNjxjA6LkhUm1iAWwTUddpmNAGHcUi72GYfo/2g5rSo4osmNw5Uk/V
	OAoMPGvQf0/TEvd8kls8W/RAboG4SRGzhqoAcWd4
X-Google-Smtp-Source: AGHT+IGWl2I1xOgcxt/qEPpyHQ8BUlc3Uem9MmYeYl7m1Gz6G3S8Ky41p9F2HGEzpxK/50SXU7PFVA==
X-Received: by 2002:a05:6e02:1549:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d586b1b246mr35475725ab.1.1742404208874;
        Wed, 19 Mar 2025 10:10:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72e015sm37657205ab.56.2025.03.19.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:10:08 -0700 (PDT)
Message-ID: <4ba22ceb-d910-4d2c-addb-dc8bcb6dfd91@kernel.dk>
Date: Wed, 19 Mar 2025 11:10:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Sidong Yang
 <sidong.yang@furiosa.ai>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
 <f78c156e-8712-4239-b17f-d917be03226a@kernel.dk>
 <20250319170710.GK32661@suse.cz>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250319170710.GK32661@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:07 AM, David Sterba wrote:
> On Wed, Mar 19, 2025 at 09:27:37AM -0600, Jens Axboe wrote:
>> On 3/19/25 9:26 AM, Jens Axboe wrote:
>>>
>>> On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
>>>> This patche series introduce io_uring_cmd_import_vec. With this function,
>>>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>>>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>>>> for new api for encoded read/write in btrfs by using uring cmd.
>>>>
>>>> There was approximately 10 percent of performance improvements through benchmark.
>>>> The benchmark code is in
>>>> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/5] io_uring: rename the data cmd cache
>>>       commit: 575e7b0629d4bd485517c40ff20676180476f5f9
>>> [2/5] io_uring/cmd: don't expose entire cmd async data
>>>       commit: 5f14404bfa245a156915ee44c827edc56655b067
>>> [3/5] io_uring/cmd: add iovec cache for commands
>>>       commit: fe549edab6c3b7995b58450e31232566b383a249
>>> [4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
>>>       commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d
>>
>> 1-4 look pretty straight forward to me - I'll be happy to queue the
>> btrfs one as well if the btrfs people are happy with it, just didn't
>> want to assume anything here.
> 
> For 6.15 is too late so it makes more sense to take it through the btrfs
> patches targetting 6.16.

No problem - Sidong, guessing you probably want to resend patch 5/5 once
btrfs has a next branch based on 6.15-rc1 or later.

-- 
Jens Axboe


