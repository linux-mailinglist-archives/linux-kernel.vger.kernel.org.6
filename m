Return-Path: <linux-kernel+bounces-394460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A79BAF69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F62818C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057E1ADFEA;
	Mon,  4 Nov 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGPVCOF6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260D1ADFF5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711771; cv=none; b=aXEhJ8F1ra6uneOnYXyUpC1/FOK8PFoJivvZICVxjTeoXn3+wKJX7Z98B5sHvS6GNX11Sp95hfXOHPYURmMejmOy7kDrQ3tzk3L2Ksas/qg7kDWgZeEhGGRB4nT98hZfahETn6seVi/VZ430BmRfaHKmKB4P0EiG4AYdos6xNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711771; c=relaxed/simple;
	bh=8qvvIbXZBoOhUrurg+FXL7IS9N/nTjxufCJF6UXmVG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Yw2aHt0nq1OeqCByx3tNRfPhKneraiHWmzoLajgiZE9eArGeekQh/9B0hySE6zeNC1nTHRZvBn57w+PJIiWK9vSIgrOrw741ElhK2Vv/8B3gKEt7FxZASMjSF8UVs/uMEi61WA3dZTcZQsHBFVouDHV1cuhW/xwHofkctK6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGPVCOF6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a850270e2so664084066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730711768; x=1731316568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjW0MeEanGzE6qJjI2t+OcWT0D3B+88t+GC9PRoygKY=;
        b=MGPVCOF6Hn02fyYFq3XHuUsgwuVGc5oyXa8OzGESEDC6S7b4/elG7NJGvM+YWbDJI4
         a1wH5CMtOoyseSQxuzMUxjXvQR1sDJtXj3a2cX+nwQ4pdOxRQQi5iL/WcrtJtpnNszhs
         tv/y2szsY6WRjpeqZ169bD+pywwJP7f2mXDHWZK9IC1cI00O9Mp0vJfybv6Hl4fPwmSA
         HMLFN3nj+CZ9ytgqwYrjXjUqQFBj0NOxFu3r8ZhdlWZQRVtx0ZuDs4heUBVzzMFp2oph
         ReVW8VaW++qCLmH5i7CcjRkq3r7PP9pnfGhF4m5At28adj0De086FXKzcvUk/rMPSA/f
         SLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711768; x=1731316568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjW0MeEanGzE6qJjI2t+OcWT0D3B+88t+GC9PRoygKY=;
        b=ppg6LkUBJZyKdOqFIqO12FWMv/Y1xOlcUNI5h0+3Rn7Qx2tmzQArwFowDK0S10S9W/
         qKPeLHxxZ6GFKjzpho4aJWP1556ETljG/ox9TErU5sgRhMUA7DWmfGyHGg8fstfWb1c0
         uJoNAOfV5ECT2fYFpfnStQbAuZRAX80IfF7Z9T/9rgBPS8MbbZpw83cYIkq+7BwJXQXp
         eG77wushxN4CIQtiLkIncTCu1olkYi84yTvwuktEqxrZWUabu3217K00l4BvDEO4wGLf
         rDxhsDT/nCBtA/CR9vMVCqRBTd3b86QsILYOAarp0ODxVZc8LHUmI5FmrF7hTRsykklC
         pVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7sz9djIncBK9a32X90PyEf+8HXGwq6DPa4U1eAQkcLRujxCY96nzIkrI2gg+Va0n03pgk7jNj61WqnFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhx3zBLUFYGlP7h/rr8ZK76USonhdSQgDKz929SRdAWKWpFDuo
	KUYCxKnLbg8gc+Vrukj6dUzXMOoNlT/roCoNf1Qt5NP90re9P5LASdgdcMnaIA==
X-Google-Smtp-Source: AGHT+IEi3CGJRpuLDqOUs4AbQRJ6VtgvGgoK9lVUe7GdygoxskVpKy2yxyMGcjqfE0/N3aK1DynM8A==
X-Received: by 2002:a17:907:2dac:b0:a9a:82e2:e8ce with SMTP id a640c23a62f3a-a9e6587e288mr1306429766b.40.1730711768194;
        Mon, 04 Nov 2024 01:16:08 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494295sm535883266b.14.2024.11.04.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:16:07 -0800 (PST)
Date: Mon, 4 Nov 2024 09:16:05 +0000
From: Quentin Perret <qperret@google.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Message-ID: <ZyiQ1YS81ZjE1Qlu@google.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
 <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>

On Monday 04 Nov 2024 at 09:14:36 (+0000), Lukasz Luba wrote:
> Hi Jinjie,
> 
> On 11/4/24 09:03, Jinjie Ruan wrote:
> > In em_create_perf_table(), power is uninitialized and passed the pointer
> > to active_power() hook, but the hook function may not assign it and
> > return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for
> 
> Please fix the driver. I have checked that function. It must return
> -EINVAL when the 'policy' is not found. We cannot progress with power=0.
> 
> 
> > power is not invalid, initialize power to zero to fix it.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7d9895c7fbfc ("PM / EM: introduce em_dev_register_perf_domain function")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >   kernel/power/energy_model.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index 927cc55ba0b3..866a3e9c05b2 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -344,7 +344,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> >   				struct em_data_callback *cb,
> >   				unsigned long flags)
> >   {
> > -	unsigned long power, freq, prev_freq = 0;
> > +	unsigned long power = 0, freq, prev_freq = 0;
> >   	int nr_states = pd->nr_perf_states;
> >   	int i, ret;
> 
> 
> This patch proposal is just a workaround.
> 
> When you send a patch to that MTK driver, I can review it for you so
> please add me on CC.

We raced, but +1 to the above :-)

