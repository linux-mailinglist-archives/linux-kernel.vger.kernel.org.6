Return-Path: <linux-kernel+bounces-291101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63036955D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F381F21457
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3375A14373F;
	Sun, 18 Aug 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVjd2X+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00C12B93
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995731; cv=none; b=uQYNW7IVU/v29JcZ5JU+CtVqTje47M/yQBUohQUkORJMwmY0Msu8AwWEAJ8Gz8Llueka9bKQn3UBaBOGj+8BjFwSpYNXvx+Z6Yo//o3fc1xCOFGjokzPITWAgEQaSRRX3eDEktxw711XNyt5oZwXd2h7EZvUSpZ3lkjFeS1NdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995731; c=relaxed/simple;
	bh=h7Bqm7k9wvNRQZj+EFxfH9ISm29N662ih2IeVUXenjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UcKBO5mPaGL9QuKm18uSF7KTu+G0WJz9jY2sH5KSphjvhnlisaHF8ak3DoG5MmnGMlEWQKQkPJ28zjKwYPl2DwZ5i+gOcqGPqCCs5ys7jPRY668dMdjz3ssE1af03XOdjrh/0UC1+j6hi3LUR7GpTnLBigwqJ6olE+pe2qcrjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVjd2X+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90035C32786;
	Sun, 18 Aug 2024 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723995730;
	bh=h7Bqm7k9wvNRQZj+EFxfH9ISm29N662ih2IeVUXenjw=;
	h=Date:From:To:Cc:Subject:From;
	b=XVjd2X+0pK1mSCh1y/vBCNeKhTcR4ylqaUTiFdpDaN5ntIOZLfE1eChPv+fkUxws0
	 OauVC5gpWGALmeLg05mPcxf7jNZfl0QyV6HpfF3OIBtZ0Q+whFvNsiOfGm4TbZzfbY
	 r+bDy6C8qNnyia22YtVlt12qllACFokl84O5HA3s=
Date: Sun, 18 Aug 2024 17:42:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.11-rc4
Message-ID: <ZsIWUHiPLdjeo7ow@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc4

for you to fetch changes up to cdd1fa91a6b8c7cd93b3abf9f3ef05b8ce741b61:

  mips: sgi-ip22: Fix the build (2024-08-13 11:34:55 +0200)

----------------------------------------------------------------
Driver core fixes for 6.11-rc4

Here are 2 driver fixes for regressions from 6.11-rc1 due to the driver
core change making a structure in a driver core callback const.  These
were missed by all testing EXCEPT for what Bart happened to be running,
so I appreciate the fixes provided here for some odd/not-often-used
driver subsystems that nothing else happened to catch.

Both of these fixes have been in linux-next all week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bart Van Assche (2):
      ARM: riscpc: ecard: Fix the build
      mips: sgi-ip22: Fix the build

 arch/arm/mach-rpc/ecard.c     | 2 +-
 arch/mips/sgi-ip22/ip22-gio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

