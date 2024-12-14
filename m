Return-Path: <linux-kernel+bounces-445776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652C9F1B74
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63B27A0396
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBF2CA6F;
	Sat, 14 Dec 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxbK35Gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80885C2C6
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137280; cv=none; b=RpPFceBpMahtrRYel5OQ+m1VTLuLgJSP/mA/8g0J3icFQTB8/tIjjMF00D+tideUqF3vkJV/2LrfvuXNS9299iBYEyO04NNP9kGhcIsKKzJizJP8O9n7z27TRqkfzZkadEsHqzKE5hq04Ajy6mUnpdimQTYLqTy7tdXJkl8BD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137280; c=relaxed/simple;
	bh=ZWUapzYBfg+yA2O2i7ZrPdQKWk4wYGSt3Gk8wNYzf90=;
	h=Message-ID:From:To:Cc:Subject:Date; b=IMNewO9hIklS+ur92TL1a/+qvKWEdDgrWaxv3t98x8oU9TXNrRwmN/gMkbBLc7LprjqrziYCkSp7FXPMVJ/m8r/xPhqF2mK5cUIUVOA+7/yd05v2UKcODxFrECeYjKIvd7zV/stYomwCExcozAt0pVxOIRk/mjPYpgFOuvGFngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxbK35Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CEAC4CED0;
	Sat, 14 Dec 2024 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137279;
	bh=ZWUapzYBfg+yA2O2i7ZrPdQKWk4wYGSt3Gk8wNYzf90=;
	h=From:To:Cc:Subject:Date:From;
	b=kxbK35GpjDP4X+Zs0ebwZiAInahkFM3mXqb8rqpv7e9kdMhDv7IjGyzEF+WyEXxol
	 JMDjr0kDzyD08Eg0su74n0jL4Tj5W65R96Q3wv9pJnVzSe5bptk3GIUMDFBw0ColkH
	 m45KbBPrEQqY+t7p1iNZKNItcUGozy9CoQzVx9LHzAWwLTwnvWZ0DZZYRCLjWjdo2o
	 wjSpMDGqJVcjOoSdvatTwZcc9TkJSiwWTxlLnkHcj+kArIYxPrLr6NC6DOxkAmRhKd
	 tld0qnMRyWyuTjDD5M+Q+ZT+d/SVS26m4TQ435SmJaRT4X3nEm2y5vOWBA1LnMBi+/
	 YgopIMfghZKWQ==
Message-ID: <9982142531c7617c43646d6e7042267e.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.13-rc2
Date: Sat, 14 Dec 2024 00:47:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-rc2

for you to fetch changes up to f07ae52f5cf6a5584fdf7c8c652f027d90bc8b74:

  regulator: axp20x: AXP717: set ramp_delay (2024-12-09 13:06:07 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.13

A couple of additional changes, one ensuring we give AXP717 enough time
to stabalise after changing voltages which fixes serious stability
issues on some platforms and another documenting the DT support required
for the Qualcomm WCN6750.

----------------------------------------------------------------
Janaki Ramaiah Thota (1):
      regulator: dt-bindings: qcom,qca6390-pmu: document wcn6750-pmu

Philippe Simons (1):
      regulator: axp20x: AXP717: set ramp_delay

 .../bindings/regulator/qcom,qca6390-pmu.yaml       | 27 ++++++++++++++++
 drivers/regulator/axp20x-regulator.c               | 36 ++++++++++++++--------
 2 files changed, 51 insertions(+), 12 deletions(-)

