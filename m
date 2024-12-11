Return-Path: <linux-kernel+bounces-441238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA069ECB91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498F0188796F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B71DA634;
	Wed, 11 Dec 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwpSSNgf"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADB238E27
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917853; cv=none; b=XfKMbBFitm+vicKxGoP1AZcKaIGVBkVadmr710kSJ+NImVHSK+fvN7VGKiq6g18h1tgxiO4NfLvnppB2jgVIzC1f4snlpLu8bAzy/WyITp4IOcAR+EFt7+kCPJR4hT/Dlv4TYE2QMM6jpCWAEyKhhQbduPhhcq64L/XLq6HXndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917853; c=relaxed/simple;
	bh=lJJE7PelyxsqF5tjm3FPJmE6ni3GV2a73JcuICAnivQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR+kYZw7d9HJAM0dQwMWpnqKGO8oKCdULqvvwDiejFATPfdNMREY/EzWUca08PqV7pGw0Wby4GZzxusuP2VrBSmUrPJTZ0UplehwGVweXU4p91kR5sHFYJptCApF20znyUzi06WR45WKfv0v2mW5yxKBRW270/g3o2a/W+dwt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwpSSNgf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21675fd60feso21589665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733917851; x=1734522651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhcCxygbhPLWVCPLSEOC9aoZpP2GOwRDWDssDWGzilI=;
        b=OwpSSNgfao5/uYzEVaf1OX4o52cdf8CHN4+v8Wqy9h4k3o/fSogFEVj3xaZM4BO5GY
         XrZViiE2uxWnRUqHNezpOYFI2z3Ig9YLKld+FUhja+GRzNymU+iO/BlD06n7R3WnuyGg
         fgz961fxbyW+Dy3P8hXtSrCs2r9XKurEgocjwABY5k76pz/aZzQvNVNnLqrGqs8S4xCq
         v++RsWklMF6kerR6Jn8lBB8hNS2sJjtE2GifpW42dCGOLBsPSijKz+BlfZglNke2B/rS
         Y4RmJ/GSOWHbSszdu6j0kZtixaCVIdm+RvgTtlKwfCx2icC6JlnyGOytjLOAvOMdF9MD
         Qsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733917851; x=1734522651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhcCxygbhPLWVCPLSEOC9aoZpP2GOwRDWDssDWGzilI=;
        b=n+mVC2q1G0iaJp9rehcfO229o/EX+dLtM2hrzpcNrz+QEFLgvig8EaG4/wDYRJTPSq
         y2944BESHGQI62YhCr58S5y3yAkkDdQxuU8Sim1BSn5DhITD/Vkw2+3Jb5OmwPEicvSs
         C/QT6xX3mXZMq2dt12Yj9Z599B9ldVHjG3hUpEBHU8TlJ9+o6BqRJ/qd5wA55VA6Q38/
         eOw8xsNX7GUGx5tAE0LzeWrSxUkFfVfsvnivhPfA+Ozz6gXDGznKZoKqy8q+f/5Is1oP
         aArfyY2/XVnHglzMR/jk0uYQsICtSzyFWyb+nH8WBXSzWbmzmLt6iO0bt4KM9fcxAgyX
         ukig==
X-Forwarded-Encrypted: i=1; AJvYcCU5XWFeARicYYhbC7SHgaTVUTyTh08tNEuuFFNTsGJ9VVEAs+ofSxJQ2qX7/OZ4XZr3HVH53AVQ60sU8/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteOk+k/9oZL7PBpaC2ZHfGeQiIlJmfu3iQ+sZgfK8UI7r9aS5
	YmdDwqloJFULTP17lqaoyenlRoBt3oelxttg6tGWRKr1CbMi748uTht38OIO9A==
X-Gm-Gg: ASbGncv2+hucUxLIt6bwxxru1zPTxMv6o6FVS7Ii4qQ5QugrKdRnNmP50+6DjhZBqBw
	vRU9XZXQHynE2IC27R6KYBQKYiQ8b1R3HoK/2UYMWCsYnPxVm9qi1JGxI2nPmh29gjn3lsCZyvG
	tz2Nf6tASVFjVtJJlIMwRIwBuozBFGc7aFTan/p8huHFGUTEjvxOWlXuEyj+DZgQwVFKM/lWV/w
	8/tUL5lR2bdyGWGQFolVnWLmbhs4jXU34eDbb1WAYE1RKU+PHEy9jBvVXKaRqM=
X-Google-Smtp-Source: AGHT+IEVbl+wAIa5JZrSvowjO/cDdfR9fBf3jYVsXQMOChSoFGmYHwPGwinFUNul81v+vwc84aIqVg==
X-Received: by 2002:a17:902:ea10:b0:216:2e5e:96ff with SMTP id d9443c01a7336-217782d9da1mr47074955ad.0.1733917851326;
        Wed, 11 Dec 2024 03:50:51 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216356f24d8sm64927805ad.242.2024.12.11.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:50:50 -0800 (PST)
Date: Wed, 11 Dec 2024 17:20:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, dmitry.baryshkov@linaro.org,
	abel.vesa@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp-pcie: add optional
 current load properties
Message-ID: <20241211115034.4hrpmninbx5uryev@thinkpad>
References: <20241204105249.3544114-1-quic_ziyuzhan@quicinc.com>
 <20241204105249.3544114-2-quic_ziyuzhan@quicinc.com>
 <qvjtwilukxbeaxnbyzfkdsfkktm6p4yv3sgx3rbugpb6qkcbjy@rohvixslizhh>
 <20241211062053.vxdpovlmetvyx3za@thinkpad>
 <33697bd9-02f4-4a9a-b8c0-4930d7fdaee2@kernel.org>
 <20241211082404.p7fbmhooikmipxvm@thinkpad>
 <3c7ddb08-38db-44b3-a7a7-ec7b270a408f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c7ddb08-38db-44b3-a7a7-ec7b270a408f@kernel.org>

On Wed, Dec 11, 2024 at 10:52:11AM +0100, Krzysztof Kozlowski wrote:
> On 11/12/2024 09:24, Manivannan Sadhasivam wrote:
> > On Wed, Dec 11, 2024 at 09:09:18AM +0100, Krzysztof Kozlowski wrote:
> >> On 11/12/2024 07:20, Manivannan Sadhasivam wrote:
> >>> On Thu, Dec 05, 2024 at 11:23:11AM +0100, Krzysztof Kozlowski wrote:
> >>>> On Wed, Dec 04, 2024 at 06:52:47PM +0800, Ziyue Zhang wrote:
> >>>>> On some platforms, the power supply for PCIe PHY is not able to provide
> >>>>> enough current when it works in LPM mode. Hence, PCIe PHY driver needs to
> >>>>> set current load to vote the regulator to HPM mode.
> >>>>>
> >>>>> Document the current load as properties for each power supply PCIe PHY
> >>>>> required, namely vdda-phy-max-microamp, vdda-pll-max-microamp and
> >>>>> vdda-qref-max-microamp, respectively.PCIe PHY driver should parse them to
> >>>>> set appropriate current load during PHY power on.
> >>>>>
> >>>>> This three properties are optional and not mandatory for those platforms
> >>>>> that PCIe PHY can still work with power supply.
> >>>>
> >>>>
> >>>> Uh uh, so the downstream comes finally!
> >>>>
> >>>> No sorry guys, use existing regulator bindings for this.
> >>>>
> >>>
> >>> Maybe they got inspired by upstream UFS bindings?
> >>> Documentation/devicetree/bindings/ufs/ufs-common.yaml:
> >>>
> >>> vcc-max-microamp
> >>> vccq-max-microamp
> >>> vccq2-max-microamp
> >>
> >> And it is already an ABI, so we cannot do anything about it.
> >>
> >>>
> >>> Regulator binding only describes the min/max load for the regulators and not
> >>
> >> No, it exactly describes min/max consumers can use. Let's quote:
> >> "largest current consumers may set"
> >> It is all about consumers.
> >>
> >>> consumers. What if the consumers need to set variable load per platform? Should
> >>
> >> Then each platform uses regulator API or regulator bindings to set it? I
> >> don't see the problem here.
> >>
> >>> they hardcode the load in driver? (even so, the load should not vary for each
> >>> board).
> >>
> >> The load must vary per board, because regulators vary per board. Of
> >> course in practice most designs could be the same, but regulators and
> >> their limits are always properties of the board, not the SoC.
> >>
> > 
> > How the consumer drivers are supposed to know the optimum load?
> > 
> > I don't see how the consumer drivers can set the load without hardcoding the
> > values. And I could see from UFS properties that each board has different
> > values.
> 
> 
> Drivers do not need to know, it's not the driver's responsibility. If

What? I think there is a misunderstanding here. The intention of these proposed
properties is to allow the PHY driver to set the required load of the regulator
using regulator_set_load() API. As per the API description:

'Consumer devices notify their supply regulator of the maximum power they will
require (can be taken from device datasheet in the power consumption tables)
when they change operational status and hence power state'.

IIUC, your concern is that the devicetree shouldn't specify the load for each
consumer but just the min/max load of the regulator. And the consumer driver
should figure out the load and set it accordingly.

Correct me if I'm wrong.

In that case, I was wondering if the load set by the driver is going to vary
between platforms (boards) or not (question to Ziyue Zhang). If it varies
between SoC, then we can hardcode the load in driver based on compatible.

> If
> these are constraints per board, then regulator properties apply and
> there is no difference between this "vdd-max-microamp = 10" and
> "regulator-max-microamp".
> 

There is a difference. Regulator properties are just threshold. So unless the
consumer sets the load, they won't take effect. I think you got confused by the
'max' wording in the proposed properties?

> If this varies runtime, then your property is already not suitable and
> very limited and you should use OPP table.
> 

The consumer driver may request different loads based on their operational
state.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

