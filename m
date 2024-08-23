Return-Path: <linux-kernel+bounces-299420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDF95D45B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708121C21FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1EE18FDB4;
	Fri, 23 Aug 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DvpcqYDe"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFD18EFC9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434405; cv=none; b=SWFyLv23e2r8yNdfhoqeP40cQbyJ3BbzGekZax/av5HEgfYj1BNjVJkuPV2KKdMXmzajDM676WJyIVwTiLhAv2wDbswVKLu+2SnOLXCAyiiAB3I5dBm6m1vMf09H2/SswdbZLylcXL01l1qd3adxRgsbYBQCRjVQYWuxEBRwSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434405; c=relaxed/simple;
	bh=K4cq+OOOrTA6ua+XnnHZvCHegNDpKNDn0pYdSFgtsPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3ykyxgNpox/FaZV6mCLrT064IK6YVK/TSDKHZlZ0QfnjPWwOF1EkU2rM9BMCggiG1sjWRD+Lqk+S0IzO6jUkp4fi7gNHLnWE4vqfgiunlfqWr5/C3SRu+80X/M7oEgdskH++ljfF1qIxqY2rKzHtUR60gWHooWFjXQw7tCxVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DvpcqYDe; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD232E0004;
	Fri, 23 Aug 2024 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilACbOsegEYw+lBMnWMXh1/9ZyigT+kDzQKGVXWORHI=;
	b=DvpcqYDe0fQuJYt4lytCQxrM0MQnDnY3KrQ7NX2eiRJP0We4t1QemGU38UdLhRXIxxYobi
	CrMJCXNWSO/Ftqk7gG1mdbilpZJvIDCy7dWhHTtuAO8vpBlCqvCNoRVt8lSY6m53xB9Mzb
	e6jmm3rqPBe8rvpuZgYiDNhrBRnaTeHL59Mmj0fpeVwkpkXEYEi1WKwkYxCE+nuynVjUTc
	y2jyJmM9w8z25hKKcC2V1GLUgfCAj1YG7NzR5MSjIL/+eBnRTkZsUFMFdYXD0cc/qjvo4f
	4AtcMagb36jY1XJHh/4OB1RyySPX0wkokZEWAYewI/t2I5il73Jgjd3iPt/xuw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yan Zhen <yanzhen@vivo.com>,
	vigneshr@ti.com,
	miquel.raynal@bootlin.com,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] mtd: concat: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Fri, 23 Aug 2024 19:33:20 +0200
Message-ID: <20240823173320.441765-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823110824.3895787-1-yanzhen@vivo.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'175086cf4acdf4ccd3d7a6bb5c5231ececd6656b'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-08-23 at 11:08:24 UTC, Yan Zhen wrote:
> When we are allocating an array, using kmemdup_array() to take care about
> multiplication and possible overflows.
> 
> Also it makes auditing the code easier.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

