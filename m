Return-Path: <linux-kernel+bounces-268710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18F94282B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC974B22E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3421A76A9;
	Wed, 31 Jul 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mN5v2c5q"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125391A71FE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411465; cv=none; b=spidGD+UKX2lG6yjk43nq87tgRkRm8GuDsxtNx7oPrmyZmS7iPXFK9q3pUDFNSL6hTghw+yIU3gtenCXtFYkr09ySmZ6rst/aSrsjNM5B6AY1DHzkRYN5yfmrvH7ChkQor2qtGI2kNL9qngFeTG5V2d01mVt0sSslWgfVKNTEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411465; c=relaxed/simple;
	bh=YXxZ5xgTPPldz607+hzEen57ZqJbno6jTm5v3EiEeD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPZjzyIBvPKH+20JEb7prCE27OovVM88Ue1seEXYX6RTeNNCiEprzxh0Yqw2yIdJ//npcE0YsUxfHKGjWNdsK/D9qUF1ExFzudo6iAqTvLBfhW43f6hg+ni8Jn/oFWU2V4g0DbH4NlFnNYlYZFnqv3Vs8Ju24RiQrba7J5bmKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mN5v2c5q; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-81f905eb19cso277516239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722411463; x=1723016263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzglC/byDhDvnFBWc6wZL41SNGknlqAMA7KmvbuJtb4=;
        b=mN5v2c5qb6M4c9Pb1+HNKXgTDeIalFcRLebR1WsAM/IcZwJQfEjBKut+o7j5q/6LQ5
         9ZUGEc1fXUr6RRqyLQO567N9fm43TjeQoKCoQoKF1B2hnDhTNfwLw3fKBEv8HlP+6A6B
         BhyAZxLJjvqKGqQ/b8ioArQtN7PWRtBKcIMYq4NRenWHyfs34MnKvX+zMUl/imCUnWqu
         BlOQ4q4iwCDwZYFUyo+WiTqPUARKrWD4gKE/hbNlOw7Z4v+oefe7OSjSXrWVyQne2MPG
         4c/F7XHnLVN6nb84KXLi9kj5FvZKMYAK8ed9GhByIdoJFrGkeaDFcM6qRsAPG0/hhzv+
         jDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411463; x=1723016263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzglC/byDhDvnFBWc6wZL41SNGknlqAMA7KmvbuJtb4=;
        b=HUaK+R/+vWqtkbDakqifHVb3dYWlKfFihx+NBKwoCOmFs5hzZLS+OIWGSGDCaKDgTp
         IH6hZhLRSf7n/z8dOebSHTxv1sDNE2VI1GVY33EkQnhaUAuql5pMjArGq4oDHcroZEGP
         L7dMmmxZY8NOZUpmFQUdE8PIUMA+ofNGSfobowLspFVvdkIsBDt3PF0d59QliFpv+g/H
         IpDIju5uEQ7PwRlTu/0WTSKcFg+8/Rgf153wfnU9t29L+qWMyftTMtRdIfWzmJd5eogC
         hLWIfiK0aLCUgh9cMmu+JslrXFj7KSpS7odo4CRNosCAMgc2SL5IZT1XVjDp/EMUqVsi
         Z79Q==
X-Forwarded-Encrypted: i=1; AJvYcCVssLgGwcFAfXR39MLRfcqDHQIQtkDW1HCzKtYBgKN/Thnfjf5IMsoiqAQ8Bkf6FUZrxEbN9ufXIETfa6uK0qtYjlbjjHfiw6LUGsyo
X-Gm-Message-State: AOJu0YzgROcp4bb8dRzAyBcMwDs2JartzJu2SuYYVS8ZWoiWCs1tXr4P
	mXc91RccYjKGaHrO1zOa5OoLAkLXVNQ74HzzNeqEUpAe8lfNpYXRlGW6e19bjB8=
X-Google-Smtp-Source: AGHT+IHF+FmD7RvwEBRIUXC9/YpswlEdr8n2P3czYAdfPAZ3IrYGybmYAj5wUY3xomuIwU5OEOAT3A==
X-Received: by 2002:a05:6602:340a:b0:7f6:84e7:bd35 with SMTP id ca18e2360f4ac-81f95beb9cfmr1526267239f.8.1722411463003;
        Wed, 31 Jul 2024 00:37:43 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f8ec67998sm322012439f.9.2024.07.31.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:37:42 -0700 (PDT)
Message-ID: <0fa3cf3d-48f6-405b-8b66-8935a629089e@sifive.com>
Date: Wed, 31 Jul 2024 02:37:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: riscv: Fix selecting counters in legacy mode
To: Shifrin Dmitry <dmitry.shifrin@syntacore.com>,
 linux-riscv@lists.infradead.org
Cc: atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, alexghiti@rivosinc.com
References: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 2024-07-29 7:58 AM, Shifrin Dmitry wrote:
> It is required to check event type before checking event config.
> Events with the different types can have the same config.
> This check is missed for legacy mode code
> 
> For such perf usage:
>     sysctl -w kernel.perf_user_access=2
>     perf stat -e cycles,L1-dcache-loads --
> driver will try to force both events to CYCLE counter.
> 
> This commit implements event type check before forcing
> events on the special counters.

It looks like pmu_sbi_event_mapped() and pmu_sbi_event_mapped() have a similar
bug where they do not check event->attr.type.

Regards,
Samuel

> 
> Signed-off-by: Shifrin Dmitry <dmitry.shifrin@syntacore.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 36d128ff166f..bf14ab282e11 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -416,7 +416,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  	 * but not in the user access mode as we want to use the other counters
>  	 * that support sampling/filtering.
>  	 */
> -	if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
> +	if ((hwc->flags & PERF_EVENT_FLAG_LEGACY) && (event->attr.type == PERF_TYPE_HARDWARE)) {
>  		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>  			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
>  			cmask = 1;


