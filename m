Return-Path: <linux-kernel+bounces-417519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D19D5517
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4243B21C01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0771D9A6D;
	Thu, 21 Nov 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nG75BV9l"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908B1D47DC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226397; cv=none; b=GqbqGlJz7jyF855QK9QW3VDvtFbH9VNg4xgvX2FKMn/4R6W6KF5bk07NUiMB3bFkqxPx79LbigHkB/zpfW3At38bAJIp8xdGKYP7br8xgcxq7Py+rSBL9jkoNixqkP1t3mCtIvWiX9fpP/auH4FbjgBte38NkqIEwsFjndqWcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226397; c=relaxed/simple;
	bh=Z9hBdIRlSlIOJt5RlJxNQ+/7oHtkA0DlqGr9R4P4wWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nupmdSsiH38CDzq5tzSIlSv4Z7fJadLuARI93E8z/v0GJ9LO5ar6iNrLHMhoR09q+gfqPgKaTGp+Mid4rYrvCnu2Qg1JP5BQq3qcpq1kQCo8q0FmE0uUyFzbUd0p52VEW0jvlCeJuekIXGRoIbFo69iFRCzz3wSvn0W5iUBgNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nG75BV9l; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb49510250so17528361fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732226393; x=1732831193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWJdS00cJ4rOlNcmR7aH9AGornPg9zKM2yab94TA0Ik=;
        b=nG75BV9ll6f8M9nCyA2rtIYkr6oTFQnnZQfsVFdZstFylyRqzsThIm4TIEWxp1OsOB
         ZnXj1b9FHHLdITKiswho7JrtFg+TNK/kYlq43Edh3krCavycojczVYIYpuVXuBtHbWSr
         3GlXbjnL0capucBiV3iRfLZDnQrVQNyjQSEAqps80F8LxAhd8GETSqNQdwys3fa+mfb/
         fLLMJnSnEE4aeUbpCfF5eB/VLQIXVTbggtF8UIN3+NaSMTamtS+UaMIbKmvO57P22CXg
         ly+MdoTbZo47Zc05Q6+Jg2qPZUHHfLXBmZcIxiXyFZwgWtpGkYtlq4aDKzSExxYqxqfD
         fmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226393; x=1732831193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWJdS00cJ4rOlNcmR7aH9AGornPg9zKM2yab94TA0Ik=;
        b=QE+WTGBqHL1T5XZ8G4EYpNPvGIZB1jTsVagmWR4TGWXj4bpwfku5Zi9FkQRSACk4Ze
         mY5hfWr9xdrJ1RwIMG1ix3DxV6DQhWXscOmUxFd0mvKg1P+5eRc7zOIl/AoPrBnGFtk1
         Zsp97+qrXzB2d1BiL0rfZUJOL5kO7E77Ui7htHOQZ3fsPWTGTr9wgg849nCXO1F2g85g
         8rRyWA/wE7SCXbiphaKS4Tv7pCRzlP5n3G7PKuzadm3Bwqkdc8YlIZTx+Ex2VaY43z9q
         xpSRl07GxcLk2ro5o8bQ4aig1u8BLf6xlJF/2IkngGFcSI8hDWqs3GWaVyKoJ6H7RAls
         Z4gw==
X-Forwarded-Encrypted: i=1; AJvYcCWjRLciDPUnS4MGSuspKKEP+xbIjv2l6BFynW6qbsBY2/z2u+ZNq1kdenUlvf8K2sO3wNd47VWWwoHwMXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmtzB46iDB421ioF47YkGJxtwzNFrup8d1QT7APpxFAA2Aamo
	NfdShME3zrlGF7jGQx4j1UZhh6NKMwQkjURDrbolAsedARP+x/GShKG9E6hvDvQ=
X-Gm-Gg: ASbGncvBgHqUCuLB4hMnP8lvd12Z7c6RLrm6pW3/KDiwX14HZQlZjHZ9mjwQCiQy8xI
	hAQkBoTrlsm0Xz7ZqSKsFLRYAkALv8J5sSpwGerPaEd8YNoxadCTt0mOQM/jbab2o3g8aXPVynR
	aa7lWJqX5bxqWl0/ZJiy/6MZmTkFY28mEmDDrNqaxKIdxroI1vxuQsm3jBcKQvgSFZgRrAB6NgY
	Vd/niKb80Cq1S6+e8QySZbCIf7xJl+aQwfwLUzBfykuOkvdQ8v7+4ZV+jFoISYtWqc3PK2Y/Yvt
	YYhBiB8WavWDIUt52LgocVcJibwcHQ==
X-Google-Smtp-Source: AGHT+IHBwuG5kencpPo4m09q691DHgtw2tL/t0BfxRPekGjk62eEZPhMHiR1SRxKJAeR+W+b3uNZ+A==
X-Received: by 2002:a05:651c:1148:b0:2ff:5f94:e649 with SMTP id 38308e7fff4ca-2ffa7125e84mr1424491fa.16.1732226392942;
        Thu, 21 Nov 2024 13:59:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538ea19sm652441fa.95.2024.11.21.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:59:51 -0800 (PST)
Date: Thu, 21 Nov 2024 23:59:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: common: Add support for power-domain
 attachment
Message-ID: <hfkvbshgbhz3dst44kbdxxy34phrqtysxbfchuvefars7ibrwt@jqjl4oca6g2k>
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
 <u6azgqlmncadcwiz42pk36q7rehwajnftvwfjh4aoawskdwkof@ao2imoy34k4y>
 <587de15d-06c8-4f12-8986-f60a80fe5ad8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587de15d-06c8-4f12-8986-f60a80fe5ad8@linaro.org>

On Wed, Nov 20, 2024 at 04:49:04PM +0000, Bryan O'Donoghue wrote:
> On 19/11/2024 15:41, Bjorn Andersson wrote:
> audience what exactly you mean with "singleton" and "core logic".
> > 
> > > Use dev_pm_domain_attach_list() to automatically hook the list of given
> > > power-domains in the dtsi for the clock being registered in
> > > qcom_cc_really_probe().
> > > 
> > Do we need to power on/off all the associated power-domains every time
> > we access registers in the clock controller etc, or only in relation to
> > operating these GDSCs?
> 
> Its a good question.
> 
> No I don't believe these PDs are required for the regs themselves i.e. we
> can write and read - I checked the regs in the clock's probe with the GDSCs
> off
> 
>         /* Keep clocks always enabled */
>         qcom_branch_set_clk_en(regmap, 0x13a9c); /* CAM_CC_GDSC_CLK */
>         qcom_branch_set_clk_en(regmap, 0x13ab8); /* CAM_CC_SLEEP_CLK */
> 
> only inside the probe where we actually try to switch the clock on, do we
> need the PD.
> 
>         ret = qcom_cc_really_probe(&pdev->dev, &cam_cc_x1e80100_desc,
> regmap);
>
> Which means the registers themselves don't need the PD. The clock remains
> "stuck" unless the GDSC is on which to me means that the PLL isn't powered
> until the GDSC is switched on.
> 
> So no, the regs are fine but the PLL won't budge without juice from the PD.

Is it for the MMCX or for MXC domain? If my memory doesn't play tricks
on me (it can) I think that on sm8250 I had to keep MMCX up to access
registers. But it also well might be that I didn't run the fine-grained
test and the MMCX was really required to power up the PLLs rather than
registers.


-- 
With best wishes
Dmitry

