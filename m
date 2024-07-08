Return-Path: <linux-kernel+bounces-243935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA73929CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED43128185B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10621B5A4;
	Mon,  8 Jul 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LyfU1B3B"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884817C66
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422123; cv=none; b=qONLFSOl9iH05rSRWoz0XHyWsbqAjwRDEa1j8C7H2zAy1OQHlaZCOPfTizc5aY3d1dXm+ryQa3xF0ixHrvTdxg8UErC0lqjBq043N1JWZYBja0n8ppEJZwEnIwc+ZaX9pRM5XBfbUwyBIUlcyUyHnuKscVFy/95Cl5qHcll3QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422123; c=relaxed/simple;
	bh=q/bgiJfm/HdA6Cv5ovtlFies0lVWr9NNP3EY1Gbk/ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpfSnwFYAaWQ53HgGeZHQfxqEoPD/ABRKsPGwDpVqYUadcuiiWkTMQPcm57dPEWSgXoDPMrfeB0qz+KC7+CBmP0V3vmCobhTRoX7NPkKaQUt87TF28BUAajhueRvs8qmBhkIS+rJGj0H+RLX1Z60vvnBZszJKY+awuduvkHdFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LyfU1B3B; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B88F20007;
	Mon,  8 Jul 2024 07:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720422114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+I3UPmsCQqa7VNrWRNTEA+DBLGE5VNKe5lzl9UQuF8=;
	b=LyfU1B3BwJ8dUJv9SKTWE7K8enxz23xs4syYwBby3SGdAvHwr0StbteCkbeXIllsLQYpte
	4u477vOwS8ZThtOMDyq5fAPlPg3Z0a0nt8Mqlpw1VEBtMwcih3NbSXS65i3RWaYWzcykAM
	i8uZrb7JLuWAucR/cdjkbOe3H1CM5HkMxM+3UVfBDTQ3lXcRUxSU82DZXboU/Rc5MK71G1
	j1WrC15+260BAOn6K47cOErVHrTPcl8NHT888iYXg7uQUt7u3wfDXjsRhfI9H016U4Wayh
	RmTg1iM3GA7k79E1zIoopNUif5EfdZkcbe0itEXx54XTp3erV6Hsosen48vS6Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/2] mtd: spinand: macronix: Add support for reading Device ID 2
Date: Mon,  8 Jul 2024 09:01:51 +0200
Message-Id: <20240708070151.12247-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240704024839.241101-2-linchengming884@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'20dc4c711a2a3260f02f15e1cdd4f34cc38e8b4f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-07-04 at 02:48:38 UTC, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> Adding the Device ID 2 on Macronix serial NAND flash.
> 
> When the number of flashes increases, we need to utilize
> Device ID 2 to distinguish between different flashes.
> 
> These flashes have been validated on Xilinx zynq-picozed
> board which included Macronix SPI Host.
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

