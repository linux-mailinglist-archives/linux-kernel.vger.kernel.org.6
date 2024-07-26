Return-Path: <linux-kernel+bounces-263282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4593D3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4151C228A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9625717B50E;
	Fri, 26 Jul 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXj/Cb5u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1342070
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999157; cv=none; b=BsBMzLEPXVHmakIpQa3TfdiMOAhkG4UiUshefRluMoL5VPguOBHhjACpyA5QtL/tKAT7nt4UHtAoKIWR1MZKAqFrGqFWFtdCDJeHaJh5oSVfluQgMP2d3s4xak0a4N3I3upTWYbMkI2I1lk6Igqx46RU032EssmuWO4AVNcBxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999157; c=relaxed/simple;
	bh=73c303h8D2Bh9Wjdk+gEXX9ZQvv7V38H21ogxJ+yx7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUnKk5LVkivI9ndd954nq6LtyPSK377gUvYdhmY/x1F1iJno8Di1t+kxT6bg2ALNi0kXLNeR3OtZOc00Ew5ZcKrnppeaDKhoyzi9mUNRDLEEZL2330sDxcEJqid05RB1+qUOCUVProURLCHnhBGc1rqXV58Z+e1khWwC+6q4YBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXj/Cb5u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73c303h8D2Bh9Wjdk+gEXX9ZQvv7V38H21ogxJ+yx7o=;
	b=TXj/Cb5uTDQHH3GTG+2IfCbr0+QiGYxSSrFvU3H+Dyppv/EYgns1IV/qgYtLUR8wD/vuTf
	tD/LIkXd9MdzKia/Cqrht0oaPWkagkklN36ZGTri1hPsMOmSOhgM6SO9/kabRinhg4885M
	N1HUeHV+pZxW5pGswEiivElvpXQ3OXw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-mOP2QBJaO96LGK9_uNYxPQ-1; Fri,
 26 Jul 2024 09:05:50 -0400
X-MC-Unique: mOP2QBJaO96LGK9_uNYxPQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417D71955EA6;
	Fri, 26 Jul 2024 13:05:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 505E31955D42;
	Fri, 26 Jul 2024 13:05:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jul 2024 15:04:07 +0200 (CEST)
Date: Fri, 26 Jul 2024 15:04:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zheng Zucheng <zhengzucheng@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime
Message-ID: <20240726130401.GB21542@redhat.com>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240726023235.217771-1-zhengzucheng@huawei.com>
 <20240726104429.GA21542@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726104429.GA21542@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/26, Oleg Nesterov wrote:
>
> On 07/26, Zheng Zucheng wrote:
> >
> > before call mul_u64_u64_div_u64(),
> > stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
>
> So stime + utime == 175138003500000
>
> > after call mul_u64_u64_div_u64(),
> > stime = 135989949653530
>
> Hmm. On x86 mul_u64_u64_div_u64(175136586720000, 135989749728000, 175138003500000)
> returns 135989749728000 == rtime, see below.

Seriously, can you re-check your numbers? it would be nice to understand why
x86_64 differs...

> But perhaps it makes sense to improve the accuracy of mul_u64_u64_div_u64() ?
> See the new() function in the code below.

Just in case, the usage of ilog2 can be improved, but this is minor.

Oleg.


