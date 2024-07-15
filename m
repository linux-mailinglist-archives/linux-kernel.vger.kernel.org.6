Return-Path: <linux-kernel+bounces-252977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF7931AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89902842F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D0134405;
	Mon, 15 Jul 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1dQFmFI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4C7C0B7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071313; cv=none; b=Nug+F86yI0nJF5X/9ReG8earGuIVVEZDBkFsnvCTU299G4jex0i1le6dZ733/m0YloxC4U6FTEW/LLjTxNb4BEJSvUIw4mgCnv/xr98cngMpwOpQD0ZSVrTDr4mlrXyNQ1E91xdLEZqECwrTCIm7SA1vZBnEckfuPIW5tYqI4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071313; c=relaxed/simple;
	bh=B0IpMvJzke/973HZPlLZKBuCQcswwxmVEGuJbnrmXVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+6sal+8yVc9E5vrwZSUO7DeyvDCaQHSxBhbQfecmgIsWXgrgqk5e05fVv5+eWdc1JrfdCCCj5kMGxilUICEJacjDShcbg4ynY2ZW8TTZ9ATfStLkZ2X4A3hs4++VTiJqzYhOS7vhK06ruQz1Qv+CiT5/+nrQYj/ExLGqLYI0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1dQFmFI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
	b=f1dQFmFIvE39L4Oz1vCjEab6/3xCsZp91iUrO/L6DzsAITR8+D5/B4cc7oF4aIFl8Ix34c
	HNMMDhHVDgR1gTHPhOo3RPxFw9TKIWvpc/vuMR59BjmXeuTMNVVOUo2zUlkiYR+Rc8W7xx
	fxMxe92vWLe12VkyWL2GraL656ZMM38=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-40PEkCWSOQeOZ6yJOcCfcw-1; Mon, 15 Jul 2024 15:21:49 -0400
X-MC-Unique: 40PEkCWSOQeOZ6yJOcCfcw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7678caf7dso6080926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071308; x=1721676108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
        b=T/EQEP5NPKh2tRIq4+6YBZMC0xko9HTUUSVi3Mz3Q66w2+UYqSKtqjRMTxqSjQzPPb
         a/fo6E+843TxKmycryPjlrXKTEtzpDb9kqy3/0zSXRznFddNqu+RlrwnRR9VMNrF6Br9
         m1loGoIU7oPxKSC0qqUyWlxS0hSk1pP6slnt+1CV6DnQl/IM/glCNFzXG1njTkrisvUj
         fEzxHNiQ4ArYmRZWnx115h/4cv93QOGfdQ/lP7U5XzonEXLaoog/oPaYsB2rivhW6+pV
         gn8oUtDbXIsfMLw2DBsWKKgkW+MHkgdVFnCsplv50f12brZ+xyEj7deLaioHwv2z2LOU
         S1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLwXmKvKZPSIdGIAVIYH1HwrAEu+RVgpuphzOeSV7Mi2PGuiam6F8BidXWTqy0pdfWTFNrzkq9Gohb82S/PiqKXoGnzYQzWDEUVgc
X-Gm-Message-State: AOJu0YxD0R2vJI8MU9q3lzTwbYuBp+Xvz6hkXYoNQ8N5OSB5X7pWD4eS
	BY1Yn7S7sR3LhWTpNdvDGi0HMlB6nUchzGw4m3IAw1nXDt18InaVZghUDPR5YH7EcdYAyDMIvT7
	N3rdDNa2m7FzgsFpJe2IrTi8JzabDbR3KTu9XIuiMw5qBzTc2B6t4B8Klyo0qyA==
X-Received: by 2002:a05:6214:3209:b0:6b7:64a2:3189 with SMTP id 6a1803df08f44-6b77e17f47fmr4877726d6.8.1721071308370;
        Mon, 15 Jul 2024 12:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFchV1JB+E55nHTPY9KJJNPGb9+S7LV2RfQetOl80mLgqA/kra292Zxs5L4jIR6tRho3Ee1yQ==
X-Received: by 2002:a05:6214:3209:b0:6b7:64a2:3189 with SMTP id 6a1803df08f44-6b77e17f47fmr4877546d6.8.1721071308060;
        Mon, 15 Jul 2024 12:21:48 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 1/8] mm/dax: Dump start address in fault handler
Date: Mon, 15 Jul 2024 15:21:35 -0400
Message-ID: <20240715192142.3241557-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the dax fault handler dumps the vma range when dynamic debugging
enabled.  That's mostly not useful.  Dump the (aligned) address instead
with the order info.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/dax/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index eb61598247a9..714174844ca5 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -235,9 +235,9 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	int id;
 	struct dev_dax *dev_dax = filp->private_data;
 
-	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) order:%d\n", current->comm,
-			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
-			vmf->vma->vm_start, vmf->vma->vm_end, order);
+	dev_dbg(&dev_dax->dev, "%s: op=%s addr=%#lx order=%d\n", current->comm,
+		(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
+		vmf->address & ~((1UL << (order + PAGE_SHIFT)) - 1), order);
 
 	id = dax_read_lock();
 	if (order == 0)
-- 
2.45.0


