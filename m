Return-Path: <linux-kernel+bounces-433001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243349E52D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C0A1650BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770CC1DD87C;
	Thu,  5 Dec 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PM3PNEOg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FEC1DA60C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395419; cv=none; b=kM9t31D3KiwFT8Lj44NMFUBehKf+5qzCsouC+GwmzX8DVgn9km+DlLJDBnZptm2iedJnqmJMqE57JF8vPYXWBqaid0y8szL4GcCapBjR7twNN1Zz+6ZJ+TikAgEfiAPutAhn29yNMfcYzB11o+5v1o67XZhQUtM+xnbeP0vNFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395419; c=relaxed/simple;
	bh=U2ziYZuINOr524CTLEwSUuoZt7e8AqpSvyEEq+pA05Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i62q+Cmt7KVLxFNycphLYOS9kLp8NRp708b1DCuTXaP/NyfoKvQnI8I0xPh7wjsoM0hln9e3u3NLMK4kDiGLSIiLGNuQMwMuF+qHE1RMhbbGACAIOGrX9BaCyHwqNAXBkvtucvVJ9RlNJ0M5MLfppwcoa8LYOxvuSVWa+Epfv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PM3PNEOg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50B80FF80D;
	Thu,  5 Dec 2024 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhvvChap9ZOF4+7oCzotq/RCUZEJw7jw4NJIfwhkUzo=;
	b=PM3PNEOg4sXiuUueXBwTcZpDn7Kd4SK3eld/tb9Ibzg30kaDHjCa+UffCbpBpNyd6x9SkY
	sile5ymQwabW0ApN91TxuL1BZil3W88aIBPEJfGqBsiqhyXj5kwM5dgGX20/BK2ZNU/f7R
	lMpVh05dMcjRh9RkcipXptXDwMdliLeAJ6IyLza7BHjMYzeCUobEAr0lXvPyVVFV76AuSd
	o/+9mLCOPHFNG49t46sdunsm+HmrDDNyQGwh8AO+c+A3khJMzZrgDunXgQYfqCoYKy0Wk4
	mQAMGBY8cVo341KAFDd1VvknJJ8RqauKYm7dHJaCtZ7t4ImOGoYWAkqaMtfXIw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mtd: rawnand: omap2: Fix build warnings with W=1
Date: Thu,  5 Dec 2024 11:43:28 +0100
Message-ID: <173339519121.766262.11889443513973056861.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203-omap2-doc-fix-v1-1-f46cd2a5c055@kernel.org>
References: <20241203-omap2-doc-fix-v1-1-f46cd2a5c055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 03 Dec 2024 15:33:17 +0200, Roger Quadros wrote:
> Add kernel-doc for functions to get rid of below warnings
> when built with W=1.
> 
> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_in_pref'
> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_in_pref'
> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_in_pref'
> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_in_pref'
> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_out_pref'
> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_out_pref'
> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_out_pref'
> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_out_pref'
> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_in_dma_pref'
> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_in_dma_pref'
> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_in_dma_pref'
> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_in_dma_pref'
> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'chip' not described in 'omap_nand_data_out_dma_pref'
> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'buf' not described in 'omap_nand_data_out_dma_pref'
> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'len' not described in 'omap_nand_data_out_dma_pref'
> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or struct member 'force_8bit' not described in 'omap_nand_data_out_dma_pref'
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: omap2: Fix build warnings with W=1

Patche(s) will be available within hours on:
mtd/linux.git

Kind regards,
Miquèl

