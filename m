Return-Path: <linux-kernel+bounces-289581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD289547CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19781F22202
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951B1BA868;
	Fri, 16 Aug 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="BNZQMBdl"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57D1AE87B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806903; cv=none; b=sUjGKzxUfuIhLpBon91JUu5W8Lt9wddU4Ki+/lMh1CSS0UY3lWl1s1gCC30Ozk9oKaB2z8kl4qmI9RqmpjEaM9hWZ6sLAxtUbTBlWl8S0GwAgaNXKj40W8wcyiUTe/lXaRh5AgjXfCrVq+jcvJ89AEbEgdcZ3c1sa45gx71pboo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806903; c=relaxed/simple;
	bh=yK6ov8hgFtaWAM1vqMjc3gNimXgnllKi2UDmtSbYxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4fLSuSaEA3IqhCml9baX6S5GHkWjSqYtOrbk03uLcRlaEnLKUgc+hh/k8VVDIDFWRqp4Gz4MZyNFgf/QhWcCQ/zsYymAqarJgZR91+a19/DC/JdGV32GeBR/gdvuiUET28dt9NduvopunwSgnZAsYIb5NiG1TvANq34phrCZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=BNZQMBdl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806870; x=1724411670; i=spasswolf@web.de;
	bh=q0h6rMe/QGaT++JPp5Z3rkGRpCNRbqXYhv4xZ4c2KKA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BNZQMBdltYarlRDfr9l+xhmEOPgu9dPnz1Vy9AwBEuxr8kVyy5YMCQ/XXZ/sjkBp
	 PL25ghqtjvKhQqHM80zU1tHv8j1h5eFoeEAByPSoy+pFfzXDQQnpVjIv7yk3d178B
	 tnzjVme3+aY4X6TXNq6XFO4IKvTxM17KYhJnEdJU/6rJ1W8DtqVq9CErAIZUWrkY6
	 4qqHSmHCSds6Dv0YzEn5qN1LXOUVEA3dtdyZ8hB9A48pTtAhzvy59rB0R1K0iwpS1
	 KihTCbL98EqYRU3IkBUkB302Ng7HaTn378t240WUYkw2KXLII7EAI+dmiWtBr+0rA
	 v9QJU+x3DP7ceUSeDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N62yY-1s859h3aUy-00suJG; Fri, 16 Aug 2024 13:14:29 +0200
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
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5.1 09/19] mm/mmap: Expand mmap_region() munmap call
Date: Fri, 16 Aug 2024 13:13:50 +0200
Message-ID: <20240816111405.11793-10-spasswolf@web.de>
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
X-Provags-ID: V03:K1:3fFxHOvIpxuFtPf29BwBcYr+yqtYehqzJgvJRmGLNR5rOdc3yPh
 GnhJ5knCS7QqrGbxM4+N3sB1dK0m3tOiqQNX/oZaSkeGkyW2goQaQFwguClg7nXkljAuNrv
 VLOtsAsKtAbCw7uxsSOSChzIRpt92HTrS9e5onFPgvYbwKfjn19554eeeuPzWfd88tq5kSm
 9afxwJHMcns5e3+Mm28rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tp495Uzsi2o=;GLD5Dcf/qUytGv/C6v/BITps8Us
 +roeUFaZ/z5RrHebMmZgfH+F8xHoZymY5ZqBlzcK1zjLUAuSZKY9+YVXq6QZsZpL7YisgJsEQ
 T5uRQaXAu3JnIdsvEx/up1cmL2khi0SOKpd+BBnXH16QOviyk91OZRIDm83WyP8kHPMZFqmmn
 rACVD0h7cWN4wy7NabEwIzIUI2D5J6K6ClK0ezWIlAz5UJFKDiWeYt0+YPP5ENQ8fsac9qOhj
 eEDiM+rmzmq24stZhvKp5hNB/iDLB/MLiYyjJRt4kcFi8FMW5eJL2nYvjs/WcyltmTIEnCKdV
 1NrcqJyMkNUv1j3nXE15+6ZhrpbXpPPWRCrHxgS2l44r9EuYNCLYGj+rpOlnSBXqA1wgn63mm
 VIybrgzIGm1aMSgWFZ2yWTMeOznnGw2CtJC5VpJEFzX5EjEv+S1uiPlFHV+t9qURZsbtNn/kP
 OU+8G8zCPSNtaWzKhupwevc9+ljHktVJQG+4959tVHWgBJ6s+H3R8bDnL02KLvFTwrWQyGzAS
 fu5blI2j0srPMH5Hsep15VQNDxr7aCXHNOSwImB6aVusBvQRTEdsqRaAjPgONh+lshC8EmoeE
 Asgvcc3fn2NaLcfRr5Yzm8f4Fnha7+mUCvvqgbbCstRSCIdYSC/hEoqiCTW6uFjWgCcwirBVV
 nrq+BKyLIcuSiD7HLz8mZUAhJ97o2PNUJZF25BCTLdlYVN/sFWp3VGJktPvYlt/qRmoVmJo5V
 M7zNdEK7sBfw22z6iWfW/Ij6AwKssGFzwa3GGXM+8VA9SSGGpWk5nRl9FBVlj8YXBamJQVP5C
 PxfzF1Llmai/300S+RI/2QNA==

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6ed27cf12217..56d0aaff8478 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1366,6 +1366,9 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end =3D addr + len;
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	bool writable_file_mapping =3D false;
@@ -1398,10 +1401,27 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	/* Find the first overlapping VMA */
 	vma =3D vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock =3D */ false)=
;
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
+			return -ENOMEM;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
 			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next =3D vms.next;
+		prev =3D vms.prev;
+		vma_prev(&vmi);
 		vma =3D NULL;
+	} else {
+		next =3D vma_next(&vmi);
+		prev =3D vma_prev(&vmi);
 	}

 	/*
@@ -1414,8 +1434,6 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}

-	next =3D vma_next(&vmi);
-	prev =3D vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
=2D-
2.45.2


