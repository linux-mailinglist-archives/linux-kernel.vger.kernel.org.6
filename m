Return-Path: <linux-kernel+bounces-251407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE793048D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D62825F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9642049;
	Sat, 13 Jul 2024 08:46:37 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF12F2A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720860396; cv=none; b=nneDCGgYB5Ptl7IeDNg5JK1BI90NUJz1Z8P0TNCWCTOfXMMduFwLb4r3OqaF4dXOr6LBGgpr66K0j79OcNuNfoZNZQ2jPiVyDrScYppVU2Bws17+DX8f9Z/QmPEm+LGIYFsQQw3D+SZmq3zQ/jrn3XL+d+zAE0SaNxNKKvYNaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720860396; c=relaxed/simple;
	bh=F7XMmFhnQVCGlewwnGylqtGnVybCCrgcl3Fi+RC8FMw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UDSg5J6HDwhFzoYJlNvxhdJUgyrDqtTpWKFnSH3SQ51C4qqTweFA+ucrmNxGc+/qkGPkzYZ3n5fU84PKUtt+/v5s7ondTNnGey/RAVzzoROKGMIyWmHStovm2cFnaGGsZdbXCdwFyAVTz0/k/w6XBvdrRWvC2seWd8E8nrELXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C22E86196A56;
	Sat, 13 Jul 2024 10:46:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KRQdpSGc2R3V; Sat, 13 Jul 2024 10:46:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E28046196A71;
	Sat, 13 Jul 2024 10:46:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SLU5LTIjVIPa; Sat, 13 Jul 2024 10:46:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C6CB06196A56;
	Sat, 13 Jul 2024 10:46:30 +0200 (CEST)
Date: Sat, 13 Jul 2024 10:46:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Ben Hutchings <bwh@kernel.org>, kernel test robot <lkp@intel.com>
Message-ID: <1422580650.65606.1720860390692.JavaMail.zimbra@nod.at>
In-Reply-To: <3c624cf1-b5a3-f89c-ac6a-0875fcabaf25@huawei.com>
References: <20240713073519.25325-1-richard@nod.at> <3c624cf1-b5a3-f89c-ac6a-0875fcabaf25@huawei.com>
Subject: Re: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix ubi_init() ubiblock_exit() section mismatch
Thread-Index: JLuc69wdLoWYy8hheIEtVbp4M8FslQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.or=
g>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "Ben Hutchings" <bwh@k=
ernel.org>, "kernel test robot" <lkp@intel.com>
> Gesendet: Samstag, 13. Juli 2024 10:16:15
> Betreff: Re: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch

> =E5=9C=A8 2024/7/13 15:35, Richard Weinberger =E5=86=99=E9=81=93:
>> Since ubiblock_exit() is now called from an init function,
>> the __exit section no longer makes sense.
>>=20
>> Cc: Ben Hutchings <bwh@kernel.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202407131403.wZJpd8n2-lkp@intel.co=
m/
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>   drivers/mtd/ubi/block.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Looks like that you prefer a simpler fix. Feel fine to add

Yes, and Ben sent the patch first. :)
=20
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the review!
And especially thanks for reviewing so many UBI/UBIFS patches,
I appreciate your help.

Thanks,
//richard


