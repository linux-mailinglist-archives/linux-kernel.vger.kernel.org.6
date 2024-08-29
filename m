Return-Path: <linux-kernel+bounces-306667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE09641DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4421C21F95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648D19007F;
	Thu, 29 Aug 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VHQLXZNd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC319007E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927040; cv=none; b=hHaidtZnyRs8YTFxEE+TifJ7DKChOXOLc/x3yMV1UDR5N1h0MYsUlUq0X4qOhZiecrAhCQGzd/vDzGJBjc3IQJLrqhFLIkO2Z1AhTSTf7iRN0BvaezjoYsII6JnzJf/qsh7EEnDlYdIleFs7ZHnIt5jgGwyBdSSp4OcPBhc2Pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927040; c=relaxed/simple;
	bh=GrWjMJP0u1Qa6slxrzSDez4NRlE7jWHP1Zjfq2IioTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG4TBoXh2s2K9OfVgXm96B776e8NxK5UVa91F9zNErcYpONInR0YJVqdM7q5cYlxKlR6YSml4gARDIScFZGQcK7IfXavE7N+KHGotYac5/h1I4RKDc/Dq4mu1siXsqg4iZrycn7Xi3ToiDv8UFvxk8qeuTotlWtCV7+nTnuzPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VHQLXZNd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso3526405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724927036; x=1725531836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpM6Nu+nGTdBDOnlln+7hjSWR827MYH0jprVOFPNg7w=;
        b=VHQLXZNdFBFJ2lSpTYE0HCEyo321MAWCK5fVXrn65OI/JrXf7+T0ny50klupC6AFSL
         9ypkGfggB6oSn+hURnsQjvJlhQG8p/5X0cHi27ouFVKpwY7z3ghewgKhDiq4w1hkebKg
         HDFnaJZAaLKTlWAyS/6Ll0MDSqAnWBnDs6OQ/ZFPqnmaNLte4Ql8NNGqNT4/cL+/C9Sp
         YZsbDOTDNx2Q5GbwHccEOS2vYnrib2BUBruLE0DDcwk130JAWYivgyl7mn9x2HR+jYBC
         +nlFRUeitfID0vhsnI1IYbXbxRW2lmnP34xEGHiciL2Ubje5MLw5eInqTh0fTP6we2HU
         yy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927036; x=1725531836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpM6Nu+nGTdBDOnlln+7hjSWR827MYH0jprVOFPNg7w=;
        b=Kxp1JwCaZBdNs1dnZqU5kDH+z7IfLnmA3bK9BeXY2QHQW8HUFzWINYtfA5+YWXju2z
         8r2LgpQfpbNz20EwtG+NaGpagonmMparKGLpVkauCUETDmtdJ7jw5+I/tjVP2JrmGscl
         nIEVCZO2UzhSOpLaHCjkN/FYvRTrq1Aq1d520RjeKzvyHHnWhkB1TVDXJCUZzV8s20Ht
         S1D1voApPAzEoHn/oxHKoktDludAHpiYwZMEv5Vq20h+zACAuO1k6+/5bbAlNNkS6aWW
         Mm2qxl8YUBeAoO+VGy9KWLecO0dwjIAMSHA/4rz3nAuyXYLmBMAisIZQNRWVjBt3gLwZ
         oKPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2cvwZ1uGFWmwUTtY4XAeEA7Ns9nwyuJZITj9VvW49CDGgw7GKcFYU3miOzgmTcS9GrB7l6uiZQIOmqEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyflkUjoH+Vlv+2FR3U4WbS8uu0gIXv7A4WD06+MLjEOC7+fu
	/gtr1x5wpWV+2b8vVcSaZaXL+PPy1KC3RfpjBPmw3R7g2L7Qua1DkLbpTaKiXmw=
X-Google-Smtp-Source: AGHT+IEdDHd3BL09vforgTUgQS7bf4tn7UQrs3kUPM7WXz9LrzDjlxo2BxV8RIwgmi0hvVyJFs4B7Q==
X-Received: by 2002:a05:600c:45d4:b0:428:36e:be59 with SMTP id 5b1f17b1804b1-42bb01b4453mr17782455e9.11.1724927036327;
        Thu, 29 Aug 2024 03:23:56 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e09esm1022710f8f.86.2024.08.29.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:23:56 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:23:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	lizefan.x@bytedance.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add disable_unmap_file arg to memory.reclaim
Message-ID: <ZtBMO1owCU3XmagV@tiehlicka>
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>

On Thu 29-08-24 18:19:16, Zhongkun He wrote:
> This patch proposes augmenting the memory.reclaim interface with a
> disable_unmap_file argument that will skip the mapped pages in
> that reclaim attempt.
> 
> For example:
> 
> echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim
> 
> will perform reclaim on the test cgroup with no mapped file page.
> 
> The memory.reclaim is a useful interface. We can carry out proactive
> memory reclaim in the user space, which can increase the utilization
> rate of memory. 
> 
> In the actual usage scenarios, we found that when there are sufficient
> anonymous pages, mapped file pages with a relatively small proportion
> would still be reclaimed. This is likely to cause an increase in
> refaults and an increase in task delay, because mapped file pages
> usually include important executable codes, data, and shared libraries,
> etc. According to the verified situation, if we can skip this part of
> the memory, the task delay will be reduced.

Do you have examples of workloads where this is demonstrably helps and
cannot be tuned via swappiness?
-- 
Michal Hocko
SUSE Labs

