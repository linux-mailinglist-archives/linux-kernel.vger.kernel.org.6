Return-Path: <linux-kernel+bounces-380338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B39AEC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F781F24854
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4C1F76DA;
	Thu, 24 Oct 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5fMDVoh"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976D1F8182
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788564; cv=none; b=VoUkNb5dV3xzw7ahQEZQOHqRx6aq2O8Fn9j/dlqxTswtWxXWFHgpvmLJ0ooNn4/s4/opjKhaaHv2uKSwEk12/jU3Ot1l0isisN1hWFI/LwOJaHyhU3pRu1dfeOGPNyFkEmKCRhy0GKXOLE0Dxo+VttWh0BjIGVZ0+hkmJbtWHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788564; c=relaxed/simple;
	bh=9GcHUz52wuFp5Sb0ctRxkBPtEugGIsVdi2cS9zDZce8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQXWdtOMq53ZgnSFbK1tstfKibvUZOPRzCKbDcCJwfJ5C/P2oV4RnUdBHJd9dFvJEUVaABw8IJTkMOjxmFqJ9WTkHgrn4ZLglom7exOmqL2oezzHlXuVTH+4wpvdmFN7eB45ppPUyCUB870yZqeQQR8UfZJpqrin1PxaKub/EA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5fMDVoh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 16:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729788558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7C5GlsDwNElfgpiyTybH/73F9q9fjWvPlTSJahZM+g=;
	b=I5fMDVohF0KK1ZqIQWa0arCYw2jN5B7e4tRJfo6t4WmRsTtS5w/EmuJEGEPdShll/KdiPm
	wAacEcwB5Lba0CFPJr1BuH0vWkpflBsRg3QDpNIHCAAEA0kLAILHTfZc9+Iq11L/mZlDtS
	lYquzVA/BP9KAPUrh4EO9uRxr5+i9sQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 1/3] memcg-v1: fully deprecate
 move_charge_at_immigrate
Message-ID: <Zxp6h_YS8YR6Anwm@google.com>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065712.1274481-2-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 11:57:10PM -0700, Shakeel Butt wrote:
> Proceed with the complete deprecation of memcg v1's charge moving
> feature. The deprecation warning has been in the kernel for almost two
> years and has been ported to all stable kernel since. Now is the time to
> fully deprecate this feature.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Nice! Thank you!

