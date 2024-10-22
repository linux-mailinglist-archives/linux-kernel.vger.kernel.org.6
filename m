Return-Path: <linux-kernel+bounces-376449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBA9AB1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CA71F21FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFE1A0AF2;
	Tue, 22 Oct 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbuoS3Xi"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54B1A0BFE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609823; cv=none; b=JsWFL1EJ0nq9ySh67uIBZ8o1NgI+qEodXaAHPhnEdtiGuSUJ29NDI3kl7oOMG3+Fq1iy6So2n4P4uYIqXxZjK1WjqStNdDG9aBAjYuQS2uTyeTklH+xEXt/DfPpjzrVasYt0ObPNitmLX3StdQNUKCUtg/+DD//dw5jEyybOQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609823; c=relaxed/simple;
	bh=qTfIuTVAUUhrlUanxecmlRHah06WtvV7DSWHRs4WfLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAtIm74XNwrN9veaGNOuMtjpYCV1VD5XBU+NaCmNYVJJlsSGQm0Rg7icwhXEeSGav+XUB24IdOjiIT/lcl2C6NmpvzDWNnAPLnXkHtNt1IDogiWsTyp/WayyVblrxPHJVPgSfLfRkAnuf3AK4GFSBSzPlDHPgyUX24plMnULEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbuoS3Xi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so4692904a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729609821; x=1730214621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MzxEKUQWg3uIWQMJ7O52/X0erwQFBgLhhHBq8a3fZ8A=;
        b=AbuoS3XiJ4NxLu40b5armtGFlr3JWXPTwAqxli6KbsyfJqLcMem/kUeMTjGT0zi5Y2
         2/8BFwlASndr7ISHWZbgbSu/ewt8i8VVs7UU28LP4skjVoI9W7i/B9HVMSmJCwZGlDMS
         Qfxq+ucLxOIrnBns4M3cED1nQeEKGSahYWoiACN61jw/xizADSxVASpQhMJOs97Wyn/W
         PAN9by0DUwYuJaN7RZWlbrOJ7wa2D7whjF+/8kuGf5DovOuZ1UpSfxEE3wvC/yO5W11W
         0vKOYzf3jLydF6+2/IyJvZph8UrUU2QS4IzLx3V9HcqbfsZiNqnpdpowsql46izKObA6
         myTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609821; x=1730214621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzxEKUQWg3uIWQMJ7O52/X0erwQFBgLhhHBq8a3fZ8A=;
        b=KZac+Rw+bmsBpji5RaXXwJCtu2//gPsJzztsIm5sKx5IfqY9FKQ0qojMnKNuzBv4sw
         d4EUoWMCTg3JvJrsI7dcs/3CJ2JpzqdGqOi0s62PfaYR7Q86BSIc+VCSYR4GigXgncgO
         n2uXdd+eFEumiViiOxYdqFdJNTHEBF+ufBlw5+6jClchRAkE/YaRz9WjXWA0RzKtzP5f
         5O4y0d4NKsi18M5x55cL+keCTU4Rhvz+/c0nkSnwKhHsoSaCEQcwVBMhnYcNHsRWqzMz
         45+jTVQS471zjy5EIIrqvxLZfPS0ngUjV5iJoxY47vbaTjlwiprPAwoK4gxuGIaFEMcR
         QyIw==
X-Forwarded-Encrypted: i=1; AJvYcCVXnebkwTPTkJSvatiDECBHNfBKNVeLkvwt7Q4PuktOklcYrThr9mMfnoPsbal/eYG9j8ahcyoASoNfw20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tzaljFsgKWVU/a8vbkyJ02Tz3BoM1NHPlWYMQo50zL4kDC5E
	5sdmwDwoXRZ1Ao3gpJuGy3g/SEjxMD6w4z8iYchCzbPuCVydAcglgVImWpjbVr7g2K1W+DbazpM
	=
X-Google-Smtp-Source: AGHT+IEAUr9zghTEqbLPVOaKd1kA+KWHp2S31/G9XQzAAHxpn+gWkKxU4GM59uffiKAEQIim/PwS5A==
X-Received: by 2002:a17:90a:ce8d:b0:2e2:cd65:de55 with SMTP id 98e67ed59e1d1-2e56175742emr18618394a91.20.1729609821009;
        Tue, 22 Oct 2024 08:10:21 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ed277sm6378409a91.39.2024.10.22.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:10:20 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:40:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
Message-ID: <20241022151005.g36xnr7lf46p32ha@thinkpad>
References: <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>
 <20241001101622.ys36slymgjbaz26q@thinkpad>
 <8459161B-87B8-481F-AE71-3D5156B1CA56@linaro.org>
 <20241001141948.g74rn6777ywvtcmx@thinkpad>
 <CFF89D4D-8131-47C2-95B8-A0E130A16E46@linaro.org>
 <9c24ba5d-431a-c45e-ce1c-3541eac7d017@quicinc.com>
 <20241012124334.4gsspgtuud4uudop@thinkpad>
 <7yzjgqitjvfwricftcpelktwjbgwkjuibwkpodjd6x4gwkjkw3@wkeqp6lqwfqv>
 <bbc900f7-eb8f-2664-2144-50a9a6ad8453@quicinc.com>
 <qevhitaa47fd77jrrs4viv6mctkhedoz5jy33ruqvv62qrb44y@owzfxnxrapvf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qevhitaa47fd77jrrs4viv6mctkhedoz5jy33ruqvv62qrb44y@owzfxnxrapvf>

On Thu, Oct 17, 2024 at 02:12:00PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 16, 2024 at 10:43:19AM +0530, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 10/14/2024 4:55 AM, Dmitry Baryshkov wrote:
> > > On Sat, Oct 12, 2024 at 06:13:34PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Oct 11, 2024 at 05:24:29PM +0530, Krishna Chaitanya Chundru wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > The logic here is that the fixed endpoints in the switch will get an unique SID
> > > > > > > and the devices getting attached to slots will share the same SID of the bus
> > > > > > > (this is the usual case with all Qcom SoCs).
> > > > > > > 
> > > > > > > But I guess we would need 'iommu-map-mask' as well. Hope this addresses your
> > > > > > > concern.
> > > > > > 
> > > > > > Yes, thank you!
> > > > > > 
> > > > > Hi dimitry & mani,
> > > > > 
> > > > > This particular board variant doesn't expose any open slots to connect
> > > > > a different endpoints like another switch(which might have BDF unknown
> > > > > to us) so static table should be fine for this board variant.
> > > > > 
> > > > > I tries to add iommu-map-mask property, the issue with that property is
> > > > > that the driver is applying the mask to the bdf before searching for the
> > > > > entry in the table. If I use a mask value which satisfies all the
> > > > > entries in the table ( mask as 0x718) and if a new bdf is enumerated
> > > > > lets say 0x600 due to mask 0x718 its value is again 0x600 only.
> > > > > 
> > > > > Can we skip iommu-map-mask property and use only static table for this
> > > > > board as we know this board doesn't expose any open slots.
> > > > > 
> > > > 
> > > > Hmm, I was not aware that it doesn't have open slots. Fine with me then.
> > > 
> > > It doesn't feature open slots, but it has two PCIe connections on HS2 /
> > > HS3. Users might attach external PCIe devices.
> > > 
> > > Krishna, could you please clarify, how those two connections are routed?
> > > 
> > For this qps615 board to one of the downstream port (pcie to usb) usb
> > hub is connected and to the other downstream port NVMe will be
> > connected.
> 
> The board has two PCIe links routed to the HS2 and HS3 connectors. Are
> they routed to the PCIe switch?
> 
> Yes, they are not standard slots, but still the board is expandable and
> it is possible to connect external PCIe devices. As such it is not
> possible to have static SID mapping.
> 

Sorry, I think the conversation got deviated. We have concluded that the
endpoints fixed (soldered) in the board will get a fixed SID (because we know
what they are) and all other devices going to get connected to HS/LS connectors
will get shared SID (because we don't know what they are).

Any concern with that?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

