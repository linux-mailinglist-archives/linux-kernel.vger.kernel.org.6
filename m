Return-Path: <linux-kernel+bounces-510611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A644A31F80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C607A2E35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5C1FECC2;
	Wed, 12 Feb 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D09iauIs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EC1FE46B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343200; cv=none; b=NSkwYsGYJ+4GuPYpLsMyeAWMfKjnpvdbKtRMqbPO/l+T11JZp2+rRsLh25Pr6ubfQkxXc/NjzSClom6bkUzOuOxg59zJVId+Bl1DjItl5Di658KgxymOUDiVRAoCD4kAhe56WWvfLe+k2L/VRhxt1wNKK8MdQm657PSO7qY6tso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343200; c=relaxed/simple;
	bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fplpNBRVF30bXQrZ9Z/hDcPbwRvz4bVKKaXvJz5IoqB4BcPGrx3Ms/AdYVpvnPpMDYQgIPWVC/IY6rveaxi2gGeSnVxxk19qKVFkoHwJygQC+1uRF+25YUPIQlH56AuNy0KOMlA95Yp+GwVNSyUtI8Ptf+5XxkRCwlIArzqfPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D09iauIs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeec07b705so1011889966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739343195; x=1739947995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
        b=D09iauIsQO7CBWD1UHpsWgow/5Vz9jznCZGh2QbIv7tbh2nxuw2/GlEpHKc5rH67TZ
         7vYW7/hrFwgM0k+y4jii6Pwcj3kuO2SBlfPdLIR0iQuQYY9F6Ld97MgJh5WM0dXk3PIc
         9w5apXM7XtdqFeTt2pbrVlQR6erOUXy6hrSmbuE6Qc+dWD6DXVb7PSFJgBFcvyvQgV9D
         LkW2tLShC+1D01YJsDadP5GxjJQf8oZfaJWOccyzgqAulvdAqjGVZ99gGcoxo+UgjUlE
         n8KWScBhXdhwEFznadag96/L46cGx1fjR8l5fBiWSCWk10xwcd8d0ssbVC8Sap0m4Si6
         csOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343195; x=1739947995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
        b=qGym7HAK+JgCWBV3S1NLkbjhTwZ7YQgf9zuInTGbHsGW+ZWl9fm6zdoCpd88A9yXkx
         mN0iazMpp/81C4L5ptk84+wztCHm8cH+k3oXwajfqUF/TkGu/HJd4L4CE5NxQR4wMNmn
         JpIxonu8dbHrokDZ2n/qK6mqtRwMLdpoxeeiG23NivSMi+xlz2zy91UOoPGdMUEVISrw
         1bVEOJ6KW20OoKwMURZK82SAJHiVIIH/6axs3W+bjwhfskfUF+ymD5t4dZj+5mNdTE3V
         KF+k5tVOZMDfmtYjOeyT7HKtVr/MdFm/erXDqPiayVGE3bGZzyh5OgOp589S0lUSuQxb
         vkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD0uqE1oNcPigip1ONdvvRaWzIwejZ5ZphX8uu+PkRKPO0s1+C3I20J7s5wjsWCZc5O0FF9GPfRr90Mo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJZShZcs9konVsfN05JMvIPuJPflEeruB8Yu1xtAD9rqd7nBT
	b7nCOR94VPuOBzm1UeV9WvAiuie9X8tp+pnLEJxJKhQ1GTaOW+qA7xDlKNx1zw==
X-Gm-Gg: ASbGncvvNO8/XWGBnFX6AQtK9N5xL7xsrr8L4wWU1/k7O7ypDDQYWEPdcfpsBbEZnFz
	bRt884WWAqWEuVOdX7fv7b8GkfPtSAnXYCuUxFXU7VQDKBelo9Yt+Kbulz9BxaP1Sbq22njbQlJ
	8S6/2g1ajnpGh/OPgPgh+DE/DNNJJeed45WN3+VFs6v7kG3qDeY/cjiPdcU5kxRBerM4JWyYdGD
	v+efoQnURyRXUWHTJjhYRjX9/003+kv1svAre8PX3xzQjTl3J8wAwPkeVL2AFIbTNzXu4UF+M3a
	WdNtYnUiyWLA5PuxI2foMpnnOvQjqZq97MfMZrW3yyBk7CUl2+Rry0RvW2izOo9fB0UGlQGbUky
	5
X-Google-Smtp-Source: AGHT+IH7szDJ7r/FLs7HCSZgQOG6ClTKkQlnfHrZmIaLFikv1S6Fh81Vo5LwUTuyR2T+FFP/nHdGEw==
X-Received: by 2002:a17:907:2da1:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab7f33e0e2amr203666266b.34.1739343195217;
        Tue, 11 Feb 2025 22:53:15 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cae13326sm458952566b.115.2025.02.11.22.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:53:14 -0800 (PST)
Message-ID: <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
Date: Wed, 12 Feb 2025 07:53:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xen/swiotlb: relax alignment requirements
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-2-jgross@suse.com>
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
In-Reply-To: <20250211120432.29493-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.02.2025 13:04, Juergen Gross wrote:
> When mapping a buffer for DMA via .map_page or .map_sg DMA operations,
> there is no need to check the machine frames to be aligned according
> to the mapped areas size. All what is needed in these cases is that the
> buffer is contiguous at machine level.

Is this really true in all cases? Can't e.g. compound pages make it here,
with the caller then still being permitted to assume higher than page
alignment? Alignment checking in xen_swiotlb_map_page() would perhaps
need doing with the base address of the incoming page, i.e. excluding
the incoming offset.

Jan


