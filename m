Return-Path: <linux-kernel+bounces-271802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695D94535F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95221C20C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE414A0A7;
	Thu,  1 Aug 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L25Vj7Nl"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D971487E9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540432; cv=none; b=pQHTZUe6IhHVnfXkj6SiaiMl+ls6kUCKGzNKJnc4bHmh15/3BUxeNNryvTJ/5IxODD8TmG7QTPFujx7jZnSU0GLMLY5Mjc3fHnkirm0U+c1dl1Xb1gWQ54ofRWjSXTIfbDvUW5GvJri131l9KUnhGdJLX0UxvHReuTXyDLbuiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540432; c=relaxed/simple;
	bh=wkOZCY9N+tEWf9xzIT9PoKCpQBLabjsUfn7YGlJsLAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0IY6tHHXOT3t0HWcpldPs/O30tbm2tJ6qGZq7ByItX9yulUJ1tTc077vffjnioNDFY509lx9rX3GnD1PE6Bsiq/IqDhFGrbhk8b5BG1erMBukG03Egy2a+F2yPOL62BPPqhHBgHOi+G1r6iWofjpxxRJoQQ9Lkyjf5bh4LteaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L25Vj7Nl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso107464021fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722540429; x=1723145229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDiQzKV7V2fFU3bp2HZ8kCtvzTR2/LI8LX+WVgvxAC8=;
        b=L25Vj7Nl6ixJbAgxZZ2oYe1mHK0DsOj/uFkg4Yd9NstNUvxcAw6lPmD5MXsIq7ZhMN
         ETtYpvOH7YgwzNEk+I8CeEIuSpLDtl95j61VOUieuPaNcJtc+Xu4aE3k3aiJD1yNCNbS
         1JQY6bi7x1u+8JPg3CPoT8jSsO8s3MOui+9bLjzJUq597sG7Vi7iuzxALJZK9J3FUoLQ
         yQ+4tyExDn4fSgll5GYIPh+j2okSgXhjjiPuR9WgQGcuj8pIWNxNtnSXP39j0VnoaZbW
         U05GJrTFUXfZnQN2wyfYqfesGoZ7Ccol92rEDZ8ww07p3vu/Lgdv/IKHQmVb81ohl02s
         ZRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540429; x=1723145229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDiQzKV7V2fFU3bp2HZ8kCtvzTR2/LI8LX+WVgvxAC8=;
        b=hmZTZfeGtffhYin06GG2uZc5Kwo06EE927z8ygx3jBo0j0ZHfEyF5ki3F+K92JatFr
         6A+k+bK7/oacFEFBWWhEVHf2HjyCYOhftAgKY8St/A5SAoeZnKKhyiXVnuCSufXCBwkn
         sshYou0kcCbf/nXSPchH8Jk8z7IagUvZdm1/+wXs7Jf8yH9Ku62Uyl75nLo/ssAag9FV
         om2WgOAIOSRgUcxeyLaD6dBosGhcL7CqKKrZEPiLSw6SSM5gqZb3zu8u+3eWZYhFMXjh
         W1tYIbeZCXMr4aCro+1R8YzSay6xr5txjz3L9KSZFxrs/0APmRJGl5WAwXCXr16qCW84
         Lrgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFheP3hX3xBjrWno1uiGZ2774uwuzhlrN2nITUSOotmZUCVYganQUwvW95LZyTaKq+HXRKpdapGeFdlrIAYZi+Y3ZRsZ1LF2Q6O4fe
X-Gm-Message-State: AOJu0Ywx2Ng00A08Tl+ggMi4LqMLGNvOboSQX4a+NerRDQA8dQeeThzT
	Re+TEcRtcfk+yNxe1RawAq10IcwZA7jLKik99aZZusoQAXMDUeDZje9x+mwCm7Q=
X-Google-Smtp-Source: AGHT+IHKqGnemhTJWJyNS+fY4snJ4ynvhZOVxkj5ompO665PXfS0Z2yTSf0YbR0e5lrQvkeMNSvYGA==
X-Received: by 2002:a2e:b70a:0:b0:2f1:561e:c329 with SMTP id 38308e7fff4ca-2f15aac4fb2mr11233151fa.26.1722540428301;
        Thu, 01 Aug 2024 12:27:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15c45062csm301111fa.109.2024.08.01.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:27:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:27:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v2] phy: qcom: qmp-pcie: Configure all tables on port B
 PHY
Message-ID: <37id2c7h33sj7p3vlo3tiv35qta7utee6aswieyy2b64get4bk@eqjjakr743fx>
References: <20240801-phy-qcom-qmp-pcie-write-all-tbls-second-port-v2-1-6e53c701e87e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-phy-qcom-qmp-pcie-write-all-tbls-second-port-v2-1-6e53c701e87e@linaro.org>

On Thu, Aug 01, 2024 at 06:54:53PM GMT, Abel Vesa wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Currently, only the RX and TX tables are written to the second PHY
> (port B) when the 4-lanes mode is configured, but according to Qualcomm
> internal documentation, the pcs, pcs_misc, serdes and ln_shrd tables need
> to be written as well.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Reordered tables as Johan has suggested
> - Link to v1: https://lore.kernel.org/r/20240726-phy-qcom-qmp-pcie-write-all-tbls-second-port-v1-1-751b9ee01184@linaro.org
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

