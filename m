Return-Path: <linux-kernel+bounces-277805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391E94A6B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE30228585C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA271E3CA6;
	Wed,  7 Aug 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="T71WI5jz"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D801C579A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028997; cv=none; b=PXjarCxM+qKQsszTkV9dyixcMEmRMM6v9V+DWCHYHrgP27vH2WHvOlisRA2z5dToVsv5UI7hJOTKklXQ3iubDH05XlOY6i60yzcA20g/PaTFMEbmcQjQcKNLY2VnCt9e37b/GmfVXT0ZA9IqJu7mRwvcXXMys+Us2QYFuXsO36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028997; c=relaxed/simple;
	bh=JlJ7cxsqjhip96//XmwsY/m33RLGtbcFb8XvROc3Yzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjJjIjVbSIzAID/0A3XwEtuQPVRW5R8Al/+VfjKk3wGFWLCCKYIupQh4IYKlql4DTYAfbG93Jj5evmbRKoQPNBG8ZdOiBZfLWOTerEqhZLkL9lzR/+PxvyH0P7t3pNPrkx8GiquAafn/l0QMBvSAuEllTq3hBzWZS+2oWkt4lWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=T71WI5jz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d81dc0beso86141785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723028993; x=1723633793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fY7kcjju6totcRCO0TNFjl+wPiujlR010gr+hx+b76E=;
        b=T71WI5jzr9G4JvtrKnBz4QTxwsanZbthEVmF3zhWyxWM5yeCGoMkupkIruW04vnSoy
         YbIEM+PglV3SQvoBnQzqe0aerFeIpf8cCRZSSHjEe5THqAh8Dc72bGKDKz980jdCH2YK
         vQ7Ev4JdWBNJ6KVoEE6tBEWgCfHJmBuUyH+Xqv9apYSNhNy5ANsjhiIusQ1Gy3/lDLYF
         QN7OLTAK5IR96TMJ6KdI5rCaPOrLCtNK2ZlSzA+FLyUYnegTCsONdSYd0idx5JnC5irx
         OHBQ34BDarnkyjVmUzej4wHVL3e9YPnEDM3ajTsChj/Su1Y6nuu4Vdzeug3vjyDB+BUZ
         lNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723028993; x=1723633793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY7kcjju6totcRCO0TNFjl+wPiujlR010gr+hx+b76E=;
        b=glzrxY2pgCUMwZNSMdsvMcIo49lAAg1vI6SuUfD7Zy/tBNoOV1UdJruAkIzJPvQpQD
         5x2KdkirxrjVxMaIJjkd4Dc+mL9O6OjT5JMBMEJFOMbFDJtUsvXVeAbe7xw7kc+UH6Ge
         xbgIDh3XrV95QLgbjKAtXxcS9bySwY+YOyZRsuL5xJFxh+R7wMHmz/iIDJS3P67YDVTV
         4ELznEiQCeAN9y2MhmV/VbXuopJPXFKlykIiOSeiq4FAmhDHsKvaf33W7zT6JlrUwCPh
         0OBV7Ba1OZ6e6ZTxtaDX1N4LwHNZCCI4VMon7wCEO47ODlyOSuag5gBRN/qmKjIMFhMo
         xdrw==
X-Forwarded-Encrypted: i=1; AJvYcCU14bib5IauEhLmSu6dDH1KgzZB0ZBAb1AIMaPwqaAWN00tULIYVtcsqYns8tfvPrmwDKyINeJ8mEyFyS3RRjxVOurLZF/qPr9Nh7va
X-Gm-Message-State: AOJu0YyeqFDNN7PiSm6ywDX87gb5V0IWJSoV14Iw7Sx4FuMyoiGZ9Ajv
	wlbzriCFrV6j+w3gM7i0wx8Ux+i/EtuBpdrjHlOFhRJfKrGp2JSVCmQbAiZ3sh8=
X-Google-Smtp-Source: AGHT+IGceACSv/jDFfYTUQvCzN9rHNwB3IV7PoKlUInGWrwktnTV0kcTiXg3XMJQLve23UfPiF6w6w==
X-Received: by 2002:a05:620a:f04:b0:7a2:bd9:70d0 with SMTP id af79cd13be357-7a34f00776emr2350929985a.63.1723028993045;
        Wed, 07 Aug 2024 04:09:53 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a37869808asm48066285a.94.2024.08.07.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:09:52 -0700 (PDT)
Date: Wed, 7 Aug 2024 07:09:51 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com,
	shakeel.butt@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: Re: [PATCH v3 2/2] zswap: track swapins from disk more accurately
Message-ID: <20240807110951.GB1726375@cmpxchg.org>
References: <20240805232243.2896283-1-nphamcs@gmail.com>
 <20240805232243.2896283-3-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805232243.2896283-3-nphamcs@gmail.com>

On Mon, Aug 05, 2024 at 04:22:43PM -0700, Nhat Pham wrote:
> Currently, there are a couple of issues with our disk swapin tracking
> for dynamic zswap shrinker heuristics:
> 
> 1. We only increment the swapin counter on pivot pages. This means we
>    are not taking into account pages that also need to be swapped in,
>    but are already taken care of as part of the readahead window.
> 
> 2. We are also incrementing when the pages are read from the zswap pool,
>    which is inaccurate.
> 
> This patch rectifies these issues by incrementing the counter whenever
> we need to perform a non-zswap read. Note that we are slightly
> overcounting, as a page might be read into memory by the readahead
> algorithm even though it will not be neeeded by users - however, this is
> an acceptable inaccuracy, as the readahead logic itself will adapt to
> these kind of scenarios.
> 
> To test this change, I built the kernel under a cgroup with its
> memory.max set to 2 GB:
> 
> real: 236.66s
> user: 4286.06s
> sys: 652.86s
> swapins: 81552
> 
> For comparison, with just the new second chance algorithm, the build
> time is as follows:
> 
> real: 244.85s
> user: 4327.22s
> sys: 664.39s
> swapins: 94663
> 
> Without neither:
> 
> real: 263.89s
> user: 4318.11s
> sys: 673.29s
> swapins: 227300.5
> 
> (average over 5 runs)
> 
> With this change, the kernel CPU time reduces by a further 1.7%, and
> the real time is reduced by another 3.3%, compared to just the second
> chance algorithm by itself. The swapins count also reduces by another
> 13.85%.
> 
> Combinng the two changes, we reduce the real time by 10.32%, kernel CPU
> time by 3%, and number of swapins by 64.12%.
> 
> To gauge the new scheme's ability to offload cold data, I ran another
> benchmark, in which the kernel was built under a cgroup with memory.max
> set to 3 GB, but with 0.5 GB worth of cold data allocated before each
> build (in a shmem file).
> 
> Under the old scheme:
> 
> real: 197.18s
> user: 4365.08s
> sys: 289.02s
> zswpwb: 72115.2
> 
> Under the new scheme:
> 
> real: 195.8s
> user: 4362.25s
> sys: 290.14s
> zswpwb: 87277.8
> 
> (average over 5 runs)
> 
> Notice that we actually observe a 21% increase in the number of written
> back pages - so the new scheme is just as good, if not better at
> offloading pages from the zswap pool when they are cold. Build time
> reduces by around 0.7% as a result.
> 
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

