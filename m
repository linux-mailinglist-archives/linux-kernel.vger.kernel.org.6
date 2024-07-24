Return-Path: <linux-kernel+bounces-261564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F893B917
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024381F23526
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B213C8F3;
	Wed, 24 Jul 2024 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AUBNaEdn"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D813A24D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859471; cv=none; b=XGPP1S9+D4zXNrmMFzyx+V8GgQ3jKwLIQj3vgHw58hEOPjDML8m3hsd6p3Y8X07GQEgIc/BSKOhED38ak5ZFbKNTptzN5Z6zt9Y1ftRPSk00BfFWohL7IzxDq3/FOjeqI+jQG7CkJUon61SuluMX8v1JDgd6fQhUrIULrdUL55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859471; c=relaxed/simple;
	bh=HSnd91iA2JxmReCQYgUgkXdR5g00/TMxtyg2D7XNu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtcIcnjBGEVBjtyoChUvfzyV/MyhtaLwdBe1LXj7EXlIn98T/UJtSfFzxN6dIUqQadjyf9aM831dzyR2LxxqfsJzVjCbIJbwOejqnEscJXGr+n3NtfWFDO+GdrBQqLkX0L3zC6Gns9QfkEOF4BP+mfFetqZ14T+MRgNwOv6qXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AUBNaEdn; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 15:17:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721859468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TwYIfl0vNJ0uM1DyVpfdAyoTfXn2gsQ4tGbgw4T4bZA=;
	b=AUBNaEdnKC3q1oNn3ZdkcvNfgNylW83MTFLC6Ysb93PGYIvq/hPYUvBy778JTthIFph2dF
	4Yjj99buWY/Pkl4od8eUfazWXIuvR8Iq+1oQSzYrdFBLzIcJ9I+50hgSrb8tlG0ATrlVgX
	WnTgp+GdTJg67fGav2KA4tgyhki+TPw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 0/5] This patchset reorganizes page_counter structures
 which helps to make
Message-ID: <xjrklql4khu6csizw63kznudhiwithh5k5fqw6krscu36mwac7@ufivi4ivxumm>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <ZqFmu9qmRiVJfRg3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqFmu9qmRiVJfRg3@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:40:27PM GMT, Roman Gushchin wrote:
> Ooops, there was a formatting error in the cover letter, my apologies.
> 
> Here is a fixed version:
> 

Hi Roman, what is the base of this series? Is it linus tree or
mm-unstable?


