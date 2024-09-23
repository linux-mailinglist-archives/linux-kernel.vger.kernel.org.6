Return-Path: <linux-kernel+bounces-335805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3CC97EAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE127281D10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F3198A19;
	Mon, 23 Sep 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBPbh6gO"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED80043
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092068; cv=none; b=NArEWsccViT3p9BDsKg83GzITPwL2S1kOLLAlMQbO14GrLmgnyuEDV5xJocYqV1Cg8ppAOtxvwXkY3IOnmRumzZQPPYS+giL5gmZPQs/y04Xic17HXorukDNmsjykTHER3EfFIqCjVyA51KKUSvyPeIMpZv89CDRU9qYkuThl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092068; c=relaxed/simple;
	bh=3SbgIdRUjYzuNhjnvUZP+Nr40Ibrmk6328EEhkaeYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF24KtXum3FwASHymp/OGGFVEeJTq+rP4oD20EPodCMPDUkmiTopxfYVJfJT6Umhq4DQyToGtOldHybUU1Ueeh42Yay2vyM8Iiq9RzwhBtKAhLZfGWKYhE16VnRb5nRHha+orzPjq/ypp00TbJCGmqJJ1MdQIRMFOa0GqU32dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBPbh6gO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365cc68efaso22948e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727092065; x=1727696865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0djd4G/7ZZ9d24oyrx0WPtUTMtYC0XKPiOilllFoMEI=;
        b=tBPbh6gOD3GaLZ7DyKBNFx1DpLo8rwv+dTlgCgNQUrCc2+UYpAGMxW9cvJr3Jb36AS
         qQejXXznQGAXuD9G7ILoZQ8Wiyrqa6C6j2wm36ZH/y365mPUhKfd8OFflokshGYV0UQU
         izDUgDGBcFO/3CI30m/dRFV5bOgZoPF1kcxVZER388hROIoz+CvpZZsmTgeRnVnHlKhx
         j5qL0RL+lM6fo/o2tsx0dnKcgfO1bk0wHyRxcfVL9RcVoV6mnJpTy3BZWtLoFZbCJwAd
         0BpsKz7AboD43uQyb0wz2H5fhRRhcOgtozCHwMULMOpXOW3ZX275S9VkTav4UWIxfcP+
         /bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092065; x=1727696865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0djd4G/7ZZ9d24oyrx0WPtUTMtYC0XKPiOilllFoMEI=;
        b=s2JngYLC2HIz35gUZ/zozxoZ0m3tSZnbfs6nZkuQAyPr6UQB4LQS1BhD/5I31aMN3d
         C7j/eJAlIYz5R5xlJFwhgFdV9ifVlt4/jtLKmOBO/gQTKZMJaY6wDfZak++6izTI3LKh
         L6qvo6IDGIWitaj07xe8VQO/kiPLGeWDx6kcTmqvoSgoUNTaDePGAY9/9HYyj/7v6oj8
         skPLWVYqk9rO5g8zx7pb6hyUp6xF9cAydHzLowcKAqmw/FDWFr7OUxikelaRuDLVBREZ
         4/9Bd0mNiWF/m7HTDPfzZT+LGnYn2r0pqMgsIGOvu271GXM1veX90INBmc9e8oZ2f2Jv
         fEiw==
X-Forwarded-Encrypted: i=1; AJvYcCVtwSCap+yWbZV9JLgKI97Qnu7EUKuYXxkkzkpPTueVZOaQ4I5S1S7REzIx9Kb3iV6Bx7MM4lNobUEELrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytndA0VwlWw3jiH9b6Xxl0E5Fg0u24MuZgwji3eA1SvHCtNCIU
	kSrfsNxANkbuT6ZFTwm6TBut6gf1H0UAJH/vntehzUKSPcxDuprscvN7ci6RWO8=
X-Google-Smtp-Source: AGHT+IGOWlf1E3MK25Ig9GpguOQfG2ei5zN70UwUJJU5oIGPcT/EQOZr978PoKbxaP0b1IeYvBKH9w==
X-Received: by 2002:a05:6512:10d0:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-536ad164335mr5499187e87.16.1727092065029;
        Mon, 23 Sep 2024 04:47:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704678asm3244982e87.5.2024.09.23.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:47:44 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:47:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, konradybcio@kernel.org, 
	andersson@kernel.org, simona@ffwll.ch, abel.vesa@linaro.org, robdclark@gmail.com, 
	quic_abhinavk@quicinc.com, sean@poorly.run, marijn.suijten@somainline.org, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, quic_khsieh@quicinc.com, konrad.dybcio@linaro.org, 
	quic_parellan@quicinc.com, quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com
Subject: Re: [PATCH v3 5/5] drm/msm/dp: Add DisplayPort controller for SA8775P
Message-ID: <vdzxghgr3uhj36mjqnphagf2mftpsnqg3mubjo7gfiexcrdb55@6i2s7s4a4qr4>
References: <20240923113150.24711-1-quic_mukhopad@quicinc.com>
 <20240923113150.24711-6-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923113150.24711-6-quic_mukhopad@quicinc.com>

On Mon, Sep 23, 2024 at 05:01:50PM GMT, Soutrik Mukhopadhyay wrote:
> The Qualcomm SA8775P platform comes with 2 DisplayPort controllers
> for each mdss, having different base offsets than the previous
> SoCs. The support for all 4 DPTX have been added here, and
> validation of MDSS0 DPTX0 and DPTX1 have been conducted.

I'd prefer if there was a word 'only' in the last phrase, but I can live
without it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
> v2: No change
> 
> v3: Fixed review comments from Konrad and Bjorn
> 	-Added all the necessary DPTX controllers for this platform.
> 
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

-- 
With best wishes
Dmitry

