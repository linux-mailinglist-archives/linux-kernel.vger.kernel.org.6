Return-Path: <linux-kernel+bounces-323088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A2E97378B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6C428749C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C41917CB;
	Tue, 10 Sep 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBo6kpKG"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BE1E4A4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971811; cv=none; b=EhfaEibDQL7fOzP2LqHHij8poKhnZoPyPO86BNC6/RRZh9n/Z/SNnPxxXb3UkvCL3PA6dRI3II5Whi+jHM53kF/F2vEx3i+zsaf+rkXm2popzfmDP53nPIX4YHKoRAzcT4irzpXrhD+LMS7iYEr9GjGamTXAXlNrIeVR9S/jekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971811; c=relaxed/simple;
	bh=k7NHxqA3SglM0ZepSL0ApUEMR+pkYg4qNOQViEo1lvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3gnbbautHT6xQx1S8fRTAi8dSoJc+lmODkRO7g3OB0EVBUUVUORpY6QEdHDXYyQ9uqAyC1eAF2pcCRwaUCEHlsDvpMkv1S4vNjRMF/dowHSpPBzSrDm3V84ssVw1VNA9fEL5H0vjRrDY5NkeK0sUMspXjxoA0/mp0EhyW9ocfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBo6kpKG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so45867581fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725971808; x=1726576608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a3xqhKe2V4hP7VjyNfJjl2E35TafJrVbJyzMXlI9uuc=;
        b=NBo6kpKGh7H5eyoA9Uu9gCWpywn8mqMQIwtFeobWnZ6mzCAnUrhac/3outrJdIfIi5
         XSHu3n8aIVum6OvbscvWboCiX3AR0B6W/Dl+uo/ZIPXDR8f36nGFqvfHfWVBO/WgLFii
         wQHYx0i1j8yy4QzZCtA30ZEgZ8rPhm2arS6go6RJ3aNeafvsSjYDKb+RLHvj1PJ+dRuy
         NhaQk+YHtxe+RglhUysWq2fQTU8VDwQ9JCc6ogavi+kgrFmbV3x64d7GKutCKoqs1CN6
         c5m1vyRqcitGCNYSLFl18n7Mth1Kz6KFiUiM465sxoDl6RE9GhVwL8qrCH6WZpGmP+mY
         su0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971808; x=1726576608;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3xqhKe2V4hP7VjyNfJjl2E35TafJrVbJyzMXlI9uuc=;
        b=vzm/2qzJ5WKuCfwvrchAp38U3T6xsK3UzJP2K28jCoHs5vP4PI8pJRdTOsdjHBsCxG
         x9ndGMRBGid2nb+QJTaIj7I9cppPHMpPiC1szfRF8VGdfc8TjwxptieEE3BG779ji7wb
         PB580kUgf6w82uCdfMFLReHZHQghc20cais1sevfSapfQDgfN35w/7sIkqx1mCPrwQb0
         cYDmbxIJnkVTFClAAEun38EkPc6XeiiCMNmJJ6cUl66PczBK3ot/elqVWxM1NtQ89P1f
         wAG9Q/oi34U9GpAsrZz0SC1LV54gRajxCs6oAn/Z+SCJmg7H5LDyp1b7WgiDRLRvz6/4
         fTyg==
X-Forwarded-Encrypted: i=1; AJvYcCVU6Mi+Tn1Tu6N+KzOtYAOCkI5uUnoWpMSoejJMCGA17da/6q0bS+3GvjRBz5YYZtrIjN99MPxduECp4XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMBsBE04JuljoSru24LQyaOHV8Km643+4ptrtM4pzQup01xLRE
	8OjOQi8s+J828OcKqDkyTHGvOZjH8rX5o5WYOenE2HVYqL6Vhr8KvDgId8I83A==
X-Google-Smtp-Source: AGHT+IF3MoHGt1ik2VoSI/zIwXkBeiwZ9N+LJCLGLJBDe7Y5/hECHzQfOWFESmPwN/oMzTzhzfvfug==
X-Received: by 2002:a2e:801:0:b0:2f3:f8d7:d556 with SMTP id 38308e7fff4ca-2f751f01fafmr65227181fa.18.1725971807575;
        Tue, 10 Sep 2024 05:36:47 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdd3sm4237156a12.96.2024.09.10.05.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:36:47 -0700 (PDT)
Message-ID: <3fb809a5-d0a2-4b72-b810-13e4ee93b8b7@suse.com>
Date: Tue, 10 Sep 2024 14:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240910103932.7634-1-jgross@suse.com>
 <20240910103932.7634-8-jgross@suse.com>
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
In-Reply-To: <20240910103932.7634-8-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.09.2024 12:39, Juergen Gross wrote:
> In order to minimize required special handling for running as Xen PV
> dom0, the memory layout is modified to match that of the host. This
> requires to have only RAM at the locations where Xen allocated memory
> is living. Unfortunately there seem to be some machines, where ACPI
> NVS is located at 64 MB, resulting in a conflict with the loaded
> kernel or the initial page tables built by Xen.
> 
> Avoid this conflict by swapping the ACPI NVS area in the memory map
> with unused RAM. This is possible via modification of the dom0 P2M map.
> Accesses to the ACPI NVS area are done either for saving and restoring
> it across suspend operations (this will work the same way as before),
> or by ACPI code when NVS memory is referenced from other ACPI tables.
> The latter case is handled by a Xen specific indirection of
> acpi_os_ioremap().
> 
> While the E820 map can (and should) be modified right away, the P2M
> map can be updated only after memory allocation is working, as the P2M
> map might need to be extended.
> 
> Fixes: 808fdb71936c ("xen: check for kernel memory conflicting with memory layout")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>



