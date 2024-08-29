Return-Path: <linux-kernel+bounces-307013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B59646EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2222AB27BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF91AAE1E;
	Thu, 29 Aug 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4r6pdKj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8D1A7AF3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938588; cv=none; b=WFUKtXV15Omj7yFAw73+lOmmW262VRlsDpcleJRSRsOtknbK16srVVP9WbwRXOUDJS2VMEN7XVWpbQ2pBglVfuBKICvUOXAfk9Bp7axRQQpqme1Q4zOex+fLhR8E+HO1aTDuPQhOe2Rc79Vwm+a5zjxHeC/lOcnB1BThi9aC5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938588; c=relaxed/simple;
	bh=ZeMJUIxFKueAM+1gPkeqgvS13tV5orxhIMCtghsgqXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5MnF7CpfMtndFTJDZvgR+GGTdnBRoCWUn4CoV+ZPEsrheT1h/Fl82SohSZyvUCW8PzOcd7APRLiKfxdLsoXKeY7ZoSz7ns3NIIDatuSthVX2SVIHDEyKz1feN13wIgP34tX7ViPdvXr/TLXbZL9wt8NolqLE2Q2c/3sVeWCGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4r6pdKj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso6304305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724938583; x=1725543383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wwzrWSl4QmNb//4oM3ybSBFzbuQXvWdfQdlCdZCtaZA=;
        b=e4r6pdKjPdGe/L+u3mt/ch9JZVadpiKCr2uAcj/fdYoqvTbA3v4x9eo6O+jKThkFeO
         D+/kHToYGF7f750MuLbYE20fFAYP0CBDf7XQZCtHQuXimtqOQpI6flSMSSG27u+uAfWy
         KK2VshhkUnYrY64rT9mRt84kPSCFbMJokBldEPRQnpt9Pi3Jwm9pr6TIjtIyPWqufobe
         96+PYKAcb1LJMrUOOBBuamw9ufKX++u5U6Ff2Cm+Pgnb50CEaKMMKlsivtmV0PKQVDY+
         t2+MztI9c9+KTVhdMboBXEg0SKpIjGKpSN1I8yPzzDG1wF3wYMufroW2HzdMyGisT6b5
         O6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938583; x=1725543383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwzrWSl4QmNb//4oM3ybSBFzbuQXvWdfQdlCdZCtaZA=;
        b=hDJlurs6kS18lr50uorfSfJr9FBCYfwcI2WRGYL3+81tvgUBu7c1ARpx0mRl0vf2Cj
         S5hoJKGkrsk7GfutfQu9e7GZNEXHAb9Z9UPcz7oucMzQaoczyGA/xYnyf9nEHVNE4q/Y
         Dsad+QQTxaBD/4NuJVaZGMJ5anyvqF9WNXRD3ra7v6jjw98rE2nYMr5V4StSm0iAqsOG
         3H98BeH5fnJDxeZ8vUGrCXfPGnEWD2B5N8PmEXN3WwWGHJc3+MbSmjc6t0FyXXcb80sU
         trsbnrWxpqIHq8dNXhYrwVF0LQfVJ86wUxhuKi9PKZ0i8UrMQyCMgUuim392vQ1NgutZ
         UuoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeYiw072ubrr0rHo1S1N+soz+Kiy3Q7egidFYjDECR0+DWBoFf4/tqIBnaCIHNMaZSYpQEbjVz4ECGTmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5KvG1ToeulyZVyh+1ZlZD88SIBm/LCjnF11R9MlOqx2FGoAh
	MFDfrdcf6T8d8DF40bkmnrVZL38QeKd/3QT1tzfB4Go2IPJg1KGe1dhVT+IBmv8=
X-Google-Smtp-Source: AGHT+IF2hWzIo4nvH7VaruPdmF/MnzuPCFARU8YeDyU0mXMLL5O5B66d3cJOBON82KFLLD/if11uUg==
X-Received: by 2002:a05:600c:4594:b0:426:6d1a:d497 with SMTP id 5b1f17b1804b1-42bb01b993amr23949655e9.12.1724938583239;
        Thu, 29 Aug 2024 06:36:23 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb9593c32sm4208105e9.48.2024.08.29.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:36:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:36:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	lizefan.x@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to
 memory.reclaim
Message-ID: <ZtB5Vn69L27oodEq@tiehlicka>
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
 <ZtBMO1owCU3XmagV@tiehlicka>
 <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
 <ZtBglyqZz_uGDnOS@tiehlicka>
 <CACSyD1NWVe9gjo15xsPnh-JUEsacawf47uoiu439tRO7K+ov5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1NWVe9gjo15xsPnh-JUEsacawf47uoiu439tRO7K+ov5g@mail.gmail.com>

On Thu 29-08-24 21:15:50, Zhongkun He wrote:
> On Thu, Aug 29, 2024 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Is this some artificial workload or something real world?
> >
> 
> This is an artificial workload to show the detail of this case more
> easily. But we have encountered this problem on our servers.

This is always good to mention in the changelog. If you can observe this
in real workloads it is good to get numbers from those because
artificial workloads tend to overshoot the underlying problem and we can
potentially miss the practical contributors to the problem.

Seeing this my main question is whether we should focus on swappiness
behavior more than adding a very strange and very targetted reclaim
mode. After all we have a mapped memory and executables protection in
place. So in the end this is more about balance between anon vs. file
LRUs.

> If the performance of the disk is poor, like HDD, the situation will
> become even worse.

Doesn't that impact swapin/out as well? Or do you happen to have a
faster storage for the swap?

> The delay of the task becomes more serious because reading data will
> be slower.  Hot pages will thrash repeatedly between the memory and
> the disk. 

Doesn't refault stats and IO cost aspect of the reclaim when balancing
LRUs dealing with this situation already? Why it doesn't work in your
case? Have you tried to investigate that?
-- 
Michal Hocko
SUSE Labs

