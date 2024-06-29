Return-Path: <linux-kernel+bounces-234728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4A91C9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D481F22F09
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9936EDB;
	Sat, 29 Jun 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qve80Cv3"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60CEC7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622422; cv=none; b=gSV1n/KEQU4YaxCSo+yxrEjy0pxNjHbWmnU0eZtpd1c9D+5JpZ7D8S68qDNV/xC4hiVz+viM2cIDvHKwSF/PCez0MPlVqXDD7DpjuMCD2WR+FkvalHa9tOmE9g7P7qKUKTjq84yYWnZJvPEcVXCvFK9O9tf5JZR2+eT/XjJucJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622422; c=relaxed/simple;
	bh=DFlXFK11/eLgYM1QJHM0FL2BSReFnWJ4N+6IQawpRpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2oUxep/D+tml2yNvlTW4J/1/FaiCVNxJIhGkR/6c13algqR+ulNprjRaEaO4oPPVpOfEap/FDBCewo5ZWpF8f1PnnqTgrfsKMrDJRll4AU3U6lo2xC1aPb/C2LOdA/TuEnnicyF90PGEJNvpY7QXTKAlFV5qx3/kL/1KqwU1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qve80Cv3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719622418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRMMODaM7H83u1vR21hpGAF+yO00hfPA1yE6kBSSOck=;
	b=Qve80Cv3+UG1JMKfkWxIAmWhRwTysmybz5w/brxE6gsYbTlbqxG322hQC814rQc9p5eJ39
	n2qwrVsetL5+FhQ4GKy/UL+4nOVxcPPZ/1CymjKNkKFpirgceQdrTfnEDYhQnIsmrtVNuz
	6rCy4JoB2aufKD155x1tNspU8UzRhcs=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:53:34 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 8/9] mm: memcg: put struct task_struct::memcg_in_oom
 under CONFIG_MEMCG_V1
Message-ID: <l3gmo2h6qtfvrwyof7qsiduwid65wqs7xbncdabpgrvyun7ifx@w5rod4je4pgm>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-9-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-9-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:16PM GMT, Roman Gushchin wrote:
> The memcg_in_oom field of the struct task_struct is not used by
> the cgroup v2's memory controller, so it can be happily compiled out
> if CONFIG_MEMCG_V1 is not set.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

