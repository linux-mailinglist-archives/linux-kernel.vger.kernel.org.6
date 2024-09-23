Return-Path: <linux-kernel+bounces-335800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3797EAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2315D28236D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27E198A35;
	Mon, 23 Sep 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJvMwk+x"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01808198E86
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091904; cv=none; b=TeRvCF+X5vY1IEJtDCAZBL7BXSBwUq0jKg/ajFnfhmCKyizhVse/Eq3cyekgTXJtehtijpBJI643lmLQSohS4+asWgNq5/ja6QhOL3Xhi2fkYh3dHI9WNgBmVD42EdlRaD5rLrc7ivOkMt7QuAz0SNch7IaUZekeXVGEZsi0/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091904; c=relaxed/simple;
	bh=oWf1etSGThdvWeQQGh2KhdCYp3tZr3vCu5xX3HYconA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlAnItD0YCmrhuhHDawTzO9CT8AtSYbHSlkkrijvK+ExWcOBxvGCxoQnBBzV5lr1qmnnT83ABzJZqOK1vyjokUg7xSNiSTXLGwCw38XxPckl4tcjyYFEAhwdh5mzS2AlUBf1gWh8/4wf8bTMqXc1KLELFbzsa/gx/Kiu1pez9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJvMwk+x; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so4448059e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727091901; x=1727696701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhnBmWAe9NUrsichqtPogCcJph5ClsF7zPozObEyXA4=;
        b=GJvMwk+x2MX6pzODrbN64H/LfXKU2PeSMlbdLttBnReJzt7e2PET+r7JEKrSfSbvyu
         JNaPDnzS9OTElED6d6gdQ7w/bR1rC7y1qAjAYU/DgEkbhieoaeB+4vWy1lBxZRqbEtjr
         ++c+Ze5BqFSUzkOxhQeoHaNpvUZsZfkH3eIQV+e23DtOJDVd3faoWMUn+YwUII3XchQB
         BuhFC4ZHnXE0u5nJOpnZ2WquHkUbLklFPewTir2+6IeeL0bbKjbVGci3rIxP2qvju4ag
         0r3POYT4hjjLs9UO3EyZX2obHUQYuAQtdqqaHY3+mQQ1a64TXUy7jQFFhEI2/SgYeHla
         dHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727091901; x=1727696701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhnBmWAe9NUrsichqtPogCcJph5ClsF7zPozObEyXA4=;
        b=pMrpOOnMUbDSGAy9vO/WMrd2mYYtvA2w6AWF+NfJ0+hBKO5oBrUuMlNMp3DKkYvmLy
         O0GBemKsAO3oHaP5/R1XNfe+EDufMK3PE5Jr2Gvn1Fgpyu46lQuCX9aeCSzrDyDZthyq
         hvBr7gitvyIfef28xth8lV53O9zkQnusRg/4+2KTF1TYN5OkVt1qHmJYm37MJhegtkAt
         0x0Yiyxqv3UPTQjKso3AnxhwPO9OOvnoHfRhf3gxCSqoui5RYCrBjfqQvIrbk582OArF
         IKpw/11V1rJGZXshAm3AjJFpK1UllLXQuDWcjX+MQj748lgWkDmPkBZOjpZ55uDU7WC7
         talg==
X-Forwarded-Encrypted: i=1; AJvYcCUDTvTb+2B6wmhWiz8k+EYKyTRiLpObdwuo/rpVUaU5nm/NtP0tmYMnXaf1fquTMKUvdfZmtnBqyomu1KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPNpa6EQ+iQJ5GeOZCmaZGH3a+Z1QiIAQy1MQbADlF4u+Dn/J
	G/rg52jwaowUv/RD+ipiubww0XwizbLxiRVERb7L7jSzUYFC+VkGKnXqCLxi+gk=
X-Google-Smtp-Source: AGHT+IHa4aqsZXTbC37KCXn5fe4mfHLWoWf0Nyyz2mtzA1/7uiKYj0/E1PRavXBv3jLrfICSOaxmpg==
X-Received: by 2002:a05:6512:a8e:b0:536:52c4:e45c with SMTP id 2adb3069b0e04-536ac2f54b4mr4462943e87.31.1727091901086;
        Mon, 23 Sep 2024 04:45:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a875bsm3259740e87.224.2024.09.23.04.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:44:59 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:44:57 +0300
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
Subject: Re: [PATCH v3 2/5] phy: qcom: edp: Introduce aux_cfg array for
 version specific aux settings
Message-ID: <qughwerqucheykdwxhip32n7epijn3625jxn2ls7t7nptu4tkw@ls2u7uzaoegj>
References: <20240923113150.24711-1-quic_mukhopad@quicinc.com>
 <20240923113150.24711-3-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923113150.24711-3-quic_mukhopad@quicinc.com>

On Mon, Sep 23, 2024 at 05:01:47PM GMT, Soutrik Mukhopadhyay wrote:
> In order to support different HW versions, introduce aux_cfg array
> to move v4 specific aux configuration settings.
> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
> v2: Fixed review comments from Bjorn and Dmitry
> 	- Made aux_cfg array as const.
> 
> v3: Fixed review comments from Dmitry
> 	- Used a for loop to write the dp_phy_aux_cfg registers.
> 	- Pre-defined the aux_cfg size to prevent any magic numbers.
> 
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 41 ++++++++++++-----------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

