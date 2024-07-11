Return-Path: <linux-kernel+bounces-249317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCD92E9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606D2B22CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A633161320;
	Thu, 11 Jul 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="A+MukzNr"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742461607AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705776; cv=none; b=Isa+yqJFyLOh29gpu6eqJUXORoaqngX69NCxw3VJHDh2JbE737erwHwjlcJzJVLW9vTuIktk4P7S7UTMReEzZjxw7uTubnd15l/3AHaOQAYaqInCpdXCWIR3CagXK7bKZMmQ5Uc6H+Hi2OJ8oZfq0mKgyHNpWMUsDFPzGWd3C6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705776; c=relaxed/simple;
	bh=+3RA/WCEZOLvNp1kfnEI1aI9/Vj5N0p7XqouO3rUMnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cebUustQiZhSf2ZngJyiyhhQeHNtcOAigSWiTT3xCnwH6U5GZFZOwsGXbF9H177ZsNbbOm9uIHK2HMWjcolvbaHFtDd6Zfp7swU2h6X3gRJWmxZ1+zQx4gQat/IumdF/NyGyVlNmk3V3VU2y2Ybzovx54q3+Wnvn0PFvq67TzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=A+MukzNr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a05b4fa525so69670885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1720705772; x=1721310572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4c/thh0gX3Wuy0Qhdv01QxrBoTYgtRK1bsGV9IACHGk=;
        b=A+MukzNrL8Sk1y0udzdaX/RHYy4Ys5oqxxPuqsjU3dNC7hF90THiWfJp7fsXsDjNVz
         /uLmAmprzkMpOuN3T59Fu7nvJXneA8Jc0ls1Yf1AQBscX7xCShPrQ71/sWtl2GvuDDDe
         JeEVx6VFSNGCrpK9ZN26h7pSqAMpvyDvytEPFVG8YkrouQV06VVDAIrOeEws/no26G4Y
         QAhonNFkPDH9St3lEfd9oKmE7aAWRmurVhKMsmEg/+0/r8dd+LkdTNgiHBmPjQTO8cAl
         4O27JgpgRz3+i7rMpsKblD5XESq5TS3ADqDyp5Ld1sw1+PLg5DlPlI6HcshEPx5T8gnZ
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705772; x=1721310572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c/thh0gX3Wuy0Qhdv01QxrBoTYgtRK1bsGV9IACHGk=;
        b=T0XRr8VoVOp6HLyVfqLC4Od3fGkKv35rfx11r6zi++xWKzPEcnJYwosEWSVwUWf/mb
         0lv3Eo8359vc8VFtdRC70xNSd5WkMzwyg7gPJJr9RiEbau/4Z6nRhatNy/90oE/vrcr5
         yG7EnLXKxwYbPLQuZQFt7g1h5jPVjwqScaGEg9YEqS1N6qB7M8gN0gawlUyiyvPjdC6X
         xyFM5D1xMy7VvqR3V0A7Jads54lw+mjT93HJAsDSTxJLv+5ts8aNwfWpmQM1ewJW7utn
         y+28uckvlzXe787k2VV+qhZE6H7BCbmvGK6nUMfuswYn3F1f/kZfMdDzippT6TxpCJKb
         NeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV6weZjBPLjJjUnlydSZSpQC8IinYmF6Us7lch+Gy8cXLSWMrlwK+Aj8l1fE/lFxi6Osek00XEY/bzcmhGCJzXlf8PQibBbIsKF9QY
X-Gm-Message-State: AOJu0YwnwkOppZzMbhrfcClr/okeRv30ildqgvtp+Ra2BxXXwvzciuuE
	xOOp48hqpjO35a+hCTeYOO3UykCfkHx06bilUDSTPDf9uczq/8F1Dn7v27TyHq0=
X-Google-Smtp-Source: AGHT+IHwEOYVfSWxKEQP0w8KFn4k/nB2bnIk+/F2DNotqRksDFSC7MbAwOqVXy2Rh4H9nIWY4EYR3Q==
X-Received: by 2002:a05:620a:4723:b0:79f:e0d:e052 with SMTP id af79cd13be357-7a1469bce11mr482286985a.9.1720705772260;
        Thu, 11 Jul 2024 06:49:32 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b4468sm291254485a.128.2024.07.11.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:49:31 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:49:27 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <20240711134927.GB456706@cmpxchg.org>
References: <20240710182353.2312025-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710182353.2312025-1-longman@redhat.com>

On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
> @@ -3669,12 +3669,34 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int ssid;
>  
> +	/* cgroup_mutex required for for_each_css() */
> +	cgroup_lock();
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
>  
> +	/*
> +	 * Show the number of live and dying csses associated with each of
> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
> +	 */
> +	for_each_css(css, ssid, cgroup) {
> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> +		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
> +			continue;
> +
> +		seq_printf(seq, "nr_%s %d\n", cgroup_subsys[ssid]->name,
> +			   css->nr_descendants + 1);
> +		/* Current css is online */
> +		if (css->nr_dying_descendants)
> +			seq_printf(seq, "nr_dying_%s %d\n",
> +				   cgroup_subsys[ssid]->name,
> +				   css->nr_dying_descendants);
> +	}

I think it'd be better to print the dying count unconditionally. It
makes the output more predictable for parsers, and also it's clearer
to users which data points are being tracked and reported.

With that, and TJ's "subsys" suggestion for the name, it looks good to
me. Thanks!

