Return-Path: <linux-kernel+bounces-575734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D7A70691
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232BF188C28E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B181A5BA0;
	Tue, 25 Mar 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DLGOIdwT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD061FFE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919429; cv=none; b=CGgkbapX0cslhVjKRRH7GOtT0xUsNhmwnQi+uZ9ZOTUgfHIKFuEqXh6w80ovl/nt8Y59yQ0MUbmbyC7UIepNX/UmerUDkwURLwC3RYedUIad/NPc3QqkTPLvIracTPFB9hPurWFH+0hkwljGZYtCKoPM5mILIiS49dMltwTz93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919429; c=relaxed/simple;
	bh=erQ9lWCFG2Xn9sWGLOzW92heJjF+4bbOtkfHpaRVeiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn7+TGdocPPMVxF753Un2tAU75dntrqCvS/ooN8SHHPtRGKi1pNhlP8OWkop9X1Z8KFZx1ClM4Ow/JPx8Jl5BQEYZk836eSMm1ETwpDw3/QgIrClUkM7Iyoel5ufKOwXCMCrdctoIZPCej7Rgayb7LwJu7hmZpOF2PO8CJxyvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DLGOIdwT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3914a5def6bso3479404f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742919425; x=1743524225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzom9g4Ka5TevUtw1wU09d/0vW6yFxavyu5lSqFcITk=;
        b=DLGOIdwTdamXURmfwuyElqQePsaJjLJl/n9G7pDeESa7UCEWNxgN4Csz1Zo38Wy2pr
         3GOxvocMnJxlE70bk8/2slEjnMddjRODAKkDZSYCVPfxXFGgnO4GkaK74FUg8p95urJr
         MqEGrT7QoZT576W5QRhP2BKb5RvZhajDCeN60bojfrsdmSIVgnIkixeySxPMRazvUbuQ
         5FDyyT6FH9+ZL3nPcwmtOfS0ZPZpwZDz4wLLfTGF+8pleFrPv5xpt2DX0iVYpPJJOfX7
         FcP/ZNoXmA1wBxuuOdKPXYAY0qukOfmTzVRpoFJkiDMC7tNqWjnDRm656pZC+FxZJD1B
         fkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919425; x=1743524225;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzom9g4Ka5TevUtw1wU09d/0vW6yFxavyu5lSqFcITk=;
        b=TxhBiHvH7jGrCqrJXlT3bK69+iV3L62nlc8aULjblmMWbRFTzCOyb0j9mGxywCwSoj
         M0VaGHXCdDB9B+VNaEmf1dlQGkN3AZgKEyrIJybDM5q5ytdwT1uXR3+T2KHmmajkrQWl
         MHf/M4VPBlcHUilUZvImG7LPyZ0vb+HBB0QJaO7VnVMvZiGwt/w2cyg/AZvhwjxZTCrg
         VXICnBbi99ZgdpPJfrUXFd9F/Q3wnrx/fRuqj+uwJoKrvjuWMwhcy1bbSz5DczcYW/1V
         /uCnz8sy8oS+YRfxUEEOVefWMOMupniE1mp21lAPC9jC/3+7svCAnpYGq9fHEuyvMkPh
         PJAA==
X-Forwarded-Encrypted: i=1; AJvYcCUV7XWzpnfdShWeepOJgPNhI/hSyJW4bU78yFBfkZatjt4FuGqfkNKX1STEyasfG+P9evPQRJDLT2smumU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEFit5CWz7vsuXa8zdPomeYJ+3TM+KbiXFnh+2ll/K+rdMnBJ
	uxTNjvIJb0rbyUgnGmJaxwpeCFTgaoYQIEpquwWGIkPubK6i/FBQXhklsdx3Ag==
X-Gm-Gg: ASbGncuid3rfpxrPFfV7wai+E+MCk4r9gjI0WpB5iUT0tntlACC2iKQpp9JC4aoZYfB
	MUDp3jRt+H8WmDGVWcok21ytKLZ0oT4QSsHQIAEBAqFWeWUVB3fXKV/tOkV+Pl8IQTkE4xp8Hf/
	WTMvKAKo1irwKXzhm0HAKdCOmraGWZDaT5qtvQzy5wLtOOK8Z2+V3iz2jZTDCAVGaCM+2PWmOO7
	cz8Z/7R7kAP1KpqP86WrzvMQAV0B030jNlmDStBIj5aR98N/4Y9W4hFQr+J9QRFeJx1gz671J5W
	F92ycZtv3O7EwT1RyqHlYHWltSJ/rAHhVJF4woVdXwX9Yc+jeNqNtGhVNS099lAl3t+RvwenG3o
	avbWG3MS2fLLrIf1BaaphvBvxbL/2CRw63q6YOyNM
X-Google-Smtp-Source: AGHT+IFAMF5I9YU7m8Jb60Oer9qE9T5DhfVykQZ4NtX7buysg8XRTsEGTIIKCjRzTnfRw1k9AA5epA==
X-Received: by 2002:a5d:5982:0:b0:391:2b11:657 with SMTP id ffacd0b85a97d-3997f92d423mr18749416f8f.38.1742919425210;
        Tue, 25 Mar 2025 09:17:05 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef23esm14023550f8f.81.2025.03.25.09.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 09:17:04 -0700 (PDT)
Message-ID: <45640c36-0b7d-4502-bf4d-df1c1d17d528@suse.com>
Date: Tue, 25 Mar 2025 17:17:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] xen/acpi: upload power and performance related
 data from a PVH dom0
To: Penny Zheng <Penny.Zheng@amd.com>, Roger Pau Monne <roger.pau@citrix.com>
Cc: Ray Huang <Ray.Huang@amd.com>, Jason Andryuk <jason.andryuk@amd.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20250306110824.1506699-1-Penny.Zheng@amd.com>
 <20250306110824.1506699-2-Penny.Zheng@amd.com>
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
In-Reply-To: <20250306110824.1506699-2-Penny.Zheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06.03.2025 12:08, Penny Zheng wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
> report the correct numbers of vCPUs that dom0 has, so the host MADT is
> not provided to dom0.  This creates issues when parsing the power and
> performance related data from ACPI dynamic tables, as the ACPI
> Processor UIDs found on the dynamic code are likely to not match the
> ones crafted by Xen in the dom0 MADT.
> 
> Xen would rely on Linux having filled at least the power and
> performance related data of the vCPUs on the system, and would clone
> that information in order to setup the remaining pCPUs on the system
> if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
> that none of dom0 CPUs will have the power and performance data
> filled, and hence the Xen ACPI Processor driver needs to fetch that
> information by itself.
> 
> In order to do so correctly, introduce a new helper to fetch the _CST
> data without taking into account the system capabilities from the
> CPUID output, as the capabilities reported to dom0 in CPUID might be
> different from the ones on the host.
> 
> Note that the newly introduced code will only fetch the _CST, _PSS,
> _PPC and _PCT from a single CPU, and clone that information for all the
> other Processors.  This won't work on an heterogeneous system with
> Processors having different power and performance related data between
> them.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
>  drivers/xen/pcpu.c               |   3 +-
>  drivers/xen/xen-acpi-processor.c | 232 ++++++++++++++++++++++++++++---
>  include/xen/xen.h                |   2 +-
>  3 files changed, 216 insertions(+), 21 deletions(-)

No dependency on another patch is mentioned anywhere (the cover letter
only says the series is based on the very patch here), yet the bulk of
the changes here (to drivers/xen/xen-acpi-processor.c) are meaningless
for a PVH Dom0, because of

config XEN_ACPI_PROCESSOR
	tristate "Xen ACPI processor"
	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ

(note the XEN_PV_DOM0 in there). Is the patch here perhaps missing an
adjustment to the above, to use XEN_DOM0 instead?

Jan

