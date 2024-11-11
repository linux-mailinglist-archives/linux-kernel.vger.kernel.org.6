Return-Path: <linux-kernel+bounces-403609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06089C37D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F359E1C21416
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC861537CE;
	Mon, 11 Nov 2024 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omqKtDo7"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778C14F9F8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303214; cv=none; b=Rh5A6pQNCJCB4ZDVe6gqt7irZlwO8cLkj/qA2VNS0MPeJGll6EaAX5D8IdsVAX/6awG6Kz9yX1SybDfSZFbtyiXVEIypUmqpoaWCb8qvA1t5h/QWcFjyAbV7DzZxXc5vBprXcsh6oPd+eCbfMDR8i37ifrBNmddSy32XscupN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303214; c=relaxed/simple;
	bh=sbcKthTcc4q13LbsAW8yGi8wstMcdZ9WG7mZdhavg/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKOjJco5UlmTnl0pSrQqfXzwc3IzZtGtjU++k+l8aC0gxJELYkQ2+Xe0dRav7o7QQEB3yviLKiyebx9p8mDhYiivNtDejZF5MhMgVkhRowYLVk5uIjHqs16Hzc/moDELEEcNHvD2euAcjV3xhyvDrLWv4/4Rzw3jb5PWXzkxk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omqKtDo7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3426385b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731303212; x=1731908012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4HVRdgGS5DOA+EYctmE9uWaF+AEiWCZv1bh01Vt6XE=;
        b=omqKtDo7p9b0eFV/c55UjplA1CF52FAo4vN6UuQ+H8aV7TdM8O/P+70OjcsVl4Uegq
         14bEjVN28mwBBehLGO0luqIC+VvEJxcBQhMd1/xNfhgTm9HK7S4LsBb/MZoUk2ZZjjcR
         M9T2iTOoRgOcAFfSeo/EktvZ/vKIV/X/35/Lxnddi9p8xKVf3P5bHDeyTGQWXlcd5WII
         FNc1u1uObahvg0Iq0MegadZPazh6Es3BfM9KjoA8ver6f3KafgrXeeWm12+mSp5YlGcw
         x0DC/rJrusmOVFLq9BNVeph8ZV/3SQLdDewSuMLAg4x8QTN3mJwAHGTMccHN1ZHr+QKi
         PJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731303212; x=1731908012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4HVRdgGS5DOA+EYctmE9uWaF+AEiWCZv1bh01Vt6XE=;
        b=uA1iKEZWsbqKT8t4DbD4oiTsYqp36O53ozaxyY3XO3Tx8uCAIhA+M5WizLxszrz7rV
         Hu5myL3pPLM5p9XBKUCf1lxCsQxm6d1LVUYfabiIEWUPJu5TyXVugG2evt2QvtnZpEMm
         TA+dNcd2pgdgxBR/Vd3N/SZKTWV9CwRAJFHuOom+u/aTcG+Chdy6kySwNHFzq8DNgl3H
         PIY4S4w4veO+B3kTqJW2sDvT9L+ApJi8k+Bolb+DpcT10EfCJdU/CHobbpuNB6IvsXR9
         g94qbQavr+txrHU8tL4AZS2wJWd4eA6k17me1IgV59r8zB9YZPcUqAUt/TJ1f3A4xDMB
         c/kw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8q9u0r6YsroK15Yyh0IyyAx+BxQqJI6aweFGVmhZ4MG+u9ilyEb15D/cWwgIAqWjXhrc64diV4Bc8b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/ND0G3MX+oYvDLkOyKiskvqYZDSVBmoRiqOGE/JN1LFl/Psh
	UUxqc9JixBMPDTExHm7hJH9STjBBO/6TT90djyoMGqcPNUgL/CpiVXMMG0IaZw==
X-Google-Smtp-Source: AGHT+IHY6okJDvEtYsogRJLe7mNmV55cCGW94l3n3BHyFg2QQU1s60l9Oqs0JWjKaeWbNyoHkDvVGw==
X-Received: by 2002:a05:6a20:8417:b0:1db:eb2c:a74 with SMTP id adf61e73a8af0-1dc2296b6admr16767552637.12.1731303212263;
        Sun, 10 Nov 2024 21:33:32 -0800 (PST)
Received: from thinkpad ([117.193.211.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724216f0642sm4314638b3a.151.2024.11.10.21.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:33:31 -0800 (PST)
Date: Mon, 11 Nov 2024 11:03:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241111053322.bh6qhoigqdxui65l@thinkpad>
References: <20241108002425.GA1631063@bhelgaas>
 <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
 <DU2PR04MB8677ECC185DFF1E2B62B05858C582@DU2PR04MB8677.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU2PR04MB8677ECC185DFF1E2B62B05858C582@DU2PR04MB8677.eurprd04.prod.outlook.com>

On Mon, Nov 11, 2024 at 03:29:18AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
> > Sent: 2024年11月10日 8:10
> > To: Bjorn Helgaas <helgaas@kernel.org>; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; jingoohan1@gmail.com;
> > bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > robh@kernel.org; Frank Li <frank.li@nxp.com>; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
> > dw_pcie_suspend_noirq()
> > 
> > 
> > 
> > On 11/8/2024 5:54 AM, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam
> > wrote:
> > >> On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > >>> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > >>> safe to send PME_TURN_OFF message regardless of whether the link is
> > >>> up or down. So, there would be no need to test the LTSSM stat before
> > >>> sending PME_TURN_OFF message.
> > >>
> > >> What is the incentive to send PME_Turn_Off when link is not up?
> > >
> > > There's no need to send PME_Turn_Off when link is not up.
> > >
> > > But a link-up check is inherently racy because the link may go down
> > > between the check and the PME_Turn_Off.  Since it's impossible for
> > > software to guarantee the link is up, the Root Port should be able to
> > > tolerate attempts to send PME_Turn_Off when the link is down.
> > >
> > > So IMO there's no need to check whether the link is up, and checking
> > > gives the misleading impression that "we know the link is up and
> > > therefore sending PME_Turn_Off is safe."
> > >
> > Hi Bjorn,
> > 
> > I agree that link-up check is racy but once link is up and link has gone down
> > due to some reason the ltssm state will not move detect quiet or detect act, it
> > will go to pre detect quiet (i.e value 0f 0x5).
> > we can assume if the link is up LTSSM state will greater than detect act even if
> > the link was down.
> > 
> > - Krishna Chaitanya.
> > >>> Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> > >>> Because the re-initialization would be done in
> > >>> dw_pcie_resume_noirq().
> > >>
> > >> As Krishna explained, host needs to wait until the endpoint acks the
> > >> message (just to give it some time to do cleanups). Then only the
> > >> host can initiate D3Cold. It matters when the device supports L2.
> > >
> > > The important thing here is to be clear about the *reason* to poll for
> > > L2 and the *event* that must wait for L2.
> > >
> > > I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> > > waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> > > for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> > > 5.2, fig 5-1).
> > >
> > > L2 and L3 are states where main power to the downstream component is
> > > off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> > > no link in those states.
> > >
> > > The PME_Turn_Off handshake is part of the process to put the
> > > downstream component in D3cold.  I think the reason for this handshake
> > > is to allow an orderly shutdown of that component before main power is
> > > removed.
> > >
> > > When the downstream component receives PME_Turn_Off, it will stop
> > > scheduling new TLPs, but it may already have TLPs scheduled but not
> > > yet sent.  If power were removed immediately, they would be lost.  My
> > > understanding is that the link will not enter L2/L3 Ready until the
> > > components on both ends have completed whatever needs to be done with
> > > those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> > > PCIe book; I haven't found clear spec citations for all of it.)
> > >
> > > I think waiting for L2/L3 Ready is to keep us from turning off main
> > > power when the components are still trying to dispose of those TLPs.
> > >
> > > So I think every controller that turns off main power needs to wait
> > > for L2/L3 Ready.
> > >
> > > There's also a requirement that software wait at least 100 ns after
> > > L2/L3 Ready before turning off refclock and main power (sec
> > > 5.3.3.2.1).
> Thanks for the comments.
> So, the L2 poll is better kept, since PCIe r6.0, sec 5.3.3.2.1 also recommends
>  1ms to 10ms timeout to check L2 ready or not.
> The v2 of this patch would only remove the LTSSM stat check when issue
>  the PME_TURN_OFF message if there are no further comments.
> 

If you unconditionally send PME_Turn_Off message, then you'd end up polling for
L23 Ready, which may result in a timeout and users will see the error message.
This is my concern.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

