Return-Path: <linux-kernel+bounces-305546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA21963047
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E95E1C21272
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F811AAE29;
	Wed, 28 Aug 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJXE7K9N"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD51AB505
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870479; cv=none; b=bRkZEW2TyGcHEFAVnMcJOOgjCKxhu4IcLYmC9XEr1P0QWWCvvHwbEzkXiHGXa/wuBXEPNCunV1Csm8wEOJIVviplyn28nzs0z0SFKILfEEQrK+r4uBDs7bqNADPXaHFriHo4U+WfxxVFo4uWE39SPlYdU4kJIaE/WgHx/DokO9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870479; c=relaxed/simple;
	bh=vrKyRp2+gJHOVTsp+LSu/FfYLaKE6b7bgUPPEv2NOys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVYedso/cbVEdyrIa8OjG/KR+BeZv/ynuCbgZNTXpYgw3R7HmSNBoku7EZH1KbhC+p+5LfyZy8dQR1xIZCmk1tGuUDNDNg3LYDJfDvHse4XiIMYcA5y2jc8E/JRavnr1aOQirl1b9IuIpWdzsily51nsKKSdu72Jr2FvXm+pFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJXE7K9N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202508cb8ebso48116865ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724870478; x=1725475278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PG1bl7v+VApZiFFdPuv8DCXf//YPD8GTnfqBj8wbbs=;
        b=ZJXE7K9NYIHPfJtF5Pl3wmlkQG0zgAxeEK3EKym9o+Ce7XnhlZSvmF1vcI6LrN33TE
         H9wt2JLOK3xM09IE4x13WBV/kuPt/U2i8eh6qJwZnmqAt9YUKOlXutgLWzi0kxXDF/zT
         LogDMeH5Ze57mhxIsFu0rIUJFWpsa5LA5o0QxR3dW4J3Fap/iGyaeYvyVinpWKKZMBph
         Wws5cr4tX2KMeCtICXr29mpSkjEPdLlT2NZaXv/xVbZ0ATU9UgXQbdq2KQJwbVW5KKNy
         wfFiR5GzdWKpdXUORq2ApMf/lqimAqXKkvc7k8i28UF1vo/Rt9RcisQfZ9ShhxNFj3xT
         Cwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724870478; x=1725475278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PG1bl7v+VApZiFFdPuv8DCXf//YPD8GTnfqBj8wbbs=;
        b=DAfMYF7ESUKN3K2+ZrT9wORLgan4Cfv6E58f6sovjlnyFdKQptn+9DukykL1ZrE8vt
         +kjtCEvsYSWcDvYK9pROTRXd82g+jwbTOZ4S33au8P3LTMvO5ohRjaHyK2Z58MAOugqE
         e7m5cQDEFmftnhY/RRyJzBIH12q08aq4cx8V1I+VFhFQS1C1sopfPYwoH0OZmFvm4Jlb
         ItvCEmV9bvm6lX16j7Uq36UZC+F5y/iEJNHRleCgzMOePGS30mo/ejFuuAb0zFeXlJ6c
         l208rbLXGpX19cg2OirAlLSneyDwl2CNBjNDZ4Ok/4ZNgisTgTmxiRK6XZhSF43nfRVj
         j86g==
X-Forwarded-Encrypted: i=1; AJvYcCWRBIaS7qZnu77Y++ktZgspunZbTX2wd++LmXx8Cw+9OPT5657LHvhJRIhLSlxK021d6tBnVtQd3ZzhYww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIhooTaHuJnfNEYHMIkjCFYTWwGfYudMN0xncCaxwaWkp+snQk
	AdBQaImUH8dPaOIwiz5n0V1JLg+RdwWxLKTqgBo47diR3z9plmz3
X-Google-Smtp-Source: AGHT+IHWt11gqqZsdzfOodJ4LhEY/9aOlKZtWqHzKtXAgUTAWGd+7ULFpa/vmvnrUb+KY6P5TqH4uw==
X-Received: by 2002:a17:903:2292:b0:201:cda4:69cb with SMTP id d9443c01a7336-2050c34f7e4mr5452225ad.9.1724870477624;
        Wed, 28 Aug 2024 11:41:17 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038558b3ffsm101887255ad.117.2024.08.28.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:41:17 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:41:14 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 2/6] lib: Implement find_{first,next,nth}_nor_bit,
 find_first_andnot_bit
Message-ID: <Zs9vSkFNLMDsUH9R@yury-ThinkPad>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
 <20240823185946.418340-3-mathieu.desnoyers@efficios.com>
 <Zsjg1H_V8eq3-grK@yury-ThinkPad>
 <48d61e8d-7a69-44ae-9c8a-846d76c5a4b4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d61e8d-7a69-44ae-9c8a-846d76c5a4b4@efficios.com>

On Wed, Aug 28, 2024 at 02:24:28PM -0400, Mathieu Desnoyers wrote:
> On 2024-08-23 21:19, Yury Norov wrote:
> 
> [...]
> > 
> > If it comes to v2, can you also add some sanity tests for the new API?
> 
> I don't mind extending existing tests to cover my new APIs, but
> I could not find any selftests for the linux/find.h API within the
> kernel tree. Am I missing something ?
> 
> Thanks,
> 
> Mathieu

There's a very poor coverage indeed. Mostly because old find_bit API
is actively used since very long ago, and if broken, the kernel will
likely crash on boot.

For a new API, I try to keep it tested. You can find test_find_nth_bit
in lib/test_bitmap.c as an example.

Also, if you think your new helpers would have a performance impact,
or will be used in hot paths, you can add performance tests in
lib/find_bit_benchmark.c.

Thanks,
Yury

