Return-Path: <linux-kernel+bounces-262591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8893C919
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49674284297
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EA13AA2A;
	Thu, 25 Jul 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qmGKGFbu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAA137C35
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936831; cv=none; b=n1q5g4AkY7bkMcUqhlW2c8zHxqWEkHhJw8C6cmd8jizaeTkxYq1l1aLJ5o76YGw+4rAgOlE79LH63jqSOv7OBsJXxQS+cmV5eZydf2sXY4sEACaKu6ofhz6guldAbffkEcKNzQDOx/W9T+WHqA9FWxP6ecTak959w5jQ8IwTqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936831; c=relaxed/simple;
	bh=BU5Wxb6NLkscTs38oI32XkDXG45HkzUFyAf6EuMsgFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ij+L+1OVG/q7lyApJvGmw49FJVUSvG8ix5AtaF8KJkCOZIiC2WfGvXjTN/5tfhDkO1+PusyiQvg5KpK360jBT9mByQJIyXL4T9SI+G3OSN3tGXEo2wlTPFgIUHNS+VZOVLq79Ebr+rT4i86q2PlwRlB3j7CaDawg1CpGx0/ff80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qmGKGFbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AE6C32786;
	Thu, 25 Jul 2024 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721936831;
	bh=BU5Wxb6NLkscTs38oI32XkDXG45HkzUFyAf6EuMsgFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qmGKGFbu0Sr2xjlkH0IBl8lKX6jHJq4jAj0394aZ01rrGZ1fL1RVHm5wZB+opohrv
	 shpYoKjYxJBvYKBM229NXGRIOiBrd5pb/FucJopcf0K9JwWFqil/PxDdM+VRq0hhLC
	 q11ga5PefTHJLb8E3LzNb8zyxRqwa8iUYeobL0tU=
Date: Thu, 25 Jul 2024 12:47:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shivank Garg <shivankg@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <vbabka@suse.cz>,
 <hillf.zj@alibaba-inc.com>, <mgorman@techsingularity.net>,
 <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/vmstat: Fix placement of per-node stats in
 /proc/zoneinfo
Message-Id: <20240725124710.76206c2c9baa27b8463b825d@linux-foundation.org>
In-Reply-To: <20240725105626.824-1-shivankg@amd.com>
References: <20240725105626.824-1-shivankg@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:26:26 +0530 Shivank Garg <shivankg@amd.com> wrote:

> The per-node stats in /proc/zoneinfo output are incorrectly inserted
> between the first populated zone title and its specific stats. This
> creates confusion while reading or parsing its output.

I pity anyone who has to write a parser for that mess.

> This patch relocates the per-node stats at the beginning for each node,
> followed by the individual zone statistics. This fix results in a clearer
> and more consistent output format.

> Fixes: e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file")

It's been this way since 2016?  Surely there's a risk of breaking
existing userspace parsers?



