Return-Path: <linux-kernel+bounces-305578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB29630C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A56928611F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772181ABEB8;
	Wed, 28 Aug 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B3LfUWA8"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2502158531
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872286; cv=none; b=bYPPumuVsB12QCVU/UzyLNq6ngAY49BL9cC4uHzPircblIOgaMzSDKbqFk3NS/uf7p/m1+rg3/1KhQ5VDWX/jcOPfEGrBN8g/ELHUlZr7GuO89L/pxBTn+mWKAQXAW1AxBEdWkQXa+yu6W/M7acsv7RWFHhmgPHez/6o3evKsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872286; c=relaxed/simple;
	bh=xwUHcngPIMMwNkAT0pu+KDN1EFPtCTrM6SVkoQoFFAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0n/+7IUBLWVMcv1QTqM7Hgxc6hOtVoEqlBNwZfbCZp9coFKCDZitcXlcvezLn26aq7zlfZQK19IyGCvU59Wb70EkWXy+89GqOuH9h+n+5B3YFsHwLDzjndcg91H7s6+7O3vbeo+J0zv0aFxOA+xi8gSYsoGy07EQBJzRRJ8+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B3LfUWA8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 15:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724872283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GJ0kQNrYXX9msho8J4AhvERHyhJZ0duOS+e8oU72YE=;
	b=B3LfUWA8l8mmjSaFE6ClHPtuaOFidM2PzSFwePSZfiEQifAAVqUkYhY10DynXMQw3ODDYY
	QIIZoSt1z0wfqLJjUt0+eDfyko6JI/8MBw4Ua5La8XdmAHWRV6QgjkssZBcW9o8SG9Ppma
	KeyI1odcm9BVsEUCU0PgAQIPhHNFed4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9xC3OJPbkMy25C@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > unsafe locks is a potential deadlock.
> 
> Kent, the approach you've taken with this was NACKed.  You merged it
> anyway (!).  Now you're spreading this crap further, presumably in an effort
> to make it harder to remove.

Excuse me? This is fixing a real issue which has been known for years.

It was decided _years_ ago that PF_MEMALLOC flags were how this was
going to be addressed.

> Stop it.  Work with us to come up with an acceptable approach.  I
> think there is one that will work, but you need to listen to the people
> who're giving you feedback because Linux is too big of a code-base for
> you to understand everything.

No, you guys need to stop pushing broken shit.

