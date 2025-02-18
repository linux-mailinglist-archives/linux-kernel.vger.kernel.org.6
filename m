Return-Path: <linux-kernel+bounces-520057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912ACA3A52A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D1A1885B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1717A309;
	Tue, 18 Feb 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEDDKPwm"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40D271293
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902650; cv=none; b=aqEjJhHhSQuv8IG8nRE8xTn6PBzCiT7b3BYMgYe1mXTAzY8ONR5zR/EqxFjSQF+EAoA3EnBlXyqW/M15k2v0TtT36poPZz+2b/DsCc6K3ilbPT7grfuMNhVtONnxsGKHsnMNjcxXrtXAffP41n7+7jWh+2JcQK7dA04ZvSPZj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902650; c=relaxed/simple;
	bh=BOUyx5EsWWjCZqwoILlVSGflf8blEnkgIikzItCUqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1GLD6yByPAJLDNi44sa/5EkTVQcXJ2auP4cFR0PzE6BFjALIzsRh41RiMfZKs5gt0/z3wsDcoC5s69bot9EWoh5p8fZVXtGgm/w4Rl1Hp6aanaOTy14hkfAeiNR06s8e+sbQmIl3b+5DzmULmy7MknCoTbCXDMzhJ3EaYCyWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEDDKPwm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e0575f5bso490435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902647; x=1740507447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=IEDDKPwmsCnXzgsxU9UFmcPy9nb+59LDcji7VEN+uObYIwhYLLVTegfR4cPukphh3i
         n26LIz5uFbOfM/CNOEVdgY4wc+WQR/0qKhZQKofkElSAsQrxpASu4a3Mm1l7JKF3mmDT
         s/NQ2BIxdDPNuCxdxg1g7iomKKMTBrPho1/0geaO1qyOtRU2lhMQTVJf+XvQLCh6bfJ+
         JLqpFqvteKZlzmUfHQ2FFM4npwJoSf3EFM93FUNU9T4II+4/eFE0eCPZF1+11hUGrKPK
         UcQkj1neNFdFBgJQfaNO635F4y3UqCvwiTx+nyUw2/RAme0lKoGug97pV1DZ7CuAWt8h
         Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902647; x=1740507447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M89M9SRzWTrfxkPQChi6cYghdfRxV0Kb26Fn5pPvW98=;
        b=nY6ry9zAebNqQIO4pstjVDSQ+kXd/brtkcQTRNBGvj4qJCxfr/jrYpInBr1DFbX4lu
         VWcX5ayxWlgju6EhhunBuJA+cDrZ0zOAOcyxYEHayGgl5VoVwpt4JKvdtJ5xVCNsGAAe
         v6lxP/KaBO+rfBVJ80OMtVk9FcRO9oQ6dgqINCarFtyQX0QejGpXugmDMD/gKJBghYY6
         phXbQHyRULbAkPTdLQDJIeEKMsm0EjdMhFurkJQAC6esOTKMH1VdXF2tuizwcyDVpNYH
         8PzzRZgBf2hUimtc+ADIFRqtuKeZWSVeN+6kx/sIw9y0vEL8g3kJRL7x2qBqD120YGOL
         CmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLBSWRLq73XrvAxawfzbAHSUN9clCfnrvFzNrWY/E2QRyLrA+jNHkoq5bWdj96hWY/PWD/p7Q4ol5Euc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rb5sWWTSr5NyG7NqUtBwRBzSUL4hdKyDBOgGrnMMwEgDO8dv
	9NepZkGj/G089YOwIifqOwmQ6K/XfdsyTHHau8kizg92VC43OaDuQ6pR49oEyw==
X-Gm-Gg: ASbGncvynfEz5n250LQVlfXnPjtIqGz2Gbj9zZ1sOgRRi8dRHIIuOfoKHQXM0yy9YYP
	xfQiC6a7GqrWHO3PsfTZr9dmFUbGCdLmtBrJ4A+ZP8zFlSUF786E4usRt5uf3YR/1OnOSov+GZR
	h8rFdbuI9GXFtgzI3bUcuQkiczWGA+7cgC76MvHEFe0WlzjXj8x5xqwEYV0YjL8KU4dN6jw6rcD
	n12p6r2tkIDRqEZ4QC8xD8R0TSgNE2YmDrTUwpWUFLTnfP2k6tYH4TksghG2AAwDWdb4b9Il5ZV
	ld13AHJjapIxRDKjR/lROvnP6P3yfnBO5Emv4fvCCD1WCg7/v+xE
X-Google-Smtp-Source: AGHT+IFkiHL5TTpaBclB/MgmM3kcQbDHYVWCGmPRDpeRclWjC4Poa8aWW8CJbN/ySGXple0OccOeRQ==
X-Received: by 2002:a17:902:fc4e:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-22104c939afmr7012905ad.16.1739902646969;
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55960ecsm91516115ad.253.2025.02.18.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:17:26 -0800 (PST)
Date: Tue, 18 Feb 2025 18:17:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7TOq-gIGPY_ztW7@google.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Feb 18, 2025 at 05:24:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, January 25, 2025 8:31 AM
> > 
> > There is a DoS concern on the shared hardware event queue among devices
> > passed through to VMs, that too many translation failures that belong to
> > VMs could overflow the shared hardware event queue if those VMs or their
> > VMMs don't handle/recover the devices properly.
> 
> This statement is not specific to the nested configuration.
> 
> > 
> > The MEV bit in the STE allows to configure the SMMU HW to merge similar
> > event records, though there is no guarantee. Set it in a nested STE for
> > DoS mitigations.
> 
> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

MEV is available at all times (if an implemented by the HW) and doesn't
depend on the nested mode. As per the Arm SMMUv3 spec (section 3.5.5):

Events can be merged where all of the following conditions are upheld:
 - The event types and all fields are identical, except fields explicitly
indicated in section 7.3 Event records.

 - If present, the Stall field is 0. Stall fault records are not merged.

I'm not sure to what extent, but I think *trying* to merge similar event
should reduce some chances of overflowing the hw eventq.

> Is MEV available only in nested mode? Otherwise it perhaps makes
> sense to turn it on in all configurations in IOMMUFD paths...

I think the arm-smmu-v3's iommufd implementation only supports nested
which could be the reason.

Thanks,
Praan

