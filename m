Return-Path: <linux-kernel+bounces-419161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBF89D6A25
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6353EB21824
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047C44C81;
	Sat, 23 Nov 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khstgrlT"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACF17736
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379535; cv=none; b=BugCbV6YLnSfRUI0PjTW6p+QzGLqcWsf9B1fzzsH8wmWx/8tcmh8G3lZP+U4nVgfc4KjYjpi5PX04Ba2BR/TWNnMC6BdXPtZx3EeZFaliMisurQ0wBKm8432j7atkjQb8/LDgRMyiIg0skz9A2ocaxtTVFCkg54iKxu2m7Vwce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379535; c=relaxed/simple;
	bh=dIpO4kbW8cyJ+9JZaFOjMBIi6VHmtHYF7j+sMn9wMmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtk5cXpDgmgUeA20akHPiEV+iYEzZ1ZIGfgXJUD3g7ZoPLFnSes1SMKGSqwzSO3BDP0aqzEVrdVVYaqRbxOk2i3VYLCqSKtXeQbU89aMS9o7mH9COYiknVLZ+2nsFGvogKbtNAOjM8jk8PeTIAy53m6vrNKV3zwRP4x9UKCrT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khstgrlT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da22c5863so3759364e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732379531; x=1732984331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MxevDa9VlZfQk/6diKJ/RQ0XTFV8JaAse1FnOzuzGI=;
        b=khstgrlTdWjxJ9rZW/n6fyrhgyGDDHumwa9Tf17Pbf8tLGgx+SvyIjV1byesXOVh2+
         mc4waXQNz7CCtCZsG3R+VdBInpyksGSfCV8Mwn2kxA5/lmjyJzomWXoMX+3KxVzRmbG2
         MqO3JmaLfwwS8hKg5HKsvclC80CV5yagcvC9+zHTotFIWZW42/z+PiNhAELNb1jVZ70/
         yAnbIrmaRIPnKyvWDRCV9LOdUhjsYrqEY1tJKDSKjqV3rBTNL5gMKC8DULjXRbQkH8XJ
         EYbAVTrteMQpwaRfBfJSdvzXr/d2wZ1+H+l7uutn7I7zaFWlJN3CRewiovY0oTPtffne
         gyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379531; x=1732984331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MxevDa9VlZfQk/6diKJ/RQ0XTFV8JaAse1FnOzuzGI=;
        b=v51OxJ/QajyWKNeG1wYZBw8w09eEJW1GZKw3UUpTga9623yHwOI5dfjenvLlgUzVYQ
         5XnTccP/J0Blecr9tFiqHXOvy6BxzH8FQ4T7PdpDYAmdFCGy9dFIGpZD1lF2kji3mOCx
         zuvdh+DunZs+HU+K5AApqumXt8t0PtEf7j47UE/p/Ol5h1yt2g9vib3uaZnPIKXrreCf
         mLhXH7Dx6b7R589ECZTES6nKu6xN8r9Z6gOnPoQe8FBP81AHQFQY3h0+WpH+NYelQkGg
         HTXXA1r5wIfuiY6wB6ZYEwNNXPe6wqqNmE7NDU9XtVY4zOxBzFEZ6JCbdZXhscphUkNt
         QWUw==
X-Forwarded-Encrypted: i=1; AJvYcCUgP/+Eq0JLnYxTyRZB7hqDqqkAfTBeOjRtQ+L6DL0DcBi26rXROxKlDLWpTT8yZuew8gjReJbwPI/IFhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSk380RhiVqTGGrXVg6rasP0ApMSTvsKWjX5JlTb/vv6Eto7Y9
	dR/NqYBlivCvDOABQtGOVRKMP5alh5JcJ0nWt2aMY98j81Vlu4fXKGqosckclMw=
X-Gm-Gg: ASbGncuC14IZkDbUln/SWXrl23aWYMyqEEv+aGnSqQpUvWcD1nSb0ak2r3t0Bv4Id2x
	j/W16eNqoQIbFaPOh5kH5/5Oa07qkX7GnXI/G5QiHSS8rbXqZpQ/1jdPX4S7j83cyqhR8JIZFng
	He1Cs3DPKZxo8WMAMjhcA5TnORdt8GQKiSv/wKc4yGydJodtAKKS/J2o5jfPBfy5Xmh1nzwthgK
	jTtgcS136pIjVzR0Anfk6EA1CUoBx+Q2unn400CyfAYWKFOykwbzAS3+f5RJaMU3LXM7bNTc+HU
	xhfZalDgGm+jn74kWZ/2rKcBY0BGFw==
X-Google-Smtp-Source: AGHT+IE/kpuKX9Z55uF4fzpcyiUmNjnR2bVsf+7KIIGnKThLK7KcQSqBM0gFxYOZnj/rPZs2stSn0Q==
X-Received: by 2002:a05:6512:3b97:b0:53d:c37d:3378 with SMTP id 2adb3069b0e04-53dd35a5531mr3263454e87.5.1732379531348;
        Sat, 23 Nov 2024 08:32:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2450a7dsm970118e87.59.2024.11.23.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 08:32:09 -0800 (PST)
Date: Sat, 23 Nov 2024 18:32:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Song Xue <quic_songxue@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manu Gautam <mgautam@codeaurora.org>, 
	Vivek Gautam <vivek.gautam@codeaurora.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: qcom-qusb2: Add regulator_set_load to Qualcomm
 usb phy
Message-ID: <3zvstdxhgobn64ttcggmk44ejsroxmwe7y25rraebh3p4evsy6@3g64a5tuvt7w>
References: <20241121-add_set_load_to_qusb_phy-v2-1-1c5da1befec0@quicinc.com>
 <7qj4szkw365ve45hm5w475xs2vlfsfg5pcpc44bo3s5vhrcmuu@bh5swbug4ywi>
 <b8cd1434-8096-4d52-8499-9d25cf3805b8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8cd1434-8096-4d52-8499-9d25cf3805b8@quicinc.com>

On Sat, Nov 23, 2024 at 01:07:06PM +0800, Song Xue wrote:
> 
> 
> On 11/22/2024 6:24 AM, Dmitry Baryshkov wrote:
> > On Thu, Nov 21, 2024 at 04:09:27PM +0800, Song Xue wrote:
> > > Set the current load before enable regulator supplies at QUSB phy.
> > > 
> > > Encountered one issue where the board powered down instantly once the UVC
> > > camera was attached to USB port while adding host mode on usb port and
> > > testing a UVC camera with the driver on QCS615 platform. The extensible
> > > boot loader mentioned that OCP(Over Current Protection) occurred at LDO12
> > > from regulators-0 upon powered on board again. That indicates that the
> > > current load set for QUSB phy, which use the regulator supply, is lower
> > > than expected.
> > > 
> > > As per QUSB spec, set the maximum current load at 30mA to avoid overcurrent
> > > load when attach a device to the USB port.
> > > 
> > > Fixes: 937e17f36a32 ("phy: qcom-qusb2: Power-on PHY before initialization")
> > > Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> > > ---
> > > Changes in v2:
> > > - Removed "---" above the Fixes.
> > > - Link to v1: https://lore.kernel.org/r/20241121-add_set_load_to_qusb_phy-v1-1-0f44f3a3290e@quicinc.com
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qusb2.c | 13 ++++++++++++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> > > index c52655a383cef008552ed4533b9f31d1cbf34a13..80f0d17c42717e843937255a9a780bbae5998535 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> > > @@ -722,16 +722,27 @@ static int __maybe_unused qusb2_phy_runtime_resume(struct device *dev)
> > >   	return ret;
> > >   }
> > > +#define QUSB2PHY_HPM_LOAD 30000 /*uA*/
> > > +
> > >   static int qusb2_phy_init(struct phy *phy)
> > >   {
> > >   	struct qusb2_phy *qphy = phy_get_drvdata(phy);
> > >   	const struct qusb2_phy_cfg *cfg = qphy->cfg;
> > >   	unsigned int val = 0;
> > >   	unsigned int clk_scheme;
> > > -	int ret;
> > > +	int ret, i;
> > >   	dev_vdbg(&phy->dev, "%s(): Initializing QUSB2 phy\n", __func__);
> > > +	/* set the current load */
> > > +	for (i = 0; i < ARRAY_SIZE(qphy->vregs); i++) {
> > > +		ret = regulator_set_load(qphy->vregs[i].consumer, QUSB2PHY_HPM_LOAD);
> > 
> > Please use regulator_set_mode() instead. Or just fix the mode in the
> > device tree, if the device can not operate if the regulator is in
> > non-HPM mode.
> > 
> Thanks for comment.
> 
> From my point, regulator_set_mode() will change the regulator's operating
> mode including current and voltage, which will also influence the other
> shared consumers. Meanwhile it is unacceptable to fix mode in the device
> tree because it is determined by regulator's device tree.
> 
> According to the required fix, regulator_set_load() simply aggregates the
> current load for the regulator and does not affect other shared consumers.
> Setting the current load is relevant to the issue.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Regards,
> Song
> > > +		if (ret) {
> > > +			dev_err(&phy->dev, "failed to set load at %s\n", qphy->vregs[i].supply);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > >   	/* turn on regulator supplies */
> > >   	ret = regulator_bulk_enable(ARRAY_SIZE(qphy->vregs), qphy->vregs);
> > >   	if (ret)
> > > 
> > > ---
> > > base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> > > change-id: 20241121-add_set_load_to_qusb_phy-d1327c797ffe
> > > 
> > > Best regards,
> > > -- 
> > > Song Xue <quic_songxue@quicinc.com>
> > > 
> > 
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

