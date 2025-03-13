Return-Path: <linux-kernel+bounces-558799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED6A5EB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8F3B7241
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424141FAC53;
	Thu, 13 Mar 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcvXTkZK"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAF1DDC3B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845427; cv=none; b=soY0pZpHqfDWvLQOIruqI0USdnYsp0hbqVxztv+rVW8BCu0dy8rKdU7X3LESgFzBWCPnvgNM3FuOf26O+iiuqMYm2zUOSJBsd6cfjIzC0PtZf2FBTLGOVREmj/fdfMjzYJuxB4TBmNuVynKzoCAjopqKBW9C1BcLxUlyLI2jyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845427; c=relaxed/simple;
	bh=F4KVeeG/vfL6d+LN7wLEC48P+h1mm/VpKDoXwyHPxJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKCy18pL38wmr5qR8TriYfQFTe1WwEi8K5ojkqxmQrfvPsT9t0LXoMjnCCxGNXJxRMfIRpS1HJMgVl5GFPa1jvZBRqrK+VFn+/D1RKW5ObrrPSA5yQV07lHudLd91C+/AWoHBxPtUq4zv9EMQ4oPGmwn6yaCWfQQBiQVRul+xGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcvXTkZK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22435603572so10137215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741845424; x=1742450224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VHoBJbaXxWZBoHH4orsV607HNQCFDV6U6o2TbMEjzlk=;
        b=dcvXTkZK9v5l9ypIejk+MBRh1iZznuNKEgidR/wPk7J35xXlSy8ecmAJUT3HDZ4nak
         MAmaWBrPlcthMyexK7r7v5kz3C5IH4sOXON0k20mzItTWuYMF6Q1V64mHtwkvmIDBItL
         IjwWVIoc67shieH4iDrwXEn8qh6nL94S/5gvHe3LOsTR7qQbDUj0LyLG3rkxGMIhRdON
         KG6bJMVnt87wVrmTwtEvqCdIfqnRoF4GV1u3g3EGl43slydGfAV2KKFjCNdHZIP/WB//
         oEwDlPNiJ2qfwE8oD7mrpUNsUqE9qo3LOhxSA8qgiziGcg5bDgAAvp4kUzmAp5OPp4+n
         dgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741845424; x=1742450224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHoBJbaXxWZBoHH4orsV607HNQCFDV6U6o2TbMEjzlk=;
        b=dIPNxmFUAtgpmaZpnEFse/qS68+VbUJD5yHR8q5UDSioIOIbxd6wRPDvdqzU1RNH9v
         tnrOVKipIQMcIl0OY2FvO6+7s6FvCYYP66QMwE6tRs8/HFVuy8jRc0i8C2cC1rbjVLth
         kUGT3YJDn7VbWZvt7uySiWBz+BSm2Up2FzjFzK7Oqp2rYnOkDyxmuP08rSKUgGAMHD4B
         wj1Kj3ERdJjCJQFhM9goVPFdo8zNqmcFZ3Utx0Bl8PGHb6MS1fMuoZz6SlsodbW4MGf0
         gpXiEhc5w287fSn5HbZDxLGlOIS0sUQ7Z8PlT67yR9Aijp7jA5pi+sRzjElf47mC/OQ5
         O8pg==
X-Forwarded-Encrypted: i=1; AJvYcCUkLX44VvWK2YvHzhc4gn2QTTFGA9+QeSxLQM5Ljb4eV+GdU7C4XsK/gmBTaZc3POX8mXLs9chxxwtsoAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+lsKCf7lQiMV2N/sadoZ0Kf0X+zKcCn+emzbj2MrrNXGncfC
	yncWJEcDa2PATzbjnI3G1RKn0Q/QZydck8V4Hh/tGavopACZfgzzN5OwjWmTyg==
X-Gm-Gg: ASbGncsQrK1JNjmYO5m3AHBKMjeKt4AawAplXp9WLzg9AvnsKI7kB2eZdMEzwSimg/2
	gGFvztekF0NTr29Jc5oJNwG8gNOX1yomR/PSKCeaVXKFLwYRdXN0WhxNLiGYFiBCsTTtSBcge5I
	NpsIYbJ6awlAwdkkD0SKCR34WU1p8l0+CcYCD0Yhw/JoWXwYyKIF83uEl700MufyPqJLmsINA0D
	1lrIJY+hrgDbkMIdsKGLmRnaOi7MDpafpiTNfFTYwPy4YgUJBm6s0Tci/UgPOJUFxi/OsfbTbbW
	hYJhRwW0GBVn53j0n0/LgcMGnDOZV65RIT3Et4HovD3Ksog0/3x0sQ==
X-Google-Smtp-Source: AGHT+IHiW5BfoY5YHVExATQIPB58ttIl6IxR42gqC9h8+1Se6XOAkH59TkpxwTZSBoe4vBqiS4Z8Ug==
X-Received: by 2002:a17:902:d48f:b0:224:2715:bf44 with SMTP id d9443c01a7336-22428a96909mr390296795ad.19.1741845424487;
        Wed, 12 Mar 2025 22:57:04 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a4bsm5340475ad.216.2025.03.12.22.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 22:57:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:26:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>, quic_vbadigan@quicnic.com,
	jorge.ramirez@oss.qualcomm.com, cros-qcom-dts-watchers@chromium.org,
	linux-pci@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, amitk@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba
 TC956x PCIe switch
Message-ID: <20250313055657.ddrzqo2edx46az7b@thinkpad>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <174048982895.1892984.13694169241426640158.robh@kernel.org>
 <f718ae90-237c-634a-111d-05f2f0240db9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f718ae90-237c-634a-111d-05f2f0240db9@oss.qualcomm.com>

On Fri, Feb 28, 2025 at 04:26:23AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/25/2025 6:53 PM, Rob Herring (Arm) wrote:
> > 
> > On Tue, 25 Feb 2025 15:03:58 +0530, Krishna Chaitanya Chundru wrote:
> > > From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > 
> > > Add a device tree binding for the Toshiba TC956x PCIe switch, which
> > > provides an Ethernet MAC integrated to the 3rd downstream port and two
> > > downstream PCIe ports.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > ---
> > >   .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
> > >   1 file changed, 178 insertions(+)
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Warning: Duplicate compatible "pciclass,0604" found in schemas matching "$id":
> > 	http://devicetree.org/schemas/pci/toshiba,tc956x.yaml#
> > 	http://devicetree.org/schemas/pci/pci-pci-bridge.yaml#
> Hi Rob,
> 
> As we want to refernce pci-pci-bridge.yaml which is expecting compatible
> as "pciclass,0604", we modified the compatible as "pci1179,0623",
> "pciclass,0604". Now adding pciclass0604 is giving this warning. can you
> suggest correct way to represent this.
> 

I think the PCI-PCI bridge compatible should be part of the actual bridge nodes
inside the switch. I still stand by my view that the bridge compatible doesn't
make sense for the top level switch node as this switch is a sort of MFD.

So you should do:

	pcie@0,0 {
		compatible = "pci1179,0623";
		reg = <0x10000 0x0 0x0 0x0 0x0>;
		...

		pcie@1,0 {
			compatible = "pciclass,0604";
			reg = <0x20800 0x0 0x0 0x0 0x0>;
			...
		};
	};


- Mani

-- 
மணிவண்ணன் சதாசிவம்

