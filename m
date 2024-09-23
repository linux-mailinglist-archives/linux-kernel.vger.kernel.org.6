Return-Path: <linux-kernel+bounces-335753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAAF97EA27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1B9281CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40EB197559;
	Mon, 23 Sep 2024 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTWuB14k"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AB19599C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088565; cv=none; b=MXND60lyrhiDp14QJFaAdkiLA7fzblSKe000rGLd/pkyWwolaE0FOLmS5SwkvK4ix/bfTn4vBtisl8N5m3jh/7v2Urygz5Jq1lfQrkKrmzL+R+9N4yxpE4kt8YyJE6cZEK0hq/nEXGRkptRCsxY8ydDWqHBgvILsr2/MEzoucBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088565; c=relaxed/simple;
	bh=i/tmphCAfKOTxbykRTk9VH95pDN1sk53RbkTdR5Oiy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/s+iLcefrXZx8/pButY+wDBO+NdajECCmbq9kLraeoqbnoG3KUMb+6h9EIzZysnarQF7cw+9j+4z8MJScWH42f+oytqcdbp15Lf2xRmgUE93tRjnrmbVO/hGIAIzK7M4ZjgZpehVmCFBHUxfGceZXs7+d9g39wnYGEGB2EZ7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTWuB14k; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727088560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=77SNg4RVz7Xv8ZAv6cD5UDFUzHD/MzyETwAuoBF/hSQ=;
	b=jTWuB14kxov5LPrajucQ1GJJjogH9vfJje5lad39f8WZT+vYFBTGq96zxeDj192cIqRONZ
	t3vsTWtrf941TEaDMppVzhKYFnPK5EPI9uFVqHXrUxvk14nSK1y/hCVLyR37BuiSUVOv8N
	ixxeIiH+gw6QqSfrorfY/CA4ZWwxZXw=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 0/2] ext4: mark FC as ineligible using an handle
Date: Mon, 23 Sep 2024 11:49:07 +0100
Message-ID: <20240923104909.18342-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

Changes since v1:
* only the second patch has been changed to drop the call to
  ext4_fc_mark_ineligible() in the error path.  Commit text has also been
  adjusted accordingly.

And here's the original cover-letter:

The following patches were suggested by Jan Kara[1] some time ago.  Basically,
they try to address a race that exists in several places, where function
ext4_fc_mark_ineligible() is called with a NULL handle: in these cases, marking
the filesystem as ineligible may effectively happen _after_ the fast-commit is
done.

There are several places where this happen, and the two patches that follow try
to address some of them.  The first patch fixes the calls that exist in
__track_dentry_update().

The second patch _partially_ fixes the call in ext4_xattr_set() -- this is
because it may fail to obtain an handle.  And, to be honest, I'm not sure what
to do in this case: try again to obtain a new handle just for marking the fc,
with a lower value for credits? or leave it as-is, with the NULL?

The other two missing callers are the ioctl for filesystem resize and
ext4_evict_inode().

[1] https://lore.kernel.org/all/20240724101504.e2t4pvgw6td7rrmm@quack3/


Luis Henriques (SUSE) (2):
  ext4: use handle to mark fc as ineligible in __track_dentry_update()
  ext4: mark fc as ineligible using an handle in ext4_xattr_set()

 fs/ext4/fast_commit.c | 19 +++++++++++--------
 fs/ext4/xattr.c       |  3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)


