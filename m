Return-Path: <linux-kernel+bounces-289732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735A2954B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E7F284157
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C311B86DE;
	Fri, 16 Aug 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cUNVVc/g"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76938F91
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815163; cv=none; b=dksKaxGH4dhC4igMglTl10/rEd4uGO3q3OKJ6V7DsMMV9WF5vZbvATI1nZzxbWCH3BaqS95KQgSDtzkYK4WzwLuvPs2Mx+dOvUkfXxlLn1kxB6IleEKqTnwdAtDPdYcevBtWu2IV0iI9VyMh8pSnbInmPHyABIvvmf0zg+3W1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815163; c=relaxed/simple;
	bh=qcTAVK6EItOoSO1Q3tgK65Y7zRc5MBErrU82rC1VqJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxZu5EfDtA9YkVsF6tL/EDT6Yihj4mwFJKujFNRzW/G7eDZpeEwWofwReqsE3vcWJP/DXGMZlqYHTCRpRB8af+0pZ8sJLkWGCrdmkBR5lAG/LV+0AilpcjpSNqv4HTzyKviRvfp+eDEfGr4yGT5qurhH2b3UEq0bBTITJPFsCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cUNVVc/g; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf6beda0c0so11552096d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723815161; x=1724419961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcNVKD9ArkalzemGS28H2A8RRoS7UHu4ogyyEqaz7QQ=;
        b=cUNVVc/gDMbWlxUG+oWYRWN361eb91ZyinCcJPMZLEn2ctsz+ThSzkcTSV3jwy6byh
         8ye73/ow4htzyxw4fdHFqnqGb2ROgi/LVnoh6aqBE6D2JYR3mFD9b51dA+UHAAxJ7O5b
         kV6zR4evefMQTs9JEQFOWZf75H5kegTRsf9H77woGu9a1Q/Jb/4hpqzeTDX7Ze8mUCzN
         gzZc0BjOYj17vcyxcwy4pa+OXLyZaB/1wE6IaAWK1ABQVDhDah06EQ8lNsXr2yA824iA
         njk8sn2ErAbdNa9v9JVtNNsWGSo+mkHX1lLUWb8yRKtfZokF9xrFdPFIdmHR3SSZk/kM
         Fowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815161; x=1724419961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcNVKD9ArkalzemGS28H2A8RRoS7UHu4ogyyEqaz7QQ=;
        b=SL4y0oLErdnfPHYggDX3QyzfQNlelQf2wSBXSwXxgOkn/t8uADtZlg72/NC6wlevn4
         4keQ7w0Lcyeb6Fo4cNNMNMz0D1/TIKpBE1nWdLx9nxtiZqcKvXHWwn/5bp58Ym58ngNz
         9GTqoMzwAgwi6/TSthadq55MlXIdkUR25StTiXis39kimAxKB4PzlnfJs+pjN8Ie/58O
         RVsATKKfjvNg+1THauebAMPZR1OH7emIIYlgkSUWsuCQ3mM/hywROFiPK14q0M6j5qIR
         B8gBN6sSMUV3hK1bKODhggoH5y2ZQU3EWGnR3YJvv5Tqkbf9kM1bjiTsJKke5Wt7Qlgi
         sTsA==
X-Forwarded-Encrypted: i=1; AJvYcCXV98JIxrUopJlt6wrl6OTgfvGQiBG/v/agktggvLwsCG9zbpvs2fW8jBBY86wOsrUnceNSY30A3Ezipkvt4Fq+lNroKKi7GR3MAQyU
X-Gm-Message-State: AOJu0YwbE0uC4nii30Wz0F7thB5/isnbfQfXfSuKO6IzItW+yQi3npWq
	xH1Hud8n4cQhi0axlZLRanmR1YSNKkkN7eNEBkL17T1tOGnnxcEydmKXRPMI6lI=
X-Google-Smtp-Source: AGHT+IFWZiZFILtEO3eQGWudldVtkY+zYk/91TK19t9S7myPrK6cUMb0pkmDP2UYPZcLYzFykUvR3g==
X-Received: by 2002:a05:6214:4893:b0:6bd:6f1e:3303 with SMTP id 6a1803df08f44-6bf7cd9dff9mr33711496d6.13.1723815160843;
        Fri, 16 Aug 2024 06:32:40 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe2748csm17322026d6.63.2024.08.16.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:32:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sex3a-009kPY-NK;
	Fri, 16 Aug 2024 10:31:54 -0300
Date: Fri, 16 Aug 2024 10:31:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240816133154.GQ3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>

On Fri, Aug 16, 2024 at 09:09:04PM +0800, Baolu Lu wrote:
> On 2024/8/16 20:16, Vasant Hegde wrote:
> > On 8/16/2024 4:19 PM, Lu Baolu wrote:
> > > Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> > > attached to the device and disabled when the device transitions to block
> > > translation mode. This approach is inappropriate as PCI PASID is a device
> > > feature independent of the type of the attached domain.
> > Reading through other thread, I thought we want to enable both PASID and PRI in
> > device probe path. Did I miss something?
> 
> PRI is different. PRI should be enabled when the first iopf-capable
> domain is attached to device or its PASID, and disabled when the last
> such domain is detached.

+1

Jason

