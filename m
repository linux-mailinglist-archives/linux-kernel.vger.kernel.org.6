Return-Path: <linux-kernel+bounces-556190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50770A5C244
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AE0188FC64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684511ADC94;
	Tue, 11 Mar 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oS7wC3oS"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87C1BD01F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699105; cv=none; b=Imr+LPv0Pd8YCx50X8OCip9kwZuizgSPZIqzkR0q4F6iHxlsr10RFWbykFIPoZ+RN4BKJh0MywEQNJjgbPoeU1c4HwygIWNNkd9NFG1vJID18nn1ovE3MFxhIAA4R4sGFplQbvM+P3nmsYqtlDelaGjch6CUhiTGQlcLnZm9i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699105; c=relaxed/simple;
	bh=epdKFY+uVF/7PgVLHKRyqByV9Sxbc8LmSXgVAXlQ4wM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRv3X+R/FstQo01p3hp03oKA5981pbJnIh2lJ3cKmlcgoK9qRFdrQi0rGPd9Nkq7I0MR9xceQAm2NTZSzaPp7JgmkfIJscO21BWv13YpPMnTzjjsChHF3I0j3Ce+xvTNYUfJrq3xvXGSileGGMn9X7UVGqCKeGJkc0Mr65kHhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oS7wC3oS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so27361705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699102; x=1742303902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNnWwlE7ZfA4njYaSa6+RHThvRYMfszFV0jljda2YI4=;
        b=oS7wC3oSPKVKVSYi9w/ORJ7KYQZjiNZv+3fM72dRJr13uKfg0uEd5+jLFVWL7fsJVr
         MSGW0KYM11lbtGGfCUpobD9HvTJtcneT9ylP1Nh9qAf3MGMIZ8gYPQbbJS/S1/0Zrjwm
         tEM2J8VG6xKZ+YowwX6qMfDkAgv6lbEnwc1jS4ewqQDl2UvWLiuUxqGf0lwCWyt8s+Rv
         Uj+6/HER2lsE+t+hSUqGNMrpgd0cbsZ/Gtq7eVLVrrYKC2+EKKD9f0OPkvNSjqHWMjHs
         1gzy0fOpsbUe/P9X3liFZ16+Xbi7femne/lgeWAa2ZpRWinY4iBgzhUCEP/E/w8PYDbo
         AnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699102; x=1742303902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNnWwlE7ZfA4njYaSa6+RHThvRYMfszFV0jljda2YI4=;
        b=FzMmN1htpPzsArvpphNxdoxA0zPVwpFBIoVIS/u+PRozGdQ80hGv8ZAaAGnsnvVTlj
         l751gZif9TMHOPhuIHgfU2GPb86uhMXcTFgZLEajMCS+L1wN9vJIUtrr/3VOvkRhhwFC
         2vpqPtolHhkeB1+Nyeqx8kI1jKlAt3X3706VNnT/CRGUmC8+yy+8w4/ZLI6DewppvxWc
         NPXfbuEuKIbJS/VwB4PnA/YNL8usBvpw4ggJgVXZcykaUTP+2FpcSaB34DHKG7Z2A5jn
         hHIhtW6JisP+jNpDSWPx9ORMjJHK3qymhEA18x+tMdYIBhwfSnQRniNA1tDYfeXp5zjf
         0SZg==
X-Forwarded-Encrypted: i=1; AJvYcCVjMPULo4abJ4Dcvuvn2+uewzdnKe8aa4vMseljRoI2oNvys2xVtzoPqOGMaUIOZ21ODX2kMAtyC2G1MlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hEV9ErqLguJN1NwsroWaquVK35qVHOTIQpq8tn6yhn9iTyvz
	WEwmQnub7EBY1QlUgO50nsLd64Yy4RHM4xnb77+7XdUiE76jDfAdUIXMxSnOvj5UeZXsQ+i3E2f
	D/1F1W2roKg==
X-Google-Smtp-Source: AGHT+IF00DB9vxEjSFZYMwiT0cUkAqXFwWmkRj0Y1btbCtCISAk52bWxBSSNcRq9+pCP65pccsXXfMuEUhHyLQ==
X-Received: from wmbfk3.prod.google.com ([2002:a05:600c:cc3:b0:43b:c336:7b29])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3512:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43cfded98b3mr57431755e9.19.1741699102457;
 Tue, 11 Mar 2025 06:18:22 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:13 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-2-dec210a658f5@google.com>
Subject: [PATCH v4 02/12] selftests/mm: Skip uffd-stress if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's pretty obvious that the test wouldn't work if you don't have the
feature enabled. But, it's still useful to SKIP instead of failing so
the reader can immediately tell that this is the reason why.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 944d559ade21f255404eb38557660e54e81d46b8..91174e9425cde2500b459db78cb27adda6647b55 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -412,8 +412,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (uffd_get_features(&features))
-		err("failed to get available features");
+	if (uffd_get_features(&features) && errno == ENOENT)
+		ksft_exit_skip("failed to get available features (%d)\n", errno);
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


