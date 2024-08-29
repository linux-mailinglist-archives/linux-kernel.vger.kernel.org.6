Return-Path: <linux-kernel+bounces-306016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7969963815
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D0286039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E134CE5;
	Thu, 29 Aug 2024 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEdG1yvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616431C6B2;
	Thu, 29 Aug 2024 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897535; cv=none; b=DLip0TXpzT/1lrTftBK+UUVhN6oLw4Jefc/J9j7yb0Gx9hWazwTU+J8GdbTkk2OAzy0qiW7V1yfTT48FjfufQC5xK1kkgorAozUsuqWBhX2GBYva9vTRmlMyV+0I3pIVXvG6UFIxY9eutPXGhJXdOQgcvCZ5oDu8uQKFv7GFFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897535; c=relaxed/simple;
	bh=vGqn24cAZcRr9iQMqB4XXgIBgziDfeOa5+VEC51/Xeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1X7ABAwt/d/3ztbPJ25++vEeCLZ7dIEToipXPNWoyNyHulSYjVCRPQbXWZ5cnd3qEeQmgf7dlqlqA30z6WSnLKFbSExOUCyHwgolfk9NMmlGG8vHiNFsKOxFGPGiSGe470+8bMR8VFgJpJEVMrIHAW+2WnI1g6+AqFVs1WKoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEdG1yvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F10CC4CEC0;
	Thu, 29 Aug 2024 02:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724897534;
	bh=vGqn24cAZcRr9iQMqB4XXgIBgziDfeOa5+VEC51/Xeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEdG1yvCawwnB25FjbBx9+cwkool2rMcdlQdASsAXGk2QfRoBDa/x5X+XTSQJBak0
	 BN7nWCXVsrZClnDfKCPnZjKQ827o2qd24jiZgQuL/tppmDhXLtba9UNI2Rqu0wExpT
	 sBDffg4i9FL2FJPV9kTNsgdklaVacGlyzlJl0Ens4XOi3dgDkMstgjJJcqRnRdmvh7
	 tlXOjjwpntDq2gUtQgCmdWFisj+yQeLf5n+iYdQFY4gS3M76Ib2rC9k/DnPUkOKJNY
	 JFRZNPqBvcYEvi50jSomgGJojpY8SiD5H9MIsDux3+rluHVGjlJQVpluKGvpUmVD8E
	 Yq8kXII1mFliw==
Date: Wed, 28 Aug 2024 19:12:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 04/11] net: hibmcge: Add interrupt supported
 in this module
Message-ID: <20240828191213.3237eaaa@kernel.org>
In-Reply-To: <6c7d1538-5a94-466a-bd4b-022b5570b287@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-5-shaojijie@huawei.com>
	<20240828183536.130df0fa@kernel.org>
	<6c7d1538-5a94-466a-bd4b-022b5570b287@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 09:54:00 +0800 Jijie Shao wrote:
> on 2024/8/29 9:35, Jakub Kicinski wrote:
> > On Tue, 27 Aug 2024 21:14:48 +0800 Jijie Shao wrote:  
> >> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> >> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);  
> > These are not devm_ -managed, don't you have to free them?
> > On remove and errors during probe?
> >  
> Jonathan Cameron told me:
> 	I have used pcim_enable(),  so, the irq vectors become device managed.
> Look for where those paths call pci_setup_msi_context() / pcim_setup_msi_release()
> 
> So there should be no need to free the vectors on remove()

Please include change logs in individual patches, going forward.
Please add this information to the commit message, and remove
the existing mention of freeing there which is now out of date.

