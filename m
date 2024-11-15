Return-Path: <linux-kernel+bounces-410542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F072B9CDD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA8282FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33901B3920;
	Fri, 15 Nov 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg9JOtXn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC4136338
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668078; cv=none; b=L8jkwk2SKsdOHF2UDzun6BSfRfpgI4OEZpNZ935hGF0sUDEYRn6+ruSRAhfSyyr2ZkbeklrIwo2ZoH3i1hmP9mwebf9JkpUh/sTODy+UhGmW9+52Rhi4VbeSPIRcs2vK0rDp1/epuTGfD4qAzmACxO1BJIY8CHeghMtQscnx1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668078; c=relaxed/simple;
	bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT/TyEgmbi+ZfxRHirQstSJ+BFFI5+X37A5qAMid0Gem0A6j/Cf2saqrolI7T5QaGFL5HntvgVpGRkctguKmsy7Q/W3nggINJVfRsWv9gXOWMv49vqOjo1PCGOmlYXyDKehyJOVM0aud2uu2GXpCReny+9hPaZDOrNDgxk/jZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg9JOtXn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731668075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
	b=Jg9JOtXnpxWY23wa69Xy9kFb3SIy/ng7WCzh/VeYffflRBKvjojwRvMVG7vKdC4ui1KvVL
	ZP2q/8kOe4eg2NIT/7dbHEzkxZFySepoMwfRyJQ9LFesLnRJ5uhzhM4Hwyxlv0na4LWDt0
	JUiSCfSpJ4vm/QDpOzNXYoRrVTY8HPQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-3m-zchwuNBaJsGtbBtIKBg-1; Fri, 15 Nov 2024 05:54:34 -0500
X-MC-Unique: 3m-zchwuNBaJsGtbBtIKBg-1
X-Mimecast-MFC-AGG-ID: 3m-zchwuNBaJsGtbBtIKBg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3822ec50b64so27862f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668073; x=1732272873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJYUB7rGj6m30IJq7NMeEAdvdHtt/hMzg8P+2e0dRhc=;
        b=OODRv0Zk4UkKDxHj+UAhmBQrmfJ7hAfYB5gcBu/SvCMml+vnKytoI8pPksgfsBmYAO
         71gwQteXaDwJ/awfGHH//vYlmWoq1ekNEEqsDSbuQAB6DxHSCID6n35kK9N2OQfHlkqq
         bvgtvF9YbNg7ds6USd0Zlmg+WUzDcVHkP7bNhdq1YDqSCQQXdoLYA5ojOMlL0HjJ+c/3
         yR2bOJ+0OvvZWhK+sAeFNI34Xl3yQoU+bakO0u9ham9MRtsukpdt0vfwEsGbU56NB99e
         RO9fLVjKYJFWA4m3vt+4T9EBevN58EymOyv107lslr20HYkOh6QCAb22cIQC+OpAYTBI
         ZW7g==
X-Forwarded-Encrypted: i=1; AJvYcCWISqTYFuxP6fj5hOENUXpllCAOHMHT8AkwMMXfbGMH8MZ5aLZTFqdatrhd3SFla6nbdLWUmLhAA/Q+mow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjIXyriaBHoTVcIjVHC9Tm1bfPxblgomhbk32JEf8ym0oojv5
	0cp2ifEKFDgEkoefL0Zs7/gDA3sWHk+LjUafHV/B168wEdCL5ouD3WDNjby8s14e02kiRqLI/rJ
	NQ4ouxvx9vReH94fh4UG0OV4EiJeXH9+36NwFIxK445xaztk3Y0OYizhxeycARA==
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id ffacd0b85a97d-38225a89fe4mr1992784f8f.46.1731668072814;
        Fri, 15 Nov 2024 02:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMLLahLve2i85NSHyBQknYctxJFodWGkT2mc+GIqMJNAdazw+5Xuwbvgn0mTfJ/qu2SQDiMw==
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id ffacd0b85a97d-38225a89fe4mr1992766f8f.46.1731668072454;
        Fri, 15 Nov 2024 02:54:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad619sm4022252f8f.27.2024.11.15.02.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:54:31 -0800 (PST)
Date: Fri, 15 Nov 2024 10:54:30 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114181915.142894-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114181915.142894-1-longman@redhat.com>

Hi Waiman,

On 14/11/24 13:19, Waiman Long wrote:
> With some recent proposed changes [1] in the deadline server code,
> it has caused a test failure in test_cpuset_prs.sh when a change
> is being made to an isolated partition. This is due to failing
> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
> validate_change().

What sort of change is being made to that isolated partition? Which test
is failing from the test_cpuset_prs.sh collection? Asking because I now
see "All tests PASSED" running that locally (with all my 3 patches on
top of cgroup/for-6.13 w/o this last patch from you).

Thanks,
Juri


