Return-Path: <linux-kernel+bounces-539270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B2A4A2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14E51724AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A281F0981;
	Fri, 28 Feb 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ah1S86zq"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC927702E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771146; cv=none; b=PolfjBGErfwEr+A2RUz+oy3jdoPMbcqbO7myLes4QsYux4EKSAqT2saZIgVr5B27G299gVnr+ggHUfBYJzFGvQ2b69jVRUF5HV6+mUMszXqQtOEsI5LKZCslxexyT5uY6f6pNBlzv5A8yeiCovlfsG0kte/Q7EwaSkhc4g0uDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771146; c=relaxed/simple;
	bh=sUQoD/oUM2YIJUykZgTKKV8h/csrykSBi4575KKh/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksr8+gsS0g054bJB+rfpOBBgQddibnTLa/VcMGUf6SvIDslnWrM1h4nKmrn//6qd+G9jWMdLZWmY14xoLcKj2hMVYbMOI1OOeHvH3BwqsIagLgbr0bC8LSveFeSzP8fgdBy3GwEL5t8yKew81X2B3MQzQtYryhdYNd1VoBsCRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ah1S86zq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be8f28172dso188909485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740771143; x=1741375943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8ahLP6tau5z9zFvNaThnA7Wz1kGZZr7teXmDUhSLis=;
        b=ah1S86zqvP1oCdS6hIZnXya0YuyBsSyJxl/0QsK9RdIBKng9Ur+ybWerFqe2YZCRLu
         G6fsF+QHjlNHQxY7q0e7HvuAe5nO40lP92xqFYNdcgD0xOokDQOQRR7Tk3bi8zZGK56z
         6yFlY5Ongz/eXCQezSFu+GAQT8hjE0toeO/E0MQHU6kSe9MuAoHCWq5ZEnvBMdt6U6Yg
         TOhjJiz9AGJAlZ5Qk3eMh4i6bdCLo28fjEhDQffV3DTDffiFFSPp8/0MdohLevK6xW7L
         EoslNRMCqozaPw/+8EBl2TBSs25bml0gsDKM0Pml820Wo5Cwo7YaVIGuyx8Ln4usCnfF
         KtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740771143; x=1741375943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8ahLP6tau5z9zFvNaThnA7Wz1kGZZr7teXmDUhSLis=;
        b=IR3UenY0+0bynD6qR4B+KvH6FN+fMXDS1pc/AtwVnBZgx3VL88jbyLpbjImjogBYdv
         Recr5AXxuRv14QtRf25/m/iFiEUxaf7oVS2V8hg5pFw9wt4k/NKLqO3GG3K0z0xoJbeH
         rzAbFFF/GeP8Q/SnFMgfXP9d30GTBGvxOkbvYnrZztg/YHQM7FLYXqfQ7cv8XwyWFSrS
         oApiQq9Kqy3hnLMcutM4zcImuVEu9Yx7R0b/mw+44jHh0bFHgmkLfUMJjNFyMVByhoY+
         C3Sr5R28qyscKbzu+HyZYFFnsYSu4A8VemrhDAO5mOxDMts5b8kKbapob/ecvDFswnEW
         LXFg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoewxYHCQx9sYO6zRkiAZiJ+zVrvhTdHidAbrFuAUXY8TdTLA5aaUyYKsyp3A8pQHFOoXcYnHf3W8Nw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwa5/G57TrAWLziCgUbPnO6640tHWKqp7NuhRLIwZP0d3+SG0
	SZxs9SQkfcyFKWpQ53OHIX/k2p1vmjzRMr6/7i6OHoXbO/J7YNn3SyARWmusjak=
X-Gm-Gg: ASbGncshASTjQ94UC+uwkTRX2mR8xCGtvXJMy99YQlrRCFIzZ+0ca/seDq8H1xs/qNM
	yrp15W8AgfDo2kAK5lHxwJKxxWyHcz7Hkda7llw91WscYXGagdRBXsWst1H0Jk3STSfK22pWAbh
	hep816PHp4eoP/KvfR5kcvesBjjD9T7F26GTKwqRRvRGTD5VmTIWtbsO2UebEytbNQ8iraOkbDC
	dvdSIX8PIdeAsD50VdzCLePHolIcQ+74OW79ggBsETa9iSI1C5u4mYtfKelJG8uxmzOYOKUhhAy
	x8/XQVYTaY2OOkxy+im4xjAGdZwus5Z4ukHFOah0ddjnzqs1L1OHqiH/jpwsUxYEnJluumxQ5hY
	=
X-Google-Smtp-Source: AGHT+IGfp/qlV0bFdQ4UlFF5bJNQ0s1CsbH7fJWc4GjD61AnOXb+ucW0858X/QRyI+8xsu26VjRTjg==
X-Received: by 2002:a05:620a:668d:b0:7c3:9d4c:8193 with SMTP id af79cd13be357-7c39d4c81bfmr429574885a.5.1740771142740;
        Fri, 28 Feb 2025 11:32:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da283sm25082546d6.111.2025.02.28.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:32:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1to65t-00000000Th1-2Pej;
	Fri, 28 Feb 2025 15:32:21 -0400
Date: Fri, 28 Feb 2025 15:32:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	david@redhat.com, akpm@linux-foundation.org, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250228193221.GM5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228182403.6269-6-miko.lenczewski@arm.com>

On Fri, Feb 28, 2025 at 06:24:04PM +0000, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
> 
> Add the feature and testing for it under arm_smmu_sva_supported().
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c                  | 7 +++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>  4 files changed, 13 insertions(+), 4 deletions(-)

This patch looks good, for what it does. However for bisection safety
it should be earlier, before the patches that change the page table
algorithms to be unsafe for the SMMU.

However, I've heard people talking about shipping chips that have CPUs
with BBML2 but SMMUs without.

On such a system it seems like your series would break previously
working SVA support because this patch will end up disabling it?

Though I see your MIDR_REV list is limited, so perhaps that worry
doesn't effect any real chips made with those families? I am trying to
check some NVIDIA products against this list..

Jason

