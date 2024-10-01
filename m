Return-Path: <linux-kernel+bounces-345673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8098B915
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6731C21D06
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903E1A0AF7;
	Tue,  1 Oct 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v56ybqSL"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B51A08AB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777791; cv=none; b=IJAHXg41jf0Bh3T1aN8OU0nMShd0u+uZNC5JQ8qWqBvaMEyFoANzWN7eehRiL7dMz2/cvwvb55XWMvrS3VIEThJfOPHpiZhnDVS4fUSPugcJvnzHyaDWN2SRDgvoZFCpmfDYGJ6yKZ38jyK1osAffTrl7jVKEb9EY3jIDKNkZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777791; c=relaxed/simple;
	bh=SLtTu3IL6LDgby4y+6PpF+5CxE4Cp3ifpTj6cEABEYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG2v7AIO4UWLW8WcRjBHqni7mWA+hrXbjtlks2OV9pm2gB3STEceYh7MihCeAiGuUe5iYBGiH7iJl1s4C/wD3ZMVchJbfofT0BwQ2aEaEEugscxCaFiru+uBOZQGkr3L8Y1kUrBAvg6ytenlZUEbDCwxV/APoCs8mGGfZZS7S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v56ybqSL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e2855479so3799204b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727777789; x=1728382589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7xJfFb9OXfKCKyEf8rku/AUF7m8DFvn5lEQLXOiYm1s=;
        b=v56ybqSLpQL1RMBM3c2QOataNzX/HsLQBY8FeNTnLtSxywxO9mwcfTbCMeVV54qeea
         cbMBD7Mfa5+YGow+M/3ImltyoPdLbUQA6LwF8Mus6noU1rlHasI1sGsnnzYh5ALX6/y+
         k85DQiZ7CC+eZgdMYiX27h+0PNjLba0QzEd+Cfar81EZp5h1PPxKWuFLyjgoHpTLEOhi
         I7vY0kgaEgRRLnrRTZZ3xCtUYS1Ba787ZXdKlY6WZq7xjt3WPqGCQ71nqMEWU98KXb9i
         3xtNozkEZy4K6jILKvK8RvFczdx8NjOruUkqzLcyQB9WUMkkfKtR0If18pOwlchD2wtr
         AszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727777789; x=1728382589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xJfFb9OXfKCKyEf8rku/AUF7m8DFvn5lEQLXOiYm1s=;
        b=IXWx4VAfkZbDz3LT3tGV6eUGAkGTB3/H26bh8rMMZ0dZOJG9dK9w+7ux78xRILLOkZ
         BaxKVXZyNmCYmZzVd1juuq435SRuy0tWMwia0D/X4QVno/CYsJXarYX7gqgnB0ft+CiH
         0zzNmrKD0chl7R0NnKoLRd86K8CVXYNmYREjyyEJtIbvU7lTfvJaYq7w9hmZUj1z/ijB
         EmDwwFueDeALF9elkems9amXe03dqucZVv9sS2PdloZjdBpuuWyzuZqgrJlzbqbJTh5e
         4n7bVcYnRSb6aByn7mxhgAh5GBwp9kDUXnmJ57eOXWlv3bRB97JiJA8MQ0dOUWr20u32
         E/gw==
X-Forwarded-Encrypted: i=1; AJvYcCV8o/b7p9CwvFaLeG2YtFf2tFCAoXX+pefWrGHwIyW6KBB3zLXQ3tNJlcx/slGYCCsu3OGa5Xy60+x8ojw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/poLcFsjftsNGgHH79QTLYnNXBuf4elIa2XOyKPq5/XEqQdCa
	U0xnUlT4xMal+akK1NCj8wQA/qwclwK6hn/Kb8r2zH7H+asvZlW0XyCM3mIE/w==
X-Google-Smtp-Source: AGHT+IG906Y5WrfPvkSFRlwSRimFFyhVffR8lxQBd4ADp4oyVjxHKJ6izFGXe7OZDAtkNUW7jX74EA==
X-Received: by 2002:a05:6a21:164e:b0:1bd:2214:e92f with SMTP id adf61e73a8af0-1d4fa6a173emr20544864637.14.1727777789459;
        Tue, 01 Oct 2024 03:16:29 -0700 (PDT)
Received: from thinkpad ([36.255.17.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b2f73sm7965180a12.25.2024.10.01.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:16:29 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:46:22 +0530
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
Message-ID: <20241001101622.ys36slymgjbaz26q@thinkpad>
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
 <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com>
 <CAA8EJprsm5Tw=vFpmfEKL8fxS-S+aW+YR0byfyL=v78k75TGEw@mail.gmail.com>
 <3ad77846-b4a8-80ee-e9e1-d5cbf4add6d8@quicinc.com>
 <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
 <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com>
 <20240209075716.GA12035@thinkpad>
 <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>

On Fri, Feb 09, 2024 at 12:56:18PM +0200, Dmitry Baryshkov wrote:
> On Fri, 9 Feb 2024 at 09:57, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 09, 2024 at 12:58:15PM +0530, Krishna Chaitanya Chundru wrote:
> > >
> > >
> > > On 2/8/2024 8:49 PM, Dmitry Baryshkov wrote:
> > > > On Thu, 8 Feb 2024 at 16:58, Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > On 2/8/2024 12:21 PM, Dmitry Baryshkov wrote:
> > > > > > On Thu, 8 Feb 2024 at 08:14, Krishna Chaitanya Chundru
> > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
> > > > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > > > >
> > > > > > > > > Enable PCIe1 controller and its corresponding PHY nodes on
> > > > > > > > > qcs6490-rb3g2 platform.
> > > > > > > > >
> > > > > > > > > PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
> > > > > > > > > connected. For each endpoint a unique BDF will be assigned and should
> > > > > > > > > assign unique smmu id. So for each BDF add smmu id.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > > ---
> > > > > > > > >     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
> > > > > > > > >     1 file changed, 42 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > index 8bb7d13d85f6..0082a3399453 100644
> > > > > > > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
> > > > > > > > >            };
> > > > > > > > >     };
> > > > > > > > >
> > > > > > > > > +&pcie1 {
> > > > > > > > > +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > > > > > > > +
> > > > > > > > > +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> > > > > > > > > +       pinctrl-names = "default";
> > > > > > > > > +
> > > > > > > > > +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> > > > > > > > > +                   <0x100 &apps_smmu 0x1c81 0x1>,
> > > > > > > > > +                   <0x208 &apps_smmu 0x1c84 0x1>,
> > > > > > > > > +                   <0x210 &apps_smmu 0x1c85 0x1>,
> > > > > > > > > +                   <0x218 &apps_smmu 0x1c86 0x1>,
> > > > > > > > > +                   <0x300 &apps_smmu 0x1c87 0x1>,
> > > > > > > > > +                   <0x400 &apps_smmu 0x1c88 0x1>,
> > > > > > > > > +                   <0x500 &apps_smmu 0x1c89 0x1>,
> > > > > > > > > +                   <0x501 &apps_smmu 0x1c90 0x1>;
> > > > > > > >
> > > > > > > > Is the iommu-map really board specific?
> > > > > > > >
> > > > > > > The iommu-map for PCIe varies if PCIe switch is connected.
> > > > > > > For this platform a PCIe switch is connected and for that reason
> > > > > > > we need to define additional smmu ID's for each BDF.
> > > > > > >
> > > > > > > For that reason we defined here as these ID's are applicable only
> > > > > > > for this board.
> > > > > >
> > > > > > So, these IDs are the same for all boards, just being unused on
> > > > > > devices which have no bridges / switches connected to this PCIe host.
> > > > > > If this is correct, please move them to sc7280.dtsi.
> > > > > >
> > > > > Yes ID's will be same for all boards. we can move them sc7280.dtsi
> > > > > but the BDF to smmu mapping will be specific to this board only.
> > > > > if there is some other PCIe switch with different configuration is
> > > > > connected to different board of same variant in future again these
> > > > > mapping needs to updated.
> > > >
> > > > Could you possibly clarify this? Are they assigned one at a time
> > > > manually? Or is it somehow handled by the board's TZ code, which
> > > > assigns them sequentially to the known endpoints? And is it done via
> > > > probing the link or via some static configuration?
> > >
> > > There is no assignment of SID's in TZ for PCIe.
> > > PCIe controller has BDF to SID mapping table which we need to
> > > program with the iommu map table.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?h=v6.8-rc3#n997
> > >
> > > Based upon switch the BDF to SID table will change for example I had two
> > > switches with one switch has 2 PCIe ports and other has 3 ports one
> > > embedded port which supports multiple functions.
> > >
> > > For the first switch the BDF's are
> > >       - 0x000(root complex),
> > >       - 0x100(USP),
> > >       - 0x208(DSP 0),
> > >       - 0x210(DSP 1),
> > >       - 0x300(endpoint connected to DSP 0),
> > >       - 0x400( endpoint connected to DSP 1).
> > >
> > > For 2nd switch the BDF's are
> > >       - 0x000(root complex),
> > >       - 0x100(USP),
> > >       - 0x208(embeeded DSP 0),
> > >       - 0x210(DSP 1),
> > >       - 0x218 (DSP 2),
> > >       - 0x300(embedded endpoint function 0),
> > >       - 0x301 (embedded endpoint function 1)
> > >       - 0x400( endpoint connected to DSP 1)
> > >       - 0x500(endpoint connected to DSP2).
> > >
> > > For these two switches we need different BDF to SID table so for that
> > > reason we are keeping iommu map here as this is specific to this board.
> > >
> >
> > I don't understand why the SID table has to change between PCIe devices. The SID
> > mapping should be part of the SoC dtsi, where a single SID would be defined for
> > the devices under a bus. And all the devices under the bus have to use the same
> > SID.
> 
> This sounds like a sane default, indeed. Nevertheless, I see a point
> in having per-device-SID assignment. This increases isolation and can
> potentially prevent security issues. However in such case SID
> assignment should be handled in some automagic way. In other words,
> there must be no need to duplicate the topology of the PCIe bus in the
> iommu-maps property.
> 

Agree with you on this. This is what I suggested some time back to have the
logic in the SMMU/PCIe drivers to assign SIDs dynamically. Unfortunately, it is
not a trivial work and it requires a broader discussion with the community.

Also starting with SMMUv3, there are practically no limitations in SIDs and
each device should get a unique SID by default.

So I got convinced that we can have these static mappings in the DT *atm* for
non SMMUv3 based hardwares and at the same time let the discussion happen with
the community. But this static mapping solution is just an interim one and won't
scale if more devices are added to the topology.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

