Return-Path: <linux-kernel+bounces-351312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E7990F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C011D1C22407
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56431FBCAE;
	Fri,  4 Oct 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2bm3SsiF"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521AE1ADFE1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069170; cv=none; b=QXG4Nc9PkOifcmohaGmmymqA7i2xDbvy0WDdw4EmW8eSZLPBNJ1Zg/X9lKOYup64Uf2U7c3bBbgG+PB1ehakZPjY0qhyXVfhw31a38aG/HTcJod5TANMD1JgOATAvg1n+ILyQjVGsUM47KziembllhDuFDkEu8MmR+me14WDa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069170; c=relaxed/simple;
	bh=/M1ZjTmABJbh4MwRycydLtqA1KHIs1Qq3zaDKYdOVWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUPMuNVQ3q6m8+3uKYn4T7194MADzaT50pVQeZqpKstsl0BOozLAFp3ua5CJgf7gSzJLctKdKRVqbsgoVBbbZVnIoriNYo1NbGr59pLA+M6QfjzneEt4qAOd3QeK6ATnwMixPVyP4/5z2ZYDw0WjIcpeOwCfY8ubXUHFdEEFb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2bm3SsiF; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e77c6ed92bso1412506eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728069165; x=1728673965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8E/75Ze8LWS+oGsxT4cv2r0PKvnIHpyk0O4+fHPIOA=;
        b=2bm3SsiFnil/TerVkPL27FcNu6kn2S1Ba4V6iJbhm8KA/CTWn9lEZcGpbCy0UvAaad
         RNa9st+PTK+vVm7kYOQZL2hMsHGPhRnio9VLBIcXTTraC84aWu8JyJ1CapFKXpGVijqR
         U0YaRXesOhWPflYv/eMLu38nhh+xlQAIsUX3Nrqxw4ZLvnUJj7XEq058j7JSXmjvCJrs
         cIiM+5pYTygTqHyGyuH8ON6k5sQe+MscV3W13u3YAR8/BoYwkz+2uVzZqleDRbV16HSv
         L2SsEdfr0PuCl0I+S+fbB9PbyVjoDIYpoIaadqyUMxvmjB3pQaEM3ca5M5bqGkgiAqXD
         er4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069165; x=1728673965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8E/75Ze8LWS+oGsxT4cv2r0PKvnIHpyk0O4+fHPIOA=;
        b=fjJ4lHNTdwhS9xIHPrjHy1cvQpaeDdukrErwzW8K6UfZp2OXfFPq5WfqL2TWEZ4e0Z
         1nhcpM6VlRstT/3ZtmYMJXh8HJQaFU1e/pfgIiY4e6u5x4Bdq70xqVs5l5HTBeQwNZgZ
         nkvUMwX3kt9dxRash3vgBG5CXNtkxSds4e60kqKACweYnO3lCTGBLtgZxEhi+sP9jYlG
         eCMwZssCiFihvoINQEzw3GIsR65IXdrt96ZuvyndRcgjm2ZZb+crdE4kfg8BFEJwO30u
         +CxDaJ9IBdjj8Ehh+8ghIINA4N767Vczu970SG5nWt+nHcPc2DcQaErWPfqsZM7rJ7Kn
         Ax1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX/ik91kiRin6Z7gFiHmVZIen8e7HT5V0Vw2UTG9bepeTLCD6cgRNR8FV5HB22OxNS+mgJ3gSymVpX9ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYF4sq96+Ow9QpinJFhXftSi37Ucc4EzhCjQOvbsGjS8LwHVA9
	WSOYc5gJW8luQ4j0EGtYJiBv1qPMc03celhSYe5RC1QQRsb9EsokuPQvuYtmVCA=
X-Google-Smtp-Source: AGHT+IFauv67y1n9nX22pC/6NEemDgp2UqXjYbZLEVPwPcm0WP0X9oCZ9xusSoOdx+Ve9A4mDrHazg==
X-Received: by 2002:a05:6870:3913:b0:278:14bf:2fb with SMTP id 586e51a60fabf-287c228bee8mr2703044fac.34.1728069165246;
        Fri, 04 Oct 2024 12:12:45 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155674599dsm137977a34.9.2024.10.04.12.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:12:44 -0700 (PDT)
Message-ID: <0ce9a516-dee5-49cd-bb74-62166c16e644@baylibre.com>
Date: Fri, 4 Oct 2024 14:12:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: core: make iio_device_claim_direct_mode()
 __must_check
To: Dan Williams <dan.j.williams@intel.com>, kernel test robot
 <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002-iio-must-check-claim-direct-v1-1-ab94ce728731@baylibre.com>
 <202410040721.upAHwZJm-lkp@intel.com>
 <67002c9cdb068_10a0a294a7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <67002c9cdb068_10a0a294a7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 12:57 PM, Dan Williams wrote:
> kernel test robot wrote:
>> Hi David,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-core-make-iio_device_claim_direct_mode-__must_check/20241002-233644
>> base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
>> patch link:    https://lore.kernel.org/r/20241002-iio-must-check-claim-direct-v1-1-ab94ce728731%40baylibre.com
>> patch subject: [PATCH] iio: core: make iio_device_claim_direct_mode() __must_check
> [..]
>>>> include/linux/iio/iio.h:669:50: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
>>      669 | DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
> 
> So I think this points to the fact that iio_device_claim_direct_mode()
> should not be using DEFINE_GUARD() in the first instance. I think
> iio_claim_direct() really wants to be using DEFINE_CLASS() directly.
> Skip usage of DEFINE_GUARD() which I now see is unable to interoperate
> with a __must_check locking function.
> 
> Perhaps the new class can be something like:
> 
>     DEFINE_GUARD_EXCL_COND()
> 
> ...which creates a guard that is exclusively conditional and has no
> unconditional flavor. However, maybe that only lives in iio unless and
> until another user arrives.

Hmm... I see what you mean. All other conditional guards (e.g.
mutex_trylock) have an unconditional counterpart (mutex_lock)
that is used with DEFINE_GUARD.



