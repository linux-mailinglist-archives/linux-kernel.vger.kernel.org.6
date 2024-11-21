Return-Path: <linux-kernel+bounces-416630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF29D4804
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE19281BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60C14EC55;
	Thu, 21 Nov 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEHXwG8c"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349B148FE8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732172352; cv=none; b=QD7BkZ+O005bFklUGuuuOdNJ82byXmOUn40a6QwWcbydmbQqHiPs0HzzhMGJRCsH4+CBZH0Q+kv5aKNuAeqmCLeTq0Su821sFGfszC6QqnkCjTT0d/GwcR5fryM2D8XLNkP0EOFI2aoGWv7ix2JJORili8C54/jpn1asJXxDu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732172352; c=relaxed/simple;
	bh=8G7n5bTdv36lFVT7gEmYLdEyyRXW1+/nmqQ9Bf4n9O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWjrGVaBI3atC0WoqnQDmGWPYVtDuJd75cS1dTbIIxd14icuDNXGMWB2HzASjujFKgDzFxRdxyBNZqKz76FXgx4uASPmn13++fMMjOM7uHnrbT1LQcAkG703YvaYgThxG8wqfs9rAGVtb//NKPSn3wQqpT7aypnBDGeq0JX6Rzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEHXwG8c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2128383b86eso5121515ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732172350; x=1732777150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CX+T3EFfpXGMGIEPeCbVEAvdRt7ONV0jadH9gWqGSx4=;
        b=wEHXwG8c0dYFuwx34sVsXhYSmMct24k5y1BAe37p18DZ7y3mbDCo2A327xTGaFoxzz
         oKDsYBIZU4+F5jbzNRlE8zKkvp/TwtZdaiPPPKT8K75r9L+mOZQo0PWNmwP5S4AsCWG2
         IVNw8sbXNhc106KT3IHy6Fn53tLHrHn6xhzeAeLLNThcybjiTlTi0v9OJcmUsN9k8Ztr
         VcPkcCjmNqrk1biW7/EeCgg8uRkcy14UjbvRlYw2sgIn6U9f2abssVzXugYs4FCyhC0a
         VvksWl62BOHeWRga3VueMWoFGvrit75My83Q4BaDXaYcHl2+Ig5LJP9WjWW4th0RoaK8
         IIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732172350; x=1732777150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX+T3EFfpXGMGIEPeCbVEAvdRt7ONV0jadH9gWqGSx4=;
        b=VbZrT44h+475gEdJ6w3v5hdsWsJLMowCSiywtalf5rB/R4rXm6ba1cSbb3vInezZ5Z
         +f097lqepxugBXzPSQg0ebcUrd/QLEhXyts5RUUuQ9YH1CjnCGecXGAIQ/1eNGTmfYVr
         jYKwfoqAUDKWSUtO+DAHvvNBTMQ9PsxXt9t0iJL9jmehtPHqPUFmr5n4Hq7B5IXNUnrt
         eHi55nRJ9zdt18bM+PXAt/mNXxLI3yu4xR7/BeVP35+xc2xTIIRaEWHHU0CYHRLUe0Ou
         YEts5zHWQuH/NX+mdFBu9fL2DCkLGsilRnKtCRYMlMkkH8GmkXB9bCoROs8R2MpFh3Cn
         3k4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjnVUAm5YHJ1p6z/AMSarWTl1V6gVyov8QIaxKhLs68/q+1frEjDQ+5XLaieWV6KnKlI9Pf5Zz0yx5BY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9877BpxddqML4LC4OsiGo/3ChLaVKonSE6NhsKBRnGWE2PBVd
	FRV9CCao/Z/42jP2rKG2b5LYnZnEOdsIv5rj/vDo5NhMj/x0IZf0epPU1SkGPQ==
X-Gm-Gg: ASbGncv+rRgvAZbu2fH8qKEDgo4y0qBEHaEPlQnlBj9NAnzDNgXJ4ANU370sbQGutyV
	69tpczbL3CtaemR00TI4Zpsm4WE+vfcNx9ZyoFOOL0W0RHf9DtmxggbeBTc7Mt8uGXeJAEOhRNE
	mt7Hc7XMomgKNLOUGefQ6NEf8/QDpiF8mIJqED4FzqrUu/QPN1yvSoSo1Vl2lNkdQ9LF0ySWTNz
	/xn15frz7bt4/eFd8WqWf4/aZZjDlNAUc+nWup4AeFqDNeB/wF2PvOyB9M=
X-Google-Smtp-Source: AGHT+IF6xy4JqlxIY2wzKiDE0KR7Op32gWUTCohn9wmiX+ShLE+Z+iDAd3EWXRpCGZhAm6QQ0kCfsA==
X-Received: by 2002:a17:902:fc86:b0:212:88cc:d57b with SMTP id d9443c01a7336-21288ccd685mr16176325ad.11.1732172350039;
        Wed, 20 Nov 2024 22:59:10 -0800 (PST)
Received: from thinkpad ([120.60.72.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212878a7659sm6583555ad.87.2024.11.20.22.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:59:09 -0800 (PST)
Date: Thu, 21 Nov 2024 12:29:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
	quic_nainmeht@quicinc.com, quic_laksd@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH 1/2] mtd: rawnand: qcom: Pass 18 bit offset from QPIC
 base address to BAM
Message-ID: <20241121065902.5w7rpjjgjqgfxpqo@thinkpad>
References: <20241119092058.480363-1-quic_mdalam@quicinc.com>
 <20241119092058.480363-2-quic_mdalam@quicinc.com>
 <20241120070115.qox54zr3yhnkqgmd@thinkpad>
 <e76e9562-f7d0-88c9-dcb6-dfcf41cdf205@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e76e9562-f7d0-88c9-dcb6-dfcf41cdf205@quicinc.com>

On Thu, Nov 21, 2024 at 11:33:13AM +0530, Md Sadre Alam wrote:
> 
> 
> On 11/20/2024 12:31 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 19, 2024 at 02:50:57PM +0530, Md Sadre Alam wrote:
> > > Currently we are configuring lower 24 bits of address in descriptor
> > > whereas QPIC design expects 18 bit register offset from QPIC base
> > 
> > You mean 'QPIC IP' here? But is it QPIC or NANDc? I guess the later.
> It's QPIC IP only.

Hmm, so what is the difference between QPIC and NANDc?

> > 
> > > address to be configured in cmd descriptors. This is leading to a
> > > different address actually being used in HW, leading to wrong value
> > > read.
> > > 
> > 
> > This doesn't clearly say what the actual issue is. IIUC, the issue is that the
> > NANDc base address is different from the QPIC base address. But the driver
> > doesn't take it into account and just used the QPIC base as the NANDc base. This
> > used to work as the NANDc IP only considers the lower 18 bits of the address
> > passed by the driver to derive the register offset. Since the base address of
> > QPIC used to contain all 0 for lower 18 bits (like 0x07980000), the driver ended
> > up passing the actual register offset in it and NANDc worked properly. But on
> > newer SoCs like SDX75, the QPIC base address doesn't contain all 0 for lower 18
> > bits (like 0x01C98000). So NANDc sees wrong offset as per the current logic.
> Yes correct. If QPIC address = 0x07980000 and QPIC_EBI2NAND address = 0x079b0000
> the the diff is 0x30000, this is the actual offset expected by QPIC RTL code.
> and RTL needs only 18-bit offset.

Okay. So the driver used to pass 0x30000 + offset in older targets and on newer
ones starting from SDX75, 0x30000 is not passed correctly due to the changed
QPIC base address.

Please mention it clearly in description.

- Mani

> > 
> > > Older targets also used same configuration (lower 24 bits) like sdxpinn,
> > 
> > Please use actual product names and not internal names. I believe you are
> > referring to SDX55/SDX65 here.
> Ok , will change in next revision.
> > 
> > > ipq etc. but issue is masked in older targets due to lower 18 bits of QPIC
> > > base address being zero leading to expected address generation.
> > > 
> > > Sdxpinn     : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
> > > Sdxnightjar : QPIC_QPIC | 0x07980000 (Lower 18 bits are zero) Same for
> > > older targets.
> > 
> > Same here.
> Ok
> > 
> > > 
> > > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> > 
> > Please add relevant Fixes tag.
> Ok
> > 
> > > ---
> > >   drivers/mtd/nand/raw/qcom_nandc.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > index b8cff9240b28..34ee8555fb8a 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -207,7 +207,7 @@ nandc_set_reg(chip, reg,			\
> > >   #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
> > >   /* Returns the NAND register physical address */
> > > -#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
> > > +#define nandc_reg_phys(chip, offset)  ((nandc)->props->offset_from_qpic + (offset))
> > >   /* Returns the dma address for reg read buffer */
> > >   #define reg_buf_dma_addr(chip, vaddr) \
> > > @@ -561,6 +561,7 @@ struct qcom_nandc_props {
> > >   	bool is_qpic;
> > >   	bool qpic_v2;
> > >   	bool use_codeword_fixup;
> > > +	u32 offset_from_qpic;
> > 
> > nandc_offset?
> Ok
> > 
> > >   };
> > >   /* Frees the BAM transaction memory */
> > > @@ -3477,6 +3478,7 @@ static const struct qcom_nandc_props ipq806x_nandc_props = {
> > >   	.is_bam = false,
> > >   	.use_codeword_fixup = true,
> > >   	.dev_cmd_reg_start = 0x0,
> > > +	.offset_from_qpic = 0x30000,
> > 
> > How 0x30000 is supposed to work? You said the NANDc ignores lower 18 bits, but
> > this has 17th and 18th bits set.
> Not this address 0x30000, this the diff b/w QPIC base and EBI2NAND base. The 18-bits we have see
> on this address 0x07980000 and this address 0x01C98000.
> > 
> > - Mani
> > 

-- 
மணிவண்ணன் சதாசிவம்

