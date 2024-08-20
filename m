Return-Path: <linux-kernel+bounces-293546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC2958122
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA7928621E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75A18A6DB;
	Tue, 20 Aug 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MpCV73mw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0D18A6C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143221; cv=none; b=j/+w1Ino8Tzs1zfCLf4UElm/2jDRXk5Tgt/aVL8uEILDs0jcuHLQ7HFIDlBszEFjgabMvczDSZ5sB1iYPyxMUgT1i/uSdZyUrnH69Yg3zyGwOjYP6CT4JRm63iPHKaZ9cdR0sfYDQD9RzMIH/rHdGjIPPwhL8DTfVdwbvBkhdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143221; c=relaxed/simple;
	bh=IK7VIPRCbNbf4HxweezMTdztzKI9ALuZcNdPkExTHPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iibGGSBd9evjwLs5FKIk5yCWIPobtpqTCdw41booQwqz0MN+djO1ut8FGH8fZi7E8ZMW3lkZrJqdMwUJ6qDwYC7T7hjzu2+yT8q/T2XMQjgfS3AHABVCIAJquHVSqdukAZcwCn7XrKoewzF75Dopugn+2GdplK9NJV2qRApzG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MpCV73mw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86464934e3so84907166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724143218; x=1724748018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UIDfxVhY7fnottjWLC7fDlRPFUbWqgVBnlZeCyzgUPg=;
        b=MpCV73mwzEL01E4rMTlkJ+f8swxyfbQ9TWCLTHtYseqfdqdu8okRwO9x9b92Mh918z
         12ayEl75VRDPobcZPskfkhjuPvMNp3z1Qq1AgTc81icx9yVtllCW7Rxz+M1Cf/Z/sEeG
         YYbpjuFIwEnGOz2Ts4w4RG6B/9L11IAnJkg0fxNrJinoeTlIOtJOXZcbM1KAIDEWYeVs
         E2IM2vvD9wrBrs/Ad/v10nb/H+Rd1LzC4ynZhZ9JqpbYBMy0Sc8OhWrf7iU0JK6Q4y1h
         8+OgTWsbwSojANvT1wFxz396T1Y6/zeVvSPgu9peE3NtY+jGeV2VU4b/fhWLzWO+cbfA
         Mr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143218; x=1724748018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIDfxVhY7fnottjWLC7fDlRPFUbWqgVBnlZeCyzgUPg=;
        b=ljwJlN7tEIunFoBc62jFqPRfhCEzvE/FLjk3gbZ8+LIBsMQlm3keT0hO8iaG9XEExW
         R+BrzG6ZEv4WSGEXf6S4BVeRpki/rUJB7NSDundwuj5JqcDPTuhFeTPoNTw+938gN9hp
         Jb8rkiorT3yci85GUG52o8YFPWFPlmudkwnXRj5WdP+LVoTgZBBpKFvVP8JIj6J96T9u
         n/yPWaEIZZS9PJQa+V0PgmLLAcPGCgUMHdeb2yO77TmUOGYHONEerTBmL0QVRUCc5JNO
         Oi53vpdLacBKIEd/NiIALqfCmdxl+olEFWsDtApPe5s7B4Z72geL77N5zStLkTBIXoBb
         gBaw==
X-Forwarded-Encrypted: i=1; AJvYcCVIWtNIXJuIXbfwNnFjuWOfPnfkMcwiPwoZq7pDsIRNgAwvp27AKZFmr7UZJOsZOHmJPVreQvM6bUwh4lz5IBO+HEf81ZXqjUVwro4y
X-Gm-Message-State: AOJu0YxMebccgl/sKW5ZfDtyvFGJ3ZniFgHJBgJ+vAhjM3z8V/pkBvZQ
	3gLddm8tU3MTiE8aU3iW1WsCI59y8FB44rH+5wnU4YgvFK0BZeQKii1B/BP3+g==
X-Google-Smtp-Source: AGHT+IFKKwbAe4UsLI5P0/ECxxMtGDpjSBVELhqGsnY3Ji1MWH4EqctA+4Uw+oYqt73ir9MQOPbetg==
X-Received: by 2002:a17:907:7e93:b0:a7d:3f4b:fcaa with SMTP id a640c23a62f3a-a8392a38e65mr867605966b.67.1724143217855;
        Tue, 20 Aug 2024 01:40:17 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946538sm732780666b.151.2024.08.20.01.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:40:17 -0700 (PDT)
Message-ID: <e01257b4-e2b2-4b3c-84e7-9b4c17d97baf@suse.com>
Date: Tue, 20 Aug 2024 10:40:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] xen: move checks for e820 conflicts further up
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-4-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-4-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.08.2024 10:20, Juergen Gross wrote:
> Move the checks for e820 memory map conflicts using the
> xen_chk_is_e820_usable() helper further up in order to prepare
> resolving some of the possible conflicts by doing some e820 map
> modifications, which must happen before evaluating the RAM layout.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>



