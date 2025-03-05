Return-Path: <linux-kernel+bounces-547372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A3A50656
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1590C1886F0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7ED2512C7;
	Wed,  5 Mar 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQwa1his"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9362250C1B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195685; cv=none; b=RNaVGHC/TGHGwE/lzGcobyLzfFlqYAofb0y5yRTc0pVS+DFYwfoL8t3eyB0rB77MAsuku8so+kWShIK6+LT/HeP4igvBx/j+slO4AvP8FOvCX99fbAajKZBICPL5mMeXUfeQqJPUfPw6JM4PaM+3f7bh1EcJjQrntqpWq/o/ioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195685; c=relaxed/simple;
	bh=VuItw8oDG/JxjNFddARGZyzcjOXVjB38Cc7H5oMy7HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dv6qvUKl22cvnCLshJqqKwNgIVE5coO8JIdGp+gzI9FqJtzVf2/aQ2chFgrxzxH3zSYWKs8V0EOk+dcIwdUSeLVCN9sd6qRSr8qN4+n/YnOfBszXPb9yeS2zASPwHy9zBy3aE7oyAC5pCif7luwDmhC2WfuxA6C1Pyy1UJcZH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQwa1his; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28300C4CEE0;
	Wed,  5 Mar 2025 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195685;
	bh=VuItw8oDG/JxjNFddARGZyzcjOXVjB38Cc7H5oMy7HA=;
	h=From:To:Cc:Subject:Date:From;
	b=WQwa1hisZ+I1lDEVm6G04zmuJ1fvP9ool4svAEpUXDQ9VZF6A7BxFsZPljpTbpth+
	 9TrxEPKttiny8W713OaHWiw/J8xFCz+851xGvQ50coDDZOQDn1MM7vYxeyqKN8jxRa
	 oOroD+er8bxuLgJ1RA2S9H97mpu4bSQXJqFOjTi9v4p6LsvJ0w8f+WD+th9gcSRHuy
	 XtR2L1LlMl+Cr36v43Nu4fyphlOpdvav6jT9od7bQk9jrQg7LbGkkFD5me3PSOJ17V
	 rcxSO83EahMSlfmxn/CYLPVBNeeM1ueQkMq7cZlrn8qDhHSnzT8Us8uCviPBq8RRRa
	 Pa5fu5Ku010XA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jeff Xu <jeffxu@chromium.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mremap: fix uninitialized return code
Date: Wed,  5 Mar 2025 18:27:56 +0100
Message-Id: <20250305172800.3465120-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'err' variable is set in a conditinal branch and is not
set otherwise:

mm/mremap.c:1017:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
 1017 |                 if (vma->vm_start != old_addr)

Set it to zero before the initial value is set.

Fixes: 3129f7896afb ("mm/mremap: initial refactor of move_vma()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 456849b9e7bd..9c51a2360d84 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1014,6 +1014,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
+		err = 0;
 		if (vma->vm_start != old_addr)
 			err = vma->vm_ops->may_split(vma, old_addr);
 		if (!err && vma->vm_end != old_addr + old_len)
-- 
2.39.5


