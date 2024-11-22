Return-Path: <linux-kernel+bounces-418539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FBB9D62C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0ABB26285
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDF1DE3D6;
	Fri, 22 Nov 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEHbJ5Cn"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C61DDA32
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295452; cv=none; b=tn/Ivf7ip8822B0eGZkOhLzlaDJn0XXuNCsln9UbMCK4OZ8xGkFnlWVxbvIV19xFwxICNdH15JZKP/xvHJdCGAVl7YpmisEemKzY2KFBStOZUMqhovJi1n0eaTB0a6MFe4XuvcKanZPE+7jm2HCwRnrN5SeD5AhA2l1OJDaOctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295452; c=relaxed/simple;
	bh=JSfJBNYEbA8FDDOxY/qXqSPsOBH8pc0lxdl5eHk3OHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtxO1Yq7xw8Ja+ztjIpqlKWCwp9XkWQHtK1XSyiW23N76ujud1lbn4y30549iKvrUga3vx2CqoYn43k2Znnq782wEMi3BF9r5Z2oPCL7+KswTfPuuiUbTFTIeK8fHU6QqFndCa570fEVervzsEdgT5DmPs4CYL92lqcgkox7fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEHbJ5Cn; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8de14848so2057747a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295450; x=1732900250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9Rzu/atJszaZiZQ8bphSysVEtM05e/rUjckRGXXQa8=;
        b=eEHbJ5Cnr2LP8QZElbeawTkXgevrD8ABRlNJvZt1JkG9R+miEgmgPO82jiaFVKeau0
         sYR9Qa3JIM8DlJuMwGsHosxuRynXh4QW0N4EmYr3ygqHL9zyXOp7JewevuBEPBhbpu2O
         aYA9Ozni6L4o7LO8v6+UmOCogpUHNooCv5dRIG2YhOHIfkiyxG/VdL/Is7eNt7ePUccd
         6c/2mxkv9oIeMW5N1VKoWnU0yxuIz/TnhuvOW/wUycHtIbCp+d0RyCcTgGBEb2OIGHZK
         iMgJDM2WAF7Br9pBVBawATHk1B6eKy+KXtCkqpfURGwyNtZi2beo9VNsFDSo+Y7nav0m
         Skzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295450; x=1732900250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9Rzu/atJszaZiZQ8bphSysVEtM05e/rUjckRGXXQa8=;
        b=xVAXE8saWrS31Kdgn0dG3EjiGR2lnTxBp2R5vEWeENZwmp3VDoFC6FQafgWKYureJN
         zfOzlfr0uHfT/z0ebYwuWexi35HV67Fm7QW4yBUkdMYpcwY+X6ByTFTT7RmcLLxHVaDw
         PsOoEfTe/+nse2qQ2+sU4DE7qDMd1Fu5dQ5aQhAKVdNzO1P0eq+kfpJz2fGbdqOMumDY
         gooOqbBL0TzUcxe4lz7F9l5tHlsA3Ao6jjZU7s5zH+6oLDVTg9dqVjmJLpVmaBg0hYZY
         2R+uoaBf7LIu3kue2RUruJyhjkOL5jNDk4hWNq3g2iZOofhPJ5J7qiWrFiTUEbZBwQUF
         yWJg==
X-Forwarded-Encrypted: i=1; AJvYcCVWMe4xnVExinvIaS/rpL+imDrpfBFp+aFjIVTpbcOM1cphvvphmLdWeMvqarAALn3z5buYzzoqlg5Suw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxC4a4FGOWZTIohUaLD9pXTAjD8WKdOIBJUJ8ZYxEd64L7Xs0
	HHWTA0yy6isIMtwaewT6qv5XBX52HEZxl2RKrbIQ3r5/GH1t8asfm4Ccv3hc/w==
X-Gm-Gg: ASbGncv2zsY3pJCJd3ILBQZ+M53GWjUoA64H6EmSiYGdke70Hyhdy5xEkxPMm/eo7p5
	dtteHGQ6eTsNCtBoWh5WEGxY4PxFcN+qVAsiUmEvQUN6/9p1xlzjn/UU6gXISnQd0ftb4iqLcbX
	gXGnQ1Wfpch1tlKvuc27mRzHMUfUgwqo7KO3NUsvs4SDW98+txlBgMHHWNBOjCF86RmS5UcN0SK
	sdPZKpFPQc+tinWH5kA6l40NfeuYA96aZUpTwYCvRL4HahoZMM7uaLLz1yz
X-Google-Smtp-Source: AGHT+IFIhc1R40hXLVSot1qpNb47cXTxZcrRwISXx0lJGKYTEDxVxH0DwKBYDolmma7+CJxTTAgLkQ==
X-Received: by 2002:a05:6a20:d503:b0:1c6:fb66:cfe with SMTP id adf61e73a8af0-1e09e45ff0emr4838841637.21.1732295449974;
        Fri, 22 Nov 2024 09:10:49 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de57a562sm1847026b3a.195.2024.11.22.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:10:49 -0800 (PST)
Date: Fri, 22 Nov 2024 22:40:43 +0530
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
Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Message-ID: <20241122171043.j2xh4fvdo6goq7o2@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-5-hongxing.zhu@nxp.com>
 <20241115064321.3cuqng7bzmphiomw@thinkpad>
 <AS8PR04MB8676989276C723C26DADFB5D8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676989276C723C26DADFB5D8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Mon, Nov 18, 2024 at 02:59:48AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月15日 14:43
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > shawnguo@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; festevam@gmail.com; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
> > logic for i.MX7D
> > 
> > On Fri, Nov 01, 2024 at 03:06:04PM +0800, Richard Zhu wrote:
> > > i.MX7D only has one PCIe controller, so controller_id should always be 0.
> > > The previous code is incorrect although yielding the correct result.
> > > Fix by removing IMX7D from the switch case branch.
> > >
> > 
> > Worth adding a fixes tag?
> > 
> It's originated from commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> 
> How about to add one Fixes tag like this?
> Fixes: commit 2d8ed461dbc9 ("PCI: imx6: Add support for i.MX8MQ")
> 

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

