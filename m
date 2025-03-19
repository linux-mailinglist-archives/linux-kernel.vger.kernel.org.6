Return-Path: <linux-kernel+bounces-568659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8800A69902
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5045C1B81227
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4D2144BF;
	Wed, 19 Mar 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KzHR6tAw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A32116F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411806; cv=none; b=UAIngdhl1XNBatC0rU0wzftY4AW5fyUYL+2qLyFuQmBywWCWZbzX6eGZfjrw3WY50UPriHu/+VvDitxPtUlls4lSV94fuP26+BdpX6J263vdSzknp1IAYOwpaIjoVYBY6V/fFj5uu/LO7GAE3UMhA1Uy0ihnSqKmQANhHgyU/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411806; c=relaxed/simple;
	bh=tXLoUo6DziRJgG2bIsKtUTPmu7pJFqeAmmvjt5Rxncc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk0Z4M2BBUz2l/MTyrqnIQE+fIkT5/AVUVfZo9mRtakgEjoZByVpBv4Mt502yEU0haRbi9pdUWdjdAXIR+wDsgE3cKkPPVvm4LjTwrltPrSmBcoflyJVmp0INAUKUbngTr5e/MdMRUP9CNZmCdZxZrD456498qsUJRs1MkaHufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KzHR6tAw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47690a4ec97so332361cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742411802; x=1743016602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwZYITC3Gbppixi2KZZqHp5PUuDT5djtLXFC/0w6SVQ=;
        b=KzHR6tAwBp5jiEYYpndyc+S7n6Erl/dddcvUayvNgaJI7RL7170ucTPs9xu9ExtiUu
         WRmXVk+HoZJqzU9hhlf3UWtgfP1OTLkN7oII0OdpjEKowaI5JOCUrzpXgHckA6Fxy/0e
         e2cQ5YI0G1/a+eviUWSTjlXkE7U1umvJLXg2+6mejctZWg2B/PQfyYk5aVIYnR7NFi3/
         jXJitGMW3J9zRwoKIfWnjqql0b2cNWNLC68HtT1MTgufx4jBGAeyk1epDMfUBVy2ZIBr
         +qyuB/DhNUgOdUmLhBREIXy/Xh53MKjkjkK84oPRaw9c5dRZsMOHQ964yVIS7u5AhIoY
         9Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411802; x=1743016602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwZYITC3Gbppixi2KZZqHp5PUuDT5djtLXFC/0w6SVQ=;
        b=en7DmnP8CgovVkxtkrCy+fM1KI14xpEyV2k4r5k9NZwKSKc08Xdhu+lSk3Jzvh0ji6
         b/ATRVVBkAN2Y1WsHivW3GrT20X3RFXye8gqPrMy89XCFGH2Pq7/AdD/SuvjcYGmawjt
         6bOlZe5a8E7GqaDaD57yNN/fxAEoLD5Z2lQ2Y4zbeovq0fh6vEXJxWVOJwsU+X9bmYkl
         fv28VLws+Cqcno27YxS0Y8wiW2+a8eu2ojpUp88h806p3UHEya832V2/y/6pyBJQLJNF
         X+u7OCKI5XdHOwaCS5E6627RUm+DZ8gDl85mt0jJL28Yn48C81M8/joyPDLPTP1a88XE
         Bzrg==
X-Forwarded-Encrypted: i=1; AJvYcCUEu2fpJpQW0WyegiU4cq6f0EYO+myF1Q1LfNzZylWokp6OYxHPhv4t1Gt0kG5EMMcsFKJ7snuF5kNLqew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpzkWIMyjpwiFZ0RiZMNPr77KoKgwmMmwCxoe/NISXYE+VCqZ
	aVbs/VH+yG4cGliptaGZLinSZ4e35SkQ+I4B30wiGzSV3f2SiiV7cjXYy3BYw5NqilqrEaIh6Ki
	R
X-Gm-Gg: ASbGncu2Ws2UqtcRFUgmihGChyVZzq6wNIzVLd13VIWN7vcIEe2Sp1SBvUwoa/ROuL0
	eezJgTr/i8j1J4wQfFYXgeBwbuuiaJtp4eb39AgoZOt25a3KAo6ZQbtbSa1qRHGVUE2YhwMyPMi
	4N4hyyhVeFjhbVPCZ9/ihqAPkLISatRbDQPbKlx2Av8H3LnXmsPYdhwv7ZYOuCd1DobZ2phl78e
	6yvYkIkLlPI/vV1PaY5/4XBl7jxQjmgc9N+lg9oH1QK6JrX8TL7H3PWhbF0JxLH8296wtIaMQjJ
	S9+gQctn63tb9s6UK6TfIUHqkZGA3/EA/hF+sV4Ttgs=
X-Google-Smtp-Source: AGHT+IEL7dBxtUf8JbHdoTqCi0756jwzQ5qz/ECZoCAsd0Rnq2Y+/GuVS5qghsIL92pasrWy7R7xjA==
X-Received: by 2002:a05:622a:1149:b0:476:980c:10a4 with SMTP id d75a77b69052e-477082dee45mr67738901cf.23.1742411802648;
        Wed, 19 Mar 2025 12:16:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47705ec40b9sm15493031cf.3.2025.03.19.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:16:42 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:16:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319191638.GD1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
 <Z9sOVsMtaZ9n02MZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sOVsMtaZ9n02MZ@google.com>

On Wed, Mar 19, 2025 at 06:35:02PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> > (btw, why do we not have any locking around the root stats in
> > cgroup_base_stat_cputime_show()? There isn't anything preventing a
> > reader from seeing all zeroes if another reader runs the memset() on
> > cgrp->bstat, is there? Or double times...)
> 
> (I think root_cgroup_cputime() operates on a stack allocated bstat, not
> cgrp->bstat)

That was the case until:

commit b824766504e49f3fdcbb8c722e70996a78c3636e
Author: Chen Ridong <chenridong@huawei.com>
Date:   Thu Jul 4 14:01:19 2024 +0000

    cgroup/rstat: add force idle show helper

Now it's doing this:

void cgroup_base_stat_cputime_show(struct seq_file *seq)
{
	struct cgroup *cgrp = seq_css(seq)->cgroup;

	if (cgroup_parent(cgrp)) {
		...
	} else {
		/* cgrp->bstat of root is not actually used, reuse it */
		root_cgroup_cputime(&cgrp->bstat);
		usage = cgrp->bstat.cputime.sum_exec_runtime;
		utime = cgrp->bstat.cputime.utime;
		stime = cgrp->bstat.cputime.stime;
		ntime = cgrp->bstat.ntime;
	}
}

and then:

static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
{
	struct task_cputime *cputime = &bstat->cputime;
	int i;

	memset(bstat, 0, sizeof(*bstat));

	/* various += on bstat and cputime members */
}

So all readers are mucking with the root cgroup's bstat.

