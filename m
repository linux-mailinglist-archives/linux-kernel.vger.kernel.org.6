Return-Path: <linux-kernel+bounces-276605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F209495F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0573A1C22F12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6C4F8BB;
	Tue,  6 Aug 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JkRd0Udn"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B255339D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963270; cv=none; b=Uj1et9cDgMKNaLBXTLBcA9rer6PGkok8FgLdPy7gablbRsy5uGYIIlGnk4GHpA1mXyxXuUqAmA8DDLTfziqMYeFy2VsCYJa3FE8avHO4RN2InPBA4igCYBcKZqefWf7JG1dLtSiqp0ZG3PjigyXE6zqQQnHlE2xCUlhDMd/5Vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963270; c=relaxed/simple;
	bh=wYfaWsh6Sn8wwLS9gnk0eyrAgYMx+qgcYiLYh20Su9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTRmBnsjj2EfxBG/YtUkXCn15mSLkRqp82yHhvaLLyAjWmYSM5JVw1nvkc63wuI3zx1PPOgCSdHX9TJmNiTh9/TwgAjc9zoJupSKfhRj2Dt027+4vZKOFJZrZzlIj8HBfmTC++dmCzC8erUjjs0pQUJ8evTreKoIdzCOqzhEP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JkRd0Udn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so4569236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722963267; x=1723568067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAtE3NrwvMQADtEx9/Wu95vxDu4saq6pM1UUIbdCnAA=;
        b=JkRd0Udn3X2xJUkLsxwIorLonu3ZMIl/0TYFKuxPgBo/js9wilkGTpHxMiba3YTkel
         p101R+TOH4m+hJ0lvwiftl0t9hlSKU2oNShCKkiCeeL+yN4+OJjgssvfmKhHmgG2kShj
         et+UWo4F1V0RAKyzOjTaobhi3JbFsU9+pTXMvfxmAAh8Cc9j9kQNlYFbSMwgf7BVFhkH
         AUO+9/m9dEIPEReEWxAUxRAkACCQr/N/CNzOleVWlcPzy38VEVqbQIgEwnqb7A170YY2
         vLa0aKkBg3GFZ/0ingTZt/om4pCMhi9FtwtPdWyuqNvNElrE/YSa3ntalFeQX4U+2XoI
         PPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963267; x=1723568067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAtE3NrwvMQADtEx9/Wu95vxDu4saq6pM1UUIbdCnAA=;
        b=DweIGx8hhmhtWyeEl3M4AP60Nuqy4z0DdqziTI8atel1wRd0rH0fwwpkXujUt3D/Ez
         +ryk9wiv11f66rQ/CjZ6H+gXFx8fF6IUn+H864ZKjK2J+3Vn1l2jdh5sIQX2tfu/j7gB
         /48urf+aII4kDkJFn9wNs9cXqFf0gfmK+WH0dsOmGBP9KHRJkXPb0INf+iVhZH43LkXV
         O7c5LIXHN0H1SdpK5vj4nLsmnB0Imn6B/h7E5Zw34/vQKBsRWSYuX6Ma2vBKEaDdLBIj
         f7Hpz95F+C5EVtRqFExvUNyd+prUqw1W05V6mqW2k6v76uOwjBiPmaby+lFGGGdM3Jce
         9mcg==
X-Forwarded-Encrypted: i=1; AJvYcCX8t0xYK7jx0LPy3Fr9k1UsemOIVmcfwYBTWb80cvk8a19WUft03efnFofoC2QEjmI/jA+AWSXhdFXxCUqnOpjQz4x/45g1L15ZMM7N
X-Gm-Message-State: AOJu0YxluIDxlZf8epGAFGzJJtcBjeZcQLijrehUCd+zyA5UmuaV/kvk
	T/Hg0rj/sY8CF0bVbuWS9kSqf9cTpufYwdPVCxrHLlTyfD0JqjnID1cV9uiozDtfOY6trI9LeDZ
	e
X-Google-Smtp-Source: AGHT+IG7NmK09twXabrf/broQ0lPcxWf11duxdRdIzqDmUxQ0A445hpYQ9qMVh5SqopGRWRDeernQQ==
X-Received: by 2002:a05:6214:4586:b0:6b0:7d80:38b9 with SMTP id 6a1803df08f44-6bb983d0e04mr201635916d6.16.1722963266718;
        Tue, 06 Aug 2024 09:54:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87bb90sm48302166d6.130.2024.08.06.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNS5-00FQVe-PN;
	Tue, 06 Aug 2024 13:54:25 -0300
Date: Tue, 6 Aug 2024 13:54:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Message-ID: <20240806165425.GJ676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-2-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:35AM +0800, Lu Baolu wrote:
> The iommu core defines the def_domain_type callback to query the iommu
> driver about hardware capability and quirks. The iommu driver should
> declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
> capability.
> 
> Earlier VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a paging domain with all
> physical system memory addresses identically mapped to the same IOVA
> to simulate pass-through translation before the def_domain_type was
> introduced and it has been kept until now. It's time to adjust it now
> to make the Intel iommu driver follow the def_domain_type semantics.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

