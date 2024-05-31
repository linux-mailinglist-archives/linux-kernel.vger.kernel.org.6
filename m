Return-Path: <linux-kernel+bounces-196343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1FE8D5A77
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202662860A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F607F466;
	Fri, 31 May 2024 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xr+4Y/3n"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A97D07F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136517; cv=none; b=jj7AJICsqCIMznd/7ZU6lrIhyB5SF4DVJiAXUv8mPuoKsbdobXBw0F1jwDlRzuG0fhb1isn6w0n5rJm0sTD+SLX7rJrDxYzGdQRoln71YoRWioXPdF8DGsbxKHIgB6rGiWYLjkuaNyzACqA6/QbaVXx3rdP7VIIpG9am+oYXxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136517; c=relaxed/simple;
	bh=fFkZ8TAr6SU5Y0vnG4OgXcYwVOOp2klZ+zMv/VYv8to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ6nAccrhUTgiLUkb8HXoMRFNYe7du51zIof1MeMBAc/WFPS7nA1FFvAzZHvrO4sZDJ+Fs5LsgTAqGf5mLIgCn+oGIhB8uADJBCW92FMmshdwCaJWav4k77hnxfPLMs3cSyIyo+un6vgZekWupN4FFSu7MlIqvUuGritwBXhPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xr+4Y/3n; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5755fafa5a7so1931332a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717136514; x=1717741314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ6kKwyyFsGMHpdJmmwBKTWKasVE0feVJrpjcHhJyQM=;
        b=Xr+4Y/3nwQNnxxSNFmLt2IOBSvHwTSfbf+be7catm4DsdGhF1t6zNI9mSzoSacxCbu
         IIS0bXwxrnJI/EthtGrRkm2AGAP3JMMI5NFVp5XK0Q9EI9hmlBXRNBN41g0Hk77tzQqN
         ZBUvQamDb756nTOBtnTZfOc6FGW+JarKBL2D/dH18rwq978hkSmnjUT1n8D9ANysFHlo
         wp5yY3zXupXP0kLxy5qGlK3R2I1MOZjAyI3UBDWVnuD0ikwL4gHDVlMsaUrPW233EZ8U
         vIz2OQJ8zOsMFW94E1KB8d3cqv9FfeXVYhReqi1kYf0BznLJfXYUAMeu+8GjB0MVoLyN
         PPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717136514; x=1717741314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ6kKwyyFsGMHpdJmmwBKTWKasVE0feVJrpjcHhJyQM=;
        b=vu3rHbBijWk3cTaHaa1Gf9avLzEapxKOAMt3OVKx2yfmJiZs8xUbak3eSxkXUB4q2R
         +kpB00q49St1AVD1ei8BinqzVgzkukrixA2WL1xSlRQR4Q8HsksuTGn5vKeJmGBnGyTO
         Y0/ZIGtzTqc8PbdrVSTg3K8t8XYr2QcIyyPMpbp1n8aSsf8lgl1vO7QVELUWsv0kud42
         FTKqLwILy4Kw84hUJs2nH4reM+2PzoTNttdRU/RZ9nixeXYpJb2gBBYmWq1v++kKxRnm
         82GFHnb9bnvgDlgTg6oX+pZ9P8L7tmlJxtv9AyKdfvZ9C1EzGjF9RisFMxgml3CyCE47
         10bw==
X-Forwarded-Encrypted: i=1; AJvYcCV1aCjEc1dNMMybkjEvbyXgK3H7/WOWthBhSTsX4lR1+7Y995fYlyrq2fVyyABBntCRVGrIinr6fT62bOAkxEle2mto+IWb8L5g7v0G
X-Gm-Message-State: AOJu0YyqqNqgn5Mx9p+Ed5zAATuGiW52FgAB53wa+0OjLSnRL/FvR8fV
	+syO1kB97y4ouGBdrE1VWMRuZJ4McRsvnxEeGtOwigTkAYuHWOqaDaleOgZLhw==
X-Google-Smtp-Source: AGHT+IHo6mzlcPnlN26oAQajbmGI4v5vL4n994N6QbmUpFFYDDgojxmCs0eo+jCCcklf4F/FmyX+kw==
X-Received: by 2002:a17:906:7c8d:b0:a62:4b4d:5447 with SMTP id a640c23a62f3a-a6821b76639mr78203466b.62.1717136513767;
        Thu, 30 May 2024 23:21:53 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fb4dbsm51080366b.56.2024.05.30.23.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 23:21:53 -0700 (PDT)
Message-ID: <8d906c2a-8666-430c-aa41-2db6ec0088e5@suse.com>
Date: Fri, 31 May 2024 08:21:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/NUMA: don't pass MAX_NUMNODES to memblock_set_node()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>
References: <abadb736-a239-49e4-ab42-ace7acdd4278@suse.com>
 <e33ec69b-21e0-46e3-9b70-6d89548a145b@intel.com>
 <997fcbc7-4e75-4aa2-974c-15d984f02d02@suse.com>
 <bec94a1e-8c87-461a-a8db-1ea57385e745@intel.com>
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
In-Reply-To: <bec94a1e-8c87-461a-a8db-1ea57385e745@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.05.2024 18:08, Dave Hansen wrote:
> On 5/29/24 09:00, Jan Beulich wrote:
>>> In other words, it's not completely clear why ff6c3d81f2e8 introduced
>>> this problem.
>> It is my understanding that said change, by preventing the NUMA
>> configuration from being rejected, resulted in different code paths to
>> be taken. The observed crash was somewhat later than the "No NUMA
>> configuration found" etc messages. Thus I don't really see a connection
>> between said change not having had any MAX_NUMNODES check and it having
>> introduced the (only perceived?) regression.
> 
> So your system has a bad NUMA config.  If it's rejected, then all is
> merry.  Something goes and writes over the nids in all of the memblocks
> to point to 0 (probably).
> 
> If it _isn't_ rejected, then it leaves a memblock in place that points
> to MAX_NUMNODES.  That MAX_NUMNODES is a ticking time bomb for later.
> 
> So this patch doesn't actually revert the rejection behavior change in
> the Fixes: commit.  It just makes the rest of the code more tolerant to
> _not_ rejecting the NUMA config?

No, the NUMA config is now properly rejected again:

NUMA: no nodes coverage for 2041MB of 8185MB RAM
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000027fffffff]

Jan

