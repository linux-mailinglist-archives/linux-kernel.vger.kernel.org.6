Return-Path: <linux-kernel+bounces-216883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F091D90A809
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FAB27E61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDB1862AE;
	Mon, 17 Jun 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLbjfx8h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A1256A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611313; cv=none; b=G83KEAbTokcSoiMMaxBYDsADWEvdM1WNuT2aN/5ZV2Q1NkTUWliPTtKXTI8/rfSwOqVep41OjOL81zPPuNnNiSNxawNTxnTM5bQBjj779fdB7ojkdTnsdKft4ub0ZnkHj90nKcl7ZncQFzEH2Vh3+m4l2UoLLvbpJhUKQ+AKpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611313; c=relaxed/simple;
	bh=i5r8YuAigRBJHSLNZDtf/saMfQpMK9rQ7hxG4bpcKiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVrUaovHTHuIqSJH3ElvOth1cJjYBH3rBKEaK8khcaYiaEcuAIVMA5mPNb+JXZFoCPt5LtZze6u7CN7r2TQWdv+7gAZT6QHg2yImYgkZ62g0dnU3Yu82zWjBFLLDpcdUbxh1yZFquwvuSqRATIa7O7dZ7vFG0IYbqvKlb8r6nbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLbjfx8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718611310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IgTxPmNGiZIKbJVJ0jw/LH1jBY1RMimEyv/rUqf+UzQ=;
	b=iLbjfx8hsNuuWB6VStweeRRcVTVTHhhbcrG9U0tFWsS42qa/jbbf536aB6KlYPoC0fuPeT
	JJHChOrFlxETnBgJKmJ2q6keDvyhLLGPSuvtOV/FVFqcYilSCMsx+jk+uEF7t+HiPJI0en
	gShxiwIJe2lx6E1MGG29aPmOhLBcJIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-UhL26zRDMKuboorpHgXjcg-1; Mon, 17 Jun 2024 04:01:48 -0400
X-MC-Unique: UhL26zRDMKuboorpHgXjcg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f358e59so2087022f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718611307; x=1719216107;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgTxPmNGiZIKbJVJ0jw/LH1jBY1RMimEyv/rUqf+UzQ=;
        b=PKiyPTSb9Ft59BJAT8028qaYg0ZVVSVa2hnIP+mqNdqEXkSyg0r2BpDqU0Unum0I0s
         4LqetM8agjZJqxPjtYfnSWiTR1ZtvkoOfuSR+OPizI3NFcXTzSlHZkGwfdXoYiJT8W8m
         MSnEDxTkvhpVyBS++K16dqqyexnyyavP48I7NCVCzqVIrMkdr0qK9iU4IYcqGNfTFwvO
         HrNckdOCxh1oI2lLU817cxycwrwwQlc0K+UZJT222JcS6J5xydhBAU2PPsJFBkRddNx1
         IaL4KlQp6hBQUrnK8UqQzWxGJ2DWNykwWBrhWPiuoxwKtDHktwOfCC1HjCkdqj1cWsKf
         Efzg==
X-Forwarded-Encrypted: i=1; AJvYcCX19Qp5SKaEmWTMOsN5NQxLvR13cwYmaHl6UQNXZj6JFXuzFicTVO/gKP0L1Vo7Xu+NIrAHJXCp8a0Mfu3g8gwaqTu7Ztil1kwMGOFG
X-Gm-Message-State: AOJu0Yx5cXzI7PnoSgYZDjf/DDf83YJo0tppZ2x7MpHIib1SWvDMivIK
	xP1YKf/po3hNpY3YwWA3L41EL3BFE81uKRPcyUahhhGBbIRH2Y/AcELIzV1QOKdbofYAF3q40yE
	pjGUO24B7urqvSb1oouPsFvSYroIJSLghYop1cBh9vcK+2SucRnACGmrRanh4Dw==
X-Received: by 2002:a5d:6312:0:b0:360:7039:cd27 with SMTP id ffacd0b85a97d-3607a4863b8mr8423769f8f.0.1718611306982;
        Mon, 17 Jun 2024 01:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhKJjVysZr+CVxJtK6vdoRu7o7uLuHh2GTKMOK++A4E0n0xe3NdbJSg/OlMQ4aKP0WZp275A==
X-Received: by 2002:a5d:6312:0:b0:360:7039:cd27 with SMTP id ffacd0b85a97d-3607a4863b8mr8423731f8f.0.1718611306446;
        Mon, 17 Jun 2024 01:01:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609a892324sm694287f8f.6.2024.06.17.01.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 01:01:45 -0700 (PDT)
Message-ID: <3f5ad53c-f473-469a-a834-afb9b069cb13@redhat.com>
Date: Mon, 17 Jun 2024 10:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm:fix test_prctl_fork_exec return failure
To: aigourensheng <shechenglong001@gmail.com>, akpm@linux-foundation.org
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240617052934.5834-1-shechenglong001@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240617052934.5834-1-shechenglong001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.24 07:29, aigourensheng wrote:
> after calling fork() in the test_prctl_fork_exec() function,
> the global variable ksm_full_scans_fd is initialized to 0
> in the child process upon entering the main function
> of ./ksm_functional_tests.
> In the function call chain test_child_ksm() ->
> __mmap_and_merge_range -> ksm_merge-> ksm_get_full_scans,
> start_scans = ksm_get_full_scans() will return an error.
> Therefore, the value of ksm_full_scans_fd needs to be
> initialized before calling test_child_ksm in the child process.
> 
> Signed-off-by: aigourensheng <shechenglong001@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


