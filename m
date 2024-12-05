Return-Path: <linux-kernel+bounces-432822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D69E50B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF618827BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6E1D63CF;
	Thu,  5 Dec 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxmiI4fx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F131D618C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389520; cv=none; b=Vtzn2g0LQkfGa3LCOcyX1mIZ0PwPnCdFkVTTLm5tXPktMcw9g16OHBtT3220feyFS4UwYbPqJUKdB5G8KQRdougY15jA5NUy54DyxdZ1ZjeuKEFr+VlO19RkRH/BH/YbrR5ytoTfy3hJBKJVmtp+rNNiE5KohuEvBsQ2qyLhDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389520; c=relaxed/simple;
	bh=yQP9CqueRlm+YQ9afptPMf9AE+3AyBDNitTmhZ7+6Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyCOcbNBgxZ0wQsKiOJUfNehHHj6YF1MaKl/uYccdg62Ona+oYwSJwN/VBykEaPFyPWQb/szgepKN7isTJCxWMYlLYRbC8IhJSMhdPxddQNlZr2wIYUiSvPOli175AR0XDWxozHnRs1xMplhY7uTNhEqc45xpM+6nt53dGZ3ABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxmiI4fx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733389516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZSFDwJlAKXFJSXVwhmhlyEP18MO+pVAWVa/JNjtNys=;
	b=LxmiI4fxySaeyv34NoDEaMh1w5LWCbDqx1peSzu7DnCACPVCpvlY7BY3eYQE2Fs7bH2n/H
	cXdfgXOv6MZC5YzYfdlPd3bzuhSfYFqtoORbe7bmPZwNjBwEpSnE9PjwsJ7YSG1iZ+9uUG
	wnibcKjG+ILJGxtzaLIKciUTJdvAzp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-obQNsKP_OcCamlK0IDtnpw-1; Thu, 05 Dec 2024 04:05:15 -0500
X-MC-Unique: obQNsKP_OcCamlK0IDtnpw-1
X-Mimecast-MFC-AGG-ID: obQNsKP_OcCamlK0IDtnpw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d7611ad3so477599f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389515; x=1733994315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZSFDwJlAKXFJSXVwhmhlyEP18MO+pVAWVa/JNjtNys=;
        b=XCHD4mF0BNNwT9Vu8glBGvxmP0jqXsCqyaOnTybASg1nnj+ehnkmabHlbLBfEnQ7eS
         hfNAjMNXIMO5b0E6n4CAqr0CASCBC0ca55sNqF7h3VykSP47VvirqAlcc6sRkZnmkVcX
         sSH+ZMrSzRnw5Gkb5GfR9Ay2KOsb4LICet96CQZV0XvjqCHQ8ccRC8N10fzgZJIHDAYy
         h108Gn6pX1GhROA7Z/wVXb1NvsBP+nslLQNlGfKuWS8D6WMy4k4pjlqfFp9R7E2rKlB4
         tYi1Rv2A0RU/NcphGQ8R5Saz/b3UZhIzQIBCRqIolxYsF4jZKYdMBzwpTWrpOy415oeo
         k2Og==
X-Gm-Message-State: AOJu0Yw6QHa+QTTGJJHcrQ7VL+Suk8Pgy9+8RV9FzzCpbSrEmYfqDlYi
	diY7hKqLI7CpJa3P/Tqh35zNDAKxBRj3IrnmslkSEAQF7efghaBcHpy4svXh96Jn9TulXXITugi
	DTlW6fVGpCnHlvJDC21hVV3/1L0XEgYrOsseAc6++19ThsWVLtVJZW8mENomBaLhMRaTqUlDjNw
	tINRC62qHFZ3RDRc68K9opQy9Un57HpD6+EoIplz7Neg==
X-Gm-Gg: ASbGncsFb1dXcF1m8rL/XQpOiFTxsDu3zpANvkYn3t7LyWI7Az6+OdTB1TKPs2yF1In
	tzgwxLyIVlkwBtcg8pog2WQxezk4H5IewnOMlBsHhEihEnfF+u6ys7CpQGefsw/Ye15yQIk5DZZ
	1jO2Z2c0bs0BptWM5eon93JCFYDhOKU9kI+LmTALcrKKTJbwwppPFNefx/l2TyfKY8xNGyTZQ50
	Sl9+MOiYh6vQeNTZUKvQ8uvynRq8jBRk2lDN/qE0FBx9wEsdO1+0ja2aOFenqFXnh0yR1Gl3gTt
	CuW809tCARTN97uyF8fniTWUk5vkeP3bf5M=
X-Received: by 2002:a5d:64a4:0:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-385fd3c698emr7956184f8f.6.1733389514714;
        Thu, 05 Dec 2024 01:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCrbcpW1Xi07pKqvUBrMBHYZrVQRE4roT9Z5e8o7Kih4pqEH8fCaIymgDgFkTeIR8MpLgkow==
X-Received: by 2002:a5d:64a4:0:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-385fd3c698emr7956147f8f.6.1733389514244;
        Thu, 05 Dec 2024 01:05:14 -0800 (PST)
Received: from localhost (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3861ecf4395sm1365949f8f.10.2024.12.05.01.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:05:12 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RESEND v1 1/2] mm/page_alloc: don't use __GFP_HARDWALL when migrating pages via alloc_contig*()
Date: Thu,  5 Dec 2024 10:05:07 +0100
Message-ID: <20241205090508.2095225-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205090508.2095225-1-david@redhat.com>
References: <20241205090508.2095225-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll migrate pages allocated by other contexts; respecting the cpuset of
the alloc_contig*() caller when allocating a migration target does not
make sense.

Drop the __GFP_HARDWALL.

Note that in an ideal world, migration code could figure out the cpuset
of the original context and take that into consideration.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48a291c485df..acadfcf654fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6410,11 +6410,11 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
 	 * for them.
 	 *
-	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
-	 * keep doing that to not degrade callers.
+	 * Traditionally we always had __GFP_RETRY_MAYFAIL set, keep doing that
+	 * to not degrade callers.
 	 */
 	*gfp_cc_mask = (gfp_mask & (reclaim_mask | cc_action_mask)) |
-			__GFP_HARDWALL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+			__GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	return 0;
 }
 
-- 
2.47.1


