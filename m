Return-Path: <linux-kernel+bounces-256516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC7934F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927181F24A60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5306142E88;
	Thu, 18 Jul 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j90GKrsb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B113FD8C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314872; cv=none; b=HfEsgemcqB1c4j+yVtBOqD5sd4wPvNZAVyFSJyrSIxh40+7TVTjYlnvNXE04oMyZJUVACIpMdb3Ju8aYz/v6H5d0Ac12gLaDLsjjRSd+xZFJQXjd7wApCwRJMSLsx2R+rs9vFBFOslMTZn/B/DJ48zXo0u5OVpU636vpzddzzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314872; c=relaxed/simple;
	bh=j7gUtYNVRN87Ci9I68Ml7RQwp1MzuEKvOHlCXU6fcL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3J2eEkNM55I9uMOTIYZb+ael3vGlWXi+Art+YZQMN3mrZPhEcpIWakVSUyFDnJQ8euL1LkH3n5te3GrpxG8ZYrz8lfMBn0SHrn8/TyiUhtY1YvBEYkFeVbRXWeU6xIq8hAJbo51ORy5ZkHsFC5pfDZVHvvOFkptOqS4CmTfgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j90GKrsb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb05b0be01so6183275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721314871; x=1721919671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSVGewa3tgM4oW6A4Bb4GUZUrikJhKxdwIPrTqhOIpY=;
        b=j90GKrsbWPnZE4Ez/ZOwNXMVJjkfhIDxscD35SiJcheNgPFKrJouoEh97DSpjLbai9
         QZluB+10e8kMtNoUWBewD0HrDm4ld2oW8Cfszmvd9PLD/NWB6L/NOduBe+/z+T+SmpQ5
         1rxVefz/l99uJYdOt9kmvlpZe3Qo/TaxIqCbvhACf0az4Vicx5ziLl0d9Dx6HlifoCFN
         Wg5pqXcrcXW+owiOpSYeeclIX/eiv653OZnSdUKSEFNX3wru/Z75lSQJhjYPhA+XLdeR
         t5oy8zFM20TKXtM3g0o9AJxMRrbjuZ3FZ9q3MkY+2S333sojAarnbWf9Im5Cu3TcLcLt
         dXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314871; x=1721919671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSVGewa3tgM4oW6A4Bb4GUZUrikJhKxdwIPrTqhOIpY=;
        b=ZgY0+ug7oKHNqQVmePkBu3pQfC0v0yCqrbIlBHu0s3G0ZAnI4jxfsrK+Fp+PkDqH7L
         8S9Khf2yUqiFA1nxe/45vXekkCqc9TPa/qDxSzRDb0VhBCK7ueY9YxwWJRLKRfXOBHH6
         EKoUw7yZ2hSx5GU6VEAZazhQR6zRdVEvrUeuEKkTP1bx4u+aKPv8ORS/6GlBVBH/KnsB
         kDssmZmjiPBcFYyDvpkOd/LrkD8D1XwyV+Q0xRhdzzjDz4IoEtN+7WrFGYNRgRbye4AO
         FQeRg6EneyFKeV1dRFUXy5DqnSCZU4F1eQHyo8xsY8xq/Jkq2U/cCYD8RUpPJORSP7PO
         WJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWXMy9lN+Tg2r0ZgDmjIHZvuRAeGthBdHFu8qgCO9EkxOHMcYPVPqHm3rvp4ikyD09TlW6VftQfcurnxd5/9JT1G/LlaYNA9xfK2p
X-Gm-Message-State: AOJu0Yxd5x0XxCZPfmPubakpdvPMlUIe1PZUn2cKKmgUXxcwgOL6Q++B
	4adbShcVT9D5CX+wIbPLNzxw5wgf93HAK0iSub1M5zUPqxzZJ/+0xFwo77U/Qg==
X-Google-Smtp-Source: AGHT+IF7oyHGMF2cBMndvGXmF7zw/i/p2gQTV4ozRfdo6HZZBZIVgLkO4gynCROlpiV1RqdpN2IC5A==
X-Received: by 2002:a17:902:e805:b0:1fb:95c6:8408 with SMTP id d9443c01a7336-1fc4e818b6bmr49991805ad.61.1721314870603;
        Thu, 18 Jul 2024 08:01:10 -0700 (PDT)
Received: from thinkpad ([120.56.207.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb73f45sm94582935ad.13.2024.07.18.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:01:10 -0700 (PDT)
Date: Thu, 18 Jul 2024 20:31:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <20240718150103.GA2499@thinkpad>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>
 <8b6cd895-8904-4d8c-bf23-5d933f476d57@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b6cd895-8904-4d8c-bf23-5d933f476d57@linaro.org>

On Thu, Jul 18, 2024 at 02:11:00PM +0200, Konrad Dybcio wrote:
> On 17.07.2024 7:03 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
> > PCI endpoint controllers. But this domain number could be useful to the EPC
> > drivers to uniquely identify each controller based on the hardware instance
> > when there are multiple ones present in an SoC (even multiple RC/EP).
> > 
> > So let's make use of the existing pci_bus_find_domain_nr() API to allocate
> > domain numbers based on either Devicetree (linux,pci-domain) property or
> > dynamic domain number allocation scheme.
> > 
> > It should be noted that the domain number allocated by this API will be
> > based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
> > property is present, then the domain number represents the actual hardware
> > instance of the PCI endpoint controller. If not, then the domain number
> > will be allocated based on the PCI EP/RC controller probe order.
> > 
> > If the architecture doesn't support CONFIG_PCI_DOMAINS_GENERIC (rare), then
> > currently a warning is thrown to indicate that the architecture specific
> > implementation is needed.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 10 ++++++++++
> >  include/linux/pci-epc.h             |  2 ++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 84309dfe0c68..7fa81b91e762 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -838,6 +838,9 @@ void pci_epc_destroy(struct pci_epc *epc)
> >  {
> >  	pci_ep_cfs_remove_epc_group(epc->group);
> >  	device_unregister(&epc->dev);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> > +		pci_bus_release_domain_nr(NULL, &epc->dev);	
> 
> Shouldn't this be called before device_unregister? pci/remove.c
> does that (via pci_remove_bus() in pci_remove_root_bus())
> 

No, the release should follow the allocation order in __pci_epc_create. As per
that, pci_bus_release_domain_nr() should come last.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

