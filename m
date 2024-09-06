Return-Path: <linux-kernel+bounces-319113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE396F7E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206B0281850
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62561D1F77;
	Fri,  6 Sep 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M5owgzrf"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767651C9EA4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635425; cv=none; b=cyJW/iA61pHVb80We7D/dLYDorR0cBCuirCdO2eUiphfiSbOMmv+ISYfd+xuYjSZbEuH2sArHg2G0hbicxECnRSKFDbP+877ssJ6Mekbo5GV6hvycZgyaZFWTbmrzo7VyWhtu1EZm4ElW4/yZE2A8BCRyoogUKNJ4VQdngJnFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635425; c=relaxed/simple;
	bh=9s7PhIoWAfK/mGPwqaR0MkH/KvuRTXyyFYgwLcjhqVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgd82k1CilUg2yH367NBmFvchRWZAgUdiXKtGxPeSI+TD7TYNtosOz3W51nqVrAGAT3kAz7vhygdjOFy7Wp5GkViVbb307NWuqOIn/vCJVjkKK/AG6I9R29dJNU8GIsjO8NTD8vfWCt6G1vrsmB8RA5Zg2NgdGD/MSaRnsC4NKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M5owgzrf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 982941C0003;
	Fri,  6 Sep 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725635421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZUTVAepqA+jwCEzGkgSw+Dy++rZGvQ4PU8h+QLC69A=;
	b=M5owgzrfDtz62VtH/Mb5OyRrqhUwReZC3YK7qTz8CR+5MKjjWw32W7y3S6V0Ec2Nw3A80t
	I8rbMtTiHV1Gs4gSN/IAcqPJ84qXf002ZvWJvkBMg6Rvy+dbU/n9yW8t1j3fJw7rEx3cIo
	nRxvFdnhw3j4/7NKzzK3It43BzhRpaNY02TxslEg7RRGh3wNFf9umYZ4fehJ/KuB2Eriu1
	AGemnkOKo/vj0LrNOUKAUVK9fatosuHEaszal35qrzNYPMp/4IshMeK0nYPhXE853KdaZ+
	+8SujWPGnVVw5CL5q4Y42NrLBUSejtXKzvMv9TgpyDOyMj7Md1o/Mvb825Y3Ig==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 05/18] mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Fri,  6 Sep 2024 17:10:21 +0200
Message-ID: <20240906151021.736425-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905122020.872466-6-ubizjak@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'098a573b6e8b8515354c1e07a1c54990435340b6'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-09-05 at 12:17:13 UTC, Uros Bizjak wrote:
> Usage of pseudo-random functions requires inclusion of
> <linux/prandom.h> header instead of <linux/random.h>.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

