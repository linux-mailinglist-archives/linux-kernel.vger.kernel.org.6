Return-Path: <linux-kernel+bounces-418533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952F9D62B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34162B23F90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E611DF978;
	Fri, 22 Nov 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkI1nmkF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41C1DF971
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295252; cv=none; b=esI64d5eOF6kIrWgQdPo9TEK4nCnDzW9SJschZfGm6II5nnxgpILoSIdqQEDlR/RbHq62BoLD0gsWyPwJlF/HFMWbP5ubfA59LlFQUMa+kknU+s4EoARA1amfr4Ck0pRY7FxkV9MULDZK4HQi9rpYHuT13gNJoc9qGdhxhrjYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295252; c=relaxed/simple;
	bh=qHGeW+9YJHnoV8xlYG8Yntca2NxQVMAEhNoIhEt+6xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBdGOsU28UlxU7zvBoEsl2XamH9HTwF8Zbzjo31wtmxYGJdsbkcEd1fS9iNs7skFV9U4tH7HoN53G7O0CR6NmhLo4vW30dUf3GuZTA5Q31yjyJqmc/Cf4d58dXOhMXYphfmIkK26xVzpt/Nxspex+4WcnMtUp+p2g/nAJyq4N84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkI1nmkF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7240d93fffdso1936588b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295250; x=1732900050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/2iR2t92OCH9/EybMxXNXRhh30tebsZGZl/G3WtQ4A=;
        b=PkI1nmkFNbg40iAjHfbpK8fx/tPj5m3Sglq2emncXcuVpB+ur+6+vf1TAnWuhzV3tU
         bWsMb99G6w6CIlxZCp8Fu0N1gyziWG2MPKCBVuStdw5dGBMH63tP0MUipwF5appfzShs
         VKCLFlfuR+aTaNguGX/J80uPEXokG7qLwrIGH4K7zTonUi1cWvv6H9aYN8IQcRub+IgR
         gYdGoxjYgKqyST98FvK7E9ebSOQZebSSGDf8Dd8ZXl5hamMqdChiSiumMHzbpsZ1PdTy
         3mE1AQ0OwC1YquluK1kzLBXmmgVB1DnsnrUeXJ5VX1UwAfihzWfs/eGIrvPikv3bSNba
         2AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295250; x=1732900050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/2iR2t92OCH9/EybMxXNXRhh30tebsZGZl/G3WtQ4A=;
        b=SaVxT4ONrC+jK0I62q/CwFyD5f8AUm0GY/7rESm8YygRLzDHLXOUSzEG/Ch+owR4Q/
         aInfhhshBHoCwR7EM3pWMPWcUoe2QyfAN0v3v6tjfj1FDvVY5fPuYmAvfr/NLJTDPB3z
         mvpTgcOVHZpxzSqAHSVtLMww6B6XeDZkGaLd2kekAKieZi9xRAY9s7X1W8zVYkaddj80
         nU0lxqyWG/gfcRggvSTQ8TVQ02/q80jtnTNAfLVqc8Ng7IVnzcjLKYj9LibLcOqXFfz4
         p9i+xaxaxi5/vEKXYMSdgEvdFhZy/gwMG4JGiC0mvd9vNZLdSQStxxTypQTlBoirg19l
         O5gw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvDVifIpKmQGDkh2JU9riaCB0+cPhLqytT9Tqpn1xdp8/vuTzyUDm68/NCCdtxI7ntyAsas5oranE93w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwADGQCRT5eHz+qlfYbEPhNUnmClRwdopfbGWtZPbNNOxdycpz2
	aI3RrzeZA9d702cA+jPqqhOKprFW/37BGcVERUJzFoaFkS6pxOGJL8IPANS02Q==
X-Gm-Gg: ASbGnctBhJ8lDxVyXUmFioj1/43i9EVUPu6ZfNIGrRWTtpEwqLWknf6k+FPRD8CUWpB
	ZiFYt6Q5Y10jUD/pmToJfVPXkQ0tP7JeKmbMbdZwbUHStIxN45o8bRj+joXD+VPg+45gQJfbskU
	2dBqttkhfLMKL4ImiYYjozB4ne4DAEF9lX4fehI+QdPFolD8h9qfZzRRmhMEwCz+bKwKSy++4SH
	UmW/ZDLWROsIgB8Ce2nRmCHFW9RiLpEt3ZZfmDTyuW8C82vpXNAhVRHSF2p
X-Google-Smtp-Source: AGHT+IGZvDpaoKhSksqbzMsm60Yp0W7DGNYEnn4YmD/coS4PDUIKaXASCZ3cNh00dMOu8rfdsP6n3g==
X-Received: by 2002:a17:902:d4c6:b0:20e:a2f7:8ab9 with SMTP id d9443c01a7336-2129f6ac33amr44650405ad.27.1732295250203;
        Fri, 22 Nov 2024 09:07:30 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba1b40sm18541705ad.87.2024.11.22.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:07:29 -0800 (PST)
Date: Fri, 22 Nov 2024 22:37:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
 deassertion symmetric
Message-ID: <20241122170723.s43eokayvnuhas4r@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-6-hongxing.zhu@nxp.com>
 <20241115065221.scfb2chnoetpdzu6@thinkpad>
 <AS8PR04MB8676D25A87FBF45E2B1D26628C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676D25A87FBF45E2B1D26628C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:59AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:52
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
> > deassertion symmetric
> > 
> > On Fri, Nov 01, 2024 at 03:06:05PM +0800, Richard Zhu wrote:
> > > Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let
> > > it be symmetric with imx_pcie_assert_core_reset().
> > >
> > > In the commit first introduced apps_reset, apps_reset is asserted in
> > > imx6_pcie_assert_core_reset(), but it is de-asserted in another place,
> > > in
> > 
> > I'd suggest rewording like below to make it easy to understand,
> > 
> > "PCI: imx6: Deassert apps_reset in imx_pcie_assert_core_reset()
> I'm very appreciate for your rewords. Should the imx_pcie_assert_core_reset()
>  be imx_pcie_deassert_core_reset()?
> 

Yeah!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

