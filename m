Return-Path: <linux-kernel+bounces-561620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19723A61427
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9AE3B9518
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1A2010E3;
	Fri, 14 Mar 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m34jz9vX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605222AF07
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964055; cv=none; b=mJDr++KnEjJOv9N9rgxazBYT7s7vLiy01pFn/Ll0TxoNA4chjPMwqOKeqAHmAz5mkchJhZ9QDlWvmA+Btus6CjJyvozSQ58CSs87QsV4dJkZ+F5KvJvr8f8sqCii7wUzsb0WeCwP+syvRw4B3QPVuy0uAjiSIOrVu1vkeiY0LnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964055; c=relaxed/simple;
	bh=auNWg3EtXdmee2r1M8LgUXlbLAnbWTsjH3D8o7NFe8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXSk1MEI8MAHRESTy/Vs0HLFn/lS9ETtZRbAJzJsnVrcF20yLr36Iu01Xe7cI9f32duL6SltZ6axyyb/Yr2Q2YXcGI2vUa9xwyFqcvOaArtveDAN3XquEk9XsqU75tlywaS0mZerkojvbcLB5eICIH0DBES9r9DuwQJ5Ue6RWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m34jz9vX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso57174985ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741964052; x=1742568852; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dsQQtVO/hGMC4LT3OjrS/iAkJsL7ea7avit69Kt1D9g=;
        b=m34jz9vX7XhN1qrRHhvnpHzUFkUSqU5hDRmOwgT4JGUVH8ByMZnnyAkqQW2CEvdOjE
         CxeTk1QVTvOZndPosy4urzmV5AbZKSick6gK6MBwUggaIB2qvFBMO/nPrikG7kZ4lDWa
         hdJU3Uz9WZBRehSiMz8ZxFS4+yUlgJ3D5HPy+H1XaQlvICqq2f7Y+AJVTzaH1c/y9T31
         x5XB8k35wCyA0thqHEGU2orjbrcpDIdEDAI4uHjXOn5Y+IhzQAdeO8ydznhUJqoXFYGd
         zD+O9kTl/uPmMA+pwYyuNXY3WVxpUG+yyXqJjoGYmxPvsazxBjxqzQrk+zVXcSQozteE
         7Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964052; x=1742568852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsQQtVO/hGMC4LT3OjrS/iAkJsL7ea7avit69Kt1D9g=;
        b=Unl5CtvreNz+4ZW3555+x6pDRP44zLSNrNYHP0GfECblsHavr/Nt933ldnG3g+vxjg
         quMnoyFToN6UbvRXnlDUGAtV146P82rDGjypCLqF50UEJSjQkkxgvD1xjA2AzTfUFz8L
         Mr94TjjZa+o9eqr7W7IYMqYNayoAkd/wnWHHTmAJGohg6vyKgDD+5CbI98FyVfNE8fqQ
         lL5nACZ4Ah8Yb5aCntCYt+codcS1mJnnE2FPV3kWgFIuDneejfZahf2WgRdVGnzvtYam
         zPYAQkowAyC0DXb8m06sPoT5hi9N1QiX7B8Tx2PgVuezlLkJ+Wv81FMsTfZFiEt6ifjg
         iU0w==
X-Forwarded-Encrypted: i=1; AJvYcCVa3Hd2x+pOz7x8qkDrzge5ma7KuVQ+t/OY2AIeblm+0+2tQ44Whmdq3WdVhUw2h8S3izdVln36H8BKNmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6C+TpaBn80+UP+854Rmw35nt0P6rzmFUusAbHoNL8t7bEGkA
	1/Oh7nIIgBhlQt+94nydFCjTMHBX8Rhf9c/YMkhanLocmH/RgnzRqOueA0QZgw==
X-Gm-Gg: ASbGncvjplCFW/9jJxp0Kd2/ZclYnQLbTbHAtyRCuAf4wx4YNMaNQZk8Ik+3rkGv15F
	nxQYTsCKawe2rNN0njwid/LadSqvHXDpgQBQriKDMa22GPxB6WwUvNZWcZz8fIR0xGvX/sF414j
	3CrHVAztgyfPiVYPb2aCsBcYTb43XsdHGeHK9GNsGlPrnV1/eqjC/C0QSySjktYqtyTjjBYIaye
	zw9Kg36L5dQA0g1LpyRMM+Wo717JxT/gWGjhRy9mGcG+xqGwxCPnx6zaoXyEyraPCjiW8H4s0zl
	q98GcF34Q4QLsgFs/UPV93fGe7pta8aDlKTeZZABDTXu8x5BYu6Aa3G4
X-Google-Smtp-Source: AGHT+IHzKryo+V7jF5cXWjTyfNfCm3Y69vTnLwXkAPKHfg34JnPxyDQUu9P0t75RNjjyMzo4OR6/iA==
X-Received: by 2002:a05:6a21:4d05:b0:1f5:591b:4f82 with SMTP id adf61e73a8af0-1f5c1184768mr4519574637.16.1741964052644;
        Fri, 14 Mar 2025 07:54:12 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e69sm3054059b3a.141.2025.03.14.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:54:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 20:24:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>, kishon@kernel.org,
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org,
	abel.vesa@linaro.org, quic_qianyu@quicinc.com,
	neil.armstrong@linaro.org, quic_devipriy@quicinc.com,
	konrad.dybcio@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] phy: qcom: qmp-pcie: Add PCIe PHY no_csr reset
 support
Message-ID: <20250314145407.5uuw7ucrdhca4z5i@thinkpad>
References: <20250226103600.1923047-1-quic_wenbyao@quicinc.com>
 <e556e3c9-93ee-494a-be35-9353dc5718e4@quicinc.com>
 <Z89Ek8Y7TRSgTuMg@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z89Ek8Y7TRSgTuMg@vaman>

On Tue, Mar 11, 2025 at 01:29:15AM +0530, Vinod Koul wrote:
> On 10-03-25, 16:58, Wenbin Yao (Consultant) wrote:
> > On 2/26/2025 6:35 PM, Wenbin Yao wrote:
> > > The series aims to skip phy register programming and drive PCIe PHY with
> > > register setting programmed in bootloader by simply toggling no_csr reset,
> > > which once togglled, PHY hardware will be reset while PHY registers are
> > > retained.
> > > 
> > > First, determine whether PHY setting can be skipped by checking
> > > QPHY_START_CTRL register and the existence of nocsr reset. If it is
> > > programmed and no_csr reset is supported, do no_csr reset and skip BCR
> > > reset which will reset entire PHY.
> > > 
> > > This series also remove has_nocsr_reset flag in qmp_phy_cfg structure and
> > > decide whether the PHY supports nocsr reset by checking the existence of
> > > nocsr reset in device tree.
> > > 
> > > The series are tested on X1E80100-QCP and HDK8550.
> > > 
> > > The commit messages of this patchset have been modified based on comments
> > > and suggestions.
> > > 
> > > Changes in v5:
> > > - Add a check whether the init sequences are exist if the PHY needs to be
> > >    initialized to Patch 2/2.
> > > - Link to v4: https://lore.kernel.org/all/20250220102253.755116-1-quic_wenbyao@quicinc.com/
> > > 
> > > Changes in v4:
> > > - Add Philipp's Reviewed-by tag to Patch 1/2.
> > > - Use PHY instead of phy in comments in Patch 2/2.
> > > - Use "if (qmp->nocsr_reset)" instead of "if (!qmp->nocsr_reset)" in
> > >    function qmp_pcie_exit for readability in Patch 2/2.
> > > - Use goto statements in function qmp_pcie_power_on and qmp_pcie_power_off
> > >    for readability in Patch 2/2.
> > > - Refine the comment of why not checking qmp->skip_init when reset PHY in
> > >    function qmp_pcie_power_off in Patch 2/2.
> > > - Link to v3: https://lore.kernel.org/all/20250214104539.281846-1-quic_wenbyao@quicinc.com/
> > > 
> > > Changes in v3:
> > > - Replace devm_reset_control_get_exclusive with
> > >    devm_reset_control_get_optional_exclusive when get phy_nocsr reset
> > >    control in Patch 1/2.
> > > - Do not ignore -EINVAL when get phy_nocsr reset control in Patch 1/2.
> > > - Replace phy_initialized with skip_init in struct qmp_pcie in Patch 2/2.
> > > - Add a comment to why not check qmp->skip_init in function
> > >    qmp_pcie_power_off in Patch 2/2.
> > > - Link to v2: https://lore.kernel.org/all/20250211094231.1813558-1-quic_wenbyao@quicinc.com/
> > > 
> > > Changes in v2:
> > > - Add Abel's and Manivannan's Reviewed-by tag to Patch 1/2.
> > > - Refine commit msg of Patch 2/2.
> > > - Link to v1: https://lore.kernel.org/all/20250121094140.4006801-1-quic_wenbyao@quicinc.com/
> > > 
> > > Konrad Dybcio (1):
> > >    phy: qcom: pcie: Determine has_nocsr_reset dynamically
> > > 
> > > Qiang Yu (1):
> > >    phy: qcom: qmp-pcie: Add PHY register retention support
> > > 
> > >   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 86 +++++++++++++++++-------
> > >   1 file changed, 63 insertions(+), 23 deletions(-)
> > > 
> > > 
> > > base-commit: bcf2acd8f64b0a5783deeeb5fd70c6163ec5acd7
> > 
> > Hi, do you have any futher comments?
> 
> Patches lgtm, It would be great if this was tested by someone as well...
> Abel, Stephan, Neil can you folks test this and provide T-B
> 

I tested the previous version and it worked well on X1P40100-CRD. Will give this
version a go and give my tag.

> I am also concerned about bootloader assumptions esp if the Qcom boot
> chain is skipped
> 

In that case, someone should add the PHY init sequence to the driver. That's why
I wanted to have the check in place to avoid silently failing PHY
initialization. Right now, the driver will error out if there is no init
sequence available.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

