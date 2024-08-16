Return-Path: <linux-kernel+bounces-289584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0C9547D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E9B1C208BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636641A01BF;
	Fri, 16 Aug 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="L5L+6Zcl"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AC1BC08C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806912; cv=none; b=SjW1q7o4fdJ9uxA6T1DO1vkXpfkjjwt0MbdTFZMGL53UKGdu9f0W0MB1AFbK542+fOZkAr5HEQIhglc4Kf0JvXP3+Ezm19HveXAVj+0mBfPgM9lYsZ92z/Z5KLACALOjXfKo80J18rettxa3unLqgNrOZbWJlSNaw36Wt4UKREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806912; c=relaxed/simple;
	bh=5Ngq+nH66/ykxLU1XTk5+HN7Rutp9UxEriwGlEyN4CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuYE3XqfSyzHu9Ci+WIBtAyGTbv2gJd4NF4GNNaOTef9Tyq4zxrRhNHNg4W2RnEFLxGm207ewdtBfRkWz0glcVhKgQdKCs6vBwE0kKL5VfqPfCVD7MytFYwYtCXYPh6MVDCiRIV82YDjgxxNhKhujwHYfJUuQfaaqQwG2cLKVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=L5L+6Zcl; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806876; x=1724411676; i=spasswolf@web.de;
	bh=E0tenUw2wopYUJtJXU9/jIJXrBQpDpxL8g+F0RGALdE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L5L+6ZclSX42QYLUW8vtiT2DDV1YDpOhnQExdYUeK+gKP70ob6BDFbrVi57Dq7OD
	 SXzKAOx1jelINkzMw2MfwIV2Kl52MFHcPAX375TlyL2TmOyHep89DAAZ8+ngEuJ6L
	 Ly2dssKnMC0UV2kJBrEOUMgEwAdlX241/FTZvk8JvjV5W2a8QybRKXiGem/R6kGnq
	 hRoEN3F4MEZhJPdgQ4+r7OWE1S0mDvuxJTIQ7nbsc9aERcP758G+R+Bd3CrFg8OU+
	 K+fQj5pRuDpnX2m6ifzsS+kZp5egWy/gp9959iTbgEA0h7t0Yyq1xxzw88p/sNyX6
	 DkBQeZlouAHl4Kilpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MIL4Y-1sQYuW0HC8-00380E; Fri, 16 Aug 2024 13:14:36 +0200
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
Subject: [PATCH v5.1 15/19] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Fri, 16 Aug 2024 13:13:56 +0200
Message-ID: <20240816111405.11793-16-spasswolf@web.de>
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
X-Provags-ID: V03:K1:eCVsU7mzHyULyhBGJDmXZIAx9FHHpxBOTVU7MpEzaMObRLktneQ
 WA9rkX1sAY1n5DbOrkqc9/qYe7aDDa2u7GPHUCOV8ylG9qS49ksbEXIrvUIXVxJJa6IplUS
 RnAiqkGx7jYtteewJE8JIdovsqUFWe1pDqORtMKUBECCsrjkaid7BH/By5+WMbpm5GbwLm3
 q2AOA3OXOU82MSdb86uxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bA1vkDMWn8Q=;9XG+PHSHOtTHHkd5lMT97oXUb+9
 /QaI7lZ3s0q6Hr0G6SODvGqbbwspTcKMBg/AngIZtq+pN/N/whiiXDuBZLFDdUN72p1ebRTmS
 ZsdDtfDYTAidoAWZ42p7wBUj45WSk7qJrtt3lj9XDyh368F7fh9yHgG1dNUQymRhefuqV4w4S
 yVQQeSTFRJtYslXnqWdh0mlLMCnyM/ugUFANiJrtGBnIbdjtcBbQAWvuf89NzrGm43p91VlED
 HqzBXet5JHKzyFrdR2rG+m5SkXaWEnCsEyTboAJ37nicTU2OT/OzB1A6jtufxkVeIVSA10H2p
 mzsq0D9e+vabkp/IKwwvk3VINxlSsjeMRpaRb4dtDu1uLAIlLybpIo/aC2k5pMXc185jw8Egb
 dwA42nv1Qi6Zavr1OUnVkO3b2gZKoC7hnZ2Fntl4yCfN/RhdzqgVmWE+klqF7tzLAUO3g8KHi
 KoDZABV1mJ+m93IqnMloI6nngx7qXWovS917yy+WiOGTY45HNjkWB9ZdlJztiHQTB9Ryiwoxb
 pU/andK5GpJoiHjyVQEuOvgnMNn5caRsVwmL/GRHdeFSFZ91/YjpjxMOdlxDUA8DAPkEF7/7S
 AlEtgHAIUSW5ongs+ezmE1uVlcO89p7XyqcnWZnp1sE35oID9GpvX8VVcg8G/AjIZtR28aQL0
 f+ZwnUeTUegV9JblYi+o0M9Pggjke/kaWMidpvB01UaqPvA2a4tzHkYGf5FqIy3S9LhponjG0
 +y3B0IY3KFIKDB5/pnF2wXzLpePCQzbGKKGWo+jS/EoDnfep7kwgESuZ2mHACN4MMtWGM1dWF
 T0Ra8v2JMpZ5MNkzUpMz6dzg==

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
=2D--
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e152b6caaf9c..57fb1c82a852 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,7 +1364,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma =3D NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	pgoff_t pglen =3D PHYS_PFN(len);
 	unsigned long charged =3D 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1384,7 +1384,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;

 	if (unlikely(!can_modify_mm(mm, addr, end)))
@@ -1415,7 +1415,7 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
+		charged =3D pglen;
 		charged -=3D nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -1575,14 +1575,14 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	if (vms.nr_pages)
 		vms_complete_munmap_vmas(&vms, &mas_detach);

-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma =3D=3D get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+			mm->locked_vm +=3D pglen;
 	}

 	if (file)
=2D-
2.45.2


