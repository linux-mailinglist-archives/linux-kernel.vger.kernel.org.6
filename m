Return-Path: <linux-kernel+bounces-371424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F549A3AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EA7282464
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3229188A18;
	Fri, 18 Oct 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8HItveP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA0200B86
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246095; cv=none; b=OMVDqCv0WLMPREtG367ApG60x4I8VkbRC7zpm/VvtKHB0UKcpn13bmp6Qpq/CcZTkYlbyk4JUtl6d5pxcfMjM2C9W/v+3ZtkrhgOULxM+4acsPQEZSzvpeycag/4keXYcpCp1x86iP/qLSuCXpc/oeOTTi6vicfO3oeNzrH8CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246095; c=relaxed/simple;
	bh=4uBJVji3ycVqZ6CU17CaXtEQ1m7RmscWbQxhamYSdRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXfroTyX7VvUIweXWapl6+dNXVkvlTyD3kGGU3kpGxduDuvMM3tT7PoSI5WS0EBwQV8SfQBGFFQC7lYGA1QaNNXN/yiVMNcq+YBewMnuoOOUvT6BqHPAKg5f5eExBIMYAmy02V2MJok+ayT9WMb8rP/IelbTpYCzxDlNdHEf6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8HItveP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe02c386so3061839e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246091; x=1729850891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWO5SIPIA+/rWAYr4Euwe43sU4NAtmP9U+0QgyOHFx8=;
        b=b8HItvePFF/K+CgAdGRNwTO3JBZZfTp+ZzLWlAJq8udeLkOeiPwvoUd9G4acAStLw1
         6kZSmb7HvPVAfE8ecCFk/9fTtNhiaG0rOhWk11cVFN0F2kT1KgvdNJ8/O8J1xmS8oQtd
         hInaE2gssEht4hf1iNwyW4cKp8j6SXwv8y5fdTiyskOZJ/FKKVkfVx9pQeVt+lEHLrIE
         DFMGpzEOaGl0QD64BlzCetCjx9XuJfXmAPc3IoGSP/5TelPE8kIRKBxj22pem2SKNrtL
         pttbDsSio0kFbB6etdU7IUc4abRGWG1ajPqK0Van+A1lbJp9DjqTiCnRA5Y3PUT5HbjL
         6Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246091; x=1729850891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWO5SIPIA+/rWAYr4Euwe43sU4NAtmP9U+0QgyOHFx8=;
        b=s4s3U4sXgdquUtDlbj1Wq+EIEoiHV8uKWydoeMd66vPSEC18ESrMP14OM+qnQ0mgjy
         9IZOoRmYmUoatPd7MTKoYhDthEUb5bNOpPMnqy0gdOmXvAPtcNEnUnnzanRD0xzvDmzZ
         Hq+LGL2dATRN1xoKUCEnp9I5NWd+gku5IvdYaSwHzfh0hpg+qtngIE8NqIJqCstNQpNh
         d0LibGJZ2FffZqNantptl5jEG4X5gYHrbPqB0flWRI6v3OOTOsS36eGwCGAfM/2rqJ7f
         u1naMzv7Zl84WJmMYAFIYh00Tr2y4tSjjoTKrV4+8MkpoJSOkPxIiP/jV7M9M396lgBy
         giFg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ELN/1YuQ0HLZtYkzW3WPUszLUUaOBol7nlBnKJviZanSIGKF18iMMx7gByqCvrhyJ4lAeEBmgEgWQXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJxTPs7kKVT3ecC7KQxiTbF8AQS9/ywjg4w0xD2KTq8ah2yuf
	eMgNSxFoUoZljm8d3a8sjWKsV5D5LtaRQkP22gSqVHZO3Jub4MCTb2Sm/+yNY6o=
X-Google-Smtp-Source: AGHT+IG2fzF1NEqkVxyx3ltslEHQ5ZS8VwVmoBLD0KSZElJbLsKJHZFOX9qwuUQyNzdp9PiQBHBbNw==
X-Received: by 2002:a05:6512:e9b:b0:539:ebc7:97a2 with SMTP id 2adb3069b0e04-53a0c73434dmr2093811e87.19.1729246091341;
        Fri, 18 Oct 2024 03:08:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0db9sm175433e87.151.2024.10.18.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:08:10 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:08:08 +0300
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
Subject: Re: [PATCH v5 0/5] Add support for DisplayPort on SA8775P platform
Message-ID: <vtfz5vteaedwrqw5cpggmd3esi2rky3f2axubxukh74wdux4uy@zdac7miws5lu>
References: <20241018070706.28980-1-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018070706.28980-1-quic_mukhopad@quicinc.com>

On Fri, Oct 18, 2024 at 12:37:01PM +0530, Soutrik Mukhopadhyay wrote:
> This series adds support for the DisplayPort controller
> and eDP PHY v5 found on the Qualcomm SA8775P platform.
> 
> ---
> v2: Fixed review comments from Dmitry and Bjorn
> 	- Made aux_cfg array as const.
> 	- Reused edp_swing_hbr_rbr and edp_swing_hbr2_hbr3 for v5.
> 
> v3: Fixed review comments from Dmitry, Konrad and Bjorn
> 	- Used a for loop to write the dp_phy_aux_cfg registers.
> 	- Pre-defined the aux_cfg size to prevent any magic numbers.
> 	- Added all the necessary DPTX controllers for this platform.
> 
> v4: Fixed review comments from Dmitry and Krzysztof
> 	- Removed the "reviewed by" and kept only the "acked by" for 
> 	  patch 1.
> 	- Updated the commit message of patch 5 to mention specifically
> 	  about the validation of "only" MDSS0 DPTX0 and DPTX1.
> 
> v5: Fixed review comment from Dmitry in patch 5
> 	- Aligned the register starting address for display port as part 
> 	  of device description with respect to other targets.
> 
> Below patches are applied:
> 
> [1/5] dt-bindings: phy: Add eDP PHY compatible for sa8775p
>       commit: 7adb3d221a4d6a4f5e0793c3bd35f1168934035c
> [2/5] phy: qcom: edp: Introduce aux_cfg array for version specific aux settings
>       commit: 913463587d528d766a8e12c7790995e273ec84fb
> [3/5] phy: qcom: edp: Add support for eDP PHY on SA8775P
>       commit: 3f12bf16213c30d8e645027efd94a19c13ee0253

Please in future skip applied patches instead of including them into the
series.  No need to resend the series just for this issue though.

> 
> ---
> 
> Soutrik Mukhopadhyay (5):
>   dt-bindings: phy: Add eDP PHY compatible for sa8775p
>   phy: qcom: edp: Introduce aux_cfg array for version specific aux
>     settings
>   phy: qcom: edp: Add support for eDP PHY on SA8775P
>   dt-bindings: display: msm: dp-controller: document SA8775P compatible
>   drm/msm/dp: Add DisplayPort controller for SA8775P
> 
>  .../bindings/display/msm/dp-controller.yaml   |  1 +
>  .../devicetree/bindings/phy/qcom,edp-phy.yaml |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c           |  9 +++
>  drivers/phy/qualcomm/phy-qcom-edp.c           | 74 +++++++++++++------
>  4 files changed, 61 insertions(+), 24 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

