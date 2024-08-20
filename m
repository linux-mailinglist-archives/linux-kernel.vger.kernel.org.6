Return-Path: <linux-kernel+bounces-293543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64345958116
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA11C218FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FB18A6D3;
	Tue, 20 Aug 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mr+WXeAb"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E218A6BD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142953; cv=none; b=nhLic/80x8qCutDLLQAgPFBa2aomQmlv9q7UzlCGVlzwRpGFCL/pz0rEcezRvQrKIyYHBlBkJnn/45JfiOi4FawONiEeL84WDOVBWoHsk2xHBe6JQ6M4yGHG32nt0FVz1n4paGM7HL6DYN9PQ8Vd5KHuwRlFiz40Uc738n80x28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142953; c=relaxed/simple;
	bh=lKaS0lQy7BGig29UGQ55OGWU8w1coukRfAUDz1HVMHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQuXaeTR9qanFNKtPyyMlOVAy275ntjIqh5TtQTnmOnVqHBFJCByot7IHr5R1GtV2f1+kkceGyzJosNsKW4l3r/MsMbPsbaxOZJlPq4BoTuRjkjZH4mrGnWlbsx7kaj6EXQgvgGHA4LEsmisbyvubAsBTWA7Nzo6viVZhmQdRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mr+WXeAb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so3853716a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724142950; x=1724747750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4JRiL9QfRwrA91a43rlkba0LZJgJJT6qYuSKw8nxb4M=;
        b=Mr+WXeAbvYK4YLvokrogIeGcyDMgllCCS23P0cPMeQRc0iCGFLFvguxKjgRf4PmbmW
         QoFLfEV36koFMos/CSMIiuWGLaPO5YIj6WH8DhV9t7xT9E0iyAjcrupOYfbk6KBN8yiN
         5zKHw/RnB6Hbad7TBaJqs29CX/gyw9qYPkoXUQIpAXJpdwaNhUk6zKZ88Ln+/92rd2qs
         NNWxUhwEu2XkZtYkQb1YWo+S5A9z1YLyzCEgJXKsKLPpwzNIOaMcazQ8bds5AIPfMsHO
         LGeMf885j8pjKvnP41+o0wWpSHSZDQgbiQd9VD1HD5dsOFyf6RakCX0Vz7QEfQ2PKZHf
         zuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142950; x=1724747750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JRiL9QfRwrA91a43rlkba0LZJgJJT6qYuSKw8nxb4M=;
        b=f6S3e86P0x42mtqmp8U+n8KUAZ4jwXbmAWndVWL9YnK+DZIg3+nOpnPEjbX2vuVZww
         PmhbTV/MxWRrMTcnCrGRtMmvIJt2NVu6rpk0dyA53waCqvDm5eB5AL4GOn0EVvOk3n5x
         RCjdJ+OFOpX3yNfJaw/VDo4dRQZYdfv1f0Cj9t5WaosT7xAQuDa14PcUG+DV2tcHyWg9
         EUP2Ka+Nh6mfAFYavODUrBTiGvX4c0jzGKTpCiFLa5zt/s1ZtbNtE2a40zUlGjz0xQUo
         uY8VhUu1mUkqT5GTrpXR9zSyp7Ua6EqXH2uSmeWguq6Ay+NQHp6xyJ0tM3JtyRjte7Vx
         5j8A==
X-Forwarded-Encrypted: i=1; AJvYcCW4AsjYfgiAJUZjQn++MyA1Gm1JhZxQpLcE+m++vghvrSPL8Ty8wAZe4jBMgCnhzkZht5Sb3B3nrodhJWuAoOh/qp3DAHhnNsrNP8Nq
X-Gm-Message-State: AOJu0Yyz3oj2mrZNJv+qx6kMAe8e57eBYVFJCD1+yqkTEt/ncwApi1K6
	+nrUZFuHIpcBqiDtjUqkJQn2HXml3Dt4xUWO+OdLMGS2AhNxX7jfOjMc+6OorA==
X-Google-Smtp-Source: AGHT+IFdaawlNtR3epLC2KfjMcGlx4S9voLmzaSlkj8QL7rvwRfouEdIYTrEhiOI34tqIlQtR+1i2A==
X-Received: by 2002:a17:907:d3c7:b0:a77:e1fb:7dec with SMTP id a640c23a62f3a-a839292dd54mr1022324966b.17.1724142949444;
        Tue, 20 Aug 2024 01:35:49 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935600sm736331666b.111.2024.08.20.01.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:35:49 -0700 (PDT)
Message-ID: <22961690-14d0-4695-ba93-a68d2517059e@suse.com>
Date: Tue, 20 Aug 2024 10:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] xen: introduce generic helper checking for memory
 map conflicts
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-3-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.08.2024 10:20, Juergen Gross wrote:
> When booting as a Xen PV dom0 the memory layout of the dom0 is
> modified to match that of the host, as this requires less changes in
> the kernel for supporting Xen.
> 
> There are some cases, though, which are problematic, as it is the Xen
> hypervisor selecting the kernel's load address plus some other data,
> which might conflict with the host's memory map.
> 
> These conflicts are detected at boot time and result in a boot error.
> In order to support handling at least some of these conflicts in
> future, introduce a generic helper function which will later gain the
> ability to adapt the memory layout when possible.
> 
> Add the missing check for the xen_start_info area.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

However, since you mention the start_info area it may be worth adding half
a sentence to the description also mentioning why the hypervisor allocated
stack page doesn't need checking. In fact this may want to extend to
initrd and phys-mach map as well, to cover everything Xen sets up on behalf
of the kernel.

Jan

