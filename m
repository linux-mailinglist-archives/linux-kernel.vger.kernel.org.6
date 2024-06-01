Return-Path: <linux-kernel+bounces-197730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700328D6E85
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17711C213BC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADB9134A8;
	Sat,  1 Jun 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JhwTnnh1"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09096DDB8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224185; cv=none; b=mjeijLqzgUDKuSHnDLg3Mlvg80mnSDvElMNCc57Uua7O/Z82adHKaWlPSGWMO4QhEooTfthq38jb/zI8yBBh/pi15kUXHQaY+Uq8rZlrQtS1SleWq9tP31hnkR1RpDC2JEiW6ThZn7j6ycBzVcVJ82t3/jm72KGXxw4zbjNQzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224185; c=relaxed/simple;
	bh=vb+qajOZY9DeMHN/EmkGOf0ZAQEEiqV2HlJSQg1sc+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWqLhENjZSyvzAWNrUI0szVilwhmCYtmHQeaW68psbi2WdGzlvTiH0sJHS/UQQx7/+ntiuC8dTaKGcK3PFaFe4wSdWGfIkgSre57X0sjF4BZID6JEpEsYEOCvZoIBOV0TLSaOyCllXfZnE4+K8ZbkrIZ+bDm7+lsPCkfHPG5qNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JhwTnnh1; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6g/m2Vo4ckbmL7s3SgPNBlQnNOpuP29aYJPD6t4ximg=;
	b=JhwTnnh1lqUzylBqkmbluW8TtdLppzH+OLMF3UnhBhc89uoOJ4FoB1XwXyRjTUIFovDeEA
	oR1VeeSkLb8HzsnUNOI/1tazE40iwXvaqnmWGuRnYNbpUwiPruV41EhHPKNnrDvQL4WY0Q
	4WVV8sPX8eUKjOxBPtKLlrJ9dOj8kg0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:42:55 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/14] mm: memcg: move soft limit reclaim code to
 memcontrol-v1.c
Message-ID: <2tvwb3io7tynt32wwauyupbpq7kvmpkywm2e2z6v2npwmj2f7z@fydgwb7rsa6h>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:54PM GMT, Roman Gushchin wrote:
> Soft limits are cgroup v1-specific and are not supported by cgroup v2,
> so let's move the corresponding code into memcontrol-v1.c.
> 
> Aside from simple moving the code, this commits introduces a trivial
> memcg1_soft_limit_reset() function to reset soft limits and also
> moves the global soft limit tree initialization code into a new
> memcg1_init() function.
> 
> It also moves corresponding declarations shared between memcontrol.c
> and memcontrol-v1.c into mm/memcontrol-v1.h.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

