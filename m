Return-Path: <linux-kernel+bounces-440955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D49EC70B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE900169552
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7A1D88D0;
	Wed, 11 Dec 2024 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcH1X+X6"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7A1D8A0B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905458; cv=none; b=lQR9DEwEB8UWgHlcHaU+QIC7sjlFmlOCyQBy8zLjyM1yke8TKFbWPISfkp2bKyUT0Q5RIl80OIzBuQffbOSRxgat7EwLemOsnHHhpQ0E1XGJSfZrCkpTw9ToLw5XPjDbajJ/es9wPh69qXDPGTjeRSmnofIlCfZmfdoueTtzGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905458; c=relaxed/simple;
	bh=hU8ic9mPL/Bg2bJjsyKXRHBm1+CN3DAjSXMLP5ZIzUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG6zZE55sprcNc87D/t0ENY9CYDDY8fN1TLRM6h3eKEZpimWnBF4OD9JAoPFnSoN3i+qRn0zb6LsdBSX6EKD1se39atKlLhLcURzx0ATQPqH/EPKzg6JMZudODzotvMJHY8c8zsa5x0KXDTFK3ErrDubS1T0L/xGOK+vE8YLYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EcH1X+X6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ee27e905so3288802b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733905456; x=1734510256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjyvF7kb3Fj9Wqsey0yFF+HNeDsO4egY2+tvcam+GFQ=;
        b=EcH1X+X6Mm91AeYm8uXTKZLhLNaM5nr3nDuPPmfvEPsktM/tZwXDT+aL1aZ3ZCNrRy
         s2FzBpEOWHGQYGvoxR9fn4NY8DYyVIgGiGWyWHlS8eTMfuVv9pkqVfGv7MdjYfYw3ZlN
         G/8mkN2bAKtSby3HzY2Uh1v1FxVXxov3u1ryUaXlKsMeLpATOlzSpEGxJNsOz1n42toI
         My3eF2H0SrXmQVHEAlrrvtx/qX4XWo/DNBG3zD5NkYM1Vv7XlGJFGesteG868OX7MBEC
         8qumcdcoJ7GhMafyIMJMtP90b5qkO4aGr9u5gbCx9Zv3R0l1nszozWSFPrkOEjqevVvL
         EVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905456; x=1734510256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjyvF7kb3Fj9Wqsey0yFF+HNeDsO4egY2+tvcam+GFQ=;
        b=QFCJh8wNf6ekfrrILLk7FoRLeky2efXeey7mkWBCSP2/MmjcqQzFFqzm9azLTFuGwQ
         eJXVl93PKSPwsGf91WzkY56b1kIsy7UypEkwN/0oUPY8tFwZ9LxxgVgiCWPz4ZMgzcuP
         Lg8TjAEHS47Zsi654XdtFD9c0qlk6JM5YjY1CAtN8A4kIS8/5YhTYN6UABjxxsy+xnHu
         Bg7TdeyTgZH8kdJq9JVJtRsT6rDz1hAqLookaBSiWcGStnB/kIrC+CfhfO4Qa32d9H+8
         xknwFWEtNuYxxLVYt9QC1Csyzl8b8P1tO6q/EKV9LV5J4Ip5OCxDUrMW7aWGf/BFqh1K
         4G/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXVscLyf1a2yqwKuWM4+iKVa56WhDiET3kR6loOYFMUS7BBM0KKtK7Q5X8CKizrUkCchBNZ+Wzu4E/n0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFdevpaoCWK6RwIRsnACEeaigkoI1R0EMsxFzLWcFk91Q5puI
	RUAjKqPfxm3RE/hCLe/PVMiz1rbB22LYzwkiPmytST4A09Ja2Skr2Daw2+8EUw==
X-Gm-Gg: ASbGnct+6JBk3xFmJlHaC7kSR3z0qzR86PXOiY1Ipk4WJWdql2kRzspDd1qby8cX7jG
	68c0tzXihDWT6a8eWz1aZZVwN2CeG00B4fkJLctJTfn06qCpcQcP40D0XKQDjosxytGL+irfood
	yjZS9dHJk1ykamWPyTHXAd/6iV1DqRv+gaHgZo0zb2n8u5vYFcO5Brv/XEkSAEGtMBzfKZJTRpf
	QQppjnRDYE/XzfG0l07aaAuAg48lQ38TE7Gk5zt/wFJBoiG7g9CAf0Fau/NkdA=
X-Google-Smtp-Source: AGHT+IHAA8av2ZjtMDzhDwJWK9BDEonm49fwB5KzeIRHQyFoeoJaUDA8Pre4/aT4K/XkNchmbfmmOQ==
X-Received: by 2002:a05:6a20:72a4:b0:1e1:9f57:eac1 with SMTP id adf61e73a8af0-1e1c126f5d5mr4443839637.8.1733905456230;
        Wed, 11 Dec 2024 00:24:16 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd2f40dc81sm6568577a12.64.2024.12.11.00.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:24:15 -0800 (PST)
Date: Wed, 11 Dec 2024 13:54:04 +0530
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
Message-ID: <20241211082404.p7fbmhooikmipxvm@thinkpad>
References: <20241204105249.3544114-1-quic_ziyuzhan@quicinc.com>
 <20241204105249.3544114-2-quic_ziyuzhan@quicinc.com>
 <qvjtwilukxbeaxnbyzfkdsfkktm6p4yv3sgx3rbugpb6qkcbjy@rohvixslizhh>
 <20241211062053.vxdpovlmetvyx3za@thinkpad>
 <33697bd9-02f4-4a9a-b8c0-4930d7fdaee2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33697bd9-02f4-4a9a-b8c0-4930d7fdaee2@kernel.org>

On Wed, Dec 11, 2024 at 09:09:18AM +0100, Krzysztof Kozlowski wrote:
> On 11/12/2024 07:20, Manivannan Sadhasivam wrote:
> > On Thu, Dec 05, 2024 at 11:23:11AM +0100, Krzysztof Kozlowski wrote:
> >> On Wed, Dec 04, 2024 at 06:52:47PM +0800, Ziyue Zhang wrote:
> >>> On some platforms, the power supply for PCIe PHY is not able to provide
> >>> enough current when it works in LPM mode. Hence, PCIe PHY driver needs to
> >>> set current load to vote the regulator to HPM mode.
> >>>
> >>> Document the current load as properties for each power supply PCIe PHY
> >>> required, namely vdda-phy-max-microamp, vdda-pll-max-microamp and
> >>> vdda-qref-max-microamp, respectively.PCIe PHY driver should parse them to
> >>> set appropriate current load during PHY power on.
> >>>
> >>> This three properties are optional and not mandatory for those platforms
> >>> that PCIe PHY can still work with power supply.
> >>
> >>
> >> Uh uh, so the downstream comes finally!
> >>
> >> No sorry guys, use existing regulator bindings for this.
> >>
> > 
> > Maybe they got inspired by upstream UFS bindings?
> > Documentation/devicetree/bindings/ufs/ufs-common.yaml:
> > 
> > vcc-max-microamp
> > vccq-max-microamp
> > vccq2-max-microamp
> 
> And it is already an ABI, so we cannot do anything about it.
> 
> > 
> > Regulator binding only describes the min/max load for the regulators and not
> 
> No, it exactly describes min/max consumers can use. Let's quote:
> "largest current consumers may set"
> It is all about consumers.
> 
> > consumers. What if the consumers need to set variable load per platform? Should
> 
> Then each platform uses regulator API or regulator bindings to set it? I
> don't see the problem here.
> 
> > they hardcode the load in driver? (even so, the load should not vary for each
> > board).
> 
> The load must vary per board, because regulators vary per board. Of
> course in practice most designs could be the same, but regulators and
> their limits are always properties of the board, not the SoC.
> 

How the consumer drivers are supposed to know the optimum load?

I don't see how the consumer drivers can set the load without hardcoding the
values. And I could see from UFS properties that each board has different
values.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

