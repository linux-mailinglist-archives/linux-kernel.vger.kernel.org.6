Return-Path: <linux-kernel+bounces-315128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A0F96BE50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BE2859A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC61DA2E0;
	Wed,  4 Sep 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8ntN9/x"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F41D9D70
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456114; cv=none; b=M5PiXChz6VO/ry8A/uZCa3FdjfzRI0aQbf6sgdmhZ1EgcR4jSz/sqN4z3r6oUHWWy5YE7o3egzW+lgp4iox6sBdmrYAcAlUSYPCdHAK3eWJ4BoeL1FV7bh6lgE26op/64L3I/e3CDg1WUvrQWENZ52FsH23RGkUt5hGNyGK9hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456114; c=relaxed/simple;
	bh=zVRgdL9dPuZyikd1MiBzEK2m6JOLGqFkwfEjTl5rHus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdYo0QmohdnPEhbSqEybhlIxkks/KdvWIK/qWI0/cUrqfzQeTMRKrWCt8wjpRD34oA/oSx/cJqCh0eDNJoaoYJ8NBqv0jnH+yDlNDqrEbx7diQkqtESCQgkPu3MpI7nOXa1VkPHCiw08Cx1zJrPsN+0+cQudxbShIBcyX5Yq8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8ntN9/x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fee6435a34so48241545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456109; x=1726060909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd2ZYCNG0SqbW6OjTbIGTZ++FMQuVNRn0puOuY80IA4=;
        b=T8ntN9/xdqdkUWeLRDFLuGcAIISLQfZSemLC+mI+pKy1wz43RkhH+24j7k8qkboyKY
         rNaFiNOEVEO1f2WgzMqZYM7HHBW4aeaQHOV3Hi/pPx+1Ek1wMEAMUoUZH3D25n7hBdjy
         eeyHEruXoLxO+ML6brzkWsq76Uc+dAfjyU/W01ZG7cpjaYFPYpYC7M/jsKEMAxA2jUDl
         4zSLl4+mneaScF7xr7HyCrb9+hEdyBHF7zq+xJ6HD3IbZ3z53X35sxj8HcPZ7J1aVCRR
         ryKDrwCJllyPMlOQYYHwne9VGZSBcbDLFAAM3gdDd7pwIL/q0P9LHrPEmxtse4/+TdYi
         S0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456109; x=1726060909;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd2ZYCNG0SqbW6OjTbIGTZ++FMQuVNRn0puOuY80IA4=;
        b=nSsWANyrkvwV4fmhI7x8JyHMY7jiUSxBPMZjbNIdXMjO8z8ZNrjO+7A4//9bhLz9pd
         V/icSV/aQeVJ+x27sXwBcgD3SsTyL7h53VGQ3Bdnf/IahftjQEK8pYD+KS/vN0ltPK8Y
         HuAnOMUbi175312BNSmGZeKl2oifDow6MjL5+1LhBmqyNMJVFIPdjcXxG9oIOn90ZYGC
         Jqa4nZFJWzteuI83WJ8tsjlMbVTibtPs9MpGYCcWRIaXYHcdgK6hc28FaVifOpLrNiWy
         21fxoOLF65JgzTj+ZGo7g621Y5LwyBFKwUzgrchoaegSLbiCA4R04XyuauUH4zXib6+x
         A2jw==
X-Gm-Message-State: AOJu0YwgA8MN7RNtdCR4C6y4rdiQZ+9S4VsdYatna1n+G/Dc1PYN4+U2
	ltZ1+75798O7ZzfITwn74/0vzBXoTqmztyACbgfrKklDVCQ9w2UaOYN2Y8GdTEG+CacxXn7Hjis
	Y09k=
X-Google-Smtp-Source: AGHT+IHNpwkCP+QEkYIrMc7mghHUBa8dyZ0ef4WmVGXl0vpaZbDnwcxB6gw+kSB/ilBIMALmK26aeQ==
X-Received: by 2002:a17:903:234e:b0:206:94f5:c312 with SMTP id d9443c01a7336-20699af10a7mr74145445ad.28.1725456108954;
        Wed, 04 Sep 2024 06:21:48 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:e912:6904:dd5a:7f0d:ac77? ([2804:1b3:a7c3:e912:6904:dd5a:7f0d:ac77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912bf3sm13555005ad.24.2024.09.04.06.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:21:48 -0700 (PDT)
Message-ID: <45fbd9a2-78f7-4697-b3f7-b26b72f4a795@linaro.org>
Date: Wed, 4 Sep 2024 10:21:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Profiling of vdso_test_random
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Xi Ruoyao <xry111@xry111.site>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <30e9575c-a53e-4e17-bbbd-7127798efb05@csgroup.eu>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <30e9575c-a53e-4e17-bbbd-7127798efb05@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/24 08:41, Christophe Leroy wrote:
> Hi,
> 
> I'm done a 'perf record' on vdso_test_random reduced to vdso test only, and I get the following function usage profile.
> 
> Do you see the same type of percentage on your platforms ?
> 
> I would have expected most of the time to be spent in __arch_chacha20_blocks_nostack() but that's in fact not the case.
> 
> # Samples: 61K of event 'task-clock:ppp'
> # Event count (approx.): 15463500000
> #
> # Overhead  Command          Shared Object        Symbol
> # ........  ...............  ................... ....................................
> #
>     57.74%  vdso_test_getra  [vdso]               [.] __c_kernel_getrandom
>     22.49%  vdso_test_getra  [vdso]               [.] __arch_chacha20_blocks_nostack
>     10.80%  vdso_test_getra  vdso_test_getrandom  [.] test_vdso_getrandom
>      8.89%  vdso_test_getra  [vdso]               [.] __kernel_getrandom
>      0.01%  vdso_test_getra  [kernel.kallsyms]    [k] finish_task_switch.isra.0
> 

After tinkering with vDSO build parameters (I had to remove the '-Bsymbolic'
and 'objdump -S') to get perf show the symbols I see on aarch64 with a reduced
vdso_test_random:

$ perf record ./vdso_test_getrandom bench-single
$ perf report
[...]
# Samples: 305  of event 'cycles:P'
# Event count (approx.): 5583551
#
# Overhead  Command          Shared Object        Symbol
# ........  ...............  ...................  .........................................
#
    44.27%  vdso_test_getra  [vdso]               [.] __arch_chacha20_blocks_nostack
    21.16%  vdso_test_getra  [vdso]               [.] __kernel_getrandom
     6.19%  vdso_test_getra  [kernel.kallsyms]    [k] task_mm_cid_work
     3.14%  vdso_test_getra  [kernel.kallsyms]    [k] perf_iterate_ctx
     2.96%  vdso_test_getra  vdso_test_getrandom  [.] test_vdso_getrandom
     2.48%  vdso_test_getra  [kernel.kallsyms]    [k] __memcg_slab_free_hook
     2.28%  vdso_test_getra  [kernel.kallsyms]    [k] next_uptodate_folio
     2.05%  vdso_test_getra  [kernel.kallsyms]    [k] _raw_spin_unlock_irq

It is what I would expect, so I am not sure why might be different on powerpc.

