Return-Path: <linux-kernel+bounces-271090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BF94495C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0341F24ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741D18454B;
	Thu,  1 Aug 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDatmGVa"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4818452C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508422; cv=none; b=mXDcjnoPiSTFMdx7SXzjes3MAPLujgFP9PO5q+zxwglAkFGxPI74Mvv6ZWT7fhdc2FFap5OE9KlipgV19LX6JP49zfCyqB1KtAralUSoSpbwdIeg3QpHWeW/M9Pl7u0Angcf8qCdUKJ6ZhjdSL22Fwd3+9tqyWFmid1zPmV4z3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508422; c=relaxed/simple;
	bh=bjhQLQz9r+qgUE5nGLyvNJrXOF+KlCK1fhgEuPnhK74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiTwOKCaMIw+Zl+WcXS7H73ga1LwiTTigdVBgQs1tpDOo31MLoN1kgR9Mx1ls5t5Tc+8cE4Grmu1hE2sgp+HOb1ipFQaw+cM3Mq+Kkp2AHOzjC95bKLGPSjec1cbafQMrEmB8Cddc1/RfYxq65VhqOgSgt7ecBaOMgsq+fkCZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDatmGVa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42808071810so44876335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722508419; x=1723113219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DZ9JRnL0e7KpbgL/FSZ6b64iFFZz5Rvxbediv3ijJ8=;
        b=IDatmGVaUic9Og7PO9OwK4tO/hOQhNPY/gJBcOtKopo7LHq3Dfsq1/mYqztxYr+Wfx
         44V8fY4ds+G9hMfZ4G7x/kLWffWRjV462lFbPxH+Ct23I6ftofUfnjTjf2hT/IaNeCNE
         OTeOuXpBochlU2ygo7fl59npq3PzlqOksCBXCiKsXlkfrHzWeW/WSuMguqxgDcjAyzA8
         Chr0JxwDETjMpKFiqoOHNPeJuYQLkjt7dU0H8gn/bl1yCg+aR40rMthG0IVj/dCEiSNU
         q/JanwOAIoj/dSJSB79rSaLEUb1wvraZQNkuXgylf8ELspW3Gr2Z9hd9yJ6H1TrHW0xS
         pqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722508419; x=1723113219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DZ9JRnL0e7KpbgL/FSZ6b64iFFZz5Rvxbediv3ijJ8=;
        b=MHgLq5PtjnyAacUWpi4emYK/JwaUtk0IkCM9/jHGP+3cmtg6luv3FvG7q1TFh0VJVg
         Besbd6VW+vtRl33e/CedK0OvWQbdQ1N07skb//7Y2S9ZQYRpyCuZ4sqGzDzf4ltxktCP
         bMLzM94TQXylH05o+V4eBbOccp7fzjXT8++FOLB91PtlrRl9Y/d56fVHeuDSXo43CdUL
         VVV58GrkPNpGyv5TOV5nEyKasqcn6C7RxEhPM+LlRrAucZNmpEHw4A5ypmP0S408zfpE
         9cizDrLs//7zUJBpf3lIUg8KOeSCm510r6OTTev1zOiBDYGv4FYQR2cumlu4DINhGXDL
         d1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXeUOU7V53A2SQwRiSo9ocFkETGTazqN7loRs77UDuLhlyPTFSxmQV7eUUBTg/YT1saRDlUdfcNe3ntPmQmmIaft+x1EviIn1hkTGMe
X-Gm-Message-State: AOJu0YzNh/wOw7rE0YczKR5OyORAp0fUlrm2DlA8V+ZiyZDFgEqS+PkP
	dWWuyt0qjrotjx+96fGJFmQLkp1QGD9S+lgBU5oFZUCAUEiWfCCmja5rfQ2k/Nk=
X-Google-Smtp-Source: AGHT+IEQgVTcNKj105V6VOej2nknnx4vup+h7CU4av90EuoPVBm6nZUMtPvjq53uwkUNQcyJVXl21g==
X-Received: by 2002:a05:600c:3ca7:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-428b4ae2222mr14059125e9.33.1722508418390;
        Thu, 01 Aug 2024 03:33:38 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428240b2d65sm44538315e9.0.2024.08.01.03.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:33:37 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:33:36 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix X1E80100 PCIe Gen4 PHY
 initialisation
Message-ID: <ZqtkgPf+JOP+im1s@linaro.org>
References: <20240726-x1e80100-phy-qmp-pcie-fix-config-v1-1-b569f03c0c48@linaro.org>
 <ZqOysDk0LqwxG4OF@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqOysDk0LqwxG4OF@hovoldconsulting.com>

On 24-07-26 16:29:04, Johan Hovold wrote:
> On Fri, Jul 26, 2024 at 10:16:56AM +0300, Abel Vesa wrote:
> > Update the PCIe Gen4 PHY init sequence with the latest based on internal
> > Qualcomm documentation.
> 
> Any hints about what these updates imply?

Usually, there is an updated variant of the same document.
I've been told that this values are fine-tuned over time.
I'm assuming these updates should help with link stability, but it's
just a guess.

> 
> > Fixes: 606060ce8fd0 ("phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index 5b36cc7ac78b..8b624afbf014 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> 
> >  static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_tx_tbl[] = {
> > @@ -1286,12 +1287,15 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_rx_tbl[] = {
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_1, 0x01),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_2, 0x01),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x45),
> > -	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0b),
> > +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0A, 1),
> > +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0B, 2),
> 
> Please use lower-case hex consistently.

Sure. Will fix in v2.

> 
> > +	QMP_PHY_INIT_CFG(QSERDES_V6_20_VGA_CAL_CNTRL1, 0x00),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
> >  	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
> > -	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> > +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x3A, 1),
> > +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38, 2),
> 
> Ditto.
> 
> Johan

