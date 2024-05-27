Return-Path: <linux-kernel+bounces-190564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD38CFFDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F2228700A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FB15E5C7;
	Mon, 27 May 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="imvQUyHg"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015CD15DBC7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812341; cv=none; b=ma/D03bUpd7uxizD5ICxTdCh3Mmv6y31DuYcaEvaX+Ce/aMfHWNhEm7Vb/ZOlqYzxrwuE7sWZ582bpNN1SFovkn2YevRZwhMOJmz7d1lzzB1BDpEteN0vUDVEizqrJF0HgOfzE8Z9qGbHIq1Q/sMYiFNHCgmtM9R9zHQtgLL3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812341; c=relaxed/simple;
	bh=+0DkvV/Shnh4FyToP8SLlV89Oa6us0WIDKmx8saP17w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s22PHbYAu80BI+WO3iwoqoaMX34VIlDwyPRlGeKOQbYTiLs+8b1XaP+ZSn0e8sV11cqtixAqDI/75lQPbumN+ICooUuNDnZYEer7tqjiIratJNYgOA2teR2mxmOqXny2XEWcigvgTYKz8Ag7g20NIcEvEc6vDFO/7wPp9YXsosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=imvQUyHg; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7B0940002;
	Mon, 27 May 2024 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R7cFvSC577zVMzteD0DF9w8WqoOSObu+odjjrmcu2o=;
	b=imvQUyHgyIxwYidVmqJN9MmX9i3l48IJPLOi70z+9I5UTrUvBdtVjFvgVi5HmqRHZkXhS/
	kJQLjfYd37qYhC4cChZwiZg1bjmUeKQBykpk+G8m9NcaarYmL+Q+FDiT90cp7KMXSAfHln
	yLwgJYsMG+T0kmDSMmFnNfCMeNJJ0TaVVM0+COnsSgFHSK9jSP8Hoba8RLDIgBaOXVefsp
	dZUotLv20rKdxgE4aHGjHt5MsaNfoKhEDf1QCXdm2pJdymRR/Xh3dLcTP4GQk/yftg7K9e
	d7wZZxdjhoKsObq4Cb+BgaHCo7ImeJKg+zhEH5wTTBu2mRJJcUJU8PS15VP7wQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: nand: mxc_nand: implement exec_op
Date: Mon, 27 May 2024 14:18:51 +0200
Message-Id: <20240527121851.178571-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To:  <20240522-mtd-nand-mxc-nand-exec-op-v4-2-75b611e0ac44@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3df54960b63cce13c5b4daab5793f8e8b056c4ad'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-05-22 at 05:39:52 UTC, Sascha Hauer wrote:
> This converts the driver to the more modern exec_op which gets us rid
> of a bunch of legacy code. Tested on i.MX27 and i.MX25.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

