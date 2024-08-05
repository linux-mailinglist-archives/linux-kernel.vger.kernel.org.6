Return-Path: <linux-kernel+bounces-274857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94959947DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5087A2838DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D514885C;
	Mon,  5 Aug 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OrEmnaKr"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B13F9D5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870493; cv=none; b=AfqZilS1RbMZt42eSrPROwemwO9r5OeEthdYAzQHMFWUOyGlatrDQhLDZwODZ7pjsZCvgshTIdDcU7cjWhadA7uItLWdiVqRmfpuiYXGCyk0KQXGFCdS1acx+xqqcNkigeeHqWHVbjvwqWaKxgC2Q4SBrxMYkX5e9tsEYNow18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870493; c=relaxed/simple;
	bh=O9ctqr2OOwDyQgI+Tw9ka8os8+6XfU1CcgEDGKKGRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCTv0zq8j0UVk9w1onTbL1z0ptucDeOe9Zh+DEeaYP7wYFesoUzM8MwH2mTyxJBJa8kJB/4TxWH+THOsuD4TA9doVpQog3aCgtmkXrCw/LdYlmuGXD+uBk/DHF69zw8H87R0epnueSHksMqjgPeSfo1uhk6fZZak5TRcw11z+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OrEmnaKr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so5564087a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722870489; x=1723475289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z12bTz3uc/6bWoxaYbSLkO/A8SqLo9rW3xC9vooatVQ=;
        b=OrEmnaKrQ3sAGBya7/XtfuyQj+nJr99k5I0Fz5HrCZSAkCR+RMAqZPQxozgHKBCsCt
         vzqDJN6H4xhomWk+YmK54fkq/rzuoD/c0gtSmbARJSEXo3L/jrPsCmJdSwJemJ0RFRyh
         nAAfN989ynEjRjNaI10znsBNB4IIwcDjJQq2ehLI9ZghK7hxLaSSiSFVAMQFCGxpmvf7
         HxwhY5Ax4+2KWezUerCetecAqm4ygDaTD/8lSNG5gbTJB8IhuOlLqautD38I1TYAS4Cw
         2a05/z0vweua+dUZeRfi0zBOBRiT5nXaSixFWO8W1kJPK/1sQ3b4sKlfeiX+q/Wd2dF0
         J59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870489; x=1723475289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z12bTz3uc/6bWoxaYbSLkO/A8SqLo9rW3xC9vooatVQ=;
        b=w0tDNkVHuzAPWPyrx65L0mK9X/M4fuILABd/foCxV2JnKllrEHKtmgWgwRg4M9fXen
         QPuUHIuT7dtFxxjOfn+8XmyAP4vjz4K6sIEOtxgjX+7/BqFBti/sC4YHAKL9XxRvZitk
         zGn7OMv8frqZm9KnRligmU3zbGguAsZpl1n7O+3Qnj5fCBcmpEdgPJrJzqhrTWRO8Y7N
         OkTlMz7nsAG5V6wQ7v/0ELdQxOBr09IIZW6W8DG0k+qwaltY0dEIIk135hkoatS8V6sS
         Sa4WFQcONfgKIoxKz83PYQnzbWGT7tTL6n0SOqqyEnQoI5/0WkYzYPQ0RLQv29VKr0OE
         zf2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxB/KAGcy3EoNvINpsjND07dT28ZsAGa7EDu2m3tXtwz5okVNhPOSXi0uJZoTpj9Uv5jNfGXnyP8dx9K4eIrUVnmxlDaBW0Ne5fDSy
X-Gm-Message-State: AOJu0YxZj8Lab0oWvDas2vp5ZBMC3e3L9H+OnGdWdsRZOsdiQOZKGllo
	K0oZ5c1StqPwZmTkPhm81z9gZ2uTAS3rxNFN6GN2bLqPBMQJIPo8SJSshZMMxjc=
X-Google-Smtp-Source: AGHT+IEag2rNRk0j4QehJ+DMvtcP+G/n9mTpBKv6zvPEM0uKOUnzQ0IF6Ol2eIkgYDDb+d00iGANlw==
X-Received: by 2002:a17:906:d554:b0:a72:6849:cb0f with SMTP id a640c23a62f3a-a7dc5100463mr806932766b.62.1722870489211;
        Mon, 05 Aug 2024 08:08:09 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7173sm459121666b.204.2024.08.05.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:08:08 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	kexec@lists.infradead.org (open list:KEXEC),
	linux-kernel@vger.kernel.org (open list)
Cc: Petr Tesarik <ptesarik@suse.com>,
	stable@kernel.org
Subject: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when CONFIG_CRASH_HOTPLUG=y
Date: Mon,  5 Aug 2024 17:07:50 +0200
Message-ID: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Tesarik <ptesarik@suse.com>

Fix the condition to exclude the elfcorehdr segment from the SHA digest
calculation.

The j iterator is an index into the output sha_regions[] array, not into
the input image->segment[] array. Once it reaches image->elfcorehdr_index,
all subsequent segments are excluded. Besides, if the purgatory segment
precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
the calculation.

Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
Cc: stable@kernel.org
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3d64290d24c9..3eedb8c226ad 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 #ifdef CONFIG_CRASH_HOTPLUG
 		/* Exclude elfcorehdr segment to allow future changes via hotplug */
-		if (j == image->elfcorehdr_index)
+		if (i == image->elfcorehdr_index)
 			continue;
 #endif
 
-- 
2.45.2


