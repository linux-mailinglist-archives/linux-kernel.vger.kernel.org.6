Return-Path: <linux-kernel+bounces-308156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CC9657F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C64285F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95355153BF9;
	Fri, 30 Aug 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9BfnUds"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F41531EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001479; cv=none; b=Opn5jq7hGdMxk4BTYMEpx/JyFMkQlBir6UbWCwNOd1GS+u9IInzN2Q87+uqh6D/wDSbN3YgYAyYaABAnCLjDAPwteMXeZLKStlpGg48LuEaL0M67SMx8YfvlTWBmBvDOrhA3HPyRYObnFuX0usLAThLRjb7RtVQs0uhy3KNcW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001479; c=relaxed/simple;
	bh=l4FyY0fAOQkXCQ8r7DUhe/hxcGrqq9PbkHCsIcW8yFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifBI53Hz74RLnxAdK+BYGaQVOlyDq9UbiBbsAhojxEyfEf5sp1MM2q2yCO6koC0lmqjjAVkh+AUlaVlB4wCNDWP+RwiXC1O0pRsG1o8dmmHykrXHgJ7ksemhpxOX7jMjeOSMJUu49NgGFk28JsvRwB+oKeanXHr1IaUwvuA/+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A9BfnUds; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so4353221a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725001476; x=1725606276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAqkPKV8FIclg2RIfEME8aNTCMBfxloXKZQVTM0jEG4=;
        b=A9BfnUds/mrpq0ax3wgc0E99PV/62ThwtsEbOZGjsOfmblsZVbu3NFmL19oo5kMh7S
         AQ54tQPUR6GI/gwVj62wc9DmTOscpqFO+phznsh3YNtwNkLndVkLHO0gnKwmc2gxk6U7
         xrf+KgTgSuZn3kL/lDIdI8vTRK+joWY42BnB+2aKJx8zlTAE+4WkorgSAfqrhbIZOZcn
         TiNyXDxWuLZnoDSNOBkzakpZGdI+Xulg82kxMKpU7cZDOh/6Z4Dx60N81ejSiaF8qfML
         CXPnQgBSC49mJzQCHO72NxcKhmPhSItAmg3aZoTxAKpz2qLxQn8A9hEBtqLhjPBGAPip
         3vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725001476; x=1725606276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAqkPKV8FIclg2RIfEME8aNTCMBfxloXKZQVTM0jEG4=;
        b=TOWR3uqc/Yaismk2vpynOVhx810gJs8XfwPs+t7hAQH+2Fxt+kcaavoEIdP6Xbgvom
         qdxJy/oLn2ZiXIVsZbcqFjtJkClcIecVu8pvTUyjAZ9xLXHx0gBpNABrDmDjccU1wne7
         iKUftmIcjCi3zwzjZse827slaARzboAzvUNZu3K+NzxtEn6ysZkiRLs/YjM9Vu8onvgZ
         dZJC1ASdqHXcPk+4+8Au2s4SDNmyzh75j4mfbEQcDHckxlCj2E10n+RfgkBsM+4Xtbom
         uq/murxd0BKqJOiDociEBlQN5WkCMeja3YnI5KmFiXtDXYzDWB3FXrkUWBcUGpHveKSO
         J2sg==
X-Gm-Message-State: AOJu0YxhBq3EPS7WUqiVoAvuTsssDVztO+t+k7ZkHIYVvjpHLc9fe8ZL
	LAfFuYIGAlHZGBA9BRBTsnzQIDSkzdOv2vGMR+ki0j9XVJdhBhCwJ/9+DBpRTzZTz+QCGKwxUUS
	/NqEzZg==
X-Google-Smtp-Source: AGHT+IFDgPRujvPs0pY58RBt0z0M4T/+m/fwfgJO35cZdR0pWvXLPvq+fQ5KKo/0SLFh8TiIvn9dYw==
X-Received: by 2002:a17:907:6d25:b0:a86:94cd:97f0 with SMTP id a640c23a62f3a-a89a26bfcb7mr138897066b.19.1725001475410;
        Fri, 30 Aug 2024 00:04:35 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892232c7sm178026866b.222.2024.08.30.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:04:34 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH 0/4] Linaro restricted heap
Date: Fri, 30 Aug 2024 09:03:47 +0200
Message-Id: <20240830070351.2855919-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch set is based on top of Yong Wu's restricted heap patch set [1].
It's also a continuation on Olivier's Add dma-buf secure-heap patch set [2].

The Linaro restricted heap uses genalloc in the kernel to manage the heap
carvout. This is a difference from the Mediatek restricted heap which
relies on the secure world to manage the carveout.

I've tried to adress the comments on [2], but [1] introduces changes so I'm
afraid I've had to skip some comments.

This can be tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v1
repo sync -j8
cd build
make toolchains -j4
make all -j$(nproc)
make run-only
# login and at the prompt:
xtest --sdp-basic

https://optee.readthedocs.io/en/latest/building/prerequisites.html
list dependencies needed to build the above.

The tests are pretty basic, mostly checking that a Trusted Application in
the secure world can access and manipulate the memory.

Cheers,
Jens

[1] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu@mediatek.com/
[2] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse@nxp.com/

Changes since Olivier's post [2]:
* Based on Yong Wu's post [1] where much of dma-buf handling is done in
  the generic restricted heap
* Simplifications and cleanup
* New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
  support"
* Replaced the word "secure" with "restricted" where applicable

Etienne Carriere (1):
  tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Jens Wiklander (2):
  dma-buf: heaps: restricted_heap: add no_map attribute
  dma-buf: heaps: add Linaro restricted dmabuf heap support

Olivier Masse (1):
  dt-bindings: reserved-memory: add linaro,restricted-heap

 .../linaro,restricted-heap.yaml               |  56 ++++++
 drivers/dma-buf/heaps/Kconfig                 |  10 ++
 drivers/dma-buf/heaps/Makefile                |   1 +
 drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
 drivers/dma-buf/heaps/restricted_heap.h       |   2 +
 .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++++
 drivers/tee/tee_core.c                        |  38 ++++
 drivers/tee/tee_shm.c                         | 104 ++++++++++-
 include/linux/tee_drv.h                       |  11 ++
 include/uapi/linux/tee.h                      |  29 +++
 10 files changed, 426 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/linaro,restricted-heap.yaml
 create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c

-- 
2.34.1


