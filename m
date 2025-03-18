Return-Path: <linux-kernel+bounces-566575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B46A679F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ED6189BF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F1211479;
	Tue, 18 Mar 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gowYnnJz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F491210186
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316195; cv=none; b=iY/hwrREQgXduA3upyO1lUGln9BCehFRm1M9IN6zQ3b57VBYYP4Y3oHOuEnEOSj/O5ddZsLd1Icqvd9j7C0WCbWcqI1TgILVYLiYWZsCRIXsxtCRsSDYCm+Hw2E8+oqjVzGUag0/VjtfxLnB/RUW0HXnXpEeIWBVggGdDJbpDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316195; c=relaxed/simple;
	bh=EsbgIYtjbfNeElRzR6OisnRntRlhSoTM036q0hXfBZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/gUe0TKCoy42kLkUyF/BXtPvlOXdEur2IKxkMTAwK63msHhmWRY3Ekv1Lj0DqBecjb86gKqNWZ/vD+gYd6o0au426lmIf88MCzLA4039iX6do8VfjhdlAkPhDaQ/hoza/1RNqZN6PNJBQNU1V03Aj1VJDkX4W2nYogZ2fmSdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gowYnnJz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474f0c1e1c6so55614331cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742316192; x=1742920992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9CLAy0aRkMC+3t0gCpzgmh226XJDIlR7r1Y/Y+7ry4=;
        b=gowYnnJzXSONBI2Ig6zTHQe4j6yag4HBZr+QmqtGUtdQTGNtFMqajMKPAWMejUc8LW
         4OSH48gkxrc04bsnf1MOTenuMQgzYSAVKv+QliIwYxWfx4PLftuNlpMXWkh9Sn7jXJJ3
         orZEnhTVgDVCdah6u7KMUbMk3MKKGiMYRW+t1Dj8aQuaVRE7kJIWDpt56kIpLz369fLm
         JrUhWW4SNMC6t6wkL1RheLmN4A+DkO+8ubJVRWppTE0ArrN0JLUIfNQWKT+bnBTjC6h2
         xM/gjQveoeFS4KNHD+gkGID2tmtlH/RMY1UAQYTXkw9+ZWQ9X7vYe7Ie9M6Lft5bD9nA
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316192; x=1742920992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9CLAy0aRkMC+3t0gCpzgmh226XJDIlR7r1Y/Y+7ry4=;
        b=KM2JoBii3rFcBN174fXiEKNGouQeUmxxp+yWbvlZrIILgGceQGjuKN6uaMNBTu7rLw
         B8Z8kuHoiq+f/t213te2dt/CMFUXFRBPfKmwo5nrNIgc+z0G24a5epLLdl0CzViCnppb
         4ch8CvqrEPYWC7tm5Gm5EKMD9sMizj/oo6GLKsoUqHYVn65TJkIKLG9gJmXwdvw1AGL3
         2biHzmrNDv0KiRAnWuodYOPN1p7ohE6jYtZBk0fjzPbil3Cp9d3tqmLTOyaMbP0pWhho
         8h/Wb8o3QX6AV0RsKEX8PxW07lD8Q0Sm+XfpYEq8rOmMny0svLOAIHZgtcmYM/xA8EXv
         GEIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRpJtkiEpYm9kAv8iYzHXZx42Pu2lG4pjYc1vsLU1a7nGBeNLiDriYQ8nr2bQBQTQAlGF8h5CfxYFQaOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqcPMQ7EknyIZ6HoCVdJmHe6NtmfJFJuW04swcmaLcn/zCYFm
	LvmsSp091cGKVfAW1i+PYJji1DDoDNkRzf8NU8jdFb+X+lurDYSodQSK9mJL8qk=
X-Gm-Gg: ASbGnctAUeffle5Kz2c3+8fXCTMCzhi2XI7pNkKFlEKr+0+bMrN6ob0mueaaYNtUDye
	oibBvcfx42I29rddh00eX5W1xMdkivrNW2AElDv4CC3AarpWYspRyCU5SQXTCZWM231QLQeBTY1
	A3u6lRVikGZLE/kcDmPYXpP7Fqfv8wxUaHHrzM1c/H7MmrBuMSfLF7kl7NGhZ3q0SqOfKHF/o43
	WC4Nbs6fNeNY6uxamAd8pDm/dXWvQeZ0PJNNs6mqQpD16NwekDXrp0aqI9ZU/11TlMf02eFcpRQ
	m10lhwZtke1/x83Ao7TrnwQ9eBxeJ/Xx2E68vEyriPg=
X-Google-Smtp-Source: AGHT+IEzTYUQvFIqJGczT4BQNneYiwp+YHih+8M1aGN1FxBK+xc18mlXInT5tBAGDIgXKIv4Q5neOA==
X-Received: by 2002:ac8:5955:0:b0:476:7199:4da1 with SMTP id d75a77b69052e-476c81d94b1mr252892281cf.46.1742316192210;
        Tue, 18 Mar 2025 09:43:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f3d0fsm69107731cf.59.2025.03.18.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:43:11 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:43:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
Message-ID: <20250318164310.GB1867495@cmpxchg.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-3-jiahao.kernel@gmail.com>

On Tue, Mar 18, 2025 at 03:58:33PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
> counter") introduced the pswpin and pswpout items in the memory.stat
> of cgroup v2. Therefore, update them accordingly in the cgroup-v2
> documentation.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

