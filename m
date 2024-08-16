Return-Path: <linux-kernel+bounces-289576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226F9547C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3710B24DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894831AE878;
	Fri, 16 Aug 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="isRfwnJm"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9F817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806900; cv=none; b=JNTEfuWuaf+OngUo2TB6UV8pVle5zk/fTd8XOh6waq/JawYR9BmRkROnB33y+3NnIkUtjsZ1M4AOHfJJUR+vLNR1OnVLMPXsqCcrBaivAykbF3JGk8PLzHDKSycBxbuvfBmrx1F3ELt9+u0H6JFhI0o39l2BlojY+NNKk5ATmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806900; c=relaxed/simple;
	bh=Rt5sAEEdEzxSe13kpuFXBanKCAjzUfRU1j6PKopeDTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9A7j0n6jLLnwkqelKQoZAn9cHs03apW0Nmsz1W5PdlGgoUQfD9AJubbIItuveXmgaPMDwJeZRSjPLKxqTpMJxEYrz4Eq7GaBGBtYPF4S31Wfw4z9UjM1sFU3a6coRR6ETbZOw+1ZMBdfa2WrNHvTDX9BxZ/YYhXnOLkHlmvjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=isRfwnJm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723806858; x=1724411658; i=spasswolf@web.de;
	bh=hyLy5zcuz4oq+TGeFENweUivt0Um5vv9+zRVy5K7Dk4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=isRfwnJmdoIjdoxSXjRx1ZoOuxuydYKOM53dmNbr/J8Hdsa9t64eLYIv4NGyNM5Q
	 2EpEg/PT1iMa85RnmPd5GWHFbYHslvIhUs9kOsxI3VWROgifb0YX+8ToDLs8t+GAP
	 idIz8diiz6X++gTr6PYCtOoI+b7D6NJy4bs2arEh4U1PTvxyDl962zvBEqBLFJ9sz
	 zrv6AvuF83dor92u7kJJiJZRABYiBmVvYtmQh+B7WEskiYFgyKIg1kjorIPojmgw4
	 gPYjjsWTdyB6mlC7000R9/24PjVIwCq/U6acU0XT41BII63oG6+DbJmSTbH5YAV20
	 XAMLRX6ldMimz74o/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MvKXb-1sNFZA3G6b-0180Kx; Fri, 16 Aug 2024 13:14:17 +0200
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5.1 01/19] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Fri, 16 Aug 2024 13:13:42 +0200
Message-ID: <20240816111405.11793-2-spasswolf@web.de>
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
X-Provags-ID: V03:K1:+jC36m1sRkvD5Vpf0wAeR0fwYwAGuLGXzoRuZyjrkTvLj8USB2Q
 nwExSus+XkiTkJ34jIqqtkqkt3AO+PPmAXiqZW3RgRrAhEoDWGFU5Pu2G7RFqxKwzSAmdNJ
 BsjgHW2psegBvLOjhAiyuX3tDxwTnsAU3qt+LoA681DQK+0eHEkUA58ufkSG58CFxlRpR8Y
 f2U9vLsm0g0bfzfuBOn+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xlXs275Tsxw=;5tLYSClCHU2trUPg31ml7gJdKMK
 DPbAa4ogoE6zXVqtGcUjy8gOfcVfhYGhvYoxL8qXQWVxgS3gs/Uy1FsR7YuL2dLmVGoQuy9CX
 Q8ODAMPw0cbFMha20Xuavu8ECYNAyDIvJLXjRtWw770hccX9QnSuEJwV6aJBVyS6TCxT3lg12
 dVr7lgTjsRg5i0neNZJE/unSU/4Qu5uWKPvl7xWnA3ogZWqPdWOf6lBo6+zGy0SSQ+Cch7qJq
 OFl8LYEDqdh/XqaRcAU0Z0rVVXqzD2A1WQK+6dpIxMhmxbrY7ZS16Vz8T/OIjvEm5X55ycjCP
 moNPL5LzbA0qbR6O84EglsY8ALLzkwWh2LqBNdmidfeUj7eM5FJvNCv2M6xwv9q8a+jeNc1AZ
 N4tCUkiPPRZWDxEAn2bZD04B9ifnzYWqB3YKPC7TkpMUm8JfPoQvNrgvfDwYb5GGzUw+roTml
 HBr//2ROSZAH+PaGCOgr1AJuzPNQBUbFwpGeMWOI3bMbkq+wb8hM+p3x+CXX01ezqgHg8iZBh
 J6V0cTIlERHDGc5WYgrC4yIbnQ0PuKGCWdAlgjmB08c8kR4DyotDWveOOyxjGayx4Kzc4Wv2z
 9HQNs+z3sLhWjytwiHNt7FKrM2sUauymNz6c2n+A3ZZFuaqRYGU1txvW/nqNGFPJRNPWtnkKK
 GiwNeV69kIrRUsxLZztFGeRBf0Rz2Z7rBMCVGzMFdQjfLdLfbvF1lj7OhqlTt4Cz+06+rRhfE
 FFL+PhHlFSQRFXg35gSzL+SbbUP1wKy6RI9J7uYsBltAejcJYwIssmnWPY0eD02GRSXfUzTsu
 jwTuFyjVbr0i9dzTffCmFkmg==

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
=2D--
 mm/vma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 84965f2cd580..02e4f7cf489f 100644
=2D-- a/mm/vma.c
+++ b/mm/vma.c
@@ -246,6 +246,9 @@ static int __split_vma(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;

 out_free_mpol:
=2D-
2.45.2


