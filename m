Return-Path: <linux-kernel+bounces-316169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4496CC24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987B62890FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A4B661;
	Thu,  5 Sep 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FM7LPDXG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AADA9463
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498944; cv=none; b=eH0TK7YHtK2ohajB//dZ16Bv8FILBaTT3K5l3Yyma9qaUMPp1vdgjr3u+5scmjzLhLFRTQev4FSU/qRWyApl6kblg2DpIsPMuUPvYhaUFa99h+duIa2tGI69ZVhPWuD/ZvvnLdm3mt9d46DRpPA0iawkCk6hYymKQdACEaUxgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498944; c=relaxed/simple;
	bh=6fs2uhR2bK8qEvj+bOCFzAA4wSbevoeGQovZS7jGau4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nl7ELxsBg1Dwm+cwIXonJu5Kwq6EBL1Hxle5rX3Fa/ALXTty6eQqVJ7VNPoAC2o6ZQadj72+X+2eAvysWFIRuqe+fNM6QWSvhuJpBN1H+p+7DQdoPzFaiunMfD0Lf4CZlC2kuf7D8bbqN0/uHkhQgJsZ4+Kl806MdZsNFMG30U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FM7LPDXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD508C4CEC2;
	Thu,  5 Sep 2024 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725498944;
	bh=6fs2uhR2bK8qEvj+bOCFzAA4wSbevoeGQovZS7jGau4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FM7LPDXGo3+mIpdiRM7RMOVO+rQSob05rZyd1LmwtgUqeQkcdMIMmT3lNs766bu3i
	 VMW/2e8PYfDx2scbOm8yh9p2w8ZgZnm2OYJSuMUWTkPDFby+RHbDM8ZiEbGxkDVAMp
	 aFzOAL+fH+oE9WTvZnNoEMZPMiXBLNJt64grnTP0=
Date: Wed, 4 Sep 2024 18:15:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com,
 yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
 roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
 a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim
 interface
Message-Id: <20240904181543.02de2242490cf233c7879697@linux-foundation.org>
In-Reply-To: <nwutv6cuuyajmakiiznb3hoao6jfhrs2clpqi76xomqbc6yymg@n7inzwjcskhf>
References: <20240904162740.1043168-1-dave@stgolabs.net>
	<20240904131811.234e005307f249ef07670c20@linux-foundation.org>
	<nwutv6cuuyajmakiiznb3hoao6jfhrs2clpqi76xomqbc6yymg@n7inzwjcskhf>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 18:08:05 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 04 Sep 2024, Andrew Morton wrote:\n
> >On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> >> This adds support for allowing proactive reclaim in general on a
> >> NUMA system. A per-node interface extends support for beyond a
> >> memcg-specific interface, respecting the current semantics of
> >> memory.reclaim: respecting aging LRU and not supporting
> >> artificially triggering eviction on nodes belonging to non-bottom
> >> tiers.
> >>
> >> This patch allows userspace to do:
> >>
> >>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim
> >
> >One value per sysfs file is a rule.
> 
> I wasn't aware of it as a rule - is this documented somewhere?

Documentation/filesystems/sysfs.rst, line 62.  Also lots of gregkh
grumpygrams :)

> I ask because I see some others are using space-separated parameters, ie:
> 
> /sys/bus/usb/drivers/foo/new_id
> 
> ... or colons. What would be acceptable? echo "512M:10" > ... ?

Kinda cheating.  But the rule gets violated a lot.



