Return-Path: <linux-kernel+bounces-221251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546890F0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FA91F21086
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71861612EB;
	Wed, 19 Jun 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kpw1fmxn"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78B4D8B4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807868; cv=none; b=s7CF6ZItU0QSYJzKcvNY+zauy2pkRZDKJdYHxuYvSwSPEMy6VeZC5dCeTo+iUUuPdk50NLMgRqmq/2squLyAkJ5iBbt17EyWicmyhQjICJ1hKwd2WEHpzpZEUrxCDAD/L5fA6dnkRurLeK5VIATdeRmAAolMH4iM51SHqATyS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807868; c=relaxed/simple;
	bh=O2Mc1QzJP89YmB6eoAnF/3NLaj/HJnIjRAyUwSdc+tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj+FP8BLTOQ1FZWjJsyKPngTG8pSKwekst7EAd/K+NKuoznu/ee4nA/WI74A7HPHIQyRZ5BSt7EqRKylG02ajwrsaMyxzZYc4OUbk5TSS/k9ZLRsk205dXluciLYgKr3MDpdZod+SHGSyfQ4USgSKs9Fo3F1AqJETkubUNvA4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kpw1fmxn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7955e1bf5f8so398372685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807866; x=1719412666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=41x36+E2nhusvTatiAF8IHTdsL8WdLUPppc5CYA4l6M=;
        b=kpw1fmxnrI4NKzS4Ws93hzQpvYgop0bOkKVRW9l3vOU/qLMgE2v+1hRLsfPTUFTB4e
         oBSWmBFL3wQgpF1P0us3VDJkFMGhYiTrny1pBL9nvukYVb4YR2OV80Ys/YCXryT96N9k
         X8StMyMGmdETU+bmoFD5uhhuYFtR+CV7araxPUjNhNXh49i1HIYfYUHGilTZLwt9sdlv
         DFxiFEUcCYt914BJz9iaBOJEF+jajHWLETSn7WtB7XWvc1CXbnIYsPIbdEPkPB4R40s7
         QG1ZygbcHBJwGlFVq6nHOvsejrWOjXb//AmgA1o5sE3n0DP9QdB++rxnRiieKA2e9KsF
         21dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807866; x=1719412666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41x36+E2nhusvTatiAF8IHTdsL8WdLUPppc5CYA4l6M=;
        b=OHNZ9t7PtX1juQs1iqkJmqpbSpGLrHIQ+3uUHXCr7Jy+kXHLqgJZ13Nts1Grdz6KzH
         WcTV1FJEmdP59TEEfMKOHbgAMOINbRPYF0jno4bNkinDEpFG1WWOY3M2NIbBKCi/73SG
         d4yt6soE1zaTBOLmED3F5sAGYISrISRkP1FJwjvQCv46qN7ewIW7h4dOwEVG8jsYtMPK
         WjD9Z6Lf/eeaIYB74uge34khR24t5eIKItyz/Vqytvx5W/JhqOYw2/5vKubG3G0BvYKY
         X1hJNgQDy53pz9MtOGInGAzrlnqG+Gl2b/A1PRuxPFX4kSqABIGok+4msKbuSQ0nv9V8
         qaGA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Q7iWhv7CqGpgaMGA3YMI0sfRdBKBs/BUChB1Aza1Ff3Yy6/yHeVSr2PpnfpT+hq3Hwja9NVjnI6uqTrmUJWAM1bYMRet9l8TXNeo
X-Gm-Message-State: AOJu0YxCxu9RnwIzTIdx54iFPZ/OtTlp5SQTpy0ibtyAs0GsS0e2rygj
	BytiXoDYnS6MpAwhDdSiZ8o/tXEIKHjqrhfQUU0EWPRvmnNt7lB0G4YED5/W5E0=
X-Google-Smtp-Source: AGHT+IEcJxNrliYdvuzlpiDb78QsThSHkvJcrlo7MFvwHxPiUc2KNP4DZqSrOqcyX1HTz8934IoI+w==
X-Received: by 2002:a05:620a:4044:b0:79b:b8ef:160d with SMTP id af79cd13be357-79bb8ef1b2fmr197306985a.32.1718807866220;
        Wed, 19 Jun 2024 07:37:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0719fsm611398185a.83.2024.06.19.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:37:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRV-004dKe-BM;
	Wed, 19 Jun 2024 11:37:45 -0300
Date: Wed, 19 Jun 2024 11:37:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
Message-ID: <20240619143745.GE1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-11-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-11-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:44PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in ath10k_fw_init() and is attached to
> ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

