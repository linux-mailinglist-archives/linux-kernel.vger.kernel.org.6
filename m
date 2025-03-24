Return-Path: <linux-kernel+bounces-574113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FDA6E0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A5616F909
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02136263C75;
	Mon, 24 Mar 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXOjrb8u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C015E96
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837188; cv=none; b=NJlF7DBHM1CP5stoSn5kEPwoUkVjFpfQL+mD2HFpodAqg9dF0m1eeTCI2Y6Tn4lS+3oWzl0j/ZO5BFC4zBOJH+82bfBAEmhzN379P5fFjb0BBmuf0+4zvvVFoZtjmj5cKtCGr9clyyY+wHhVtbOLhQ9HoUmBh8GDqgKECIEPTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837188; c=relaxed/simple;
	bh=PxTSQJR/zd+m6rTehyE+LwNLaSBt8BP7YOp92sznOuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abm3npMDauQUJ7e/C6IHqC6jsxFcCTp383ny37G74bpw50G2Z2IXQ1kjG85ANURQSgJmiOOnrqiWHoZaoIIAlL7cZMlgshKdo0C4tTF+c4j152jDvHsPc2M4GzZu+vaQ+ZJSW2i5N7Paf5/9qAjEw7xa4jfp/uYkSle7w/sEddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXOjrb8u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742837187; x=1774373187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxTSQJR/zd+m6rTehyE+LwNLaSBt8BP7YOp92sznOuM=;
  b=NXOjrb8uyT2G2Opx+F6Sh32W5Wd2Ly6PJLKlSdOLeOhR8bUWTdJ1laRZ
   a6tE3f+YZjokejc/78mxzJUkEfMEbAMKu2w5wIlt5YFqUp5Md1ivHHbpu
   QSzm+mgvL4kqQyDib08691sfhFT/AhxdPXqUl/458mJGk4WFAPfyq55lA
   nYbZ6fHf24u9myM1gEtr/gJj8J2IKtUCUEdcjZrUgGZTauvbFHqsy3Qpd
   m3Cjki4dMSBZKpcP17CRr7GMN5lUxLZx/tI4Qsus4N7UaVIXcCNTsSICO
   ZK+EOUcSh90g+Eh7i3RIbgbBIOhkrOH0uWqvEKub4abBi6ingCnipJae3
   g==;
X-CSE-ConnectionGUID: VIqI3nK5QMCFP92asgIY4w==
X-CSE-MsgGUID: 5BcqWsbMRhO5dyMDJDN3kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43944825"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43944825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 10:26:27 -0700
X-CSE-ConnectionGUID: R27JcKqzTqSoMlCUaPBIGA==
X-CSE-MsgGUID: mhN3/9SpSbyYFsWE7JzFGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="129308397"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 10:26:26 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 08F6620B5736;
	Mon, 24 Mar 2025 10:26:24 -0700 (PDT)
Message-ID: <d084e81c-19eb-4424-9fa9-868b75786527@linux.intel.com>
Date: Mon, 24 Mar 2025 13:26:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/ds: Fix counter backwards of non-precise
 events counters-snapshotting
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
References: <20250204210514.4089680-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250204210514.4089680-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

The patch is to fix a counters-snapshotting backwards issue with
non-precise events in freq mode. Could you please pick it up as well?

Thanks,
Kan

On 2025-02-04 4:05 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The counter backwards may be observed in the PMI handler when
> counters-snapshotting some non-precise events in the freq mode.
> 
> For the non-precise events, it's possible the counters-snapshotting
> records a positive value for an overflowed PEBS event. Then the HW
> auto-reload mechanism reset the counter to 0 immediately. Because the
> pebs_event_reset is cleared in the freq mode, which doesn't set the
> PERF_X86_EVENT_AUTO_RELOAD.
> In the PMI handler, 0 will be read rather than the positive value
> recorded in the counters-snapshotting record.
> 
> The counters-snapshotting case has to be specially handled. Since the
> event value has been updated when processing the counters-snapshotting
> record, only needs to set the new period for the counter via
> x86_pmu_set_period().
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 46aaaeae0c8d..e8f808905871 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2377,8 +2377,25 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
>  			 */
>  			intel_pmu_save_and_restart_reload(event, count);
>  		}
> -	} else
> -		intel_pmu_save_and_restart(event);
> +	} else {
> +		/*
> +		 * For a non-precise event, it's possible the
> +		 * counters-snapshotting records a positive value for the
> +		 * overflowed event. Then the HW auto-reload mechanism
> +		 * reset the counter to 0 immediately, because the
> +		 * pebs_event_reset is cleared if the PERF_X86_EVENT_AUTO_RELOAD
> +		 * is not set. The counter backwards may be observed in a
> +		 * PMI handler.
> +		 *
> +		 * Since the event value has been updated when processing the
> +		 * counters-snapshotting record, only needs to set the new
> +		 * period for the counter.
> +		 */
> +		if (is_pebs_counter_event_group(event))
> +			static_call(x86_pmu_set_period)(event);
> +		else
> +			intel_pmu_save_and_restart(event);
> +	}
>  }
>  
>  static __always_inline void


