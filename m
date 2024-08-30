Return-Path: <linux-kernel+bounces-309293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7D96689F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290F6280D30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A131BC9ED;
	Fri, 30 Aug 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AnHHLPis"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EB1BAEF6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040965; cv=none; b=l8pycFG6+WSeHHBtohCO6AO6RhUJQ7c8wvpl6RSP7Xm26cpIN5uUDo6hX1x49DmjXTbMVIlvYT1nHaRL/uE7m0mHPNBstdSTq8q+FVBW0rzH716V8WXVoqu+dGz643h5Wmb/gfpzIkWIHlAIcNY8rxhrE4hAwbqFFioPt564c9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040965; c=relaxed/simple;
	bh=T3aBJ9fnmYj5an6GZeg3uLH3LGkl+XZDCDWyiQZyo/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOXfjAUm0nOKgBGIWfqGvwortUlBvMod3G1GLDmOT8FTp4pi+hjWF+sa4vUZy4vivy6MiMy+yBkd6CYgJ7j2khAluoYyb8uzg1oLNBF/fgKedHejd1ehG6kDzW0UI5Pt/zroIjb2dgAl4qQxiJ7lQ/1t01gs0VXzddBW+qgf3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AnHHLPis; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-205371a8af0so529975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040962; x=1725645762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7BWq7oVdU2RJCnx+Dm004xyt6dkCplP5f/XTiAPqqc=;
        b=AnHHLPisqQVt//9IJIJ9+MsSngY4EUwaI5DB71ABvYgKXN4aNizEdQ6rImw6azABbz
         s+PLk4LK+MrOiI8o39XrQHQhEtM1SppV08pGYrRpALXcaaPZfDNa0wlLbJuqVfYRZl90
         SLSF5mO6BgLfyIZkNxChrA+TZ7Rgv/56ZCQ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040962; x=1725645762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7BWq7oVdU2RJCnx+Dm004xyt6dkCplP5f/XTiAPqqc=;
        b=UeO7nJeHAZH6S5UB55vIT1VKp552CTQi1jGJhha0/uVfHH/eQAPyCjEGtXfAe2U7WI
         xfVa+4hS6/vodK2CD3GgKVWSmxYOMVmKy6vxbJnCCnwWKst051GHSlblV7vEGeDIVPpi
         xyQqF/JCGb2maWyybw+gbd7wKVu2kE/QuEroF1ua+71AKRkGR9iy2QigadaZE4CB3uHL
         /n43094EMolYZf7LuTW9bYlKBu253yUumQjmmTaNORX84ulHqL+WPCjhQW6Uw3qddt7E
         G0ASTH/E0UmC4iP21DM0Ssb3+EbJrTbTedoi35Z95ucJDetT8M30q7CR81e9iUq26qds
         lsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp7YUnepvr/TNDiPQsbQjbZeEMKjv3LqR7o133EZA3eDjAv5+i58x+Fawy/jyjqCDms9C+Q7UyVkxm3uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUs0rOI0Jw3FzT6Muuzve/LCQTPx55hkPkNqRJe9vrTddANR4
	6yNOLXORh19GrFnXzLNTXZl4zq21lV5mBY6hZabb5SUyrSf1eyKUbFsd61EXZA==
X-Google-Smtp-Source: AGHT+IFfg3nmCpS6l8tCSIgiK8ygtmcd3GUg9HFT26UxW+AIXZxfWCUoJstGo9qdujnZ6B7n8WVNZQ==
X-Received: by 2002:a17:902:cecd:b0:1fc:5cc8:bb1b with SMTP id d9443c01a7336-2052773ab73mr19021075ad.7.1725040961241;
        Fri, 30 Aug 2024 11:02:41 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205155671bdsm29574215ad.302.2024.08.30.11.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:40 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 0/5] Increase mseal test coverage
Date: Fri, 30 Aug 2024 18:02:32 +0000
Message-ID: <20240830180237.1220027-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This series increase the test coverage of mseal_test by:

Add check for vma_size, prot, and error code for existing tests.
Add more testcases for madvise, munmap, mmap and mremap to cover
sealing in different scenarios.

The increase test coverage hopefully help to prevent future regression.
It doesn't change any existing mm api's semantics, i.e. it will pass on
linux main and 6.10 branch.

Note: in order to pass this test in mm-unstable, mm-unstable must have
Liam's fix on mmap [1]

[1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t

History:
V3:
- no-functional change, incooperate feedback from Pedro Falcato

V2:
- https://lore.kernel.org/linux-kselftest/20240829214352.963001-1-jeffxu@chromium.org/
- remove the mmap fix (Liam R. Howlett will fix it separately)
- Add cover letter (Lorenzo Stoakes)
- split the testcase for ease of review (Mark Brown)

V1:
- https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/


Jeff Xu (5):
  selftests/mseal_test: Check vma_size, prot, error code.
  selftests/mseal: add sealed madvise type
  selftests/mseal: munmap across multiple vma ranges.
  selftests/mseal: add more tests for mmap
  selftests/mseal: add more tests for mremap

 tools/testing/selftests/mm/mseal_test.c | 830 ++++++++++++++++++++++--
 1 file changed, 763 insertions(+), 67 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


