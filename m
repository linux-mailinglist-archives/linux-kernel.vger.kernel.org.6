Return-Path: <linux-kernel+bounces-510974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD24A3244A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28676168CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FC2AF19;
	Wed, 12 Feb 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiLzxyJz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271320969A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358449; cv=none; b=Vv9s8Pom5vf9AZa5tA+BqOaCDA0VPKEM5Sbuu7I7AoAhRn4EQEf1ZRLn6z/mWOv7v8iDojidq9d1+qY2GFPE/Sg9tMKKjCyzzSyfeRY/O72pkzVTVvPCWmzNosziLiXNS3AF9I5DHSvDm67RmLhrrGLiWuv8Xn3WrOcxqJNYqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358449; c=relaxed/simple;
	bh=FHXNEo8vJ+zt35Y3YtGgLr1i7rPjMlV3XF9e92i/nE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAGJg5ifGITVhULKtKjMky4cmqb5NnxGmk87xNmjMeGM4Zco2GFLgtmdvp5b2SpSw0uE2UyOEHLiJ56ofII2KsM+6qA023vP5F1AmRKBcHRINjkVzJRRJvo7a2c3il4nbQhIu6U3DOUD4cHdX+P5w/gKSWjouPqAhviUGPnkMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WiLzxyJz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543d8badc30so6903531e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358445; x=1739963245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XrcsMcosgMotFmWvKnhVc1K8RooVNeMblYbDmD45Vw=;
        b=WiLzxyJz1BYJ/YgR1EtV1Dfg5jAm9Ah55htBpwAoTJJ9VtwigT2sKeeqPx7raIx6db
         Aty5Lw4FDVs99eEqQchVX/04mzsa0PuOSq23xQ7GllnuW0wokL/+V9l6cB5vn9aonwfq
         dNEqh3XZoGoILTaZkNcKi5sL0Fv7WyhyOd6kdNl8T82nphUmic31suNXZA8puYiERnYd
         A6L9lAOJUJF+svKvwcxvVun5mIZUhahebfwK1g0yaYdW2mvMfAPuLBmS339vldivdhwe
         MwZiPTssP82Qg5nvmj+4g/NrM4bxBUojXBCUOUSLk6UwnuIsl7noZyh+6vMELQj7MFYh
         dgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358445; x=1739963245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XrcsMcosgMotFmWvKnhVc1K8RooVNeMblYbDmD45Vw=;
        b=ZNamPPkkKMm3jZu6PKuA+hTo8pI/+F+hns7tGEzENGCqVOLVV1x6no/PnYtjZXAsLg
         tlKO+R3f2YJweem1Ne5RNaMEvRU4C4MLQZMP7mIb4jnV7fm7aFM9fGXJPtatLbZaR/u1
         z1j6HVkI1ycuOk/X8nCx3PLwDFUzdLHAMMdzID7vJSNXoHpEoa+CbHdK3AG0tlhv/rYf
         VUujzRXtjBzoV0Pq7S6Jl1K3Opyyoo6W3kak+Vpwd+/yEAgHUtPCCFkimk2DgLmB09Sl
         Dn+9G90pDF1Ynhbir4EhFzDIvLc+EoSJmHhSYdhjWNRD2pfOvi8s9hE+1IqDSP9ju7P2
         J05Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Zm2GBySSkJR2KUrTv/DN1tK0QFRRtouDnoveYrjyOb9LAsCYD3r18MVDTidsRq2dOOf21Bau4P7lOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRMVQ0mQltr9Rf2Q6evFLqeJnNCIz+Xf1UOI9ZVOAVBnZbe4O
	XEoa/ndgrAXby4CqQBEfes5ME5HI06uM6Kvk/FZ7/FWGOfKJlCSVdPJBcgffX8M=
X-Gm-Gg: ASbGnct/K20OgScz8UaNBGXYtzU7LEJELUhc0eD8YS5eRKy7AsxdFJqp2ZNhMVPMxPj
	o+4Fyjbaf6tuYdw19SSZKeo3SBXlaO0Jc7jgC5btUI+yG58earkJ1xZGLf0vHhk5pyKMLLWp9rf
	WUO7zA8JmMl9o8hkxYUzTwxT1Rqtof1DVXZW0FwW5754zlj1SIp8KEFi1qUYB7QajBknrokfBr8
	JlikYsOZRtIS+RnfJMvFl5uk8f7LkrjzVil6a8629W5fr9Ol5xFhQr7MvPIIjRVqp2SOg6CJiPW
	y/5sSSwx9gNSD8HkRryj7I5oiRZgvgfV660W21FUBc0MIcRt2LPsg5Blf0K2ecgpINmJxqg=
X-Google-Smtp-Source: AGHT+IGk7ilb21dI1tWaLiaK33rLAvEcR3Cz6NPO4Liu0mG/KS3Lk7rbmF6c9dM+6Y2HrYHp/mPLwA==
X-Received: by 2002:a05:6512:31d3:b0:545:61b:c84b with SMTP id 2adb3069b0e04-5451818c5b6mr933058e87.32.1739358445264;
        Wed, 12 Feb 2025 03:07:25 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450a76bc6fsm1018745e87.241.2025.02.12.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:07:23 -0800 (PST)
Date: Wed, 12 Feb 2025 13:07:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, p.zabel@pengutronix.de, 
	abel.vesa@linaro.org, quic_qianyu@quicinc.com, neil.armstrong@linaro.org, 
	manivannan.sadhasivam@linaro.org, quic_devipriy@quicinc.com, konrad.dybcio@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <fwfxhy535nm7227wzlwlojxyxrr3ond5hmc3njqbcje3usfh5t@hqrnbpmdqweg>
References: <20250211094231.1813558-1-quic_wenbyao@quicinc.com>
 <20250211094231.1813558-3-quic_wenbyao@quicinc.com>
 <7deghiadmomrz7w7vq3v7nkzq2kabq4xbhkouswjrexif7pip3@tvjlpvuulxvp>
 <791fa29e-a2b5-d5f6-3cbc-0f499b463262@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791fa29e-a2b5-d5f6-3cbc-0f499b463262@quicinc.com>

On Wed, Feb 12, 2025 at 04:31:21PM +0800, Wenbin Yao (Consultant) wrote:
> On 2/12/2025 8:13 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 11, 2025 at 05:42:31PM +0800, Wenbin Yao wrote:
> > > From: Qiang Yu <quic_qianyu@quicinc.com>
> > > 
> > > Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> > > whole PHY (hardware and register), no_csr reset only resets PHY hardware
> > > but retains register values, which means PHY setting can be skipped during
> > > PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> > > after that.
> > > 
> > > Hence, determine whether the PHY has been enabled in bootloader by
> > > verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> > > available, skip BCR reset and PHY register setting to establish the PCIe
> > > link with bootloader - programmed PHY settings.
> > > 
> > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 91 +++++++++++++++---------
> > >   1 file changed, 58 insertions(+), 33 deletions(-)
> > > 

> > > @@ -4042,16 +4057,22 @@ static int qmp_pcie_power_on(struct phy *phy)
> > >   	unsigned int mask, val;
> > >   	int ret;
> > > -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> > > -			cfg->pwrdn_ctrl);
> > > +	/*
> > > +	 * Write CSR register for phy that doesn't support no_csr
> > what is CSR register?
> The registers of PHY.

So 'CSR registers for phy' means 'registers of PHY for phy'? that seems
incorrect.

> > 
> > > +	 * reset or has not been initialized
> > > +	 */
> > > +	if (!qmp->nocsr_reset || !qmp->phy_initialized) {
> > > +		qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> > > +				cfg->pwrdn_ctrl);
> > > -	if (qmp->mode == PHY_MODE_PCIE_RC)
> > > -		mode_tbls = cfg->tbls_rc;
> > > -	else
> > > -		mode_tbls = cfg->tbls_ep;
> > > +		if (qmp->mode == PHY_MODE_PCIE_RC)
> > > +			mode_tbls = cfg->tbls_rc;
> > > +		else
> > > +			mode_tbls = cfg->tbls_ep;
> > > -	qmp_pcie_init_registers(qmp, &cfg->tbls);
> > > -	qmp_pcie_init_registers(qmp, mode_tbls);
> > > +		qmp_pcie_init_registers(qmp, &cfg->tbls);
> > > +		qmp_pcie_init_registers(qmp, mode_tbls);
> > > +	}
> > >   	ret = clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
> > >   	if (ret)

-- 
With best wishes
Dmitry

