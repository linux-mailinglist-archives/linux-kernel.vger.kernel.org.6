Return-Path: <linux-kernel+bounces-196358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D38D5AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C22283FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653A7FBDA;
	Fri, 31 May 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dbvd2kHF"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E627AD59
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137836; cv=none; b=TB13IEV209TlP4bu9ta7Kv/pSe8K93P9EyOTP8msZhM51gwL0kh2t7VfNmOnOrK7IODrgtgZbnlaLD/VqPsIAjSkBSf/IFH5tLMUTivLzbEtnMvVIjR17MBITjZp05Q2DqcZWvRZWJmivI/UpgjqtHqvXMuPNByf8lXtx7AVSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137836; c=relaxed/simple;
	bh=iTlnbU1rl+5ZTBkkWR0zu+TUVYCwvWt6+ALadeJVDyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJS2YYj1kTMtxcPMGpq3D9rR+enLPkCUsuj4MVnoTlWybEwY8zfI+WLI/qzyu4WwbuiGLMr2E78UjqEBXoeOk4oD/NeUmvacL1ec0fSExIoF5EB/vyuCiq1vGGluFDisBht8XMJ5YzirTWHRxViE7TuhI7khT5hGPdQeRgY8qUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dbvd2kHF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e964acff1aso17106111fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717137832; x=1717742632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMiq15SmhHqHIQjJm9pUJ6aH+pnQZBtgLiLte82fH8E=;
        b=dbvd2kHFn70l4zFZdepSIkbXWb4OOpcp/FAMjq1jdnYY3cPkscKHrk7D4SOtxE4FpJ
         fKZ2k52ECjjzH6gw1UZB0iqMXhE6FOHujEgRWiANADkl0Nu7F3e4fYgHMdo1R+Q0uTNm
         n/tXGp4ze7nlQoHi/kJttM2xXX+QCpPIQs9eH/bFE9YJsC6kfmFfrxRd2B+iX3qqmBA+
         iyr3l4c1ZSdnm/mr7Vkqm5N5L1+8+amjJuWiYWEDA7tB5cSkIjPUzsHsVdZv7Jxz9iN1
         RM8Bp4j3MI6Yf6uEVTIWoeeBttr4d1UNL78oQOVB2Dhf6kbrGim+o2OHWc2c3hgikku4
         SusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137832; x=1717742632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMiq15SmhHqHIQjJm9pUJ6aH+pnQZBtgLiLte82fH8E=;
        b=XlQoBGdb6YfYXngzpUOJoNw1py84Lp+ZVWI583g9Ypcukxi96AKSHpRLTMvF2hiVfW
         /lzAZgiHokprvezIkBosmXsU+igiRQp5bQf3/AecToVjz9UuvejWzqsIXooNtGUpXKb3
         3e7wXGBlxZTHhj2d2xQpbKjKqTLckkHnVFyUd8S35MB6BvVNszZsWS88tZDQMKrDrnQi
         fEtILk5Pzpjl0wCwvwMimWHbdH4UVFf5xV3V2GK9mVSew7yu+zamMix1OYZe6qGk33OL
         oEdOmX3tiCRDM49qElbtGPCReZn42YRjyc2D/+mhNzS1ElkD28siJHV/nJP/71XZfdIS
         ruBw==
X-Forwarded-Encrypted: i=1; AJvYcCVaoDsze8gAL+ACQ1agskr65Xwq2aDHTLPhHPPpy505SCXE46nonji0l9PkP1HVEGBwcYVx257SqXxr0lx26mZ8aXB/NanGtRyseIty
X-Gm-Message-State: AOJu0Yws64rHnsxhLgqoBHvCUZVjDryO3TOcx8aPaLeASvyvNkBG6YQH
	39s/ht4J0rpM5ptUqYOZdY9gm0nYzeXjOjVzVcUwJKABFwgEiV505rq0x+noQEY=
X-Google-Smtp-Source: AGHT+IGlj/rDGIF5KJU8pZOw+FyOP+EzXkNiG7PGjV92PN3ciJjdFWhnjCSEr75gphiPw/9vmM+q5g==
X-Received: by 2002:a2e:8415:0:b0:2ea:814b:f578 with SMTP id 38308e7fff4ca-2ea950fdc71mr6721401fa.6.1717137832314;
        Thu, 30 May 2024 23:43:52 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:bb8b:418e:c4fc:b349? ([2a10:bac0:b000:5de0:bb8b:418e:c4fc:b349])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c4388sm1121324f8f.14.2024.05.30.23.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 23:43:52 -0700 (PDT)
Message-ID: <d143cc4c-8f8e-48e5-87f1-dded3272433a@suse.com>
Date: Fri, 31 May 2024 09:43:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Remove export of mxcsr_feature_mask
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
References: <20240530192751.172597-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240530192751.172597-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.05.24 г. 22:27 ч., Chang S. Bae wrote:
> The variable was previously referenced in KVM code but is no longer used.
> Don't export it.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

FWIW the usage of this variable got removed in ea4d6938d4c0 ("x86/fpu: 
Replace KVMs home brewed FPU copy from user")

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

