Return-Path: <linux-kernel+bounces-533289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCEAA457E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B431169D61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BC1624EA;
	Wed, 26 Feb 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dhsMVBSj"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD2258CD2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557641; cv=none; b=FvMh5TlCLgcHRcX9nMmyTP0DsflnSTpF48JrJeiqzw8XHfNIt2UxzYyZpY60dcDSJUndGkVKjbvFrO5VhWpoth/gLMS4plqrQdvE+/NvHta6mu3v6ZpMvbr5MuLMAkgjFTm3+RwNOhVuo8Ggwk2+Ha21GiHwrYPi2WMEpNYL+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557641; c=relaxed/simple;
	bh=MHoYi6MeQ2uAoTx/l3HlnLXFvLxDJR+RjxklBSgtnco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RHesuOO3fJgE65HwyCVdyqXuJQwKwA7svru1FjQJkLzLt/7fWP00kcGehfvqD6BD/yPV1FnSQ+zty0zOuq0WZMWKLjl+Dy7cqSejWk2ZfMWfDMj0JNmLr2UaxxKsmH8GjwFoK3WuCy8FazGUBaPPTzraSvwdnqm08Tf4Qi2yocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dhsMVBSj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250226081356epoutp018cf05d56ab598c429aa60c002e7b076b~ns-LaL8cw0999909999epoutp01f
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:13:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250226081356epoutp018cf05d56ab598c429aa60c002e7b076b~ns-LaL8cw0999909999epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740557636;
	bh=zV62Ppl9bLc57iOsxwWlThXzH/7aSoKI3RCXNue3PJs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=dhsMVBSjqoDHBukZj8B3f695ANd9iBnQQa5kvW32jsIP6IA815YFqsbVdi2BcKGvl
	 jdTiu6qRITP+uq76Jlf8ZKFaE891bC63SZ/sXXs972k7EivY0RZ5wJM468DWI7zD9n
	 sEH1o1DftoVhqz72/qPZl7O6Po0yyVXpvTo7csSo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250226081356epcas2p1861b9e6dc60a3252381b3254ca20fb32~ns-K5BtW_1119911199epcas2p1L;
	Wed, 26 Feb 2025 08:13:56 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z2nLC3DzGz4x9Pr; Wed, 26 Feb
	2025 08:13:55 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.83.32010.34DCEB76; Wed, 26 Feb 2025 17:13:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa~ns-JxRpMz2383723837epcas2p4D;
	Wed, 26 Feb 2025 08:13:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250226081354epsmtrp250b7b89c730a546a01869d3aa3a90671~ns-JwRTzk2522125221epsmtrp2h;
	Wed, 26 Feb 2025 08:13:54 +0000 (GMT)
X-AuditID: b6c32a4d-abdff70000007d0a-96-67becd431a92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.A9.23488.24DCEB76; Wed, 26 Feb 2025 17:13:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226081354epsmtip27199ab34483b5c499cd78e8c60b1c465~ns-Jj-0fL2366323663epsmtip2I;
	Wed, 26 Feb 2025 08:13:54 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, harry.yoo@oracle.com, Hyesoo
	Yu <hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm: slub: Enhanced debugging in slub error
Date: Wed, 26 Feb 2025 17:11:59 +0900
Message-ID: <20250226081206.680495-1-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmua7z2X3pBpM2i1hM7DGwmLN+DZvF
	9W9vGC3uL3vGYvG38wKrxcruZjaLzXOKLS7vmsNmcW/Nf1aLts//gMSSjUwWE9eIWsxu7GN0
	4PXYOesuu8eCTaUem1Z1snls+jSJ3aPr7RUmjxMzfrN4PLkyncljYcNUZo+PT2+xePRtWcXo
	cWbBEXaPz5vkAniism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
	fAJ03TJzgH5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+Wl
	llgZGhgYmQIVJmRnvJ3YyVJwj6fiUEMXSwPjVq4uRk4OCQETiR1PdjN3MXJxCAnsYZToeTOT
	FcL5xCix6cF0KOcbo8SsC5MYYVqufm4Es4UE9jJKLPteBWF/ZpQ4+SQYxGYTUJc4sWUZWI2I
	AIvEyu/fWUAGMQusY5ZYOX8yWEJYwElicc95FhCbRUBV4vmC2+wgNq+AtcSGN63sEMvkJW6v
	OckCEReUODnzCZjNDBRv3job7G4JgaUcEhua+lggGlwkjjV/ZYOwhSVeHd8CNUhK4vO7vVDx
	Yoltiw8zQTQ3MEps7rjPDJEwlpj1rB3oOg6gDZoS63fpg5gSAsoSR25B7eWT6Dj8lx0izCvR
	0SYE0agssX/ZPKgLJCUerW1nhbA9JO69O88GCZ9YiX1TbzFPYJSfheSbWUi+mYWwdwEj8ypG
	qdSC4tz01GSjAkPdvNRyeMQm5+duYgQnZS3fHYyv1//VO8TIxMF4iFGCg1lJhJczc0+6EG9K
	YmVValF+fFFpTmrxIUZTYBhPZJYSTc4H5oW8knhDE0sDEzMzQ3MjUwNzJXHe6h0t6UIC6Ykl
	qdmpqQWpRTB9TBycUg1MkZYrJhr0b428kdt44ATXmW0Wsm9PFYjY+HuuVZyQlRPcpTOz6ltd
	x+rNdTvq+TTeherb3DwS81fp10P5epOn3xhO3Du1qpC1rG7ldkM5t676lYYOT2Uibn2x2O82
	iaHuQ9D8N/EefZHxq8P26UeIsS9/5GNzobnm7ItIrq550yQWCS3dctRhW8M8bbWLs4PmJFzx
	i7jcOrW764o7j8pSxnzerXfMN3o9mPCxMvWZ2afzb3uPdV84br/n+Nrpcu5SDHc2uUbPZNN/
	5uZrsm79R399b70UmZLm1DOnX1899kWcR2inY3NIloD5dqV5bbp5XSsyomfXFVrnhctb7XjE
	3GFoLy44Ifu09zUntjYlluKMREMt5qLiRACTgT3yUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvK7T2X3pBlua9C0m9hhYzFm/hs3i
	+rc3jBb3lz1jsfjbeYHVYmV3M5vF5jnFFpd3zWGzuLfmP6tF2+d/QGLJRiaLiWtELWY39jE6
	8HrsnHWX3WPBplKPTas62Tw2fZrE7tH19gqTx4kZv1k8nlyZzuSxsGEqs8fHp7dYPPq2rGL0
	OLPgCLvH501yATxRXDYpqTmZZalF+nYJXBlvJ3ayFNzjqTjU0MXSwLiVq4uRk0NCwETi6udG
	xi5GLg4hgd2MEkc+n2GDSEhKzPp8kgnCFpa433KEFaLoI6PE69ctYAk2AXWJE1uWMYLYIgIs
	Eiu/f2cBKWIW2MMs8aZ5OytIQljASWJxz3kWEJtFQFXi+YLb7CA2r4C1xIY3rewQG+Qlbq85
	yQIRF5Q4OfMJmM0MFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al
	6yXn525iBMeIlsYOxnffmvQPMTJxMB5ilOBgVhLh5czcky7Em5JYWZValB9fVJqTWnyIUZqD
	RUmcd6VhRLqQQHpiSWp2ampBahFMlomDU6qBabLi70INJdfE8lnJxfuPSQsrlJ4ustQzUT3C
	OOfW7JmZon0PzCKUstTtJ3/7erItqfLgotMpu9cf9X9W48UR3cmu6Px/gX6rweyHVmsq1Xyf
	q/k2HPkbZanLPH3Vw1kJneIPTy63jwp1vFd+0Hz+vZnXpD5HOvtuO3vau0vb4FDvRIHIzgul
	D7kuPsz6WT1rltkfr3/aun63d54/uNWB+eYXA1lpwf9+mx99vxQpEaZyb25/+B/up2mVnyO1
	+eZbrMvu3/r1PPsuxUNKmk/ntn9eVfWgIqltnv29DXOmfv2pwaX/MP9QjVrZkj3mfXyeRerr
	T/vN/MvetbOE3TnuKYfBymXcWwVWlFn6Ln5focRSnJFoqMVcVJwIAIoCTccAAwAA
X-CMS-MailID: 20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa
References: <CGME20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa@epcas2p4.samsung.com>

Dear Maintainer,

The purpose is to improve the debugging capabilities of the slub allocator
when a error occurs. The following improvements have been made:

 - Added WARN() calls at specific locations (slab_err, object_err) to detect
errors effectively and to generate a crash dump if panic_on_warn is enabled.

 - Additionally, the error printing location in check_object has been adjusted to
display the broken data before the restoration process. This improvement
allows for a better understanding of how the data was corrupted.

This series combines two patches that were discussed seperately in the links below.
https://lore.kernel.org/linux-mm/20250120082908.4162780-1-hyesoo.yu@samsung.com/
https://lore.kernel.org/linux-mm/20250120083023.4162932-1-hyesoo.yu@samsung.com/

Thanks you.

version 2 changes
 - Replaced direct calling of BUG_ON with the use of WARN() to trigger a panic.
 - Modified the code to print the broken data only once before the restore.

version 3 changes
 - Moved WARN() from slab_fix to slab_err and object to call WARN on all error
 reporting paths.
 - Changed the parameter type of check_bytes_and_report.

version 4 changes
 - Modified the print format to include specific error names.
 - Removed the redundant warning by removing WARN() in kmem_cache_destroy

Hyesoo Yu (2):
  mm: slub: Print the broken data before restoring slub.
  mm: slub: call WARN() when the slab detect an error

 mm/slab_common.c |  3 ---
 mm/slub.c        | 63 +++++++++++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.28.0


