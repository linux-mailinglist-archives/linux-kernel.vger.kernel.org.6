Return-Path: <linux-kernel+bounces-418521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7159D6282
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45FBB274FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FCF5D477;
	Fri, 22 Nov 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7sxXxm2"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9D2D638
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294042; cv=none; b=I+Nsck64KQZLFPGXPCBSLGsfNjkcUvyTx1L0drwCq7i47a0RC0r0EWqdUT4g7/2PxbTwf9wLhvuvb8Z8CMb8y1/lQDktO5n5VOyYAEiO5xBBfI6Tfc/Wknw+b4Nk0D4HE+5i5OO0xsABV4o2w9MxnlaYj71hBsU4PyXRW+/1fGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294042; c=relaxed/simple;
	bh=ItNTKavT00h+piga1HTfcObBvAtBiGxqCrbjRJ1Tavc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJP3YA0F0E8sGDRfyBtJXi5oqXfgOEDyF7R984aBEZ72eTA0aWpdm1gHitGoDGvYkZiO8dz8RIayiK5/6tFKBbDFHYXQgkjvR14I6hm4kpEP9fu61ykyQCgdYvKLbdOPkrv1EoQRUuQ8GJLl1mLFluj55/DTf7iV9268tEPrq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N7sxXxm2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-212884028a3so14085625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732294040; x=1732898840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzq5xBGhrLm4GuYMaG3vOjkgbW2jTLhEik+B/AfpKr0=;
        b=N7sxXxm28qpSXdKXM1+JiWGvFRcSNDETzc91Xq/qDHCDzGC+Q7wjdupj7fQnIRqf7z
         qOd1jUlf2NO/MXy3qRwmHqEjJUVksk9IuTtuNdVwvareJuu41Oot2YKDmqaZb5wMiPJZ
         d9Cw/Z3hSFZ2KEtSRk4A0H+aNVDgDVzPs5nnGauQD5KeStHBiJNRvDTK+AlaoyyPcL2T
         g2uskKblMTx4NkQ+KozZqPC/aspdSRiC0Wzr9YMwGvJz1aGM2/sZvffUMukkkx6Trg7u
         ONTSqxQ9394/HY6LpZzlhR/8uljXKZrtZ0IEOFDZZakqTukL1ZaHU/0Kaze+SjCgPjGg
         OOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294040; x=1732898840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzq5xBGhrLm4GuYMaG3vOjkgbW2jTLhEik+B/AfpKr0=;
        b=Kq9yUfprpmwMNlbIiojTvHNPoJ4fXPMXISq0zq0BqZUB0N52wYFPAS0UtFM/4OEQT6
         TUHWg7f+DOtEL4u9xkblAcZxBtZBvs6H7C9aJaFqH1aDFPdesOz/o2obDXDSIFeHQ+fr
         Dzs7jDJTskEcLiew6FpECTSkL5k7b8Wh123R/69LJ2AzrQCoKoNYmRIYD2gE4P+AHNDe
         VrghlU/OKqJO1BCIg6NhaSK4mxxz889wsk851esgvO3T6gXceIYwyIm2HBKWVxQ3Gcw1
         StA+Te5ATb3MPSphvOum4f29VpsUy5P+fqrfKtWoLwYfgDDs4N+XeikdyjIF8vsF19jU
         k55w==
X-Forwarded-Encrypted: i=1; AJvYcCXFPyPZmlXbWNDiDsCAUpvCiX1Edkif/bFZUjaDUAlk5S3IPnpPwgu3EUi0uimhzJ38L4eJ8oQXcPCxwXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3cryKzxMzgUZfDsPzYjimXq+P2hJSppv3p38GjcNRjB/XYf8
	HIhKod7jvX1cJpYO45HXfJZVupIOI93HmJL+Qw2dYPYTYMSUkv5OrqLsRUBnUA==
X-Gm-Gg: ASbGnctJJyzp/A0i1HpG6sNryFXHLkF2G8hjXWbMZKIxOkwICNnTb7yu/p0hjaDUwtW
	y130XEsOR0/4iZ204Bxr9VqM+Rlj7DAhbjEtnqxJpcyVOeNSUFtGiabO24x6ik1f7iLvb+nZd6G
	eHmNXdHKS5rFJzL3D48pFRcmu5xj8Vkc3qNrl2MWUKx8L+bruaPJWpI9xZHawVoP0HOQLvm7tGU
	S6iExis60TaNNsWC8m9Ogbgd5PrjX/6MNv12u6bNEn111ej+WcsoYbG1qNJ
X-Google-Smtp-Source: AGHT+IH2RH2HUiPHMzLk35ACiz5SeB6Uib1iKjXQGa54thdOMDLFrThNUfglBoU0p2O84vxcD04wlg==
X-Received: by 2002:a17:902:f70d:b0:212:35f5:b564 with SMTP id d9443c01a7336-2129fe2669emr56816865ad.7.1732294040271;
        Fri, 22 Nov 2024 08:47:20 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba357bsm18336365ad.88.2024.11.22.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:47:19 -0800 (PST)
Date: Fri, 22 Nov 2024 22:17:14 +0530
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
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241122164714.aj4dzv32zixdj7pq@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
 <AS8PR04MB867625A97A43FE5352FC0E768C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867625A97A43FE5352FC0E768C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 03:00:44AM +0000, Hongxing Zhu wrote:

[...]

> > > -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie) -{
> > > -	struct device *dev = imx_pcie->pci->dev;
> > > -
> > > -	/* Some variants have a turnoff reset in DT */
> > > -	if (imx_pcie->turnoff_reset) {
> > > -		reset_control_assert(imx_pcie->turnoff_reset);
> > > -		reset_control_deassert(imx_pcie->turnoff_reset);
> > 
> > Where these are handled in imx_pcie_pme_turn_off()? If you removed them
> > intentionally for a reason, it should be mentioned in commit message.
> > 
> How about add the following descriptions into commit message?
> SRC interface is used to do the PME_TURN_OFF operations before. It's not very

What is SRC?

>  suitable. Now DWC common driver can do the PME_TURN_OFF kick off. Switch to
>  this common methods, and remove the useless turnoff_reset manipulate codes.
> 

Hmm, so 'turnoff_reset' is used to send PME_Turn_Off msg?

If so, then you need to say in such a way that the reader should understand
'turnoff_reset' was used to send PME_Turn_Off and since the DWC implementation
is used, it is not needed now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

