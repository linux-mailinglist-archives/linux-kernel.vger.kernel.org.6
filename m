Return-Path: <linux-kernel+bounces-510443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E5DA31CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EE11889BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AB1E7C34;
	Wed, 12 Feb 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwISrUry"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC11DB933
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331150; cv=none; b=rFzLZe/9recYEIBAIr63WllxaJU8+tdo92zm4w38WCSOwSBlaNE3e/61iRZLUVDyKA5j3l49+Gxg8GTWlr5SgqT6EvduCNysPO0jkwU7kRV6OQk7DAR2DUms6gMwGY3JYA+rmQjuV2rMv156x1Li+4vqhckT+1sbfPq66GxjK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331150; c=relaxed/simple;
	bh=GXIjdcanFwwm7LKyMwYAwJA0WALJk9p2AHH6SgAhdTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJdiBu5DJzxmIZgAL2saKOEifJzrYjDHUChx1WFGrTbpCyLU/o8Cb/p5o+yFleEmRibySlGOZTZSMpDU1O6bjNkktGa/6zvMODBn5X7LoUJkDmc3OXtBSPkJHFtKmXIoU3LegrncnSp0r/ZdaeG38A1N8A/aAIZN2cSsncmnHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JwISrUry; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f5ccd9742so9869775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739331148; x=1739935948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhDIo/pgY9uUkXE2IY3OHzZfG1I5TLyMDQUSWmrc3tE=;
        b=JwISrUrylt611oz1S2thbgPIWQNoGJF/ztKD8RydIDAmcvBgPon3YCCt7JpscTrFP3
         8l0dW8YvWWKZDUjDh+0DN4AwRycJzcW46/zwBH6VoboNQzKHFf58T8+JO2eWhcBbnDr4
         ZHDVTaIzITMVwWBoTw0ImmEjwd1TD15gZtaf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739331148; x=1739935948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhDIo/pgY9uUkXE2IY3OHzZfG1I5TLyMDQUSWmrc3tE=;
        b=a6zof+RVdkbpP306rBSXh4Cx6h+GjKBsQSmhZuARXXgYENyE/yL9yANAZ7Zx1pVJJd
         CGAFXxK0iv+3SBuvnKg4sGYjLBHbwDoL2S/oBC/LVQyBFwldkOJuKWVqLwV8tzCq2WwB
         J2vL7JN0GzuGiXSl1uSZG2Lz6WhYLSnyUrrXdVr6AMGL4xur+WiJByJq9mCMCLlcSZec
         HXqeQsuIWWp/QqAkvEweucALP4Q/sS/wJ4DKA9JJ14VE7WHXV4yxcXJiF7n/HphRiCVC
         35f+dlT3wAnt+hJD/iIW8KooqF+Jtg6iWfFCzFeLS82vIshbfw/+sturlLnyTeyHb5vS
         +rIw==
X-Gm-Message-State: AOJu0Yy7H7l4tNOgxjsqI5lOT3ZazAOG9fQKPnI3fFdYHINrFgiv90MB
	HiISQE5fGb0wAQe77zX9TECv8TaUueYvXtWZnxBGEqTzYzDQYyL9fxExV9YCUw==
X-Gm-Gg: ASbGncsqXRft31DTJyue0egSZsdUPIOxV8XYNaROkh7BLNPiWWx4/mNvHfUh9BYJjLV
	j03XDxHfzmFC52VFkibwtWhZH+p5MeP6BNVJj5z9SPSEi94wSd9umSjh6/FiOG7h3MBrY86u1Ke
	6n/jXiPQGaPt4mQVCXkKdaN7cdGECj3wD5935/yN4pE+1q6glB9OqQc5kSND2jh+lRDGOTv/PoK
	Bwj3DW8jxY6CeoynHPN+YqkO4VGC+3PtrzOfjU05K4N6/ygotTjog20AAnFlZ/4spsZBPQjfYfm
	nNkI8wVz//DKMuS8uqPJ1pXO82Qd9UsfzksULFWBUHDuwP638w==
X-Google-Smtp-Source: AGHT+IEIwna3DqffuQNJ/PJZ/+10GTsizIv6pLGCNhKwGTKomsFMzdKcOxj1NoWcVrvGsfxSiq0lgw==
X-Received: by 2002:a17:902:e5cc:b0:215:aa88:e142 with SMTP id d9443c01a7336-220bbf75778mr10132655ad.7.1739331148140;
        Tue, 11 Feb 2025 19:32:28 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3687c6ecsm104027215ad.198.2025.02.11.19.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:32:27 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 0/7] mseal system mappings
Date: Wed, 12 Feb 2025 03:32:20 +0000
Message-ID: <20250212033227.1279141-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

The commit message in the first patch contains the full description of
this series.

------------------
History:

V5
  - Remove kernel cmd line (Lorenzo Stoakes)
  - Add test info (Lorenzo Stoakes)
  - Add threat model info (Lorenzo Stoakes)
  - Fix x86 selftest: test_mremap_vdso
  - Restrict code change to ARM64/x86-64/UM arch only.
  - Add userprocess.h to include seal_system_mapping().
  - Remove sealing vsyscall.
  - Split the patch.

V4:
  https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/

V1:
  https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

Jeff Xu (7):
  mseal, system mappings: kernel config and header change
  selftests: x86: test_mremap_vdso: skip if vdso is msealed
  mseal, system mappings: enable x86-64
  mseal, system mappings: enable arm64
  mseal, system mappings: enable uml architecture
  mseal, system mappings: uprobe mapping
  mseal, system mappings: update mseal.rst

 Documentation/userspace-api/mseal.rst         |  5 +++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/vdso.c                      | 23 +++++++----
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vdso/vma.c                     | 17 ++++++---
 arch/x86/um/vdso/vma.c                        |  7 +++-
 include/linux/userprocess.h                   | 18 +++++++++
 init/Kconfig                                  | 18 +++++++++
 kernel/events/uprobes.c                       |  6 ++-
 security/Kconfig                              | 18 +++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 12 files changed, 137 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/userprocess.h

-- 
2.48.1.502.g6dc24dfdaf-goog


