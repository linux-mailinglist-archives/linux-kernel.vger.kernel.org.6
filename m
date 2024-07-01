Return-Path: <linux-kernel+bounces-236197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8291DEA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5418285CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB815359B;
	Mon,  1 Jul 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKdIXZjj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CF153563
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835231; cv=none; b=TSSRhHHu0/cbAbewjHDebxr62Nd4NLzdHUYmjjWD22XIyNgfy/vejlWhiE5P3hAGp3o598kIfDDSUi9vlBgp9hdM/4nNbIQirzYVLzSRHCO6ndzjBMCrnXcyW0wY4qr7prbimEoFSMIy3eQjLQ8o6CXn4GHaCveWqH3R/0snUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835231; c=relaxed/simple;
	bh=XcpLI/ft75AxuL+Bs1bMWy1WYi6sKFPIpWsegoQFfuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhQvRi+JIeDH7Naigh1QLPoEQviDGjVYpYpuuraB9WB80518FDuf+Y2VZd9al2LzTP+tITzJfaKh8eMtur0oo1XALxx0vJ9hrUVF4Gnqw5tIhBQglL28voeBP674AOb/XYRozP+X2HpctU5syRFvmAcwBbRsOW7uwfTdBWlCN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PKdIXZjj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21D8DC0002;
	Mon,  1 Jul 2024 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stCq6xm2MokH+wKmsDICPsDu1Nj3JaDipa8NgCyyLi8=;
	b=PKdIXZjjZcZR1vP07WHZRVqmsM/pWwO1uTn47KNy/kpgSYVk8QFFU88I4ezo8OXQPGed94
	P9EBNy0vRXlu6ye1/+N9dCiO8D6fQb/QDRdpzm0drDPhHJbVt1QItH18l7G6ApbOkQGPGM
	G3kkKunePH1JNhtkoVCPtoEOaso4r2OIE0JarZZ2GtTHHK9GP180/rnHRde9o0bGav1NEn
	06dN1VQlrKAfGd9HJS9cV8yyZo2fRvhsA+tBj8Gx7po5gzcUpTgy0srr7j3feqI+UUrQ9t
	vP9YbbRp8fbXLS923T98tvJMcmfxaMqsfZruwBkTOlqc8XRXCZ4B9srGny4T4g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: rawnand: intel: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  1 Jul 2024 14:00:26 +0200
Message-Id: <20240701120026.525512-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604212919.5038-6-wsa+renesas@sang-engineering.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'177bf19628dcf214c658c08eb1e41ab9c373e7ff'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-06-04 at 21:29:21 UTC, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'unsigned long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

