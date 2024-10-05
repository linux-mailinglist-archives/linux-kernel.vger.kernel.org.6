Return-Path: <linux-kernel+bounces-351631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2843D9913FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 04:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EABB2393E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A071C6B2;
	Sat,  5 Oct 2024 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oO+0nMBe"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDA1BDC3
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728096150; cv=none; b=VZndXSutpOafDi7DKirpYAELx3vz7xKLY+PMvhTvRA3HVLIeegDsdkpDFfqH5U4gWj4VACgK4A5t3xIVthFM81M5qh+eNKGn8vwFvPfVqd1HvMLhowRMLSUdkOewZp0ZP3fA6VPvT7X+X89lyx/MaBmv1bdImCcV1mO3c3e+BLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728096150; c=relaxed/simple;
	bh=dSuKw3KgBtp4y2Nh4+iaxPe8SGV2r4DIQhHmXwzzgXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q83ZRtrgsXRRcBAQ/UJy9Ro1nL1hdB7INYQvl/ZCJjMx7htCNxooeanZPfOPL7S/E1HnrVixAPIqiwfMAGJ83RAPrH0NbJ6go7iWwNlKSm062r5cFcYu+H6sz8E+W7Ei6+6H8JOMep3Pa73DHGgCL9duVvg1Wku3EFTGo1r73sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oO+0nMBe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4952gLeK024607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 22:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728096143; bh=1KaDnjyQshquAFEggCflmVVbS3XL5i46DzD+xxadzNI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=oO+0nMBe9Xt+zO0yFsTvHGVVCNd53gqdDHncW/msr5T1pJ1gNwzfC15PyPcRiOody
	 2E4u+v5ux+yv7rgBpDjjD/Gx8TPlOR2AQ2/TN8ScrmwdqllcydUsROewv4kpDCycsZ
	 oHfzyFoxhiZvKjK8ETPF0yVpE+HCFcnai+CBuCOtqnq5sJWqYDTVHBuLBHhsJ6Fx48
	 xjp1l6dQBjIB57Xri6Uf9gmE3BmRST/n2xYR72hrpd0E3H8X/FMcfaOSUKMh39vdBQ
	 +PYa2taSlLxuFVRZeGoVK1LDiR16a6e0Wkm6vDhoNrBE3+/9cXHAQmNsWUAWDBaIK2
	 qQqnVYXCfw4Bg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 13F7C15C6668; Fri, 04 Oct 2024 22:42:21 -0400 (EDT)
Date: Fri, 4 Oct 2024 22:42:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for 6.12-rc2
Message-ID: <20241005024221.GA505880@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-5.12-rc2

for you to fetch changes up to 6121258c2b33ceac3d21f6a221452692c465df88:

  ext4: fix off by one issue in alloc_flex_gd() (2024-10-04 17:36:28 -0400)

----------------------------------------------------------------
Fix some ext4 bug fixes and regressions relating to oneline resize and
fast commits.

----------------------------------------------------------------
Baokun Li (1):
      ext4: fix off by one issue in alloc_flex_gd()

Luis Henriques (SUSE) (2):
      ext4: use handle to mark fc as ineligible in __track_dentry_update()
      ext4: mark fc as ineligible using an handle in ext4_xattr_set()

 fs/ext4/fast_commit.c | 19 +++++++++++--------
 fs/ext4/resize.c      | 18 ++++++++++--------
 fs/ext4/xattr.c       |  3 ++-
 3 files changed, 23 insertions(+), 17 deletions(-)

