Return-Path: <linux-kernel+bounces-394876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7349BB536
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B99A282C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C311B85CB;
	Mon,  4 Nov 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yw0Sp+2m"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4D1B3921
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725214; cv=none; b=tmqaz4o2bQE6jt95l0YHEKx+tliupE82vc/ndKS4q7aoum8Ry56t1r4hbSXqUsDVUsVliivPyFdc9ynBEroLh6rYOOxIS7PTknDuJ+jvsxVcSqRx83s9AJ+mCvpY3O8j9Njt4iS+WbNWVGygQm9h22qav3bOG1EmgvqkmrTJfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725214; c=relaxed/simple;
	bh=L+EGisSPUD9tN9fyrt+Fm/ZTB69LOdQhO31vrdXZvlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXMTAwGv/VTGhsRAmr1JjomkhIocDB2opttiGFPNjVpx0OlDXC5mmIW25/HAwv8I1mYBeNvCMi4A9Yiwr+mf14Wz5znvIa/XZgxENL/wQJLtamt/5IEY26wWjtD71aAtIFD2vIqaaWkIEUq4hbhPDV979odLk1UnBqa+vHRoDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yw0Sp+2m; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e60966297fso1935473b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730725212; x=1731330012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D85xQiYplOl/lLwSIlNTX6yVoYLo3NvP+w7RapkdIR0=;
        b=Yw0Sp+2m2ml+KHuSoNYNnL2+L0UIzPQx2Dw2N5tI39n1uokltHstv8Y/pF5DQeoKeE
         3rGm5F/gteozJdcwH4F+xbLQvZxbtV5EkWEZv2Axi8FXe/JWm1/0g98gxGbRk8HEDFAd
         CK9K8fZe9HUTULyPoHyDqpPnQFUbQ+jvwYt5NnZkh2P7us+LTfyUlUiF6+ph3rqASUwY
         Mu9lB8fiSqJtTeeh/0bTZXMy/BnpV2LjDp9yJRCoY+Ir+7sr66vH+YtEZhkx76u9ULhN
         oIQqRD8Xcej3fICYADRFO/ZZFp4qOyUoEvgxneWNjWKiRIZ4iYdN8FGAcypUqupfhBsl
         NBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725212; x=1731330012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D85xQiYplOl/lLwSIlNTX6yVoYLo3NvP+w7RapkdIR0=;
        b=w2Y+9IkGoL91Wed3JeIeGkrUA7gARwOluGY8t9sVihJOeNN06IPDn/epjKlN5c6sLF
         RJC15A11mkIpM9ravDkFyPAl6IOMYvpKc0NZNqNAhc+BVW0VE9r5KWFHO9KQ/hCTBKaj
         /1TxOkWLIXhBy1yI9Nl3VgYdLWxmVnqzctm2y/346vbneE5AtZNR9PpXT5On1s6ZDwiQ
         hXQIacq2UIrOCFxugNxkj50M4hrMk9tGEaP8ZmZomkmHbfmGROu0ADAzQXWlIR2SJjsZ
         i85rr8t1Kedw/3nn7J3rOQn1QtJOjZbwre69GUt6Rhi22aHTWiCaZF2F68kGcLAq4IeM
         Wvzw==
X-Forwarded-Encrypted: i=1; AJvYcCVXlcFEun3bVcLG/W5CpjQh444eQ85BSmLF/0VHlpH9oQ1jX8dEaW7nHAbvXiBPePT+jXsyAFg8XjDFGSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWacoKm3LwsmCK/jI3uD2ESVszBk+ZkuGVUdAtEWWB/6z5NyB
	e3oLFJivYdWL3Csf2uvPBkpXOHsRzAp8Nn/tBAGS99/rkiGHxR9az+ukWMrEIVw=
X-Google-Smtp-Source: AGHT+IEsOehBbhKvtzVymOA1MjhlkfmyQrOqjHBJ9OIDfFQs9tk2WoBgYZ3/d/FwxGd/eC4Y/sN09g==
X-Received: by 2002:a05:6808:23c9:b0:3e5:dba3:2480 with SMTP id 5614622812f47-3e758c5a8a2mr9460367b6e.15.1730725212293;
        Mon, 04 Nov 2024 05:00:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fef918sm47647116d6.73.2024.11.04.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:00:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7wgl-00000000hTj-0A8B;
	Mon, 04 Nov 2024 09:00:11 -0400
Date: Mon, 4 Nov 2024 09:00:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241104130011.GD35848@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241016152047.2a604f08@DESKTOP-0403QTC.>
 <20241028090311.54bc537f@DESKTOP-0403QTC.>
 <1f50020d9bd74ab8315cec473d3e6285d0fc8259.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f50020d9bd74ab8315cec473d3e6285d0fc8259.camel@amazon.com>

On Sat, Nov 02, 2024 at 10:22:54AM +0000, Gowans, James wrote:

> Yes, I think the guidance was to bind a device to iommufd in noiommu
> mode. It does seem a bit weird to use iommufd with noiommu, but we
> agreed it's the best/simplest way to get the functionality. 

noiommu should still have an ioas and still have kernel managed page
pinning.

My remark to bring it to iommufd was to also make it a fully
architected feature and stop relying on mprotect and /proc/ tricks.

> Then as you suggest below the IOMMUFD_OBJ_DEVICE would be serialised
> too in some way, probably by iommufd telling the PCI layer that this
> device must be persistent and hence not to re-probe it on kexec.

Presumably VFIO would be doing some/most of this part since it is the
driver that will be binding?

> It's all a bit hand wavy at the moment, but something along those lines
> probably makes sense. I need to work on rev2 of this RFC as per Jason's
> feedback in the other thread. Rev2 will make the restore path more
> userspace driven, with fresh iommufd and pgtables objects being created
> and then atomically swapped over too. I'll also get the PCI layer
> involved with rev2. Once that's out (it'll be a few weeks as I'm on
> leave) then let's take a look at how the noiommu device persistence case
> would fit in.

In a certain sense it would be nice to see the noiommu flow as it
breaks apart the problem into the first dependency:

 How to get the device handed across the kexec and safely land back in
 VFIO, and only VFIO's hands.

Preserving the iommu HW configuration is an incremental step built on
that base line.

Also, FWIW, this needs to follow good open source practices - we need
an open userspace for the feature and the kernel stuff should be
merged in a logical order.

Jason

