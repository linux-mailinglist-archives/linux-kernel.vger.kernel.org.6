Return-Path: <linux-kernel+bounces-285382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38E950CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEC81C23135
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521641A3BC4;
	Tue, 13 Aug 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFAXOIeX"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DD1097B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575916; cv=none; b=u3zMa62g+BRVDGsGRziKj5HjoEdXYGoxOpsqWlB2TV19RXAvoD2XcEhS4QKa/deEGNes4aGjdaIwHei7Vz8X9Xxm/OaJDcq2v6UbqG/ekQ9mLrxiX2dxWrIIxQp5s3jApCLpVTAGx9LwF/fRO9ywoXi0J/Bo6hi4IgmPLpF0F7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575916; c=relaxed/simple;
	bh=TtfqwXjw9BgIiUsKhH5F3ukd2kLXdHS5cJHIseXHiB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiZrvrYOqoTp2IQ8rsiFA5dbZNBiMkWqAbjNOIIPFTsCkxPjWmLFG8Cp5v3872nfplI/yxCtJQ81SJ+r551HqWIcVwIa6hgjipWd13rG2TZB2raScwAd91f1GaQK0blZviz/RxyLWQHsYhHi7YynYvhB3Itd+eHtfrdfhJuZJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFAXOIeX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7106cf5771bso4488961b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575914; x=1724180714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgNiWB9SZDb9nWcMjvgw49W8/t0BTluPKcPvC1tsy5g=;
        b=cFAXOIeX+WNtyJ/KSgWCfa4n4zRGPFxEMiLNoP8L9rRzxCkDq11OQX3cyMgsoYAHDp
         /Pb+ZGiShytxkyfo+L8W7RpY/AlWD3auMZdyvtPcy2hsoacHmDjZeQc5GHARVq13ihPn
         Z54C0OzNPvfEVdrEfRAPwo4/rzF3FAN+fJLinHStKDyCj/h8KR4HfFJjBKVxjrY+sTWk
         f9Lmv1HQSyQNN9vzdLHaG8fjBgmZwkwjOEk2t0nsjYlXKQEwUpXqK7KZumZKftHVtIt1
         4eRFzOx3T7dfncIWtpfJyue/baSMvjsLVdBKAFpr56J0Gl2j8JNIKupeSV5ysCzciSV6
         1FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575914; x=1724180714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgNiWB9SZDb9nWcMjvgw49W8/t0BTluPKcPvC1tsy5g=;
        b=lxcTcsFHTV6/tesdE65adhIT871nl/A0gG8MOvgFmzHRqlbahcJE/xd2kdvoTajnU+
         B9rhvfhpaGn7jG68jdc68qkgD7xUb7ObGCA7wRlSPfG0guYz7MBg65FWEzgB7pvFum+f
         2+/ZEpPKWJkEDnbrglTpVRG65EmfS+GfQaEY9PiO8aIJVlPc2vBPVq5HYRmBwDmqsAH/
         vXqN1/J0uC553hZnXtV+7eiLR5gWeSUjWHI90RH1+jTACOTEgK/Q/6EwqBy0SYswfXm5
         BisZdIuFqcVaipsXlMl4mxMyNsl50nKpVs24NaiK2HUmzpve2nZgEOS9BI2sGo61vsCa
         oLcg==
X-Forwarded-Encrypted: i=1; AJvYcCWxwDqhfZxUAg3Inn9h2R5Gw/PuFn5tJ3cu8HHQSB3v8tGDDKcwX1ok55sTxYrwTwC9QVw88bswXdpyVwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlYtBYT881v+PLTDN0MWV8ZdFWJ62A0ihWMs03cs1RdBQ5I1Y
	pufSk+7ZgoDhT946zs9tOSFBAUT8N1vSKTm9XGgE+pS6QdeUZfkURAvULw==
X-Google-Smtp-Source: AGHT+IHVJmQ4POGxLOqlgPh7wXbwBSSLemXNHHkVwCeCjKZ4H2kOeZMOjyNqYU/16Nc2hKNUdxKUMg==
X-Received: by 2002:a05:6a00:b42:b0:70d:3438:9689 with SMTP id d2e1a72fcca58-712670f6bb5mr737937b3a.5.1723575914261;
        Tue, 13 Aug 2024 12:05:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89e2esm6261217b3a.173.2024.08.13.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:05:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:05:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	christian.koenig@amd.com, ltuikov89@gmail.com, daniel@ffwll.ch
Subject: Re: [PATCH v3 3/5] workqueue: Add interface for user-defined
 workqueue lockdep map
Message-ID: <ZruuaIPsEH83luku@slm.duckdns.org>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
 <20240809222827.3211998-4-matthew.brost@intel.com>
 <ZruraicqNAvPWGJ1@slm.duckdns.org>
 <ZrusGBG7/EkNlbsk@DUT025-TGLU.fm.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrusGBG7/EkNlbsk@DUT025-TGLU.fm.intel.com>

On Tue, Aug 13, 2024 at 06:55:20PM +0000, Matthew Brost wrote:
> On Tue, Aug 13, 2024 at 08:52:26AM -1000, Tejun Heo wrote:
> > On Fri, Aug 09, 2024 at 03:28:25PM -0700, Matthew Brost wrote:
> > > Add an interface for a user-defined workqueue lockdep map, which is
> > > helpful when multiple workqueues are created for the same purpose. This
> > > also helps avoid leaking lockdep maps on each workqueue creation.
> > > 
> > > v2:
> > >  - Add alloc_workqueue_lockdep_map (Tejun)
> > > v3:
> > >  - Drop __WQ_USER_OWNED_LOCKDEP (Tejun)
> > >  - static inline alloc_ordered_workqueue_lockdep_map (Tejun)
> > > 
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > 1-3 look fine to me. Would applying them to wq/for-6.12 and pulling them
> > from the dri tree work?
> > 
> 
> Yes, I wanted to get this into 6.12 as I believe we are removing
> forceprobe for our driver and it would be good to have this in for that.
> 
> Any idea what this is about though [1]?

It looks like misattribution to me. I'll apply 1-3 to wq/for-6.12.

Thanks.

-- 
tejun

