Return-Path: <linux-kernel+bounces-278342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F894AEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52821F22874
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72013D63D;
	Wed,  7 Aug 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="F21abGob"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDD13D61D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051936; cv=none; b=kUgEmI6bB0FwRP9a61tfnoT2UC7AvJvocVAAI9UNrHNBaFfiaXdJYRACWaQr4nJFqkZk4xcDxeuqtuBwBeGDk9q5zvvj6ZP5WTLcJcFy799YjId5uQmWCbQdNwEyMaW6eqoPUdU8xzFWHFnpdqJH81Vd9Mq7w1Oc9G86Rkdvgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051936; c=relaxed/simple;
	bh=/0tdQ4GyIKRolLxENjc86mazApy5VDmkfI69GjhJWtk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PRJtYobboBGhb5/u09mFb93VdlfFG4E6iWmsZj4SfLIy6Uyx+qXEXStjWGUlJXIwu4dy9x2zkxTvkwvP0YfpK7FyMrneL5zJ6kjAd69qH0GKerpUGpbZAWfDGM7IVgkN3d+wMl9Q3W9Sj6rfeJ7bLW/KeN9P4ZqOXs0V0zf8v8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=F21abGob; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1723051928;
	bh=/0tdQ4GyIKRolLxENjc86mazApy5VDmkfI69GjhJWtk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F21abGobAW3vSUd+WHfIdmf77o8gwRGgx+lQeZ5b1xWtQ5Iv6k3fMNZzroX4+fgbE
	 NH9mOGrcViisNaETr2ZlXaQQ1LF/lKnJVnewSMLxJpTd1NvXtP00CqxIRSzVvu7d5I
	 BUSbb3O5JqmXWYl8kbqHBYs0hD7zd9zEYy0RKA24=
Received: by gentwo.org (Postfix, from userid 1003)
	id 9391440254; Wed,  7 Aug 2024 10:32:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 928D540253;
	Wed,  7 Aug 2024 10:32:08 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:32:08 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
In-Reply-To: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Message-ID: <ad85f6ee-28a9-b558-2219-5a6e49e17b75@gentwo.org>
References: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 7 Aug 2024, Pedro Falcato wrote:

> Duplicate slab cache names can create havoc for userspace tooling that
> expects slab cache names to be unique. This is a reasonable expectation.

Yes that is reasonable. This is done during slab creation and so is not a 
performance sensitive operation. The sanity check could be done even 
without CONFIG_DEBUG_VM

Acked-by: Christoph Lameter <cl@linux.com>


