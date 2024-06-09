Return-Path: <linux-kernel+bounces-207299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C290153C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338161C2112F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D012032B;
	Sun,  9 Jun 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gt8JVmkV"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7120310
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923902; cv=none; b=gjxlcgvFD7emv6Rs/wpsJG7fcFN1ZaQZplmMbDaHrVSJt/NROdrb/FuxOpmYB49Okn3fFN0vqd3Qg4ov4P3LqDjCPHR6jwycVZ+S36FZhJquk7qUqX54waubp0jR2tGXoZ2mGbpnl3Ko8oAKJ6moG/kpmyDGPUJxmsjlWTIlMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923902; c=relaxed/simple;
	bh=Si71bFQFrRd4fbeR2nUXGk/jsEUgyn+WHHa500mVRsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asyPxg0YRIaTFkFDlXKUAIzDWZJqtKJ5ltcro124tz4lCE2DYHGrmdfRHl4hVoOclJCRvbx5L3olDumtONQI+nuSW9u5iYSTgkU3H7Ck9KSBOlbBdc75Z9FgeXEJaMwn4raGLgaOR00hcSsg+UrxvJuaEq9Znd293eeWMwWCQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gt8JVmkV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f1c4800easo15023566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717923899; x=1718528699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=gt8JVmkVmzM7jA2jbnbS/BOMoqukT+T6ETdMRCDk60sDNkKAUTotS0F9LmBLW5iMTQ
         OB+XQ3yx+WM8xl1OCihzGJlX000NgQlpNaJ5puvb/oskLrEvV6zieLY1WAwWRa913pYO
         B+wCNb2aLUXSxn43EPmItmF1Px1emI+N/nJT10r49MSDKMPS07yvQAQ1tDG+3YAMKGv5
         jfWUcMt9M3zAkirQSOh3lJDANxSuM53+qHxfIWIECAKYntCEmw8qfKFOpLT5W9dtHfWF
         p7OalkfdrTCWMKGxYNg7gCffB5u7+ns50eqDjpxckQkqjJSBlpcJhv/otwyTEI3shgUz
         FzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717923899; x=1718528699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIh4lH8bQWGJqNihyQij8olrXP+SesotSW7Pq/JkSlw=;
        b=RbXPU9YthbvDnrS5vNqf/Lmm7dGPeexkf9O3B6QzWl8koLFpu7FkzWv6uT7OQ4Y071
         ad3tPs3hzCZ2NQKCBV9lSKqBh4YUN9FvuLRlBswVU42Hgrbn6LyLs1ALCuG5Fiko7VVC
         Eblximj5cnCv05REVhUh8jwjhvSMvYCAye29G0ghZ1JwvdtXSG1cQMhGzpvv5YUydAfM
         ieww4oRKE9KA+QDth+FrEs03frMKO7e4tV2JP/DjUm3tTV3GtI5UT/AgyYJTSuffk1M0
         PoNHoI+KAha3C0vnlUK+AvCx+ubDy7jbyH2oXyXyUeVPo1KGXj72QZiLD98gujUwLm3m
         4UNg==
X-Forwarded-Encrypted: i=1; AJvYcCViA3pmwJkGe1W1jSpbTTHqmPFyIEGXavHMxM27T7I2iKOxTvVKJFxAFV+Z35Fs3dqfVBaIVHSWBO7/MI61IwXAfIkEaBM3aYe1bUnx
X-Gm-Message-State: AOJu0YyRTu3eftj1VqM2teUbV72osbu1EsklFSFaspJ3Npi5u9zeDjU5
	7JRbccn8Alrjx9vs26OXLD9LUbNzsucNcySqgmMMBnOMaodFPLvD30PIB3zWr0c=
X-Google-Smtp-Source: AGHT+IFeE9HHbL43cW+IG9vH8TRTU8lt4FODOIbm9LfnJAHutw8/LXc+pVSYkTkSkQJY+mFvTLJ6lQ==
X-Received: by 2002:a17:906:3285:b0:a68:2f99:a3da with SMTP id a640c23a62f3a-a6cd5612575mr431690766b.16.1717923898631;
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef9100096sm247145366b.97.2024.06.09.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 02:04:58 -0700 (PDT)
Message-ID: <b2d17c74-86fd-4436-9156-271045ab1a45@blackwall.org>
Date: Sun, 9 Jun 2024 12:04:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] net: bridge: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>, Roopa Prabhu <roopa@nvidia.com>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240609082726.32742-8-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/24 11:27, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
[snip]
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ---
>  net/bridge/br_fdb.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

