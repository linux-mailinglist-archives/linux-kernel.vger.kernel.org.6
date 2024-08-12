Return-Path: <linux-kernel+bounces-283458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F7E94F533
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AEE2812B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B2187347;
	Mon, 12 Aug 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVauj42R"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BD187328
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481291; cv=none; b=p9xLQc/KFtLP5iv/SBQjYNyQfKIkJQoePJ99c4C5uqsC+C5zjmpDA1oY9GK+V86tAZ4x2y2T2KCdvoIlMFChkAKRVnGw6kQIX3Vf9PpmqfZHAxMPbsURPd4VNMbO9qoVF7/aKJhS6LTasKxCqWP5iTqv6SZ9H8GstGNyzy7dWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481291; c=relaxed/simple;
	bh=TmxIX5hjJkq4wPh3iSXY1tz8QGNGETs9QyEuazJFNKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t5L2bfHXrpSTKgIUEBAGVfkTyfeMnxdJw+zDjWRuc1x8K7URfiXBeZ2dyWGCXw6DbKrxj6sDnTYRvbjLKn+EWIdB492ioUfcap8/SdlTWnSSReqgjlPDJclJEh+/FAnEqDEXQejk4y1Nu3ODVt2KZwCUp98yj0c4TGpDnkPSuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVauj42R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-427fc9834deso605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481288; x=1724086088; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8W8rradjiBfJ1L/FzBWBc+HwrX/CzWtseLosahIJT/4=;
        b=RVauj42R68cA+t6G5zYcuSZrLMVeiX6p2s1QioNz8JIzMshfnk39lR6dW808CDzotF
         uJLq2YwrT9z71FDCyOoBBRwDwFbZHiULBSM0+2rK5ZnEE2mCtncqVim7OvudGI1wzXx8
         zNDQ2IhWIIdbDF1M218p+PkIwOfvVp5Vz+S0mxtXB+D8s2B9JhHEx1c0GIRfFsrTeKds
         wbpysHsgYli1RMU9FUqJ8sKwzjRwAwnA9jhNjNh2BkK+rciYfP/09SC4MVmHFeX1qaFh
         bG8ju85malN0j3VzE56w5Q7uh1p2W9UiFu6rlXcNafs2ShQN0p5d6/orq26k5e29p+eI
         kWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481288; x=1724086088;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W8rradjiBfJ1L/FzBWBc+HwrX/CzWtseLosahIJT/4=;
        b=j8/2xDO8BjHxaQSMQ2fxf4+uJRhKS2ki3Br5Adi44tS16E8teivLQL25/Fi+faAOtu
         TJTuDIlRen1M2eIGYJPMeyPAkPfSGNLWrCNV7hQNfNZVnwvGvTx2tkq99LQz3mZDf7iI
         s771cBvvr4P30k0LO7AJSRkKT54PnMxNjOF/VwjHqlsjfAC0oR63Fz2CJrd7UFRiVRCV
         hPWFMy853mG9ogVOHVZosvQj/PwCiEe0aAJOEhvHielGEyuuIRpBjnHETHHJ/BIsBNBb
         oRaRsUmnoc3tCMDr+WByIaOkKivExsuDLOM+7lHM2fSszCqc7Z4HPffqn4Zi1eZapH4B
         4FBg==
X-Forwarded-Encrypted: i=1; AJvYcCWTi3f0oaZJWHuJ6Kl6RjKZMlYrRnTtBXbhx//8XFSSOIj+DM7V6mepg759qi+h5mQ1g/G/a343j7k8CF1Z/Htqmv4gmd86nSU0L8hx
X-Gm-Message-State: AOJu0Yw8CGXMHSuQcDfBWIdMiWabNchs2RskWsQSoHiVGlbfaTCLmmkr
	OKEMonpvHAcuJTq/kLKTYcokyN8csmUZgO9uv7LJj7N9vNhqFrDNNURE/KIyzigonWlj8wtEnAI
	5NZtb
X-Google-Smtp-Source: AGHT+IHIWeGWnY8VcPSgXUJ/jzNWHCgruo+91eEPaXNqAV8WlrWy31snbJsf5esDSgYw/oHR4ZoreA==
X-Received: by 2002:a05:600c:b8f:b0:426:5d89:896d with SMTP id 5b1f17b1804b1-429c827daeamr2869335e9.1.1723480960022;
        Mon, 12 Aug 2024 09:42:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c2b1sm110862315e9.42.2024.08.12.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] userfaultfd: fix races around pmd_trans_huge() check
Date: Mon, 12 Aug 2024 18:42:15 +0200
Message-Id: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGc7umYC/x2MSwqAMAwFryJZG2iKgnoVceEnsQFRaVUE8e4GN
 wMz8N4DiaNygiZ7IPKlSbfVhPIMxtCvM6NO5uCdL1xFHk+RCY+woyxq0Bu9k5qEqKShBtvtkS3
 /n233vh8+buAUYwAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1348;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TmxIX5hjJkq4wPh3iSXY1tz8QGNGETs9QyEuazJFNKU=;
 b=SYVIM0dXpOuaBFmfew0dZcfaQ+wJ/cNblzbj8USk3qwigNnGDB+zs4mcZYu8VvyVtvHWjADY3
 GUpkxlqeQHkC2YWDR6oOWImtLhppIn32/lWmXQKh3ZrzEtHBMayptaM
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The pmd_trans_huge() code in mfill_atomic() is wrong in two different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these, so that the first fix
can be backported to kernels affected by the first bug.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      userfaultfd: Fix pmd_trans_huge() recheck race
      userfaultfd: Don't BUG_ON() if khugepaged yanks our page table

 mm/userfaultfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
---
base-commit: d4560686726f7a357922f300fc81f5964be8df04
change-id: 20240812-uffd-thp-flip-fix-20f91f1151b9
-- 
Jann Horn <jannh@google.com>


