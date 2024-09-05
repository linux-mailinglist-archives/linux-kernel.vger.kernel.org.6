Return-Path: <linux-kernel+bounces-316930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F0F96D72F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67081C2348C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1F199947;
	Thu,  5 Sep 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuhV2LFS"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54C199943
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535939; cv=none; b=KsY6sR2/SUMps2e6lCAypgpOFzAwBFpK95qlgaXch9bzufVtNHiO77OhWTV76oT9jxiKeCjIy8lkDmfa04tOVqhiSlT8Sy91o8L4soHj2AaLK8l58srO/H/5aub+j89NOkOPukE8+ufv5b15jAJIAcy1eRq9ZRPipj8a3xFOSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535939; c=relaxed/simple;
	bh=3qZzaYmpiDZJPb0FBA+dUOf5gH2svOgHL1P3EL9vJ+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMBz3sCPjeMKpb6W/Jv9YUhHjXrv82rxHtre8ZppCYSlVyDiQWXaY+Qh08HlJ03c4GF7nLPL+z/gr7Tga4Dp26SqeeIvB4Hc+ZhkUCB7PTF+PWr08Bzz4vk53oFv1rudiLCBTWToLrf2rVPGeP+KR9nE/Jn9EjpBWmQ4AdCc5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VuhV2LFS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a9dc3f0a3so806731276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725535937; x=1726140737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BE62jvNjRymeBPRNCoV4pu9zk/FV0GIpysTD3uE/Nh8=;
        b=VuhV2LFSn4qb2p4fTMy4O+KD7aJuFkVMmL62Z0vG/mMW1Z8fiY3qXzMlqkvaQk/kxQ
         s+IO213RSndd46q4JlA2apfx9IkkEAyllKba12Kqs0SpX+1lDIFQMKi2ZUdMIVCpeOJW
         cK3YYFihUAHYAaFnICTHWM7VIZKIhq9Hyk1A5p6eE09GIgMOv/SOGpDaU4cIDY4rUngX
         x7FadMvcUyO84fNhNPbRtf/EC0avBvBueVCaoEDk2GW9RiK6f0HvHXAB4j7T3ewHPtSI
         /OL32VeeH42YjaNsvlqjBAKL7McM0+kEMu8qcJ9DWvFvZi/Ye0o9Xek6R7lbJ57nI2TC
         xjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725535937; x=1726140737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE62jvNjRymeBPRNCoV4pu9zk/FV0GIpysTD3uE/Nh8=;
        b=u9Fp26jZBho5b66mrDMjc7edb3EqPoqfyNTLNdegirew0sIXvKV6SQDu48VHepZ9xU
         2/oSbDb5ikU+8JGqZ5qDvqHGOVSvxXVURjQ4IBsq5axWQ6MqVF5IGbUukd0JwXXO3RZh
         lLUmaNfzaf+7MTJI05+CKGsamVJvQOs7DXk7v1ptvHzR3/8yQgeOir46UbS9EcZtuEgU
         iXOL0nyKm25rc7JOrUHVT/SZTvbWtv9dmQNoF6acAhwKams7SGfNBuJHG4odcNA1xrNE
         tNrhnf/HLdgDjLRjQPuTW+Bz9YJi+Qng8oykgVd8gYBkSoGANQfrZLSsLzvT06cIIk8B
         dN7w==
X-Forwarded-Encrypted: i=1; AJvYcCX1aXUweiYpY0v9Yf8RS7PB/czJnem8QEb7ION2SIOYMqESaTMp0aWq4CzZMLRn3IE8pApSGR5sAnDs+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8F7PeshTKwKs6FWm7/oDJqxJt3RKC1Yd2ehAJXKA8ZBWzUSVq
	R/A7LvoKW887P7cphbHLhC47yTm4d3/IbSP7FF2Xf4I9wTHvYThE8HeMqcGPZ7gp/GO+M+z1tGI
	zoqfEltm7i4H2AgYClrpGE0kld3y2kbAw7mYkoQ==
X-Google-Smtp-Source: AGHT+IHygd3KTX3EiW5rVbf+Gfj+wNPvBrt4G9Mi/elE8/M1C1pE+bPBemzUuvOcTWQEiq8y22JwXAOEFht0eCV1T7o=
X-Received: by 2002:a05:6902:d47:b0:e1a:8e31:e44d with SMTP id
 3f1490d57ef6-e1a8e31e75cmr16230309276.14.1725535937095; Thu, 05 Sep 2024
 04:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:31:41 +0200
Message-ID: <CAPDyKFpH9TQ3P75CXxHmgo+y8z-C_iYCzFzqR93w1Mt9jhFBBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pmdomain: ti_sci: add wakeup constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
>
> Note: DM firmware clears all constraints on resume.
>
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 963272fa387b..8af907579152 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -76,6 +76,23 @@ static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>         return ret;
>  }
>
> +static inline bool ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{

Similar comment as for patch1, should this be a static void intstead?

> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +       const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +       int ret;
> +
> +       if (device_may_wakeup(dev)) {
> +               ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +                                                              TISCI_MSG_CONSTRAINT_SET);
> +               if (!ret)
> +                       dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +       }
> +
> +       return true;
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -117,6 +134,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>         if (ti_sci_pd_is_valid_constraint(val))
>                 ti_sci_pd_set_lat_constraint(dev, val);
>
> +       ti_sci_pd_set_wkup_constraint(dev);
> +
>         return 0;
>  }
>
>
> --
> 2.46.0
>

Kind regards
Uffe

