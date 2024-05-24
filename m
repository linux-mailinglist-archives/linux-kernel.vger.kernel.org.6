Return-Path: <linux-kernel+bounces-188780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C488CE6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED47281ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F61A12C483;
	Fri, 24 May 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z4O9HmfJ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E912BF39
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560111; cv=none; b=T0n/yvkPhbX/VWfsI/oocdx3WYmh5EqQ6dlw2CCwUzHgPNVPKDScmB7MAFO1/dnYM7zOMdy7hz576PKD6maOR6fwa88JJzks+3RcOL5mfx/NBg0RfAs7sjFfkXRsgjI0OFVJWb6cn2STLSb521OAArYMpxbqr+UzISl44uxzYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560111; c=relaxed/simple;
	bh=Xks612s/7rT6Q6ukp30bszt+1cZ8l1ePIW1QRk5v5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIbnJSnzZJx/QCPLPw0pQbpsqHWACKE+s+dq/Off06WryZ5MkIQ9eZVzdKs+6Knn8TDoX7FKBxvZhCjz3j5bFKK3plOa+5sWKmsB1wkbluedDyXauO2vgSRyXThxOyIX3osJrC+k6jmCMp0rFlzgNGB8rzBrPtUn0pXKvusVrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z4O9HmfJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ab9d01c479so4551896d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560108; x=1717164908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=Z4O9HmfJAyLs8AKSAar3Mk5yc6fTi61i4Tyh0u49fTmuPdGPGa3gjfOeHY9Z9f43dT
         ypMsblj33z3xR1NU1zBLwVmcz06JQTsQRNmos+CVVPXwXof4J17yi61VlYRa/BQF+kPd
         DCj21Sffp+XWSs0cT9TtnIH9GI6ZohnjP+2p+i50hYa77sIJoELz5IQbp1fndRXFXmlT
         BOz4DNGt1UaTxm0Un01AUceMRNo+FDc6vZ6zMRZZsf6+oDYQNnbQXO0Tdmcid3xspsXz
         GOQbgP/Jjr+dcB+q9PlGPzp26C7HVBrroA0oYuszHsPiuK91C8k/iYKOL/DzBXjxczkt
         4W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560108; x=1717164908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=wUqLWSsgmsZNgnGgpDAgysh7q8QQrYDN0ETTUKdP71S/VEsueZZ7RmtH0tNu2r1S9N
         1pWPKznow9H0kPomViVumBrkF3JfEblEA1UDKS4IAAgYqL+co/K/OImioE6/+Dc67bEM
         MjqvfGqLTvcg5mFDylrerbXLQLOJ/VrjIBjTntKp4nfSOiRscKNJ1eqtJF2mb+bkwgR9
         dkz0pKbd/gYveIiWsCjz6WcTf1i3uyVQ6h7z1aG4qWoUMdaWhZBCPkU5KYDSWrxfuVw/
         nveuzMj9LG+z04tLbx+NbSbrAHy8Vy5UFjP9sJcEpZuqQHnokvXOLvCsL9XyVLHh/qtI
         EUcA==
X-Forwarded-Encrypted: i=1; AJvYcCXBX6LqfTBjJUPpu+JOxO7UyS6/zic3x6gaO+EB6avq1hmPNfafGkOvl5WsktUNdLN5KaxEREGYrktSjuktfbFp8gafVMvT53e6xVLS
X-Gm-Message-State: AOJu0YyqM0IJ02Np0W+JnzupO+v0OLH69GTqdd4I58yJ3GaWsfMJJji0
	+PvDDAZDSk9q5/Z3npi6bBSNB23mpDJyf85zI1jlm5s3K3AG+k21j0DwEy/RgHc=
X-Google-Smtp-Source: AGHT+IH6Ac9WsdsUZJ58JI8yWFb4+VExingKf2US7XYudAGfc/E7XKaMftG4JYXDj6Yn+MrOVUjI+A==
X-Received: by 2002:a05:6214:4981:b0:6aa:3dc9:4b2 with SMTP id 6a1803df08f44-6abbbca5e8amr26530426d6.5.1716560108113;
        Fri, 24 May 2024 07:15:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac071048a3sm7543566d6.69.2024.05.24.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:15:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVhK-001JcU-UZ;
	Fri, 24 May 2024 11:15:06 -0300
Date: Fri, 24 May 2024 11:15:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Message-ID: <20240524141506.GN69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
 <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 04:59:18AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 11:33 AM
> > 
> > On 5/20/24 11:24 AM, Tian, Kevin wrote:
> > >> From: Baolu Lu <baolu.lu@linux.intel.com>
> > >> Sent: Sunday, May 19, 2024 10:38 PM
> > >>
> > >> On 2024/5/15 15:43, Tian, Kevin wrote:
> > >>>> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >>>> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>>>
> > >>>> + * @length: a hint of how much data the requestor is expecting to
> > fetch.
> > >> For
> > >>>> + *          example, if the PRI initiator knows it is going to do a 10MB
> > >>>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> > >>>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> > >>>
> > >>> This is not clear to me and I don't remember PCIe spec defines such
> > >>> mechanism.
> > >>
> > >> This came up in a previous discussion. While it's not currently part of
> > >
> > > Can you provide a link to that discussion?
> > 
> > https://lore.kernel.org/linux-iommu/20240322170410.GH66976@ziepe.ca/
> > 
> 
> We can always extend uAPI for new usages, e.g. having a new flag
> bit to indicate the additional filed for carrying the number of pages.
> But requiring the user to handle non-zero length now (though trivial)
> is unnecessary burden.

It is tricky to extend this stuff since it comes out in read().. We'd
have to have userspace negotiate a new format most likely.

> Do we want the response message to also carry a length field i.e.
> allowing the user to partially fix the fault? 

No, the device will discover this when it gets another fault  :)

Jason

