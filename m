Return-Path: <linux-kernel+bounces-364183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF799CC70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E0D1F230F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721F1A76A5;
	Mon, 14 Oct 2024 14:12:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731224A24
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915139; cv=none; b=O4S+YE/qjNXuv4VjzaobyWVEn8YMvcU7LwMFOEWnEcb4iUq43DgN5gH+Fo3hnYFsyIWgvooQzvLea78Oh949t9J5pWoXht6hRijZ2npivfgVYxCU1silqXquL0gC0g9kdksfC6uGml2sEDoiX9cWLhxubb4b5ZLbWFABmIO4xPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915139; c=relaxed/simple;
	bh=bj2ikQsyXPdb0Vw6Xe5MRm8CMRb9rkN7VRzYXMlviLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kI0belwiqVIB5sdfMVH0jHYPAspDqdex/3rJ4B/jL4vzVG2xYochwhQC78tqkGN7oU54YuleYhtKp1F4X47bFV0mv9DhZDGMza25UE/EaFKglHMsWojPrGP4uXHGI7T3ynj2/8PiOYZspMYqsqEGbpGgeim8faqIKpXL2ry26Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E761007;
	Mon, 14 Oct 2024 07:12:46 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28CFC3F51B;
	Mon, 14 Oct 2024 07:12:16 -0700 (PDT)
Message-ID: <ce396f01-e10c-41ce-b3d8-19c626d68241@arm.com>
Date: Mon, 14 Oct 2024 15:12:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm-cmn: remove unused macro
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241012092411.2497-1-bajing@cmss.chinamobile.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241012092411.2497-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2024 10:24 am, Ba Jing wrote:
> By reading the code, I found the marco CMN_HNP_PMU_EVENT_SEL
> is never referenced in the code. Just remove it.

Hmm, perhaps I got a little carried away implementing Mark's 
recommendation in 88b63a82c84e ("perf/arm-cmn: Fix CCLA register 
offset"), and the HN-P/CCLA_RNI case could have been left as it was 
using CMN_HNP_PMU_EVENT_SEL. Either way, I think it's beneficial to keep 
both definitions next to each other, so that it's at least visible from 
the code alone (without having to resort to the CMN documentation) that 
the two node types do have equivalent offsets and that combined case is 
still not a bug.

Thanks,
Robin.

> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   drivers/perf/arm-cmn.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 397a46410f7c..37b62d0dcc06 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -79,7 +79,6 @@
>   
>   /* Some types are designed to coexist with another device in the same node */
>   #define CMN_CCLA_PMU_EVENT_SEL		0x008
> -#define CMN_HNP_PMU_EVENT_SEL		0x008
>   
>   /* DTMs live in the PMU space of XP registers */
>   #define CMN_DTM_WPn(n)			(0x1A0 + (n) * 0x18)

