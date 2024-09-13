Return-Path: <linux-kernel+bounces-328168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1A977FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF71C21C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE9A1D932F;
	Fri, 13 Sep 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUF+eQ0R"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FE1D9323
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230526; cv=none; b=PP4xdjYyOEliN3jFwhr38ayO3r6EAQMBdeXZbvh70d61ApA3TgwV1Vt7g/3lYfk8AGzFuN+2rf6g5GvoyaWfSHrbmntnGWpEhm1E+QsWKOo7q3pL49VZHV9p4USw4S0HQnvCXJu1+qwiJaQtBA6pukv0PUWPs2nKHt5r1US3ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230526; c=relaxed/simple;
	bh=PsWOLXYhGEPuJf8nwq+prRl7Dg+ag5UAqgxM272Ss1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDaAiXTTnT4zPFvem6EYGX2UXN5eIYpwtt/LO2az2XZlwqPRrf4G7pSMRwtY1HnUUoTH/O7lX9fCWvGIuu9h9O1OnjsT6qRahbeKtM6acGk9AP7tCtMuTiwi7m3mVO6w8my/qjvzIswcSkQN7AjAKFtfil0nVL4l78XOosqinm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUF+eQ0R; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365392cfafso929622e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726230523; x=1726835323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ji4NYmFGGbt+gGev2Tj2lbi8IGg1JCceX+r4CZ9/dE=;
        b=tUF+eQ0RUL1LwPTPRipqgzJIKZ655MO23yXNjlKlDF8O4fVY4qN/Hw1+UuvO95y7WS
         zeGZMRcSNZcREhEB5jHwk6WRaI2Nlmwa9Q0XKkVbwhbRuO5x8Nm4de639XP+otuJ9FGE
         vxwsOYENEdQogefpxOlHb+bZQoZNwD08ZiNKSMNW1xZ1PiDia9t/KzRGNFPhGpUTAYQB
         ezG6wR5KAJJxRueRR91C+0VDDDSfOeQEcNlJCqEjPWMmN5xXj6eOAsq9bLbbEG35IxMG
         92feOX6cQWIXAzy7KQyT3Qy6xastQwNVthJrHxq0oGmmVQDLTE3NL1FSkGreBD6xGBsU
         lRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230523; x=1726835323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ji4NYmFGGbt+gGev2Tj2lbi8IGg1JCceX+r4CZ9/dE=;
        b=ESJt+zumy1DkSxl2N9PCuO8VOOMEeTcZKvU1Jx0ZZ2zxTus9njKK+QMHxGioZF81o0
         lqIBLXFQ5edm+tzdADJhRPdvGYeut/m3KZjM3V53iaNHYvVK1BviCosc1Nxoz0MfnqJr
         iug6rvJRbl3fH2sh3c9j07ssfZdrnCHO2WedUd8FDSub07QbOX0GexW9U8qPL64PaPOf
         OInuIl94DuHKlpeBzRDW9pZoBlcTJ0RkE5c6UpwzO1d9Mgziz9mMIsT7Ovo3Oug7ml9+
         iv1OE9iTBZLzQvVWDKwvGNtxYKQX2YISe8bfCby7BawvAbooujBd/FaL3j2a0NYf/oYx
         YnNA==
X-Forwarded-Encrypted: i=1; AJvYcCX2V145zl9se1GFrdaTKH0mLTzT3bTg6CMAIr4r6N2jfUfctA5QmweWq45vVvsNSO1rbM3DzHiydz/t0Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVL2IGZd6OmZ4e3ZC1q5aXxuXYj0Z6QBmezZgZ+CiT1lNQNyBm
	wlpmQYZb3uHUXE+iZJV3PXoTYOba57HSZxJ72QJZzv4Bjb3M/nNGswnwVf27dDU=
X-Google-Smtp-Source: AGHT+IFjTOd+RrLVc1MSCX5go4WC8b4PHBCxtlwa/ercIrMyEGIaP2cttCmh5EftrPHHdbja2IAJsQ==
X-Received: by 2002:a05:6512:3e0a:b0:52c:9e25:978d with SMTP id 2adb3069b0e04-5367ff24baemr1651346e87.45.1726230522693;
        Fri, 13 Sep 2024 05:28:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903ca4sm2262019e87.192.2024.09.13.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:28:42 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:28:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/5] phy: qcom: qmp: Add phy register and clk setting
 for x1e80100 PCIe3
Message-ID: <tkt6ox75xsbqhbopgi2dkexvubpmuizuzeyy5hkdv7si7jljzq@x3tgbepgxeni>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913083724.1217691-4-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:22AM GMT, Qiang Yu wrote:
> Currently driver supports only x4 lane based functionality using tx/rx and
> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
> PCIe3 related QMP PHY provides additional programming which are available
> as txz and rxz based register set. Hence adds txz and rxz based registers
> usage and programming sequences. Phy register setting for txz and rxz will
> be applied to all 8 lanes. Some lanes may have different settings on
> several registers than txz/rxz, these registers should be programmed after
> txz/rxz programming sequences completing.
> 
> Besides, x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8.
> Add the new register offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

