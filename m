Return-Path: <linux-kernel+bounces-352618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591CA992190
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D11F21343
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71D18BB95;
	Sun,  6 Oct 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5nMTpAB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C361422DD
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248876; cv=none; b=CEo4Oo/dkfY2lhbsykPnR76fGtI4MM6M2ae6j6Keo+DdgR8jGrxky0F/pOHx3VMsuAubfO7wZxfu61eINIPJELrxBVXLbbKXZM0pv+/VhoGRANZ9u5BipX/PmnA6ijBvUpVktZLS3l5s95lHXeR3lBjBmS00y4Yf1oxGmNeLkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248876; c=relaxed/simple;
	bh=ZmEHLsPsF/N6ibvDSVVq/66rE5RN7QBCRfoTpzPD//E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mflww7d4O7nTkz1n/cR/wUYlSGheMdgqpS8sPJANHxVUf9OICsmwwgGUOyU7hTIQyOh5QVUaR1GPSShPjQPsddqhMg48zkvAFCS48VsD2UE+YndCYBSxu1eMCgXLGrsCRfmrkLxiSu7cgQogq5cs1OWgT3HYQcD73X0IwrJ7z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5nMTpAB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53959a88668so4519298e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728248873; x=1728853673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Szw/D0bhQP/xtWqJOCA8PUzQroqabxhhElDsr640PI=;
        b=t5nMTpABdnd0ANto0f+s4DYsYy55O1o+LZitz9gcKKxOYmZpHdF0WLfbXBsO8XDDgo
         5pdttAbOtj7FS49WX8loWsfuYZzN7f15Y1SXfJrcLFPJOf9d2+whu+6Bn0rFkzaLy6ja
         Uo+2bMLk3KFHbcm63sS3mhMzuu5Ao8DYUWxutaiVKWv81y+q8aoEnflZkKuwSg6F+3Tx
         DxhLJRlpFgVFX/5oXeqyRDreZBquZSqlSG7AWvKOaGrpx+djtsassLLpdtYkY1B5iQt6
         Tpl2adGgYQG1s4JQiML/B1AM7o35qd2pWofERyQ+nC9z8GG/bl/8Qb5yOiNOw3dKDkHs
         116g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728248873; x=1728853673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Szw/D0bhQP/xtWqJOCA8PUzQroqabxhhElDsr640PI=;
        b=BilWbTk8hxsGufx8v8YuQNjlg3rrAQHhfK/KmTVrKJUsYyGGvtNRUlWtCrUITfwshm
         /PPAkUMV21vkPiHeECEZH3sIimekyaH4Iff3Y4O1yGgg3np6RuaWQFfx7smjwS2UT0ku
         anT9eOq551r7mcJiWNEfVGVQnZt9r2MJC4t3SW9ZwvP/2BCgCbqoYbAhqcHkLH1Gh8Na
         Gv8usiD37H8tV0kKaXrFJKEe1q8OrAi1HpeVmC4cyPfqHGy6aoi6P0Wo7LcTg07fDuyu
         BwIaVp8J29pN974E5pU+sAzpKDQUTEmQ27Np7VUDC4kGh/86agEapPq/J8mYxSjbwr9Q
         RfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5kh7XKbUfnPQG2jtkHT8QrcuVvmLupp1VorFueNZ1h2I+2V5TH9XNXR8+BMRKsXHbtKkzos2pweF3bkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyz8K8AdIECvWCCY13jtWDeWJwCF1Htc98GQwqz6J/XjC+VLZ
	PE4STpwY6mNHD9mhUiiuxcykl9t1we50727sM/xp/mzIgTLv1J3y143vzhqlPi4=
X-Google-Smtp-Source: AGHT+IGNLcBHRM2Z/UXd6g9I6VwOvjvFpOD+yzP2cMKHxtpf6x5Xa2qcpwJRnTWlA6Rteu81F+BJow==
X-Received: by 2002:a05:6512:234d:b0:536:14a1:d660 with SMTP id 2adb3069b0e04-539ab85c035mr5226217e87.6.1728248873103;
        Sun, 06 Oct 2024 14:07:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff286f6sm617883e87.293.2024.10.06.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:07:52 -0700 (PDT)
Date: Mon, 7 Oct 2024 00:07:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v2 2/4] pmdomain: qcom: rpmhpd: Add qcs8300 power domains
Message-ID: <dy2kuyx23oraslo5cqc3a2udkxaafwyuugdkzcadwyel2mjyen@xrlus5lq4ygi>
References: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-0-18c030ad7b68@quicinc.com>
 <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-2-18c030ad7b68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-add_qcs615_qcs8300_powerdomains_driver_support-v2-2-18c030ad7b68@quicinc.com>

On Fri, Sep 27, 2024 at 07:59:14PM GMT, Tingguo Cheng wrote:
> Add support for the power domains exposed by RPMh on the qcs8300
> platform. MMCX depends on CX, so mark CX as the parent of MMCX.
> 
> Co-developed-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

