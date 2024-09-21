Return-Path: <linux-kernel+bounces-334771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FF97DBF9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A1A1F21E71
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3414BF9B;
	Sat, 21 Sep 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR7HXi+s"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6812C9D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726903304; cv=none; b=tRqvmrdNZve/CeiRzUXP8EyAoHzXsp9ATxtVNlK4WQUcM/CNOsWA3rxTU/PR/6AySsKSe2ZKCFPMZJ/Fddg6GMLvSOX1H4sXYP0U6+g1HqzMuPYrDO3+VuiihqQRAXlB76qc3ZyWTuCXYZwsw4WZlzRLHTu2O8U+5591rywycj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726903304; c=relaxed/simple;
	bh=fiG3hOaA7XA752vx2vS+8PIWI70Gh9F5G6AZUWz4/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwj87IZLSInzt6Es/t18Qr05FkQMXYA9tIA3ebOqAuevoVWUgp1qWbZObZtqZigcRsFneChn2wfkRiFQlIUcN3PVYEOFJEc3P5bGDmVFFSyX2JDj4m7UFFBuVYyMWhp8hXgPksJcj98Ivic6fubGVBQLjTkdTUaUKBu60MAA/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iR7HXi+s; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-536a2759f0eso3617048e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726903301; x=1727508101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZZdu3nG9tnEBLi6sg75S4kfE8Xv5x2MAWLMz7iRXfI=;
        b=iR7HXi+sU5pB3h3tYBFTzCwe4pL5lnrPhBdW62pF+lfQFhS7rzHWR2qFX4nQrx3VxM
         dw1UieZd/iitT0xEb/kVaKkLT1rqPBCsPMo2HhOKXa7r2hwNyflhj5mbT2E1UdEmSa6d
         yHio0HvRjSLRXPwETH0IM2tTQd4hsqKxgxOsAu08CqB9pSgeHvpyeAyymDZtfttiToFC
         W4VuPT0GZ036aJ74ZbYqT/xjXFRovfBKVUbmhgO1QhRz/9BQjtDxPTbule7Puqa6+ePP
         fdOPPDAQ4zRZQAfWaX9fL7+wZ91pNwCk/i0J5jVrQdwIaz+Teo3zMNwINLwVTbEn+OAD
         6wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726903301; x=1727508101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZZdu3nG9tnEBLi6sg75S4kfE8Xv5x2MAWLMz7iRXfI=;
        b=AMsg7qJI7AVU9ywb4GGxTiGM3XBojXWmCpAN2XJ8EV/XCVBlyAb8Lsxu2puYgDh6CZ
         9QI6rWdOlRhwe0mVwyjgrHyVCZa65YoY1UUotC8bAP6NCiEYoYhJBwkxbd5X0t+95rvr
         EitXB4mIm93dSf491nVfSZG6Az0CfzKFns3AuSSKITQ4DCXXYaExj/x0hdQiE692u4ba
         NMJIIwXY4sqq/FCcXx4ahlHRct5dhOc0V/y9H3HpZmLbDwIhYoiptXaB7Ga0YqCe2FOn
         9hPmfDVizlshjsowDIrVAP77GdKAB3m8gno/O0KxEjboehRxbLpQgAWpnGCdy4+ZTq0Q
         NVSg==
X-Forwarded-Encrypted: i=1; AJvYcCV9rotMpHZzoD5XcJk1cGUEqpSVvRkzrPO4GDaN9OIYoMW84zMk16PjqCRPSWLqVXuJ7QoIJFEOl8TNP0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+U1DUjgxtlE1+8mx3/56RNOF1OlS94dg1GVNfzCO67VdVtj4d
	3ZMgHKetZHcEdGDQ5jtJn7nKcD8cS1nkwUohKMZbL6VDRpC7HqQ/dIQpOFpVGew=
X-Google-Smtp-Source: AGHT+IF0hxBF9skV/bG11iGeIxzhShS9O/B6D8X6Tmf+0dBjjxjYBBlzJE0px7XHVZWrZjZWJvNHzw==
X-Received: by 2002:a05:6512:3ca8:b0:52f:cdb0:11c0 with SMTP id 2adb3069b0e04-536ad16b1fcmr2786192e87.21.1726903301102;
        Sat, 21 Sep 2024 00:21:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704e995sm2501278e87.106.2024.09.21.00.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 00:21:39 -0700 (PDT)
Date: Sat, 21 Sep 2024 10:21:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] firmware: qcom: scm: Allow devicetree-less probe
Message-ID: <fqdmcct5b5sxv3rpxiksmzpjbpcwmyuwpb5epjnhgpzxh344pp@pxggownwv44n>
References: <20240920-scm-pdev-v1-1-b76d90e06af7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-scm-pdev-v1-1-b76d90e06af7@quicinc.com>

On Fri, Sep 20, 2024 at 11:01:40AM GMT, Elliot Berman wrote:
> Some devicetrees representing Qualcomm Technologies, Inc. SoCs are
> missing the SCM node. Users of the SCM device assume the device is
> present and the driver also assumes it has probed. This can lead to
> unanticipated crashes when there isn't an SCM device. All Qualcomm
> Technologies, Inc. SoCs use SCM to communicate with firmware, so create
> the platform device if it's not present in the devicetree.

Which devicetrees? I assume that this mostly concerns arm32 machines,
but I don't see if you have tested this on any of them. Also on some of
those machines SCM require additional clocks, I don't see that being
handled in the patch.

If we are to manually instantiate SCM node, I'd prefer for it to be
explicit, e.g. MSM8x60, create SCM device, using this-and-that clock.

> Tested that SCM node still probes on:
>  - sm8650-qrd with the SCM DT node still present
>  - sm845-mtp with the SCM DT node still present
>  - sm845-mtp with the node removed
> 
> Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM allocator")
> Reported-by: Rudraksha Gupta <guptarud@gmail.com>
> Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/
> Link: https://lore.kernel.org/all/CAA8EJpqSKbKJ=y0LAigGdj7_uk+5mezDgnzV5XEzwbxRJgpN1w@mail.gmail.com/
> Suggested-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 75 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry

