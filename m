Return-Path: <linux-kernel+bounces-221423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A730C90F361
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4ACB21D71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433B157A7C;
	Wed, 19 Jun 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kw/IrreC"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026E157496
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812145; cv=none; b=X5AVU95K8emLagBB1mTXpEzQmv3KS/gClRYmXlhFB84Dq0vqySF3sq+BTF2h2tXpet+jZbXC0ZNa1wJXEQNWv2zEvUJVP1dxdm8bYa4njNrw4mKRGlT1WtFOjM22ASum3nUyd0JGu66RVn1Dfdu8p6wmMhsnsGY5InT5Uy17MCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812145; c=relaxed/simple;
	bh=gqmsV2wQyLRTa+dMlIDvFO+HmlyFWBidO1o5Ifz7Rpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prJxJLshQLXEJnqDOEqBB595oHe40q4DwsiUve9onrGB7UtwdgO1qaqkS+wCpDD9EuVI75+c1nBbGHTxNBPbZq4AOADSPYul4Gk0GtYmX+nDPROiJz1eZdMZPo0LBZXLDbw67PnO5r7kLH1Scsvh4kOTgACJ+4xR4aqnpm/8e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kw/IrreC; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f855b2499cso3700614a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718812143; x=1719416943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaUP1kZaDzbLlLlrnXpwVvSSBYt89/ufOLldJsnhc4U=;
        b=kw/IrreCDMgEKOFOdzIwpFmxMhJvNJBLonHfusm9UL4IutZsWe2UdTwYavLzyi0fIb
         vN/Aq6FrbhSGvupvX/Ce4lXc27lCsRV66OhO2eh74ZJ+olgem/+bYBXNsoxjW1wG6Efz
         KKi+1dlYRh1XTX4g3UiusZEGxnhgWChij7csWKulmcgojVcuv2spR5Y4wE1yOKRAhgup
         fbNKacVouxr9YKveSVuEyGMqzqnBBkxgE0XlowL09D4+aI2PrhzDaZMRZOTMFxkXZs3N
         8m/Rub2qNohbUOeBb5F8ZWl9LeTIGPmSFsR6ywEQ7+SUSisZ0Njw9MSyVjojFsxYW1dj
         nJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812143; x=1719416943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaUP1kZaDzbLlLlrnXpwVvSSBYt89/ufOLldJsnhc4U=;
        b=vUZ8dsE1Hwhm7ifSOpf0sI9TVuhHRUhenXeFNprg7WR8Yf8e+uBixRPP5obXGx3Ac0
         68BIWBnYbNu2WTu42l+1zRSzIfKhvCUUZ6dFjT/uh/Vu18ei8HnEaQ9bVQcdkArcF4Wy
         S7P7LkX1wWzJINfG7tNJ1yxi7JQknlf9yozUZIVbngSN7AX1NMqZlkg7vqFl2TAx/L3s
         y1ra61oV6KNMxOlTZtQV6dcsg/YTw0exhar/GS0W7zocftuGW/uTeC0v8l+pUiERI3eT
         KjSN5fzr9B2QJ1qmMqx8zFKHRWktvBgxDgPzMzRV9/YRgu7MMshhwZ8BgDjTMQGY7AAm
         966w==
X-Forwarded-Encrypted: i=1; AJvYcCXXqNvSL+K8U+7D9bprm1fiKurwfVqEr+TP6x21opKUrQiAXw5BuI95K5bkexmiaKRif2ZI6Qw6+FDmXbNWn0wwBaTYG5kJ6YGSktjp
X-Gm-Message-State: AOJu0YzgqHl6aGL00d8OgaMpEqENcFC+xXAZwtWkmukkOujMPE9ImIPt
	O39UeSWi03ckt4Sb7lN9gUZCjxkeBdVOIYvzBRLjnrwEgzpaVrhmN/Blr4pkOds=
X-Google-Smtp-Source: AGHT+IGiKyWuqgAIxgrEV+lA+jwRvALxPu8Ex4GA8h6qTDbq5CrrDib3WqnWy/fQMHVAIh7lZU0CKQ==
X-Received: by 2002:a9d:7e9a:0:b0:6f9:62e9:9f93 with SMTP id 46e09a7af769-70075a747edmr2788040a34.35.1718812143157;
        Wed, 19 Jun 2024 08:49:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b4fcf9ab77sm15777616d6.7.2024.06.19.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:49:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJxYT-004xTQ-Ic;
	Wed, 19 Jun 2024 12:49:01 -0300
Date: Wed, 19 Jun 2024 12:49:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 06/10] iommu/riscv: support nested iommu for
 getting iommu hardware information
Message-ID: <20240619154901.GN1091770@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-7-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-7-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:52PM +0800, Zong Li wrote:
> This patch implements .hw_info operation and the related data
> structures for passing the IOMMU hardware capabilities for iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 20 ++++++++++++++++++++
>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>  2 files changed, 38 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  /**
>   * enum iommu_hw_info_type - IOMMU Hardware Info Types
>   * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
>   *                           info
>   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> + * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
>   */

Is there a more formal name than "RISCV IOMMU" here? It seems like you
will probably have a RISCV_IOMMU_V2 someday, is that naming OK?

Jason

