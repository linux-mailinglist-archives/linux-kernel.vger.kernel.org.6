Return-Path: <linux-kernel+bounces-189892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD3E8CF692
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC821C20DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC113A242;
	Sun, 26 May 2024 22:53:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC62535A4
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716763980; cv=none; b=A+WuoxNKaGCnOXaTqZ16AcqlypFiEXNbBb/cD8Fjf9xygDChnT8PW5QUawOcL3SmdPjAChE+m9/rmZfxlUM4Ky0pSxiNs+tEmO0qQJeB2dRkvndYKh1fd/4q8LTUCXkXofFJbDMWUUTcKsPzB92dg8lBZl8EB3WMDG1Pu5OTSLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716763980; c=relaxed/simple;
	bh=EngjvVv8BMOk2WNYMsum5bWofAIg4FVPRgU35cNhc2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAMXuU5d7wmuzggwfM3VDuX+1kzKSr64kLotSHeBbTc3szjRyWkI4s+KoX3Gzm3JK/fi6IGl/N4QVSGpvALqBYtQbpQd3TzhNjCvrpf2Oq+mIJYwa982Vd59ROBFET5rKSqkKoHGAGF3mgkcjsVdnxFZp8JQgVZCwnMAalKU7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2664339;
	Sun, 26 May 2024 15:53:21 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BEEB3F641;
	Sun, 26 May 2024 15:52:55 -0700 (PDT)
Message-ID: <1f8c50f2-6530-49bd-9b41-744437078100@arm.com>
Date: Mon, 27 May 2024 00:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/6] sched/uclamp: Simplify uclamp_eff_value()
To: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <6209eda0b134ad7a0be8855ffdd7b4c747fb8048.1715082714.git.hongyan.xia2@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <6209eda0b134ad7a0be8855ffdd7b4c747fb8048.1715082714.git.hongyan.xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 14:50, Hongyan Xia wrote:

[...]

> +static inline unsigned long uclamp_eff_value(struct task_struct *p,
> +					     enum uclamp_id clamp_id)
> +{
> +	if (uclamp_is_used() && p->uclamp[clamp_id].active)
> +		return p->uclamp[clamp_id].value;
> +
> +	if (clamp_id == UCLAMP_MIN)
> +		return 0;
> +
> +	return SCHED_CAPACITY_SCALE;

Why not keep using 'return uclamp_none(clamp_id)'  here?

[...]

