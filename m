Return-Path: <linux-kernel+bounces-318496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5296EEBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAD7283BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AA1C2420;
	Fri,  6 Sep 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paxnb1a2"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D11C2339
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613311; cv=none; b=A1T3V0q0a2QRLas6GSSEH6qT42nBeYjMtaGB9Y4+VniJJEHZtQm+HFSJHt6CI0NCr7AFl2XLBdjnqiOaDlcQ08AeQLhkibr57u0PTa5DMEvmrMEI0flRLgtOrrMYbbqpfm6JPIEPmYVMGMPDASeVwTTXPNm25kntc1MwicnMpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613311; c=relaxed/simple;
	bh=AK1DjOpyBmg6MrZsgyycLtZEyblkfcxZ3xEStXmD5Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C74r93MEPpLzWRDBtC02MQgJ9Z3Y7w51Ky1Bjf4IZfcKDexweyhR2AzxRIgEbw4Q+qoVPm/G6bZS0Fq0RkDLEkeZ91DjRg+wjCL2MmTLWlhN5GoudMs5xIWiPuwzxKVJ5Dc8aRRA3zcWFxq0n8V3AY9g2KFT5UJo8+LYDM0iHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=paxnb1a2; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso1931774276.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613309; x=1726218109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naafd9NQdL7c0TVHJHZyeDroIpmJmtpt2mzXoi2uMhw=;
        b=paxnb1a2Ha1yT4jQNLC3ma595OoNDdyFiUjMbsBFa7qcq4INetdoEfMSXOt/kjiuBu
         HpKdXhjN7f7nfeW5pSEOThfAxqpn6IQKelaAicKCQYKiMje+O7ecdBLnkHu5YKfJi2U4
         wuFVLeppYMB+wkrQUpVOqC3oCuOaYh9Z/Ut+FFNPiHZ3ugyQC2aTCSL7kOl/NRTAAyul
         I34J/3Q/TK+594y7zJWXNJJDBBFo3hkwIMSSuMVOihJdTHhqQMtZLHtGVu9uvt2BaSW0
         BENZWBZXV9+AGmidDpEe3HB2Y2d6HJC2VTAYvCXDHcIzhdnGB4vbB6ZS0vXWALM6C7uy
         d/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613309; x=1726218109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naafd9NQdL7c0TVHJHZyeDroIpmJmtpt2mzXoi2uMhw=;
        b=g6IYeKKR1rSvGC39yipLf97cHYbMhL9ViqQCz1FHgAwzkEP4y2POgr7CSW7LeN9F/d
         pGYUyVFGUVHZi129Hj9IglL19AyUX6MFgTlVXYhyEMhDT6qeB24fhkaBEtzO660gIX3C
         2x7ZBb9V7itNmfk0iInRZjAQW7ySDeaMx9xWAt4qvx6wDr4M5nYe1ofR/EnDY7Nh97N9
         TY/NfeXufrRydupiNoIw4Pq+ulYGV0IZDD0jH4opI2NXxRygZmlWb8cMXpNArYx2oO7U
         Zg+bybVbqNyY770Dh+kCsMdftVt7W2F8p9Kx/ovr6jUBJkPOzPZSZb5o63fECoeN5o1M
         oeQg==
X-Forwarded-Encrypted: i=1; AJvYcCWF12dCXAy1EvxUc01DdgWXS7YfI2ytutR/nIpewvqeVn1w78IkJIn1fCZwOfgqZtYOJ8QgWE1WakMu8SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVif5ZlqB80aZYJTDkOCp+XIAlfNGWhy0RGE2ixLFdcwURAeJo
	GRWQB41IkQQqKXMMYZU8wYX7vOXy8Mth3GZbs/x+wVsdP5QjcqrAiCbzsXrtgWnyv+OUaEvHRBS
	vfl1jrpDKlViFSP3JXY2hgcnfeYmYblooNJm9mw==
X-Google-Smtp-Source: AGHT+IFGQXdRZWy9RIvR/NJ/1402FeLabmNEa/IgMAE8xXJL7U/I48UXtAHrMD5jwlbUTFr/jlclZyUQEZZyPK0rr4M=
X-Received: by 2002:a05:6902:2e11:b0:e0b:db06:18cc with SMTP id
 3f1490d57ef6-e1d34875b85mr2345005276.12.1725613308963; Fri, 06 Sep 2024
 02:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
 <20240905-lpm-v6-10-constraints-pmdomain-v3-2-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-2-e359cbb39654@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:01:13 +0200
Message-ID: <CAPDyKFq=z8QQ3BLHd=sdJUcP+ZuekUzaBEt5PLARgJWD=PBMpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pmdomain: ti_sci: add wakeup constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 00:03, Kevin Hilman <khilman@baylibre.com> wrote:
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index bb95c40ab3ea..1ab1e46924ab 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -74,6 +74,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>                         pd->idx, val);
>  }
>
> +static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{
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
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -115,6 +130,8 @@ static int ti_sci_pd_suspend(struct device *dev)
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

