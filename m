Return-Path: <linux-kernel+bounces-198148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AC8D741A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EB41C20A6E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B22745D;
	Sun,  2 Jun 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk1Y/Ogd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCF2574D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313021; cv=none; b=NKdS6woVq9E2J8aWgKPY+X51U8d0TyoRqGyHIQnoKQkXM7K8ywwkj1RyPz9O1xmN1+TF4q/vAJ1qnKTHYrhV5XyxS87wRFgm3rhUWYs/g1pIEY14MYmBtrf3Bsc0QKyoH4qCj5u5auLJ04u85RDRaVIu+WnU1EdtLBigNBnxzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313021; c=relaxed/simple;
	bh=YgYwRhUxrQXGdmrAuaYQ5dQrz07WhCPTSXpwDXmQy0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gJWC7CGIL/l4e6MuIItdlaNgosWqt5h6yOGJVxRfX3TF/fTwrOMxT+aNG5304EY2FeTxy9Ts13d4ZTI+A7c0qP1RpSAx3ax+pqUAJGxoOjFgibgv8twr1Hot6tBoL57NAG21z83wQQlgWhvohtR+o2CViJW8vw8924jtwjG+s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk1Y/Ogd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2D8C2BBFC;
	Sun,  2 Jun 2024 07:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717313020;
	bh=YgYwRhUxrQXGdmrAuaYQ5dQrz07WhCPTSXpwDXmQy0s=;
	h=Date:From:To:Cc:Subject:From;
	b=Rk1Y/OgdkvR+hy0sHH17OkZPvE4AAYXye6TAa5MtlVgSgUVGlp2Mr9N01YpkM+Ljb
	 58waK74uCSV8A4APDwYU1mI2dZtytbxLLHQJ5PppNZT9xSLAyvSHQWokCNXF4E/j0b
	 cWKDnw6EWYOMQQIfPMVreQZtFdhMAwLB9zWqSZhyrygCMbB0gdIb96pRw8nrxRL8RH
	 UWPeNqxXv9dtuZUqQLUCHPi1iyec0TRoGtosilsxkWqenctp4mtmEzFcd/pIk8RTgj
	 3la6OzlIM8B+whwryQ2DwZAtaHm0g8DAK2z2L0im04CSeKvz4a2Gyy/CShEhEHKkN0
	 tJhi7+kNIzgJA==
Date: Sun, 2 Jun 2024 00:23:40 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
	Kees Cook <kees@kernel.org>, Marco Patalano <mpatalan@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [GIT PULL] hardening fixes for v6.10-rc2 (take2)
Message-ID: <202406020021.3B4B59F3A@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these few hardening fixes for v6.10-rc2 (take 2: now with
my regular key).

Thanks!

-Kees

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc2-take2

for you to fetch changes up to 99a6087dfdc65303d26ab5fba2dacd8931b82b08:

  kunit/fortify: Remove __kmalloc_node() test (2024-05-31 13:47:41 -0700)

----------------------------------------------------------------
hardening fixes for v6.10-rc2-take2

- scsi: mpt3sas: Avoid possible run-time warning with long manufacturer strings

- mailmap: update entry for Kees Cook

- kunit/fortify: Remove __kmalloc_node() test

----------------------------------------------------------------
Kees Cook (3):
      scsi: mpt3sas: Avoid possible run-time warning with long manufacturer strings
      mailmap: update entry for Kees Cook
      kunit/fortify: Remove __kmalloc_node() test

 .mailmap                                 |  9 +++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++++---------
 lib/fortify_kunit.c                      |  3 ---
 4 files changed, 11 insertions(+), 17 deletions(-)

-- 
Kees Cook

