Return-Path: <linux-kernel+bounces-404052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66E9C3E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC361C20E23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A019B3EE;
	Mon, 11 Nov 2024 12:38:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E0139578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328682; cv=none; b=eAHAf/tVehIazAOJtUCxp61fG6X729WnEMT6+bOxN7GQxZH/RWHD4OskzozbXiSQznYsn0BbsxNmHhCMFkdb0YK3+nUdGP8JeP9U+o49iEN2E50gjOGM2w3AC1jFhv4khVZXWwXo4iegjgGHCjPVAWU5j+TGCORWFcjbmb9ot88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328682; c=relaxed/simple;
	bh=Pta5Vk0xiyZy9XOL/JeY8IfKaulwL616tyjQn3snYR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dDOuhJr7//YNG/K/xxGpQegQz9/4N3lrYhxthwK/t4G5nCBbZNzZdT6YDK6OYjFzAzyo+i5TanPlRbwld9/uqW4ByJatdHkgMIjG+bgLtwY2XItxp2LA0kkXSdirQDNfOsjWrgCfqIR2W/bg+aZ15pNnW0/P8B5VCzqav3lNqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A6E1CE0;
	Mon, 11 Nov 2024 04:38:30 -0800 (PST)
Received: from [10.1.36.17] (e127648.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EADF03F6A8;
	Mon, 11 Nov 2024 04:37:58 -0800 (PST)
Message-ID: <a491e879-364c-4b57-aa69-28608d8af4f0@arm.com>
Date: Mon, 11 Nov 2024 12:37:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] tick-sched: Keep tick on if hrtimer is due imminently
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-3-joel@joelfernandes.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241108174839.1016424-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 17:48, Joel Fernandes (Google) wrote:
> In highres mode, the kernel only considers timer wheel events when
> considering whether to keep the tick on (via get_next_interrupt()).
> 
> This seems odd because it consider several other reasons to keep the
> tick on. Further, turning off the tick does not help because once idle
> exit happens due to that imminent hrtimer interrupt, the tick hrtimer
> interrupt is requeued. That means more hrtimer rbtree operations for not
> much benefit.
> 
> Ideally we should not have to do anything because the cpuidle governor
> should not try to the stop the tick because it knows about this
> situation, but apparently it still does try to stop the tick.

Any details on this? Which governor?

