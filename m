Return-Path: <linux-kernel+bounces-374047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA319A611E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05928283C24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864B1E4123;
	Mon, 21 Oct 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UUZBUtrN"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FD1E7679
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504969; cv=none; b=mrgfasYTlXNPGRsB2yi4o460lHqJhOLmRJo0f9bYxsXWMQY9kANu5IbtnBmkrxj3GMq0CwSgMAMK6PnXVHvhZQ37DQI4HLU2SHDKRyxafnPI0EZPVeelDJBKKDdrmz7KIawyiss0/H562rCbgAkkGVBPdFmVTQpzu9xIl0MjnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504969; c=relaxed/simple;
	bh=RHONku79JIKEs36ukPML16Pl8FGk/ahOecctK7C8Zvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIBOCs6k6ieyfqzJmU2dC8kXuKpAM4oukmgwhUeai09Io7Zva8cWQfF3Jt2fKxMMSyvStjcWBaqDqtj/aLensH1CdP0B+54gfFMkWgybpl+5kaHukosdpLC2JIBp/H640+WBAeuUyF2SdGsJAukOmIGcgQF9Po6iAtS+ED5DLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UUZBUtrN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E900FF80A;
	Mon, 21 Oct 2024 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tcu5dEoi9gB94N13JkzIpnDDgeeEc2xXKWP4KS/Ty58=;
	b=UUZBUtrNRLfKQVFAU3PrmVGwA23zlSfyZlbpzWMhaCoYIriBg0IkBXWS8O9Ork9uSuHE8J
	m9CR+56aGiRpLpKFcQkxGR7HOhLUzkeLe5UT/NZgEvQ5tmIIulVLy1NGUq6A5RTdnpEaXk
	Ykh0hbByMt6TKm1LjR1gCIj4GNbuB5S7nZDNRWd0FGV5yIKvBNwiiERvggNfIjidfZEPM0
	xUbCHfxrZIBYBNXEkFJWNvBJ5TGzn9KGfYz59w9/pxMR7funDILlFwfDYtTVNWkY+pqQEf
	aeggP8r5kbMFa8dAvj8QvbWBZF7d1pnMmZVzTnubbyDsq8Vhmiu4XUr0gAU2zg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] mtd: rawnand: davinci: use generic device property helpers
Date: Mon, 21 Oct 2024 12:02:44 +0200
Message-ID: <20241021100244.173421-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007122350.75285-3-brgl@bgdev.pl>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'905050b01499fb80dbd579e8ec13b19eb8f59101'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-10-07 at 12:23:50 UTC, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There's no reason for this driver to be using OF-specific property
> accessors. Switch to using generic device property interfaces and
> replace the of.h include with property.h. This allows us to no longer
> check the existence of the associated of_node.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

