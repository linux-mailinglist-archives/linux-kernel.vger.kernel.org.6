Return-Path: <linux-kernel+bounces-338230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E498551D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6441F21478
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A6158DC2;
	Wed, 25 Sep 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNysbl1B"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D11B85D1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251650; cv=none; b=FCjjU8ZrsRxHnXz4ECdlihWIoM0xLPB8b5n1aoF0S99fx0Z8lYlvvR4/U2n9cZFR0Fna8UY+NfLKwlkfw86Yoia/r/YfwjawSyOeffU5CyD5XYAlcqb12Oe1JloXnC8QeqABa9da1HJ4EVr5LgrZitE4jHUucL6F5AWc4puauHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251650; c=relaxed/simple;
	bh=NCvEqalJkNobkK4xCLa4xTHDtYUKlDxJri6i+vjftgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAPTFNS/nIJLD39ePYa3JoGf0rdy0vx9WKR5xNBgaoZsaiuJOGCo5Bk+rZyRwN/h5Q11DYhsXQa5T1HoeMUjut9Rkjvk2cnvq80cRMKQ9G/6sUqOrqPkNeC9b0AYkD0suFztCgq0rArKEnURCl2HVit2YE7+MntCE6HDFD4xsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BNysbl1B; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374bd059b12so3867436f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251647; x=1727856447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXVU8v0cgzQWSNcs1WDVL/U60/ljsd6Fh51Q9oFrZbQ=;
        b=BNysbl1BuiRsRQ4Wq85x4ivITW2+USJm++R5WSP8AOyyqRCzBdrtLGCN8ZsG3GD+sP
         Qic3TS+2TGleF9ZLOCAFLSplpYSMi+rgxcmJYbfkJPVfl6tlJQ2lBO6H+WviHm2w9i77
         sz7lGDXKPT/ytnRiPcQgvoqRHHI5U3tfBHUEb5yZYs+bcrqXZs/NwtZSkqEL3Wp9o4Ym
         zaArtnAUfoSyP7ULHZaZtBnpf+mfG6QtkEuF6TgtOYWiheseicTSNUj0fVwbeRYiRJHr
         hegUyEZo4KAB55R/7xt/9ogvNTQoeN9x/+91+w3sUiPOph2y6nLg9jeUjEKNOYpCydEJ
         8KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251647; x=1727856447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXVU8v0cgzQWSNcs1WDVL/U60/ljsd6Fh51Q9oFrZbQ=;
        b=W5HEw589JRDzXkPGmWp+X9w9WQHPD5wMb7dFQh0oIhdl41jqfggPO8MBt4IFT5Ipe1
         /bGkcE3VqRJfP06jXhcWy33dRBDWPRpHZEpdo77xAuzLacZuV6DJchSbdrMPuYHXsVpe
         xInnwcNQj1f/MwBI9L4mz8DvXaKUZhD8FrI9pyDZj8P/a/xG7nQSbCuFEKSgWBRc/Yn6
         s3mPY/yG8CKPTfkhSZUWZ8R7WQm4I89mE9/UmEZRCpVHgVdcixssAp2GLUNxHAjsoDqk
         rsbL2xb1qyowwQAmhnTPMCkFVmTq4t3LfnPqXHDCGTLPO1D1CxuEs4u3lAtjBvpLNT4c
         iWYg==
X-Forwarded-Encrypted: i=1; AJvYcCVVjyJFfZLNDKBgWPWwbiEJgP2AXcEKxWwgIFUpv6T6JuLiPKnILKNVVV/TFpBUXoAKkF/QFu+mwVFhGxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYA97CR5+Avr7GEwAHsrShW3CeGMKpmnQqwMBmnVaTBsG9AgZ8
	XDwqLhOg0LqiugIwe1khIQvCk0fImqV1LHiGYozboSWLy8SrWECXg7h4CLp3aw==
X-Google-Smtp-Source: AGHT+IF3d7MLoLPQr09BqD6UIJTxajPOYuaB+UljK19usG1V4QJtMVf1uk6Oji0/gyQV5Qdf5Z5vNg==
X-Received: by 2002:adf:f88c:0:b0:374:bb34:9fd2 with SMTP id ffacd0b85a97d-37cc24ab641mr976949f8f.36.1727251646741;
        Wed, 25 Sep 2024 01:07:26 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f5c9sm3287058f8f.102.2024.09.25.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:07:26 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:07:24 +0200
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
Subject: Re: [PATCH v4 5/6] PCI: qcom: Add support for X1E80100 SoC
Message-ID: <20240925080724.vgkgmnqc44aoiarv@thinkpad>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-6-quic_qianyu@quicinc.com>
 <20240924135021.ybpyoahlpuvedma5@thinkpad>
 <ZvLX_wkh7_y7sjPZ@hovoldconsulting.com>
 <4368503f-fb33-4e6a-bef4-517e2b959400@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4368503f-fb33-4e6a-bef4-517e2b959400@quicinc.com>

On Wed, Sep 25, 2024 at 11:47:02AM +0800, Qiang Yu wrote:
> 
> On 9/24/2024 11:17 PM, Johan Hovold wrote:
> > On Tue, Sep 24, 2024 at 03:50:21PM +0200, Manivannan Sadhasivam wrote:
> > > On Tue, Sep 24, 2024 at 03:14:43AM -0700, Qiang Yu wrote:
> > > > X1E80100 has PCIe ports that support up to Gen4 x8 based on hardware IP
> > > > version 1.38.0.
> > > > 
> > > > Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
> > > > callback to config BDF to SID table. However, this callback is not
> > > > required for X1E80100 because it has smmuv3 support and BDF to SID table
> > > > will be not present.
> > > > 
> > > > Hence add support for X1E80100 by introducing a new ops and cfg structures
> > > > that don't require the config_sid callback. This could be reused by the
> > > > future platforms based on SMMUv3.
> > > > 
> > > Oops... I completely overlooked that you are not adding the SoC support but
> > > fixing the existing one :( Sorry for suggesting a commit message that changed
> > > the context.
> > > 
> > > For this, you can have something like:
> > > 
> > > "PCI: qcom: Fix the ops for X1E80100 SoC
> > > 
> > > X1E80100 SoC is based on SMMUv3, hence it doesn't need the BDF2SID mapping
> > > present in the existing cfg_1_9_0 ops. This is fixed by introducing new ops
> > > 'ops_1_38_0' and cfg 'cfg_1_38_0' structures. These are exactly same as the
> > > 1_9_0 ones, but they don't have the 'config_sid()' callback that handles the
> > > BDF2SID mapping in the hardware. These new structures could also be used by the
> > > future SoCs making use of SMMUv3."
> > Don't we need something like this for sc8280xp and other platforms using
> > SMMUv3 as well?
> From what I know, sc8280xp and other qcom platforms are not using SMMUv3.

sc8280xp indeed has SMMUv3 for PCIe, but I'm not sure how it is configured. So
not completely sure whether we can avoid the mapping table or not.

Qiang, please check with the hw team and let us know.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

