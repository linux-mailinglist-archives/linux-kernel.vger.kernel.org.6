Return-Path: <linux-kernel+bounces-520670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5515A3AD05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65D218925C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA299F9D9;
	Wed, 19 Feb 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qUy9oCrl"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C58BA45
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924395; cv=none; b=WIQsvBtSSdx8JGjS5tVW8Mp8XSXBfS5t3/0y2bZvkxyAk66GHNLDgMRoHOaYKKC6H6x2FMQ2JHp2QRzAPkOZHXSM5OuWCOBDgf5qIsJhvR+n9EQldtzSGued8/pfwUi6DI138gR7qlJUPcbqnUlg+GRQlIapLOXQ0gdqyQwAKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924395; c=relaxed/simple;
	bh=eNGkxnFs7IfHoyUxhahkA5IGad+mw8JRk9WKmUZKn7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez6j+zJoxbiXNmnLELh5sINrVBg/YanQ+9bynt+W6hACFEduMvAtcsAsqrQ477DZH18c1s1lseXFhRHQl99EW6/iYuV/0tkY5NWZPjacOVaVZ12chG4SQvrUwVHzDGhOT8FeFnFtceaA2c7KKngGx1MJJXGkPxS/+dYYDiYXBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qUy9oCrl; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J0FrlYHmGxujW2VQqJf7eNzJk4nHZqKuUCvraxZGc7I=; b=qUy9oCrlmcXh1Th/DBT9nehFu8
	xA4YY2hhi1NoyawdZYCNgyvSfNv75EI1Hy66mQH8/JN4I0tU+H7wFjEQGbaz+dxBV9+ZsOeTFfl9r
	ePzMnGvcZJp54k1vm6seXG//qZUMc8TOghzKZtaFFAWo/RCKcFpYy0liRp5DNxrSVuDVEqJjpHjRK
	ljKsKB2n/fs7/UxZPuD+zJQ0CjLTHl7Y9ZGi5a6EiQEwQsqzgqxCXccpjqwtptNSla5tdf2QHBB1r
	k1wmVC0cDhh9GY6K3muQMJeXgGXPjaU4VxCORiEuQP4k2Y4DcwA7Igz3dKXwfeWOTFI0ZuOXlQmka
	DGdmWCzQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tkXod-00Alyi-2B;
	Tue, 18 Feb 2025 18:19:51 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	wine-devel@winehq.org,
	Elizabeth Figura <zfigura@codeweavers.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ntsync: Check wait count based on byte size.
Date: Tue, 18 Feb 2025 18:19:20 -0600
Message-ID: <20250219001920.210847-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC versions below 13 incorrectly detect the copy size as being static and too
small to fit in the "fds" array. Work around this by explicitly calculating the
size and returning EINVAL based on that, instead of based on the object count.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>

--

Suggested-by as per Arnd's request, but the only thing I changed was preserving
array_size() [as noted by Geert in the linked thread]. I tested and found no
regressions.

---
 drivers/misc/ntsync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 586b86243e1d..24cb2f71186a 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -873,6 +873,7 @@ static int setup_wait(struct ntsync_device *dev,
 {
 	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
+	size_t size = array_size(count, sizeof(fds[0]));
 	struct ntsync_q *q;
 	__u32 total_count;
 	__u32 i, j;
@@ -880,15 +881,14 @@ static int setup_wait(struct ntsync_device *dev,
 	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
-	if (args->count > NTSYNC_MAX_WAIT_COUNT)
+	if (size >= sizeof(fds))
 		return -EINVAL;
 
 	total_count = count;
 	if (args->alert)
 		total_count++;
 
-	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
-			   array_size(count, sizeof(*fds))))
+	if (copy_from_user(fds, u64_to_user_ptr(args->objs), size))
 		return -EFAULT;
 	if (args->alert)
 		fds[count] = args->alert;
-- 
2.47.2


