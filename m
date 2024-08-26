Return-Path: <linux-kernel+bounces-301630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4F95F36B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C645C28315C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4618891F;
	Mon, 26 Aug 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HyUuCWCS"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FC187FFC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680798; cv=none; b=ZM1ChX4ZEd7XBNGJ+oVHuBeC+IJzmsBFst2iUCDaHwlVYOaW9ptG5u+mNhnGBzg2OaKiOsPhN8UZ2CyYumKcZf6HWTo5Z3nmhpn0syvQBL7FVtbCmIE/2fdBWzcEygJ1wC+CXCqh+m12tgEnPNV7bj7YhpQcu4uqf5iscTYPHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680798; c=relaxed/simple;
	bh=j9QMxSHy3XpBffR7dfpz47FxtLeot0FNJuV1tI075S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksu02B+ZA2jGulWzwR5XHgjqM2M4mXWAUZC9uIw+r5349+shP6tXVwZz2yeuIa/U2CeQ2nKqN8rYWW8hzavaber+dTUndwGc9Ljj2avngBlR90St8w7/uOmpXN/5euYF/GMb2rOHt9h9+ISVyFuXfWBqTANmeItISp5GZNfGRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HyUuCWCS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5bf833de7so3314237eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724680796; x=1725285596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Xok4Exfr8qUalOltHMuaUnJ+WLJezD0kKoq3dkglM=;
        b=HyUuCWCSq3y4tqfZQppaVsV3TyX/vAROuBolFc1YzfiMd0u3jbn4cm2jxrbk1Kbety
         hLeXEoW/d5TkI1KNztVAH0HJ2c4mEZ/Z14ObAX71qBN2eGxXE2dm5O02hbQLFHr3lh9x
         CeMKH914VwWtkefDhvvQNWw02qwRgSUmsZ8XoYjBvNc71xk/rcdSijojvII4HbKFgzGF
         aaEINVE8UZRtU7ITbO9SGMq0NHTFlW9KOjxQjycKX503RSfurjT7Vp8iqxJmq1C2jSY9
         CgT0JFT9/of8fjVWwWZ5kBElcdiUci8zEKFX4G/EpAZtTSNG+9SKENuTAteF6p6Msx1b
         0oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680796; x=1725285596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2Xok4Exfr8qUalOltHMuaUnJ+WLJezD0kKoq3dkglM=;
        b=wNCOeJWPOYxIEARhJzHm2TYBYvRDAHLdm9DngyOL1ILrX1gUL/+o0YMin5JP7YpnvL
         mNpUVbVvr+bNwQFV4jt0y6tccULKSTt5H6NkELwoTHSimp1ReZyxfDwgbUPKnaD228lD
         gxkO2CumDk0kXih7pmF5cnfkzFAsVLqYGucvL70PSbYYRuHEEFewkzWoDBr70G5CPKnJ
         12gA08SYxgursXRzf+IxKZU14huRMkZFaIbOQA7I5XPK/ytwihWuAM/AL7eQjTc//Cwn
         y3i5mB2Aqhp5WsezdzvP2e3bka2RyL2ljXa6MBRbaRVrQxStEx4VXMCiQLSr7I15b9gT
         iuzA==
X-Forwarded-Encrypted: i=1; AJvYcCWSu1QpK3QtyCPUo0rzak0/wT67keb4JqwCK/VZDerCc9gn6jMEk05hQjnrfBhLwzhv9KeTrukLYkt1+wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4QZGDgtfbvrY+iCLXt8Q8/s1j+unSKQhr+Rt1N6JcB3hqEh0
	AW1hNYnPLYTkbocyWs6Ao6SQnsNjLS0Aq4dSw1EPVXkUr8l26wMB+J1Uz1h7k0I=
X-Google-Smtp-Source: AGHT+IGoxmHIXunyrBa/p1uk2uHzYi1Z/hcWVNZcLQIdjI/t7vu+fCLqkwc8pknHtw/kuTjO+ExxGg==
X-Received: by 2002:a4a:edc7:0:b0:5da:9204:6727 with SMTP id 006d021491bc7-5dcc631afa3mr12061917eaf.6.1724680796380;
        Mon, 26 Aug 2024 06:59:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162de8c17sm46261346d6.140.2024.08.26.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:59:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1siaGB-00Bx31-9b;
	Mon, 26 Aug 2024 10:59:55 -0300
Date: Mon, 26 Aug 2024 10:59:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Klaus Jensen <its@irrelevant.dk>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240826135955.GI3468552@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>

On Mon, Aug 26, 2024 at 01:40:26PM +0200, Klaus Jensen wrote:
> This is a Request for Comment series that will hopefully generate
> initial feedback on the use of the iommufd_hwpt_replace_device to
> execute non-nested and non-svm user space IOPFs. Our main motivation is
> to enable user-space driver driven device verification with default
> pasid and without nesting nor SVM.
> 
> What?
>   * Enable IO page fault handling in user space in a non-nested, non-svm
>     and non-virtualised use case.
>   * Removing the relation between IOPF and INTEL_IOMMU_SVM by allowing
>     the user to (de)select the IOPF code through Kconfig.
>   * Create a new file under iommu/intel (prq.c) that contains all the
>     page request queue related logic and is not under intel/svm.c.
>   * Add the IOMMU_HWPT_FAULT_ID_VALID to the valid flags used to create
>     IOMMU_HWPT_ALLOC allocations.
>   * Create a default (zero) pasid handle and insert it to the pasid
>     array within the dev->iommu_group when replacing the old HWPT with
>     an iopf enabled HWPT.
> 
> Why?
>   The PCI ATS Extended Capability allows peripheral devices to
>   participate in the caching of translations when operating under an
>   IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
>   devices to handle missing mappings. Currently, PRI is mainly used in
>   the context of Shared Virtual Addressing, requiring support for the
>   Process Address Space Identifier (PASID) capability, but other use
>   cases such as enabling user-space driver driven device verification
>   and reducing memory pinning exists. This patchest sets out to enable
>   these use cases.

I definitely expect PRI to work outside PASID and SVA cases, so this
is going in a good direction

>   Supplementary repositories supporting this patchset:
>     1. A user space library libvfn [1] which is used for testing and
>        verification (see examples/iopf.c), and

That's pretty neat, I've been wanting to see some kind of IOMMU test
suite based around a capable widely available device. This is the
closest I've seen..

Jason

