Return-Path: <linux-kernel+bounces-568301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE54A69357
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F49C7A770E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405911D5161;
	Wed, 19 Mar 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BAlQhS7D"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113591C4A13
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398062; cv=none; b=N2wJBn3kWR/Jh81DdN+xsRORCF/s8TqA61PU3iEN1hU0yuJzSj96vGFAhjvslv4DR4meixAwdisC0m7y3+H6RPoisYhxYpEv+4lrgleBogVC+s7e6OEXlhT5O7r7YTGI5p9UubL5HrqM9PeRQqTFEQ113BOKRZD7TcM0KmOXZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398062; c=relaxed/simple;
	bh=ajFWxYn7pN6VZQbZWugpPVNdvdOMkJjRACF7eJSLLoc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N/2Ga6Rxk4mukRD6uLS9BvD9bMNpD5DQWpDACViZ7PSL2xQynVepksOXT+nUuMtLm4iQUACaG714D2Ko6BMwoInSIEpEDwMRK+yfB+8kx9iE7m4gPEvs1tj827kC0GY0i+jcrmFK1jn5zrtm9aFRTT8PhulCxjT8Tn63EIArBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BAlQhS7D; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b4277d0fbso248657439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742398059; x=1743002859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z5XI8XP6pizbR2wnq7L2d99WOMcynVJcs75IPIYppQw=;
        b=BAlQhS7Dm6zPUORdWPqzZAXL4vAe7RWxABO+yL2EaBDL0JJ1KyEU97HN+xd3VYQq7q
         UUrTdBc2vI5g9hGbfrlD3oNi5fAvBBCTEt8S/h5a5/KtSsHLYoQYk0qZbzvBxfOQwH44
         vuREk4d0UvEEtqXO+ARRk55UwIfS3X2dBWq8AqzWUkEjKIs/9dDjhKniXVrc9uRzSyfk
         jlHoGi2w+bxJU3R6bpy75gVbfTppX3CzMfygwyFtAGMW5sAYrBv3X2DTQ8Aam7dKLgE8
         zUBv+UcTB19ZCG0p0ZC4A+N13Ioj9ze+4SOqRQ7m3FaJ31s2oYsVq3jTMbzPP91Y11F9
         Gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398059; x=1743002859;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5XI8XP6pizbR2wnq7L2d99WOMcynVJcs75IPIYppQw=;
        b=GvML+o9+rBssa16DLQBJPqGONNAu4WbXMNMYMfEN0W9jcjhyZt6iKDy4HxXZMAjB6y
         WGTNn1B0RsNu3CRFH6siFNy+PIg0myLKupqSYg8L1PwVe91HtWswWAkADnaVKgicEZHR
         y9QorNw6DUHm+L20/9JAxEnRlCabwIY30gHtS/G8VCki6ZxDQKChPnN5e4BShXOCooVP
         iELqq9pIka/OhyPoSeLJyxSvzc23qw7934OXilJYKnYFWa/IKLn1JaoltjhvNSJwrwoN
         m80ixhYaRH7aHN3TobBZEjcNjBnTPTDbGyXDV1e3hBXPtOlhnmi0rrBk9e7MGt1DA8OX
         u/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2s+9x48bgDyukh45Lg6BSOEjozPrSJ+O1aIi4AWTcLEauq+JtQPVwGOlAappi3VeIDAWARRi1IPltjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFioh2ApWgZm89oKXOtgqtuEtmvXS3TvzsTdb99DR7IRLMMOq
	qZI+12qpmBn5ZEK9HoR256u2VgL9hYMAU0qQnSPm8K+4UcXJwPk517Rg3LvaoMceaBMAr8zAN0m
	8
X-Gm-Gg: ASbGncv34mluBkZkdS5DHHl5cbVk3b6qXVtF5d1GqlW3/b+jkgp/DlZsVYjgyJLBU0X
	khnkoea1eLWQ1GBuOlxecryCe/HXAeMLaElhHiYeUcj22I5lGja8uEEN54oO+/Wv7GDsCM+YMi6
	lYw9x3+QM7ca9Hn9VX785vGyxBgW047A3rqERrT4Y+y04QAtjWxgyXAmVt1NGwvQDPesAI+TbLp
	GghwMkUfNc/V2B955A5cUNTA3M2VRUoLByE8i779kZjvjAEtMzjtnYBuywlSL//4Kt1/OI4UlvC
	cFKeY8m6xMiWZZKowjHqzgyL6EMhHN47leNioqiP
X-Google-Smtp-Source: AGHT+IFGYzlq+PPNSs3OrQmXqUnxT0HIdylQ9a9U94OGg+zbDXr0tA1fKwH39YYPMJPyqHijFNyP3Q==
X-Received: by 2002:a05:6602:3816:b0:85d:b26e:e194 with SMTP id ca18e2360f4ac-85e137e2951mr401062139f.7.1742398058991;
        Wed, 19 Mar 2025 08:27:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db87797dcsm309098739f.18.2025.03.19.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:27:38 -0700 (PDT)
Message-ID: <f78c156e-8712-4239-b17f-d917be03226a@kernel.dk>
Date: Wed, 19 Mar 2025 09:27:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [RFC PATCH v5 0/5] introduce
 io_uring_cmd_import_fixed_vec
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Sidong Yang <sidong.yang@furiosa.ai>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <174239798984.85082.13872425373891225169.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:26 AM, Jens Axboe wrote:
> 
> On Wed, 19 Mar 2025 06:12:46 +0000, Sidong Yang wrote:
>> This patche series introduce io_uring_cmd_import_vec. With this function,
>> Multiple fixed buffer could be used in uring cmd. It's vectored version
>> for io_uring_cmd_import_fixed(). Also this patch series includes a usage
>> for new api for encoded read/write in btrfs by using uring cmd.
>>
>> There was approximately 10 percent of performance improvements through benchmark.
>> The benchmark code is in
>> https://github.com/SidongYang/btrfs-encoded-io-test/blob/main/main.c
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] io_uring: rename the data cmd cache
>       commit: 575e7b0629d4bd485517c40ff20676180476f5f9
> [2/5] io_uring/cmd: don't expose entire cmd async data
>       commit: 5f14404bfa245a156915ee44c827edc56655b067
> [3/5] io_uring/cmd: add iovec cache for commands
>       commit: fe549edab6c3b7995b58450e31232566b383a249
> [4/5] io_uring/cmd: introduce io_uring_cmd_import_fixed_vec
>       commit: b24cb04c1e072ecd859a98b2e4258ca8fe8d2d4d

1-4 look pretty straight forward to me - I'll be happy to queue the
btrfs one as well if the btrfs people are happy with it, just didn't
want to assume anything here.

-- 
Jens Axboe


