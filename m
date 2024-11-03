Return-Path: <linux-kernel+bounces-393796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61A9BA556
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C621C20E1D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2BD165F01;
	Sun,  3 Nov 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwyaCcN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FD7080C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730635329; cv=none; b=ERAmyNf+ZINxqGHOS1mQuU19pVIJvZqO/o6mLaQPXS188jpgdhSxiXRhWR/c6MXtXx9wAqf4MeMVCLVAhZPGhHMEvlzwzKXY7YKKvRnKUHpCIQ6+gQC5rQx1wIQdVtB4SMwwHEph9Q1TVASHV8qFaIctSnLivjBs1qzquNdNXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730635329; c=relaxed/simple;
	bh=GrVgJBNnLFZybQ4vAx75wVn7n6208u+31IZ43I28/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+47uLVERdLJanHDN5RZMR1FDi9e2ETcnBsstkD11F7g+qIaWU68dyyRy+U5R1RfPJERW4QWbAJu5gCyBoRUkS5vUGUbxePs8y93NrveOLgroGW+QOpKCaj0aCUrY84o2LgaXGdMFv89MridllECdobFCwUmwxrUb4CUXoIKDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwyaCcN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E707C4CECD;
	Sun,  3 Nov 2024 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730635328;
	bh=GrVgJBNnLFZybQ4vAx75wVn7n6208u+31IZ43I28/h4=;
	h=Date:From:To:Cc:Subject:From;
	b=fwyaCcN/HVlgYvmTqaM4GrKFbbfrzLYMVHtVrU4zXL4Pof+aGfakTA5J4rcKU3CQs
	 GKwrRFvZsQlLNofz2+es+J88JEEiDwSCCK+rHZaWU3G8pcp7mtbIx3JLtbz0NhTIiY
	 rO4q35GNCZxPGuwrLsRMgAL3JXx9d3Rf3sO6BrdY=
Date: Sun, 3 Nov 2024 13:01:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core revert fix for 6.12-rc6
Message-ID: <ZydmMMof02Mb1kNT@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc6

for you to fetch changes up to 9a71892cbcdb9d1459c84f5a4c722b14354158a5:

  Revert "driver core: Fix uevent_show() vs driver detach race" (2024-10-29 01:23:43 +0100)

----------------------------------------------------------------
Driver core revert fix for 6.12-rc6

Here is a single driver core revert for 6.12-rc6.  It reverts a change
that came in -rc1 that was supposed to resolve a reported problem, but
caused another one, so revert it for now so that we can get this all
worked out properly in 6.13.

The revert has been in linux-next all week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "driver core: Fix uevent_show() vs driver detach race"

 drivers/base/core.c   | 13 +++++--------
 drivers/base/module.c |  4 ----
 2 files changed, 5 insertions(+), 12 deletions(-)

