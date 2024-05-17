Return-Path: <linux-kernel+bounces-182265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8118C88F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2237A283478
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FEB64CEC;
	Fri, 17 May 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TpvGm6jx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1137149
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958201; cv=none; b=RFmTGrIjzJJBMFcvKqSaBB2lnSwYps8VhQHq1wSXl/1JOlvJ3nhAK/RCGEhjUFv1q6Ym1j0POeHPRn5ZsQdReAHLmrFzwHsuW9+GF/bUUXRWgDshrppWIzInU6lIb/93AuvvDC0jTTqSdAk6dLmg0MIV8HJJYe0282+eBdUYl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958201; c=relaxed/simple;
	bh=Y4J4KtttAso/W0XkiT1jQvPwDZ9gVHzyWBIClpG+LdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1bAofeKR1C5agoI2EKh/PzS8mMrPFZkH1j8Jg5/jvuzWa/rs+q1xoaQsh2aNV1mvKO3JHsMKEYZKalqanhAurYlpA3vJJY33eeaeDegTYnus7P5eENDcp9WwwK1b30RfvxR1+S1HiM13coDXFqWt829RhBridpgqNjXDVeFW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TpvGm6jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D816C2BD10;
	Fri, 17 May 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TpvGm6jx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1715958198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eTia0qW0DZJvYz+xTPDRaVyvFjGf1DGQY0A0PHzip7A=;
	b=TpvGm6jxoxRC0F2fYBYQCSlrwFtkJEAkLoU3XfK17LslXPkx1Q7fVy1P2bjOEwcqCpiiT8
	bQAMgI2mYCKjDA9m4e2+ObtEr0SGySKjGYX2cSQkL3WtrWxQprITWjJJQGVSleCh4mIOwJ
	W5xzpDN2i7eUA1gvDNfIsu1lsqxPbxo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6cf7c872 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 15:03:18 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.10-rc1
Date: Fri, 17 May 2024 17:03:15 +0200
Message-ID: <20240517150315.2213425-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

I usually like to send you a pull early, but things got a bit delayed for me.
Nonetheless, these three small commits have been cooking in -next for a while
and I don't expect much trouble.

This pull has one new feature:

- The vmgenid driver can now be bound using device tree, rather than just
  ACPI. The improvement, from Sudan, lets Amazon's Firecracker VMM make use of
  the virtual device without having to expose an otherwise unused ACPI stack
  in their "micro VM".

Please pull.

Thanks,
Jason

The following changes since commit 5eb4573ea63d0c83bf58fb7c243fc2c2b6966c02:

  Merge tag 'soc-fixes-6.9-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2024-04-26 14:39:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.10-rc1-for-linus

for you to fetch changes up to 7b1bcd6b50a615671d4dcb0ad0378a2660a1a368:

  virt: vmgenid: add support for devicetree bindings (2024-04-27 02:38:34 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.10-rc1.
----------------------------------------------------------------

Sudan Landge (3):
      virt: vmgenid: change implementation to use a platform driver
      dt-bindings: rng: Add vmgenid support
      virt: vmgenid: add support for devicetree bindings

 .../devicetree/bindings/rng/microsoft,vmgenid.yaml |  49 +++++++
 MAINTAINERS                                        |   1 +
 drivers/virt/Kconfig                               |   1 -
 drivers/virt/vmgenid.c                             | 150 ++++++++++++++++-----
 4 files changed, 165 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

