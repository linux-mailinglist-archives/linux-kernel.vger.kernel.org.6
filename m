Return-Path: <linux-kernel+bounces-277865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E794A774
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E95C1C22B87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912081E4EEB;
	Wed,  7 Aug 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OCoWrLkZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0C1CCB45
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032337; cv=none; b=HpYxoHLW+H+LgcDIDFPIuK0cMsYIlobS8E9uKfOND5igkxcdXd6bbYPi8Qf/aub2FRUWlIbijj0tsoD1FB9T86M2b5LBb53Zj+UKR9p7iMK5gQshPVOSaI2SdNGisz4cfty+HA55AhCz+NY+hFbZ8pxDHRfAkEIX6YnxjH6nm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032337; c=relaxed/simple;
	bh=8qpuw6iaBkGU3J7CNnHrjAqhISOUDAR+7ntkY/ZomV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/kgciUnC3Y2zA1y+5G9Y3CiwhAuVwbaJJ1tQMCjT40/Nw9gvmscNL6HKZcdAbOAOIuAnfQ98cPNMeQhpCv2T2QKj9AyCBW1lQ6ZBap0fn3R5KKGU9VDgieVnA+DPInW23bTPbfogSk33IZUi4zhSYyTMckgSBGblDLXVUUuHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OCoWrLkZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so1890284a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723032334; x=1723637134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MuT+owmBfBGHR66APeEDFcZLpyhq79heLar8HGmLCSk=;
        b=OCoWrLkZiD/q6HpQydysSg1oIyQduePoqMubt45ua/zeJo5bMUC4fNsSJhCjawzT6F
         hmo3MRYgue37cv6G0h2hxCy74GM7CJFT2QdKu2JLXLiARCTyDH6CBPOe3Zg0IbhVVipT
         Sl0K4zB5mM1tKbKbcXofn9KH1tSryVU6y2yOGpzkfoDO6xwvjYytfRfXTFcXnolfr4RF
         w8MBIX17H7GDnHRSvlfcAQ4xO1HbiNiOyL2GXm+apgPrQiL8LVz2p837xuwGAu3gfHpo
         ynWJqr2RqjWcUJAwPAYf/eX2TgzMnXgjnp1DeWVdyYzZ3wn/PLCQH5F1NTzfTLkjp/8Z
         /9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032334; x=1723637134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuT+owmBfBGHR66APeEDFcZLpyhq79heLar8HGmLCSk=;
        b=Z+Y3Wpd0LzpfIFy3iN7PhU4pE5+8cbV4by33OjRuELKisQYLNwUApzArySOuMJBYSm
         L1wUh7ZGUAVfh5aQoBc1flzxJpr7A7YsEPg6/pfBweM8YH6Oh+dqLpCw0YLcX0IMrTVs
         NkmEUm1wNIs1fwU1eR/bKlHRCej1WCH0ctbh1iJWrJVK315pIN7jiGGkVEGePsMHkMuM
         WlZ56RnG6s4OduFS6OTi7rKH6wf0wbnVarXexRQ8oPZpNauj0i7R9xHIEZz5Us1zirWE
         bYXXmQwPWpcNOQ4rMaXnRnJ4hbRFqLN3HGeQ3JwacOwznWMSlVI7XlW/9IMNJOwdv9By
         aNsA==
X-Forwarded-Encrypted: i=1; AJvYcCXKRhlGkFyLl3v9NRDiEBQtaTUKEJB78IDBCv6pwVN6JlYManB5EvUmHGUXE0qk/som58SO3wS6+8FLbpBZzi4V5RJ5lBQJRCEA3fZB
X-Gm-Message-State: AOJu0YzUo+1KtZWZ3V1FRBD90GZIffs61bC90HGQGPl3JYZnGXnBAH4n
	wk0hQJUxLMtZzQx7GlGkM5m9th4xDbRlo/vz1FATev11MyPWMX1aCIypphOEDw==
X-Google-Smtp-Source: AGHT+IHvW8je1lTSF8Nb98ubzh722Xg2WrwmRlMCXY9CtnaNJOL4qZOIC7XEf4k2/+uVM13wAgiu7g==
X-Received: by 2002:a05:6402:b11:b0:5a1:32d1:91a6 with SMTP id 4fb4d7f45d1cf-5b7f4295746mr12722364a12.22.1723032333919;
        Wed, 07 Aug 2024 05:05:33 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839716a97sm6906543a12.16.2024.08.07.05.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 05:05:33 -0700 (PDT)
Message-ID: <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
Date: Wed, 7 Aug 2024 14:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240807104110.18117-1-jgross@suse.com>
 <20240807104110.18117-6-jgross@suse.com>
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
In-Reply-To: <20240807104110.18117-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.08.2024 12:41, Juergen Gross wrote:
> In order to minimize required special handling for running as Xen PV
> dom0, the memory layout is modified to match that of the host. This
> requires to have only RAM at the locations where Xen allocated memory
> is living. Unfortunately there seem to be some machines, where ACPI
> NVS is located at 64 MB, resulting in a conflict with the loaded
> kernel or the initial page tables built by Xen.
> 
> As ACPI NVS needs to be accessed by the kernel only for saving and
> restoring it across suspend operations, it can be relocated in the
> dom0's memory map by swapping it with unused RAM (this is possible
> via modification of the dom0 P2M map).

While the kernel may not (directly) need to access it for other purposes,
what about AML accessing it? As you can't advertise the movement to ACPI,
and as non-RAM mappings are carried out by drivers/acpi/osl.c:acpi_map()
using acpi_os_ioremap(), phys-to-machine translations won't cover for
that (unless I'm overlooking something, which unfortunately seems like I
might be).

Even without that I wonder in how far tools (kexec?) may be misguided by
relocating non-RAM memory ranges. Even more so when stuff traditionally
living below the 4G boundary suddenly moves far beyond that.

Jan

