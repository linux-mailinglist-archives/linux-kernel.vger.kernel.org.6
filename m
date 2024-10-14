Return-Path: <linux-kernel+bounces-363809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8A99C756
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120C51F227C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB7183CA2;
	Mon, 14 Oct 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bxSxiWmY"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111417625C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902634; cv=none; b=e2JD6/gVeMmyjNyiYUfjz1TgP5G16AnitK5E7+pb5MrMJL/I8fhM5y5J80cAlVWsxYT91mNEFM1YyEQOBvxI3Z+mCzB4WUykK2WrEx1cVNGo7eATxtC4zNzZuC4M6E4o/1Ac4JchK+0IZ9Hj8C/gTNOkX/Xt4lih8jg4W1deQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902634; c=relaxed/simple;
	bh=KNmw4EoGmfTC15o/DHmrMPh4RFHqsX5qaXgSFGRsPdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uUR+/GVDt9WhsW/R89mpGfTtwqlfg/CGRH1sHur8yv/su+X/z4qZwCnys1pw2mPHY2npK2HBkKbeJ85drmnEA5Cppi3tOD12CUCHfv+ZQYEMBq3y+Xlauc33tKgT0DDzY9o+W93ktLVl+K8wVPLbr0rX09e3AiLouFA5M367TKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bxSxiWmY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728902629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kTtU49jAZt+GMuY9hdcUXdRTNTM4uQk2ZKyxJx9kNS4=;
	b=bxSxiWmY1biH//gBzN4IfVicDZSnyurBw+SngafUdYJhegVBHsgFj3hOzG4QQhqeYC5lpM
	UgUwG0MF4zv4hXI+Op70XBwBqEJzSwYdXeRk/YlnF33Stu+t31Pq69Xs0CNL/nSVbNBFHg
	w4ndC0DMIqdUhVP72QrzSHXROw0826RuBFE5dWe0sfS/KmmBsRjUioBKcVMTp9+5F7SwrP
	Q9NsDEx0gZjf66JXQT+SbVuSmCGvFDTth0lLLixVpPHcdZrvogjxI3j81+06YwGwHOGGmZ
	gmx1qcIw/8WeAFD03BK+Q2YNbXBrvYHstCAxLEBkSQw1rhliMAEdjgCcBvhzng==
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Allow use of DVS GPIOs on the RK808 PMIC variant only
Date: Mon, 14 Oct 2024 12:43:38 +0200
Message-Id: <cover.1728902488.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that primarily makes the rk808-regulator driver
more compliant to the DT bindings, by allowing use of DVS GPIOs on the
RK808 variant only.  There's no point in allowing that on the other PMIC
variants, because they don't support the DVS GPIOs, and it goes against
the DT bindings to allow a possibly misplaced "dvs-gpios" property to
actually be handled in the rk808-regulator driver.

This series also cleans up the code a bit, improves some comments, and
replaces dev_err() with dev_err_probe(), where appropriate.

Dragan Simic (3):
  regulator: rk808: Perform trivial code cleanups
  regulator: rk808: Use dev_err_probe() in the probe path
  regulator: rk808: Restrict DVS GPIOs to the RK808 variant only

 drivers/regulator/rk808-regulator.c | 41 +++++++++++++----------------
 1 file changed, 19 insertions(+), 22 deletions(-)


