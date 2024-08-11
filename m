Return-Path: <linux-kernel+bounces-282257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30194E162
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17B91F213D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D495336B;
	Sun, 11 Aug 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnZfrYDx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6F17740
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382555; cv=none; b=ux+DfGKyzGGTej6QJuZcmikQU3WwX8fHnzxTrF7MKNERuuAJktiNqrM7lsqkgJu2qNq6/UuVGXdr1t4jVydOCuk7bo4OD/vCSa36vh743DYAuUayMQq5Zje5lbmdaLvSPBcZTqirEpxejFmYbgOakBUVzl9oBZPSMoiOXwBhSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382555; c=relaxed/simple;
	bh=fRZuJnVWBhG09lXseaq+SmDo885KlSgJs5NrT3ciseU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XHRH5sqiqaJTbVpMB5Lv3qlQr5bnGGdp1hC637kHasAKRnjr1R/mKiENXc3HiyQui2o3/Yk1Zurjyz8GPVA72uSkk+qcvTT0vqErCppSYew+xfPaW25cScpUWzuhYCrE6vbQ7bpMeJwtXyfdeYTdElJrMp7g0yuFkvKs7vVndaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnZfrYDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F37C32786;
	Sun, 11 Aug 2024 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723382554;
	bh=fRZuJnVWBhG09lXseaq+SmDo885KlSgJs5NrT3ciseU=;
	h=Date:From:To:Cc:Subject:From;
	b=wnZfrYDxX/IyD4irm10k1TSwIsOensVomAEI3tdjhs25ovmRhXGgrkUiuDMn9FuPU
	 U5FGqjh5Kyh9eQRoQmlhaXcqXaI3HGQXDUb1/8b5qPdRhwiHSg8X4vrgYQvDHx/oVy
	 QJYupnKGfioyAppgJ7TZwxF3YYfdfEjo8trQRcvI=
Date: Sun, 11 Aug 2024 15:22:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.11-rc3
Message-ID: <Zri7F8cRtyS1ylM2@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc3

for you to fetch changes up to ffcf2eb4bfa24f7256de53a95182c3e3e23fdc6c:

  spmi: pmic-arb: add missing newline in dev_err format strings (2024-07-31 13:49:28 +0200)

----------------------------------------------------------------
Char/Misc fixes for 6.11-rc3

Here are some small char/misc/other driver fixes for 6.11-rc3 for
reported issues.  Included in here are:
  - binder driver fixes
  - fsi MODULE_DESCRIPTION() additions (people seem to love them...)
  - eeprom driver fix
  - Kconfig dependency fix to resolve build issues
  - spmi driver fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Armin Wolf (1):
      eeprom: ee1004: Fix locking issues in ee1004_probe()

Arnd Bergmann (1):
      misc: mrvl-cn10k-dpi: add PCI_IOV dependency

Carlos Llamas (1):
      binder: fix descriptor lookup for context manager

David Collins (1):
      spmi: pmic-arb: add missing newline in dev_err format strings

Jeff Johnson (2):
      fsi: add missing MODULE_DESCRIPTION() macros
      char: add missing NetWinder MODULE_DESCRIPTION() macros

Konrad Dybcio (1):
      spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree

Mukesh Ojha (1):
      binder_alloc: Fix sleeping function called from invalid context

 drivers/android/binder.c        | 15 +++-----
 drivers/android/binder_alloc.c  |  2 +-
 drivers/android/dbitmap.h       | 22 ++++-------
 drivers/char/ds1620.c           |  1 +
 drivers/char/nwbutton.c         |  1 +
 drivers/char/nwflash.c          |  1 +
 drivers/fsi/fsi-core.c          |  1 +
 drivers/fsi/fsi-master-aspeed.c |  1 +
 drivers/fsi/fsi-master-ast-cf.c |  3 +-
 drivers/fsi/fsi-master-gpio.c   |  1 +
 drivers/fsi/fsi-master-hub.c    |  1 +
 drivers/fsi/fsi-scom.c          |  1 +
 drivers/misc/Kconfig            |  2 +-
 drivers/misc/eeprom/ee1004.c    | 85 ++++++++++++++++++++++++-----------------
 drivers/spmi/spmi-pmic-arb.c    | 11 +++---
 15 files changed, 81 insertions(+), 67 deletions(-)

