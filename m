Return-Path: <linux-kernel+bounces-336396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C79983A25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52311F22DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5B12BF32;
	Mon, 23 Sep 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4xpDoRC"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B637126C0D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133105; cv=none; b=pUF8YvSxyD/Hir7EbR37UrpXpKJW4l/bFnirRlzj7Vvw2QC3pBUuoiEyGQeSuaRbJuqSeohPhumqqQhgKbI1iGilv2yKYqdeKrBwoaah/6Gts0Jd7M0Tzbspx2W+Y4lp9th7kiPQR74XqS/b4ufYkvKDu0nZES/A0oVEVap7vhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133105; c=relaxed/simple;
	bh=Lj05WYOTUjsViVcGytUMKefpYQXxLN8fCthA2NS/oJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8tc3ErgOzlneq4FaPy7ZnstKI+GtrEpnKFlgwlFgnpSCgwL8UBxulilmuFXuf2Fq0H0fd8VYSx7Go55F/ZeuMeEJAkFAleGyFlmeEdEx/OseQpwyhPKtBoJeBMDjMAMowqzgb60LzOMRRJSqAPLTfDCiyr9H+gxp61jasiFUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4xpDoRC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e20a8141c7so2713507b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133103; x=1727737903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHKkPqQYYlWv/vbNTvZkuEr8x6McI9yagRLdFXJXWgk=;
        b=G4xpDoRC1edvDKVTVK3TY19OSKhwuViZweXOE1NJdUzKIV688/F6BzJsVKr70HYwx6
         XkhEWTwu5FnGucpuzsorizPUhIqq3wWo62Oyj784IH/VStlCYb9Vjqq4cB9UgZkYHz6b
         yQlCCRPuHY7u6d5UDYmYrF8RYb7HIkRUW5d+A7q6eGB10HWkq0pW14GTotPEa+rjqhAM
         AoaWPdcjAw0VX1dHtD3w9fDHIegAXKXliO8FGw0XN26+CEotrMn0duc0nLTs1hYlzcyO
         JStKmAlWsvH4v7oXfEIZ4m0h+XB74QX7q/F+jRufeMZBXPhv4Of7jAcQROElQgpwOVlA
         8Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133103; x=1727737903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHKkPqQYYlWv/vbNTvZkuEr8x6McI9yagRLdFXJXWgk=;
        b=iSw4BBXBWRC0R4AqoSgtfJuD338gf0FTsmKNnzJnUCu6dNE6HLh+i2Iz7IFOOJl5ha
         jqkYQ7Oab4JC4YlTkhCgXhhBiDxXt7Ai92yD5RReSSfjA624hpOEQDCJCnAMr6lGJHv9
         tVB3J+erCtjU5rpyg6UlKccqjxxso/dHE31FqMH5OqOo/U2iQJ9ySjnd2KpSWatMbmRy
         HtiAoUxe+BElXOsUHYSQRVtN1iY4OoHd+yMabVDwOdzDm55nBWvkN6EqfXokf7NUIutV
         5gkDt3/1XOlihgX8sQ8jv22pt3RJxX3Qd09eAViSOhnbc11zzu0WLuxVA3ChbGQ4pl8+
         L39A==
X-Forwarded-Encrypted: i=1; AJvYcCUPYr0GVX9MDEurr9EBOCqx5ap38mbVotKp7kIr2o/6IRMPQG8p++3VvomSvsuC4LQ+ZiDiYnL4vzZVeS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbPe6lnxjPkemBv8TgiQ+j4l/6vcOu6Ob4GnWmcecJxCpDyeA
	56w6du2/oTDskWVjsezkG/i9V64T4ZIYFfIUFhdP4ZoAK9ImIAIM
X-Google-Smtp-Source: AGHT+IFd3FdhPUVmHvF03BjWT2MKPtk7UXG3s7ZdOz3aEwuodHwAbZ/TN/xYLkEOz68pRIzcUQq3AQ==
X-Received: by 2002:a05:690c:fc1:b0:6e2:f32:bd2c with SMTP id 00721157ae682-6e20f32c4camr1941657b3.29.1727133103225;
        Mon, 23 Sep 2024 16:11:43 -0700 (PDT)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d06a9d8sm577977b3.59.2024.09.23.16.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:11:43 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	hughd@google.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
Date: Mon, 23 Sep 2024 16:11:40 -0700
Message-ID: <20240923231142.4155415-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWAP_MAP_SHMEM state was originally introduced in the commit
aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a
swap entry belongs to shmem during swapoff.

However, swapoff has since been rewritten drastically in the commit
b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
having swap count == SWAP_MAP_SHMEM value is basically the same as having
swap count == 1, and swap_shmem_alloc() behaves analogously to
swap_duplicate()
    
This RFC proposes the removal of this state and the associated helper to
simplify the state machine (both mentally and code-wise). We will also
have an extra state/special value that can be repurposed (for swap entries
that never gets re-duplicated).

Another motivation (albeit a bit premature at the moment) is the new swap
abstraction I am currently working on, that would allow for swap/zswap
decoupling, swapoff optimization, etc. The fewer states and swap API
functions there are, the simpler the conversion will be.

I am sending this series first as an RFC, just in case I missed something
or misunderstood this state, or if someone has a swap optimization in mind
for shmem that would require this special state.

Swap experts, let me know if I'm mistaken :) Otherwise if there is no
objection I will resend this patch series again for merging.

Nhat Pham (2):
  swapfile: add a batched variant for swap_duplicate()
  swap: shmem: remove SWAP_MAP_SHMEM

 include/linux/swap.h | 16 ++++++++--------
 mm/shmem.c           |  2 +-
 mm/swapfile.c        | 28 +++++++++-------------------
 3 files changed, 18 insertions(+), 28 deletions(-)


base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049
-- 
2.43.5

