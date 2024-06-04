Return-Path: <linux-kernel+bounces-201394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A78FBDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2861F2289E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA614D28A;
	Tue,  4 Jun 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lrwIyQ3o"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F05B683
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536178; cv=none; b=lxTWQyA2SrhLkFYfWx0rgoSYuhlOReYNQGc9oUo/YZ4O8qaCfxRA5EFgqRXYKlbkhhQqk9I35B8yFeDFuYGgL3NY/XYGwG4uvKBP1MgD40A+OVOf/QggWIOs3eCIp0gA74xAHCy7x8hFAtA/KAenIQLKNjv9K6oGeQbNuncMxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536178; c=relaxed/simple;
	bh=uq9U9mDJUce7Qvp01K18gA3dtgV4zfH955lkRAaV4mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/h1vartqrXZmnS9vxWDiFjuqW8G0Ib7aPkrdVPTYuBMkVJva6fv4McQTgm10BxlDyiiRYkmiGOCYunRfC9408tYqm0FiiURCG9KBVKhOXTRTcsIEVdbeQPdvM/qTV83jOaLZp1EtIXwbvTB3Td8OFGs6Jqb/4admH3jiprYMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lrwIyQ3o; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=62lUBNUlR8iL4F
	sWpr9dsKOLBDz7it0Yl5zVjY+xhek=; b=lrwIyQ3o/NpXvUfIj1XZdN5jgXuzeR
	ItuU2mxagSryrReDB1IlhEqN0RXIbZW0wd/N1KJaTjm94gQYvHTKz1RtVGT30UWF
	RnQHMjloLw6LgWmp8JpgtukU7oP0a7KHviWl9rUhoSzUfnLmOEewjv7vqHFQS3Op
	yobcghwSmSBZzW4cgK6ovfV2gvep2T7gCSVQ9gDnvfQtHB52/urLCY2UZ/zUne14
	MPtjT/K4wOevZ8mAUSFvzXRFRe5fQFSH464BTfSaBR/N0+1AVtILb7MAAIhtG2FE
	Efz8ZdIUTAmI35F/QmYrtHBPvTui023Zfr31gyuNeJnamP0FUkg7IMVQ==
Received: (qmail 2449393 invoked from network); 4 Jun 2024 23:22:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2024 23:22:50 +0200
X-UD-Smtp-Session: l3s3148p1@sZxQDRcapIFehhtB
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alex Dubov <oakad@yahoo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/4] misc: use 'time_left' instead of 'timeout' with wait_*() functions
Date: Tue,  4 Jun 2024 23:22:35 +0200
Message-ID: <20240604212240.4529-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_*() functions causing patterns like:

        timeout = wait_for_completion_timeout(...)
        if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
obvious and self explaining.

This is part of a tree-wide series. The rest of the patches can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left

Because these patches are generated, I audit them before sending. This is why I
will send series step by step. Build bot is happy with these patches, though.
No functional changes intended.

Wolfram Sang (4):
  misc: apds990x: use 'time_left' variable with
    wait_event_interruptible_timeout()
  misc: bh1770glc: use 'time_left' variable with
    wait_event_interruptible_timeout()
  misc: tifm: use 'time_left' variable with
    wait_for_completion_timeout()
  misc: ti-st: st_kim: use 'time_left' variable with
    wait_for_completion_interruptible_timeout()

 drivers/misc/apds990x.c     | 10 +++++-----
 drivers/misc/bh1770glc.c    | 10 +++++-----
 drivers/misc/ti-st/st_kim.c |  8 ++++----
 drivers/misc/tifm_7xx1.c    |  6 +++---
 4 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.43.0


