Return-Path: <linux-kernel+bounces-247130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432492CBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4F32817DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E20C8248C;
	Wed, 10 Jul 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOdD3+kn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7081AC1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595359; cv=none; b=AK3QfN8ndaFWcpH8BcdI2yMSgPn6jV8XguSMAYCtlsxFcu562KQfSEw0Dv0nW7DPoJi2FpyeWO5WQIMXUhflBm1wk1AbQRPhl4FoiVdwLw2JrdfEHMlaakokMTa6Iwp0rsEofNOoUTDyTcFx5tGPY8F6khv18bOFDiTwG9oeKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595359; c=relaxed/simple;
	bh=OT979Mbwccrux7nyb412mjccw6Y//DJLzT48HaqYqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMdFr9s+D/8Boty86bsUEvMlebpPlPea19GDMLfF6Sebd8/Xyyw566imCFx1XwWrG6NYRFPIMK9zsuIoHzz/Byxk3MABme4ihYEgPmY7RdiFNjRzMInRnCi4nwN22742+rGP07kn97TVJRaZNpclYHuq9pTr9ZN9DHrhv7RtwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOdD3+kn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b04cb28acso395104b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720595357; x=1721200157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0bu6VssHFvmAMt5F5xmH4HU5/r8C8lHI0vg8R3gXXQ=;
        b=tOdD3+knzVO8gSqtPkxiEZSpqSGPvLLh9ZqZMguUHeDFtV6zGVHfmPuCtObx5j1CPO
         UDqAhx+aBfkF4BiaPT7sKOCUxi4pAEU6eEFPR8ccyyr3ERugGCND5Wg80VWDzzYSZIfi
         inATMRL7tnWc8a3Ku2v5B50CfcaaY66ASbq8SMuRb00vn43GZeSvRCD8K49SKmC6XI4B
         wd/4yEgz+QNXjDrFVQXP/1JqqJDJw08H5w+O9r/YVkn27NHqk76KEpRUGG86d9mVoKbP
         vE0NBJHoxT25UkhdTfcC4mDc59m2BvI7QVvCYf6TAOc0FF4BtMZ07jhl/VtVklLiCeO6
         Rgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595357; x=1721200157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bu6VssHFvmAMt5F5xmH4HU5/r8C8lHI0vg8R3gXXQ=;
        b=Bd9tOGDfVfMh6LQih2GEHn4xtyMvSG5YSvS7F/u8KyVFA/U3zX6CoMjTsaCyckrRyQ
         AYrf8gra5+oYl163Nkjz2RBTvW2xpHHpIjkhN8rmb+XLNK5f8K3bvdG7+QRgIQ77u4OY
         dQiwggaRp943kAHxfs060QsgCNqZnSclxKYlHQrDFE+ytSBskKG7U4BA7jQIfk/GKKuR
         ilHB7DlU8ZtUFmXxjYcUFesR0ch0N5qrlRZjIvqOLwQSTAO2IajxooO5zLI5buXjHipI
         NIyXDq68bRg1PQ6U63ofVTKPME3eMt1YT2DlxiTOvQkDo45NrYZkO4o7qxM9KRJ8QhnX
         1xuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOX73ttyp5gV7H0S2eT84rhgxLGUoJUFMZwUfUwmXyvSbmZcop1PUzQU8Ykkfz+P4cIhZeLG8eU5NVQVmCoSlxihG3yNXS7UtoIVe3
X-Gm-Message-State: AOJu0YxDnG2/ImN9ru2/hdjfmvaUBcKxUXuip+CsD3xJPnpGPa9KSG/H
	DnB24Mziq5T9fzfTZ3JuX5AsmnkUHcS3m6qKSCo+xshFJiWT6b8DwUCSt++NKA==
X-Google-Smtp-Source: AGHT+IG/rAnEukBAzI2bnWUEZo3nkrCfOIU03sX3YeQH2JHev4ZrCkeAgEfzwqzVu3fW34UT14c7uA==
X-Received: by 2002:aa7:8c45:0:b0:70a:faf2:1764 with SMTP id d2e1a72fcca58-70b44d3a3demr6367450b3a.3.1720595357318;
        Wed, 10 Jul 2024 00:09:17 -0700 (PDT)
Received: from thinkpad ([117.193.213.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54ebce29sm499353b3a.45.2024.07.10.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:09:16 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:39:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
Message-ID: <20240710070908.GA3731@thinkpad>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
 <20240709175823.GB44420@thinkpad>
 <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>

On Wed, Jul 10, 2024 at 09:47:47AM +0800, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/10/2024 1:58 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 09, 2024 at 10:59:28PM +0800, Tengfei Fan wrote:
> >> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> >> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> >> While the QCS9100 platform is still in the early design stage, the
> >> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> >> mounts the QCS9100 SoC instead of the SA8775p SoC.
> >>
> >> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
> >> all the compatible strings will be updated from "SA8775p" to "QCS9100".
> >> The QCS9100 device tree patches will be pushed after all the device tree
> >> bindings and device driver patches are reviewed.
> >>
> > 
> > Are you going to remove SA8775p compatible from all drivers as well?
> 
> SA8775p compatible and corresponding scmi solutions for the driver will
> be taken care from auto team, currently IOT team is adding QCS9100
> support only. Auto team have a dependency on the current QCS9100(IOT
> non-scmi solution) and SA8775p(AUTO SCMI solution) device tree splitting
> effort.
> 
> More background and information can be referenced from [1].
> [1] v1:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

I'm aware of the background, but what I don't understand is, why do you want to
keep the sa8775p compatible in both the driver and binding? Once you rename the
DT, these compatibles become meaningless.

Waiting for Auto team to remove the compatible is not ideal. They may anyway
modify it based on SCMI design.

- Mani

> > 
> > - Mani
> > 
> >> The final dtsi will like:
> >> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
> >>
> >> The detailed cover letter reference:
> >> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> >>
> >> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >> ---
> >> Changes in v2:
> >>   - Split huge patch series into different patch series according to
> >>     subsytems
> >>   - Update patch commit message
> >>
> >> prevous disscussion here:
> >> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> >>
> >> ---
> >> Tengfei Fan (2):
> >>       dt-bindings: PCI: Document compatible for QCS9100
> >>       PCI: qcom: Add support for QCS9100 SoC
> >>
> >>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
> >>  drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >> ---
> >> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> >> change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d
> >>
> >> Best regards,
> >> -- 
> >> Tengfei Fan <quic_tengfan@quicinc.com>
> >>
> > 
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu

-- 
மணிவண்ணன் சதாசிவம்

