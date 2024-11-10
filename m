Return-Path: <linux-kernel+bounces-403103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3E69C310C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF04281D26
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5A149C7A;
	Sun, 10 Nov 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wP3xTUyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B18EED8;
	Sun, 10 Nov 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731220318; cv=none; b=GdeGCPPcG/u05S4o6ht2JimMlO+TQrZh5PgEGzbZiKSMX+11RSAsLP9SVDrhS1Km8osPbq6I4VyoC5GEXA9CPyoSKH8pl+X69ms1wPc0ZoeTDKn50XvcbNgR1KbcwmP5T3VYv50Hp4WcNmtCxXnzvjtj2YByovPWWPrzoBJ0sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731220318; c=relaxed/simple;
	bh=fzNdD925ObhXP254JcPMkti77begVal/v/vinG+FHHE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kHO5biJukf1PcVq3e4fI86VCKWwfQO8xaY7FHlx5GKnn6qzuaIzawzvRVCm2HvkbHbuzHxU7QZmn9WtmJVDIxrCqkUqBkt1T1mb706R1sF7sOP2voJu11XzyhvwVy/HHhlRNdLKF3SdDC/94fEiO3vFLcshQPtm1LD2GEjfph8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wP3xTUyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1623C4CECD;
	Sun, 10 Nov 2024 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731220318;
	bh=fzNdD925ObhXP254JcPMkti77begVal/v/vinG+FHHE=;
	h=Date:From:To:Cc:Subject:From;
	b=wP3xTUyI3yRGB7KFHx6AV/LAlCKha2u7KT+gJ7Wj3PP0feXjnQ/4DH8xXu/bVoHCp
	 lhr7QPm/mzvUL64uM+ijUNSSFrxv9kr9iHIcm2OC3CqQzooaLoxh4dmerQ5iwWS7VE
	 17ium454yCx4/3rBDSFaB28+whLT4K9odhxkJX3w=
Date: Sun, 10 Nov 2024 07:31:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.12-rc7
Message-ID: <ZzBTSKyx1daFpdky@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc7

for you to fetch changes up to 807babf69027b4f1c55e72b06879658e83830880:

  staging: vchiq_arm: Use devm_kzalloc() for drv_mgmt allocation (2024-10-19 10:04:57 +0200)

----------------------------------------------------------------
Staging driver fixes for 6.12-rc7

Here are 2 small memory leak fixes for the vchiq_arm staging driver that
have been sitting in my tree for weeks and should get merged for
6.12-rc7 so that people don't keep tripping over them.

They both have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Umang Jain (2):
      staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation
      staging: vchiq_arm: Use devm_kzalloc() for drv_mgmt allocation

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

