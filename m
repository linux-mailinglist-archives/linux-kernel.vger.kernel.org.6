Return-Path: <linux-kernel+bounces-424766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D09DB918
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D9B21B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D311A9B59;
	Thu, 28 Nov 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh9m54vc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2419CC02
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802088; cv=none; b=oRWwsbyKQw5mBin/I/w8eY51AClNjDv6K4z+Hz0fiMRZvJBkirS6zxqoTfHKRn2K+oVDKZ7j+gKFJqkkiBRlPV9SjJ8PSkF8hjVoTWSq1Ndzjiy4avaQodX05G8h6P11Vn42UudLTjLBQpatXZ11zK0PbLfsip2tcic20KffD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802088; c=relaxed/simple;
	bh=1ZZ9Yd7Mg/Tf4OZ5hcwN4m2w+RdJ+Zx5Gjoz5Ep3Hgw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=RsYUmwt5STU6TYy0xR3zSXo4f8pm5imHv3aYQ6OqlyLyWbW79CDAM6OVBNzchylh1V8LZxtA5AGjSlfNVyBDi3nyWgG1+S+vMIbmzqTrt0boxxV/FEQLbV80VutzUCL81UdcM6y+Hf+bKS2/8tlziDnNtk66f4Fc93J8/9OyT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh9m54vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4CAC4CECE;
	Thu, 28 Nov 2024 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732802088;
	bh=1ZZ9Yd7Mg/Tf4OZ5hcwN4m2w+RdJ+Zx5Gjoz5Ep3Hgw=;
	h=From:To:Cc:Subject:Date:From;
	b=kh9m54vcszeKVlv2nnfgcQCPqaSUs3RTkRCmE9B9Ey11tKsdo/wlTSqZymr6/7Y7s
	 lzzhlGV25JYM5q2lwskmLLYOMHIUeK0dxi4VOfJ7zIF2b8uSCzQoA3uvZ2fBCJciBb
	 UlVaK8ZxMxWOkgCLk7yP0tGBtiyHht3zjExGA2IVo3loMwOIhSWUDFLwSPnAXxFcPC
	 lRqDhs63W44SJeQHHfoB4arVwzhJYRIpZpZ0js6nWzZLVb+kMzZADxARAQaXl1Bfro
	 TZdXgtc1aBDs2KkShLZipBTIK5MEZluzRp9CaP7QN5MlturJWzS3S/pQtsucEkYS56
	 Hhz6WYlNPXvZg==
Message-ID: <4bfbd5a99af176813f7d8e165cb05dd7.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.13-merge-window
Date: Thu, 28 Nov 2024 13:54:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 21ccadc64dae18bd092f1255bdbaf595f53381d5:

  regulator: dt-bindings: qcom,rpmh: Correct PM8550VE supplies (2024-11-13 13:53:14 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-merge-window

for you to fetch changes up to 351f2bfe6362c663f45f5c6111f14365cfd094ab:

  regulator: core: Ignore unset max_uA constraints in current limit check (2024-11-21 14:48:25 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.13

A couple of fixes that came in during the merge window, plus
documetation of a new device ID for the Qualcomm LABIBB driver.  There's
a core fix for the rarely used current constraints and a fix for the
Qualcomm RPMH driver which had described only one of the two voltage
ranges that the hardware could control, creating a potential
incompatibility with the configuration left by firmware.

----------------------------------------------------------------
Kory Maincent (Dent Project) (1):
      regulator: core: Ignore unset max_uA constraints in current limit check

Melody Olvera (1):
      regulator: qcom-rpmh: Update ranges for FTSMPS525

Neil Armstrong (1):
      dt-bindings: regulator: qcom-labibb-regulator: document the pmi8950 labibb regulator

 .../bindings/regulator/qcom-labibb-regulator.yaml  |  7 +-
 drivers/regulator/core.c                           |  3 +-
 drivers/regulator/qcom-rpmh-regulator.c            | 83 ++++++++++------------
 3 files changed, 44 insertions(+), 49 deletions(-)

