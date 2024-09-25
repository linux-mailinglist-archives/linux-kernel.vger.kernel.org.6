Return-Path: <linux-kernel+bounces-338227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186498550F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3921F21285
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A115AAC6;
	Wed, 25 Sep 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yc9/tr21"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D5158A33
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251527; cv=none; b=uze/NcDr02HY2/9JJrRkDRh44TJtaLCyF/MBn7Qa5ouruH5OM8EgpXFlG+bLT7evHQNL1MBJxIIii/6nhF9J+fL90D1ciNehvWbtibwqeNniVVuSabXlyOhT60cSPixQOVPbYS4MjjAaiANhxv2Ay6dd7TYmrGN5SZaHW2GXN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251527; c=relaxed/simple;
	bh=Ge+7LszBaOT5Dm6+t5UCLcHOk904zSSAP9mOUFtAaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKagvFrCvFhh8DrQnCQsUkcbwTHV0fNLivmNBRi3NjsKuvOUDlP0J5X1EPa4NWZTxeIJihGtw1Iz4xP+ZM7cWYRX9LC3nFUR7Lif8mxaIJhSVLAs8zs6DZWAyLfdFclposyO97d3e4K8XDdTT7QI7fVvfFJBX1KN6SmO9rDabRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yc9/tr21; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so63227495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251524; x=1727856324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fmE1UeERqrchW40NVacg6nrSR6Vcco0wZ6da4wq9+7A=;
        b=yc9/tr21EW3GzcNSMPS2Z+skDSEURgLHh543NbLFnQy/R3ccxmO4zmG48598TV3/8R
         MbQl/HfzMXpMd6YqAXIGT8giyg3w1d7+bczZL0jJwnnLZOEsbTHZanyFKjvG+HvJjr64
         GHbcJCSrI4S2wu9ru5NELW5sFvLnGcChKkjvpbCaAB2wuejaC4uXagXB/ofxLTvRF9oo
         D+Pkch73c++xHNqwtxx+x640Kj+CBdDIfiGICpZ3fCy3VZaQ2Hx5s9eMK5yowW1Xwbo3
         m7LpIbi/d2xfX0z6cgq1Do6TlnTsSyOPXXRR5nngfz2yc96Q9o3nDi1AT5SiQZvv5F/G
         F+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251524; x=1727856324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmE1UeERqrchW40NVacg6nrSR6Vcco0wZ6da4wq9+7A=;
        b=LNu3rloxSfH7IH7mQl3x4OOSeFbPDt/GLPEemNpyF3tPVLIJu/ikoe4/mVIiofIDBs
         gryT7pHDrLsHN1dEx0q5HB+vvTqqoNDyCHI/SFayWV46qb9hJr7QfoAakHM9ZRD1qZRQ
         /fLcnI16grcAewZvKaqGvwLjJ1KPxHFdklE6ZNlpdL63YbJvEu/X/9y5+E7DpwJBRgf/
         Qf70Bagc0syhPNcNE2OVN1z41woOxbjt0L8+VZ6NkqD8oir5Fj9vRyglA7WrDuPA4kMW
         18Bbvp8YhMqTv2gkLxrEG7XoiGSdRvqE/EUAoG2+1Cx81HiTQWAzFnfCJWnrYdCML1zY
         iW4g==
X-Forwarded-Encrypted: i=1; AJvYcCUSKqYHWV+hEjq3pkTXpPHm4dnyQZJS3G5FQ4zWUiqtSVBCbc1QWaqhAAq4L6FxPzkZNqcvZDIMZV2vMis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK55UfnLm4MvOawiDgZn2LmRn/1a3BRBZ0ADXBnW244MBh8to
	GRlXR9pU4TMf+UTgfFaMat0UDAs4U1dc68trjBC83aZDyDiZ4nz0YMdxud2eVw==
X-Google-Smtp-Source: AGHT+IGu+EQFdqJdQRNdKI2O1nnUzgvF8rHWsav7UIwu3lMA5nKO4ePunuX3F80nTqxwvNWJ8lBRwg==
X-Received: by 2002:adf:e7cf:0:b0:374:c64d:5379 with SMTP id ffacd0b85a97d-37cc247945emr1246796f8f.27.1727251523891;
        Wed, 25 Sep 2024 01:05:23 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e90cd8c5asm40971185e9.1.2024.09.25.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:05:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:05:22 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <20240925080522.qwjeyrpjtz64pccx@thinkpad>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>

On Tue, Sep 24, 2024 at 04:26:34PM +0200, Konrad Dybcio wrote:
> On 24.09.2024 12:14 PM, Qiang Yu wrote:
> > Describe PCIe3 controller and PHY. Also add required system resources like
> > regulators, clocks, interrupts and registers configuration for PCIe3.
> > 
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> 
> Qiang, Mani
> 
> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.

Is it based on x1e80100?

> Adding the global irq breaks sdcard detection (the chip still comes
> up fine) somehow. Removing the irq makes it work again :|
> 
> I've confirmed that the irq number is correct
> 

Yeah, I did see some issues with MSI on SM8250 (RB5) when global interrupts are
enabled and I'm working with the hw folks to understand what is going on. But
I didn't see the same issues on newer platforms (sa8775p etc...).

Can you please confirm if the issue is due to MSI not being received from the
device? Checking the /proc/interrutps is enough.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

