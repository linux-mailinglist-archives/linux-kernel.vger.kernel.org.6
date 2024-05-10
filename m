Return-Path: <linux-kernel+bounces-175225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447298C1CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEEF283123
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8E148840;
	Fri, 10 May 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hf0Uy9H"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2843308A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309963; cv=none; b=DO6RMruSLVQSD8geD42LswDU4zI39DPSVHNK2ttdaZAM0mqYfL+MtLOs7Vq2gtDeBNbzhlNliq3uPjy5BTDI4ymd13AJ2hazw+VcmVXj95UhBF3KAr1PZerd6qdvUy86sEMSRpOs8q9sdzmQH++iPQ28XlIQNF5ndc92OlE/v4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309963; c=relaxed/simple;
	bh=Pi6sA5OEePkFTgTO+Gh4nnwPpOvV+oqjS1oHiKLDvl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XSgqmN61GfEL97cIpT5BL2iKHtiIG605UCTdKAZ7FXCfyVB5mbWtxEL4/IiQ6u5igvogcyHAi5LscicfDj4v2nysG90Z8omATOCN8dUwEcWmdaX8+2Wj0OlBQHtEeR+NgtcwNV3S7lR+jkskp6N2ENEF7Mx1SqWCuPYubpu1KKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hf0Uy9H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee5f3123d8so49155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715309961; x=1715914761; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YAvN15jkkQy4bLNa73Wwd2uC52sgt5QgcX7n+MN8qs=;
        b=3hf0Uy9HEEUjocQJn0hkVh1LuBIrj1JOSoY4aIjaU0gVgsqlunDjY8bp4C738/gbQ+
         WZ3v1GINnwn1YOL6ht7m6T8wTGBGF5Scm4iirUsJ9ueDPKc+v6AXIqeJ0rtJVXeydOhS
         Y+VgONUuJBrBlr+2JvwLi0Uvc+Q8doBQZLcaG3n2ORXssx3pM4+MchWIpXE4GfDtvM6H
         hXg624jLcDiK6ghi3p7LaJPGaXAPs4SCUGv3fKKswlca6aDWUiOxr7970P7Xz+haRfb2
         DcV26cw/6TbSnPvI03OGNjyFBDVZIRcWvialpxfqIW/ZebCt9Px+aOocq8FUDcYWgnLh
         bYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715309961; x=1715914761;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YAvN15jkkQy4bLNa73Wwd2uC52sgt5QgcX7n+MN8qs=;
        b=jCxy0JZdDDUvusXJn4Z5ZGYTReWX66iWQ54ya9RG0KLHqg9rhsTPVHUzwlGIfXsvyU
         jyoZJFhaeAVD9UrHkYGWtHRbiE0k+QiWJfNbahcsKoOrskTDRMqX3Y0zpVJiQX0DOiCN
         8A22tJzNESQjUsZhv/5B2gf4qAtO5eJrFip/mLZS3MJtSQdvMv0iOiPSHulDJefGIex2
         SXouAmqtkzJSC1ZFoXtOvdNCBqftEKgzMTWcjPLIMbCSZOj0rHfG87RgewMXxmA4/gP2
         ZmDfD7rRoKDT7SuZud5fSxcQtNOLCYQDhYfleIH2EwkufvZQDAfY6G+JBbqIcWjLVrSc
         o6cA==
X-Forwarded-Encrypted: i=1; AJvYcCUFrT249pQZxBnuVykhXExQ6WUrP+0xkPodeZi7Wqgge6+77ZFnktpsCBgoqHOyUBlzu3RbWO6H7F6rMpHFtDUhrjzq2pxRrHudBeFq
X-Gm-Message-State: AOJu0Yy6k5sNOd+gIK/eUUFs/4+1jLf279OjUjxtlwVMO9kdI2MlcTJK
	v00WJ/0vEoNmoQgj4MxfhLhO2PpWkE6OlfgI6EFmkylHbSroz6ZLbCh8PrFYng==
X-Google-Smtp-Source: AGHT+IGaHJ+wZn5VmufMdAwkzCDF3q/3AUjQoHy7CLQdXnVDg+CcsdVfafdasXLMZwLKfSl4MaPkpg==
X-Received: by 2002:a17:903:40d2:b0:1e4:33a6:b0d4 with SMTP id d9443c01a7336-1ef5e8d77d5mr720365ad.9.1715309960592;
        Thu, 09 May 2024 19:59:20 -0700 (PDT)
Received: from [2620:0:1008:15:3671:ce3b:3311:fcd2] ([2620:0:1008:15:3671:ce3b:3311:fcd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c039f29sm21969055ad.219.2024.05.09.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:59:19 -0700 (PDT)
Date: Thu, 9 May 2024 19:59:19 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
cc: Roman Gushchin <roman.gushchin@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
    Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, gthelen@google.coma, 
    Chris Li <chriscli@google.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
In-Reply-To: <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
Message-ID: <edff9a60-a77f-bc6c-3d07-4f96a97f1e38@google.com>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev> <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 May 2024, Shakeel Butt wrote:

> Hi Roman,
> 
> A very timely and important topic and we should definitely talk about it
> during LSFMM as well. I have been thinking about this problem for quite
> sometime and I am getting more and more convinced that we should aim to
> completely deprecate memcg-v1.
> 

I think this would be a very worthwhile discussion at LSF/MM, I'm not sure 
if it would be too late for someone to make a formal proposal for it to be 
included in the schedule.  Michal would know if there is a opportunity.

I say that in light of 
https://lore.kernel.org/bpf/ZjL5b-zipMrV2JSg@archie.me/T/#mb6c21b09543c434dd85e718a8ecf5ca6485e6d07 
as well for the whole cgroup v1 -> v2 transition.

Chris, now cc'd, would know best about all of the dependencies that Google 
has for memcg specifically.

> More specifically:
> 
> 1. What are the memcg-v1 features which have no alternative in memcg-v2
> and are blocker for memcg-v1 users? (setting aside the cgroup v2
> structual restrictions)
> 
> 2. What are unused memcg-v1 features which we should start deprecating?
> 
> IMO we should systematically start deprecating memcg-v1 features and
> start unblocking the users stuck on memcg-v1.
> 
> Now regarding the proposal in this series, I think it can be a first
> step but should not give an impression that we are done. The only
> concern I have is the potential of "out of sight, out of mind" situation
> with this change but if we keep the momentum of deprecation of memcg-v1
> it should be fine.
> 
> I have CCed Greg and David from Google to get their opinion on what
> memcg-v1 features are blocker for their memcg-v2 migration and if they
> have concern in deprecation of memcg-v1 features.
> 
> Anyone else still on memcg-v1, please do provide your input.
> 
> thanks,
> Shakeel
> 

