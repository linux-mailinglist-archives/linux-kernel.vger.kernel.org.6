Return-Path: <linux-kernel+bounces-414698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044579D2C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9459284205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DB1D0B95;
	Tue, 19 Nov 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cR/KpTDE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780D1D094F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036245; cv=none; b=WmWFklX/SFfkjpQncMBv9mlWK0Yw9GEZ66Oulqvgb1kia0Zu4rytS2upno3g0cB9PB3dSMgpE6sQeOpSl8oXm+J+KJ8iI3TAE1VmLM+mIF2ACNlmWYEWpQVlUheAlNacdy4gfolnG+RlqyQ3Mo6NtYsls0/cdgcYayzcQBJqA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036245; c=relaxed/simple;
	bh=kvLbJ579ZwGw3Oaztv7AZcVCN5b4MH15HVGgmcj/8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDyP63tpWxyX6u4EvNjShhoZ79xIgRemJWmuNlTi4QUgBIiEE+EMzCayKFS1iZUCnkp9XK/ZhM0E1Yr27sTiAK9mXYXqdCSd05GjzcWhz6jLO019EbjO+A7AZUKq7pR/EkvmJMq2mtvGZl1M8ijyHoY2lpqIGSXcSDSK/vCCGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cR/KpTDE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea5a22d80cso1972366a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732036243; x=1732641043; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iUUWg+UGhAfZ69jZ3O5Hxqi/tTrKLMmbgFAb621AXyg=;
        b=cR/KpTDEgBQGSMM9IX/9DcjhRtrjBECc4DLuL++mrfhj6BYnu/PJXqxmD3ZjPBPqtf
         vD5AIaHmNPfxic9TDtIZz6KN/MY96olvObj7Xs4bhAf2aR8+1u6hEzZj8sgtNkoSw/A2
         Wpp/vatU9zB1qp1K88sLHDjkUdItS8+nBr5PTEjwHFUuSRktdjEjJo7sQHenxKwzGcE1
         X8wX+8Aa7F7DCceXmJXgWAWnA1jOZt9FlpjY2G3ltZC3R2ykk597Q80tZLpPndrhL27J
         moBoXxO31JMfvQ/KMBYTxPnEXck7DjooJsE88jn3qnI7t+hh2uENKoJGCY1q3/oTeYbB
         8x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036243; x=1732641043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUUWg+UGhAfZ69jZ3O5Hxqi/tTrKLMmbgFAb621AXyg=;
        b=tYS2NFsR0Wd9/gk9yjkS62eaYauu49xXaj0hm9q7XQc8Hhd4FTb/vl07eRWP0Aqj1t
         /klPUXYSZeo7xkBX5RokRW2SJkVSNLqTaLdsLIMHmIdw9tupcAXsfJmnMrIcIi2KsT6+
         xdf6XnYwKlph1sDDCbCCOY2NipKVB7EVPFPPB4fzrGqTkQfl4PZLgQSz1yylfMjobub5
         TBrcrpuBE96ovEpcnaQMJeRAQj6Tzzhj0SX5MYkA2rSngyTz5xz9KYtxgge8+Xg9KqY2
         HeOqn0lZYoUWbMB2heoosqwCDIJm0KYagaM8ApRkWyPef0hYCodd/1LCBMG2OMtmrioQ
         pW2w==
X-Forwarded-Encrypted: i=1; AJvYcCXw2VuMDTOnttxaGNyKl+nHBy4Vvm6TFvG/jdFUKevQn7Z/hC6PeLX4CcmvFKWXcfe2K+8E8jiBOnFr0lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceP4VQiDz8HcDr5A6dhvGISD6OYSt12GRmqaBhGw+2aeK2CWz
	gMhxqSnAIZaF1gdsRnBuFJsABYNTILR+S4hmbYFC8HxAH2iNCKojZFfS0ausmw==
X-Google-Smtp-Source: AGHT+IE7E3Zp2kHPwg5lXWa8INvXlJxcFdphad7gNVjXAQACkRCQ/vp5YyEU16SHnGc89YQPOSIJpw==
X-Received: by 2002:a17:90b:3c52:b0:2ea:95ac:54d1 with SMTP id 98e67ed59e1d1-2ea95ac56damr6412420a91.19.1732036243274;
        Tue, 19 Nov 2024 09:10:43 -0800 (PST)
Received: from thinkpad ([36.255.17.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea499aff4esm5636614a91.34.2024.11.19.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:10:42 -0800 (PST)
Date: Tue, 19 Nov 2024 22:40:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
Message-ID: <20241119171037.53zxi47u643zztvx@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241115112802.66xoxj4z5wsg4idl@thinkpad>
 <6e9db73e-0441-453c-978c-961f308f8a11@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e9db73e-0441-453c-978c-961f308f8a11@quicinc.com>

On Fri, Nov 15, 2024 at 10:31:17AM -0800, Mayank Rana wrote:
> 
> 
> On 11/15/2024 3:28 AM, Manivannan Sadhasivam wrote:
> > On Wed, Nov 06, 2024 at 02:13:37PM -0800, Mayank Rana wrote:
> > > Based on received feedback, this patch series adds support with existing
> > > Linux qcom-pcie.c driver to get PCIe host root complex functionality on
> > > Qualcomm SA8255P auto platform.
> > > 
> > > 1. Interface to allow requesting firmware to manage system resources and
> > > performing PCIe Link up (devicetree binding in terms of power domain and
> > > runtime PM APIs is used in driver)
> > > 
> > > 2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
> > > controller. Using existing MSI controller based functionality by exporting
> > > important pcie dwc core driver based MSI APIs, and using those from
> > > pcie-qcom.c driver.
> > > 
> > > Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
> > > compliant PCIe controller based functionality. Here firmware VM based PCIe
> > > driver takes care of resource management and performing PCIe link related
> > > handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
> > > request firmware VM to perform these operations using SCMI interface.
> > > --------------------
> > > 
> > > 
> > >                                     ┌────────────────────────┐
> > >                                     │                        │
> > >    ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐
> > >    │     Firmware VM      │         │                        │            │         Linux VM         │
> > >    │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │
> > >    │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │
> > >    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │
> > >    │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │
> > >    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │
> > >    │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │
> > >    │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │
> > >    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │
> > >    │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │
> > >    │               │  │   │         │                        │            │       │          │       │
> > >    └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘
> > >                    │  │             │                        │                    │          │
> > >                    │  │             └────────────────────────┘                    │          │
> > >                    │  │                                                           │          │
> > >                    │  │                                                           │          │
> > >                    │  │                                                           │          │
> > >                    │  │                                                           │IRQ       │HVC
> > >                IRQ │  │HVC                                                        │          │
> > >                    │  │                                                           │          │
> > >                    │  │                                                           │          │
> > >                    │  │                                                           │          │
> > > ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > │                                      HYPERVISOR                                                          │
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
> > >    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐
> > >    │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │
> > >    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │
> > >    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘
> > 
> > Thanks a lot for working on this Mayank! This version looks good to me. I've
> > left some comments, nothing alarming though.
> Thanks for reviewing change. I would address those in next patchset.
> 
> > But I do want to hold up this series until we finalize the SCMI based design.
> ok. I want to send these changes which are prepared based on previously
> provided feedback, to see if we have any major concern here in terms of
> getting functionality.
> 

That's fine. My comment was a note to the maintainers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

