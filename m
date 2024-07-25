Return-Path: <linux-kernel+bounces-261783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D093BC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB893286130
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60E1CD29;
	Thu, 25 Jul 2024 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEAVhneD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C871C694
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885635; cv=none; b=Cb9bom4/Tza8QHM6naVAXWBvBEByexjDkjiYWEFvY3ci2RF3mtQq7iiOVK7zDMQ8j4FRE/OfSCUhMcU8W9SZHpEijE0WrO4I3lpnstLYnnSnFj+1XA4OzVbM7iXWqzryY6sFgEM9+IbudyvRyBI0EQ8ZTVW5ovNw5xMF0qJWkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885635; c=relaxed/simple;
	bh=2tGfEYHwzW/wGfMKg0R45p2xryVYT+n7SGr2VPkgruw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7ZNwILUZd98gJhBHOq0CdaoPCNaRjlp1/GFf+nqUEq0crFLx5Skg5wWMkTrVLoaQoCKgUXa4pvbPf9kQ5fxBpju+ccBgUsj4cr3C6kIgdcnDkvtpxVo4dOcqBewh0Np/5kvgYGE26ByMfttsVwGCPNrnZjOF6Xhh3EzjhmB9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YEAVhneD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc566ac769so3921405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721885633; x=1722490433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WvP5xv6a5VWVYL+E3TZ2I1foLVXzeCPYT1zO1NeZJnc=;
        b=YEAVhneDK1ImT5x4ovFQlcTHpQZxZGz0hDAYSbXkTrPuHQSftcYsRehne9NAKa5sgi
         weuH3IouNNlV35CRTmW9WzRJyt11Lbb6MgeEYrf2S0/E+NgP4xhv2j0/Xw+c6MtkIS2O
         40PvKICQfwD0Q0015MfFbRU67C4gO2fqWLelLJug2bq9/cyBzOdkGkfMMiyv4Zh9Xc2q
         cIKtP26uEEQ/xQJLMHGufbEaxeDkBLh+h9CgWNS6Tom+C02TyNUg93WjtinoIFEYjY1A
         q/GdQ+fY6Y81RAYUKoLV6iwoYhLD/Ld7h/J0X3DFFtodYcsDwEBUDZjhbIWPtxKsFb/g
         FIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721885633; x=1722490433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvP5xv6a5VWVYL+E3TZ2I1foLVXzeCPYT1zO1NeZJnc=;
        b=VZHjk37BAmVHi5oMnUc0no5uA1CsYqrvx3GIRJBQ2BvZv1X+mMYO2/zPp+B67tAdcE
         XTG8+fEUz5GcMg+1NVZ9rRzKbjd4hwJvPW29HH1ha9GsuRosGawoMxy8XimbbqEyn6ld
         H5uPOQ6/2TeVOiVDHZGwZzEhV2XceLVkYqU2iOBP4qCZiA26ZDV0boethtwhTV6hLRQX
         pzQxm2qgEC5Ih0NrXk0eoECFyXwohez1shvwm6k+JaIR3yT053pw5Ndzid9WP4nMBMvb
         JKUHpwxMq+M6sNGc7+4fVy2rKyJLiT+GVWKPgqS7alq/TEb9R96PaLsS4OrhsXaNLvdr
         p7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo7PkjYlWsXP7uYY6G0XRp4cBJZyJEzn2vkWmZ9z0COGrC398kRKsV4axRFrSpDrAvy0BGTKjJkGFVnO6WL8N9difpNalz0jVHp0is
X-Gm-Message-State: AOJu0Yyv3uo3rv5BroCdhpWx9zPV1k8KXiKY6IEah+aPUhoS+SoR4+LK
	1NXhSQ/Fz+zKL+ouG2X+zK4qXUlFDCWiMYZsvTrv6Ho0g+GXb9jXeCWNLXHdNQ==
X-Google-Smtp-Source: AGHT+IG+Jz8QIIFB7Xv4Jj0Zdf+JcdD4DBAsUgPPRHwYyUzYcZicmU3kuQE8eB0QN6KEdH4/zv41pA==
X-Received: by 2002:a17:902:f68f:b0:1fd:a7a7:20b7 with SMTP id d9443c01a7336-1fed389fd3dmr24712335ad.30.1721885633089;
        Wed, 24 Jul 2024 22:33:53 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm4984275ad.237.2024.07.24.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 22:33:52 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:03:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <20240725053348.GN2317@thinkpad>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zp/e2+NanHRNVfRJ@x1-carbon.lan>

On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> Hello Rick,
> 
> On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> > >
> > > But like you suggested in the other mail, the right thing is to merge
> > > alloc_space() and set_bar() anyway. (Basically instead of where EPF drivers
> > > currently call set_bar(), the should call alloc_and_set_bar() (or whatever)
> > > instead.)
> > >
> > 
> > Yes, if we merge both, the code will need to be in the EPC code
> > (because of the set_bar), and then the pci_epf_alloc_space (if needed)
> > would be called internally in the EPC code and not in the endpoint
> > function code.
> > 
> > The only downside, as I said in my other mail, is the very niche case
> > where the contents of a BAR should be moved and remain unchanged when
> > rebinding a given endpoint function from one controller to another.
> > But this is not expected in any endpoint function currently, and with
> > the new changes, the endpoint could simply copy the BAR contents to a
> > local buffer and then set the contents in the BAR of the new
> > controller.
> > Anyways, probably no one is moving live functions between controllers,
> > and if needed it still can be done, so no problem here...
> 
> I think we need to wait for Mani's opinion, but I've never heard of anyone
> doing so, and I agree with your suggested feature to copy the BAR contents
> in case anyone actually changes the backing EPC controller to an EPF.
> (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> 

Hi Rick/Niklas,

TBH, I don't think currently we have an usecase for remapping the EPC to EPF. So
we do not need to worry until the actual requirement comes.

But I really like combining alloc() and set_bar() APIs. Something I wanted to do
for so long but never got around to it. We can use the API name something like
pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we need to
have it to align with existing APIs.

And regarding the implementation, the use of fixed address for BAR is not new.
If you look into the pci-epf-mhi.c driver, you can see that I use a fixed BAR0
location that is derived from the controller DT node (MMIO region).

But I was thinking of moving this region to EPF node once we add DT support for
EPF driver. Because, there can be many EPFs in a single endpoint and each can
have upto 6 BARs. We cannot really describe each resource in the controller DT
node.

Given that you really have a usecase now for multiple BARs, I think it is best
if we can add DT support for the EPF drivers and describe the BAR resources in
each EPF node. With that, we can hide all the resource allocation within the EPC
core without exposing any flag to the EPF drivers.

So if the EPF node has a fixed location for BAR and defined in DT, then the new
API pci_epf_alloc_set_bar() API will use that address and configure it
accordingly. If not, it will just call pci_epf_alloc_space() internally to
allocate the memory from coherent region and use it.

Wdyt?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

