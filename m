Return-Path: <linux-kernel+bounces-216331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD0909DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E92B2136E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410E12E7E;
	Sun, 16 Jun 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiCdP8/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B812B73;
	Sun, 16 Jun 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718549821; cv=none; b=L5N2Uzjko8wGFLnv3QrQ3juDmqzgcSqJgNthf0XkIsVUQBXl4JXsSYkCbCG3ui/8Vvv9qWGeIsEiuZatxm80JPbAKafkh7HdeIuDEMe4ji6FovTpY0s09oUdrBRS7MUdRrmUOJYp23Jp6leG+ylgAN+1MXI8szAYsH2PI824IHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718549821; c=relaxed/simple;
	bh=OEK/0Wk/iV7IEcoaqWDTQRqddRJOamy6tc1nYeMGQJU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c6j0KiZLClRqXqNeRu3w/sXJHQbwUxkImJg3UTmqxjVJF5IZJyu5YP91HREvhK3d+kuqg+HIDYoSkDBNMbEtM0hpO2WcU4VI0YV7VbyndDxAi+pc+H+XCPL1qk6TVhXveRfkgFzHx8uTe97uk6EJR5WPoBT015laAApab3wZ9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiCdP8/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD05BC2BBFC;
	Sun, 16 Jun 2024 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718549821;
	bh=OEK/0Wk/iV7IEcoaqWDTQRqddRJOamy6tc1nYeMGQJU=;
	h=Date:From:To:Subject:From;
	b=TiCdP8/UqBSTE4E6gEWu9g5q415/3DC3e5HU8CoslGfDI7V7XRIkKoMsD7/z40MA7
	 H+5IxK3m1Fk3+zjwYiVEnDGQHSL3KxrvfhRlf7xhe30HH8jJ758gzMwQ3KHQZnXjBn
	 JbPIcC0JLpFn+AD4erqR5doGhSPqO9i5lENENPmUd1+Y9OrkJ0R3ZPG2raraRtLwLu
	 PftoVPzjtkdsf/XyRWL0bHqnB4u+c/09FkcBJrUnfrxsN/d2QfV0uSvgLuoJVmeLqO
	 OKYl4JAa+PEmIEZGDGvooaUdcuuVvaue+gYDkMFvY1O/iW1M7cQtjCO6SEXZrLAMBC
	 DXAkHX3oAXWhQ==
Date: Sun, 16 Jun 2024 16:56:57 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for v6.10-rc4
Message-ID: <Zm79OUifsEhG8CMT@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull one fix for the parisc architecture for 6.10-rc4.

On parisc we have suffered since years from random segfaults which seem to
have been triggered due to cache inconsistencies. Those segfaults happened
more often on machines with PA8800 and PA8900 CPUs, which have much bigger
caches than the earlier machines.

Dave Anglin has worked over the last few weeks to fix this bug.
His patch has been successfully tested by various people on various machines
and with various kernels (6.6, 6.8 and 6.9), and the debian buildd servers
haven't shown a single random segfault with this patch.

Since the cache handling has been reworked, the patch is slightly bigger than
I would like in this stage, but the greatly improved stability IMHO justifies
the inclusion now.

Please pull.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.10-rc4

for you to fetch changes up to 72d95924ee35c8cd16ef52f912483ee938a34d49:

  parisc: Try to fix random segmentation faults in package builds (2024-06-12 01:57:05 +0200)

----------------------------------------------------------------
parisc architecture fix for kernel v6.10-rc4:

One patch from John David Anglin which reworks the parisc cache flushing
routines with the aim to fix the random segmentation faults on machines with
PA8800 and PA8900 processors. We have faced those segfaults since many years,
but with this patch no single segfault could be triggered any longer. The
patch was tested by 3 people on 5 different machines with various stable
kernels (6.6, 6.8 and 6.9).

----------------------------------------------------------------
John David Anglin (1):
      parisc: Try to fix random segmentation faults in package builds

 arch/parisc/include/asm/cacheflush.h |  15 +-
 arch/parisc/include/asm/pgtable.h    |  27 +--
 arch/parisc/kernel/cache.c           | 413 ++++++++++++++++++++++-------------
 3 files changed, 275 insertions(+), 180 deletions(-)

