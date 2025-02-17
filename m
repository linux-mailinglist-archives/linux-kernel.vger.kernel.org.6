Return-Path: <linux-kernel+bounces-517612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8EFA3831E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B5E3AB2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3E21A45C;
	Mon, 17 Feb 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvkSZJkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28681219A67
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795925; cv=none; b=uoU5DOzz6fqIo2HvyNcaZrDFEyvaoG4CAkRBW7wa6qFmNqdUWInz6Y8lRS4WFEgBqPSxT+HnQBiN0FUobb2zi2MBRShdhBWCmmcr6myXooXC+qRtN3+/U5OkRr56+YsImoDv2D+KAkfSZC/UQO7t1lJ9dodq2zIVhKudt/9qrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795925; c=relaxed/simple;
	bh=X0oRZi8zYTDNfAJos6hQDutixGfIUWF4rPx0EH6eyLw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XkoUsQnqO6LLtjK14c6ZI178gvUijIHv//9kvGVOER3bdFa58799FZb++T3n6bn7VdplfvQ+Lc0/sECi2YZd2EJFkx+VQVtGEQuYlIw595HbGOJuq2xwPclAU8rQN4aPP3BoHCElmh68TkQgwS+UKgUkARIBccw509TP9+QcBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvkSZJkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E7C4CED1;
	Mon, 17 Feb 2025 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795924;
	bh=X0oRZi8zYTDNfAJos6hQDutixGfIUWF4rPx0EH6eyLw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PvkSZJkfULpDTie60tVXnfff1IZSq8ewJEUdKfnnOgGdBxhs+vahQQByLMw+WO6qa
	 OdBWOLEaaeuFTco5PG0mFnlUeeWGduo58eyJgvGndEQAylWQV+jsamVLlVsme+MQ5d
	 2LrwNi/9KqFeyRQyCemmt/GUEexGMqzD35oBckzy3oWkErltHCuxTe1Gv135QxVmXi
	 5DodKwE/jEcptJ43IRunJ477ym3dVvx4ewmj6KBfwltvVuBEt8Ahzlha31bTKT4hYq
	 xcCRpv23YZ0BiKTofg5sLeBA+QRiKuLjvu+ikTdUUdYSeQH7h+gcFQ9+TuXDJFoK7m
	 b3pblP27d8stA==
Message-ID: <53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org>
Date: Mon, 17 Feb 2025 20:38:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH v1] f2fs: fix to ensure queued discard commands are
 properly issued
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250204145353.165-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250204145353.165-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 22:53, Yohan Joung wrote:
> F2FS zone storage requires discard and reset zone for each conventional,
> zoned device.
> In the current configuration, Discard granularity is set to the zone
> size but queuing is inserted into the pend list with a maximum size of the
> segment size As a result queued commands cannot be issued.
> so we are restorting discard granularity to its original state

It seems commit 4f993264fe29 ("f2fs: introduce discard_unit mount option")
introduced a bug: when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause bug. blkzoned feature became the victim since it use
discard_unit=section option by default.

What:           /sys/fs/f2fs/<disk>/discard_granularity
Date:           July 2017
Contact:        "Chao Yu" <yuchao0@huawei.com>
Description:    Controls discard granularity of inner discard thread. Inner thread
                will not issue discards with size that is smaller than granularity.
                The unit size is one block(4KB), now only support configuring
                in range of [1, 512]. Default value is 16.
                For small devices, default value is 1.

What about this?

Subject: [PATCH] f2fs: fix to set .discard_granularity correctly

commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
a bug, when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
w/ any granularity to issue.

Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
Signed-off-by: Yohan Joung <yohan.joung@sk.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ebe25eafafa..2b415926641f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT ||
+		F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);

 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.48.1.601.g30ceb7b040-goog



