Return-Path: <linux-kernel+bounces-222370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1AA91006E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207771F22498
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487B1802E;
	Thu, 20 Jun 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MhbA5S0U"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C61A3BC9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875980; cv=none; b=RmafxyW3rO8EbtWql8keYRM+cRQ3aH0nyY9MoOZfHdO4F5EgoHjXaT1wb6faNEFGQhxs27KLMOzhgcu3oXf3roqf+88+F5Od3/mWa7JyyZhOSRqmd/reCakbb9VHi+w8jmM2mGpJxuBWgOcsmqa9WK3l4Mh0xThyrQ9lBgaGhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875980; c=relaxed/simple;
	bh=hLSecVmYPQpDsQqgHQO+sFjfOM7c7GwYktsilKHtfJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGnZFklccF7fzfjb4zO/tqVLmV+WK4HboW5vybV1/uOXaNcWRzyHQcQcqGeyH+L+rN8nrTZ9BQQw7/YpII7gMpwAikzopZSjvd4kKRY0VpK/s1k2qRVv2bgxHMAsZadYGjwSsvxZBIuqwPUgmS8mDb+0xLEE6MQGqUSOcYvg6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MhbA5S0U; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso6995191fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718875976; x=1719480776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j6DH6kSEubD5FxstJVeVPeWtnIqQMdMOTzrYhkokE1A=;
        b=MhbA5S0U0H4BgDKN/PFMlm+Boohh6Ziea4Se4zSwg69tyJsPU7pxvosaGgQRrRdxcJ
         EQrhsBKCqnPJxZr55zFOV6nKkE3EBQOFUKMAJcg0sR7NbvcQRT9qObx0RIKSv6UWevVM
         P5yhMenFdRsEwqy+ouc+AmGL06PGLENAezZMV0mXECAjYrZrpWOxhQt20FB95tO4DP5r
         EZ7y+4UZU+v3kjMzsdByd5wfTtPmBWmI0ZXD6NLNEmI399iYwhUgvOBPxmic4AP22LBm
         7RO/hvIi8w5J6QJalIdMV737EUMk8F10c6i6pw+CFvA1hxXnReRwr7AWUUEP2AeP0p+A
         aoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875976; x=1719480776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6DH6kSEubD5FxstJVeVPeWtnIqQMdMOTzrYhkokE1A=;
        b=HjlkaLYhgQuo79zdy5SLixYAThDwBsbEgnixSyZapvNoa79hUJ1NAtYtQoSVBTS2Qq
         baXCEvtueSFeepcWfuEKUPZWc1DwCltw6tyJpZ/jwqa6BI7ZMAgmoqDWe1Gc3/fyuGnG
         iaKdBkgIrpOdKB0N35f5Fa2/4PinLDjtliukkhqqSNGE4u+FFhDDxwlZiEKOd9l+io+D
         LvLCGVTS4/JLGWxcPgIqh6ViuOwq8AqgZS2WadiJBiMp2F3wCKpj580RXcazFAw1eZev
         CV8O/sMedQbkv2QfQWmhJwiMASOlVwwZ9hrEz0VUbe8MGoc1e13DmjSokw4Unm33TN9m
         boLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTxniZHUbmHyKkw5Yqg7tJcFauTo8ErgLsYJMrZBmgYrD0CDqmfZFyivwGLqqNl3rpYXtzaojM6X45ejzNkj2OxopqVai3uDKO3nBK
X-Gm-Message-State: AOJu0Ywqu/pZcpyyaDGacCtQAXPL3mFQ9vZ/zNcv9pKjjYBqdDDYSw9Y
	Zq/+xOo+dR11oEFEnw9NNtUWgFpXe9uCNaPTk2YFbxk56Joe4gwfRVoqlulq9fm2mJYXKvqJdVE
	=
X-Google-Smtp-Source: AGHT+IEbC5qQajogR95Z0ode8BqDcoOQRyHxKKAIuPQD7+OVafU1ScduKvw/hYNvUOB+cFNlXw5Ymw==
X-Received: by 2002:a2e:860e:0:b0:2ec:1a6:7b01 with SMTP id 38308e7fff4ca-2ec3cfe89ddmr28651041fa.33.1718875975898;
        Thu, 20 Jun 2024 02:32:55 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f497a1sm132036505ad.283.2024.06.20.02.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 02:32:55 -0700 (PDT)
Message-ID: <92819ebe-8895-4c61-825d-4bd56aac38ad@suse.com>
Date: Thu, 20 Jun 2024 11:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-47573: xen/blkfront: harden blkfront against event
 channel storms
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 "security@xenproject.org" <security@xenproject.org>,
 Juergen Gross <jgross@suse.com>
References: <2024061911-CVE-2021-47573-5c43@gregkh>
 <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>
 <2024062034-pork-limes-2c4c@gregkh>
 <ac40bf5e-6537-4ef5-bac9-afbe512a9d70@suse.com>
 <2024062025-uncivil-sterile-03f7@gregkh>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <2024062025-uncivil-sterile-03f7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.06.2024 11:20, Greg Kroah-Hartman wrote:
> On Thu, Jun 20, 2024 at 10:46:10AM +0200, Jan Beulich wrote:
>> On 20.06.2024 10:18, Greg Kroah-Hartman wrote:
>>> Also, the XSA-391 announcement doesn't say anything about them either,
>>> is that intentional?
>>
>> If by announcement you mean the email sent out to xen-security-issues@lists.xen.org,
>> then the copy I'm looking at (v3, the only one having gone public afaict) clearly
>> lists the three CVEs.
> 
> I'm looking at:
> 	https://xenbits.xen.org/xsa/advisory-391.html
> and I don't see a git id anywhere, where do you see the v3 announcement
> saying that?

Hmm, okay, I then misunderstood your earlier reply: I was assuming you
were looking for the CVE numbers associated with the XSA, as I thought
that's what you need to know when deciding whether to issue one
yourself. No, we didn't ever mention commit IDs anywhere, except when
issuing XSAs after-the-fact (i.e. changes already having gone in earlier
on). I guess we need to see whether that's feasible to do for Linux XSAs
going forward. Yet then it may not be needed there, as we'd now ask you
for CVE numbers in such cases anyway?

Jan

> Also, the json file at:
> 	https://www.cve.org/CVERecord?id=CVE-2021-28711
> points to:
> 	https://xenbits.xenproject.org/xsa/advisory-391.txt
> Not to the html document, which is correct?
> 
> But to be fair, I'm not going to be able to search all links in all json
> files for all entries, so even if the 391 announcement did show the git
> ids for the changes, I would miss it.  All I can do is search the json
> repo for all CVEs.
> 
> thanks,
> 
> greg k-h


