Return-Path: <linux-kernel+bounces-338206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72F9854CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB5C1C20FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFB158540;
	Wed, 25 Sep 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbqV20Nu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49199158552
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251146; cv=none; b=pfkoYswQ26wGFfNuIJupupLSbQb/7dg5rWNzEkZiCaBvbpn2eyZSwbeDy6rVSMU8dZ100/YcqQP3XGBjRvRPxWR5nE579ZM5XR8l4Ig3mJXP0YC3k+dUo7Wl43jk/92n/Zd1wkW6I7fTMXTD7/zDWX5uyZZX3GPS/2sASPkBRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251146; c=relaxed/simple;
	bh=Hc+LCHMm4RDQ9GTVn7gf8E/cTxLuUSUoH4rgKkOqOT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXY/f5cptIdzgO40Xej6LS1Qz3ZuQ1YRd6zmjGKA9+l1XyposFoO7IHBVfHNtLQKtUGbxkepxryQCgE8f4dLwU1dKYEAd5AM7Dg97G1LI3uv1mW9j68L5wM6y182Ddi0jq4HqK1fJrxJWBQlk0sXI3MMwlsUxDelpSyhyI4qyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbqV20Nu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso63677515e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251141; x=1727855941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bapYHrGCRxq+5Z8fPQWisdRvflJnfm7FCmo91yCvTzg=;
        b=bbqV20Nu4WOcVFoCgpRpACsANHDTTYiD4uCkkknliQaNFvKMuajE+2rrUs7qGaa7Le
         LPCn/VPkRXg2ywwEsby6gWnq27hXh8I+8FLFIJ29X3bgc9vmOd2+lX9VZM3cRDv4avhp
         IO5e50GbLxAO3ZCIsmTGO/zQFDn1x7LbQjBDeAIMpD0Vxm7Wr7OJ09WMybfxeOsrg8nZ
         zQ5iHUpcRGTV7Z2ouCtV6A7ynVnoBYh35ftbOAXy44EbhWDzP4LL4356iRWLq+ARX9jI
         fQaDvwr6HvR2r/kyWADPVr8fS8fWO7OLH2Yk7PBqoBvkmLQUFu/MowTWXID+rLu4K6/r
         GBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251141; x=1727855941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bapYHrGCRxq+5Z8fPQWisdRvflJnfm7FCmo91yCvTzg=;
        b=PGnYHpZWUwig9Z/OjlXDQ73T1ogEVv0beUMn464ZZ+aFErkMJ4oFeVda7ppJ6Q6tma
         laXBQrRg42wNXxysHaq0/aeS9XikBKQ6uIUViLa3z3+kLBavTMnFVTO4tyCTIhyfvJFe
         5uJJE311phet2EktgFyYCKg3PUiD7ygbz2CcYEJQHktJy2VaUKRTUyD1FUljaKQRdvgk
         mPYZlF/Ts30Ck0LyIYNLthPLcrnALYzbtsVSKgcY2CCUqExkRw9u7QL6qhnWb0YXdZoo
         XJwD5JBvB8xQ4Ju9Rp3JOTurxWJOuV3k37jwZZfKflh7/Z5uXYGEnCRk6XCFX40jHmq6
         7QFw==
X-Forwarded-Encrypted: i=1; AJvYcCXqOcv8d/4lwVko1FxyVnNWRSa8yK/ZaRsqZAG+cX7DWsf0yrYo/5panzBY8JWvmdoRBR8m1uKkmV/my7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlR/GrInAix5537Pdk0dZCrVf7dnv7YV5ycrOq1+cmrEglG0gB
	a7ko8T2+PLOBdhNeLFQaz5UpRu7azWIxLXkZxW4/0bgXFQzAlhU2LXy4TovwdA==
X-Google-Smtp-Source: AGHT+IG3djtkgvDwFjL5SMyfW3qLoXY0CLRwpTQ//e0lJY1MODc0J/w7hgvsNBnFokru+vE1owYtFw==
X-Received: by 2002:adf:f886:0:b0:371:8cc3:3995 with SMTP id ffacd0b85a97d-37cc24847f5mr1254992f8f.34.1727251141533;
        Wed, 25 Sep 2024 00:59:01 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f77esm3313206f8f.108.2024.09.25.00.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:59:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:58:59 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <20240925075859.4vbb4faaworc6eyz@thinkpad>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <ZvLQFSjwR-TvHbm_@hovoldconsulting.com>
 <ee32742d-9daf-4bff-948b-cf2e705bc73f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee32742d-9daf-4bff-948b-cf2e705bc73f@quicinc.com>

On Wed, Sep 25, 2024 at 02:37:41PM +0800, Qiang Yu wrote:
> 
> On 9/24/2024 10:43 PM, Johan Hovold wrote:
> > On Tue, Sep 24, 2024 at 03:14:44AM -0700, Qiang Yu wrote:
> > > Describe PCIe3 controller and PHY. Also add required system resources like
> > > regulators, clocks, interrupts and registers configuration for PCIe3.
> > > @@ -2907,6 +2907,208 @@ mmss_noc: interconnect@1780000 {
> > >   			#interconnect-cells = <2>;
> > >   		};
> > > +		pcie3: pcie@1bd0000 {
> > > +			device_type = "pci";
> > > +			compatible = "qcom,pcie-x1e80100";
> > > +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "msi0",
> > > +					  "msi1",
> > > +					  "msi2",
> > > +					  "msi3",
> > > +					  "msi4",
> > > +					  "msi5",
> > > +					  "msi6",
> > > +					  "msi7",
> > > +					  "global";
> > This ninth "global" interrupt is not described by the bindings, which
> > would also need to be updated. What is it used for?
> 
> As of now, the global interrupts is mainly used to get link up event so
> that the device driver can enumerate the PCIe endpoint devices without
> user intervention. You can refer to
> https://lore.kernel.org/linux-pci/20240828-pci-qcom-hotplug-v4-11-263a385fbbcb@linaro.org.
> 
> I see this global interrupts has been documented in qcom,pcie-sm8450.yaml.
> Do I need to move it to qcom,pcie-common.yaml?
> 

No, you need to describe it in qcom,pcie-x1e80100.yaml.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

