Return-Path: <linux-kernel+bounces-556772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B323A5CE52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD43D179777
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C7263F3C;
	Tue, 11 Mar 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NnaOIMSd"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36B260A43
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719393; cv=none; b=bxn6/UCnzP0KUZ4WbWPrhn80kD1wWRHJChIAW/mItbOlRwYVryKpXACV6xmo4VJq57/G7Ql6NWFHKfp8Na9ffCWYqbmgG+Skeuq7bdBp/3s59LjRmvSkU/Fn7Sg5VTcetciPj3E0gdwsn6Y7P5CgGQAahqZl11abTK3afynT21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719393; c=relaxed/simple;
	bh=lNBjEgxta7oq4TwKBSAROy6ISAN/Tq6iYeWcKE4Vv/0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K5NRMUrJldSpt5/K09f7ym0ZGVS8vEUf6sOwflenAyAOZCinDroc6Ocxr7M61CUqWdDpY/1+eZ2bhb96jHNCtt78vLEAMOUnte5Jhp/7Oo+Tc2iubEyoDaVhmT72AtHU8ceNBDJ5z9q6b2EoaJKXPnUhdPS4X6ykUdRxb/ecSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NnaOIMSd; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso102241839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741719389; x=1742324189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=NnaOIMSddEPHT8Qo1YzHCECi55a8B5zU7qb0NLMcOe01u/v3w/iNulIeG1JuPW0UNy
         /rb1+5kltBqg60TmY8Bz6/9ajmJYAOCmcQnPy0v2K/gWA7l7rh2l9X/UAAf8zHJ4oM9l
         6RoNW/z35MtTPNGzjeNPt+nxZRZpIhQjAHkAfSzw//XVlc25z2oXL2Zixzpe5qRnoFYd
         5THe5/7EDTSfX+eU6+np5F5WsQ6cz5nbf0unICwVfwdpVJ771ofp+Pl9fnNhGlErQG2f
         1+DDW5DkPSDCCAdW21fZnpey9nZiWZvNwemBtuemnmsJoaTHQI2WCN8mbATBeyQOh2QN
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719389; x=1742324189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=PnvoveynsEo5t5UGFF8UHlrQ4e+cHACvmg83PFiOeQ6+tTxHY6Sn76BoAh7/YKxdi9
         GSBYQ91BynsIGvR2wuiaRtwuGbI1hnjSr8GQfXrzS6KjrfaSMxzWDjeoEbmglVgrxJXa
         uqxhtqGr/mOAXOColPy6Ji5043jvQz60fyL1Y7ljO7YSlKYucgxJmAOvXzGhTwnnNuUj
         R1fIqx+/SAulVBGg3OKkaXMr3mjn4nvVFwBOjPL1id3v4pYWwM9OXpSgAfUVeGTp0HwO
         SAvhMrTE7MV27itP2kb46khJg1J+j6c0QaEYFWdhXl9rwKWY+RFDOgcS7XqaENu9XYy3
         /5hg==
X-Forwarded-Encrypted: i=1; AJvYcCXOQtsQNe9j7WaxOt1Ib/3pwjAcWfxSCVPgETwEEkAYYQIvUOQYIMUTTjlTubIgyiWVjDOZYxGXplg3QO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0nfHo1Dd2gJw9hBu1AP9dY1LfsjkpwaOXnW5Vw4/C7Yvu7SE
	O0wNe10djB3sqh1Jc1U7hQnt1YCujfg2999tMCv0aGQIa+wFcF0adkhhCt0RSCM=
X-Gm-Gg: ASbGncs2Lp/kRInYPRO29h4W81xFeKH7NIc3096sOJaFteoRwbEVcmWSD7IQBz8aj5e
	rhdoK4bahQy6WDPIwejlsSynn6BQA1fupOEkIBsbu5uAJKP/DGfZN8u0NY2HniL4l9XWy0sUKHp
	okXOBALqILiXsMkJ5M1fUbc8cLZZbXjvjQKrSUu3F3sABCVX68Z48MKSljTQhhw6cLzU5YvZo0B
	ECc/Qp4Ubc7uNGOAILsuW85wfuyQ8pcaGZ6AgMxrCDgUFJpXYzaInfRB2MxuFfQbqx0AAf0wFOj
	PJXugvXDshZ+/yoaiUpPd9NQSPM7qtQ9TRpWFJyg
X-Google-Smtp-Source: AGHT+IF6QEvMgNWs9dedBUfcF2UZXbN6XsW8AZipdiC80ycaj5jlFprQu0VmRz6Jjl/szbD7bbMzQQ==
X-Received: by 2002:a05:6e02:1c0b:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3d4419712a9mr212361315ab.5.1741719388965;
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23abbf42csm1034856173.105.2025.03.11.11.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Message-ID: <32c6f6fb-d75e-45a1-b050-4c078a757a50@kernel.dk>
Date: Tue, 11 Mar 2025 12:56:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 00/11] cgroup v1 deprecation messages
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Waiman Long <longman@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Memory controller had begun to print warning messages when using some
> attributes that do no have a counterpart in its cgroup v2
> implementation. This is informative to users who run (unwittingly) on v1
> or to distros that run v1 (they can learn about such users or prepare
> for disabling v1 configs).
>
> I consider the deprecated files in three categories:
>   - RE) replacement exists,
>   - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
>   - NE) not evaluated (yet).
>
> For RE, I added the replacement into the warning message, DN have only a
> plain deprecation message and I marked the commits with NE as RFC.
> Also I'd be happy if you would point out some forgotten knobs that'd
> deserve similar warnings.
>
> The level of messages is info to avoid too much noise (may be increased
> in future when there are fewer users). Some knobs from DN have warn
> level.
>
> The net_cls and net_prio controllers that only exist on v1 hierarchies
> have no straightforward action for users (replacement would rely on net
> NS or eBPF), so messages for their usage are omitted, although it'd be
> good to eventually retire that code in favor of aforementioned.
>
> At the end are some cleanup patches I encountered en route.

For the block related parts, as I'm assuming Tejun will pick this up:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


