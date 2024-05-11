Return-Path: <linux-kernel+bounces-176435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13408C2FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB828406E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F821610B;
	Sat, 11 May 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6QWFToX"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919AA55
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409578; cv=none; b=CByE33TyaLlsTHUh5P1wM1sUySc4dp+H7zc2+67rTgIAypG9gQgWQnF9FJdFmc1sLMXPMFIwXixOXJBfonOrcTXa+2t/LKit9nXyV7SjMPinvHfzmqzs0HuxOKYbkBdAGKbWi/dZwa5kPCmoMto2NVk45QJNiF5hkAR0Ml8mMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409578; c=relaxed/simple;
	bh=ohIU0BNbyMtZNdVZlUNr4IqV8gPhaMqQ1agVuP69fhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDXACV6rsT+Uf1ZTACfcaXyew2H3b9m+qQv01yWWkmahKf62H/jhVdVybJcuSGwro7vBQJAT6eZOOI51HucvVovNKPkIzkOVNVildhRrbnW31RRD3C3MBxugaOtCJebX+dMDkMERmbuESiIIrA7UxWSWBbT97g1oClJNP5OquIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6QWFToX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1851898a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715409575; x=1716014375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZGOyYQlPMjCo7NoBFPkuXTj+4higrK3cJrWnMzKiEg=;
        b=g6QWFToXQok+V3jhWb2TA3WU/cfN+txc45PKhItOMk96vdRAEaANIWx+gFttgrZYl+
         FaI0gNYJJUlNVBsU0WD281elonouHMH79bVjcJIcikEn7fIQq+1qOAg7Oyvqny8ZxMB5
         UcM/tzNUBRzotnXfpSVPX9quL1B3mOqbutzAuG5Wrt+3AXVoayqJf6ylehJpcRzJu5fd
         qJVZl66V3RmCFsyB3I0stWXqVJg3DXjGQyIy5APlEfcU179nQ2E5nYyP5RHRbvbKn+dW
         EbWLXROGUq5dwKFMtKiMiVJu7m3KL6nm00/lA8Yx6c6eyL9A+Xp7pBdaZWNtUd8iCsmH
         QoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715409575; x=1716014375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZGOyYQlPMjCo7NoBFPkuXTj+4higrK3cJrWnMzKiEg=;
        b=krfu7c7r2ApgoTGAK6cQuV8BkzhGYeLLgFqlfzvKUBYepPbK11TqQM46P5GlqqTwwL
         8bvm0XxGknubPSUXL/XBvF7OsM7yhI9BSuFv+Kum+J9o3MiZErml6k/yKkxdPZtbhyW+
         6XsRxETHzt+yp4BzqytiTsLR3AUKmx1/aUURX7oYKa2LMpKightV+QOnKa3u6LU0t02g
         SKvCZTx25zPywDLu2ioH1XDePWpz6BLVABiAknHUBqsjlxkPD4sYy6lYuG92c+m13Yk8
         1zmL9y89lLcFmpwij5kXVvACyl/OY8DVTqVejkhJ9oWLcTQmrNPPzjz4llVNsHmMWUGB
         KZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoZ/yzCaGiL0jmPZa8OkPWJSXwxV5PasfjZiYyuFn9lxMtlXjpm4zTHl0RvEWgw9mP+mPOtNgMdw6K0GoEA98MJZWUxqt+ezWTpIal
X-Gm-Message-State: AOJu0Yz9e8+T+R4ijSQOX/4dVVcyduswBo/IiKm2rWZNHsrFSYz81Mks
	8cI0NP8sBDzhRK9ocBA2g/09Cv4qWqtxjrlh+egH3ROeZyMOGl6LUhmslTn/oA==
X-Google-Smtp-Source: AGHT+IFcPHdwaLWt2eocdN1RJhFnTd98pYEBepeLkuj7kAaEyXPW4pVze6C7JF/k2OT36e+fxjw+tA==
X-Received: by 2002:a05:6a20:dc95:b0:1a7:60d8:a6dd with SMTP id adf61e73a8af0-1afde1df3b4mr5538644637.53.1715409575282;
        Fri, 10 May 2024 23:39:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671056629sm4242175a91.7.2024.05.10.23.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 23:39:34 -0700 (PDT)
Date: Sat, 11 May 2024 12:09:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 5/8] PCI: qcom: Add support for IPQ9574
Message-ID: <20240511063929.GB6672@thinkpad>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
 <20240501042847.1545145-6-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501042847.1545145-6-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:28:44PM -0500, Alexandru Gagniuc wrote:
> IPQ9574 has four PCIe controllers: two single-lane Gen3, and two
> dual-lane Gen3. The controllers are identical from a software

You mean to say, 'identical to IPQ8074 Gen3 platform' since you are reusing the
2_9_0 cfg?

> perspective, with the differences appearing in the PHYs.
> 
> Add a compatible for the PCIe on IPQ9574.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

But the change looks good to me.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ea81ff68d433..e61888e6c63d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1551,6 +1551,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

