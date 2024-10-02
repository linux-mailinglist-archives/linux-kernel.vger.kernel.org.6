Return-Path: <linux-kernel+bounces-346899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E398CAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34909B20954
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6912107;
	Wed,  2 Oct 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRDVQsYa"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD61103
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832045; cv=none; b=bztsSqF3sRcm0SA8NU1Qxyg9vOX3d5fDmE95dmgGUwSkFifrhdV7gNEmV/OAB4xGkvUpcQBmwB9XJ2qB6wgQbPP+mE+FcpqZngkcno2TYMMgzHyS95lgmyC886IIcCmkVwudZmzsCXbFxB5RTopOcJRw7BsGzgzx6n0T5txDLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832045; c=relaxed/simple;
	bh=ALNJef6cPVNYxmZT2/fG7sGeTZdVrufp1lw+R1J5Aag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbHfNPZBVLPLq/dSX2IVAe4Asaa+mTm29zhfBtKt0p7B5xpIce2wnIKV15/EhbeVa190jfDiau/SMQrBIGul+3N9Wvh/jaEEEewg7n2TLyIyQWs/BVAShm1OPEmteXZQS/oRJARFyDt1fU5DHkcUKoTTCEJNS+P4xUzUV0r7n2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRDVQsYa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25cb91f3b3so6101368276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727832043; x=1728436843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DDiG/7V3reVxLK4DbYXQt0ki9kjoNNk0OLn5oS4hQM=;
        b=BRDVQsYaOCyfg2pRt1iwxMRtQgi1rwKr71LfegPyUSPajNBRr6ViFf8mxsJTRihxE5
         ITDG+DMVs8TdKPd8mSaBSxDyIgZGns7YFk8+tx6qlBvx4qrXE8Mb0tkKYzt+n7Oys8/a
         48u5dK9kmulwEeG4MOSW3XogW5OowbhXvpkmhSDKaGo03Kar/VUo0M3QlTjQm9aRTX8n
         yMdiYb6tupQ3xaWJNE1u17WASr6tu90IwQnZ1Hsid88Zk4xCqX3Ou4QQ1AQppK2Qy/cR
         yguiZ0sq0AsxYI+rjkL9uYhpgDB5OJOg3vABRxN5fhSX/vUZUo2iNbqn/X1hmmjqr0Eu
         BX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832043; x=1728436843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DDiG/7V3reVxLK4DbYXQt0ki9kjoNNk0OLn5oS4hQM=;
        b=vMaPA6jvuSRZWU9iMYZm3hNpOhzk08j/t1VTMtTVjQEWM4krIaGLTDhWaBn0DIHe8K
         Tueg2Nq+KNWQYIheUqnErgO45oX488lcWr+7SlyYzH3BZ5WDDJ6SNcm0fOdba4DyQKmt
         ZavTDYQlK3oyvCJG39BOFg6JdmWODt2E8sPu0XdCRcm0Rz4RzbDIBA68sIkaigfZZIuY
         r9MujBHjvPwK9lYi3f0FFIdhpdVcMR+5xkzyG6tn2LRPb/Pz29D3itWKH1R9wtiEEYuc
         s4+ECfKfJsxlvm/lhyJIH9Xjwi6fzkVQ+v+vqywIxnbJsLYXikZ0YF8VbhHd0ZjmqCtu
         xu2A==
X-Forwarded-Encrypted: i=1; AJvYcCWQEF7zeYvyjh0pAvz4EvtkArnB332zkjUJzQ1zOuOPWrFvMbIbCkQX12dVaqQpsT32/umcM/c73vbNMbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsv4r3h6TYp3vMr0Osav0mfFpTQHfi29CGiNPQS3IyyMzxukw
	6EHhSq6O6TlrR4jYfg6EzXpier/aUbimIfZOT7SwciYLXf8Vyhp/
X-Google-Smtp-Source: AGHT+IE+VkbWY85UvGhcoEeS/0Hg8lVKhDIQRFI1/JH3RTdc3UlUKEQz5QC0zrEGImxYEq96f20gtA==
X-Received: by 2002:a25:c5cd:0:b0:e28:67b3:d731 with SMTP id 3f1490d57ef6-e2867b3d8a4mr48695276.9.1727832043182;
        Tue, 01 Oct 2024 18:20:43 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3ef8ee8sm3566914276.1.2024.10.01.18.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:20:42 -0700 (PDT)
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
	v-songbaohua@oppo.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] remove SWAP_MAP_SHMEM
Date: Tue,  1 Oct 2024 18:20:41 -0700
Message-ID: <20241002012042.2753174-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
	* Fix a WARN in the shmem THP swap path. Thanks Baolin, Yosry, and Barry
	for the report and the discussion on how to solve it.
	* Squash the two patches into one.
RFC v1: https://lore.kernel.org/all/20240923231142.4155415-1-nphamcs@gmail.com/

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

Another motivation  is the new swap abstraction I am currently working on,
that would allow for swap/zswap decoupling, swapoff optimization, etc. The
fewer states and swap API functions there are, the simpler the conversion
will be.

Nhat Pham (1):
  swap: shmem: remove SWAP_MAP_SHMEM

 include/linux/swap.h | 16 ++++++++--------
 mm/shmem.c           |  2 +-
 mm/swapfile.c        | 41 +++++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 29 deletions(-)


base-commit: 391cad4424af8bb563e1504c5adaef0155b4abb6
-- 
2.43.5

