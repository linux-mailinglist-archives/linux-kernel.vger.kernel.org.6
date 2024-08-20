Return-Path: <linux-kernel+bounces-293771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B63958456
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8371287C17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE018E037;
	Tue, 20 Aug 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="as5xlgJP"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36E18CBFF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149426; cv=none; b=t6kug0QfI/ADuZ7Hr36Iul5HLH21gDVoL1v/9lMz6sQ/7lkFzMdOL/x5VmsS0PebpqQsv+9bboUxqIMk3tHqw64/hQkFqOiaJ+H5PpE7yb8nPg0ra7R8Gn/w23FtnEQAKuG6t3RGR2z2ssR80kYHqFrWIxLg7x6rqmd5MoJuZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149426; c=relaxed/simple;
	bh=7R95fIIPP1pmIvqdF19S5CT5HdRIDj0OLRSo1I91tOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFcDzbALU2A+u6YtjBTASucTvYewtHW9aDnnERn4ED6ic3bPQyhtbOplnFPw46Fw8y6YGb9hrJvs4L55ZCn8SuUFOXvUJQiAXjxvF8B/bpc+p+o67o8w1TohjXJfCzqKxup9SZftihXYm12J6+D7NLCQu6P/N2LTpZgJmHpzOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=as5xlgJP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so681180866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724149422; x=1724754222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQbU+wmhc9okDK89belLs9mlxFgpOghZ2CbgXLEJ9V0=;
        b=as5xlgJPRPlD4n+Vxidc4K3nlwWi0/gLEXWbG/V6EL8o12Vjgewjp7QTwhUAPJQQOL
         /gJFHJ57M3zhG129Wvcw4Ok411yzvxWSQnUjKVcaPSOzMphFzzFMDT1I7cpsQGacDLcV
         kyMA2CBc7jJtp3U68iywlm5FAYv5pBdQoUnLrUdcNCVhqPlvP3ZKBIDkQqA1feTsgFM6
         a0Me21FVVA/Z9x8tWnoQxWK2zKj4CKJPyWrvbuj5BqjY2mt/DKIqdQHiPE3WY01DSlUU
         VgOr1psgjsYpVRFm6sZZ787QUKdUtEVlPhbeMPseodQBcguHV+AfKYJ5zoTKub8ufu14
         ZsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149422; x=1724754222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQbU+wmhc9okDK89belLs9mlxFgpOghZ2CbgXLEJ9V0=;
        b=h9FHaBGCVEPxoAgic3f/EHNi6ZckYRGVbWj0gUokzelbPBOWz5JKv2VYGLveLtDmrj
         2mMF2SRYe5c8VJObX5NTwt+ozFRciiptwVsL8BHZgXVUZhZ4vd8PlzD0VxWux0TKcOCs
         WBdld5VAHCKNC7O0NxHBql3QkkZs4MghSnsaXnO5C5fClbBylNv7PcBh2V2kV+rHcf4w
         on/Qj7iaY2bvuPgnuE7+41QeJ9vaMA6TkNlBEEiuXljCJWSWFkBmxcZY0kR75JIzh1TI
         lwN/oDrhTgXXAsziJ3D8nEg4aqTLyNAg4MAKtDpcLR0E4VBfiiyHKPVbaWrjl3vgdc1l
         gD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1gEXLGTq/B06db8z3JXs6QzuR+7B3c4b+aXgMx7SGkImzcSXojQPjDFSeadBKLR0EhArIQntpvUlwfbflS/k1i6dXWQJCmMFCdy4b
X-Gm-Message-State: AOJu0YyeNyElbY8ZExIUGHVZNjXLq37LHAdmYurVH6GkMSxeh9+jscx7
	En8jKLd3GP/ev3BKEh0sFOj6Ja84ddemostosocIFyxCNgJm0H4hBtsLMmXzbw==
X-Google-Smtp-Source: AGHT+IGYY6+/3Hs0Q6u/L07obMsnlHRatKoHFLlhFa/E1FH4GJdX79IJomctjDvK3E1Sp8/0CJuvXg==
X-Received: by 2002:a17:907:8691:b0:a77:c583:4f78 with SMTP id a640c23a62f3a-a8647a1a0eemr101756366b.39.1724149422397;
        Tue, 20 Aug 2024 03:23:42 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344cdsm741874266b.114.2024.08.20.03.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 03:23:42 -0700 (PDT)
Message-ID: <45a43d3c-35a5-49cd-a677-67fde3e5b56b@suse.com>
Date: Tue, 20 Aug 2024 12:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-8-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-8-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.08.2024 10:20, Juergen Gross wrote:
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

Shouldn't this paragraph be amended / re-written, as this was what made
me ask for what is now patch 6?

Jan

