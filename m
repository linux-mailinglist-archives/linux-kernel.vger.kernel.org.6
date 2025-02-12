Return-Path: <linux-kernel+bounces-511339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22755A329A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF23163727
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AB211463;
	Wed, 12 Feb 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LhgZHZcY"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB629205AD9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373283; cv=none; b=W7wcQzl05yLBdCdx7WmhSS1pD8xaUEKKEzAfxr4yWuQE/PQT8jcmFv+mIFcwqtggm6cC8vlIzXQjB1ydy+Wn3N9DbdarGU6oMD7tU37lvW60Zp4TkoitGnJjGH7NuNYqvXFIdirmRywLUYujmcQTcML6rEzXQwirxtR/JPvcRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373283; c=relaxed/simple;
	bh=gubpEh+dRLUuwWnGuWH3T1XeTa7Eb0OMY9HTJM+vEHg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QX6uM6PAvGoTlJkT8AEbngYwiSsdqDC/MzorhWwSId8jo3NVTNxZLpITAqv7JqjBov+gIBk399ZQDyJU0ebm3BOONc1F56AQZEyCN0JIHhJxBqNxHmPN/nRPbBxSMa53UO1rGvVQdjGXAriU43psjZBj1pdynTCfzjOYfwEfLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LhgZHZcY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so9858268a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739373280; x=1739978080; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55Sze70nCKwYZwnO6m5jnIDoctBFu3704OsiyltWzpk=;
        b=LhgZHZcYvFdhUI4nrr3us2d8O0sQUkzYKUT/LHH9utQqMPxvF14NksHDe1vJgfYx31
         FX2+8Jvs4Z4TXV3COFIzwT92TGlpD+2IP/AHIhrleZfTc9zi+lOQUgqxb7RiPAPHwZu+
         SyNRaaKX+lsncS+BEDt3J5tGbNl/XelGtlwzlvE8/0LtMBMkoUr8wBGFaqrX6QRNDyEF
         IxLDqbaEfbozwg1QL1UJrQkmJhyuxAxfuOKiNZuedZv8my5XbzX6ochEbgr7qzLo4Guc
         5x+RQMUD9g5EGzQfQZ0KYdAnrxzn0be2K/Z++cJ0Jjxshowo+VE4zR17tr09mEAACDrH
         NIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373280; x=1739978080;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55Sze70nCKwYZwnO6m5jnIDoctBFu3704OsiyltWzpk=;
        b=n8JoDGQuxguVZMYGYkZK0lujKBbF5TP5vqqg+tB1H/KIQk7u7peMnxXbJiSU4QG80U
         GhAUcZ+f6hEirInyPGC/KVfYHIeZ6pSt4d1lXO/y6sSW07uGPEJ0+yp5JCbxgaqAU+hP
         ujU+FQQbEbSZr2oZ2TclBfP5E35HMq3i2rlOvwKkAEzqEyOZdNllqr+Zn5W4jN5ckxvG
         tGimyk2yoPIViwgR0AFOt2HHnsOZv4/HyJijQ3UA1ud5kAWZygCpxIAEmVdOmAYY4HSa
         B9ZgUh9ektO20tjnwJ5VCCU7mU+0d4hZ24VnkZAdIgDUFcSBcjV74kW6Rd01Gch6Yrj9
         KP9g==
X-Gm-Message-State: AOJu0YyQx6Xn5wyF4ua/+AgpB8Ic+OOOhvNGc1r3/7+G3291AWK+MXuC
	Qcvq7jxOyLZl2BwhkfXlB37Y0Z96sf8SsZ7HWkuOE69T+Qi12jLxXVVmurr/bBcXgyzfUopncMY
	=
X-Gm-Gg: ASbGnctiNDH4r6RELSGyf5H2kdI6tFnUWZLZLRSd0W9ItTAjQ08V9rHT6xyl3hFMMR2
	gfdCXIckP4sKVHrdKA91pjZ7mgNJx72Mc8EPd3r/qAqkbPIMDtkRnXnaDe9xVmjmXrvZtOGE4Xl
	+7SdsNklIbXYy8fm0sNbafv52QXi9uqeDmxK2vVUks9IstuDfJcjieXI9FqmLw2gtXfS+Dz2qk2
	lHjQQUMCc7TSX7EJcFzyJZWwWPua8EnvMxpI2uy1PfEuDGQCipqh7kWXst6z8pP9Iy6LkKBxbUV
	nmagZ9g51GAby7TxbceZTxZxE9oXQ95qgZG3pmrE4X288JCYWc8+OVqin9GvikhM+ONs6IK7oS8
	R
X-Google-Smtp-Source: AGHT+IGj1jKwWNk7iw92QGRDhoUC7sem+NUjywpVYH+WhzbmFGswKt19wnfE7JhXyl41yr11mSL9rw==
X-Received: by 2002:a17:907:d26:b0:ab7:c6a5:4555 with SMTP id a640c23a62f3a-ab7f3365a77mr371056166b.2.1739373279934;
        Wed, 12 Feb 2025 07:14:39 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cc737d81sm535551166b.176.2025.02.12.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:14:39 -0800 (PST)
Message-ID: <e1198286-99ec-41c1-b5ad-e04e285836c9@suse.com>
Date: Wed, 12 Feb 2025 16:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lkml <linux-kernel@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
From: Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] Xen/swiotlb: mark xen_swiotlb_fixup() __init
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It's sole user (pci_xen_swiotlb_init()) is __init, too.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -111,7 +111,7 @@ static struct io_tlb_pool *xen_swiotlb_f
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);

