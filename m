Return-Path: <linux-kernel+bounces-217740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D690B39A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F45F281DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A49156F5B;
	Mon, 17 Jun 2024 14:32:11 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C2156F48
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634731; cv=none; b=oY0Ne6c50y7YiyvRG8Y06lDDZ87AraNmUBAuNByLtScES5USArM1VAgEy57cJ7fdgdyc0pL9uVWIADJMuMFSahb04WYHJ5gwrql2IMxVYliApqqeWZ8/VzFlIeugjF8YSIwjfhUM1XZ6DjHNkY1PIAtzdx+j7Wkq8qQGDia3Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634731; c=relaxed/simple;
	bh=VJKpdFQPUIW4FN3QIA7aSVbuR+6jevqlt/U/f+yPoRI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dkpBSJkekQpWV6Vso5N+Q5UVBpYarHOe5BmCypzGgLlRIGAKIJ8yN80eYKRoGOKxhw5r2IO0Ibc3uTFxorydMGhjHG7jL2G0SgIUJD7BbiQjlw/XQkJDeLW+ZnaEqEK5+7GvLvl7ZCBnhP/oJPiYZeodEULL7dL3XiymyUV0WuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E1DD161966BD;
	Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ylp9hY2GKHJa; Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8404561966BE;
	Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JW9koqa3rudw; Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5CC9861966BD;
	Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
Date: Mon, 17 Jun 2024 16:31:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gagan Sidhu <broly@mac.com>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Message-ID: <976649573.251318.1718634719216.JavaMail.zimbra@nod.at>
In-Reply-To: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: mFBxGNSof92Nq/KN5lgnAM/4Uq7Bqw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> An: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> i have attached a log of this behaviour. and by removing mr wang=E2=80=99=
s =E2=80=9Cfixes=E2=80=9D, it
> mounts as we would expect.
>=20
> this change must be reverted. extremely surprised the openwrt team has no=
t
> raised issues over this by now.

No need to be offended, sometimes use-cases are forgotten.
Thanks for your report, we'll look into it.

Thanks,
//richard

