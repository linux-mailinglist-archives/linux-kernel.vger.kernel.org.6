Return-Path: <linux-kernel+bounces-216240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2D6909D01
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325E5281937
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BB186E58;
	Sun, 16 Jun 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ai4cJXwd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F467186E2C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535067; cv=none; b=Sa7wRIaqkVgpjg49RoEaFgtYoWAlkXLGEDbU3+LO3Q6e6XOEd0Vv431RWE+V0/D7G+9rkru1kQC6FzwvPG6SqQyUiLJUY2/nOaO4oscjzmf9U/H+UHwSLyHtsMvU7bImFTkie7Mdalt6Z9lBffi8H8lj+LqTQIQQutGrOCmQsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535067; c=relaxed/simple;
	bh=hM+AGQbKSrCaYFPPKsQIU8xO1mSNDcWR1AoVW7cgtRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kv/628KyC3LXyxcdGKeK6zKPe0HiI7bFK3eglkwKmqEf5VlIVPeWME8PFttScj4/hORa6oKeOZqffzHCykEmqEXQ9fnDwzgDxEapnHYjChBuCnAvrjxGnrALgVCplAKgmhJA6S4mcGpFK+I9DE0Bn4oGOUddST2AvKrpxLbQWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ai4cJXwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836DEC2BBFC;
	Sun, 16 Jun 2024 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718535066;
	bh=hM+AGQbKSrCaYFPPKsQIU8xO1mSNDcWR1AoVW7cgtRo=;
	h=Date:From:To:Cc:Subject:From;
	b=ai4cJXwdlty38HcM2MfyizBFLrtAvTqhQke7MtD7oFsH7VBUOv/fENvmUeA7ra2m1
	 lMvUhiYQHEpKw9ZhbuJ/srtsNwiB49vuKYIRgQ/+huSryDamCPreRHm1cgDCOWOEYh
	 wFsCZai8HPG2VVV1YPgLptL4ItLzHL616iVeOlqo=
Date: Sun, 16 Jun 2024 12:51:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core / sysfs fixes for 6.10-rc4
Message-ID: <Zm7DmPaMqUO699gy@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc4

for you to fetch changes up to c0a40097f0bc81deafc15f9195d1fb54595cd6d0:

  drivers: core: synchronize really_probe() and dev_uevent() (2024-06-04 18:14:51 +0200)

----------------------------------------------------------------
Driver core / sysfs fixes for 6.10-rc4

Here are 3 small changes for 6.10-rc4 that resolve reported problems,
and finally drop an unused api call.  These are:
  - removal of devm_device_add_groups(), all the callers of this are
    finally gone after the 6.10-rc1 merge (changes came in through
    different trees), so it's safe to remove.
  - much reported sysfs build error fixed up for systems that did not
    have sysfs enabled
  - driver core sync issue fix for a many reported issue over the years
    that no one really paid much attention to, until Dirk finally
    tracked down the real issue and made the "obviously correct and
    simple" fix for it.

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Greg Kroah-Hartman (1):
      driver core: remove devm_device_add_groups()

Lukas Wunner (1):
      sysfs: Unbreak the build around sysfs_bin_attr_simple_read()

 drivers/base/core.c    | 48 +++---------------------------------------------
 include/linux/device.h |  2 --
 include/linux/sysfs.h  |  9 +++++++++
 3 files changed, 12 insertions(+), 47 deletions(-)

