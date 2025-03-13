Return-Path: <linux-kernel+bounces-558947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACACA5ED6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF2917B161
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F092260360;
	Thu, 13 Mar 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q8nucKrA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2925F996
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852627; cv=none; b=bg4ETmNh7hpBn0L3wkxjEojRWwdvYSQRYe4Jln4jnptmXzAU5MI7ZQRQ+6PClJyAGTlEwPkBaMrnr8tyfeI2L26KfqgrN5wCOfCxS9Qu7qlShVW2AcOyFuDT73PLH1x5vd7ybK4AguhbwH+MmETi0d3zv/8xMW3YhYLMDrcgVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852627; c=relaxed/simple;
	bh=3EYA2NoG7OwGqv+mU/zP94ltEPZlfgH7UPlLyj/iAO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1KhE9x82WEmqjgMvXShAM55dLs2RH5t/rZFfao/BumUUjOUQD+rJSD6OUw/sj4JDJpcu79f9C3KfAySvmgpo9KQxySnRaWiWKjrYA0AqgVXiFl7zzoieHd1T7JCajPcnMTyXvtdMQYQOMu1od5SfF/uaNXBow6kdeijFQDKa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q8nucKrA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso5252945e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741852623; x=1742457423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwf2i5gHneUYy8bWl7vKw8JV7HZhRd7+rn+CrTrat8o=;
        b=Q8nucKrAVsAXZ2au83ynW9iHzGbKM1/0cfj58f7u9aSJB7wSZOm0hPlVhVGlCurZis
         b4sJOkqc1iuj0ofWWvfLJNDaYUDN2igWMUwSHAttyTRdBSsAsVoIUhlShZVcItH+xUmA
         xDeYDI2zRU9sMCok9mJiGOdupuUCveH1wP1CttoyGR3d17mVj7gL8bOipChD+/dAgw7n
         ABtQu+4FoI5wvtIFjSuyTFKLd39u2jqkzpRk6Qpqr9PY6BvO0YafANYBbkSlCH1jzyy4
         EoNpLl6JN2LOSPT1m2rjPEe9rsgY2/Ay8fURGqz4I8HIMHAzYDqm2/qXl9TZJODfCpJR
         f0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741852623; x=1742457423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwf2i5gHneUYy8bWl7vKw8JV7HZhRd7+rn+CrTrat8o=;
        b=M2KzSnRVGo0IO7N0yulxP3qe4Pq4i5Q/LOUemiKaLv0jtk46L0vXdZsE+x9Xrj0hSo
         LNjKrMiW8vNnun9rFOdygtsZW8TH6HehQejRzvUrysq5exuG1cf3tevJYlS1RHDIcrpF
         h4+L2LaM5a327mFZTvHxsNF8GziTYPtBQRxD2jROZnXyT9gMiuOXCkttUKNO9qFvlnZg
         pkGFubdNge3lYV6mWnVK03pWt35tjNc6WZUnAMesxLnVfoOXzWEoa8Heg77HIdB0MbtR
         UPs68WIbC9f+v5ZPSJ5nr02+HhauDK5+QSpp8OArmdGGDp0msok8T2zUVSxlwx07iJLR
         Updg==
X-Forwarded-Encrypted: i=1; AJvYcCWEb+VNiVr0uKRuEQIPUl1gKYM8Mv/MH3+C194Em+i1iawC2ldmwd/if3PzvPJH3jbqxETMsOpaCvr3NNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpZEY0vtbP+8S2p55GDS+Cv2CL/Em15upnCm6+DKiekgOK/D5
	2MXHlLfeQcqC8wJ0SxApQrdOXuHGlj7Y5cNfnQM/GnYoGPCKYawRcgEaidHTTo0=
X-Gm-Gg: ASbGncvHJvaffioMXWMfkyUTGwnuPvVdl/KI33VT3y1KhGLYIxXNznK8slo0RigKSAd
	mWKB482K+iDf4YIuPy5kfl9LELR928viPkKB/VHvW9zJslXczV8oh5RQlkyonET1J2bDFGOD7fV
	mk3yGkTwp3s5FE14//JG7N+V0DnucwwRbdbHiNNqoYAL4udh8lgLsa1XxgPoDYrqEciOiGoqKXa
	wFrJIQ5JSUDyufJY6qkmStIE6z6m4gITZAgHwb82v5Av8a4hPZW9lnAnur+G2nPMRBrp17teyrc
	AJLxe4aUQW+ODY0qYQK+eNRA/U4LSTL3Lbw4POY1ful47EYNoxBQZPmPGQ==
X-Google-Smtp-Source: AGHT+IHLJfn/7dH4w1ct5Gv9av3VFZjFj36gqLEf4r4KmE6NMqjhdhtPDOy/FoyVFiDUa8E6iS68cA==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr132581815e9.20.1741852622653;
        Thu, 13 Mar 2025 00:57:02 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d188bb81bsm11432315e9.23.2025.03.13.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:57:02 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:57:01 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <Z9KPzQNctY_ALL0D@tiehlicka>
References: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com>

On Thu 13-03-25 11:48:12, Zhongkun He wrote:
> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file folios.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
> 
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
> 
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available. For example, if we find that a certain cgroup has a
> large number of inactive anon folios, we can reclaim only those and skip
> file folios, because with the zram/zswap, the IO tradeoff that
> cache_trim_mode is making doesn't hold - file refaults will cause IO,
> whereas anon decompression will not.
> 
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.

Well, with this patch we have 0 - always swap, 200 - never swap and
anything inbetween behaves more or less arbitrary, right? Not a new
problem with swappiness but would it make more sense to drop all the
heuristics for scanning LRUs and simply use the given swappiness when
doing the pro active reclaim?

-- 
Michal Hocko
SUSE Labs

