Return-Path: <linux-kernel+bounces-289575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC449547C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3219F283D95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC141A76BC;
	Fri, 16 Aug 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="bsK8cuuI"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC7196D80
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806900; cv=none; b=jEGL2hBCsrK8X/k/Xwb9uYUk3HbAd4stCNq6T0JKy0im3O5CyCr1o/W4mexZvpvXyduR0TcyGgLxTf/LjPQLJ60tVnUQUxU3h8lYw0OSxyPh3FQGvUQ/J7tCkRWgigB5MR7lywOBsIoV85Fysh8E/sXataLoVqlr5BiY3iK32mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806900; c=relaxed/simple;
	bh=uOdhOyYOYMVrUBfTRyb5sKNN6DqI7uarBUjBIwIhyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtC7cT8i7Xli47KEHjcY7g+dFgb3fSYxPOepnSVjH3WwmxFmjsURy1XadKn05Ki/l3ePSIDHFzbTTp6docr4tkdDfdEZmxpygjc+F3QUEh5KgdAcZXJS/Lj8IRtsHYui4/Sg2va6TlI9wby2s4diNZclK74YEWG2F2vgGbHTWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=bsK8cuuI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806860; x=1724411660; i=spasswolf@web.de;
	bh=PD0UJnTTUnduI4jUI2AUZd3cQsVgrFRB0T+PkKYNVlE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bsK8cuuIwKJQ7Clao6dvNXejoLvUACj62D88xFuXrHIS+SqZqZTiIkujgT3A9ogY
	 IhQJSqIE6uwM4jJUu3Y+OOCpiLqhjeQUQBAvfUIKQ9GY/NyQncvVRmKmO9P1KznFv
	 mICbU3RCOrx6UYEEc6F8F9j60SD2wIqZlWOrUuIbPditRuTPuMpICwfgd83XWKsJ+
	 NAVvDNQCmC8+8/prBKp1+f/N1mhVGUKIdWaMxOA5qW4vuiHTMby3PmANgpRWjQD+d
	 pgBkbFv+LVhQcrkVk3+H+FMLZUjvNWBz5Fnw/R6Pf0xtu6f2i2Vi1M3bApaKoWOwZ
	 /+jId0FSCoX7SPdC3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M1JEu-1scB5F3PJa-00Efvc; Fri, 16 Aug 2024 13:14:19 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 02/19] mm/mmap: Introduce abort_munmap_vmas()
Date: Fri, 16 Aug 2024 13:13:43 +0200
Message-ID: <20240816111405.11793-3-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816111405.11793-1-spasswolf@web.de>
References: <20240816111405.11793-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7KgXoE5HB9OV298a3GOVGcOeApkwDqVfJq67tQ9GhMRkOUXHJq
 gQe/uyt64zxgKlEVwry9NxzofzGiM+VSusOjNCQCe9eR02VW5JQJw7hVKeLlUGcPh8uJ1jF
 NK9AUGmZJg3Ne3Syq+OAN1Q0jU6NHxW2SiHXhvRCPTLE/2LbW1krN1ZNb1yITe9LFSvu5af
 iZDSjIiY0lFBQveIY9w6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ofwdbonbc40=;L5C5ebC4C8iyme8NqV5FdrBrKv3
 jggi6yIg5irFKJZoFZ1AUmOFwm629xLS/Pq+aBHQ1Wy3oeXp9Q92h0JqJ56UUO1NyNpCdAro/
 XL5wNfpHC4LTisxEPcRh5wJFlVM8ALu1v4zY5wohBc9Efw0gZB6DpzpRL4YeDejTjhCph66gq
 KuWEd+ATwhmmcOkKo1wZSFCFNgnL10kwVxKqMhQkdmJ9ou1RRnGCmlcI1W+TTrNqygX02k9Z2
 MfDLUCL67zBTEk8rZPwhCssKbChfIKdzjewDjKwr1Dww++SgSYLo39KykJu/I8aqes2ye2QK6
 0fNZxL0auXmG9hR+QrUjdZtkomvnWWlc9m139gMPOr7yxmh9YrgQfNS6ywo2Qkaqigia/Cnii
 kIu3YGK1N0MjK7qsl0B5R1Y2KjaLhKq4H+zIEVrukpDYJV+oNHccH/iGQRkljXKvLfRpOLS8Q
 sVzHXhv6pbtxExHMB+pA4yWJ6XMQx1+s+Q4OGEqv1XRqb1mARQBHVYr0H0cL8xYs2s4QDGAIG
 ZYr1YW1gWLMSXcfdTCuGbJ/mu/Q00bYXH3bLqPCZcOry6QyTQChYYgra9LxrK/xpOABnfUwaD
 iLGGXdfWuVOf8IcbrB/AX3L4Fe9NaTxnx2ojD4KatOqgfqlo4NzrH+34x3uuW9A7F4wpnBqHj
 qjtsp96aR0ts+wZdFiHycF3LXvVMCKUo37nX0giTE5FmtgCXj9nnFx8h78l1+oughaxjeVhl2
 gOhC2mx6vm9g6OtEuTYmhYvjd168A2zjfBRzHFJ6pFnzTcdGKopgONNxv9vjTVV/qUYb33yR5
 WsAqjsJ2otakBBPF2ad3jluA==

Extract clean up of failed munmap() operations from
do_vmi_align_munmap().  This simplifies later patches in the series.

It is worth noting that the mas_for_each() loop now has a different
upper limit.  This should not change the number of vmas visited for
reattaching to the main vma tree (mm_mt), as all vmas are reattached in
both scenarios.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
=2D--
 mm/vma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 02e4f7cf489f..83260a3142b3 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -668,6 +668,22 @@ void vma_complete(struct vma_prepare *vp,
 	validate_mm(mm);
 }

+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track th=
e vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -822,11 +838,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
+	abort_munmap_vmas(&mas_detach);
 start_split_failed:
 map_count_exceeded:
 	validate_mm(mm);
=2D-
2.45.2


