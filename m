Return-Path: <linux-kernel+bounces-282259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7394E165
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676DD280F71
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D66A33A;
	Sun, 11 Aug 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5VXPtUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBA3F9C5
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382605; cv=none; b=GnYdzcDnZhyeTD8qFm8noRmt6C9Dv6nbt2xnnU1axlzTyn3rBBD8U79O9nQi6y/x7ThnWK/vd8VzucNQ2cUiccsFn/rB5T1D3TLCyJ2P3KrtuIb7qV2F5n/H1e4k07lbfujtO8zGl/fY4MBu4AaAGpEedr1SvSLazpr0vJjFVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382605; c=relaxed/simple;
	bh=QXukIxN0eyNLSnPkL0lFOjc2g6XSeAsUJnzlcjB95hI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B9hwsGbnm82iQgS9znkTR7x2HOZnXKRsyg74fLr1j8aEScguNKrs1eAClnTIKMUAQyPmv5c//cZxJi0W6MsbKhMH+6tBnZ+Xno+Soyaw85iWBYIhzrp8MEZdPW75wWdm4GQia2jFHcCaY2aqURh7y6q5QIgrDO2jVipCpjxVHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5VXPtUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B872C32786;
	Sun, 11 Aug 2024 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723382604;
	bh=QXukIxN0eyNLSnPkL0lFOjc2g6XSeAsUJnzlcjB95hI=;
	h=Date:From:To:Cc:Subject:From;
	b=F5VXPtUv2xDdgIrM/7MnXWK7jaz3yk1/BL7nsiUbuenWTkFj1V2HPdSfogjqokryy
	 lCjKKeXIb6vtRJmI79pv3gyMBdq4YufLssDVFkxv/8FkbE5X+LuQk5aviM402a4OEV
	 6VgGHKAGZE7S2yVsV5lnV+yvyg9JjWS7pr7Gr3k4=
Date: Sun, 11 Aug 2024 15:23:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.11-rc3
Message-ID: <Zri7SXl7mFsto0MJ@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc3

for you to fetch changes up to 15fffc6a5624b13b428bb1c6e9088e32a55eb82c:

  driver core: Fix uevent_show() vs driver detach race (2024-07-31 14:41:44 +0200)

----------------------------------------------------------------
Driver Core / Documentation fixes for 6.11-rc3

Here are some small fixes, and some documentation updates for 6.11-rc3.
Included in here are:
  - embargoed hardware documenation updates based on a lot of review by
    legal-types in lots of companies to try to make the process a _bit_
    easier for us to manage over time.
  - rust firmware documentation fix
  - driver detach race fix for the fix that went into 6.11-rc1

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Ballance (1):
      rust: firmware: fix invalid rustdoc link

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Greg Kroah-Hartman (2):
      Documentation: embargoed-hardware-issues.rst: minor cleanups and fixes
      Documentation: embargoed-hardware-issues.rst: add a section documenting the "early access" process

 .../process/embargoed-hardware-issues.rst          | 153 +++++++++++++--------
 drivers/base/core.c                                |  13 +-
 drivers/base/module.c                              |   4 +
 rust/kernel/firmware.rs                            |   2 +-
 4 files changed, 109 insertions(+), 63 deletions(-)

