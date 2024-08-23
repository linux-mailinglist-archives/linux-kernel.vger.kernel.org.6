Return-Path: <linux-kernel+bounces-299423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4795D461
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB71C22507
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3451925A1;
	Fri, 23 Aug 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L0rWyoil"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935341922E0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434420; cv=none; b=TSMHECsRZvjmRaP95VvRtbe0Em+umCTO3Xq97afv0W61Gc/o53lsUmYskYhNr1ZIQG9YqMBWPpwV7Ap2DkubnJL7VaQ9CIwPs4aK+iMIYfngnUCDfggjOzY2n283ZwSGHqTRVM8HpVOCu3BmgaRJoWmviWkQlydNkuw3A2f6NGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434420; c=relaxed/simple;
	bh=e+ornxI8Qrxm6vJy/AKf2u+YsQZBCGJpjlybDc4GAE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7XQoJv+sspTSUyaSO92LyExr+lDFS9XkiF79cUnTyapTVPigL/0BcQX9DSq7NpgK3uILy0PTh+K0uZ1bCBWXel+g9lTzg8CUHii/HWFe3ypcf//kPY2aES1xE+Ik6PWS/lPjSyEE1IyoUK5Ogt50eSy8a1PChFiKCWOEBHh7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L0rWyoil; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55DC9FF802;
	Fri, 23 Aug 2024 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kB7RsilmKxOThANKEwiQDRFUDRaozJrT72dVND4PyBk=;
	b=L0rWyoilr8WfIm+kx7cqFPFnXYBzVv9ncPvfZsJjs/bfdKTdKkqZzdbNEJqAI1CF8JFKg9
	XvVUnraCuxbaiupy2/arVwwx7lhASpKAmqYsBwqwbqqUJakljASMTn9WZPi++5Jh4rTCUx
	0/ZymfspuSbp81nh5K9NYNYuaAB3ToxdoInpPK8zDUXsGQFb38Glhokm3c6eWvoQtxOam7
	bLiOPTna8mjqhqmsYksXFmfNpw8XRlF6yHFUX8SG+FBnSyksQhHfcW2ZV6On5YwFENugKZ
	WkHt7TlPOnzGUfy1GUiTuBFDKjG1SUqU3MZv953LFINc3q/n7TETv/X1wWPfzA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/1] mtd: slram: insert break after errors in parsing the map
Date: Fri, 23 Aug 2024 19:33:29 +0200
Message-ID: <20240823173329.441853-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711234319.637824-1-mtodorovac69@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'336c218dd7f0588ed8a7345f367975a00a4f003f'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-07-11 at 23:43:20 UTC, Mirsad Todorovac wrote:
> GCC 12.3.0 compiler on linux-next next-20240709 tree found the execution
> path in which, due to lazy evaluation, devlength isn't initialised with the
> parsed string:
> 
>    289		while (map) {
>    290			devname = devstart = devlength = NULL;
>    291
>    292			if (!(devname = strsep(&map, ","))) {
>    293				E("slram: No devicename specified.\n");
>    294				break;
>    295			}
>    296			T("slram: devname = %s\n", devname);
>    297			if ((!map) || (!(devstart = strsep(&map, ",")))) {
>    298				E("slram: No devicestart specified.\n");
>    299			}
>    300			T("slram: devstart = %s\n", devstart);
>  → 301			if ((!map) || (!(devlength = strsep(&map, ",")))) {
>    302				E("slram: No devicelength / -end specified.\n");
>    303			}
>  → 304			T("slram: devlength = %s\n", devlength);
>    305			if (parse_cmdline(devname, devstart, devlength) != 0) {
>    306				return(-EINVAL);
>    307			}
> 
> Parsing should be finished after map == NULL, so a break is best inserted after
> each E("slram: ... \n") error message.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

