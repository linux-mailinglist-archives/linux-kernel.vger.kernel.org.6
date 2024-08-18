Return-Path: <linux-kernel+bounces-291100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E68955D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31036281881
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC5143C7E;
	Sun, 18 Aug 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhhEabs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97A13B783
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995565; cv=none; b=AeTBsH+DaWLNNBCav8Rbl5z2uUMCxb4TJQ5RYhcLb00z2wV+LZmNIaqYBEbjePJObHOJdwa0xslE+SEx2w2dxC79aCqzsfppmr5BSocpCDAZ8itNB26YsTTHEMoFhXJy0y/UFPAI33mP4b3LmZpa0S9nycTa18Um3bdR3ITc0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995565; c=relaxed/simple;
	bh=QFApO25i66ywj3/6hpIpsCgGoisigMbbwPCOCvWS6LY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xch0avuU/yfetVX6bkT8Hf98Y1O6HwO9zpMb9otw/KyPqdBuDskR9sfuP9rHmo1ctaUhTlRzBwTirxoIwy6MBNU0i75ZS5O/CSnFeRU1MxFUVpI439eoR08ABGZ/lUdgrrK5e5H9LtcwHkuYWpP57k+48duh4a3tC4OR4ToI95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhhEabs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7036C32786;
	Sun, 18 Aug 2024 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723995565;
	bh=QFApO25i66ywj3/6hpIpsCgGoisigMbbwPCOCvWS6LY=;
	h=Date:From:To:Cc:Subject:From;
	b=xhhEabs7l7bRnwEmCo7gZ47q4OWyb0I3XaRPOJGo19NvItfkekCvMDLp8xFohWglm
	 yh+Znab+tzUKQOooHZEFMdX4VEibMWW+dkedVjDL3F0Pkx1WbnzQL0xQZ+T1FwYurU
	 4ptmbt4STMCsH1lVzk/i8aRzgGlv9IdqeZ0Hf+XY=
Date: Sun, 18 Aug 2024 17:39:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.11-rc4
Message-ID: <ZsIVqh8N4QstYXVh@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc4

for you to fetch changes up to 2374bf7558de915edc6ec8cb10ec3291dfab9594:

  char: xillybus: Check USB endpoints when probing device (2024-08-16 09:57:56 +0200)

----------------------------------------------------------------
Char/Misc fixes for 6.11-rc4

Here are some small char/misc fixes for 6.11-rc4 to resolve reported
problems.  Included in here are:
  - fastrpc revert of a change that broke userspace
  - xillybus fixes for reported issues

Half of these have been in linux-next this week with no reported
problems, I don't know if the last bit of xillybus driver changes made
it in, but they are "obviously correct" so will be safe :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

Griffin Kroah-Hartman (1):
      Revert "misc: fastrpc: Restrict untrusted app to attach to privileged PD"

 drivers/char/xillybus/xillyusb.c | 42 ++++++++++++++++++++++++++++++++--------
 drivers/misc/fastrpc.c           | 22 +++------------------
 include/uapi/misc/fastrpc.h      |  3 ---
 3 files changed, 37 insertions(+), 30 deletions(-)

