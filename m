Return-Path: <linux-kernel+bounces-232553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161491AAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF26128A442
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAEC1327E5;
	Thu, 27 Jun 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL6/Oc/E"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBD198A27
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501301; cv=none; b=qg33ljnq4ObOki5Gw5LyWWHpEUxBd3PH+q2eyagO3O1/LpD+pFHNdkZ3x1E23ZA6+OR1RpacrOlUJw5d6SsQa/nFPN0JHv2LYiqquK0Oum2vB6mEshbLrMXp9FP/GD9rxU5qHivQa6P5jy9o4iMNBMgBmhKjgGvp+BHcYZSWr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501301; c=relaxed/simple;
	bh=8eem//ITjEXYdm72pHz9iK8ciJdXphch4zpUa3zYnNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiDqAuRA7+qHnGxM5W5VLXLMne2ccNtAFhGKezuWVIZBDrGd15qb8ZcplUVN90SEROf5CQarwr1tw7X8Zv4xPCZme9E/dMgVf5YTEvwP2GX9eLW4/6LkCSNKeVPsDRP6CeUwHJ9h/S467ERWJIGBM1jUxOYkozagftiCjn90oY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PL6/Oc/E; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-648260fe4bcso22324077b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719501299; x=1720106099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hwRyUjzUUY1CTiMvK15nbjIjb4MSnbZcFsEElNFFbM=;
        b=PL6/Oc/EkakHVxHkrw44QdyTe1Ir4u4V2a1mTaekekOgKyGTSn1ru9STNk/D4aVChX
         +z0xcS6PEm6Hoqhug0jK6OsRvbygxnFz3uVgAGiOnnWR2wrxGkt9zyunMOFT8qPlwH9e
         ZxsZAJqOmBkVCL6cwn6pvn/MGMJ9WAw8qyazAyu0T2wfGCvVd5T5gNE2NXEEzGoARGjC
         1S2AhT102+qMRqsqvas++27E4+pyVrgfaU+wIC/4Pl2zqERdnMg8wLpi74i/hnvrPBSs
         VcCveeukCFaCDlMYOovzsVDH9rY7B0/lLSspVQAWR1J2RyhSyrZJdI280YS8gB7Ypzmk
         yEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501299; x=1720106099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hwRyUjzUUY1CTiMvK15nbjIjb4MSnbZcFsEElNFFbM=;
        b=DYnZuDJarqYHATFW3OMrydeWM93uAfX91xmOnDz6OJNydSBW1UXnJfzuHscaP8Q0p3
         VFvMKgS8fpK7FAyyq3OpVOWzvFesKL+quPdnvdnJTd+sF0Dkw1jX+HOsiis54ohxJbkS
         XG+f9nb4QkINCY9i+XVdmM8QjenFF6zC5vgW+LIGN2d71nTFhg4mIn1N2hJXssRJSKIe
         AIPMlI9KOv33qkb2ih7WWpRXi6GVjqCK5O3b2vOWywDvGktkQVig5dQ7oJT1xCU2mDOc
         jF4tMtPPRSIILaLxznIrjK+zWHq1lRoKe6a0W0I3CjywDLE1XHdNv2XFKe/C2vlJxfXx
         UB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUVXkz9Trq1iKlYmtQKu7ahEVdZcVGNebOD+Tw75/69DiqECvT+rIgoqjeL73BQ3EOIzynsvpjOMg4hrPKGPmKyqdQ6GnBsMVcQlwW
X-Gm-Message-State: AOJu0Yy6acVgcOzDO9voT/+vZ7JSOOnRM2qYDVB9HVP6NyWE7MEZSb4K
	AkyeqBRQ7GMZMXjQ2NEnJCMVQDYzswAWPnl0/tHMFd0da+ydgHtAJxpBEPf4yRzWspiCsL/DzWW
	wI0aq28QegNP1MNm7YOGJGl/flNoMrBdOTm2EKw==
X-Google-Smtp-Source: AGHT+IEIdj5kMgp1wElSphuCogD/aifBCB+hXxrUP1eZ9IZ1k197mI29RMs431bOzaAjpNxukowNArLWDrSnNW0Js8w=
X-Received: by 2002:a81:9e0b:0:b0:62f:945a:7bb1 with SMTP id
 00721157ae682-6429c6dae8cmr154073967b3.42.1719501299067; Thu, 27 Jun 2024
 08:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625070536.3043630-1-quic_devipriy@quicinc.com>
 <20240625070536.3043630-6-quic_devipriy@quicinc.com> <2391a1a1-46d3-4ced-a31f-c80194fdaf29@linaro.org>
 <69126dff-fe23-48d3-99b5-a2830af52e6a@quicinc.com>
In-Reply-To: <69126dff-fe23-48d3-99b5-a2830af52e6a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 18:14:47 +0300
Message-ID: <CAA8EJpoAKJqDH1z44_93kYLoAeAZ30TQe+=4ty1UgMydLUCxJQ@mail.gmail.com>
Subject: Re: [PATCH V4 5/7] clk: qcom: Add NSS clock Controller driver for IPQ9574
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	arnd@arndb.de, m.szyprowski@samsung.com, nfraprado@collabora.com, 
	u-kumar1@ti.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 08:37, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 6/25/2024 10:33 PM, Konrad Dybcio wrote:
> > On 25.06.2024 9:05 AM, Devi Priya wrote:
> >> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> >> devices.
> >>
> >> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >
> > [...]
> >
> >> +    struct regmap *regmap;
> >> +    struct qcom_cc_desc nsscc_ipq9574_desc = nss_cc_ipq9574_desc;
> >
> > Why?
> Sure, Will drop this in V6.
> >
> >> +    struct clk *nsscc_clk;
> >> +    struct device_node *np = (&pdev->dev)->of_node;
> >> +    int ret;
> >> +
> >> +    nsscc_clk = of_clk_get(np, 11);
> >> +    if (IS_ERR(nsscc_clk))
> >> +            return PTR_ERR(nsscc_clk);
> >> +
> >> +    ret = clk_prepare_enable(nsscc_clk);
> >
> > pm_clk_add()? And definitely drop the 11 literal, nobody could ever guess
> > or maintain magic numbers
> Hi Konrad,
>
> nsscc clk isn't related to power management clocks.
> Also, I believe it might require the usage of clock-names.

No. First of all, you can use pm_clk_add_clk. And even better than
that, you can add pm_clk_add_by_index().

> Do you suggest adding a macro for the literal (11)?

No, add it to DT_something enumeration.

> Please correct me if I'm wrong.

-- 
With best wishes
Dmitry

