Return-Path: <linux-kernel+bounces-235312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6991D390
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265FD28130D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E7153814;
	Sun, 30 Jun 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qb4jgR/M"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5F2C1BA
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777182; cv=none; b=n7jViMmlLS1siGbL9HDSdeNf2GjIY4STk8lxyS4F589d7OfJ+zemdjq0cErGJclcDiKVBa9jm+jyNOchbaLjc55G6im9nBr7HtPFJyXwU1CJSKEEr+so9nNBHqlxMegq8kzgdi5Ufyh3+NKkK+GUVutyCMZM7I+fMzLVzkMYycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777182; c=relaxed/simple;
	bh=zjrep4fX9TmpsgCAS9uCVjQRvbS1Ne2EqtBf2V7TwfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5sXM3RW79KzEO71fSdj4GPf40Q3iZunvugKBAPCkZtE7B05GpQP/5YGqqCNRG5okrePDG7xObExtoQo+EIMN+aXdhLl69BDBQUmJppGtfT+N1K+EYNMsIeDSkgoAunSYtWNyZKIdcGxxVyP3VJzi+FCOxlYEKix7MRQcRkHfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qb4jgR/M; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: surenb@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719777174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl3FZxzTv6nkUMASAYvw9B8a5YZiWMBa7RB0BRu1rRY=;
	b=Qb4jgR/MtNRK+7bUH1C4JiDr6rYwpc54H/vo3kvIVx36HKB6OlJPcwCKrkLorjp+HpqPid
	iDpzITqlK083JXmw4t04lIQ+aWf8AG11rc8jnk1uDiubhEyGSSTNvh4NcQ94z8ybCyEBEb
	7cQLuac+4BJWiSbSFJgKCouzFY1fSrc=
X-Envelope-To: 00107082@163.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 30 Jun 2024 15:52:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Wang <00107082@163.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add accumulated call counter for memory allocation
 profiling
Message-ID: <baku3uqaneue53rr7uixlio4hvfgig4kcox3h45y3ijvigwait@sfsxp2pcftqr>
References: <20240617153250.9079-1-00107082@163.com>
 <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 30, 2024 at 12:33:14PM GMT, Suren Baghdasaryan wrote:
> On Mon, Jun 17, 2024 at 8:33 AM David Wang <00107082@163.com> wrote:
> >
> > Accumulated call counter can be used to evaluate rate
> > of memory allocation via delta(counters)/delta(time).
> > This metrics can help analysis performance behaviours,
> > e.g. tuning cache size, etc.
> 
> Sorry for the delay, David.
> IIUC with this counter you can identify the number of allocations ever
> made from a specific code location. Could you please clarify the usage
> a bit more? Is the goal to see which locations are the most active and
> the rate at which allocations are made there? How will that
> information be used?
> I'm a bit cautious here because each counter will take more space and
> use some additional cpu cycles.
> Thanks,
> Suren.

Maybe behind another kconfig option?

