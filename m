Return-Path: <linux-kernel+bounces-557097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8AA5D3B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7383B60B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8563595E;
	Wed, 12 Mar 2025 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOouwTYm"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDF182D7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738887; cv=none; b=pighPRa0E5eGIWbHDJ/1CUYkVRbPZ7GuDASW3iKEH8lh4OtO+hnXB1kVyoNtezW05F4WcJx5AQcjBQMpFBHIf4z6wVCQIDNZsRloDZHnQIDwLOrTEq1QL6sJQkJhhM2HneeVZcv4RKgA43xTa3moMixnLpcgCmmC8yURhUZx43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738887; c=relaxed/simple;
	bh=H5++SEOlYVvHKWlmzOVPPdCy7O19bFEfJFTgn0kXp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mqw5eWEq5Pp3yIVZRMTr4xSjPPcZ7OE2DLAxpTvcPUNx2Jut4XH9mxtGMeOu8lDdv15bgjl73E3S6BhGTv3KAYGsYhsKG1Y4rF+tQGPVBHSAY0GTReEhxOaVnAAjbt/dld7irmDfa+9kCCP39xopcGwHxFyLncNid37NKGvjHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YOouwTYm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5b736b3fcso809520a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738883; x=1742343683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxhTVWfKMvwlygUn42tfW0inla3um9pm5PRUxvke0sk=;
        b=YOouwTYmElHEvDj3gkv9FMjcMJdW2j5KeLo5+lYVNsjbiPKl0EM7sFYbpvWXLzoBeW
         sm4bsJ6vDDil6mRIYFFkylR9sO2w1plR7RHp62o5JnNS2R8gujZRPMScPbwqg/LYh+80
         K10BSAPW32Z8bMCF6WBRSlNZLp3DKqTruk18Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738883; x=1742343683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxhTVWfKMvwlygUn42tfW0inla3um9pm5PRUxvke0sk=;
        b=YSjQoK/n7XOYihfaHXErej09cU//7/R23ner1VJwD7rXKm0dFA1qVgLuAEIfqqZJoF
         /fPDvxaL/5KalA/CAmRQAnzcdIjQP0/QSmvFptJNAZFRfZpesi5B5jp5Yu9ov690UgiP
         jNc3e+plLlz0X3ZfcjSW5oG8XAplzkThCuo7kmuQ6W5SUjOsjP3I21wk36NYtNXsG9Do
         LSpNAkTACLPS+pmsT6K9R/gHOgNQWLhnOa37m9MKJ83KJW3Vc8C0ADMxrONI4VOlFHRI
         BR9rTVjoPd4JNa0wP8m0sHgy6VkiO7zvDGCGJ3Kc1y9ZG/OxUIoTYTbDBQ3zvqpCMXBx
         LyIQ==
X-Gm-Message-State: AOJu0Yyren9YctzTczCSW9S3/m0opfym6mNLEWOL885WRivNJqx8H3HV
	yqzELXRm7msSq+lgrWV5T1M2YF4D8N4WIvpuhSCgCT4Y94I3r4GMrK+k09mxJA==
X-Gm-Gg: ASbGncs+boLniAg5oqwvwh8yC9kuxYx7wuj5Wal2LesZ9bHeXPPK9Bz22l0l55ydmm/
	CKo3pLd7nqZnWaUn8LBUsCinvrb8bNZzDwFMxx2RmRJWYTLPkyjh8d2XuXRSn4nsh6zVlkAIAs9
	ZQ3NstsuLXzrGv/9PFb88/X5xFh9JJhSM25R+zeGtIJttVFCD+KLxhNtVnB8jPTXRhnwKynlwhO
	vPIYy1qHxuPi8mdOQNA2IOI20dOuxjHnbnuLebDYkJC4vU9pBD+MuJvpd976sbzo4KXsz+iopsu
	iWAOSxDpwtTl1y50J/D0FlPfaRXrQeZ9EP4iIDmVJL7pEmfZ7HbsLoRuiMetB4roOLwi02lIQO9
	3uIdTFU3zovI=
X-Google-Smtp-Source: AGHT+IFtgvPPWm2btr1Xtn33I57TNFhVpEuzGkQix5y9M7OehAhXbs7W3QjpSSzY3kDwK7gNa2Zc0g==
X-Received: by 2002:a05:6402:270d:b0:5e0:8b75:5470 with SMTP id 4fb4d7f45d1cf-5e75f2b404emr3051425a12.5.1741738882887;
        Tue, 11 Mar 2025 17:21:22 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:21 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 0/2] mseal: allow noop mprotect
Date: Wed, 12 Mar 2025 00:21:15 +0000
Message-ID: <20250312002117.2556240-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Initially, when mseal was introduced in 6.10, semantically, when a VMA
within the specified address range is sealed, the mprotect will be rejected,
leaving all of VMA unmodified. However, adding an extra loop to check the mseal
flag for every VMA slows things down a bit, therefore in 6.12, this issue was
solved by removing can_modify_mm and checking each VMA’s mseal flag directly
without an extra loop [1]. This is a semantic change, i.e. partial update is
allowed, VMAs can be updated until a sealed VMA is found.

The new semantic also means, we could allow mprotect on a sealed VMA if the new
attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
impacts for applications that want to seal a particular mapping. Doing this also
has no security impact.

The mseal_test is also modified by this patch to adapt to the new
semantic. Please note, mseal_test is currently undergoing refactoring,
and eventually will be replaced with a new memory sealing selftest.
In this patch, I only make a minimum change to make it pass. I considered
adding a new testcase in mseal_test to cover this new behavior, however, the
existing mseal_test is using wrong patterns and won’t pass the review.
Such a new test is better to be added in the new refactored memory sealing tests.
The refactoring is currently pending review [2].

[1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/
[2] https://lore.kernel.org/all/20241211053311.245636-1-jeffxu@google.com/

Jeff Xu (2):
  selftests/mm: mseal_test: avoid using no-op mprotect
  mseal: allow noop mprotect

 mm/mprotect.c                           | 6 +++---
 tools/testing/selftests/mm/mseal_test.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


