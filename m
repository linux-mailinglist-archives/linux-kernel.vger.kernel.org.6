Return-Path: <linux-kernel+bounces-446060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34019F1F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BE618867A4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD81885A5;
	Sat, 14 Dec 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nvTkvjat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70AEC0;
	Sat, 14 Dec 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186914; cv=none; b=WzJVGj1IDChya+WNNXMUylcI1wLBq6JTs0w23ALiiN4vxv+E90XxglaKDG72O44uOla1WvlF+cdgfB36MXhNmXd49r4g9MBEGJBX/fJYoxfyvpAMEdiY3MyvBlmgc8Iso7HSWxaIVdxo7rzUfa+A+HJQD10g3YWfYFMS/+eYk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186914; c=relaxed/simple;
	bh=UVxnbUO8JX+rjSTQQp+2gGGKnFIJqpZ4zXzIXYk4nh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GxCS26s/gx7bNz9SzPufbrsLHoLPgyFh596xPouX+OJ/YoLa6UepYUSKJGRxfwrE4PuHmPer6azPbbq+NBjOia/bX/2ax1IdYhJHKh/keCtSR3Vtr7+3yvgwTHeeoJlEPqx3LWub8BrHyjM+NQvtraee0dpDSQiBPsqBgCtTXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nvTkvjat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9DC4CED1;
	Sat, 14 Dec 2024 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734186914;
	bh=UVxnbUO8JX+rjSTQQp+2gGGKnFIJqpZ4zXzIXYk4nh4=;
	h=Date:From:To:Cc:Subject:From;
	b=nvTkvjat/r3TDS1Oz7nZDU0kFmKCJL8pDudugPQKa6wqlDjjZ0MOPjRN2qQO/+EaN
	 uHis1iq5ArlztdePC+qSa9MwbeiYGV2gvbzFvv5U1KwkKqA48nrbxr8yPZ+grZFsMl
	 PvQXedQFgookc9IJg7t4tFLxVEqhKdLQtssaOuZU=
Date: Sat, 14 Dec 2024 15:35:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.13-rc3
Message-ID: <Z12XnpkeQSJZoClu@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc3

for you to fetch changes up to 48e8a8160dba523af7074e668b2a458250838a3d:

  staging: gpib: Fix i386 build issue (2024-12-04 17:29:20 +0100)

----------------------------------------------------------------
Staging driver fixes for 6.13-rc3

Here are some small staging gpib driver build and bugfixes for issues
that have been much-reported (should finally fix Guenter's build
issues).  There are more of these coming in later -rc releases, but for
now this should fix the majority of the reported problems.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dave Penkler (3):
      staging: gpib: Workaround for ppc build failure
      staging: gpib: Fix faulty workaround for assignment in if
      staging: gpib: Fix i386 build issue

Nathan Chancellor (1):
      staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT

 drivers/staging/gpib/Kconfig                       | 7 ++++++-
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

