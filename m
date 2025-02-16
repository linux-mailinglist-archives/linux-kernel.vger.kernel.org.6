Return-Path: <linux-kernel+bounces-516629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6266A374F4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9668518901EB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F4199230;
	Sun, 16 Feb 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtcjeSun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8A81E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718801; cv=none; b=EQmDug7u6ycnwQ9hbZVl0z7a0NMWPKTGZ/b1GSv6asOX/UiL+JNJp5prpJKONu8Bn6+XXCpiWQan59d/iERaC4AmsR7+4TckbO2fbZnuumfL9/YLaZHQBleFDAGvNx8e4dsCKSGUyEryj58l0bxRq/7Nz6IUblDrvX4HAeFrSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718801; c=relaxed/simple;
	bh=btNNAegJkuucaU1T5YYDUX6L1KaZer1Ml8+LwyQDu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H+i3/8mizKz8sQvMlaYZ7LFzwApEPvp53fE8D3CinlrzCRy8+P/RCRL7uVa8webhr/6+UOPbwPs3rmSNC4BWoOqMRzm2NJYvRik8UhRwXZ7fLlkMSBKurcCd17WnsgAXMWhEx8OaMoJgLIqaFlQX6YPjFD8cbipQDuF3OKY7csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtcjeSun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D788C4CEDD;
	Sun, 16 Feb 2025 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739718800;
	bh=btNNAegJkuucaU1T5YYDUX6L1KaZer1Ml8+LwyQDu+k=;
	h=Date:From:To:Cc:Subject:From;
	b=AtcjeSunXETs0a6/bG9ecfSOkGl4tqxuh0Px8mGWtooB5gwNQGqfZxbBVyBPnZHTU
	 pjR1MMBsxaHCzCLDHQtob5B2lyfrCq/wvhhOAue/e1tUuZhUDgPBtIIvDYK24wvsd9
	 vX0vCJuvSwVm7VCUUqSi/BUegSl3t1fe27NiTT70=
Date: Sun, 16 Feb 2025 16:13:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core addition for 6.14-rc3
Message-ID: <Z7IAjdCB8Ly5GIjW@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc3

for you to fetch changes up to 78418f300d3999f1cf8a9ac71065bf2eca61f4dd:

  rust/kernel: Add faux device bindings (2025-02-13 16:58:58 +0100)

----------------------------------------------------------------
Driver core api addition for 6.14-rc3

Here is a driver core new api for 6.14-rc3 that is being added to allow
platform devices from stop being abused.  It adds a new "faux_device"
structure and bus and api to allow almost a straight or simpler
conversion from platform devices that were not really a platform device.
It also comes with a binding for rust, with an example driver in rust
showing how it's used.

I'm adding this now so that the patches that convert the different
drivers and subsystems can all start flowing into linux-next now through
their different development trees, in time for 6.15-rc1.  We have a
number that are already reviewed and tested, but adding those
conversions now doesn't seem right.  For now, no one is using this, and
it passes all build tests from 0-day and linux-next, so all should be
good.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      driver core: add a faux bus for use when a simple device/bus is needed

Lyude Paul (1):
      rust/kernel: Add faux device bindings

 Documentation/driver-api/infrastructure.rst |   6 +
 MAINTAINERS                                 |   2 +
 drivers/base/Makefile                       |   2 +-
 drivers/base/base.h                         |   1 +
 drivers/base/faux.c                         | 232 ++++++++++++++++++++++++++++
 drivers/base/init.c                         |   1 +
 include/linux/device/faux.h                 |  69 +++++++++
 rust/bindings/bindings_helper.h             |   1 +
 rust/kernel/faux.rs                         |  67 ++++++++
 rust/kernel/lib.rs                          |   1 +
 samples/rust/Kconfig                        |  10 ++
 samples/rust/Makefile                       |   1 +
 samples/rust/rust_driver_faux.rs            |  29 ++++
 13 files changed, 421 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/faux.c
 create mode 100644 include/linux/device/faux.h
 create mode 100644 rust/kernel/faux.rs
 create mode 100644 samples/rust/rust_driver_faux.rs

