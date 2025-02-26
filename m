Return-Path: <linux-kernel+bounces-533013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36FCA454D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DBE3A9C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51570218AAF;
	Wed, 26 Feb 2025 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1JCnNMx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B11607A4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547159; cv=none; b=k24pxx2uC9CuNXqeHMZleURb49GlEmeb6F25ySM3yvb6SocieFBMZ8HKwQGQOrYVhDphNW10kPz4HiIxxK4lCk4aobDqv0xJsG+pk34NvS9jrHCtl8QrpQI0TyRKrxRtRG44Zrh4yBW7zYGaFIifFQL2r83nugzueA+yNVcAUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547159; c=relaxed/simple;
	bh=PU4rgz4UqbomnvL0C0GUKnj/4S461kaQTOJVw1OcS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5sSKLt46sga1JjZZzlQ8sQj6sQFll0EWQxW172goDRCNOiashD15NvsWINBUrwyB/NQasdLKHIkheoPzstzoZN07/whuQztVmbglPSH4va/HfBShrmpAJ0nQ35lN781wRnz8tVzvbqrN+ha3YcStGLV4t5/Gv/gBRFrL9OAlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1JCnNMx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-545fed4642aso6075445e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740547155; x=1741151955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zF9gFcyKZ4Btfiq3+cszj8NUyBbRLBvZ0lzqaTVmau8=;
        b=i1JCnNMx9xvwKnYBW4Px5mcZtIIpxNCzF0bm2s8PTsobK5HnWs0WOskdLuijF7IQ2/
         L1OztCZ9hnrOcP2fzwS3cEmhHHSpG76pw21U+Qt80GXJaKMNuwKQ759B1MjvF/xjQteK
         nTSQSlDNpNNO5UFlLNqxBS0YxasSc6SBwhHnA/ugDbMD9B7C8GHzTG3c6nWyyT3OJy+x
         fP1rnENIkvH5j49K4q7dn+sgqMDbsXBubB7B7I2Js3pBv2+S/JFj+mrGDUeAP/kGvvyh
         pikDsEs6s+AsPLaYYFuE9osAr8a5zkw9r0JOiZt1VSv7CQK69tlBFWmiMNKt2obTidaR
         W16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740547155; x=1741151955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zF9gFcyKZ4Btfiq3+cszj8NUyBbRLBvZ0lzqaTVmau8=;
        b=NY9oqaz6IDXwfBEeVtJLreAA6TACt+5XFFNz2aQOj1+kRI7GGu+J6sWMc5NRT7p8Cq
         TaGVIgCJMzovBB1Rja5WQM95RcyNxF95VxFnyek2Gv0ZxVPkx4TycDh+b1UUnzepbHdq
         d+IvbPjDCmDnmT886EZ+amqtOCOVsJ3NSljeiJAadkq5YZWdHt+EeH3fPxEp71B2yo4p
         CGKI+3b99cxq/VRA2AJ7hm8vP30UdeZ+HHcc8BdulGt61U4ztFKgVvv5OWfgf4z9c3Zi
         vFowj52DVtjfU6CBu+a1kZ5DvqfHd065nxHHDSlNxRjLfctTDurC3IlsOQikbRNDjKFk
         a6BA==
X-Forwarded-Encrypted: i=1; AJvYcCVgDseI5mUVgtywI+ORF2ataCSks5gvyiKdsv9XqvmeI0+rIX6IJouWMzLjZC7snOmTp/NGg4yPBIIexcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqyL98DW/v3SMkXyYv8VKmWAU+GLyHLTLDCX8OYuNLEEv2lJa
	qGbcSXfMVf33n6iz5AfXKdBQwKbSJ5sAtbBGZWwBE676hEBa0dbZ3/5n8rTazMg=
X-Gm-Gg: ASbGncsg7q4DG+v8bIqNOusI2rCm6YMJ246Tm5NJEu4jEtrgSZMU5s23GMubkbJDN48
	ndSrEHdfVVp9Q2Tpa8npN5HHLYXDfPTXvs5w5PYvyh3ml2Lutd2ALnJPYlJ8MvhuIe66cmx35lo
	vZ3Z2ZX7C599PuOLMpDOu5D0Vw95bfdqM/MIow2gW21BxeLBTF5rFc3Te+wjU8RQDljfLQ9EdrA
	y6GyqxJPYlj2buJa7BUaYpPzpwbOvCL4ympKNFbnJumKOzxWEJ61V3IYaRxUp9cK4D1cvN5cgtD
	U/NywOVv2cN2NmKrPMiJYG9KBu9T5B7l87A2Vnk7PQoeA6bDB0uVVFdm8WKhy6uqRMI/f6k8b0x
	htjuwLA==
X-Google-Smtp-Source: AGHT+IHxPX3HbPicsOXhvRZbaE9MW4TbT5RH1tcAURZxDzAmkFlXwfGCZD0yRzM+p1X+SJrXmqCkLQ==
X-Received: by 2002:a05:6512:3049:b0:545:3031:b4d7 with SMTP id 2adb3069b0e04-54838edda6fmr8881336e87.6.1740547155397;
        Tue, 25 Feb 2025 21:19:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514efdf7sm341633e87.108.2025.02.25.21.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 21:19:13 -0800 (PST)
Date: Wed, 26 Feb 2025 07:19:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, vkoul@kernel.org, 
	kishon@kernel.org, p.zabel@pengutronix.de, abel.vesa@linaro.org, 
	neil.armstrong@linaro.org, quic_devipriy@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <ophii26vvcogjtvktsexi6ffnug2wi5hjsppyb44uhypk43o5b@t4bbghgatd73>
References: <20250220102253.755116-3-quic_wenbyao@quicinc.com>
 <20250224073301.aqbw3gxjnupbejfy@thinkpad>
 <7ffb09cd-9c77-4407-9087-3e789cd8bf44@quicinc.com>
 <ea5de507-1252-4ff3-9b18-40981624afea@oss.qualcomm.com>
 <20250224122439.njrcoyrfsisddoer@thinkpad>
 <eea55dfa-3dd3-488b-958c-cd20e18a7d7d@quicinc.com>
 <20250225081744.3aprpztylrdgs2cl@thinkpad>
 <4a672888-a90e-434c-b494-bb58b91c99a2@quicinc.com>
 <zppwzqdi5xbggurbqho6ivuorvlubldpjw3pyw2fdgrap4nrhp@5otsko6o5cv3>
 <47f5ab83-d25f-4132-83a6-38236575510c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47f5ab83-d25f-4132-83a6-38236575510c@quicinc.com>

On Wed, Feb 26, 2025 at 11:12:18AM +0800, Qiang Yu wrote:
> 
> On 2/25/2025 7:46 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 06:08:03PM +0800, Qiang Yu wrote:
> > > On 2/25/2025 4:17 PM, Manivannan Sadhasivam wrote:
> > > > On Tue, Feb 25, 2025 at 04:06:16PM +0800, Wenbin Yao (Consultant) wrote:
> > > > > On 2/24/2025 8:24 PM, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Feb 24, 2025 at 12:46:44PM +0100, Konrad Dybcio wrote:
> > > > > > > On 24.02.2025 9:46 AM, Wenbin Yao (Consultant) wrote:
> > > > > > > > On 2/24/2025 3:33 PM, Manivannan Sadhasivam wrote:
> > > > > > > > > On Thu, Feb 20, 2025 at 06:22:53PM +0800, Wenbin Yao wrote:
> > > > > > > > > > From: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > > > 
> > > > > > > > > > Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> > > > > > > > > > whole PHY (hardware and register), no_csr reset only resets PHY hardware
> > > > > > > > > > but retains register values, which means PHY setting can be skipped during
> > > > > > > > > > PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> > > > > > > > > > after that.
> > > > > > > > > > 
> > > > > > > > > > Hence, determine whether the PHY has been enabled in bootloader by
> > > > > > > > > > verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> > > > > > > > > > available, skip BCR reset and PHY register setting to establish the PCIe
> > > > > > > > > > link with bootloader - programmed PHY settings.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > > > > > > Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> > > > > > > > > Some nitpicks below.
> > > > > > > > > 
> > > > > > > > > > ---
> > > > > > > [...]
> > > > > > > 
> > > > > > > > > > +���� * In this way, no matter whether the PHY settings were initially
> > > > > > > > > > +���� * programmed by bootloader or PHY driver itself, we can reuse them
> > > > > > > > > It is really possible to have bootloader not programming the init sequence for
> > > > > > > > > no_csr reset platforms? The comment sounds like it is possible. But I heard the
> > > > > > > > > opposite.
> > > > > > > > PCIe3 on X1E80100 QCP is disabled by default in UEFI. We need to enable it
> > > > > > > > manually in UEFI shell if we want.
> > > > > > > IIUC this will not be a concern going forward, and this is a special case
> > > > > > > 
> > > > > > I'm wondering how many *special* cases we may have to deal with going forward.
> > > > > > Anyhow, I would propose to atleast throw an error and fail probe() if:
> > > > > > 
> > > > > > * the platform has no_csr reset AND
> > > > > > * bootloader has not initialized the PHY AND
> > > > > > * there are no init sequences in the kernel
> > > > > > 
> > > > > > - Mani
> > > > > Hmmm, regardless of whether it's a special case, we can't assume that UEFI
> > > > > will enable the PHY supporting no_csr reset on all platforms. It's a bit
> > > > > risky. If we make such an assumption, we also won't need to check whether
> > > > > the PHY is enabled by UEFI during powering on. We just need to check
> > > > > whether no_csr reset is available.
> > > > > 
> > > > I am not supportive of this assumption to be clear. While I am OK with relying
> > > > on no_csr reset and bootloader programming the PHY, we should also make sure to
> > > > catch if the PHY doesn't initialize it. Otherwise, the driver would assume that
> > > > the PHY is working, but the users won't see any PCIe devices.
> > > > 
> > > > > But it makes sense to check the exsitence of PHY senquence. How about
> > > > > adding the check in qmp_pcie_init, if a PHY supports no_csr reset and isn't
> > > > > initialized in UEFI and there is no cfg->tbls, return error and print some
> > > > > error log so that the PCIe controller will fail to probe.
> > > > > 
> > > > Sounds good to me.
> > > I'm wondering is it necessary to add this check? In current PHY driver,
> > > for PHY that doesn't suppot no_csr reset there is also no such check.
> > > If a PHY supports no_csr reset and isn't init in UEFI and there is no
> > > cfg->tbls, the worst issue is link training fail and PCIe controller will
> > > also fail to probe. Adding sucj check seems not change the result.
> > Failing the training is a random error which can mean a lot, e.g. the
> > missing voltage rail. An explicit check is beneficial, it helps
> > developers (and users) to better understand the reason of the failure.
> In the struct qmp_phy_cfg, tbls is not a pointer, we can't directly check
> if tbls == NULL to determine if the PHY init sequence is available. Can we
> add a separate patch to change the definition from
> "const struct qmp_phy_cfg_tbls tbls" to
> "const struct qmp_phy_cfg_tbls *tbls" like tlbs_rc and tbls_ep, even though
> this will affect all platforms?

Of course no. There is no need to introduce extra indirection. Checking
for qmp_phy_cfg.tbls.serdes_num should be more than enough. No matter
what, the PHY with a proper configuration tables will have non-empty
SERDES table.

-- 
With best wishes
Dmitry

