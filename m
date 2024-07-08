Return-Path: <linux-kernel+bounces-243933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F87929CA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1285B209A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590C18AEA;
	Mon,  8 Jul 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HQqpX/30"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629C125DB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422113; cv=none; b=WssAKIUCGE0gXqfgJBLv/42WXeSWjd+sA2fMkRjQmGFmSa9/9wBy+qqVpHWpINUnqNtxFJtrADtEApxFJGL5ILNFLQmG0pDP/ltlKW9cxp1oyw5lbg2ltrDEBKAo+eF3eJx0iaa3s8g92dX/xINDSrP+yOJpnqSlzbGvmbUEVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422113; c=relaxed/simple;
	bh=nPyN36GutmNhmyHw9V+VcOZE8+57QoYSa5a4nDUgRXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBCfSO4ewfT8+lnBmZN4U6PHuthVfv5Am1sufCTgLW58gFcERiC4Y/SLZMjFCIjBhgbVM+ohBxr2r5+VvB/HzJxUC9MMNjZfpVivoVKSkKwPdFfkHeo6URdHw3O2nngL2obZpalTQjuXOI6g7stufUk1Gk3RhusI4NxogmobR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HQqpX/30; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1672BFF80A;
	Mon,  8 Jul 2024 07:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720422109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IaAPKCcDN2cUovINHTRRQvROEbqxOoQ8Bs5uDLntLo=;
	b=HQqpX/30vAlKLZs+VPQX8TkROXwJN6lGd2F87LBBGmfs2suBp3A0rEa0YJlgWQ2iKarA/i
	xeK9FYkRIyfwSgkTWSNwDoM/nFp56zU6oCecHhn7Sre7pACTgcs2aNWefTCRJMNjzE6art
	Bj9YKZbevGkwX39CkTkRRR1znELptxIARDmbKLesK/krKz25hn5sDiTjjv6GYZhQbG6r93
	AHLusY9R5LTi+HxAEPS26+y9002xDT3qEQjsV8YjxFg7znBjfZaF03QKI7W8eSNVu6HFjV
	Opwsxua70gr2AUl+816+cPJj2L9VQGNWqXlPddF6RIVWMHE/i4SKfRiQYaam4A==
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
Subject: Re: [PATCH v2 2/2] mtd: spinand: macronix: Add support for serial NAND flash
Date: Mon,  8 Jul 2024 09:01:48 +0200
Message-Id: <20240708070148.12215-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240704024839.241101-3-linchengming884@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd7e25375f7d988cff65823119961f3a75f2a8c69'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-07-04 at 02:48:39 UTC, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> MX35{U,L}F{2,4}G24AD-Z4I8 are Macronix serial NAND flashes.
> 
> Their main difference from MX35{U,L}F{2,4}G24AD lies in
> the plane number. The plane number for those with the
> postfix Z4I8 is 1.
> 
> These flashes have been validated on Xilinx zynq-picozed
> board which include Macronix SPI Host.
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

