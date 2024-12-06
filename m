Return-Path: <linux-kernel+bounces-435176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63D9E7387
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E4316CC97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08601207DED;
	Fri,  6 Dec 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyYk+htD"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD550207E1E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498444; cv=none; b=c6vUNHkbRfz8k4uhaNyDqmuGjw83SFns114quWT9qexFC3PEFvdL+R3ksZWf6+2WP2/ajCbP9ex95ecQZcg7cnEadHO0X2kDO24Sikhvjxgh/nT/Bt6O4EBlhhyPLY1K1D42xpO7kM2182lm1gORO54UwuZBNCEAy4P9ARQO6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498444; c=relaxed/simple;
	bh=7BtEdFWcYLngsq2PQODOD5BiLZOIKMRwRSUO9nBBYBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sIAWPGAIlcLlQwn37jaieRXFedqu7Hq4L6kTD14WJyvuwLEWJLvwQj9RQPlgLrk5maodZ6lJuuj7ULVrND5Ei2lSnYRoLJgoX3DxSCfXL/YSjAalGk6MHlvc6Vgm73GBYOKmAPZAtd0NAzcmpFR39LzO/Cosv+el/Uh2VTQxYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyYk+htD; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b67201e64eso292011485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498440; x=1734103240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zF6cyo4V+yV1OddWsDU7llWFhEXM57i4QvxWba9u5g=;
        b=TyYk+htD7iHan6IKtOI0DpGsr69VAVluSH3QUkGOnkDnZ9HMK9HnP55oIeAKy9ykdX
         AwwxnYuAzeDujc3cUJgKWw1qYno1ydwdv86DJU/v0cZidf3u96mzqPfLaMHVcBhjddhD
         BwAz2GljP2wRo9hnoVIq4KYtT2+6iGkgVgCYm1L+lB0hZ2/ILrVebci644OXxFp4SgI4
         tlKTOsan7FBTo43No2k05Rr/iDelir54WriTOsRaaD90+dyqPZ3ZLKaM0QExkOo5g52y
         xYlEqN8lnJQi0HR9CNjVS8QD/hc+qHcpiRhq7Dr8xMteIAGNKdFhJdHkdrRhjynf+CIu
         Lbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498440; x=1734103240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zF6cyo4V+yV1OddWsDU7llWFhEXM57i4QvxWba9u5g=;
        b=jqNQoYyIQiTC5CpcU+VklpTzX9wi0e8qPPItR07fjVXOYY2c8e+7wKuPHHTzyl70hh
         UWBLJUik2xenhyHPzjT4eoln+HEliPKG0m494Hc/gZ1F/4S0teW/1mOCk8ANyKpJUvYJ
         oLGhbg4jriClJoBZqi8mfsMoQNdkx9sFpLezNHwBCIUbQwH/laDZoNTGO79xflVFbdRt
         b5Kr7yd7+hHhYFFY4wx1+oqUfAMoNpYeuBqfWuttLs3cR7TQkhmVVZlLBNQSIEO74Hh4
         uJCHl7ds7tzKmOr7285vbpuSIum0wHAWQ2pLaQy9Qpu6EcRquT2NoTKM+ahGJZ/AVGr5
         OYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTQtNG+ahxRbQvbLpLVXV6Ld/W9srtltJU9Ww8060Y+3X5mUb+tWZxZJAXB4iotyM1NEa9KSQN/+vVU/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuiSOYDdIc62q17NKY4ovIjzOVcB/Sfy64Z2vLv81IEfy+8918
	D7e/NUT6QPFKnTUKF/R2JuivwIZXIvlGbXDIc9Y7IDGkS623SVXcIYuANlBBoSh2xfAEXKdWAHk
	tgcffOg==
X-Google-Smtp-Source: AGHT+IGb3dyB+1mIM9uaJ8shaiN2smOAw7d48MDhvLaY9VwvHL+JlNyqB1itmzCSQbeXEMb+r4xoquxqxwdB
X-Received: from qtcw37.prod.google.com ([2002:a05:622a:1925:b0:462:ac63:5263])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:57cb:0:b0:467:1f3c:4d22
 with SMTP id d75a77b69052e-46734e26188mr80292871cf.52.1733498440618; Fri, 06
 Dec 2024 07:20:40 -0800 (PST)
Date: Fri,  6 Dec 2024 10:20:32 -0500
In-Reply-To: <20241206152032.1222067-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206152032.1222067-3-bgeffon@google.com>
Subject: [PATCH 2/2] selftests: mm: Add a new MREMAP_DONTUNMAP self test
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new selftest which validates that a new_addr as a hint behaves
in the same way as mmap.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/testing/selftests/mm/mremap_dontunmap.c | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index 1d75084b9ca5..ccce97c68019 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -224,6 +224,44 @@ static void mremap_dontunmap_simple_fixed()
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+// This test validates MREMAP_DONTUNMAP using a newaddr hint without
+// MREMAP_FIXED.
+static void mremap_dontunmap_simple_newaddr_hint()
+{
+	unsigned long num_pages = 5;
+
+	// This dest hint is intentionally not aligned.
+	void *new_addr_hint = (void*)0x999900010;
+
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	void *remapped_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
+		   new_addr_hint);
+	BUG_ON(remapped_mapping == MAP_FAILED, "mremap");
+
+	// And the source mapping will have had its ptes dropped.
+	BUG_ON(check_region_contains_byte
+	       (source_mapping, num_pages * page_size, 0) != 0,
+	       "source should have no ptes");
+
+	// And the remapped area will be filled with 'a's.
+	BUG_ON(check_region_contains_byte
+	       (remapped_mapping, num_pages * page_size, 'a') != 0,
+	       "dest should have remapped content");
+
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+	BUG_ON(munmap(remapped_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+	ksft_test_result_pass("%s\n", __func__);
+}
+
 // This test validates that we can MREMAP_DONTUNMAP for a portion of an
 // existing mapping.
 static void mremap_dontunmap_partial_mapping()
@@ -348,7 +386,7 @@ int main(void)
 		ksft_finished();
 	}
 
-	ksft_set_plan(5);
+	ksft_set_plan(6);
 
 	// Keep a page sized buffer around for when we need it.
 	page_buffer =
@@ -359,6 +397,7 @@ int main(void)
 	mremap_dontunmap_simple();
 	mremap_dontunmap_simple_shmem();
 	mremap_dontunmap_simple_fixed();
+	mremap_dontunmap_simple_newaddr_hint();
 	mremap_dontunmap_partial_mapping();
 	mremap_dontunmap_partial_mapping_overwrite();
 
-- 
2.47.0.338.g60cca15819-goog


