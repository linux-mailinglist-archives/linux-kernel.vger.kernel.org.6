Return-Path: <linux-kernel+bounces-279687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5B294C07C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A39B2275F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5F18EFC8;
	Thu,  8 Aug 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LH5SDsud"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4118C91F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129403; cv=none; b=QhMSXGAPRQ2LOVM3+dBGiiqtr0LSxm14yntZepItjh7XkrONbbckkrpQYISPw1NSXvnZMJ+jvjkJEbK8q1ChbJnmha/zU9lc0zVaN7nRbzOJOqVFhgU7alk/tTKalcNhjHvFuQw+uedzSitolXmlS+8focMWXtLvGILQ9SHtHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129403; c=relaxed/simple;
	bh=WS0hmxs4wqoVn+pvjksWhglffIW/p3RGndvw2TY45kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq7tO+v18CDJ4Dlf+tW3xfdqdswu/BYP64OtQVEbzJr/8Pz9ScvNnt/BxGOTZuYIaEwae9P/rLPWg1c3PrXN15AfdLhVEy3G1t59ePZe4bY8bu+0JwNSv78fiRoVCzCOa9iAjC1XIpEKxBRV9dgACmjyL5ZNqdc+22vZOeryOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LH5SDsud; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aada2358fso342501166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723129400; x=1723734200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sQ9PGsBk8Eff8tQCepimSQrw1AMgb/HWeK4EkA3Pzo=;
        b=LH5SDsudB1S+mxgBKkCsq1xP+r+rDkOZY8EfPQeRgEDvZijQ1IdbOwpmzRDM5CX7uB
         RmP1VaXiPumZxzxU1yCfRBfzsuT0IPLtbT8Hfrn3XOeB0J9xF+/nhdK8FUeBg5SR74C+
         7XSayqx1TSmVEwFBd88P3Va8vXWZa4hjjbsPClkQ82COT1GpEWGB+/mj7gtGrnjhA9Kq
         dsEpbUi//sSORB1oO/9DQK83MXiqMypkhnhMvEEJs1bwOSs4QL2/Zx7Ooc3aVoMX/piG
         JwUAMioGhySAgXQVvrf/4Wp+qdOtmYENIg5rOt7Y2g/jmJNP7+WS+XW44xT8d7yuXFL5
         X9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129400; x=1723734200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sQ9PGsBk8Eff8tQCepimSQrw1AMgb/HWeK4EkA3Pzo=;
        b=TgoYO9s9DcbPaVd4ljufJLOJEawZHiaEb+pkS1NMwiyqbyyJ/roXZtN1VY+ZekCov8
         dT6+eA+yDGSpff3fUV1Upm9hDAyjY6KICj3o8InCHt2uOBBNkB0PdUiVVswRbE7SIWTC
         FaH3ZEp9EN9HOr1Rwx8qOmCCaoQZiKcCM9lCVxo7Kphxrwmq6StZoxlg6gdf8geE9vSq
         GiqB9+Fv6Iup69LYfjTDU6wKHpYsRXbhwqAQAk5rRfxiRf22V1bTjCXfH9hJT7nQKkLa
         4WF5+FAJli6c4dAJ7+2BtYcdeps2ZMbDJHwMp1eLQrMmLAZ2BLIwD+b1PQ5gUt5zXGsC
         ZyWA==
X-Forwarded-Encrypted: i=1; AJvYcCV5xMgviFKeF7+ebFpKablHc7TjtL/iR3ZpwStVSAG6ubkpM2Zg9fzFlZvg4cyBfu1kQP02kkvnYo7+Bw+nFgiBTKrzWhzwMjyg7Nxr
X-Gm-Message-State: AOJu0YxV5Gg5QQLKZlBwk0ndB9+3SF7rqjfY+11xZ0XuostiKXo8E5y8
	IGjsTjSVMlB9E0nSPt3khmJtp0IScIV0X+hxwBo+dULGd70ZxJwCRX7DuKWWSg==
X-Google-Smtp-Source: AGHT+IHbEGRrZx7dXgPgKuL89cLMS/JVbDOgFN8ZoeVQ8hco5CBysjwbSaKRxrQHuJA5E7MwiIyOFw==
X-Received: by 2002:a17:907:1b23:b0:a7d:895b:fd with SMTP id a640c23a62f3a-a8091ec5ef8mr203185766b.6.1723129399785;
        Thu, 08 Aug 2024 08:03:19 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7fe2fsm755051466b.178.2024.08.08.08.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:03:19 -0700 (PDT)
Message-ID: <5de3bdbc-74a7-4722-be12-eacea6bebbdf@suse.com>
Date: Thu, 8 Aug 2024 17:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240807104110.18117-1-jgross@suse.com>
 <20240807104110.18117-6-jgross@suse.com>
 <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
 <5389eb85-873c-4ae2-a916-6fdd0e5b496d@suse.com>
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
In-Reply-To: <5389eb85-873c-4ae2-a916-6fdd0e5b496d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.08.2024 16:42, Jürgen Groß wrote:
> On 07.08.24 14:05, Jan Beulich wrote:
>> Even without that I wonder in how far tools (kexec?) may be misguided by
>> relocating non-RAM memory ranges. Even more so when stuff traditionally
>> living below the 4G boundary suddenly moves far beyond that.
> 
> I don't think kexec is working in PV mode.

I wasn't thinking of in-Dom0 kexec, but about host one. Iirc the kexec tool
will collect information it needs from various data sources, not uniformly
everything from the hypervisor. But I may be wrong with this.

Jan


