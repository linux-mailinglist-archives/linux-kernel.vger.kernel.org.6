Return-Path: <linux-kernel+bounces-226451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A21913E85
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03E6B21647
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69921850A0;
	Sun, 23 Jun 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp0XTQhZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D21836F5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719177895; cv=none; b=rFXJo6ehj7ksXVvkmgTB5EAfSwBHaP10kU9TaaI8BhsVtZDzQw+2a5KieUrDdeuqQHBZ46kFs/x6mG/na/oH+LJlZQSTCyrna7NWtGOfJcOm7ACbZBQS0lz/UzTB9+EGyyGYOxMl2gaU0AWH4u1mAmkAJR1oc4hTlbkPlGlYBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719177895; c=relaxed/simple;
	bh=AwoBBqR1ZRIfVRs1f9k+P8VRbae5Ab0Eycxpuoo3d84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3Oqh8on/1noqlYmwdq5PFn+ihcJ8ojB0RbtS1YttvEAkLl30p86LbpCfMqo0j3fdlF6AU4Tx2UuDMRrxH/EqPX6rQTY8m4WNIsx7Kr/Qrg0QLkh4hbtVCaZIUNRtA1RoiYuEqsFlgEqU5njOqv1jK/fJY/AGv/KxnU/1CrUh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qp0XTQhZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so1933768e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719177891; x=1719782691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNAVEXZ6+S4MEQi8nN59EgiF6h3aVPXVSlq4NFoo3+o=;
        b=Qp0XTQhZfd06XJxGcqYmGgxjq5Vnir7hPbsu2ymiewUKyW6FMdA3rC1WDVVYPWqVOS
         5PFM2MfWjyUCf8zHCUJoioHSAwTNDQm3REPhWQGlvyZKFoVmAJzN6gtHl++VqzWeLh1/
         CBk1HRfTKTc0M5hlPAGjn/VCAKaSqHQIzfjzCmEwSN/tyGirOZzcPHJoQtymM4Mhoa66
         QY3FUdIjDPRHI67w3Phr0lfYbDaubx7iQznIdeBvdbGA345kXiTPblLIWkhHSKqrrB80
         TZ1wd5LoZPHP0JnDhukUKxXlrJN3u7u5w5TgU7w2k235Bb6tRK3P1in4K/vD+rFeoriD
         yMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719177891; x=1719782691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNAVEXZ6+S4MEQi8nN59EgiF6h3aVPXVSlq4NFoo3+o=;
        b=FzgJCq3yrig5i/ukjtEoYRJAtluPmDofrWru9MK7fF1aV3QjA/0FbMmrIaWuuYhASe
         ZfMdzDG7jUu2Y873Jh8ORmBPpVjD2fYfLzxiLEkMXUniLun/Tc7uNN08fzRYHe9GQ3BD
         2ZGqFRg3PrXxxMyjKhkga1XTJafmCYdKHCZVHCiZ9buc8P+bNqSiGnLsMNeKxm/Te69o
         MRJzedPirlFKvvIJuZG0dTQGyqiYxJ2gEChS2N+EUGbGGQZdwutytq9RQ1mC9qtCwyPe
         q2ZTIA+i1QLdlvFKNFXrA81KLNPS6xDJhfy7t9jXSsLdbyXCa16gz5l2SEDjawpdK9j+
         eAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKbV18wBUeiIY47bcOzHCQhRwCPrLo7LiZCO3bbfMzFwOPUoCBlaAVkpSPf+JPbyfhAbewdRSxMTJrI+yJBvG80HqC84ufl2IwQGzH
X-Gm-Message-State: AOJu0Yw4aeO/8Wd6Q9qMMZBlkjrxCG5caDnRoUO6J5Am1wuBVBfQ6e1k
	n8j6ezEhqPWgqhBUI2Wp5WL/0Ez0ZLUkZMmhYkf6ixhZIkD7G03pRALHUSyS4AI=
X-Google-Smtp-Source: AGHT+IFel0DuKv+EHiHhhrq9a39fa8wCRHymYA2GhsqybiN7bXR56zuDqicVyW8ZZ/5C0YigGPyLQg==
X-Received: by 2002:a05:6512:539:b0:52c:ab21:7c05 with SMTP id 2adb3069b0e04-52ce185d03emr1894980e87.67.1719177891517;
        Sun, 23 Jun 2024 14:24:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b4762sm847367e87.14.2024.06.23.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:24:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 00:24:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	freedreno <freedreno@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Support for Adreno X1-85 GPU
Message-ID: <veyzue2rfwd3brs5ama3z5wp3zhoytnggohcidvak4xaxv54tb@hkh4dpk7fcj4>
References: <20240623110753.141400-1-quic_akhilpo@quicinc.com>
 <26abe6cd-e9da-4db9-9035-76edd5dda614@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26abe6cd-e9da-4db9-9035-76edd5dda614@kernel.org>

On Sun, Jun 23, 2024 at 01:11:48PM GMT, Krzysztof Kozlowski wrote:
> On 23/06/2024 13:06, Akhil P Oommen wrote:
> > This series adds support for the Adreno X1-85 GPU found in Qualcomm's
> > compute series chipset, Snapdragon X1 Elite (x1e80100). In this new
> > naming scheme for Adreno GPU, 'X' stands for compute series, '1' denotes
> > 1st generation and '8' & '5' denotes the tier and the SKU which it
> > belongs.
> > 
> > X1-85 has major focus on doubling core clock frequency and bandwidth
> > throughput. It has a dedicated collapsible Graphics MX rail (gmxc) to
> > power the memories and double the number of data channels to improve
> > bandwidth to DDR.
> > 
> > Mesa has the necessary bits present already to support this GPU. We are
> > able to bring up Gnome desktop by hardcoding "0xffff43050a01" as
> > chipid. Also, verified glxgears and glmark2. We have plans to add the
> > new chipid support to Mesa in next few weeks, but these patches can go in
> > right away to get included in v6.11.
> > 
> > This series is rebased on top of v6.10-rc4. P3 cherry-picks cleanly on
> > qcom/for-next.
> > 
> > P1 & P2 for Rob, P3 for Bjorn to pick up.
> 
> Which Rob?
> 
> Why bindings cannot go as usual way - via the subsystem?

They can and should, via msm-next -> drm -> linus's

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

