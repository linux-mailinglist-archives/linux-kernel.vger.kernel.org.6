Return-Path: <linux-kernel+bounces-412903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFA9D10ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5494F282D94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1D19884B;
	Mon, 18 Nov 2024 12:49:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD526AD0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934181; cv=none; b=FIfhrsytG1XYwO95Fxw8Tlzjpw/g//HLP6HPFS0E6VWMM0ny8JI5ECJcx/7hjvaPIliq67fnDAP3O+ponaY3r3nNynCpgqDQJPdFZ1BuEAdFCyvqxIl2+qlgyn/FYXTpGbsWxGx4YApXb95U4dON+NkHCNjpNdfUZoGir13oWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934181; c=relaxed/simple;
	bh=Lo7SJ31GOrsY08PYIGHe2YaEwIko41JUlk19Vy0UzU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CSRzUdr9PxerMkpdKxP+7w4a3lBOB3PpwcE56lA7cJATlmBkoEVYqRtWPhwgbNMbHSAZKmBwqeiepSZXCZg/0e0ef0y3DQDwhz1OgvF9aqOvfG2GVLnS13ZCOKWeQIJEZc9Yv2ZTZX4ra3J73lZ7Ss/mTlgpZ5gDMBeofmBDnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312BA1682;
	Mon, 18 Nov 2024 04:50:07 -0800 (PST)
Received: from [10.1.31.25] (e127648.arm.com [10.1.31.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5DB03F5A1;
	Mon, 18 Nov 2024 04:49:35 -0800 (PST)
Message-ID: <b044f0b1-7b17-41e0-98a2-0247e6212062@arm.com>
Date: Mon, 18 Nov 2024 12:49:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCHv2] cpufreq/schedutil: Only bind threads if needed
From: Christian Loehle <christian.loehle@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <633c2972-1171-4caa-8825-758d094c0ce9@arm.com>
Content-Language: en-US
In-Reply-To: <633c2972-1171-4caa-8825-758d094c0ce9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 14:55, Christian Loehle wrote:
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> ---

Gentle ping on this.

Regards,
Christian


