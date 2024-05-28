Return-Path: <linux-kernel+bounces-193229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39408D28B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF8B1C241DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035113F01A;
	Tue, 28 May 2024 23:24:43 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBE13E040
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938683; cv=none; b=CJhuqluoRAklHPpNsboG2eS6iyjIzJ91hKQQ9fUH1v1dtlvLJC4E56NwLwZdi6xiev/b4juwMySe2EqWMPnajSjFqTGglasE5iiPI6sUhzpucx3Nv4CrbNupYkAw0TIrt8XWLe+jqM2wr2tN+PmmlPYy0JorDkt45iJ/y2j0j6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938683; c=relaxed/simple;
	bh=5iq5t9rPUVGI9/3Dm5+AlILLc82DGElYeHEacD74FyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgiiQ2RgWQe3axS/+7AU5SDHvqBJN4NgL86jv5E385bxaVnIMQ7EHFVSUSRgkjkRIHVlUgl0FI2BWi/sak9Dvk+fa/T6WVX85G2OhaqVU+LRQi42BmxzHw5hMiiKKBYlcdufFHvp5T9gg6FeOW9oXb3MVKAniYyTenM/FupLpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso1103839b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938681; x=1717543481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNErHy54A1kjJTi2uYYepudf7mP7OyiGpa/dOsZhLcs=;
        b=KpDxyGIIqvsiCYyC0CBEq+wlQFWTbf2K072xaBvnLcT+MSjXEV85WENEDYHJG6Ycfu
         9BJCMKj9MKfvBPs7MlglP2375TQDmCu1QknfTcp0zsyDv7gOn4vVm7spEpieuiPaJuNA
         cs9UCJ33n2L7QBk+gkNjJSEEgUkW4VK2cqXjVPrjek3yxoWOY942xxp6nxxFtxTNobnd
         ewm94lu0GTb1oVy3eLt/VlfoRzx0CqWZACgoVL5UUYhAwz1epOYm6bYUj0WN1JFNaqzW
         H7xz/hnIK2rA+wyZOTkOAdDYoQ1s3N1xoIV5Ht72mGuWg8qFcM6Zn+Wn72y/qCrJApUJ
         2JbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH41oSYy79XbixcYELrfaX3+kMzQZq0c/3rF4Xc6ivVXxmZo/O4+vQoVhB+MyYh5pfnwL86JG4jH1Fg8fe3PxIA2WvNQHQIZuIc0/R
X-Gm-Message-State: AOJu0YwBh2wyQ07pBATXV7QK1U5GtQc2uVHRPojEwmsi+JmZJas40oeA
	d1X9NZHHyCWhQuIqfSZjzUjDzhdIib1nqQ+y7fr6WepaJ0CgFjUC
X-Google-Smtp-Source: AGHT+IG5FFGbsYGzfoXVPflYrCi7X/CC27bTaHSjh0eS+aRDNo+4B1hhCpfDR9wLsmoWZvlCEWVHiA==
X-Received: by 2002:a05:6a00:e16:b0:6eb:3d37:ce7a with SMTP id d2e1a72fcca58-6f8f392b718mr13195595b3a.21.1716938681040;
        Tue, 28 May 2024 16:24:41 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822198a705sm8059634a12.36.2024.05.28.16.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:24:40 -0700 (PDT)
Date: Tue, 28 May 2024 16:24:37 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, tj@kernel.org, hughd@google.com,
	vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] percpu_counter: add a cmpxchg-based _add_batch variant
Message-ID: <ZlZntVycT45knbwB@snowbird>
References: <20240528204257.434817-1-mjguzik@gmail.com>
 <ZlZFGmBiBE1VGQIt@snowbird>
 <20240528141929.ba7e59e4cae89eec01631306@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528141929.ba7e59e4cae89eec01631306@linux-foundation.org>

Hi Andrew,

On Tue, May 28, 2024 at 02:19:29PM -0700, Andrew Morton wrote:
> On Tue, 28 May 2024 13:56:58 -0700 Dennis Zhou <dennis@kernel.org> wrote:
> 
> > >  EXPORT_SYMBOL(percpu_counter_add_batch);
> > >  
> > >  /*
> > > -- 
> > > 2.39.2
> > > 
> > 
> > Andrew you picked up the __this_cpu_try_cmpxchg() patches. At this point
> > you might as well pick up this too. The cpumask clean ups are likely
> > going to give me trouble later this week when I rebase so I'll probably
> > have to base my percpuh hotplug branch on your mm-unstable now.
> 
> Well, if it makes more sense to carry these in a different tree, let's
> do that.

Regarding percpu, I've generally care for that allocator and to varying
degrees corresponding libraries for the last 6 years. I usually take
them in [1] if I have other stuff to run.

The cpumask stuff should not roll up through me, and I think likely you.
It's just a little unfortunate in timing as I was planning on respinning
the percpu hotplug stuff this week (not 100% sure anything will conflict
yet til I do it).

Thanks,
Dennis

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git

