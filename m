Return-Path: <linux-kernel+bounces-281546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3A94D803
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FD11C2257C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFA167DB8;
	Fri,  9 Aug 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ydWGSR+p"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5E15ECD2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235011; cv=none; b=QuRThHay7IxKnFU7P95Sb6vPDJCHJcwv5un1CX+zKTNhZu7Dw3icVFDCuWlky0/svGfKKUZPpK6kXREyYtt8lcREw0GswEcNJEFVvQdMm9lYr17mpHqximvNRlnIxN1X2Z2R4JEtSebjcSvXLVkZTC6FIF3tR5jCVcDS5/v9urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235011; c=relaxed/simple;
	bh=lIE5ff22MqP4XyUhpK02PYr8qqT2gvdFUzR+DgOceQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMy8fItd2g7bynvp9I4+gGqdmZplxGVlgeaDmEqb6465fINV7Jz2AP2ZFPfjTdaneyK6nZoeKAPiN5aFqjwzjtGAN44eqTtf30QQo1AcWdJbS2unOkxFXjXODumxFw/Xzu1PP/cPZGQU06RAYXU4an8ERXdBh8p01lYjSKhetwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ydWGSR+p; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d3e93cceso323867885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723235007; x=1723839807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=we2GavC7rNI44UKDEW6KhQYEaUpZOUZ86BP/aMxAKoo=;
        b=ydWGSR+pZfgSVCgT9sX1gSuweybmzvrIkDS2kfH2fZyqphT4IgJDXoH9kj3ORi4xkJ
         /Q5+UcxK5V8qBr98bTVK9nTVcjg85OZtBxdID1rzwXGscdeo3+dbgUnqelCsPjn+xmOK
         XVvC8+frxNzB5O9pb4BIlH+uV8B79YbczN7f08tNIVxsS7c8I/vYvYDu68GPBzHRcs3F
         wPL2/SWSmd5ugECGMuMlbb67d6zZsl4od3bn2JMjWvlMPGHQTUUAsVcbwu6S4Rv7F406
         gWLpO0hb6tu3kK4nybznHo9MUlzOfcJzO5T7r0M/AQ6uRt/puWaEfV9bcOr8VqTZb2Y9
         kNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723235007; x=1723839807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we2GavC7rNI44UKDEW6KhQYEaUpZOUZ86BP/aMxAKoo=;
        b=bMtYVs+idXs/aNc6O3anMYwKXrH6AkGZrjB348oAScYwhpUw3FzvY8sZFOUz9AaoVk
         72rysb3B4y0EdookjqH7FA2/DIF/isNsr6Bb4pmeMQGEer9gfOAHkQQL/ofC33ZA951s
         vxSa7j18HziHmS3bcyTzolLh7dGBo3JHrHT0v/YN3Jj467b0qYjG2DnW9xZ+nj8UPnf1
         NYbAYUIbKSM+TQwPO1Fsc8WzC0fiQEy1SrHQ7FLQyvsxTy8sCOblnifvdNSG4r0NKNMc
         oU7YMEXSrzKuPsU5ce58T1pjcVGsdM6S5IcCNBAYCzZ4ZmP0ZAWXP+gG6T+4c7lE3NEG
         qRqA==
X-Forwarded-Encrypted: i=1; AJvYcCVVTlLK5ut1QH+fgX5AzLDoRVbBmMqKQfjTuSrgTzPj5ZewW5zHTeNqag572DWcZ+A3b8Pan6UKjflrhdARpKf1K2WkCvmI3VTEuu4X
X-Gm-Message-State: AOJu0Yy297xJJPuL8nKO0JgIjCy4FxaUpVd5WLmOA1BxD9GBdiGCu3mL
	cEw3T1DZVNpZ5nUYBFuHXkAwXLXxHXq0oRwAfFYDrzzFrDoRwdrhDH0jO/+Xv8Q=
X-Google-Smtp-Source: AGHT+IFIRlZVxggSsHYBTjzZ+CPJpwP2DBNOyJSNbJYQmLhE01Uni3G8BOfXEXzW+0TAfN0yl3oflw==
X-Received: by 2002:a05:6214:242f:b0:6b7:9a0a:33db with SMTP id 6a1803df08f44-6bd6cb5ce28mr111108136d6.23.1723235006839;
        Fri, 09 Aug 2024 13:23:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e53a83sm1230186d6.118.2024.08.09.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:23:26 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:23:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
Message-ID: <20240809202325.GA2157603@cmpxchg.org>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>

On Fri, Aug 09, 2024 at 10:26:18AM -0700, Shakeel Butt wrote:
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

