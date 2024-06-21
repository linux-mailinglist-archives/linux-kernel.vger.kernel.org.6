Return-Path: <linux-kernel+bounces-224854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA39127A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78ADB2469C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378B22EF3;
	Fri, 21 Jun 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2Vq+vF6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A593BBF6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979923; cv=none; b=UIyKWQ8JDhOXXA3JGUcYjrkuHEgCoTwxeSYfN+Eme6V6YW1HN/ECJvMAJ1desP7tBu09rIVQpa3IV+47889OA78Z0itEf0ZGBqD2gIu4B7uFotG3yIIKQx1XHom+lqGJLYLsu/QkqYF0QgB2bGgnYCP0ZM8uu3kANLgf3PH35xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979923; c=relaxed/simple;
	bh=OWZDuzR1vWK1BTpws23bW9z6bZLcvZYrdBn8qhmt+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOyy0dpPS4CmEO/lYVP2U6e8XcQ3MPNHUCEbTKnnLaWmkMXhNvbR2mOoDbmfXm1Ocro4nXYJH0P/wvoV9gnvVDetyQDHRH4xA2Q+HUjNQVeZeBfTxMd8KegbM5JJIKAy6wenH+s7JS9gFi+Qe8+gFqfW1EWv+FEQ+pikmpStLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2Vq+vF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2ztUKph00cBWbOmplix2Q4QYxHwnhS7TcGpCnDIOcM=;
	b=P2Vq+vF6xvnJHNzX3LgLv0Q97lx6QB1z+kDYWzuJl6ik1phHyEvA1dWPAxAANuFsv15WUf
	MM9UKTws0fV5qaAEVmmyq1d3E3CXefBvkj1eFJ56qES3CmROiPluxHXOn5vQ3Ky8nbSMF1
	nvE7zBTcLQ+Bq21xeOKdra6QenZaZQM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-4KDroyRkP5u_-Z_f9GLT3Q-1; Fri, 21 Jun 2024 10:25:19 -0400
X-MC-Unique: 4KDroyRkP5u_-Z_f9GLT3Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-25cbd68532fso343133fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979918; x=1719584718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2ztUKph00cBWbOmplix2Q4QYxHwnhS7TcGpCnDIOcM=;
        b=VQopFV1nPKgBGfQJb/rnLjGLZpCXyP0CTyrUT4cfUL+Bzv2JWWqpOMVTP3rxzNBisC
         5EjJcFoxtVyFxFsstDwAsm7D+YNGHo5HZkfu18BYYG5u90lUffbNsZWDmBItk70kqyCp
         77RyiKYCBVn/mZQSeuVSR9TnNlo56QUTCdSnDj6mNK9UQvGVBGkuhHtqboVx/iuEpJNH
         nvtFldd22TPqrh5nRtzk1K4c+Hwp7FQRfJpxNW5LIBFJC4ezAVL6+RjhdPDvnmkkgi1B
         QmwOxk0Uvj8kTlu6L61HYq6LZ+OZRsfPMtbIDEzE+p55azoLNlL+nOywUpP2IvfEtSLQ
         Vfrg==
X-Gm-Message-State: AOJu0YznVEzvGLa3OdjV9aRVVQOiKi2r++nKC6GASxiAWOadSvky8OdC
	LhoTYM5nU/wImtL3MWJh/9BRZOKEWEI2Xu9UyhzAZtvihf08OAKIPp1OYg0y1H20YPK0CUeyhMJ
	H5tGGlcTljkge4NimxKd7wJ94l0Qd+LJiNeFjekTywCSddKNOplLR9rcjKdC7KOJp+iwhO4Lub9
	oMeRarj9DhCVrziqHNEMoUhwFpFeDzHcdfJ5cvlFAAP88=
X-Received: by 2002:a05:6871:14f:b0:254:cae6:a812 with SMTP id 586e51a60fabf-25c94d8a94emr9065133fac.3.1718979917984;
        Fri, 21 Jun 2024 07:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpfu3cPye3+7RpVIl2JRxNk+CTOiRpoiTdFmb6dpb/ERi8sD9JFsePfCkLHiFMYZR2Pz0U9w==
X-Received: by 2002:a05:6871:14f:b0:254:cae6:a812 with SMTP id 586e51a60fabf-25c94d8a94emr9065078fac.3.1718979917305;
        Fri, 21 Jun 2024 07:25:17 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH 5/7] mm/x86: Make pud_leaf() only cares about PSE bit
Date: Fri, 21 Jun 2024 10:25:02 -0400
Message-ID: <20240621142504.1940209-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240621142504.1940209-1-peterx@redhat.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An entry should be reported as PUD leaf even if it's PROT_NONE, in which
case PRESENT bit isn't there. I hit bad pud without this when testing dax
1G on zapping a PROT_NONE PUD.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..25fc6d809572 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1073,8 +1073,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define pud_leaf pud_leaf
 static inline bool pud_leaf(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
-		(_PAGE_PSE | _PAGE_PRESENT);
+	return pud_val(pud) & _PAGE_PSE;
 }
 
 static inline int pud_bad(pud_t pud)
-- 
2.45.0


