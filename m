Return-Path: <linux-kernel+bounces-533024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30BA454EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02B97A0FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E61922DC;
	Wed, 26 Feb 2025 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNcSHEow"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2514430
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547922; cv=none; b=qdDXWkxXQcgjs+aTRsojdxBuazdtJd2jXK8FRLrEzubT/nZIGtrZLVPcnxoqU3BQrNnGmRT+KsScbrINbHTVBlefv2XnT8NkqUqQUbIOfIYGmigzEUXjjhDZ1oQpHfdNU8VfXG5sUvM7IQjyt/sW26TohmI2HCRblZFiW7Q64M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547922; c=relaxed/simple;
	bh=aRqVdEuak5heTNn+0IQ7qSzt5Pfpvlefp5Eal42WI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7tJmijibqZl6Zsir7gCTT4qrgvLSUvPqDAeI7PM1Akjc3vEcgUh82mfyJjtRZnleN4hUrccGvJtOb4MQAStQMBH2tbopch3ruNNCBPta8j/CXM6NjmkUq0e9RwEh7OM3uc4L7xkDlR9pxgKPIILvhHSkpauyigNLIJ3IN9o1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNcSHEow; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d601886fso97781635ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740547920; x=1741152720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cs/FB4vjop09Xx6EiHePqeXJoRbdqusicfo9VoaYw5E=;
        b=UNcSHEowNK9r1D3LFH/yGNXwxbZbKYfP+G2EMK/v3rydARUsj/HJ1618zBZoHZZZnC
         P6B68dDbwL8sxmz52YTkov4tpQD+0l1txdYJC8smuFcpzTO02MvYE/rD/sp3toQdsYg0
         ABekkQsLJurf+WpU8qrKoIoUNmhfpXNxIwdlLERnGsY58nBcOj+UIJxOe/oQFJigpQYZ
         UtPEOFhcsfM8Vlo0hYpzCgWgIJaB5zdksVsobHs0qbKwLAsg1nSknWQe1a3Blw97TCKk
         vDbA8+SAVz4ywvktewBD759dkaYy9xhvFK5bR/4VNk+0j6bbQ2qPsku5p9F822LcXi7O
         XlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740547920; x=1741152720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs/FB4vjop09Xx6EiHePqeXJoRbdqusicfo9VoaYw5E=;
        b=wWgKICj10i0Xh8z16I27h+zQcutEXXG2tY3jhFxqqunOiE/Eqez2b/A5YC0NUBo5rU
         6hjzIFcMYm+O9e87w2u2FVc1tAxqN/69BdLWPYgudvzQGbVxRauuE0PiTQXMiiZb0481
         kHkLBihki4NzRiRQRzBDhpPsnOu9cs3qyrNskT0DugR/EJJTAOb+0zCPm6DTC1vftcP4
         T0BRzFp7x8iLFrCnZuK82/L8wikICbfxltVUAUbKoVha/qK0JLZC7CrEAT8CNK809lUK
         iG8nIAlih/Lcm0mn7ikQsRe+RQCpLzLDCWbwLVNrswBhnGsmGeXfiT2g9E7P0/mBesTA
         NAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSpOLk0/WD4QVCiQ/uzHgyXbsMZDko8AeJZn4nBVoCSlt6eF4ERcieh/wTInz2hkL5xl82eGlhfiANm/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ppvslHSGdeZqtEsFSndM8AHkMpRJ4gdw2DCHj+WRvAynybEe
	pcRm8E1FaYIeDE7LFjFHfmJ9yEtuvN/gMLqeFOu3Zn7WjyY5yfClGNdM1Sx/sg==
X-Gm-Gg: ASbGnctYwBHnBO2L9vqMavBzZseeWG6YmdJE9bDGBIUG75V+GLxMPVy3ioaN2x6wnLE
	KeiDCclS1Vvd+UPeGxDlvQYQQLvA4yaFO7eYRt3/6I8fpEu6pZs2oi0XmdImgxdrshgzieV6zf3
	gIU4Bh0ypw6WU9ggmSQ7gg2WD3BQ3OMxRVEi6WPwmALxl209sH7HbaUPJhsyIMmm38ftEKoPfR6
	OUiT7pUHUhC8hSLGw61F7zAY3P83w5cn3FMZ1akDYOije5T/BcMT0e4AnFU+cdUoC/A/iskf7Pk
	ILTv8Z3F/0MVQ26UaQEwfCsjYeYRVS8CeecvcGN1Gi8M0/brgpvXOMY=
X-Google-Smtp-Source: AGHT+IEPcQAWKYX9SpkFskmh4pTKxjy5wF3kTp/GFxEcYxWygfsPcia+keXfCSwcEiGOT4D3V58cmw==
X-Received: by 2002:a05:6a00:3d48:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-7347918de02mr10524786b3a.16.1740547920456;
        Tue, 25 Feb 2025 21:32:00 -0800 (PST)
Received: from thinkpad ([120.60.72.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9aafsm2570705b3a.105.2025.02.25.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 21:32:00 -0800 (PST)
Date: Wed, 26 Feb 2025 11:01:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>,
	"Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, vkoul@kernel.org,
	kishon@kernel.org, p.zabel@pengutronix.de, abel.vesa@linaro.org,
	neil.armstrong@linaro.org, quic_devipriy@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <20250226053155.5cdzeorzb5jlvdna@thinkpad>
References: <20250224073301.aqbw3gxjnupbejfy@thinkpad>
 <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
 <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>
 <20250224122439.njrcoyrfsisddoer@thinkpad>
 <eea55dfa-3dd3-488b-958c-cd20e18a7d7d@quicinc.com>
 <20250225081744.3aprpztylrdgs2cl@thinkpad>
 <4a672888-a90e-434c-b494-bb58b91c99a2@quicinc.com>
 <zppwzqdi5xbggurbqho6ivuorvlubldpjw3pyw2fdgrap4nrhp@5otsko6o5cv3>
 <47f5ab83-d25f-4132-83a6-38236575510c@quicinc.com>
 <ophii26vvcogjtvktsexi6ffnug2wi5hjsppyb44uhypk43o5b@t4bbghgatd73>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ophii26vvcogjtvktsexi6ffnug2wi5hjsppyb44uhypk43o5b@t4bbghgatd73>

On Wed, Feb 26, 2025 at 07:19:11AM +0200, Dmitry Baryshkov wrote:
> On Wed, Feb 26, 2025 at 11:12:18AM +0800, Qiang Yu wrote:
> > 
> > On 2/25/2025 7:46 PM, Dmitry Baryshkov wrote:
> > > On Tue, Feb 25, 2025 at 06:08:03PM +0800, Qiang Yu wrote:
> > > > On 2/25/2025 4:17 PM, Manivannan Sadhasivam wrote:
> > > > > On Tue, Feb 25, 2025 at 04:06:16PM +0800, Wenbin Yao (Consultant) wrote:
> > > > > > On 2/24/2025 8:24 PM, Manivannan Sadhasivam wrote:
> > > > > > > On Mon, Feb 24, 2025 at 12:46:44PM +0100, Konrad Dybcio wrote:
> > > > > > > > On 24.02.2025 9:46 AM, Wenbin Yao (Consultant) wrote:
> > > > > > > > > On 2/24/2025 3:33 PM, Manivannan Sadhasivam wrote:
> > > > > > > > > > On Thu, Feb 20, 2025 at 06:22:53PM +0800, Wenbin Yao wrote:
> > > > > > > > > > > From: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > > > > 
> > > > > > > > > > > Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> > > > > > > > > > > whole PHY (hardware and register), no_csr reset only resets PHY hardware
> > > > > > > > > > > but retains register values, which means PHY setting can be skipped during
> > > > > > > > > > > PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> > > > > > > > > > > after that.
> > > > > > > > > > > 
> > > > > > > > > > > Hence, determine whether the PHY has been enabled in bootloader by
> > > > > > > > > > > verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> > > > > > > > > > > available, skip BCR reset and PHY register setting to establish the PCIe
> > > > > > > > > > > link with bootloader - programmed PHY settings.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > > > > Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> > > > > > > > > > Some nitpicks below.
> > > > > > > > > > 
> > > > > > > > > > > ---
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > > > +     * In this way, no matter whether the PHY settings were initially
> > > > > > > > > > > +     * programmed by bootloader or PHY driver itself, we can reuse them
> > > > > > > > > > It is really possible to have bootloader not programming the init sequence for
> > > > > > > > > > no_csr reset platforms? The comment sounds like it is possible. But I heard the
> > > > > > > > > > opposite.
> > > > > > > > > PCIe3 on X1E80100 QCP is disabled by default in UEFI. We need to enable it
> > > > > > > > > manually in UEFI shell if we want.
> > > > > > > > IIUC this will not be a concern going forward, and this is a special case
> > > > > > > > 
> > > > > > > I'm wondering how many *special* cases we may have to deal with going forward.
> > > > > > > Anyhow, I would propose to atleast throw an error and fail probe() if:
> > > > > > > 
> > > > > > > * the platform has no_csr reset AND
> > > > > > > * bootloader has not initialized the PHY AND
> > > > > > > * there are no init sequences in the kernel
> > > > > > > 
> > > > > > > - Mani
> > > > > > Hmmm, regardless of whether it's a special case, we can't assume that UEFI
> > > > > > will enable the PHY supporting no_csr reset on all platforms. It's a bit
> > > > > > risky. If we make such an assumption, we also won't need to check whether
> > > > > > the PHY is enabled by UEFI during powering on. We just need to check
> > > > > > whether no_csr reset is available.
> > > > > > 
> > > > > I am not supportive of this assumption to be clear. While I am OK with relying
> > > > > on no_csr reset and bootloader programming the PHY, we should also make sure to
> > > > > catch if the PHY doesn't initialize it. Otherwise, the driver would assume that
> > > > > the PHY is working, but the users won't see any PCIe devices.
> > > > > 
> > > > > > But it makes sense to check the exsitence of PHY senquence. How about
> > > > > > adding the check in qmp_pcie_init, if a PHY supports no_csr reset and isn't
> > > > > > initialized in UEFI and there is no cfg->tbls, return error and print some
> > > > > > error log so that the PCIe controller will fail to probe.
> > > > > > 
> > > > > Sounds good to me.
> > > > I'm wondering is it necessary to add this check? In current PHY driver,
> > > > for PHY that doesn't suppot no_csr reset there is also no such check.
> > > > If a PHY supports no_csr reset and isn't init in UEFI and there is no
> > > > cfg->tbls, the worst issue is link training fail and PCIe controller will
> > > > also fail to probe. Adding sucj check seems not change the result.
> > > Failing the training is a random error which can mean a lot, e.g. the
> > > missing voltage rail. An explicit check is beneficial, it helps
> > > developers (and users) to better understand the reason of the failure.
> > In the struct qmp_phy_cfg, tbls is not a pointer, we can't directly check
> > if tbls == NULL to determine if the PHY init sequence is available. Can we
> > add a separate patch to change the definition from
> > "const struct qmp_phy_cfg_tbls tbls" to
> > "const struct qmp_phy_cfg_tbls *tbls" like tlbs_rc and tbls_ep, even though
> > this will affect all platforms?
> 
> Of course no. There is no need to introduce extra indirection. Checking
> for qmp_phy_cfg.tbls.serdes_num should be more than enough. No matter
> what, the PHY with a proper configuration tables will have non-empty
> SERDES table.
> 

+1. The check needs to be present in this series itself and it makes absolute
sense to have it. Otherwise, it will become a hard to debug issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

