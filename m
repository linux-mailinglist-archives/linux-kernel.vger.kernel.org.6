Return-Path: <linux-kernel+bounces-310009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2196730C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EBC1F221C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA314A4EC;
	Sat, 31 Aug 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PPUmUXSc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47A2E416
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725130405; cv=none; b=FzOdyI5Cpgm/jMxodMXKCCLzYC/d/XNd0aAfmm3l3eVVpAMY/mBRD2Jd2n3DBMMD+YsOin8XEsuaNT4zvTVNsO39l1hShWMIk5E8OqYk41L539YWXS+qSW7pHOt2BYwmKitwkhBb0gsuqy7JlagrZb87NWRAOlAqsHLAaffBNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725130405; c=relaxed/simple;
	bh=nGlo4A4gdV0LYIKugmBLCjwdT+kg96oNjFZgOxBUdqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiV05n+J7xK2XZPP5LfhalD+FKRBCeYXqqK+dcR+rlCffQak+nW8tTm66/nMsvLMIDKG9kLmCgJCqQzQqxsHSCtYHM6J3Du2POo1AdvP62/KmtVeK0JF/IWXKJo71P8PqtwVetQ0BDcB/V/LXpfUhnaTb0QPy4QWHx7M0UuGIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PPUmUXSc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9ocRQKCKlDhpKS9pqc7GIGRog4ihv4JVUCy7IXSwTRA=; b=PPUmUXSc0+5ldZ41xdIsgHnylt
	/D+bD6OlgpDtxSBr4UJueyzCD5Xqi8/jnX/BjdUHTbcoQIzz0rxW6+R117vjMfZYGbbfhXdOtc3IO
	2GN4qk3BFKZ5Rj3xp+gZpH6tKnCshKWqC3S9EUvWXyCIUCkLf2EeY2A9VcH3oe5NTl9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1skTDm-006DTX-IB; Sat, 31 Aug 2024 20:53:14 +0200
Date: Sat, 31 Aug 2024 20:53:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
	ssantosh@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
Message-ID: <7ddd1e8f-7c33-42cc-9994-d251c63fddcb@lunn.ch>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
 <20240830103155.5vs2hdokw6yysq47@finance>
 <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>
 <8a02ecd3-4e3d-4332-85da-8a0bdf4b9ed2@kernel.org>
 <5ba9c21f-acfa-7c89-a358-b52aa9ecedd3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba9c21f-acfa-7c89-a358-b52aa9ecedd3@huawei.com>

> > Fine but not much useful and at the same time huge churn from @vivo.com.
> 
> I see, it is fine with these dev_err_probe() dropped, the main is the
> scoped child iterate.

Which is also a lot of churn.

How about you start with those that are actually broken, missing a
put. Those changes are useful. Changing code which is already correct
has a lot less value.

	Andrew

