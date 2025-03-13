Return-Path: <linux-kernel+bounces-559819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6BCA5FA38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE481882BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904A269D0D;
	Thu, 13 Mar 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HLiOYxiE"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8A26989D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880359; cv=none; b=Y8I0ia1ZSArvrylhtJpgNzBKeHkYPZL67P6R6X1pMkegoBa4EsL5g5isHWMVzUq5XbLQ/c5Xnz/UxSaQlLrOyfd4Zsn1N1c8CecKSCAWqLpV/2sEiv8oj2yDUrrCXfRGzprH5vyQ5qct2dbBkkvtSgatcUP5AIOe4G/1GPvjKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880359; c=relaxed/simple;
	bh=AR08GzHkg4EOEhm5hqQkERNAecmAfz4v0HsYwbyhxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjQUuxtTEDS+cd/EjcHTEfkc/1mZS6nWhCDgyOR4dqCewCBq3JhPymeUJ/rhSzzwQPmQlINSWBsinUiwCm+q745ThTyccqz7/FXRs88zvt7b8VChhR5RoBn3ubQj+Jni11jtBaUzpaFrrxwi1D/KRghqGK+43Gb8c8+pww255Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HLiOYxiE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c560c55bc1so107447785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741880355; x=1742485155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOmUK0wijuW6dxDYXHnP7n0DJ9/LVG75PLhj+DBDca0=;
        b=HLiOYxiEJhBTGVn0ZG/7cENuniguCrLozlad0dnFx//60Vy5N4mFoIw2u1CaRc4lz9
         hn7VlOqkvr6a6/XjUDJsrGf3HOqoKZoeQjq1opakugmUBO2C9Evw3IyT/OgUKfciZqT6
         XxvkZsMsNxd8VxJxlXjB0KVE/OuismGz/FO/Au+lmjm4uso1h9d+vfbWTsC4u3lbfslM
         wYxIfTF8yxK6VqwPjUWc4E29UKHjjEcNZh2g3snSl6pqQHZtj9uU9TlImUpuviBRksOi
         Lou9vgdG671zTjdSb8AOvrR3BLC2p1JoOActdAyMl+JeYqIi0LJTK/rkdVtqJ3Sun959
         vDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880355; x=1742485155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOmUK0wijuW6dxDYXHnP7n0DJ9/LVG75PLhj+DBDca0=;
        b=S3YXj2xEkfHoJ9SvQa9YTH0ayKjiHU6nwczj9Yr+u92MxVl915Y/xGf6vmLDY9jDnG
         0uaUXNJO6Zy9e/OzGrRoZFy1MZgX2q5ou+aU2nzcPr1p5zH1mOq73t+pKA9S5hmNxHBx
         4sFOKLfqpLpKr+uI1RLvgQd0glkyjbKUvipu1pEeNoVB8HrGAQLMxN/jzh6zBasAloQY
         yiNDbrb11KpIwwAf4EnbipANa5HrOYILevReLuBGjFhJN253QAq5VXZ2Fv6iy59fEFMQ
         7Fa3/eGASFbqTd0ZZiSd/dr9qB6JFR4MBfQE46uBj4LMdXal01Mvx2OPcL253ZuyVzDc
         Ymsg==
X-Forwarded-Encrypted: i=1; AJvYcCWmU7pHPVdvxs5JCPyRP+GwNDd2HXrjieq6/jD5AF8Gq0sNoQERipwPrp3nbWsXdPyA+mRHA3Rhxe0BDXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8El/w6zcRoLYhfXS0U5XY9mFyoJd7WGw3ftZ/bRGXtR1fQc+J
	R0RRjrFJhgHUUEZE4TBWBJwaqOoCxC6kEzirksOuvjzij27aIYJOrEDvBC4yYuI=
X-Gm-Gg: ASbGncubpp9RgeMePoeIXyDkmot72pB3BLtEa/MUX0Sq4ak3YLx4cGRICsLJ5qF0f/t
	AQ4ItHylQ9nQAbd5oL6alGf793Dj+fIFQRTsNzTk1x2tJHw5492RmrZebH7S/T8UcPGwi0QNFfU
	8w7GEk2Ir1W2Hm4/v6CRdL26GDXbchusm4/jJxBQEYReYLu+RGcPjob31eTV0lUbfXZtfgMpPJe
	BH2V3lVJkuSRFJCYN6oxUt6dnVOtVbEgzz26UXrIh+2NtS09/e0iv+3SiA1K95z72i9Vcat8e/X
	HHaJpoHKJHL0fX6T/nEN6APNOCt+coXHWPV+xI3APMw=
X-Google-Smtp-Source: AGHT+IEiYv06z0yUVO5Elmd+9XLszQ3RCIp0amxxCA0d7ujTwAY295Ym5fJosAtLaTmWL2hWKTZtMw==
X-Received: by 2002:ae9:e014:0:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7c55e85c500mr1443206085a.19.1741880355445;
        Thu, 13 Mar 2025 08:39:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d89ad6sm110209985a.102.2025.03.13.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:39:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:39:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: avoid refill_stock for root memcg
Message-ID: <20250313153910.GA1252169@cmpxchg.org>
References: <20250313054812.2185900-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313054812.2185900-1-shakeel.butt@linux.dev>

On Wed, Mar 12, 2025 at 10:48:12PM -0700, Shakeel Butt wrote:
> We never charge the page counters of root memcg, so there is no need to
> put root memcg in the memcg stock. At the moment, refill_stock() can be
> called from try_charge_memcg(), obj_cgroup_uncharge_pages() and
> mem_cgroup_uncharge_skmem().
> 
> The try_charge_memcg() and mem_cgroup_uncharge_skmem() are never called
> with root memcg, so those are fine. However obj_cgroup_uncharge_pages()
> can potentially call refill_stock() with root memcg if the objcg object
> has been reparented over to the root memcg. Let's just avoid
> refill_stock() from obj_cgroup_uncharge_pages() for root memcg.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

