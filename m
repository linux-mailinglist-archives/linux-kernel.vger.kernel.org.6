Return-Path: <linux-kernel+bounces-431013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C39E38D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11ABFB36063
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA11B3948;
	Wed,  4 Dec 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCPj1Nc1"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CE1B393A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310104; cv=none; b=WADiWKad/AtXLwo3BwdVj3vQUmAvvwC8dAqARjNsbThj1EbafSgIZahJ6PXiDzC50qFekelRk+/VtmK/1pU8knltB0SObBJMN8CwEpmfBz96PXAqGvreWtKdJYUr9r22DnkLq/tGn57PVGlbwmfDY0eZRkgr4w80jQEpy/3JYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310104; c=relaxed/simple;
	bh=ccqc+Ze9+qmkyBvf6ra1e4vxsoQ7jIJam/V6QbyKci0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWC9MAAWFHecCk9kyQjA7PzkgC65aQjXslMY1hJFMjeawBTHSW5vwgNN1qK9JSxsNJcMpqek1v/KtSCbRzeOg5mimbV8QjgGdql3HHRyho6zAES+pEXbcSDw8n5mvSbqZGr56TcxFcVvcQcRMzRAQeqHRh3/+ElQ0HV7+UwmRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tCPj1Nc1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so849880e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310100; x=1733914900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fw93oX49gMMEDlFVw9bAOV4wOGh1pqOG8Ei8VVa+TEA=;
        b=tCPj1Nc10uv0XAie/MBqzuuk1zeW63KXHicYhnF8iQVPeWdh7ZFyGZmAdkcyLpxX2e
         NPdV9UOIT7TB+IJei9HIokCBIN4Gox8UXAJyF2ocJNor1r7gzHRfeI2TXj8ahd0K/C/V
         8awx9rIjX370Ia42f1ghXcHBgmBHe+zQVwFsVZy2olDhaoJbg4nNkzob05/DQXNw2sob
         nAlpdOtvUcEUDp9gHQXgh/i/2I9oBvctbV2wVI1ta9awIoxXQP+4gsXeidh1ypO/JAzD
         uWw/v7k5yTlGZ/yH3az0/902h+fzXKGDKl9iQ4K9BXj/ApG1TeOiI3JuxX/jlmLcSSoo
         ioyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310100; x=1733914900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw93oX49gMMEDlFVw9bAOV4wOGh1pqOG8Ei8VVa+TEA=;
        b=RH1NnOYp6jo0+n06oBVWat9OLsZ55bvMq644wfE9ND6aN/NBnluSlGVGh2bPmRyB2j
         mzVx0MOy36EQr9EulobX7AdPGr+BLMkFxjEeytHfwhUu+AQonv9mn1IVJ03GVPpC9Dll
         qn9BvAwVLfjPOa4spHiyNEbJZsO7OhDBT1b+eR54LcDTcmcd73oM3qcQNRbLzjEKJc6v
         1KRChJxqu4td76d5XCap9A78DIJ+JZY9x1hmlZ3/YDdFwzchUY8kwVFwKMXsDGieNIYB
         +33KhaD5bmFdYMhVWBQC68QcCAQJFLU0sy7tpEHeUe9by3REv+vsTtFOv21aA7gXtpZz
         WjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4PZtZHrdS8vuFzS9xVR3ke6NdOyGFBoHaGy81yzCdnMwDG7rTrn3MBoTxnZWJbLjkmV5Xs6Voww53bns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6WrHtREppv7X53e0BPUzhUc5EBLF4uKn78apHKatQQB0mPV4
	Riqpd2BdGS11Bn66ehMv+nD/XupqSE9C1QAga3BLvI0kFE61lxb3B0YyCGsq3+4=
X-Gm-Gg: ASbGncu6OBPya/71uaXY7XMbysSbnPc7q6YSJ5jlOQDpFRzKJumgUFMR8GPcXXituck
	kEAw1PIAZ4JDBGTLnSehYrjEG76Pvwdi9TTFoMDXhahFsyAvuQNPaWEswZqjrE+hzZH75zM22MI
	R5oyzLYTZJixtqZMHbfKDNftRli+HQJuNhTI5+0tW7WIpVkCluDSS8PkK4LDAnmpdtIsC5Z91kn
	ayY4XxiqyJUKG64NHaW8/HN9/pX6tuyeBXNrFe/LmGxRZg1a9jm0xPZ7020TTG3TGQgdiOMwLfZ
	KcwKfODZNJWT5tlDf4X6NHm4lhTRKA==
X-Google-Smtp-Source: AGHT+IHXZUMXi1zd9eHxyOwY1U4Jc7Xk4uPxg84MZMiLNKxWD9azrbXOzcfpS+KjwK592lxt/bVSpg==
X-Received: by 2002:a05:6512:3053:b0:53d:de1b:f961 with SMTP id 2adb3069b0e04-53e129ed30emr3418458e87.7.1733310100403;
        Wed, 04 Dec 2024 03:01:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649687csm2123316e87.209.2024.12.04.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:01:39 -0800 (PST)
Date: Wed, 4 Dec 2024 13:01:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: qcm6490-shift-otter: remove
 invalid orientation-switch
Message-ID: <gw3cex4hfdkio3slle6iipod3hwrvo7ju2o2kotkbrf632c3za@cvc42mgvkync>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-1-6d320b6454e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-1-6d320b6454e6@linaro.org>

On Wed, Dec 04, 2024 at 11:56:53AM +0100, Neil Armstrong wrote:
> The orientation-switch property is not documented in the PHY bindings,
> remove it.
> 
> This fixes:
> qcm6490-shift-otter.dts: phy@88e3000: 'orientation-switch' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

