Return-Path: <linux-kernel+bounces-299421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8C95D45C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39D4287A12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC4191F7D;
	Fri, 23 Aug 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LQoxKiTk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6C18FDCE;
	Fri, 23 Aug 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434408; cv=none; b=rgr9t8TTMO2uXi9jO9qfpsBz0Au8KLzVjrsxjwuxu5c8/qIJ9sdJ6a1FzgRyKCK2HV3RdmMUi/5AOq39oez4cl+qwfvVYBOP9QYRMkzuMRJivarwa5n8NzH1Pi9V3wYRFzqy9XpFhdC9odBVNfvqUP66PoKsf8C7CQESDkslyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434408; c=relaxed/simple;
	bh=UMOTQ/GUiVROuvaqXPOe/33RJ/idW+g5VJGymWjmRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi4BWEyXNX9vSbi6U0Z/veuPszAmqvG4QmZDB8sn2jA92bcPmJ9zERgRBCYeOSmgb/qsS+ZYyaRPJ0tIPxttyVvA14i5wJJju5dqK3vq5gQckXF6HQ4Yb/CXlesjMnp/v75QQYoFeYGMiwLs0uONSbHISuTyG9h7jopDASLsbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LQoxKiTk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B297E20002;
	Fri, 23 Aug 2024 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vd3XM6I+bhkf19E2ISY/vWU7c3FMnr6EDatsnOXb95E=;
	b=LQoxKiTkpOvuNiu9r/gu6JHkeBpOzUc3doyMjdFDwza6+Wqvi9vEpp1cFqNPsrUIPmGGgy
	4ulzXYAZGwahqxzh6f2M+pRywdJuNtnxAfi/QNaD889KuTB3oAMk/tmko418vlLEUadJUs
	2WpzxvxqC9SMS4LiQruqaRWepHHuuVUrwEDBnP/6UjxP5a7thYkPU52380ws3u8Q1C5ypR
	J07FaKOfQffni8BdidLJlnuDxUaTNHJd6Djc7kzCMT3vT5z5NguliUTwIy83fKbv2KtfHF
	zp/NgUG2fdgck1PGI01i3C4V/vAqHOtA6wySMd0KHGo2SHXG/3rrlO1JS3F61w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: parsers: bcm47xxpart: make read-only array possible_nvram_sizes static const
Date: Fri, 23 Aug 2024 19:33:23 +0200
Message-ID: <20240823173323.441793-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822164632.638171-1-colin.i.king@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e334c01df28225139cc831e4871c590a7851b4fc'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-08-22 at 16:46:32 UTC, Colin Ian King wrote:
> Don't populate the read-only array possible_nvram_sizes on the stack at
> run time, instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

