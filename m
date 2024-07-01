Return-Path: <linux-kernel+bounces-236164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2224291DE51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682E6B22424
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C01494B8;
	Mon,  1 Jul 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcERIxBu"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E717C770E6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834474; cv=none; b=auuNZjFCxDTHk34f6Y60n3fJfbW2Yza5kWMSW9X1UOKXpbxS3BmXffEo3G9AuvGbwN1xZAUW3dwWL44AM8p10s9PaAG9gwS7MjXUxbsPnX01thXbkSGeVRyHksYCDmeBR+TNBi5UnPo0qrMEG40Yp7JQ+mpgr6HF48rW1qs5EAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834474; c=relaxed/simple;
	bh=jiWVBvlci6pg3oJ+xWBRBIfbjSaD2vYzPxE1uip87Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JctVLly+Bm8NkpUEGeK/N0k3YLMOD8zZJLWPPPkS+5LXVctUqLvGiOn1AahPre9FjyLhiF7sW5sP+fpazi5iy5EIRQ+r/Sln5dIYRWqpengkrAybIZlRlaOLq60B/I4VtqchHJtvysoY42ChadiR1fN5phu/SJqH42JPkv8Of/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcERIxBu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7067a2e9607so2266160b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719834471; x=1720439271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vi7uBT1zGBUytAU1JAG3iLk2sulQaLB7Dq+BxdOsfHM=;
        b=vcERIxBu0xd5g4IpMJl4OnjdSwsr7rK3jJt6Fr/LtUsqHAzLVMhWQnD5tQacKnt0Ns
         w7hoPcm8HONBQaHUbdW3dWLvpGWDpsOtyHEwWbbPfigMkSrX8+/iI8MacalFJcz8J3rN
         MlERqwYN8ERrX5OkKjJLOn5RtovDoQG90ahTwkgKa63dJC5VN88ak3bFk2wEqNDYxI0p
         Phc+y7Ig47C67CaP/YWrBvxpIwa/TNbrVBBX9dNcvAH1YbOZ8CctzKl6IfqX2WGHPv0i
         EtDndWA9oC6ew2O3zNXzpQRJcXtDEZcgydLwA7hDYqZGv3TdbsjtwHO4uh1Hm64yDaj2
         MkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834471; x=1720439271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi7uBT1zGBUytAU1JAG3iLk2sulQaLB7Dq+BxdOsfHM=;
        b=igo/uPGK7ZgkMeVX349nm3FCkomHil1VUuvbXXMmYhNMVktf67oxSge1VbT0HTGY3t
         Ykf8qLy/wiiTWnOtkZCmyZVSiyw11OYIoopiwi2PfnarSQx7eVjQOMRV69+7tOVCsn+/
         YGooQ8LV3i8GF1IvGMIjdas75HW6vTc8/ERVfqBFkHocbbhZFHjHjH+uuia5+iGStFLy
         0JjDTC5AqYGZ1px41OAi23K5DivZMvrr7P6iVVqusZy+HlCey+SHsTM6vstuxA0PgElM
         InbILfsIeLLpUL9KQrmhONANDZVpKjios1FEYxHvscxZKP673zuRdjOaLUBxZATHoPxR
         nAKw==
X-Forwarded-Encrypted: i=1; AJvYcCWacVdHAh5VgoxA08nux+1Gel/jKwnIiG5EGjnrmn5tData7wsqtnt0HTnpHBQcauhftmHy96vP94YDwgQ1NIV1ilEPeK2qv4MzpPzl
X-Gm-Message-State: AOJu0YxBfbLjAEjVDimJajY4qzG+jLfPYVf2/FE9Qm9JdcIde5kCHyoD
	AyL+fej/k/Cuu0uXbTPFI3sIhlLzj5fjWLLyJ2DpWsgCM2YQPDh3aeVouri/Gj/OYt2qIjr4g3k
	i
X-Google-Smtp-Source: AGHT+IGOn8fZU80VMtXzaPnMUv7YL/QK2W3TGTcOrKEGGFell07/QenRkEBPEcSm5E5/EzY3PGFhNA==
X-Received: by 2002:a05:6a20:4303:b0:1bd:18ee:f145 with SMTP id adf61e73a8af0-1bef60ee5e3mr8481395637.1.1719834471025;
        Mon, 01 Jul 2024 04:47:51 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1c396sm6598209a91.4.2024.07.01.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:47:50 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:17:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240701114748.hodf6pngk7opx373@vireshk-i7>
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7>
 <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>

On 29-06-24, 11:09, Ulf Hansson wrote:
> I get your point, but I am not sure I agree with it.
> 
> For the required-opps, the only existing use case is power/perf
> domains with performance-states, so why make the code more complicated
> than it needs to be?

That is a fair argument generally, i.e. keep things as simple as we
can, but this is a bit different. We are talking about setting the
(required) OPP for a device (parent genpd) here and it should follow
the full path.

Even in case of genpds we may want to configure more properties and
not just vote, like bandwidth, regulator, clk, etc. And so I would
really like to set the OPP in a standard way, no matter what.

> No, that's not correct. Let me try to elaborate on my setup, which is
> very similar to a use case on a Tegra platform.

Thanks, I wasn't thinking about this setup earlier.

> pd_perf0: pd-perf0 {
>     #power-domain-cells = <0>;
>     operating-points-v2 = <&opp_table_pd_perf0>;
> };
> 
> //Note: no opp-table
> pd_power4: pd-power4 {
>     #power-domain-cells = <0>;
>      power-domains = <&pd_perf0>;
> };
> 
> //Note: no opp-table
> pd_power5: pd-power5 {
>      #power-domain-cells = <0>;
>      power-domains = <&pd_perf0>;
> };
> 
> //Note: The opp_table_pm_test10 are having required-opps pointing to
> pd_perf0's opp-table.
> pm_test10 {
>     ...
>     power-domains = <&pd_power4>, <&pd_power5>;
>     power-domain-names = "perf4", "perf5";
>     operating-points-v2 = <&opp_table_pm_test10>;
> };


> In the use case above, we end up never voting on pd_power5.
 
> The DT parsing of the required-opps is already complicated and there
> seems to be endless new corner-cases showing up. Maybe we can fix this
> too, but perhaps we should simply take a step back and go for
> simplifications instead?

I truly believe that keeping a standard way of updating OPPs is the
right way to go and that will only prevent complicated corner cases
coming later on.

What about this patch instead ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f4598246a87..2086292f8355 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1091,7 +1091,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			/* Set required OPPs forcefully */
+			ret = dev_pm_opp_set_opp_forced(devs[index], required_opp, true);
 			if (ret)
 				return ret;
 		}
@@ -1365,17 +1366,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_rate);
 
-/**
- * dev_pm_opp_set_opp() - Configure device for OPP
- * @dev: device for which we do this operation
- * @opp: OPP to set to
- *
- * This configures the device based on the properties of the OPP passed to this
- * routine.
- *
- * Return: 0 on success, a negative error number otherwise.
- */
-int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
+static int dev_pm_opp_set_opp_forced(struct device *dev, struct dev_pm_opp *opp,
+				     bool forced)
 {
 	struct opp_table *opp_table;
 	int ret;
@@ -1386,11 +1378,25 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, NULL, false);
+	ret = _set_opp(dev, opp_table, opp, NULL, forced);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
+/**
+ * dev_pm_opp_set_opp() - Configure device for OPP
+ * @dev: device for which we do this operation
+ * @opp: OPP to set to
+ *
+ * This configures the device based on the properties of the OPP passed to this
+ * routine.
+ *
+ * Return: 0 on success, a negative error number otherwise.
+ */
+int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_set_opp_forced(dev, opp, false);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_opp);
 
 /* OPP-dev Helpers */

-- 
viresh

