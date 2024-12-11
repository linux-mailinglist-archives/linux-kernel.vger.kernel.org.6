Return-Path: <linux-kernel+bounces-440808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AFC9EC48C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE512842FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A991C330D;
	Wed, 11 Dec 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xipfkh1P"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EE86338
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896817; cv=none; b=gxob2rR2rijrC3IGeCubTu/omxlxh8Mrp0BGG+YRQwY/+VkOnblihAQ5sQ98xrFv0QKNefdwbw/LsL9nunDtTUsiPquBBVHQRiezuPOcTlIYcKOTGS5jgSlLQgUA1axNA/a7403+p6ZwkhBSi57Wb2+auEH0U5KejZCU4r0Sy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896817; c=relaxed/simple;
	bh=O/HUgr1J4WfobxzE8q+ngELR/opzNqY/jg3OvkCE2s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCeljTdDIhpBsqx1iNcRVYly6OMAo7wDCbl/xoMetnik7DVyZbbdJTkFZPYu2ewxHoonXjd5KCBiYrrVKNcxSYOpFetLxuG3HCwdyqaBzuvqXZH5rmChFK8W3S0qVvlYBYem88/VcKAV8C4B3uUZ9I4cr+Smx8sXAOTJArlrJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xipfkh1P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2600151b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733896813; x=1734501613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6D+5UJWf2Pb6ZMQTYtdZG9lwxLVemgiQeSinsEy4PM=;
        b=Xipfkh1PvJuKvPJZA7QDTVaH9AbL+BKKgPGprps+M/GhJuYzBDbulJXXzCdi2MfGAw
         2QP5+r9UJ9YFXPrMs/qaLI8pumzLBFksbTdfYGxePxMDZzaPx7WvTpRXDPn2dVxBNVLZ
         fQqKlhOrMHW3awuIyJ2lmVEFILvo/FrxlR6Zi2iZF+5CGA0SOVjlg89FHcQETRyMgvrx
         gpIlldISzDi0I3f96jFAd66i/W6ozkMBgNW5gEvmCqn1ERQ4D3iyp56ZJv7ISLre7DQB
         K1TZxAfJtShua6RfpDKhNj/uv5KK2u9UXVcg5lj4jMQMZnPJA40Mkk2WL0HYgm/gReUH
         RgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733896813; x=1734501613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6D+5UJWf2Pb6ZMQTYtdZG9lwxLVemgiQeSinsEy4PM=;
        b=BbhVfoQlaUurYHSsEsug/txsWrnpAynT1Acg+XtWq9+lUEIU706UARUWhsqlRCXOai
         qo3QRr4SsBpsazRDxAEG1tvNz/tzvXja3mrv1nbw5rLF2X48ljrtoI8CzxauropE/N12
         aL4iWZXgq86dZu1ANYF79szuy+4neEY/dpWNwbyvV/LYgHrYC0ZLtCMEO/8GopN432Za
         MOjS/HrjH2WJ5stSkgjk6ELIp/7tx/5YZf+IIdZ5ptNmYNLV6mvcPo71lUloGpeUe0ir
         ptqFXD2QjIxTgeKKac6Gr7lll0Ze7YMlP9hCgaD/ww1miSLmOrBtFb0+6roC2nktZDKV
         qD1g==
X-Forwarded-Encrypted: i=1; AJvYcCVd0NWjYSuefy9JQUZ0CP2pNTTDN5uaprcZ/Mq4HLdxy0uTz5gD9aZWRWPqsjAPhJPDtuZ4fZJFYwBV2DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0sqjkLtAzlAFGYhmefLHk/gmmGmv4YQMfwyrEMke/SF6fjzt
	eEXkYDPDKMRqb7Z2F9r9J5jhijeBLWfoXEsQ+ARltbJzibc6vcIwbAnzEgTIIg==
X-Gm-Gg: ASbGnct0L/f79Nr0Rhj6Oiq4+6OCIBmDrC1qL5CZrGcLCl1GpOW4+GT/G+pyBhHtotN
	aHRdBtH3gI5Fp+90iWDfnxgOUaxCLmz2PdQ06kf8dFF7rn5e/Z5i4Awn+4c/7QNPXdZhZcFbWZh
	fjlse8x8CKoILX7m0+svHnyBfXIdjSXS5glqMHk/0tNF4l5oaV6aDot1Ojw8Zzor2PiDDzMVSTD
	k1RuYbd1VOoBI6xr3eqErAtLogPHJXQr2sWuoJKnxAvv0GT0nEk/8STjA5NWsg=
X-Google-Smtp-Source: AGHT+IETlOHgTkLxhqU/G3R9N0fR+q6nWJP5t1CaevYyD+oehCnYRHb6VBsIy/3q5g8vtc8rjNY1ow==
X-Received: by 2002:a05:6a20:d50c:b0:1e0:d5f3:f3ed with SMTP id adf61e73a8af0-1e1c129622amr3306101637.19.1733896813626;
        Tue, 10 Dec 2024 22:00:13 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e6e024e4sm5434850b3a.153.2024.12.10.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:00:13 -0800 (PST)
Date: Wed, 11 Dec 2024 11:30:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20241211060000.3vn3iumouggjcbva@thinkpad>
References: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <20241204212559.GA3007963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204212559.GA3007963@bhelgaas>

On Wed, Dec 04, 2024 at 03:25:59PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> > Add binding describing the Qualcomm PCIe switch, QPS615,
> > which provides Ethernet MAC integrated to the 3rd downstream port
> > and two downstream PCIe ports.
> 
> > +$defs:
> > +  qps615-node:
> > +    type: object
> > +
> > +    properties:
> > +      qcom,l0s-entry-delay-ns:
> > +        description: Aspm l0s entry delay.
> > +
> > +      qcom,l1-entry-delay-ns:
> > +        description: Aspm l1 entry delay.
> 
> To match spec usage:
> s/Aspm/ASPM/
> s/l0s/L0s/
> s/l1/L1/
> 
> Other than the fact that qps615 needs the driver to configure these,
> there's nothing qcom-specific here, so I suggest the names should omit
> "qcom" and include "aspm".
> 

In that case, these properties should be documented in dt-schema:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

- Mani

-- 
மணிவண்ணன் சதாசிவம்

