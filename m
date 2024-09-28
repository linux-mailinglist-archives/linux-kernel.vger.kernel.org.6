Return-Path: <linux-kernel+bounces-342477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407FA988F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC601F218FD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1709187FFA;
	Sat, 28 Sep 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pt1Ycg0z"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8F125DE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531188; cv=none; b=QzgmS7V/6OVxLIYIj29z28W9YbClQdrL4O7Ba+dnNXx6opQe0TuEKA19+WCEp+YQYVxft/y0iIiUCY3F9ob8hedPM8BHhcJ9FYhjWcXJBolrVje4iCL4qOIE6zKZA1Q712g+dU8wnKEI+z5c1n/yoZCWf/kRsp73Y9VGmNo/tgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531188; c=relaxed/simple;
	bh=TLX6wtKkH3TNan+28Rg//BuZKjzvb/yVzM756sALvvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os6+ij73tnRgcl+Kzh+zUccPTzEGr1hJDV7R/lrkAz/QDAFj4Er7U8iYTMyZF8pmqGbE5NLmk3A3CGIpH/mH8IAhda+UsbXu1rD644Js33c+JKLZq91UZc5v3S5KXsLu07brZ1D0NQEQ6Ur4Abm20h0kmURgGGgTMX9x6cP/AXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pt1Ycg0z; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c5ab2de184so20567536d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727531184; x=1728135984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sN4zfuTrVKtE2y+7jsLqat92Xu1bOSH8FKZo9LAfzk=;
        b=pt1Ycg0zSyjK6ZEzsbeT7Xr9ZobJ/YukLdchg1b6cxgPuw90zDONjnwpv7j+0hAKzW
         XIWMvgkP5RGDX+f5ZVKIQxdoq7F6ArGd7xGRhLevJUvoeos2m+jGv45xfpmRSyIwYdHr
         RMK2XTsOYHjzKkXWP7hywmfWH5irU6GFxCv8vCBgs+Bx0M1aHSMbXv0CLD2gwjNHeZU4
         YfyJSDrNdywouhTz6fkaeSZq09QErcWaJljwRPF47ai8nbCOrtpm1xP21Ka1Q0gNT9bw
         cg2NG+0LE/07iWncYFan3pZQtlanowc1mGuBHIfWx6P1Z750NZb/50Csk+dvNrF5n7h9
         7gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727531184; x=1728135984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sN4zfuTrVKtE2y+7jsLqat92Xu1bOSH8FKZo9LAfzk=;
        b=UTA3I3pMrOUz2AzehW91LzswO4wOvqR4t4zQ0TzFqBZz5jkZeDDvzMWyaede/X7onV
         mhfnmgggAQimVlGcLs2SxFozHCTRFfkKQhbaTQynMa2aRnoI3PAt0eeEIG55AKxZcmqp
         7rfGHZIB8Qk4VSBlqSqYz7vd1J6m4jnGKO/qZxJ8gbtgGv82qQKys0Dhq8NOMWGUxO39
         7NfQavtOT+t8QEfYLpdz+UlXDlrZnpyr+PRTS+g90S4DuWsZFsVhrTVJDt5fL2vCeusM
         Emw6R/bcwKGRAvA24lXsqONib52JdceJs49TNg3P8OJfuVjq2Zm099wDJSwYGMuYwJ07
         FxxQ==
X-Gm-Message-State: AOJu0YxbvBsuJX8gUM7QIt8YG37GJB4YN1nuWLkUKJjPIUYLeSArpIE6
	9ElzdjI6Pw/PB7cQv6zuxOE7r5E3oAyb3TVNc30uwuRRAWZafpM/P5q+lRk/DM8=
X-Google-Smtp-Source: AGHT+IF2fojP0dtZyLIM5+nHo1k2WghChM1L/tdHDzXgdfACgOx8AXC0EqTFwlLQ7ZUQdf5ldjnuEg==
X-Received: by 2002:a0c:f40c:0:b0:6c7:c8af:9447 with SMTP id 6a1803df08f44-6cb3b60991cmr85388876d6.24.1727531183658;
        Sat, 28 Sep 2024 06:46:23 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b60fa67sm19472216d6.41.2024.09.28.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 06:46:22 -0700 (PDT)
Date: Sat, 28 Sep 2024 09:46:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is
 not defined.
Message-ID: <20240928134621.GA957841@cmpxchg.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928021620.8369-2-kanchana.p.sridhar@intel.com>

On Fri, Sep 27, 2024 at 07:16:13PM -0700, Kanchana P Sridhar wrote:
> This resolves an issue with obj_cgroup_get() not being defined if
> CONFIG_MEMCG is not defined.
> 
> Before this patch, we would see build errors if obj_cgroup_get() is
> called from code that is agnostic of CONFIG_MEMCG.
> 
> The zswap_store() changes for large folios in subsequent commits will
> require the use of obj_cgroup_get() in zswap code that falls into this
> category.
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

