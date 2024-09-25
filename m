Return-Path: <linux-kernel+bounces-339106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E7986062
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147181C20B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88B1865F2;
	Wed, 25 Sep 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQjWamgQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AB158524
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268751; cv=none; b=jlSbGYnm21H3abo3jpceku6YoRV+wSRgXsClxuPdk9mG4otkQ4IWrPvsSczHVVM6Wvwl51A5SDeqiovaNQMITBOWoxN7Zo58mDE9jhw0XsA2P2DhwykHDj1yQKCVe8QscwZY7UHUPVjmNn3bpgaA0wwTIYdir/TjqhDh5CMPWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268751; c=relaxed/simple;
	bh=v8nFyWsksEF8DTF1lg3ZcP05G+mbIViNLRepJVEIEcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxJuO0VqG4J2HVmA4TTqWXMMTzutGoc002+A3rdnDut7XXqI4K1enMq2d0MsTKyn8R1AiGoxw2/3NOCUuIRYbDrv6FPz7RaiuAoHEhVnC4HXZDx1CSUfnqVfccMq7zKunOvT9djk/KEVphMQN3EjZGf/mBJAI293VOOJxoTkMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQjWamgQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so66009225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727268747; x=1727873547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PsYnTiQnoLJmTLqLligtuj1TznoQqpggCMnS36XtOaI=;
        b=gQjWamgQeu3mY706fYbRPb4Gs8vSsRR+e3bgL0K/iQzkJPdYswAepkH8PWLUa+ixnq
         zsedIwwnQWGWYOwXHRSrXF+4Hr09O0fSNJ2GCTnWxq7d5TUordl0GkJalTEfCDFYEwrQ
         1QnXG2LijNVLY3x5r+Lsf7Z8MUTyUENcxBAZ0iwDE/nkYLlL3BLl5+iXTYzD8ckJJWH7
         GRyBABHG5O3v6VBswCiSVwgVUX9nn8hW0od394L5vTTLH/y8b7juIG+Utpsa+7ftOd+L
         sqSogyw7Fp8+0lDCLDme/zc07qyj1VAzJF0e7NgI/MFPhAIA2AWgL25k426fXseOFgTz
         UlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268747; x=1727873547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsYnTiQnoLJmTLqLligtuj1TznoQqpggCMnS36XtOaI=;
        b=OahZJO40lrGO4H6tBpv+nEzgSp3LkIdmq/HE+7pA/7fBCY0RNPMNBqFGRNxdT9JkGt
         Go0qk+BdOIGRnoq6xZ78oCETQ5sQ67zBicvXr+s1eFjDEo3in4HPaFwnMoR1ePE1kL1C
         wyP1gAFHuAhP7sGKmY0XBNXd7R2goD1FrCtQSzIj4W/RJZOBweDIslIcVTuUNva5KcoO
         sCYAHkUPJQQv1d0u7kesyfb3+AP2IG+pvpy3nZPGMO0yVScCJwVa0LE5I2KGECL3wYIf
         BDHUG+TeUFsTQjabnCXBKSLVfjSQD0bUaJ1nY/k4mGMFRix3hxoj3xWr9Yvg6amPD7OO
         mTwg==
X-Forwarded-Encrypted: i=1; AJvYcCXIAofGb1n943iCRqA+3n3w7PJ9/LHycxJ+18gtJgdQHKDxxve9I+1MbJnP5+b6Rv0XCDQ9FyGzeEOwGuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydjrqwmgQUMMAgKMu/UIrlzm2+PaRpTZ2bKPayUBhN3qzMips9
	bHUrqqwx5MSzqcXeoUoAZJ+2sqQ2ReOkMXPlcsGgHCrv789K0jC+BkYW5iNOcA==
X-Google-Smtp-Source: AGHT+IG4lPaaPhhTrY0nQowUBPj7qZopeTwFGYzQZG1u0Frm/UegncIuXWSeBUCFGZpQxJONnfZ1dw==
X-Received: by 2002:a05:600c:3581:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-42e962456cbmr18604785e9.32.1727268747527;
        Wed, 25 Sep 2024 05:52:27 -0700 (PDT)
Received: from thinkpad ([62.67.186.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969a8bd5sm18569155e9.0.2024.09.25.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:52:26 -0700 (PDT)
Date: Wed, 25 Sep 2024 14:52:24 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <20240925125224.53g6rw46qufxsw6m@thinkpad>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
 <20240925080522.qwjeyrpjtz64pccx@thinkpad>
 <4ee4d016-9d68-4925-9f49-e73a4e7fa794@kernel.org>
 <2731e17d-c1ad-4fb4-ab60-82ceafeffbaf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2731e17d-c1ad-4fb4-ab60-82ceafeffbaf@kernel.org>

On Wed, Sep 25, 2024 at 11:46:35AM +0200, Konrad Dybcio wrote:
> On 25.09.2024 11:30 AM, Konrad Dybcio wrote:
> > On 25.09.2024 10:05 AM, Manivannan Sadhasivam wrote:
> >> On Tue, Sep 24, 2024 at 04:26:34PM +0200, Konrad Dybcio wrote:
> >>> On 24.09.2024 12:14 PM, Qiang Yu wrote:
> >>>> Describe PCIe3 controller and PHY. Also add required system resources like
> >>>> regulators, clocks, interrupts and registers configuration for PCIe3.
> >>>>
> >>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>> ---
> >>>
> >>> Qiang, Mani
> >>>
> >>> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
> >>
> >> Is it based on x1e80100?
> > 
> > You would think so :P
> > 
> >>
> >>> Adding the global irq breaks sdcard detection (the chip still comes
> >>> up fine) somehow. Removing the irq makes it work again :|
> >>>
> >>> I've confirmed that the irq number is correct
> >>>
> >>
> >> Yeah, I did see some issues with MSI on SM8250 (RB5) when global interrupts are
> >> enabled and I'm working with the hw folks to understand what is going on. But
> >> I didn't see the same issues on newer platforms (sa8775p etc...).
> >>
> >> Can you please confirm if the issue is due to MSI not being received from the
> >> device? Checking the /proc/interrutps is enough.
> > 
> > There's no msi-map for PCIe3. I recall +Johan talking about some sort of
> > a bug that prevents us from adding it?
> 

Yeah, that's for using GIC-ITS to receive MSIs. But the default one is the
internal MSI controller in DWC.

> Unless you just meant the msi0..=7 interrupts, then yeah, I only get one irq
> event with "global" in place and it seems to never get more
> 

Ok. Then most likely the same issue I saw on SM8250 as well. But I'm confused
why Qiang didn't see the issue. I specifically asked him to add the global
interrupt and test it with the endpoint to check if the issue arises or not.

Qiang, can you please confirm?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

