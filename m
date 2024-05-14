Return-Path: <linux-kernel+bounces-178850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000838C589E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BAB22791
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B417EBA9;
	Tue, 14 May 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0X5DxtQ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFA17EB89
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700082; cv=none; b=HZT5kk+SqfmS9diMn6MBle5yA4WRIBFsPlLnFWHy30u+E32lfAP3xjmXTOFARu31oqWm1NgUgRnhR5Rp/Ar8AkMsZvB/ewwAXxra9GtnyYXzBsRQ3tXU/+JcSTT2550+AGuO6+uX6QBGQJv9FPY5BmUi414B5IXyfg+MHiMnG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700082; c=relaxed/simple;
	bh=QvFgEf6xCAOsIIFnMgua9Q/0LKwMRZ/d2SkAe4fO65c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfrZucLgR8mq4W+YAL2ID9BTyYbpZZl667jLl89OzHGIOIApSLqYeuNuKN0VR+XkB2MzOFO5LjxEK2uaKsRXlPO673J/H7wt6s4bPmjt8ES03HZGKzIUjHiibwqkaSnsg2XbgXHRZHZm4Gpdn5J0ubcMVpLrfBSZ4CdE2UcUop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0X5DxtQ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 May 2024 08:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715700078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp/ZA/wPWSCpzR8DINVVcEwRJoZy8bTPv9U2MBOhkyM=;
	b=K0X5DxtQL08E3oWIAIjNc7psXoKc+nD1muSUTmbD3yU+iapQASGca7tK62/pJP0vxHnc3j
	LkzuW8GdiYHx6wnaWlp2rcVRQUWBqMaa3u6Pa/o032bgDTD4FGzqZfUFQgW3Qq53VXO8v4
	Yp5K7cKvGuKlIniFkjWCvWLSPbJeSIc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memcg: don't handle event_list for v2 when
 offlining
Message-ID: <ZkOBaNffNi4rmR8h@P9FQF9L96D>
References: <20240514131106.1326323-1-xiujianfeng@huawei.com>
 <ZkNwthw5vJrnQSLL@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkNwthw5vJrnQSLL@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, May 14, 2024 at 04:09:58PM +0200, Michal Hocko wrote:
> On Tue 14-05-24 13:11:06, Xiu Jianfeng wrote:
> > The event_list for memcg is only valid for v1 and not used for v2,
> > so it's unnessesary to handle event_list for v2.
> 
> You are right but the code as is works just fine. The list will be
> empty. It is true that we do not need to take event_list_lock lock but
> nobody should be using this lock anyway. Also the offline callback is
> not particularly hot path. So why do we want to change the code?

+1 to that.

Plus this code will be moved to a separate function in mm/memcontrol-v1.c
and luckily can be compiled out entirely for users who don't need the
cgroup v1 support.

Thanks!

