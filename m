Return-Path: <linux-kernel+bounces-541671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E9A4BFD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6220716BCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643420FAA1;
	Mon,  3 Mar 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UTV4I8d1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37820E70F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003625; cv=none; b=ay5lMGncCa7Hqv3rb3I88Txt+oX9hJ8dO2fpiZi+ANiZxNz7GzGjTgirSME7FG2A/J6uPN5VjOAT3DQYP7qVLDROXUY1iM4hjyC4U8F56uOOPpjDNhHJ2EBvJ+cvi4mHgdlULvoQUrk9q6Z6Tr2aJP7uabqUGZVs+TnhCTsO3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003625; c=relaxed/simple;
	bh=vKeWJ6PdCI0gjejVtsLlKdmx2G60m+SZ3JQZ4iCmGTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrlLL78yu8wpVqu6DMzM7hvk2DbZfTYFnOej8YAweZq9R+4dZW6DNcyHS4ROulS46/RCoWiVvhTKTeTPY2tDqrrERw+Vl7dgJhTRhyPhgRq+jq43Rl7bwf6LLjGNto9ajxNveEJk1mZV3pjU0FXLsoWXDeaDXdMeETk+yvDN46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UTV4I8d1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so4328965e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741003621; x=1741608421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4n87D+4TYCPxOP1NMsttu/7Z4wxAKcrq67P7w2tcEU=;
        b=UTV4I8d1YgExUBz9SyFZi2B0kKTVwJzdNYKCtP/b6+E3fQA6HC/xTnDupLFob7Ljn6
         5wddo2QcTYqqe7GYH6KV1tuWiQeK57P1fYZsxVpQ8nO4eiZsA4mG3nm3fz0Cy5b382PD
         YCT1oHEt322dedGzJ55C9cYw/G4xsgsaBrZ9oII7SwmbfR+BfBn/kZ3btjwCg5fC90wM
         DscRzB5fhjsUxIYvlyI+JdFL5Fu/ZhkoHR82kWLYwmwlo+AMJ/wGLnz4o0C7CwmCHC7d
         JawN/zyRi/iy1OlUeF6J/w9qR+qQ1LBYJ2wi28Mb71GHsslvLhLPS5z5jNVFwVRCGWNB
         Xx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003621; x=1741608421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4n87D+4TYCPxOP1NMsttu/7Z4wxAKcrq67P7w2tcEU=;
        b=Wnk+HS47IBCmHyfUxw85fGMB8jSnXLBfLU7OhE3HSpsRWEnMpD4IAFFBbt1vHyC61q
         GF7UVlz/6Alxonk5rPQiTD0/AD4cmTj493iNHlWD6dzfRh41wtMFc4es077Fp21unCdV
         7BCW+JEf2+LdRvoepRsJm6J+xKMziQQUhJzj3PoVphca97KxpUbK/KfESYqApZqn7cML
         mkAMrNRaxk7U+lxBJwsYy5zYUjNaYrEH96bQgIoChv+26JdibU42KkOpyNIDpgHzuMVe
         aPGggQa7Ko7lbRVKwtyupkOzW/jMp+hU9gCe4PUQXTD6dHI30H6tcCnwPcQzQHbgpyK4
         XiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeHJ28Q7Yk07obffMVcOYez4qG7gGpIrnEDOWRfx5M05L+ypKuhbnOCgJB2b7unAwhpLvJNXvuytN4jUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4T9+/t5LQIlD44ecMUIgGfD8moACH5Zw3xryhTwhVjnV8ZVg
	+gWNT8MflM4Yo5F29tD90fke1LgO4k+lrE5q31OLQsZj3flvxYPR3+OywiRfcJU=
X-Gm-Gg: ASbGnctJ5JwpQA0fkwDydAgYsQV48GdAOPKmjKUvRRsA0umBh11RbWV5K+xPrEF3mgm
	EjLPF9PIZjH8bZJz2AdAUSDorPWs1czs46DsDMNyqaIGSTHmIqarWJSuXpwxdJ+vKxdjqAJgL8J
	JGM/0GNaReAfwJVETmqhinZ1qD9EebIMELmWGw8dXUnGGNoA0b2iIe9wweCkw/2tRl/ZD+c9PtO
	z6dBMUXyeuhFLjaaD2x0cA1uFR2gF/YIIEaFoReanQM+wn4VigbzPbZUei8clyKZkwgnN4K0xz+
	pbUrK+hDuE7QcNUVhB2mb8iXxvJyUEhfhzJSlXTmDd4Nd1FKNV6WG8l6dw==
X-Google-Smtp-Source: AGHT+IHqHfP8DjkalDmAqVAgdGb6muzuQBb7NPew5jiVs8Tdm6zb/yC1t6gsMZUxW4RNTuObE/ckQA==
X-Received: by 2002:a05:600c:3c84:b0:439:8ada:e3b0 with SMTP id 5b1f17b1804b1-43ba697f093mr97840395e9.19.1741003621315;
        Mon, 03 Mar 2025 04:07:01 -0800 (PST)
Received: from localhost (109-81-85-168.rct.o2.cz. [109.81.85.168])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b694524c6sm163268085e9.0.2025.03.03.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:07:01 -0800 (PST)
Date: Mon, 3 Mar 2025 13:07:00 +0100
From: Michal Hocko <mhocko@suse.com>
To: ying chen <yc1082463@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
Message-ID: <Z8WbZBJFpfpue_g9@tiehlicka>
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>

On Thu 27-02-25 22:34:51, ying chen wrote:
> When we use zram as swap disks, global reclaim may cause the memory in some
> cgroups with memory.swappiness set to 0 to be swapped into zram. This memory
> won't be swapped back immediately after the free memory increases. Instead,
> it will continue to occupy the zram space, which may result in no available
> zram space for the cgroups with swapping enabled. Therefore, I think that
> when the vm.swappiness is set to 0, global reclaim should also refrain
> from memory swapping, just like these cgroups.

You are changing well established and understood semantic while working
around a problem that is not really clear to me. If the zram space is
limited then you should be using swap limits to control who can swap
out, no?

> Signed-off-by: yc1082463 <yc1082463@gmail.com>
> ---
>  mm/vmscan.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c767d71c43d7..bdbb0fc03412 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2426,14 +2426,7 @@ static void get_scan_count(struct lruvec
> *lruvec, struct scan_control *sc,
>                 goto out;
>         }
> 
> -       /*
> -        * Global reclaim will swap to prevent OOM even with no
> -        * swappiness, but memcg users want to use this knob to
> -        * disable swapping for individual groups completely when
> -        * using the memory controller's swap limit feature would be
> -        * too expensive.
> -        */
> -       if (cgroup_reclaim(sc) && !swappiness) {
> +       if (!swappiness) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> --
> 2.34.1

-- 
Michal Hocko
SUSE Labs

