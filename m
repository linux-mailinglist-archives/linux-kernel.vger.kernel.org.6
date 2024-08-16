Return-Path: <linux-kernel+bounces-289932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DB8954D74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AF9286A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD91BD4FC;
	Fri, 16 Aug 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahny4w7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2C1BD4E3;
	Fri, 16 Aug 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821379; cv=none; b=NgjRbImyuUgyeE3T7eXtOcvUQWs3nUN+r2kABB8lUeGNWzLd3ZDIMe/6kgvFUDJw9R/pbHe3D3qwcNfIo1+GNmmRnD07Jhddwli7mpw0MsTYeUxQCY+dqLr2jzHej34qwHYwCgr6fDsSYBYu/TFZ2i1XXw0EerExSDhZuGu32as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821379; c=relaxed/simple;
	bh=W+Lr43/9q2mk/Wh1qTIPGzXl34zaCk1BMS1ZofHjcjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sohfa211y/yAHuDmTXsgsFWtRVcVGxy0sb5E8DxNpJREd8ll03KLzPg3fzJ2ZAmSnWjBFj2+Ip2cCChaw7oG6lqY2bttUocJRIozCxg5rJW46AhbMoDSQV9n5dWQUC1GV2H2oh6E81ydLf/5SiQErDhR5tO27pGcUqh6RC8MMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahny4w7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14143C4AF0C;
	Fri, 16 Aug 2024 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821379;
	bh=W+Lr43/9q2mk/Wh1qTIPGzXl34zaCk1BMS1ZofHjcjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ahny4w7C4w3+gimSf8XZWQU9IJ7brnt4sumDBq9a8GWRAk6K88KBiF7Z/1wumen5K
	 QfHfk4ur64/R2yWHhUUgQ01q4N0EqRGSiwTYow2sVypDdszo6lW1qqKyhfqRN0a0WP
	 kBb6iYqOeK5hBTCR0uPcEc98UGlRtHel7QRqvDA23LhnrNznmb4qMNy6CVutHVDKwi
	 UATdVDI9M2QDVDaKxlsfyfGLwM4/LAPMXTKxH+d0ozMQN05wx73Q22EVzOBuF4G6nb
	 SXge1yDQ9CMlXszZmOEXfCiDBV7U8OAvBf+KiB9x8p7ge79Pdzvbw0/5Bq54fwjVE7
	 9EsM6qELXzETQ==
From: Will Deacon <will@kernel.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
Date: Fri, 16 Aug 2024 16:15:53 +0100
Message-Id: <172381875518.1794999.1134549433569030700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
References: <9208cd0d-8105-40df-93e9-bdcdf0d55eec@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 14:25:00 +0300, Dan Carpenter wrote:
> The arm_smmu_domain_alloc() function returns error pointers on error.  It
> doesn't return NULL.  Update the error checking to match.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
      https://git.kernel.org/will/c/af048ec9c051

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

