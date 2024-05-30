Return-Path: <linux-kernel+bounces-195699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66518D506E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011201C22285
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADB3FB94;
	Thu, 30 May 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjYQgEN4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2263D57A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088663; cv=none; b=HFVuwTMBf39QH3dWiHfY1IY1OdX6111R+vLArUuZiL6UbOJ+/VM87skVtRPlqiI4Gt0qpNSmUfpvKIZlFKsHlsKxQzGA6F8Z7aPVvgwu/p8Pkkj9JlrJpi3896Gf7fhS7fh4G/IJIioRAQZhBAY0lK57xPUD4C7Z7uWNd5Y16K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088663; c=relaxed/simple;
	bh=GUhIFx0DxmQYYxaRlO+vduVq9JOab9d63Oldn8iPYSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVYGADo/+/CYp7cPcsmLzY3bLpY+eCfX55xsU+9A4RhZe++hYIpZZv5sN4oY+B+xpWljtO56Z/bZ4Is71IvbfSWEf3z2RJoE7P8V1RKk+EU+tHcibb7v14HYhQFstd+nk9DvkLBy8ib9Xqy5mxKFLunShU2F96veyB5iNxB23zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjYQgEN4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ea80a18094so13087541fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717088660; x=1717693460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhpLPu9sBC2Dg4sX7rOAPkoVOjXa1NOeJfwNC7SE+Rc=;
        b=JjYQgEN4WGAmLVrONxgCCVOyo0k8X6u43Bstd2AAbIVssErgZz3dpuM12HGDWdvLNH
         MVrQm4ZSRQU8h1Z2/+rhlmYDxf03dPwzktlEs8onJZQsMEBOcDpeChyGQAiX7SrFQtE0
         TCNec9c3gA+29H+xcYSnRkVP628u80SIDDPzzkJTsynEExEUbnffHi7FUNMvUqc/TC2S
         ZVa9TQ6XA9c+Lyk1cPg9Q5TDMopkudSWtcAwT7zCDATL0WrrrQsOFixZ5EAEaznnDjkj
         HHn5aEi8+db8si8hWppQd47Jt6YxXVSJIbw3wRi2pIn8RPep0LAVyEUVPXIsjh1z1m6p
         A/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088660; x=1717693460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhpLPu9sBC2Dg4sX7rOAPkoVOjXa1NOeJfwNC7SE+Rc=;
        b=TaUyNj09SyJNL8lt9PlG2p/e0cB250IAS0r6fFkSvrQl3ifIviQnUDFYLg+TA/G6fS
         4bleO8/hNkj2DRSOmSCoKXmR6dxdPdiRfNZEr8VYiQbW2uGeGY7U1H88Ru6E7AtO6Kg9
         oDJlBiQ2pH61clYLcmBxuzjIyPLViX4hzZq9+/vmozfMy33EdXvl/LglNIB9cPHPWBSI
         oMTlzdUaFmGWa3fMmpam9B4XkQzq5dZMXtBVDTxj+2LtPZgX5/mBt7ra6bpK+/NJ9prR
         VLTCnm/UI4/dffgs90X4LwPzPoHo1n8u3SifDuNovy+oqTmIbAZ+zqtkZ8QIKc0YMHlD
         /BUA==
X-Forwarded-Encrypted: i=1; AJvYcCXMSEvWsKbbREkezxx1ooHCtfPzApCncKBvzyeItnBuKzfEqorluGztLuJQ3ftgHIDHQC76R/NynOMYG1yQGd/Lurq8EwbazkCrzIOn
X-Gm-Message-State: AOJu0YynUpmNup792BMDTvigVEysjjNr4IlXL5cjHZrnZxnxiWMkPpD2
	BLjE2AIjaCevBoBYW9aj9BYBZWQbzUgCViSWKRqtz7zZtGNOmOlNMDefYSx8mzMRzkl5z4R59EA
	P
X-Google-Smtp-Source: AGHT+IE7Gk5KUz2dhEVZPQ6lNyxESfnnqiVlBWPJ2z7t9MZy/2nNvv0lc4R4rPSUy+15xktWUbz8ew==
X-Received: by 2002:a2e:b74b:0:b0:2e9:550b:f28f with SMTP id 38308e7fff4ca-2ea84c39e2amr6188601fa.6.1717088659955;
        Thu, 30 May 2024 10:04:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bee55fsm185011fa.58.2024.05.30.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:04:19 -0700 (PDT)
Date: Thu, 30 May 2024 20:04:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-x1e80100: Fix halt_check for all 3 USB
 PHY pipe clocks
Message-ID: <mmsorfdaef7xwmgrnx2fuqoqjqvjwdamea5uslvbdptr4c33tb@rjgsqk3jj6ln>
References: <20240530-x1e80100-clk-gcc-fix-halt-check-for-usb-phy-pipe-clks-v1-1-16c6f4dccbd5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-x1e80100-clk-gcc-fix-halt-check-for-usb-phy-pipe-clks-v1-1-16c6f4dccbd5@linaro.org>

On Thu, May 30, 2024 at 07:48:44PM +0300, Abel Vesa wrote:
> Since the pipe clocks are fed by the QMP PHYs, they are not under the
> GCC control, therefore the halt bit might not get. This will lead to

Nit: might not get... set? cleared?

> the clock driver reporting the clock as stuck, but that is inaccurate.
> So instead of waiting for the halt bit to get set, just use the
> HALT_DELAY flag.
> 
> Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gcc-x1e80100.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

