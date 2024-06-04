Return-Path: <linux-kernel+bounces-199992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55228FA8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DE728C1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63713D881;
	Tue,  4 Jun 2024 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOwBFQfx"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8312E1CA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717473475; cv=none; b=u1E3zp5UPn3o0jm3UOtBlaXrWn9gIifHgW17R6rfKCex+KY5jjYAvNcTdoHQ2bwrDplY6FfCxxnxiBWp9yVoQdFH1D54M+o2v6/zIz/69fo/xH6HEGCDq/s8E4it2oGfQkiCFbJnzk+FWAFHOH/QZxZQzXsv2z5m9iXSYLY9jQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717473475; c=relaxed/simple;
	bh=iwRxwTH8zwIRcx9nQ4Oaaif7P+pfLS8ReV7DgkHzc/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBGZ79OqDC7ASGXoDXLgquJcxHJQi9HH6dGUWNCQLSjxySUSI+A7D8jPIogbHhQfarYNBnW1+34wXOJLeiKlUloYRALyxpzJ6z1U3K2E5ECzujOFIC0XYnRqeglWMzEfB6M6UhdWBav7YmP5yuA8YN4ZrT3+k7BAg+e/7cl8PQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOwBFQfx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shakeel.butt@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717473470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6d6WXIvaz3gcm62V+C/H0QUwbpybzVpITkvGw7t1Mc=;
	b=ZOwBFQfxKJJ7/6drU8LYL33lE56csQSX+LeZrPWum+B+3BZCqRfrJxBtTTa2Eg74BPFblX
	K7DwFyU8aS+U+o2ViQw4UMSB7KT/OT1bg8QrTgYPWIduFsqnzHhpKm0BNbo6OBwlo2cxlE
	dFclKDMO0dN9g62xWaGmOTgyjrmsHfg=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 3 Jun 2024 20:57:43 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] mm: memcg: move legacy memcg event code into
 memcontrol-v1.c
Message-ID: <Zl6Qt0F8-_66fBQ5@P9FQF9L96D>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-7-roman.gushchin@linux.dev>
 <q74ns35d6j3e5m6hx7t4cgoezvfhsk2nzi6ogmlh5ygsb3qdtl@zupnd2ngb4g6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q74ns35d6j3e5m6hx7t4cgoezvfhsk2nzi6ogmlh5ygsb3qdtl@zupnd2ngb4g6>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 11:33:46PM -0700, Shakeel Butt wrote:
> On Tue, May 28, 2024 at 01:20:58PM GMT, Roman Gushchin wrote:
> > Cgroup v1's memory controller contains a pretty complicated
> > event notifications mechanism which is not used on cgroup v2.
> > Let's move the corresponding code into memcontrol-v1.c.
> > 
> > Please, note, that mem_cgroup_event_ratelimit() remains in
> > memcontrol.c, otherwise it would require exporting too many
> > details on memcg stats outside of memcontrol.c.
> 
> In the followup work, we should decouple v1 only fields from v2 fields
> and then we should be able to move mem_cgroup_event_ratelimit() to the
> memcontrol-v1.c file.

Right, agree, this is my plan. In the RFC version I had a lot of #ifdef's
in mm/memcontrol.c and now I plan to do it in a nicer way, moving
cgroup v1 - specific stuff into separate functions.

Thanks!

