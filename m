Return-Path: <linux-kernel+bounces-325954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A550497602D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D868A1C22225
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8B184548;
	Thu, 12 Sep 2024 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HaQb9pUU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBE5BAF0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116829; cv=none; b=Rpncip/wpITTAC2xZ36DIqDJHk8LtLX+JSWoHZ8l7dUHnuWUb1xxgsZm0WvENrDg/Pt2MC8qlTWFAXYsnMnAW+9y0rMcC5QPuxkVdep/UT+OsGRlgyVGIap9sGjEABNH/OpyKpx7tQwd43N1WOdGJ/bsQKuIXrlQl1Mjdfba9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116829; c=relaxed/simple;
	bh=Wg67FOvAAGNoq1fGyUAFQP4iUXqQYadkkTm1bncLL5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdpuiWKaT5mZFjWrSMz678pGAjXYNFBeXG7egx0q+tuzF1AcDsDZ2BJlHyTMPjhxpYQgnVqWA0hpJ7PyQTXCxa3hVqirwixYCU1Cb3xEnKM8UiBZtcq9bWzt7IQ1qQKJNAfyEBnJ+TNXKxe9mZh6XBWjmPsP5VCdU7WyOjGKxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HaQb9pUU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=GfXA3mGsaNWNlym/aRMLc5TItv9Lh9SKYkKIl8Ioxvc=;
	b=HaQb9pUUm++ZB42VyOK/5H0OUtV70htULbb5M0HPLbuOpzNxdGE8syhzzJWECk
	u4I0gNbikX4Gz3J6q2bytpaxh/i+jJiygEsVE+784SWUVYp7RfMDjFdq/2hQ6jb0
	zKbngjMM0w12kfdXS4owY2KfhXX8ER2nQy2HG9+TGzG4I=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wBnT7quc+JmLGZrGw--.59345S2;
	Thu, 12 Sep 2024 12:53:03 +0800 (CST)
Date: Thu, 12 Sep 2024 12:53:02 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Should the return value of the rlookup_amd_iommu be checked?
Message-ID: <ZuJzrjovqkkw1jsm@iZbp1asjb3cy8ks0srf007Z>
References: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
 <dd76524b-34d4-4092-bb04-0f7bd45f7c5c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd76524b-34d4-4092-bb04-0f7bd45f7c5c@amd.com>
X-CM-TRANSID:_____wBnT7quc+JmLGZrGw--.59345S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3LI6DUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRYamV4JMMxcQAAs8

On Thu, Sep 12, 2024 at 10:19:53AM +0530, Vasant Hegde wrote:
> During init driver will initialize rlookup_table. rlookup_amd_iommu will not
> return NULL. So its fine.
> 
> -Vasant

OK, thanks!

-- 
Best,
Qianqiang Liu


