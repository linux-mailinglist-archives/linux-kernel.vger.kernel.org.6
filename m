Return-Path: <linux-kernel+bounces-321102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D7971485
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED62284351
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B91B3B07;
	Mon,  9 Sep 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aZ7k+wmB"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C41B29A5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875794; cv=none; b=cfGLw1HAxgKWScHkcS3Sm8hsd400cgtBQb5z7x+5gsjSJjj3A/0TfuJIv7R2PErMveHAqWwCHIB7jvxxRqrBQ1Kh7HNKL6ZbnyTluR2kmqkWFgtZBksZrMiqHRqtqltJoFAqVuu5TaGU2anBSpkQ9+j87VX0jFSr4OJhOsW/Doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875794; c=relaxed/simple;
	bh=lZppNWrAVDDYoKJO519QWgaMISzRluAgisfiFGscreI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUYpA3kI7aePXb2q9JwVbUUGaQB4RjNHDkLmYEvl+zaRffpKch8e8K5eeFqJpXTHzTlToSttGVP2iYIPtNqFi7I0T5oEe9cqD4xAFV1AjYk0MObcQ/zHKjLrVWIvgxg5KCYwQro+4yiCmxoZf27P+fMjxv0ADcaR/maXYCWRuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aZ7k+wmB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B66251C0009;
	Mon,  9 Sep 2024 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725875790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y5Q5NHxCQLDcTvXiEXz2NAloD4ZixOFnxmmJTc6rbw=;
	b=aZ7k+wmBWAn+JPADO4pTvstmnXuh9rXIN1tptlwO3FXWCLlrHPpwwiZ0ZXYbSye/GW0EOA
	LZ9etEjSzpxKAN861m8BJSkwnKfPqV0u6y1wW/8sbqgCB6jzWQCmRb5Kqd85DzdIDeixG1
	S6ZJNQWBW9FoDfVzJmdzCgs6qph+OeYByS/DSqq6MeKLv+Ift9sEJAgd+TftAEosFDwbZ9
	LBJFltBV4rNKtg3x9MvFNFFaRn22c7ktXGaT+fxHPPwUtbzaZEM3c68q4NbhshRzn+QlM1
	CTfpwh1Hc0CN84UjvfFDKDbCvY4nrX0zgWbonPwJwduzWy03hspsSf53hLQw6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v7 1/2] mtd: spinand: Add support for setting plane select bits
Date: Mon,  9 Sep 2024 11:56:28 +0200
Message-ID: <20240909095629.20698-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909092643.2434479-2-linchengming884@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ca229bdbef29be207c8666f106acc3bf50736c05'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-09-09 at 09:26:42 UTC, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> Add two flags for inserting the Plane Select bit into the column
> address during the write_to_cache and the read_from_cache operation.
> 
> Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the write_to_cache operation.
> 
> Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the read_from_cache operation.
> 
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

