Return-Path: <linux-kernel+bounces-222296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F015890FF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854DA285383
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172A1AB515;
	Thu, 20 Jun 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XBjs+uWz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DE19923A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873183; cv=none; b=I6uCVrXvXmCOUZsKrDSgwMoM5jrVPqWCBogkfD7OO+tx4rpIAqM4sfEK5nbf8zg2YVmb5kpK2kEWuVok6hsaxbotclVP4VB+H2i2vfu6tmRXovQgW3rjF7Lb3O191apqc03kO/fgh39NEbz8CVLrcGhCdqmUla6NyANHJiz7jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873183; c=relaxed/simple;
	bh=HcEWBZ11+CZpedyXTpjV6nzYX4eDbqDX72joBPCeXNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfnDrNf/9Yvexgykyy9ukRuD8t8Gn+dF6SdbGX1urCU1UgShN4jnI9eCuf0Ee2tOO7yt0s710ZHwNZm6d6Trcc7YfMQkuc+AfRmsjMmZdMxZsxy5eDtfejrt03K/at0lsjZ++CqdbtJ1IpBONfR6TTIkNrLaQ+qBuVrjBQ6SfRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XBjs+uWz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e72224c395so6351921fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718873178; x=1719477978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HcEWBZ11+CZpedyXTpjV6nzYX4eDbqDX72joBPCeXNg=;
        b=XBjs+uWzuy98trmFpItmwBylRPyX0a6A/4j2OcQta/NMov7UaKQSpbCGw9c4HiPWrR
         aMoRMM7+/geeeUbpUFXb40yIRdMMpghxCOewK3WWDPgBt3SC0KbR3EN+h25uuTD2F1wF
         CZ1+oC4q7aMkzaTCwB6ovfVbOStJ6rbgQUqWM5nZgaLLlyNFzVRsFAsNU2vRkjaTn+iv
         13tI2fk6mSuebvBnztqd4Vx4Lgxaa1sO0/5cgDEyja3RqAwfAdEwQjfeN1/EWbfR4M1+
         FCYDpE1EXYJqRLg046rmbFmePPoZgzTSldlyd9yZbYUJzsk48cM/UaEACf9ZO41se2eE
         jwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873178; x=1719477978;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcEWBZ11+CZpedyXTpjV6nzYX4eDbqDX72joBPCeXNg=;
        b=fFjM0xYZEWI7brJ6ndiKs5C6rV5JtDXspw7FW0CKHM1hmOd60vOXUPtof8znnXIQDw
         IQiojtOKuRRHYaLcJ1548SavckD/Xy5FIjzPZSN4OF8EnOI3n4ISmldgRlozeiIj+2TB
         1j5zEylJ3z5oFCAYvzMm6bO42BopDnaLnz+vJDGFj6ZidMTz8IqH0v3lyJT9hld7JTwD
         XS+6+B1bvlxJZgFHrreNf3qwQBwcdpLMQbb18ytAYuvRNljadYRCImuopzA4v3bLfahP
         BvgZ0+l5gSmNtohgnQlXCYoSPkJixC428aouVIyDoIl62bskGICmKlUrQHSD7ZuqY6s8
         z8WA==
X-Forwarded-Encrypted: i=1; AJvYcCVq/CIvlXmiJBJd/98Y0/dgsO0DL1vBGPpZDGjIhEHuUdiHbf+BqgO0U/qyEvajDTLIoJb0E/OSS7P23vq6GNVfGV5qq/rq5v1VCjJs
X-Gm-Message-State: AOJu0YypCFW2fFFVIeJp0sTy5mDfY3MHXH1KltPytQH2DGjHCu1nrp2h
	UAvGWsgw1a87+uSta7Z4Zg1G3tKMewc2y/uBnelKrwd2dZD6I3tFRUTSX1Ds2Q==
X-Google-Smtp-Source: AGHT+IEuvlmEJKCq/JoXoMXLfyzgblEvw3Dth9JqvLR7wanonbmvHn+jVG/e5q4l4SVcmJxj6vCiGg==
X-Received: by 2002:a2e:9b98:0:b0:2eb:e233:30d4 with SMTP id 38308e7fff4ca-2ec3ceb9097mr31708471fa.21.1718873178567;
        Thu, 20 Jun 2024 01:46:18 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96b03bsm11880346b3a.75.2024.06.20.01.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:46:18 -0700 (PDT)
Message-ID: <ac40bf5e-6537-4ef5-bac9-afbe512a9d70@suse.com>
Date: Thu, 20 Jun 2024 10:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-47573: xen/blkfront: harden blkfront against event
 channel storms
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 "security@xenproject.org" <security@xenproject.org>,
 Juergen Gross <jgross@suse.com>
References: <2024061911-CVE-2021-47573-5c43@gregkh>
 <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>
 <2024062034-pork-limes-2c4c@gregkh>
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
In-Reply-To: <2024062034-pork-limes-2c4c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.06.2024 10:18, Greg Kroah-Hartman wrote:
> Also, the XSA-391 announcement doesn't say anything about them either,
> is that intentional?

If by announcement you mean the email sent out to xen-security-issues@lists.xen.org,
then the copy I'm looking at (v3, the only one having gone public afaict) clearly
lists the three CVEs.

Jan

