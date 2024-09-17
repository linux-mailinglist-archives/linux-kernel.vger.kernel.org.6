Return-Path: <linux-kernel+bounces-331866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AAD97B22B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E9E1F2A725
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0E18C342;
	Tue, 17 Sep 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrLuhqHE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569418BBB8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587149; cv=none; b=RX/Q2hycg/0ZooTmiC60XCRV1Sq2vjk5FQAIED8sPAsCFNHi68CH+sz7BTqDd5po6wTw2xDBb+lHr4lY7T6beO4aoKGs2eSU2DxTHVft92wf+cPaRuBeqJtoUWS0Q2ypo77WKDK2/+wzREqPzyLoE5uXRWAEK53phLvyrVTiCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587149; c=relaxed/simple;
	bh=GtH6orHOd7OaviqK1eMSDZXt9/hshFTmujsoRog2i5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJFNvjyaQ6xiakjAoiVq0lGaV2W3XKixPECpj4RYk6z/YZ+FZNXuSXac95yIBazF42LP6E26r3h8AoxKgqpR8SByIv4e9m4RTKJYu3LN+bAWxU6yaftyqbK8dkdUj6jy+anoCxgnIqZECtheKVAaNCe4Upsyqbv3wOosev5B15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jrLuhqHE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5367ae52a01so5138572e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726587145; x=1727191945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hovqWX9ZGGc/PguKDoamC6JnPtCjHAI2q7eZhe99mHg=;
        b=jrLuhqHEB/m24mTFwQ7lqODwdsXkSI4ZHgYeQwxkV1wFXNhYcaw7122NKAdfMyCKDU
         OYu+Hl7guKw94l/38T0I5poKeyMpKnx5xw5B4JmQMX1v7ZNji5jUwGA9BzRpQQS0oYuX
         tjO60Nog3uzyDTPeglaHhnBPWd3J5r6bDXhbROzC59bAjPFtqAHfw+sLhuvavONSHJX4
         nhaYBPxpZLeX3xboc3kOrhC3R8LM4JV9i73ih1L2LYdUenfajCgycXe8fvxKYWpnUJ11
         YFGodc9EM7bctRm4mf3Me2ns6M+XJiz5bMcelzeTeGkFFhnAZvmIlMtFDPUK+MrJFABS
         Qacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726587145; x=1727191945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hovqWX9ZGGc/PguKDoamC6JnPtCjHAI2q7eZhe99mHg=;
        b=KxxyGP/XSgGzLHxC1zgbQIUDI7BBO4PEonzTXRW1ZsmIsDPhT7nHtRertex1gww7Fq
         eE5DqMSUal8qKwfNNDkbAG0SjjXY73IFCsvWhpV6y13gKomWMZt6qDOXrHIJQDzPLdcM
         TfY/P/PPVDplsqXi/gEEdx/wm0+li/RYBTGHfHh6d3UmHa+caWjW93MNi8VIz7OkboGM
         vX23Hq6zVzxYC08phHctwh3XgCE4+r9J0KuF7It+faGslv2mmrUnAZAsCPawrEL+9MYo
         BoLyn/wjiF7ugeMJHVv2mXTFRf9s2Ii/NoJ9gCY5uT1V8GNSQULYMXPeviVB+/EMHkIs
         LdxA==
X-Forwarded-Encrypted: i=1; AJvYcCW+E00j3DnJj1xtRFl/lGIZiYhRLqfRrA2cMAcLIhs6s86CHS8eSR9exIbqEcIgvxFv6O/wXppoyirEFrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ5aPUNxh2Ac+3y0ZZ3P9amLtw+vIiKk3Q3/xrA35wacBn2Et
	5GtPwFJ9vrP0sSLFMVNNSw+apDv3rKEJKGwWwQN4OHB7nvQ5tz17Ctis0cWiMgs=
X-Google-Smtp-Source: AGHT+IGtfgOTi9jypDor4dQ1o5T3M6DF1HXTXj8usXJ4QJ+V6oHOzNjz0387tRIfAxVH1jPQlKdX8A==
X-Received: by 2002:a05:6512:12d1:b0:536:5827:8778 with SMTP id 2adb3069b0e04-5367ff3382bmr7813936e87.53.1726587144460;
        Tue, 17 Sep 2024 08:32:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8cd6sm1218096e87.290.2024.09.17.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:32:23 -0700 (PDT)
Date: Tue, 17 Sep 2024 18:32:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100-t14s: add another trackpad
 support
Message-ID: <xn3pyfko2px4w73qijpkhccujgipckrazquesvzz3odbkxclzr@azgbhljfllfv>
References: <20240917150049.3110-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917150049.3110-1-srinivas.kandagatla@linaro.org>

On Tue, Sep 17, 2024 at 11:00:49AM GMT, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Trackpad HID device on some of the T14s Product Models 21N2ZC5PUS is
> at I2C address 0x2c add this to be able to get it working on these laptops.

Commit message should describe reasons for moving device-specific
pinctrl to the bus level. Other than that LGTM.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> - moved pinctrl to parent node so that pinctrl can be claimed globally.
> 
>  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts  | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry

