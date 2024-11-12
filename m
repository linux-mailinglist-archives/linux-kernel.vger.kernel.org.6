Return-Path: <linux-kernel+bounces-405859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE89C5837
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E84283AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C861586CB;
	Tue, 12 Nov 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dCqx8Tz0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08B156F3F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415619; cv=none; b=sgQ47OmQ7fvVNaP++vQ9ov5wVg2wUXX2xVie0ouXg2EUGWTphvAtFTCuQqcaOUlmZUUsjhwsSc3mUMob86+Z7AgWUxm0EOp43FAyhIgAi29fzjtKa8l1nWsnZiuitwfchwAANhCwSarORcLUk7DAmhy0L0WflvmA9KU0UArUiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415619; c=relaxed/simple;
	bh=O+/mtmVqduJg0yRU/t3LboxggqN7gL++/KKATEEOF/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0DM2rAfT9B657e2m27uyocIOEy5hDa8WFhxpiNeuKPXNmSAnO8WdZY+9doCMVEAcI/53mPZWrkow5cDE+/N4iT3aKyInzri3DbcrmrLjkyXOLoHcoyVSyNQHtsl7fAxekm3QM5HnPGzzziwq0WvRGCI50+uHB/3l6Q0D6J3+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dCqx8Tz0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731415616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JfTzCc7j/rpbNiCvvhNvhkIgzEGfWIbjeXy5YHO7tfM=;
	b=dCqx8Tz0jTpXE+yiDVd3yr9ubudztmd43oV9H9A0LhH6KLdOaGdUHWAGd0HX1Zu53iPts3
	M66r9VjG3QzYa0AybP02Zv/rXF+beOgs0EAPPXtrFb91CiKJ2v/AhcRWVuBw0rfqUERqTH
	bfKxBcinOQwkQKHLi19eoaddwAfCWQ96Mb5wxPg6OwMr5Tnu8BqylIX5ypnToa25MHymG5
	C7192YFHEnaneFL9KDiBXMO20yCZIgGdKQRygfz2qSslu9eqO2BmOIPe/K7S1pXsEOJS0v
	+ty+VtkJiOzuh1Sz77dzSEmhzSjuMRO2Q24IsSPvpdA3B3YxtJuzWHV9xYnWDQ==
To: lee@kernel.org,
	wens@csie.org
Cc: linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] Use devm_register_power_off_handler() where appropriate
Date: Tue, 12 Nov 2024 13:46:46 +0100
Message-Id: <cover.1731415409.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a tiny series that simplifies the code a bit in a couple of MFD
drivers by using devm_register_power_off_handler(), which is a purpose-
specific wrapper for devm_register_sys_off_handler().

No intended functional changes are introduced.

Dragan Simic (2):
  mfd: axp20x: Use devm_register_power_off_handler()
  mfd: stpmic1: Use devm_register_power_off_handler()

 drivers/mfd/axp20x.c  | 5 +----
 drivers/mfd/stpmic1.c | 6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)


