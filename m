Return-Path: <linux-kernel+bounces-229096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31819916AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DF41C22F23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC0158D86;
	Tue, 25 Jun 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pzp7kdEo"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122A16C6A7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326756; cv=none; b=imw3KQVmYrD5MYfy9rzRQb2COor23gzR9txE2lWhe3LWS2am55AFqA6c4mvC2N9PUje02dZmI8qK/A4v8gr3QYCxYwu2nqkuvh4C2g/z8jaqj8P7U/432LoCDJ/7Mfgo6XfGW7wvCA+Tu1s0XfzB/gehtlAV5HX/5OP+5oqMTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326756; c=relaxed/simple;
	bh=o60NL0y4kdkl14kVKvkvPLdOiFxwautjpZ7z8SqSjMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWmFLG5+JKAOLrf9htUSJPOUznM/jkSIJpadkBQLqDiB916+elTEziCAnxR7Cy9hQfMhkGBIkezhOZc6WOglHgJFImtaXKqZrPMen8a2ap3U+PE5E+7o1euTkSU9+ppjWMFNegcuURLvitd7sCrxYyeCQxrMX/zEvGK9FaY9IOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pzp7kdEo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79c084476bdso58749585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719326754; x=1719931554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbesqe0NiKN35nq9bee6ToUTPU5oW+SwrtUIxCrFjME=;
        b=Pzp7kdEoJOwxXtNj8ulrXq+iR5/UhMDVv0kZHr5l9EQWcsf5bc8SAKfsilOk+wbCvo
         8FJYP2/QoskfkK9KA9ApMfPpu1bVb3hcsxYojFgjrjgJzFQ3gznzhv8O8BM3KgrfLnHW
         yDEsPFyZPYgYVWA39LrgZFNdp3nPG3Y+hlvuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326754; x=1719931554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbesqe0NiKN35nq9bee6ToUTPU5oW+SwrtUIxCrFjME=;
        b=TqfRdQLBqA6IOKd+QZYotBLAXex+TCaVv+R8ZTW+sYlZuI9N2w3VTU0+QUv4/WOQi6
         zkRRpjf9BAb21kALI7sBlYhnBjDbmX/EAeraOpqZy/ltvxLXb++qGafnFUeyiknWtK1I
         8LVWOqaJix+8wgQuPk3javpTOR9bda4c1PPZaQmIFFUlRi8WERwODxtVG1Ci+BF7gD6v
         Cvv7ux+O+rlgfsZXL2lWCuoJNMPGlkAmr5p8kFoOTnRZ6vQu66R6vfRhUpJfzg/7CVOE
         iRKpjbyJbEd9QXBfBHGTX2Lsd3sBgE1U1impKceABMiIkD3LYUyrHA5BzDebbmy6Wi9y
         Js1A==
X-Gm-Message-State: AOJu0YwEmAvebZtO769XoyKK4HZ8GSh8hvG9rSvEZKjogj9asQVtdoz1
	q+HiXUBLEtzLJmRZmOIUQK+WDGQSEzF8I5RIvSNrSC8gRrTyortyJFpUo8Nq5w==
X-Google-Smtp-Source: AGHT+IFs2C6xwmZvkrVy/YrdeusmGi6yMJZtCqprPRHvw/7uR6VTQyKPbJhiyiLeGMT1fNT2Sld2fQ==
X-Received: by 2002:a05:622a:3d4:b0:440:f5d7:f475 with SMTP id d75a77b69052e-444d91c33ddmr86017331cf.39.1719326753618;
        Tue, 25 Jun 2024 07:45:53 -0700 (PDT)
Received: from [192.168.1.26] ([98.97.116.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b6741esm55489261cf.27.2024.06.25.07.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:45:53 -0700 (PDT)
Message-ID: <8193d6d2-5322-4a9a-82ed-50ac24dd3525@broadcom.com>
Date: Tue, 25 Jun 2024 07:45:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Alex James <alex.james@broadcom.com>
References: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
 <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My test environment was screwed up during the last version of the 
patchset. I was using a kernel which was built previously and didn't pay 
attention to commit hash suffix in `uname -r`.
Human mistake, apologize for that.

Alex found it while doing TDX testing on x86/vmware on tip.

Do you want me to resubmit the patchset to do not brake a git bisect?

On 6/25/24 1:47 AM, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 01:33:48AM -0700, Alexey Makhalov wrote:
>> Caller of vmware_hypercall_slow() can pass NULL into *out1,
>> *out2,... *out5. It will lead to a NULL pointer dereference.
>>
>> Check a pointer for NULL before assigning a value.
> 
> I queue your patches and *now* you find this?!
> 
> How did you test them in the first place and why was this scenario missed?
> 
> Geez.
> 

