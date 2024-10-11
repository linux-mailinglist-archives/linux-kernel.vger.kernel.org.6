Return-Path: <linux-kernel+bounces-361222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36599A53C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535E11F21459
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA82194B2;
	Fri, 11 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIAZ5Sxb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE172185B9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653831; cv=none; b=kavDFITAi/eFU13Qjz6F7oEcYJyC8bYVvqw9XYeNjDmnjWCrxX6o+aHcRw7O22GsbDN8UnMCfglR5xB/4T50BW5yf1spV/b9IXdGW1XRjjalg5ZZp0Qe7t6Q/DbvSK6agpOfBIA3BP9A4r+13Ouc1+tTlDJN767i4mOUR10YXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653831; c=relaxed/simple;
	bh=cjMGxQOW5XddUAB+/xLXi8oiAJnn8YXWVX2jh465DMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3Sye+0TN06ApNkTTsSGbdsyoVGuTmJIQKKPsU1hWA1wWF2UwtQ3DgyNqaWrM1SFs93FTMf5POuuExMBwTLC1aCQK0bTTqyESDbHp1SrjWfdE3/rgNHcsNA3beW+3oKo6Cp8EXKxSL2cL/+j0INFABGp0UkJ1RLPs79/kppX3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIAZ5Sxb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e044d32bso800851e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653828; x=1729258628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaGfDqX+Jbu8yXuoPx2CqSC4Xq+Wq/cr4J5BmFZrmFw=;
        b=RIAZ5SxbvncvdpKUP/SDUacSGr4cZ76tCLsLwt5IfSN/0xgeENHW5cfkO9eMbep2AL
         NkQ3h22znylJqb5pS24FTBJfjyjfWoVP55Ba3a1sFvDQThgaSdu8uh2jSEsmpHm22pTx
         U+SJ3gAFmqadfOKkQRDTpJP7q2vu1/08KfvbqQAUQ6+eKs1i2VZCTLilzM+PgX/MYGwz
         sVy8s3B6Yv39IYlJfzHnyYYE1iKkLXbifzvu0PnwjmezWcT8F/5M/U7XzJeY3NW0deJO
         7RN2FXoShNWNm580m7agcZ9UkGjkWej2u4XNc3VibZ5wy1Ip0bYqwu3nObJ4ozDSKH61
         mQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653828; x=1729258628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaGfDqX+Jbu8yXuoPx2CqSC4Xq+Wq/cr4J5BmFZrmFw=;
        b=SKVMroZhmnPiLG1ElswVHQ3xT1DpMkOMolkiQbpn+IPS8DFKZeiS8ZcKniv9hD3nJ7
         pD9FLgn+ZuVcdeTy3kBmeIN2oGS0lW9KeWijP9RaRcYJdnlcMbd9lD9F4Zcany0c9NYr
         Z9KEMfCx6BMgc2SiyfzdodHvNgoMg8sSkIm7ZHlvqSJOAhVio2QGHJtg445aYNwpcQip
         doq9jkn+nre86qmzmD106Rht9bXrxgD6GtXzJA17TfPRVF3WN5hRtkWhHiM84hZUgmUv
         eCCNRtCqdS7RDvp4Sl994QD7WIsSaTg6uCGMgvld4rOKyzcE+5GC9TYqlrCltHRG8YdU
         h4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVXZEFSAYqleUbIdJXhPml2tfb7bK0peu9V5VPt3UqAxhIAsbsj87VcdX7kQ+30nFn2Q/eppRXQVRWfiD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN43Gl7cRuJVlJk+dtjv6X5RZh6xWosQiP6F+wqh6C2MuJ7b37
	hediaFe2XOtUsuGanjmChW+I0/BbggKGlYNPiR7XuvSG20vNVWBlCjDpCJKinOE=
X-Google-Smtp-Source: AGHT+IG3qL3pSC1dHQpXFWaYB+Rn07Kp1WBxWezdJxQFyqZIdB2oubsLQBMVJh2zhElcrmtmyeK9EQ==
X-Received: by 2002:ac2:4e03:0:b0:536:553f:3ef9 with SMTP id 2adb3069b0e04-539da4e0b9bmr1361860e87.27.1728653827760;
        Fri, 11 Oct 2024 06:37:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c8c9dsm599131e87.119.2024.10.11.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:37:07 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:37:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 7/8] PCI: qcom: Fix the cfg for X1E80100 SoC
Message-ID: <u6n2u7d3sxcq57hfyrbqri2bqehuogdaof6qe2uh7qela4pihy@7mhyjayiucmi>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-8-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011104142.1181773-8-quic_qianyu@quicinc.com>

On Fri, Oct 11, 2024 at 03:41:41AM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 has config_sid
> callback in its ops and doesn't disable ASPM L0s. However, as same as
> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3 and it is
> recommended to disable ASPM L0s. Hence reuse cfg_sc8280xp for X1E80100.
> 
> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

