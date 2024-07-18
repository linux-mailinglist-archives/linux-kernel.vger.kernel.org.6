Return-Path: <linux-kernel+bounces-256312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A243934C55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E18B2120C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094A12F375;
	Thu, 18 Jul 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wwHM3JRQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9D1BF37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301720; cv=none; b=YLUVmtBSMh8DF7CXW76w8m9uaBp40fJqoX2Jt7mF2ZzxYW/kbXO8zOTiMF2A6FFAv7dDREQW8rHVUmhB9oLqBw84CkdUMLtn5SMCrOXhSPgffLWyi5LOaUELmJcAo3Wp1Fkb5JlieccGKKsXbU0uz7FDpNkU3yXp5nZ6WkU6DKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301720; c=relaxed/simple;
	bh=9u2xO8O8w/KgZ6vvG0BximWwsjHat7wfHyp4RII6BAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaiRb0Q6gCjtNnI4r4GoDraQIA+9QbhTD4MWz1MkebfiezA8rMfQYGb4UcgXykBXQULHjNqlG5oNsvYJnmQ/vBi0cHgrhOcpHEz7X2JoM+FQRyExRS3P/uPSUHTTEzTEI191lj9kowSwAQYFPe8vvAna870WKabXiIKlzzBicfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wwHM3JRQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46IBLZkS097792;
	Thu, 18 Jul 2024 06:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721301695;
	bh=FUWCt+twmOe4jXbCQ1UPrlBJg5YbwLAUu2Ie3X9EI/M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wwHM3JRQeq197wQ7LCtAGc22ZO7nTZYb6r5wI+MwtE34WlNOKgrihGFR+oKK34uCV
	 YzK8IzcCQEnpiyHHwTf9LQMilxJ4TUgrV7cHy3TzZTwFGQZq7kxAoYxZVDxGWaSZtq
	 pMm0ukXDPhxNCTpr8nNDmJZ32Il1AJyJyi8XqJXM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46IBLZnq098999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 06:21:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jul 2024 06:21:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jul 2024 06:21:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46IBLYJm023443;
	Thu, 18 Jul 2024 06:21:34 -0500
Date: Thu, 18 Jul 2024 06:21:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Julia Lawall
	<julia.lawall@inria.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/4] Do device node auto cleanup in drivers/soc/ti/
Message-ID: <20240718112134.txuimtlg62375jaw@musky>
References: <20240707055341.3656-1-five231003@gmail.com>
 <Zpg41yZRHPv9w0Lg@five231003>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zpg41yZRHPv9w0Lg@five231003>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 03:04-20240718, Kousik Sanagavarapu wrote:
> On Sun, Jul 07, 2024 at 10:44:15AM +0530, Kousik Sanagavarapu wrote:
> > Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
> > care of all the cases where this is possible.
> > 
> > Thanks Jonathan for the review on the previous round.
> > 
> > v2:
> > 
> > 	https://lore.kernel.org/linux-arm-kernel/20240703065710.13786-1-five231003@gmail.com/
> > 
> > Changes since v2:
> > - Split v2 1/3 into v3 1/4 and v3 2/4.  The memory setup code is
> >   seperated out of the pruss_probe() function and put into 1/4 and the
> >   actual conversion to auto cleanup is done in 2/4.
> > - Replace dev_err() with dev_err_probe() in the code paths touched.
> > 
> > v1:
> > 
> > 	https://lore.kernel.org/linux-arm-kernel/20240510071432.62913-1-five231003@gmail.com/
> > 
> > Changes since v1:
> > - Refactor code so that it the scope of the pointers touched is reduced,
> >   making the code look more clean.
> > - The above also the side-effect of fixing the errors that clang emitted
> >   (but my local version of gcc didn't) for PATCH 2/3 during v1.
> > 
> > Kousik Sanagavarapu (4):
> >   soc: ti: pruss: factor out memories setup
> >   soc: ti: pruss: do device_node auto cleanup
> >   soc: ti: knav_qmss_queue: do device_node auto cleanup
> >   soc: ti: pm33xx: do device_node auto cleanup
> > 
> >  drivers/soc/ti/knav_qmss_queue.c | 100 +++++++++---------
> >  drivers/soc/ti/pm33xx.c          |  52 ++++-----
> >  drivers/soc/ti/pruss.c           | 176 ++++++++++++++-----------------
> >  3 files changed, 155 insertions(+), 173 deletions(-)
> 
> Ping

Umm... ping for what? for whom and why? In addition to reviews, I will
need someone to do tested-by as well - pruss/am33xx folks..? Further,
fyi, 6.12 collection cycle starts with 6.11 rc1 and I close mine around
rc4.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

