Return-Path: <linux-kernel+bounces-434627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBB9E6922
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EDC164D67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D106FBF;
	Fri,  6 Dec 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEHB3Yfh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD81C3054
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474343; cv=none; b=sN3KAto//A1uk64kkGF52XeI4UlIy2CSD16Bg/+Vf2pmsHBWdbu/Peusn+qwMHsQRX6cR3RFz0yWMEOH6oL4wt+Rjo+ElxuKZe1DO0L4QCl1bmdlDPRWbbxve3rqLQOc2Acrf/EI1+L/4jlEEbLQHfzqNST7hN/0fwxRLEWPZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474343; c=relaxed/simple;
	bh=CbzbQCOtdOjN0raEAF8iseTHj/jr2mmJa+ApPFP6pOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExKhGEEb9Rsre6f57DTvEgAmQ/gzCw3WuwZZyWKx6do1rWB1uxPg3QVtkwPKldOrB2KofEykUxJ1p2/xyNrWyPjxNL8KD2/IskRMWvBfIM7yZ0rB/GZ/uABvW2AmvtzysbK5UQ4BI8KhCKuwWJzwfr4sNC3cDLhtNX1JXXUKL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEHB3Yfh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso18400911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474340; x=1734079140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pvfFf/6NDNSMoinPIggBLinWMjnUSRNWqgC3AbSwgA=;
        b=LEHB3YfhPIlY+waYLjnjFx85bCTwjDemhDoOD3uRq30N/C3gGCZRp53u+pe7cUdxky
         vSFiY50KGt8U/h9r+YeiGQxzdmeZVwBqHNfDmovTBtbVXI9dlcyR6WocRjKWxXoO2zUX
         kcEsrohrKmMDyptVBGLlAoITrjI7zSN7dwBYaJJ8sFd1ProlNhGyujay/PsWRIWgo+Ln
         RLIBG/0IyvZ8soP7Gyq2fQiTHpt3T5eGYpHZ4g/1IESXXeRaGeHr9kaWbylelPHsEcQq
         9l1qMjh7M/XPUdYkkXKgLTyfhjVMdo0LVypNB5fecCuktCV+UUsjOtBApl9Ocm2AeYsB
         fM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474340; x=1734079140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pvfFf/6NDNSMoinPIggBLinWMjnUSRNWqgC3AbSwgA=;
        b=vHj/jpGDCKMlCKdXgqsIVHKG7fVNgm8r2Gwy4qsb1S2zY0quMVEH/LX6mSycxOTxRz
         1tUEkZ/VrPvkm72ebwuCJGyqJm+3yWeBrCiT7aXljifLFd/9Rvn38Nrdhxg2DFriFlgl
         T3r5rM/XRelVzrhJybLIN7gbbYTNtCMWfC1amK1d4S4FYVUKPX7dq4HK3XVVqy59E7Tt
         DfmsqjZ4uzmSka6v6KXuMP+jyqZpikg1lkJVifUnkPY14Eu76ev55+RvrDmDGQektorA
         y9U9dHkHsrBYzIeIFK+ZhwET6Kwgzj2VLASKaaAGzMqdQ1M/BQcP/XLPRBANMKXWZ28N
         FNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw6QDmofcVdHdhAdjYoteNKJaiF6+/VOZUYfX6eMMJBYYc/HmcOu4GbBDf+6nmK7ajGUFfeiuIHcpBTWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIamefP14GCq/JUMeJvcqQuc0D/cktV0aaqcVmE5O6NscZMvzz
	shMNYYwuE0ZblESyfEGzAvkzclopI6j4SJ7PKm4eOAmgXyqlGwZYTK8ISMVxEH8=
X-Gm-Gg: ASbGncsLhInPRbEZotSbzQ73jZEk79szCBao9X9SsFacAgNic0lFUUmPuTsT8Tyfgn6
	A3nOc6j5hLSYZdc/05A1ty4Ybt/485D5fMx9W8akdq9EjY5SHVg6XxhPiNNCZM3nDli0ht2+XcT
	Lm7PKEMFbAYrdbkFcsAOwwJxRdqisabgTeJCITJ2GXsS+ALWb6faqMx+H1grA8o0sObh+HOZJme
	6DQahgakBFcynyXYFP7Rbe62BgUl/HgkNizZsvaqlIW0Iil/543a6SFLLASSiVjL4VHsH3Ye5ce
	ZPRAkXSFNR4gyy+E7ZcQZATgn0JsUQ==
X-Google-Smtp-Source: AGHT+IF6jOtbfo5h6K0/IZgJWEqqGaGGkKnUPirENty8sxWRk/6JZs4RfsdDJScIMrUIWenQ2Ic/pg==
X-Received: by 2002:a05:651c:886:b0:300:2dc8:41c0 with SMTP id 38308e7fff4ca-3002fcf312cmr8313101fa.41.1733474340135;
        Fri, 06 Dec 2024 00:39:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d858b4sm4111111fa.4.2024.12.06.00.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:38:58 -0800 (PST)
Date: Fri, 6 Dec 2024 10:38:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 02/45] drm/msm/dp: disable the opp table request even for
 dp_ctrl_off_link()
Message-ID: <pouqn275ajaerpicruqepijjs4zuteid3ocqyczdja6o2zhpwl@dt3ckyixmzrf>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-2-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-2-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:33PM -0800, Abhinav Kumar wrote:
> dp_ctrl_off_link() was created to handle a case where we received
> a cable connect and then get a cable disconnect without the corresponding
> dp_display_enable(). For such cases the pixel clock will be off but the
> link clock will still be on. dp_ctrl_off_link() handles this case by
> turning off the link clock only.
> 
> However, the vote removal to the opp table for this case was missed.
> Remove the opp table vote in dp_ctrl_off_link().
> 
> Fixes: 375a126090b9 ("drm/msm/dp: tear down main link at unplug handle immediately")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

