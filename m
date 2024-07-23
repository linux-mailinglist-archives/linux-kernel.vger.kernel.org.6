Return-Path: <linux-kernel+bounces-259721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91209939BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA9C1C2182B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8B14B94F;
	Tue, 23 Jul 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="QNRzbf+W"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9213C672
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721184; cv=none; b=akbk66tAmNNcfGvx1ddqc7E51SrW0aEXTZs1L9pLd+qj++vA2C1D1vaZbc9s+wY2lre7wXKdlCcY5Z7X1fDLjhxD9Ix5vqSeBjQ1o/rJgIqX3SnWvHHQVQPiZ453q5ob0gmQgP27XYRTw01slXXXHM2GYfmIxtYJXbj9MLIxMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721184; c=relaxed/simple;
	bh=NqwN1ivfdf//amCWTxGUXKkycY0A2iJVKDOTkVP/SIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+v2EavIETe4sWiXi6zR2YeeEFe668cQ1qKlKATgwyK87mVf9psuZ7qr2gSdUYNuC6xAphuCOIzwKYEf+zkJMGlXxGjVAHYyJMADGCve9iAibYoRY5sI0iw5FtQPsJJNzB25kZvxRBRwk3B2cOLHh3vfcqdqAnPkIMJbDCxTU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=QNRzbf+W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427db004e36so23817335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1721721179; x=1722325979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSxFHfDFN+MiVLSyULOWbYjXLDYVoJ0fH1mNtWGCU7I=;
        b=QNRzbf+Wvhb2Ejqc/k0VIJvDzGJ5e87p18UpsSU7bS/sRE3He2VpXY+1cBOhoN8yKy
         cqNuxVgACP+e6hF+UgRev6c3ZkhPgaZmNXySZGK86Tg++2vtvHLzu6gxNaLLFXcNpx71
         IzKCPvEzzJt1KT8rxfS6PlnDJESGh2MIbwv29fYmhPlMtzxvvr9nEdTWzF6bqKw8fmYo
         GjJJ6g41z18WQM88G2DsZPavFFWuwU3RFxdRZeLpot1enRJldJUtWfKKoSRYoJpn5UoC
         Mp9cfzOpmPzZG71UGP5PlGLsqhSl6KaGOEMUiXzRs5SIjq7hIEkm3zePGJnaaaS8x7IS
         s0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721179; x=1722325979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSxFHfDFN+MiVLSyULOWbYjXLDYVoJ0fH1mNtWGCU7I=;
        b=e2EVL3/05UmfuvKz2YY8t4GesaXxhmjkZk2ywf6CpAqtSoptK2x3BMvKrqXatW1QxN
         R6fy0JqLjApMzZ3MVRdondTQUir/Ry8KhtvrGZgLyW6LKAeS7jI3XRek7uul70p9fGrh
         +JxB3ThqMA0oRm4Xpk3IGcBbmOEH1JWhVKhGC0j78JAVXr5tsOsd9c4tBhlgjOopvKD+
         WN+RmYLmXaS611NRGCDOUlvmn7LuppJh4iUBJJAleQ3JbGAenBXV0mxxwstCQFmwl2sl
         eWbrkABdxxXe0LFgVUBUWg1R6xV9CbEJ/7qCbPHWKiQ+RcQ62M6DuaGa7y1zcIr6J2g9
         16RA==
X-Forwarded-Encrypted: i=1; AJvYcCUN/0l0GiqOP5Io6bup7g2gtaISjwuV1MzluAaUxuVX7is9fCzinLhDVG565BDUOa/ESc5Ru3XJw2dEs/b+Yu9rfqhM+ID5BXizVkfT
X-Gm-Message-State: AOJu0YxpSWw3ULUiQnbp2vYPqEWWE3GyD1w/NSZteG3sZN9fIO4lT07E
	NcujeqYsKq4IvlsCeQg9nwhl5znGqXGJZOuV2D3PqO42+kPJmE0XUqmDJa+fRmZQwTc4FybVCwz
	N
X-Google-Smtp-Source: AGHT+IE9Cvh25hfaQz/Gp/ZdOfzixVQt2BVNg/bV++7oWQiR7JI21E3NokuVP3ZF00d3/6mUezvKcQ==
X-Received: by 2002:a05:600c:3c94:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427dc56476amr60061065e9.31.1721721179228;
        Tue, 23 Jul 2024 00:52:59 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a7218esm181620735e9.25.2024.07.23.00.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 00:52:58 -0700 (PDT)
Message-ID: <4cd8c6c7-bd15-4663-bb0b-815904560c90@ursulin.net>
Date: Tue, 23 Jul 2024 08:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/i915/pmu: Drop is_igp()
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-5-lucas.demarchi@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240722210648.80892-5-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/07/2024 22:06, Lucas De Marchi wrote:
> There's no reason to hardcode checking for integrated graphics on a
> specific pci slot. That information is already available per platform an
> can be checked with IS_DGFX().

Hmm probably reason was this, added is_igp:

commit 05488673a4d41383f9dd537f298e525e6b00fb93
Author:     Tvrtko Ursulin <tursulin@ursulin.net>
AuthorDate: Wed Oct 16 10:38:02 2019 +0100
Commit:     Tvrtko Ursulin <tursulin@ursulin.net>
CommitDate: Thu Oct 17 10:50:47 2019 +0100

     drm/i915/pmu: Support multiple GPUs

Added IS_DGFX:

commit dc90fe3fd219c7693617ba09a9467e4aadc2e039
Author:     José Roberto de Souza <jose.souza@intel.com>
AuthorDate: Thu Oct 24 12:51:19 2019 -0700
Commit:     Lucas De Marchi <lucas.demarchi@intel.com>
CommitDate: Fri Oct 25 13:53:51 2019 -0700

     drm/i915: Add is_dgfx to device info

So innocently arrived just a bit before.

Regards,

Tvrtko

> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 3a8bd11b87e7..b5d14dd318e4 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1235,17 +1235,6 @@ static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
>   	cpuhp_state_remove_instance(cpuhp_slot, &pmu->cpuhp.node);
>   }
>   
> -static bool is_igp(struct drm_i915_private *i915)
> -{
> -	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> -
> -	/* IGP is 0000:00:02.0 */
> -	return pci_domain_nr(pdev->bus) == 0 &&
> -	       pdev->bus->number == 0 &&
> -	       PCI_SLOT(pdev->devfn) == 2 &&
> -	       PCI_FUNC(pdev->devfn) == 0;
> -}
> -
>   void i915_pmu_register(struct drm_i915_private *i915)
>   {
>   	struct i915_pmu *pmu = &i915->pmu;
> @@ -1269,7 +1258,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	pmu->cpuhp.cpu = -1;
>   	init_rc6(pmu);
>   
> -	if (!is_igp(i915)) {
> +	if (IS_DGFX(i915)) {
>   		pmu->name = kasprintf(GFP_KERNEL,
>   				      "i915_%s",
>   				      dev_name(i915->drm.dev));
> @@ -1323,7 +1312,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	pmu->base.event_init = NULL;
>   	free_event_attributes(pmu);
>   err_name:
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>   		kfree(pmu->name);
>   err:
>   	drm_notice(&i915->drm, "Failed to register PMU!\n");
> @@ -1351,7 +1340,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>   	perf_pmu_unregister(&pmu->base);
>   	pmu->base.event_init = NULL;
>   	kfree(pmu->base.attr_groups);
> -	if (!is_igp(i915))
> +	if (IS_DGFX(i915))
>   		kfree(pmu->name);
>   	free_event_attributes(pmu);
>   }

