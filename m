Return-Path: <linux-kernel+bounces-335908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF897EC60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51016282801
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFE1991B0;
	Mon, 23 Sep 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SLF243u3"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683138394
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098601; cv=none; b=MpiOb77Waiw0u0YbScgSYlRkc48DXjxLhuy10Lg82dn2+tBWYzYiNViskgTazHH043LuqBpcBfMQgpjX94058BIgHM0Ob1HYnDUgTOZLSTF1pUmsG6FovJeP2Wlnj72xL+uO0EpTBqn6TJpm0u8zyMggZABF/0Jk7UDFBCjP9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098601; c=relaxed/simple;
	bh=PWeh5vOh4Bf4cZ6I5oWkB8+DR0Lj/ijoH3W9pObImws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2/dZGgviKLVae76lofRLxGMb8i3QU0ArylX+Oic/c+D8+vTiL56kqVO7Z2usckqoDcPTW9eln3mB/sV5JuX4XrsfWfuLn1MPgEnglXDkD3oUFOZw9hum+eLDdl84mL/+WKTplErqeAFy7Os0klkhcsuK3PHPVfzAsO+unbBmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SLF243u3; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c7b57e2b17so32673916d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727098598; x=1727703398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvlhNE5piU/663urUfITp0zU/FAY9sAW/+6EGH8GxQ4=;
        b=SLF243u3oAzgYBv3/f3s/xNLeRUuKmj5Bskz/Ut7EaFi2xtNMIhq00ABskvnmQlJLB
         SDTuPVoh5mec8xcMCZus8CgJp4dYE/+fOA0ZGwlM/rugWzcxVOH5JT0GsL4S/2iHly2s
         heYCFOfJFKSfDNbhIlzPUtITPNd70cO4s18I/VrKxAm2eLKCQBItrnBG1HHnFE+yJPss
         6vn4KieH5Gz2329LLUscUott0tf7eGx2ONPHlAnHv8jdpxJNrKuUA5KR73uxLkF5qX38
         XeCfs3HC3kFdIBulWrutmHxRHrj5dxWc1cAyIJuuMcb+J1T3QU+qiEf4k1Dt2G5r0Ibq
         vwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098598; x=1727703398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvlhNE5piU/663urUfITp0zU/FAY9sAW/+6EGH8GxQ4=;
        b=I65qJO1PXhCtTTaI8Y4vYPTXX25ngVbK6VF64+2q83NMcPLRYsWx4XcMZCkViRwGiI
         wZ67nxqNvR+SXHgk24ThZYOo/QdeeiRmDYOtNhOEhC6KBXZMrf20LJQbeyJyKLXLW/5Z
         /LLTU8WUNpGdg7ebsA5vJmGaIPNu8Ak7IhbQIf9XLQkuNCTU3EL3BNE1wuf22huehFcA
         lOGTyPFvRNXf+KrT8nCqIAZLq9BAYU8WTlyBSjhEt646MRMJJCiVvmB8xoE3Uct3rBvr
         Cbwi4K937a2duPk/VHX4oIdaD2eKI0MOnpFtXxu2cE0pRT3t94Qf4WIZpx2v/QWx2TAn
         x79A==
X-Forwarded-Encrypted: i=1; AJvYcCXKitLNyk2Bg9qVUoFScmwLurep5sNNSsuoMM2sV4AJjcn3n+YFnN4NuunZ2VmTqmrPCSXLtZ5J2EDbGs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpmooHkretfwjP1giPKNEhUodNFK98ZvWYVX0Sm56CV4iQUvX
	aEYYDwWal74QTlkB7uonaaHakSSnDbBE5HPIwfkzOYWg9r3kwLZK2j2tlmtBNPA=
X-Google-Smtp-Source: AGHT+IG8nY/c0nUDZcgS95wwLvCpwhg9bmfm8FtbDwp/EI/oonbUwEXDnYa9yx8LSj7p8zXd/swiGw==
X-Received: by 2002:a05:6214:568d:b0:6c3:59ce:d0fd with SMTP id 6a1803df08f44-6c7bc83f5demr172796246d6.48.1727098598596;
        Mon, 23 Sep 2024 06:36:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e576f65sm46990176d6.104.2024.09.23.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:36:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ssjEy-0002fX-P4;
	Mon, 23 Sep 2024 10:36:36 -0300
Date: Mon, 23 Sep 2024 10:36:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, mshavit@google.com, smostafa@google.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Convert comma to semicolon
Message-ID: <20240923133636.GA9634@ziepe.ca>
References: <20240923021557.3432068-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923021557.3432068-1-nichen@iscas.ac.cn>

On Mon, Sep 23, 2024 at 10:15:57AM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

