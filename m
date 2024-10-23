Return-Path: <linux-kernel+bounces-378894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC69AD6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC42B221D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21771E2304;
	Wed, 23 Oct 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="goinhEN3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C4481B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719526; cv=none; b=st2TJDcEQj4D6ZTNWWImkOYLx5SEikzjwEbunnWZ2ofxHSBLcdHbfNwhpdIh0h5J89Mb86sevl/WtXYfd2HmqjPyUtr+SoTcddEbly7C/48Rn1MJoT6zVdwTvwyPMiZaAbs0oXH4zN7w+z+Jq5qhPKwzvN/VUP8s07MvL21Exr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719526; c=relaxed/simple;
	bh=hsySq/lFsh/WAJFgsffH3RwpObfPP97z54BUgccrJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVBb5AO6ssUGu2ZBQ1GNAgy9Gmw8nXhYS/6SSmh1mS+JaU4HSQbH8bEjfvM2203ra2S+gd7XwjLh5f5i6wmWpJVHjpX/+/aAxIabitxtrj7omdI9U8P9hPmKV2xxifOvHvZQJCv7aB4ASC3tLCpAQrzE1UXDwzA9CV0fWjn+c7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=goinhEN3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so2213555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729719522; x=1730324322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3L+Mi6DCqfrLQhTJ9/me+xzacY5Zdwe6SV+TH0hXgAM=;
        b=goinhEN3fsQ+VbpraZ2Kn5x7k7xL2PceWikCLrQUTl/chZqigntX+J8eJrWp9seMik
         fIR0Qu1SjXtHKk5cH1O+WDqeXg7qcNIDNMLe/tGbNLjPvkBmuzj3HVlv4LM2fS3/qIBV
         cQGV79h4S2aU4EHVWnx1Xizqzsz3RaZKmZIpdG6pY/sFulC4QzGjBeAngBWujl3sygYx
         WSnPdT4l3VxD+1DspTUTtXvZqBz54Vc5oez58Vk0F72ol85vYa3L20O4Q0R8PumVga15
         mQtrxfBKJqsYwu9RliFoKKiPJtiS1eDyZUeQ0UCCDn4WqgrRuVfWyIpkPyVaS4pKPHsW
         xi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719522; x=1730324322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L+Mi6DCqfrLQhTJ9/me+xzacY5Zdwe6SV+TH0hXgAM=;
        b=InxMUdz3pEkj8UMpM3xo3cnmr6G04caqupb27EfWnumXDoIn54SCf9kug6YXFD9Vyu
         /mlmxBh5Hw8Brz5M4navvEuBnASR8NpDgPT38wyLRNbuZwaan1vsBJdaZWvgdx1Tr2un
         69IHeY1HtgEFXr0LY745BK0lu+6UYjfqUlv+1XoZLGTudH5PkfzJ6S3ALjMPaWs0WRGq
         XGri0YUPiAoHpOl9ZgBesmrPAQdzhSw/Av1l2vkdIKafy4Hl/Zu1sDDZbqr1RMh1vVD7
         ESoz3OEHOrj9LJFL90j+n8TVVvGlkk1AJmxB0/xl6NCIHhxyFvG4vxRQplB2lgswqL7i
         rllA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2hFvvq1rt4tHOC8kUJZ/FJO4kCS+Jw7Hw5MVvTPlfFCRpy5GFkS/1E3mzUFmgsIavbRm38jg9eUHLcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwYZ9mTmEtQWiPkx8x0DpkJJ6BWT3y/wp5ET11STtnTdoBoMO
	om7alG/DJHKj76A2zso9tv+/POXK8kf4oddht9P+j5hqC9f3tprgXzRWst7XbCs=
X-Google-Smtp-Source: AGHT+IFQIpR/FPx7yYotfITiaiDTqf+2At9gJKCIzm55AVfINq+xpgx0h7c8KFDVMRBdtt22f36MYQ==
X-Received: by 2002:a5d:61d2:0:b0:37c:d2f3:b3af with SMTP id ffacd0b85a97d-37efcef116cmr2589164f8f.5.1729719521780;
        Wed, 23 Oct 2024 14:38:41 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a477d9sm9809215f8f.26.2024.10.23.14.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 14:38:41 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:38:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dongjoo Seo <dongjoo.linux.dev@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <Zxls4HqdkV_yBYxZ@tiehlicka>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>

On Wed 23-10-24 13:41:21, Andrew Morton wrote:
> On Wed, 23 Oct 2024 20:03:24 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Wed 23-10-24 10:50:37, Dongjoo Seo wrote:
> > > This patch corrects this issue by:
> > 
> > What is this issue? Please describe the problem first,
> 
> Actually, relocating the author's second-last paragraph to
> top-of-changelog produced a decent result ;)
> 
> > ideally describe
> > the NUMA topology, workload and what kind of misaccounting happens
> > (expected values vs. really reported values).
> 
> I think the changelog covered this adequately?
> 
> So with these changelog alterations I've queued this for 6.12-rcX with
> a cc:stable.  As far as I can tell this has been there since 2018.
> 
> : In the case of memoryless node, when a process prefers a node with no
> : memory(e.g., because it is running on a CPU local to that node), the
> : kernel treats a nearby node with memory as the preferred node.  As a
> : result, such allocations do not increment the numa_foreign counter on the
> : memoryless node, leading to skewed NUMA_HIT, NUMA_MISS, and NUMA_FOREIGN
> : stats for the nearest node.

I am sorry but I still do not underastand that. Especially when I do
look at the patch which would like to treat cpuless nodes specially.
Let me be more specific. Why ...

> -     if (zone_to_nid(z) != numa_node_id())
> +     if (zone_to_nid(z) != numa_node_id() || z_is_cpuless)
>               local_stat = NUMA_OTHER;
>
> -     if (zone_to_nid(z) == zone_to_nid(preferred_zone))
> +     if (zone_to_nid(z) == zone_to_nid(preferred_zone) && !z_is_cpuless)
>               __count_numa_events(z, NUMA_HIT, nr_account);
>       else {
>               __count_numa_events(z, NUMA_MISS, nr_account);
> -             __count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
> +             if (!pref_is_cpuless)
> +                     __count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);

... a (well?) established meaning of local needs to be changed? Why
prefrerred policy should have a different meaning for cpuless policies?
Those are memory specific rather than cpu specific right?

Quite some quiestions to have it in linux-next IMHO....
-- 
Michal Hocko
SUSE Labs

