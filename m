Return-Path: <linux-kernel+bounces-430034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3FC9E2C89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F0CB28C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D61FECB7;
	Tue,  3 Dec 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbVJTBdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB781DFE23
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252588; cv=none; b=S9FnABUyjuioLdwgAmEsFvG/146QV3Os+fltXCce7AzNsyw2qbegZ4Ab4rHXZmo0FwSz9tVuPZ/o7n7OKhA0X8XD8kTmP0Rr0eDFG07LM+Olm6yYQzrPQ1NZ6vE14GURMati71Dsc5FFO1InyBYoCJYez9M1MWloyQhb5hkCmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252588; c=relaxed/simple;
	bh=r6PY5qRAnByAm7avPHzxx/5PJKv4Ib39Av3nvg7mr3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxTDTNBtMzCXerZxXxV3Ogg7c98vJTdtATaQ+wUkpqkd7380xdZ1GiCOgxeYHu51qCt3Osc8PAK+bGkouYRDLjl2hGJ343tZfGPZmk4b5pj2k5mC2dOAHzCu8LKfIsNG2/jsxrmWeXb1NDM88YonMngreCRYUHwA7aTyJNAQh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbVJTBdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C58C4CECF;
	Tue,  3 Dec 2024 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252588;
	bh=r6PY5qRAnByAm7avPHzxx/5PJKv4Ib39Av3nvg7mr3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbVJTBdRo7gAFtRqj57j3XtKk2Ep9JVy3lV8mlehu6fhmm8KXBCKkCEpDat/DskVi
	 FCuoyPHKjuSKfvb+8L78SbqOLMteAsuYF/KyY4Coin2Ayj2UcWtoMPOn9GQxfzPeKO
	 9G9AMLPSV5rynrNs4Wj7GfC+7OjNdjYFISJMzTe5CoO5VulZuspkGisptZ05O742uZ
	 hebNGekOZW4TuMbbgG8NYDMjHo7koWC4GziSszEimd/PlWAw1qjZY5KnKgOSaZ02yF
	 1zXyDOpvae4azjkVa6W0l5BIpDHhLnsk3AQhuJAFnA/TKfcYSoPrcryTFgBgELsGQQ
	 ZeNa3zg1gZdpw==
Date: Tue, 3 Dec 2024 11:03:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Message-ID: <Z09V6QHNxGS5FTyB@kbusch-mbp>
References: <20241130170258.103954-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130170258.103954-1-eleanor15x@gmail.com>

On Sun, Dec 01, 2024 at 01:02:58AM +0800, Yu-Chun Lin wrote:
> cocci warnings: (new ones prefixed by >>)
> >> drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used for data, instead of kmalloc/memset
> 
> The pattern of using 'kmalloc' followed by 'memset' is replaced with
> 'kzalloc', which is functionally equivalent to 'kmalloc' + 'memset',
> but more efficient. 'kzalloc' automatically zeroes the allocated
> memory, making it a faster and more streamlined solution.

Thanks, applied to nvme-6.13.

