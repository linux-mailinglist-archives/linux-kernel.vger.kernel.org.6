Return-Path: <linux-kernel+bounces-435215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1C9E7484
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136B22833C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB820C004;
	Fri,  6 Dec 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byzygx5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB9154449
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499557; cv=none; b=tAtFHH3DKLwr1vht2xzXmNf8NEVl82LheOWfxRK227gZdinYiLUntdHJuloq3eKZDcOpZEbCQir6jDyfHzeRLBUC1AWua8z3FdGPjegLKKonwxpsplLBPliAJkKs5YSoSU14NhihCoxVI3PtCMoIJka1HPAnb4agEwu9I1NkG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499557; c=relaxed/simple;
	bh=KaBhycspzOQaRZHQjqxn81Fl+CWLiTyHkGeUu8JuXSY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=lQGJm+unHj6UO3eRvPEMQ8HkZyy9P+D4wMiROldF1Mw0h7E8hpfvFvE72P7dS0PFXXF9WAOaM72IbPH4OtcwMnQZxIpiV9ti656ICTZcFl8Ouhr3mVtXy/hQleWCdEkFZHHuZgcYpgvLDs2dEd1uJpTjq0SnySpD/9bqY6+AX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byzygx5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06175C4CED1;
	Fri,  6 Dec 2024 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733499557;
	bh=KaBhycspzOQaRZHQjqxn81Fl+CWLiTyHkGeUu8JuXSY=;
	h=From:To:Cc:Subject:Date:From;
	b=Byzygx5fpxbmmAaUVoeQUedCf5b2ycaiAME4N9stLWG+H4qXK0S4N8WAaNBakX+Pr
	 gjeFtrMOYsqEErz8iz9ScmTaBPdmhSxKtiGt23z+8op5LVwmQme7ZAz0jcn6MDzH4U
	 jU9/hb6p/HDEe2ZvAC5SyUMwkXogzdE/+Y/YwQIxDlW60uo6JclBIMH0gvSoF5FOeJ
	 7v7wVxAlSZ/9bnGUNMhq+Sk543iI2vL6KABiJOT9jORy+CVpc/+h5glK2WLuoxsDx9
	 hhmnSNPAiqi7DtkyGHjylR0RZ6eWU/QCtXOfvOuQwl94js1kbXqJyMtKW+j8nWam53
	 FOgOrPFmEOrtg==
Message-ID: <93ea3817b0aa8bf9e95e9270537af268.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.13-rc1
Date: Fri, 06 Dec 2024 15:39:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.13-rc1

for you to fetch changes up to 3061e170381af96d1e66799d34264e6414d428a7:

  regmap: detach regmap from dev on regmap_exit (2024-12-02 00:29:31 +0000)

----------------------------------------------------------------
regmap: Fixes for v6.13

A couple of small fixes, fixing an incorrect format specifier in a log
message and adding missing cleanup of the devres data used to support
dev_get_regmap() when a device is unregistered.

----------------------------------------------------------------
Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

 drivers/base/regmap/regmap.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

