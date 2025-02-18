Return-Path: <linux-kernel+bounces-520597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37650A3ABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C4F3AC475
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BC1D934B;
	Tue, 18 Feb 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANuAXFyd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E21BD4E5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918781; cv=none; b=oVZAWcYRF+hnGObRSPWzb/Xbi+YUPUwMmQw9/Ljroq4/IZ042N+Gdafq5MdzSgRUlmrhKE6cwEPBV+rP/bNKk8VXg6OuVQLi869v8KPuQLGCXnJfpWNmswGda8TVuJG0SyYmXsBwFo4V7SBmAnA4lkEQhmvOltxN65k3YKiaVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918781; c=relaxed/simple;
	bh=y1fqN5GbYRykCGi1zwcfHTkU/ZfRpFRIPo+3x+cnynk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUKiJFlWgccRkKjMg4Cn2D+7QIWc9bipq2N6ZEcQlgrEJi/g1tbMLbUkXX9AkVvHqtsYT11OIGtRxH7EVif6DBkdfiQTttvx14i4n1H7KpaRruyI3orKOL1qLCnyxQG8X/Tx6dD+ZOu5jXRnZLOxge6aLLIPChrzYlBYggqzfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANuAXFyd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739918778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZQ+x7hOq3PQQbEiSyLtN+TOyYxHPYGDMm2XpmalGJM=;
	b=ANuAXFyd3/6QpsTWGPykMR75iEIiGETyr45ufSYA0gSgARz6kZASAhvXg7AIuiGYFwDprS
	GoHPDr+T1+R9KVjuoKdpY0LMb5RWu+tFHgXjxAWvemicvncofiQtirVoYra4jCiWlZKF/d
	n1iddgPDoN+9pCj7YyQnOIGb2rQXrkE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-YIy0jK6sNYi-irDyI0sF7A-1; Tue, 18 Feb 2025 17:46:15 -0500
X-MC-Unique: YIy0jK6sNYi-irDyI0sF7A-1
X-Mimecast-MFC-AGG-ID: YIy0jK6sNYi-irDyI0sF7A_1739918774
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0834ace1dso1068582885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918774; x=1740523574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZQ+x7hOq3PQQbEiSyLtN+TOyYxHPYGDMm2XpmalGJM=;
        b=n9ssarmteHi2X4R/iL275Uhr9m3gwywGx1zUZb0gmysGpBtKO3GqHQX9d+SUn3euw1
         As4FVr9zRfSUjPnf6aqTmqBHvZAbB15aB2+XWLtgXBodcsn+adzwyewXiE8LipMHRE4W
         Du5TBjrCfbqbXToiZQ6oHNzBtORwSHxbbg0WHfFRgA5jkbQ1pkd+ohVwdbZInrtNDOOx
         GtP+gvneJk/BQ87MrJFiXL1jMEiYgaZWlhjfw+PTQ17IFe0W87judO7dv79oIdexS01J
         4e+bSr4j4DtTYR6KRmEOI82jKzpWO8aBu4RHvLqxPKUzoz5GiWiD7x8NN5DoIL6R0N20
         MV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxFb5petaiu1pggUAj/j3tfgRKiq7Gjoh/efEGFGcYlF2YXtFNRNbxFy4dLQEq9Mxwo+gfTg9B7pnDt2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOn6AHZM6oOm1q2l2lX1gxZ96cw/k5Hk4skvgq7JuDKdtx5Nin
	V3lUoyZbz9MTivUqJ7OGQP2tSNWvVaUkoP1nU/a7OXD690YKet3dRh65WlHcAqypxCtfOMXvfLb
	fahKi5HAxT5oUKM3H+IWM/b7OxNYGdnma2OR1Eo9ZTH6+m5dxblyYpnAdcZDHpQ==
X-Gm-Gg: ASbGncsonD7B6fvW/TZQ1S2vDr9zhJ4l0qcOR+WIDl/BHhKk5s9Wxa57ZUj1nmGUaZF
	LvK1Npkdn7odbCXQqKGSMjCF5DqWLsrXZsM/w2Xfp3G3UQeHrhbPkcM3+CHE03sA8Rpaqmznb6i
	XESNIchQF0Q3iK0VEgv+o09ECrRtktjp94Z0Jr2/srtMFIliw8bE2aarc5/d8vzfMQSfkmG3fpx
	llTkQgN9jEXXqCv+TduThVB5LteQF/eGkEwD9d3TK1RdWQzDW3oxeFc0lA=
X-Received: by 2002:a05:620a:2989:b0:7c0:5fff:210a with SMTP id af79cd13be357-7c08a9aaa8dmr2285348485a.23.1739918774553;
        Tue, 18 Feb 2025 14:46:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9aYa7xb0jSy10KYfjbvxeGabOuqZLuvs7LaEOm/AXuBMyqdCDraAKcVyHKcDCqvuv8zIW6g==
X-Received: by 2002:a05:620a:2989:b0:7c0:5fff:210a with SMTP id af79cd13be357-7c08a9aaa8dmr2285346185a.23.1739918774251;
        Tue, 18 Feb 2025 14:46:14 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e660f65c5csm62704546d6.117.2025.02.18.14.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:46:13 -0800 (PST)
Date: Tue, 18 Feb 2025 17:46:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH v2 4/6] vfio/type1: Use consistent types for page counts
Message-ID: <Z7UNsiRfdOWfZWuq@x1.local>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-5-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218222209.1382449-5-alex.williamson@redhat.com>

On Tue, Feb 18, 2025 at 03:22:04PM -0700, Alex Williamson wrote:
> Page count should more consistently be an unsigned long when passed as
> an argument while functions returning a number of pages should use a
> signed long to allow for -errno.
> 
> vaddr_get_pfns() can therefore be upgraded to return long, though in
> practice it's currently limited by the batch capacity.  In fact, the
> batch indexes are noted to never hold negative values, so while it
> doesn't make sense to bloat the structure with unsigned longs in this
> case, it does make sense to specify these as unsigned.
> 
> No change in behavior expected.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


