Return-Path: <linux-kernel+bounces-380678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFC9AF470
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1468B28120C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C724921D187;
	Thu, 24 Oct 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="asyKr1Qd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC17218302
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804109; cv=none; b=dhrnieJAYtAfisgKFd2qYiKfe0yCFHR/n1iItvP3/hfrNnEshmwLGr02XAI+ety/q5Bf2dZZ6aLGf8Z2Zv5jKMFGRFlwoWLvw3nWuoWHWbw8hTvUdNqmIIglL+d5/r6ni4ojyulirJZTpnFZ1cukQ73IZrlJuQwqV1v3RZCctGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804109; c=relaxed/simple;
	bh=vVmZCw1sII2JvAbtHtly8a9N6Qwt9QMxp8VcML928yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8irOutnbsOdEdpugpgs7M0uxoEs6XIzKaUzhlVzvSzcjP9Hg3BhZtGdBaRvjf4Ks6TeCUxtvxbIRI3Sj6eVPTV8WeDCguUhmCtOFOvVNd6ATWEErknn3NzLIrJCdHxod/8W+D54mv5Q7QrbcDQ4PNlDTFQiIEuC3uTGCRc3X68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=asyKr1Qd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso14085745e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729804105; x=1730408905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4n63Mb1tGM1IatUclRz9ifPt5Kd2Kg/qSEOCtMtI4c=;
        b=asyKr1QdIIAf6F83no2illp6O+3fG0sr+8gw7m+EmLBFKumBku+i9rHC5FcQ23p8Qy
         nm+uHkC1SoXgrhLfN9rpOBmT1YVuQkq3QXkLTErvofvi01qUVR8BS13HDxJxXShpVTtX
         pPfttg0BqinV89kdyHzUQUYdOQ0hiW6lTF6lBCizfrw4iWvWTVlQXxfpx/96i8jbXZC/
         2+RqMe8CPXdfAIx/BUqmSEbwiMOKj+fuzC32IzUGk9DQEpwz7HSEJkgGkwXjfappyb6I
         VULkEyLw7Kdo0n6kDA9rYyXuxbc1I+TUVX4aKCM8ywNFpCcOkEtUIZ6imvSCEwXg8pRH
         hljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804105; x=1730408905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4n63Mb1tGM1IatUclRz9ifPt5Kd2Kg/qSEOCtMtI4c=;
        b=IeE0cK2f/UkSRJTo7JHkijJJ2s4KNgjeGdygO5WcjqXS43bQ4DCX/4cATjY/I9F7Bl
         9WW9qO6yah2kVQUH6LzP/i3o4E/GURE7wDkwkfs8aETZ7H2m6FMDVQGSde4JW42roxWb
         AAaMAlyOL/Q2AHXo0NGFlcRLw+dm8wnUp8UdIkTx3keINjrrbcG4jn0hX1I+i4G3Dqal
         DXjlppkWai8cf7LBV4sVp8VxM3hT4HSU1IHuDbnOFN07ccAdnZMszRiWWChH9W8djkHn
         2pOkgBdKP3h8Yf9/NKawFN5+EYS08RnSkSgSvp4nFIun8uzPCnO7Chax2ckWqHpWKJpq
         Rmfw==
X-Forwarded-Encrypted: i=1; AJvYcCViacu9ONKf8wEzZ3n7eKM/LUCsQOciQGSnVt8NeQ8MRSEVE2WNpWXw/IMx05oASyjIqv3yNE32mmlVHBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzngvu9Dpv7GWrhIR7gEw/lKBJg6NHqzJN5hF56XQ0rUV02AxhM
	qh7zIQR/nS4Z8Cq8qpi2MBp+E66XKU4nmlzlW8EetQCeiTFFBRAq5ndVGEMXmPo=
X-Google-Smtp-Source: AGHT+IGkLoUtU7fDoIxQFhiZArRp3INvQyAVYG/gF7NuR8gQG3bPft4cqk+7+GiGG1Y8PqFuf8HOsA==
X-Received: by 2002:a05:600c:46c4:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-43184224094mr66088935e9.21.1729804104987;
        Thu, 24 Oct 2024 14:08:24 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b384sm12112309f8f.57.2024.10.24.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:08:24 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:08:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <Zxq3R25YoRO9m7yT@tiehlicka>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <Zxp63b9WlI4sTwWk@google.com>
 <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg>
 <Zxqj7hw6Q6ak8aJf@tiehlicka>
 <CAJD7tkYsCev299G=h2r_e6i34+ccdXJYphv-bQbROqOd7Lr1Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYsCev299G=h2r_e6i34+ccdXJYphv-bQbROqOd7Lr1Uw@mail.gmail.com>

On Thu 24-10-24 13:32:53, Yosry Ahmed wrote:
> On Thu, Oct 24, 2024 at 12:45 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 24-10-24 10:26:15, Shakeel Butt wrote:
> > > On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> > > > On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > > > > The memcg v1's charge move feature has been deprecated. There is no need
> > > > > to have any locking or protection against the moving charge. Let's
> > > > > proceed to remove all the locking code related to charge moving.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >
> > > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > >
> > > Thanks Roman for the review. Based on Michal's question, I am planning
> > > to keep the RCU locking in the next version of this patch and folowup
> > > with clear understanding where we really need RCU and where we don't.
> >
> > I think it would be safer and easier to review if we drop each RCU
> > separately or in smaller batches.
> 
> FWIW if we go with this route, I agree with Roman's idea about
> replacing folio_memcg_lock()/unlock()
> with an explicit rcu_read_lock()/rcu_read_unlock(), and then having
> separate patches/series that remove the RCU annotations. If done in a
> separate series, we should comment the explicit RCU calls
> appropriately to reflect the fact that they should mostly be removed
> (or at least re-evaluated).

Agreed!

-- 
Michal Hocko
SUSE Labs

