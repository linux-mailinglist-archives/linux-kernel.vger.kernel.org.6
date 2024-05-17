Return-Path: <linux-kernel+bounces-181856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AC8C8263
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433E22814D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39C199C7;
	Fri, 17 May 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQWyUfhp"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A73BBDC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933275; cv=none; b=cRPeZPAvBOivwMHufDM359CChhrTeTzAoo4WwKZ4GdG8Uh8iAx74aohtvG2ziH+/rVuilY6udDpNwta4P/B5hvc5zPaV6EqN+5ob8smAxq2HuFrfedL0v/ezt+5OXHwwJypRF1e8fZIEwoPcolRgXWrzh4ZFNlwiV+DjWBP8sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933275; c=relaxed/simple;
	bh=67kJhvVJgfr3fdLhnw6mtmsME4ghMjbF6tKsfeoLtJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgybyacbvKFxL5UFj0mk3v91KQfBBWbPYQb32d+e1uCsVASk9ZxnxU7NU6YT0fP3G1k3FwJ5VrqdPzyToe8DIvoulIrxmYpTnLCGg/takiB5ePB7SpowWB+pcsp1d5HG3SOuYTTCMUZ6xhWQR/5/sFFjU+mTJJX2CIAyF5nNNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQWyUfhp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so3293427a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715933272; x=1716538072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADMoLBL5cnEifhHVW0n3dyo7J3ncObAka0zVx8KrFmM=;
        b=WQWyUfhp+XHzzN1zHf+gqxgRF7xECOlJuPrB+F4QcszkKIYJl98OFMfwwrRmN7myXh
         1wvYO4Jd/k0YgxOu1vX2mu60VTD9TdYtKYYvolds9YoVpA5lpesrSAwmF7txEhV2zxuO
         OezUTQMm5HD+xiGUicgv3muZPUICGCxr552pQXAdDE2cqOKd408WYV7NHTF3egMkOK1n
         5nkRcD3zzhpspbHhF92q4zhRaQgpftQ6DAip5/SidGckTtmvfupQPqL+s5PoulFGwEKP
         7hx2IJGav6244guVZjisu+34Ho+t177lg5664BNCxqNKyqFQTplb6N1dL2HkxS9SkzrZ
         y7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933272; x=1716538072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADMoLBL5cnEifhHVW0n3dyo7J3ncObAka0zVx8KrFmM=;
        b=k+3uuvZwtb6G7X8zqg1dOcLkXl4MJHExinHg00RT7H6vakvQcuXkOgDw7DIIlqvy0r
         /lzpPHqbwNPo9T6oN4gtQKQtKgjAV5jbB1i7anurYoyT2tSf6X4/KQ9wnj7adxbU/ur8
         zv5RbH0kS2OQr3CSkzGKUUEAboeostMbffyYZJnZeSZvPJ1TkiswQLvWDNdBRf7sYd+D
         fXHSWSNEw7G7aEJW6mMrUiBYBeW9FJeCHRvsGJz7MzPblkrD9rdcR3YUJ7r5qCkwLtOV
         08QNk7RsqFoiLze7jnmKyjrt2McPU+ALUMW/ZQdUpe3b/6hP+0Uk8CGT8leXLYWe8JBb
         YdBA==
X-Forwarded-Encrypted: i=1; AJvYcCVQv/38AMLufxGhLOD7+Im2Ols4AMOPfylbNMPbAtCx/HKcm68nzWZRD6eVH2neVpsxIUGu+COskbugMs/D/kqDhc+pnACQMNctN4eh
X-Gm-Message-State: AOJu0YyPRoYR873Qz+JsRKpsiTbeeHTa0bhKqdmGXaJ4gOmt8J2BAEMU
	vdHUOgN5KoIHAp4TfCOW3TE/Doz5vwKE/5sNV0PHuKWY4j6kB3kwpZQ6YofweVg=
X-Google-Smtp-Source: AGHT+IE2fmU8pDp6UlRMGDlXg5CeGrnSfA6SEVVbOUx4aG63KRG891PKcbwDpqb4LC/Ug/MAPPvzjQ==
X-Received: by 2002:a50:d654:0:b0:572:6cd5:f8d with SMTP id 4fb4d7f45d1cf-5734d5ce1b1mr15053517a12.22.1715933272636;
        Fri, 17 May 2024 01:07:52 -0700 (PDT)
Received: from [10.91.2.68] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574eba4bc3dsm4452608a12.94.2024.05.17.01.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 01:07:52 -0700 (PDT)
Message-ID: <77b01a97-de2d-4e10-91f6-915ec414eede@linaro.org>
Date: Fri, 17 May 2024 10:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hwspinlock: Introduce hwspin_lock_bust()
Content-Language: en-US
To: Chris Lew <quic_clew@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Richard Maina <quic_rmaina@quicinc.com>
References: <20240516-hwspinlock-bust-v1-0-47a90a859238@quicinc.com>
 <20240516-hwspinlock-bust-v1-3-47a90a859238@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240516-hwspinlock-bust-v1-3-47a90a859238@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2024 00:58, Chris Lew wrote:
> From: Richard Maina <quic_rmaina@quicinc.com>
> 
> When a remoteproc crashes or goes down unexpectedly this can result in
> a state where locks held by the remoteproc will remain locked possibly
> resulting in deadlock. This new API hwspin_lock_bust() allows
> hwspinlock implementers to define a bust operation for freeing previously
> acquired hwspinlocks after verifying ownership of the acquired lock.
> 
> Signed-off-by: Richard Maina <quic_rmaina@quicinc.com>
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>   Documentation/locking/hwspinlock.rst     | 11 +++++++++++
>   drivers/hwspinlock/hwspinlock_core.c     | 30 +++++++++++++++++++++++++++++-

Shouldn't this be added to drivers/hwspinlock/qcom_hwspinlock.c ?

>   drivers/hwspinlock/hwspinlock_internal.h |  3 +++
>   include/linux/hwspinlock.h               |  6 ++++++
>   4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/hwspinlock.rst b/Documentation/locking/hwspinlock.rst
> index c1c2c827b575..6ee94cc6d3b7 100644
> --- a/Documentation/locking/hwspinlock.rst
> +++ b/Documentation/locking/hwspinlock.rst
> @@ -85,6 +85,17 @@ is already free).
>   
>   Should be called from a process context (might sleep).
>   
> +::
> +
> +  int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);

I don't think this is a geat name "bust" looks alot like "burst" and I 
don't think aligns well with the established namespace.

Why not simply qcom_hwspinlock_unlock_force() - which is what you are 
doing - forcing the hw spinlock to unlock.

---
bod

