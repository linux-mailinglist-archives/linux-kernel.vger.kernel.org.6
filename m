Return-Path: <linux-kernel+bounces-316711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A596D2FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06721F24BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA09198830;
	Thu,  5 Sep 2024 09:20:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8A372
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528053; cv=none; b=CuPYo2+1IQlgTpMnucm0pxORiDar6ydt4suWC0EJi8+kK8anZjxVOjkagCkgQkbmzoq0Gwg53Nt7QiXsQX9H0XTg5/Dda/IMdTZIgzKXCS5IE2Nbx2Q7a6QbNDkHi4OQJJViplyypdwCkZm4kgryfVsCjca0CILQxCE4qbR3+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528053; c=relaxed/simple;
	bh=+3eLWdFOhSWPzl6tbC8DcJS2T/Td9/PM5sBtbNXXRos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFlw7rMFFOxxaMKc4ZMpudkEA+IjiQO5W65hlxTib6ayBsinRF/qy+/JKaj6PzXHHXfVa4VUKOpeIadDFHM0LrU1ygFDlTgYl+tb+JNkb+KNrTO1/66KaxzvYuCBPpASqa1aCTSrvSqsnsjf6a60JWF4W1cRf2Kad14YRm+PqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42110FEC;
	Thu,  5 Sep 2024 02:21:18 -0700 (PDT)
Received: from [10.57.86.69] (unknown [10.57.86.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57C943F73F;
	Thu,  5 Sep 2024 02:20:49 -0700 (PDT)
Message-ID: <e2b7e637-3977-4c06-9a95-88fc53bf4d82@arm.com>
Date: Thu, 5 Sep 2024 10:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] energy model: Add a get previous state function
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, mingo@redhat.com,
 mgorman@suse.de, peterz@infradead.org, dietmar.eggemann@arm.com,
 bsegall@google.com, vschneid@redhat.com, rostedt@goodmis.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-3-vincent.guittot@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240830130309.2141697-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 8/30/24 14:03, Vincent Guittot wrote:
> Instead of parsing all EM table everytime, add a function to get the
> previous state.
> 
> Will be used in the scheduler feec() function.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/energy_model.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1ff52020cf75..ea8ea7e031c0 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -207,6 +207,24 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
>   	return nr_perf_states - 1;
>   }
>   
> +static inline int
> +em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
> +			  int idx, unsigned long pd_flags)
> +{
> +	struct em_perf_state *ps;
> +	int i;
> +
> +	for (i = idx - 1; i >= 0; i--) {
> +		ps = &table[i];
> +		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> +		    ps->flags & EM_PERF_STATE_INEFFICIENT)
> +			continue;
> +		return i;
> +	}

Would you mind to add a comment on top of that for loop?
Or maybe a bit more detail in the patch header what would you like to
find (e.g. 1st efficient OPP which is lower).

It's looking for a first OPP (don't forget it's ascending 'table') which
is lower or equal to the 'idx' state.

If uclamp_max is set and that OPP is inefficient, don't we choose
a higher OPP which is efficient?

I'm not against this function.

BTW, I wonder if this design is still valid with the uclamp_max.

Regards,
Lukasz

