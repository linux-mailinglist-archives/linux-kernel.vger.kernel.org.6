Return-Path: <linux-kernel+bounces-560885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C88A60A97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB86619C01D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4819C56D;
	Fri, 14 Mar 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P2ySH5Da"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923518F2DF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939010; cv=none; b=qUwQc3Uouy8+IqPa0vj3+MxIy8FvNM1tTAy9qGDtFN4uNtsQdxhLAc7kiUKFZvoHajAuDpgpuC51LgVafBWD5Z7WUGTbWoR+Ref9EluSeYeQ+7xz9beyXgFwdjmiREfdf6XKZATebANi3PsWMq6J4vtchSU43NZ+D6kgqLCPxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939010; c=relaxed/simple;
	bh=a4biZe/NktbyNi7gIBYlnSsu7ddxq3Lr8yuoDJvpvGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0RhJm6EOfSIKFaoMNC5U/LH91jVJiHZd3VUMGF3UAV5b+3V5hhT6gTz+ySnargUy1gQZDKh8XrAN6jDY2PH5CuXo6cRW7zUE+78v4T2j7LQjDALLhngN5JzQmVaI+KM3QswBYt0Fp+08WTjtDeeI0kA+I3iz5xbx0JNV/PyyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P2ySH5Da; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso11976685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741939007; x=1742543807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bgEsfHeBFPeJi0hxMNQ4yEJiKFLfCp9eIavJSADyNWg=;
        b=P2ySH5DaIaXXx0vrgmpHWGokIMd5y7PXWRwR5JSTRzEdyVspejgUV2zun1T2JrrGxU
         yizvHNYGltkiCoWsad8YGzMnbJVaNKx8FuTSHQnibj+dh8pikn6fZgZGXz1bc7XXrVDu
         460yXnG24qhgPEqVzBkoW1WqW3zbbr9p8fitw1cB0TTRkSZLWDi1ndkRbVBwqA1Va0+Z
         MBm0NPouGDjZ8NfQRllknTDbfWvX4a1jjunITztLeUcACUOvrOqS44Xva2Cs8fUAOcAF
         6kSsuoHiVl8WZ66msuT8mWepQaVoDVryHUzBmrpH98jJfgLxrTnL6mT9N8eZy8UAn1Le
         QRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939007; x=1742543807;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgEsfHeBFPeJi0hxMNQ4yEJiKFLfCp9eIavJSADyNWg=;
        b=ek9nX43Pwl5s2QHtCTfYcVnvOwf2i3yN8gfuKC04OSSWtY0svpNBrRTN31smgjLtBu
         APdUg7KAtvEnCk8RD2DBxPUimC8eu9xdumzdJl/j+2AjvUuKDD9MVRnQivVo1TIa/Ibg
         JcPlfP9MfdJoy9vekO/8j1bE91ZIFOAcYDT+hUfxEKpNAfJeH5Qjt2AHUXa5P7TObGLd
         17Fw1OUUH7Kv8v7utxljPFCoFZnj4JlIghFGOPb+ovZSnVAAMmKfIovGgUy65qqHMTXS
         s2T1GG9CKtmjUXIiJV+cHTP6SQegx4cEun37FFV8i+VHmKB9MAwaTin8mZ3gzwPzY344
         dBWg==
X-Gm-Message-State: AOJu0Yx2TSfbvJEujJs42fl84m+NmCYaaVKEV7W5vT+tiM4mf+N8NVbu
	nlAqL7x6rRQUO8OkvVHJU/rK2ot31daYqB6jS8IbdCMUdjXEFMRSVXbff00SWpgb/dHG2nasNBE
	=
X-Gm-Gg: ASbGncsDS4xznFIP1ZqyLaYojLhSl8uru45VBAv9pmK0GoTN0kA+FJlvx9Sk3cxxELc
	JrhgNJzC6kRFhOrK+G+Ru88nbAFJxUAhVqSlNeXSJNfxjU2t8hhrBlWTZggafkSCfehj76b0OeI
	zPHnGIsBvccjFGkaMsum9u86JXFibUpfRTANmqVYnY7eQMe+VcghU0gAu5AFKpdsPBsy0oR9hTg
	Wb7ZDBEgRlKfF9JB+4EVl3/an9i+tjzYVGblU+SLBtfKM1lqcezLRV1oMz7yMGzLO4adYrITvn5
	o8F6X3ai78zqoljM8xF7npYVIsXJfVuXwYVuYvS0buN4COqLUbEokWmaEyDiG+TuIH2L9J0AG6K
	Imv6fh4Dk305eHjXAVmDr2k+mKNN7Iw==
X-Google-Smtp-Source: AGHT+IHCRJ8yku+aiK1MLKgBl8Ma/i3SDKxWMlVhehRY7rRX6C3j6J1LUBZGwQ1PjiyRQr0DHCzlRQ==
X-Received: by 2002:a05:6000:1ac8:b0:391:4bfd:6d5 with SMTP id ffacd0b85a97d-397200b0d41mr1323318f8f.52.1741939006896;
        Fri, 14 Mar 2025 00:56:46 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf12sm8688915e9.12.2025.03.14.00.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 00:56:46 -0700 (PDT)
Message-ID: <d66254fc-79a3-45cf-8195-ea0b49bb28a0@suse.com>
Date: Fri, 14 Mar 2025 08:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
To: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <945716d2-4dd4-4d38-b732-41ab8b27c5ee@suse.com>
 <20250217202943.p57k76tpwpx7aw6q@jpoimboe>
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
In-Reply-To: <20250217202943.p57k76tpwpx7aw6q@jpoimboe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.02.2025 21:29, Josh Poimboeuf wrote:
> On Mon, Feb 17, 2025 at 05:40:09PM +0100, Jan Beulich wrote:
>> __ADDRESSABLE_ASM_STR() is where the necessary stringification happens.
>> As long as "sym" doesn't contain any odd characters, no quoting is
>> required for its use with .quad / .long. In fact the quotation gets in
>> the way with gas 2.25; it's only from 2.26 onwards that quoted symbols
>> are half-way properly supported.
>>
>> However, assembly being different from C anyway, drop
>> __ADDRESSABLE_ASM_STR() and its helper macro altogether. A simple
>> .global directive will suffice to get the symbol "declared", i.e. into
>> the symbol table. While there also stop open-coding STATIC_CALL_TRAMP()
>> and STATIC_CALL_KEY().
>>
>> Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Cc: stable@vger.kernel.org
>> ---
>> v2: Drop constructs instead of fixing them. Use STATIC_CALL_KEY().
>> ---
>> Whether the "ADDRESSABLE" in __ADDRESSABLE_xen_hypercall is still
>> meaningful to keep I'm uncertain about. The situation, as said, is quite
>> different in assembly, compared to C's requirements.
> 
> The .global still makes it "addressable", so IMO it's named
> appropriately.
> 
> Thanks!
> 
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Since this is addressing a (mild) regression, I wonder if this could still
make 6.14?

Jan

