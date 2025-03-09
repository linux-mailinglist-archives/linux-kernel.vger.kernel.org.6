Return-Path: <linux-kernel+bounces-553254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92718A58664
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8543A9E5F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B71E834E;
	Sun,  9 Mar 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDqF6MFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07610DF42
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542187; cv=none; b=JU4ILNW7HRYhQRoCaexhEaDjf+yc+MGA4aKwkdd/UnwaXZNO+cdrtecvEgMg+vDSZFdbWO0YBHadV1jbjsN3mEuQs+Zsy1BLwAjUKCpa8FFuvWhoscCLJXx3bFbj5C5eqAuyj1d4D/eXnCPdlnHSC57bOFh6cN4yTloMd+1kpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542187; c=relaxed/simple;
	bh=3fQC0WF5+6ihS2G/ztSnTb3m5b79RY7pZEYKaUvWdAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gvV21aCta+V4oBP5qATRmaRFrZzGJG8+BzFF4ll8n2oYbf9NV6esA+Rqcm0UCU7p+HPhSsPCkCqnuK4WzR7DSU93lO0c/U1/d0wS2akIWRrHxhy7DR/3twn8HS4pRxCd/dxiywdzFfGAtbsUGmOu7KkkmFHbb7+bXOeziSBC2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDqF6MFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A7BC4CEE3;
	Sun,  9 Mar 2025 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741542185;
	bh=3fQC0WF5+6ihS2G/ztSnTb3m5b79RY7pZEYKaUvWdAE=;
	h=Date:From:To:Cc:Subject:From;
	b=KDqF6MFgz7hpx6sdvVj8IG/p0f2IRi9JGOijsCcvC/VoEqmZJq7fZDmWE0nao7ruH
	 xcHK7TI9y3t5mBr2AUhUYxfn4yxcu8XDdIbtgJUuHQYlx2nqVI1cT1tNJQ+NisBt/F
	 IIdhJ9hR2v4dC1Yq3XL/IIObgkP4q+Csc329gCwM=
Date: Sun, 9 Mar 2025 18:43:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fix for 6.14-rc6
Message-ID: <Z83TJkyOpMOryy2o@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.14-rc6

for you to fetch changes up to 78eb41f518f414378643ab022241df2a9dcd008b:

  drivers: core: fix device leak in __fw_devlink_relax_cycles() (2025-02-20 13:26:30 +0100)

----------------------------------------------------------------
Driver core fix for 6.14-rc4

Here is a single driver core fix that resolves a reported memory leak.
It's been in linux-next for 2 weeks now with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Luca Ceresoli (1):
      drivers: core: fix device leak in __fw_devlink_relax_cycles()

 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

