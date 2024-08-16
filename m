Return-Path: <linux-kernel+bounces-289580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EA9547CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FB61F22434
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7351B8E90;
	Fri, 16 Aug 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="W7Tn0jRd"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88F1AD9E2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806903; cv=none; b=fjpfRm9jrHJonO1C13j/lnypngCfhwegu/xng6sUHdgCOfMRHu6FEdLNlT6mkxo1yC2LlrrYjNvNJEpoKJrQnURfP4wAl84ivF4hk+SAvdDwpyJbDHGRKb6NxWirryYSHfcNJmFr1PDJCxFj81u/yMbs1yD5o+7LYtW7Wwqpz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806903; c=relaxed/simple;
	bh=tolYApMOUH4drh1ESyYQeEboiM8LGfjs3RTlYK3mv1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRWykr9zIUTTxH4DzfM+Mjb/ZHoaMvfxW5+wuJz+G38ORv3o8W6eyjWOJytzf1s7ZgMjdR/k9UOkfemeS8Vz5ZDYgrxKtZaMpEipi/95l9GulX6evFfbN2d+5k5WjgiPxrj8K7fTS1/FRdTSgZtb3SLtDt2bymJKECunwEI1jvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=W7Tn0jRd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806867; x=1724411667; i=spasswolf@web.de;
	bh=ZrQQQZT7ARQFRs0tgv1kX7XArulslu7aLmdVZtTsOAs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W7Tn0jRd5zBYzYAbHIabP66dwywTX/boxQILpw6V8lqFe3+nJkS2Wi2xzo34Azh6
	 R78dHG+LAbrdfPDE9KQBWTVmpBWKV7VtbTJBsMNqbb8lbtRI1eVv9nSkhzL3aOpiN
	 Pnj/gfq9OJkl26gulZN16B5V2S6USoSW6zmGKAJw9TXfTVGXAAXqowFi+YcNHs8a6
	 XISXMn6AbT/OoKEtz+f2ShBnNs1IK52zh1BTDaF2Y9Lkn9M++0GpioYDv7xmrliDC
	 m4W7H/lTAPB8vjcGN0I14bsuNArJ81ZZZcPhaMIrWW5yNQI5ADh4jU0yGoktQvhuJ
	 Qcs7cjh9kHclEw9Gxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MnpKq-1rprmT2gsE-00apSa; Fri, 16 Aug 2024 13:14:27 +0200
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
Subject: [PATCH v5.1 07/19] mm/mmap: Extract validate_mm() from vma_complete()
Date: Fri, 16 Aug 2024 13:13:48 +0200
Message-ID: <20240816111405.11793-8-spasswolf@web.de>
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
X-Provags-ID: V03:K1:PeHNp6vd5g1Yuna7MwxF2eluiE5lGDtciQJQOfuIb655M/kSqfx
 rpu/JA/CNPZ80YnrYGfyMRECVf0kWQAzgsq1VZMIfL7snPdj6pSTkY/z9xT9wO/mQwSfpU3
 oPEVAcFZyj4JnbU+/81JPz/dpnHrr72PWZcmKYYxhk4lBORwLEP9oLHS6k3c+3OukPKCoa8
 TZO6Z9/DCccnVx7rEmaKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NAqq5pnOTuo=;FJgYYPfe70gjTOnVZLDmq2sgskM
 eFjDI3YQ30p3NBtcBus+7MAQ110HGDd7L6JI//poo0vtKQl2j83FqbW7GBFXuxvOTQFV8YJ8Y
 eenAkNojKhVm1B24OYAvHYryZqP3mQ7XxCpJPaWP0E/pSRhSRng3RuYeWLYKO3WkY1+hvRCZd
 pPKkDhSf7UMrR79hDL0G9bOC0Aj/YTIwIC7j6Evhh1VnsOMQ2bJhDkgSBYJ7Tq29ViozX/tNT
 x1VWHrd0XD1mbm11Hb4cby6sCcAT7FuVOhq28+Lkk63FBz8vOev0YI47lz6xLHLhE7AttRYkw
 ODmEdJWyO2PiXAdTn9ue7PWpJ06SqECKj7xiaQAVyIDiJ6+xRwXn6kRW9KxhLjRlWjc4Fwkeh
 B/J51S+tpaqW5+bfDSFoJUBbMoWJb1FdFSp6A1opGntqHbKystc3vWxdYPaRwGgIkV37GuiYm
 rNMF32g6/XPM56IrcC3a7ECgsudgME9gVd9LInmnn4Q1HRJmax/wLkXObPocXqHRGRr5ObJ0A
 MI+srh7vlbTPsy/Weq8q8Xt9lYWHBRkc/4TP5EajiuZNsNULMdwQl4uW/RwFZ//Gfn4Xxzp7K
 yYuKsB0F8ra27xyFMPBBTDR18jgLkmyMX+Y9jbO7R47C12O62vsHOCgihwiIQZMELnGCgYKRi
 QH/zBsi1SguQb4661LrWttUmv3N9CJto0bmsBb0gxz0nMEeJ/UpBfD6t1Oi9aEq+FUFitXPwX
 pQMc6WfYmF7w2NB+q/4NRJbGubU6zpQl26uZjCQAz+35vHANrBy7E0eYf7lsrQsu8+cunAEBV
 BZmlCQ9ofOm4jQpu2sfsPSeA==

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
=2D--
 mm/mmap.c | 1 +
 mm/vma.c  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1da0e8325b33..6aed0b769cc4 100644
=2D-- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1805,6 +1805,7 @@ static int do_brk_flags(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);

 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 816736c4f82e..e4677364082b 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -242,6 +242,7 @@ static int __split_vma(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,

 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);

 	/* Success. */
 	if (new_below)
@@ -548,6 +549,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
 	vma_iter_store(vmi, vma);

 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;

 nomem:
@@ -589,6 +591,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }

@@ -668,7 +671,6 @@ void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }

 /*
@@ -1196,6 +1198,7 @@ static struct vm_area_struct
 	}

 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;

=2D-
2.45.2


