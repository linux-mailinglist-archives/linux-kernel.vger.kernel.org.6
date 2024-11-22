Return-Path: <linux-kernel+bounces-418528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4E9D62AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2112A16085A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6D1DE3C9;
	Fri, 22 Nov 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzN8NUdD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432E2D638
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294641; cv=none; b=nixJFFY7TTI1C7/q5zmXPYxyr+AwmW9un0b2XE0Z9HuRJLudTktmVn3SUlgryt+eFJ+bYz4LJFQ7JkUnrb+JQ1gdMdO769GxK5kf0JcY5EBD5ypNZjEI6lO95AL3NM2wRpt+BiCb064vfkyjjZJvpmQlJZzsYo0w3TevEAUO2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294641; c=relaxed/simple;
	bh=ZNhJ0AnnhsP1xQ5LpsDqA3efNo9VGhUGzrAteBE+23s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKk1FNXz+lcP9EHVKjdaC1uVcVMS8h8Nb85lG8HJGjqn7v+SFhDP/oriF9WCJTt3UZt6uM8S7qN6wCRe1VsbtiSrw2AEBz2lZ8gUkOqurxRoMPl0QeC/QBHGMZBiM6Al/4w9aGassJNpB49svoEE5ZOsEfhS+uqn+T4E/T7fU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzN8NUdD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-212884028a3so14157465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732294639; x=1732899439; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZwDSMvFnipM0RD36mLVFKH4L1T4MEAtnhkfsYAv+8A=;
        b=DzN8NUdDbQpmQAdaoEpIXWnp08e/npx6EmJAM8JakMqMmqIppy50mR9ngjEDIvaWIn
         5xM34u9ssPBDcvuhaHn+VcZC5j0VbJtDmQFJXJf4s1qf6I3rppcO/NIdalKYGx2n2voZ
         Nb5b4iBo0iEtVNRgXQEd+LgEl1A4/sGRs/7aL7H2HFVX70JoerR8+RMfzPu+2krn47jH
         fmwjOqZIdl2A2nED1Xgi+reld+CHBQwUAVVdIvGg8fJvpVV9SOTxJsHVINMofoxU7W1w
         FtJpmskiJmsaM1HAPGqW8BrJR8e8kQk5l6fxLn0p+k+UQI76KYVta+/GklsaBcL7oZLN
         kGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294639; x=1732899439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZwDSMvFnipM0RD36mLVFKH4L1T4MEAtnhkfsYAv+8A=;
        b=vE4qH3+vFPiy3SFTBmHDiH5M6UjxqBBI8ELz3FRp3U4hSD2hOildXo+UMZpUP4HU+1
         fCCqzkAVALSQzKqPtnyJyCia1LJCfgx8rxyGQFJACWomCylF9VAZqgZj7/YFCSrEOWrf
         ZQ2oQHcjtD3WpKZDup/juOH98u79bxwSSbxvgafjIcUIy1BPSTmrlG/+LkBELYpVUovk
         gjrAUaPhxgdMwcP9J7PiQQHCpFV7Xx68U4Lcl1EBhitu81XDtKOozEHCeb0uYCXgvNhN
         O/Hnw5li8H8Q8SRtVfDoTMb1oXjVG58GSUSNQdD28zo2L5x9npQLrDRP8HsDrXx3lpDl
         nYug==
X-Forwarded-Encrypted: i=1; AJvYcCXNHXLx+lcVD2rmtoWz49nLOOIFYyU1MxIY3JaYMS3olh1c3OmNSXwIT+4e+FtTfTU1Nne8MBHtpqjMPpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94khmLSfBCo2DjugHjpKsNaU7PEuglg0NBNRBW2yK8NImk8au
	egIlDovvgPYfZ/yTeGf1dKBUvi0fn4A19/1yqgCJi6b71GZBKH27LZIs+XqxZw==
X-Gm-Gg: ASbGncsRbXIFNBljBbTZ5uty63HyKFrXOoirZ1HYp3ezvgy1ct+Cf5fJH8GCnH/ENM9
	lU+7xrsrKOVRRl/ugZdooYUlJJc3jXK28+HH+yO/zAVatOMfAbuuYJp+BecXDmR/tniG2xJFjDi
	wft57las4EjASOUDuR35euA+b8xW9E6PM39VgvlXbiC8fU6e5+0/1br9cZX+sr7/ZHF+5xyMpQ/
	iBdl3HzbfcPJk/98B+ltt7OTmNtFF6qQjX1tPv+ls45RIptfGdrt8OmeAFS
X-Google-Smtp-Source: AGHT+IEBQTm+mdF5/l17srn1QQIlJ8cpbCtyU3PjuFrTHKPmmM8RGnmeO63H3UfI8TU8tQ6zNeMktQ==
X-Received: by 2002:a17:902:d2c3:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-2129fe0903emr55796195ad.1.1732294639012;
        Fri, 22 Nov 2024 08:57:19 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21a1asm18338035ad.222.2024.11.22.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:57:18 -0800 (PST)
Date: Fri, 22 Nov 2024 22:27:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241122165712.5m7xuycxzjzatf35@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
 <ZzeHGd/vfNFgsID2@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeHGd/vfNFgsID2@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 12:38:33PM -0500, Frank Li wrote:
> On Fri, Nov 15, 2024 at 12:39:32PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 01, 2024 at 03:06:08PM +0800, Richard Zhu wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Call common dwc suspend/resume function. Use dwc common iATU method to
> > > send out PME_TURN_OFF message. In Old DWC implementations,
> > > PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
> > > generic DWC implementation of sending the PME_Turn_Off message using a
> > > dummy MMIO write cannot be used. Use previouse method to kick off
> > > PME_TURN_OFF MSG for these platforms.
> > >
> > > Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
> > > dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().
> > >
> > > Since dw_pcie_suspend_noirq() already does these, see below call stack:
> > > dw_pcie_suspend_noirq()
> > >   dw_pcie_stop_link();
> > >     imx_pcie_stop_link();
> > >   pci->pp.ops->deinit();
> > >     imx_pcie_host_exit();
> > >
> > > Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
> > > imx_pcie_start_link() by dw_pcie_resume_noirq() in
> > > imx_pcie_resume_noirq().
> > >
> > > Since dw_pcie_resume_noirq() already does these, see below call stack:
> > > dw_pcie_resume_noirq()
> > >   pci->pp.ops->init();
> > >     imx_pcie_host_init();
> > >   dw_pcie_setup_rc();
> > >   dw_pcie_start_link();
> > >     imx_pcie_start_link();
> > >
> >
> > Are these two changes (dw_pcie_suspend_noirq(), dw_pcie_resume_noirq()) related
> > to this patch? If not, these should be in a separate patch.
> 
> 
> Sorry, this patch have not touch dw_pcie_suspend_noirq() and
> dw_pcie_resume_noirq()'s implement, just call it. I have not understood
> what's your means.
> 

Sorry, I got confused. Please ignore above comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

