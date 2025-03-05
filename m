Return-Path: <linux-kernel+bounces-546863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2769A4FFC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1017B3AEEEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B9B248176;
	Wed,  5 Mar 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhotKfS6"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55B1FCF4F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180005; cv=none; b=B0rd5hcRm/0I5OWH/gSlO4OiPETR/6FgtxHnarilJQH9IiwjBNrXSs5CIHl76ByNbJUWT7jHzxMQi7TkncEIT8XBXdn6w2EUkDNgTUUSjVWP9J5PYuugi7Y/k7nJXYEWG3PIGR9jN+cKiBTYOAUZBWRyFI3Aw9L8I9gA+xBjZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180005; c=relaxed/simple;
	bh=56sqqOEqGriHtOFEYlo9hGHgSO0l2VpnsflbgQyFSf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuKh173+4s6WMfgCyYDCo2HzTzxnZZv4VzN0gnO7umeEemJlGolFrR+kD7Gpt0J7H3th3R8cylMRuY+/tnktnBPq+yfJ4WAwkAYqhE2WGyoqVLsnd/XuIU+0ayHO/Guhcce0NlRUi56IfiM9Qw9Xrztqf1N3XzjyN+eJlqkovWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhotKfS6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso4863681a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180000; x=1741784800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SQjgG6U13+uAQOBhn9HhQeG3VGEtTdqOEuDMKUhZ7o=;
        b=VhotKfS6sQi/QNWvKJHQwoibQAluNbMSCQVhrwAr3989u2DHFZUQsUH/cgKazRl1K3
         Ub798VQsBXeDBNQ+YSC/PS9YGbxNgOnUk+1ys+aHr0wI68T8tpxqwvFSlwskv6iROmkT
         mY443uGuosLOSF2uWqxuUotNfWn+gEZ4lHi7RJrkAlLEypo0VR0fhHOXWEOe/NgsAIOi
         Rn4puUGzRAlSV8rzHovGuRMfpPUb8aosVSoYEC4bMYzAZREs40e+H7lBK9UqWTmtc3kt
         mg8azee1DrJrcmF4Nf5lzwUIV3w6KmTJByQ17OdRpXqsbnC1Hwg51F8d+o7GBkfWlYY+
         VGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180000; x=1741784800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SQjgG6U13+uAQOBhn9HhQeG3VGEtTdqOEuDMKUhZ7o=;
        b=HQ5tl5q57la1d7sHXHRphvyPZZ1B+HODwVQdpvAu67YMXQyuS8b1vRM8a/EzSu5Hc3
         fYjBp45uPZJx5JmJx6dWMyEUGlQTDlzGjMFTbrX/Q2ndRWgD0B54cvwiDK2zmoT/zX+K
         IHmZNFAyS3ChYgcWwt12Tlz/juysWYv1AFnTwuEuB5wa9816N6GY33onGU3vKaRGu5Gz
         XtxYRgnVmN5BTlYBdD6nTJ0/hhszvEaTzWY8nUbxK5KE6w+EhpdkOkEF66DcAT9Dpt9N
         G8jAUqChPxnwbjjaxh+wbnZn2KEWWrUsYqWr8zSNXkqmxTTRrpvNlu9VpSgjD3pw2Sxm
         Hd9g==
X-Gm-Message-State: AOJu0YzghqAqzj6iyMqGChvS6Z1cMVXdf6Z2AtRcC7DBdbZ6+eAXmEGi
	EM2CCvalx874JGpI2saErJq4f+anHjkdBnrc1veClRtckhj21S4i5I/f+I8LQuyNTDUdzXjTp7m
	rCCA=
X-Gm-Gg: ASbGncv73OJMteectJqbQOjotUy+YOQWFfN4gls884C1UpELg7WUZiQa5Nxd/sE7F/J
	sCNtzbcE3EmXZUBK6TxY124ZV6RDFxXEgXeKGsAXyTpnsF21Z6+3XKVzSCUYts+HcpHdevy1HLf
	dCUwVwNDygdM8iK8RshbmiWwZV9jqqO0gLs7hRyQ3qhQopWDHZ+m/vZJYZzZ2bhLwikQ9bIy4YM
	JkDOHXW6U1XMpQbBMaF8g+BMenHodLUZdCY4xD5Cope1i6wYWgd1RJAoiaH0HqAzo8cFMglbrBs
	09jb/i4A91rUk4+cSLkrZM82gqhGTE+JKljoMSQBLRMnONXrXuY72uZOSFGC5gWQ+W7Rk3bVRtL
	ki3kHMuIHxUbmFssJ1015MQ==
X-Google-Smtp-Source: AGHT+IHuCz71jYp7eU0HTiLFptbPk6lrg0W55Lpw1DSz92hnpN7BGzAC+85g1xWfhNsyzgUyDK+bpg==
X-Received: by 2002:a05:6402:13cd:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5e59f3ee29amr7186053a12.15.1741180000374;
        Wed, 05 Mar 2025 05:06:40 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:06:39 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
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
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 00/10] TEE subsystem for restricted dma-buf allocations
Date: Wed,  5 Mar 2025 14:04:06 +0100
Message-ID: <20250305130634.1850178-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch set allocates the restricted DMA-bufs from a DMA-heap
instantiated from the TEE subsystem.

The TEE subsystem handles the DMA-buf allocations since it is the TEE
(OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QTEE) which sets up the
restrictions for the memory used for the DMA-bufs.

The DMA-heap uses a restricted memory pool provided by the backend TEE
driver, allowing it to choose how to allocate the restricted physical
memory.

The allocated DMA-bufs must be imported with a new TEE_IOC_SHM_REGISTER_FD
before they can be passed as arguments when requesting services from the
secure world.

Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
Recording) has been identified so far to serve as examples of what can be
expected. The use-cases has predefined DMA-heap names,
"restricted,secure-video", "restricted,trusted-ui", and
"restricted,secure-video-record". The backend driver registers restricted
memory pools for the use-cases it supports.

Each use-case has it's own restricted memory pool since different use-cases
requires isolation from different parts of the system. A restricted memory
pool can be based on a static carveout instantiated while probing the TEE
backend driver, or dynamically allocated from CMA and made restricted as
needed by the TEE.

This can be tested on a RockPi 4B+ with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml \
        -b prototype/sdp-v6
repo sync -j8
cd build
make toolchains -j$(nproc)
make all -j$(nproc)
# Copy ../out/rockpi4.img to an SD card and boot the RockPi from that
# Connect a monitor to the RockPi
# login and at the prompt:
gst-launch-1.0 videotestsrc ! \
        aesenc key=1f9423681beb9a79215820f6bda73d0f \
                iv=e9aa8e834d8d70b7e0d254ff670dd718 serialize-iv=true ! \
        aesdec key=1f9423681beb9a79215820f6bda73d0f ! \
        kmssink

The aesdec module has been hacked to use an OP-TEE TA to decrypt the stream
into restricted DMA-bufs which are consumed by the kmssink.

The primitive QEMU tests from previous patch set can be tested on RockPi
in the same way with:
xtest --sdp-basic

The primitive test are tested on QEMU with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b prototype/sdp-v6
repo sync -j8
cd build
make toolchains -j$(nproc)
make SPMC_AT_EL=1 all -j$(nproc)
make SPMC_AT_EL=1 run-only
# login and at the prompt:
xtest --sdp-basic

The SPMC_AT_EL=1 parameter configures the build with FF-A and an SPMC at
S-EL1 inside OP-TEE. The parameter can be changed into SPMC_AT_EL=n to test
without FF-A using the original SMC ABI instead. Please remember to do
%rm -rf ../trusted-firmware-a/build/qemu
for TF-A to be rebuilt properly using the new configuration.

https://optee.readthedocs.io/en/latest/building/prerequisites.html
list dependencies needed to build the above.

The tests are pretty basic, mostly checking that a Trusted Application in
the secure world can access and manipulate the memory. There are also some
negative tests for out of bounds buffers etc.

Thanks,
Jens

Changes since V5:
* Removing "tee: add restricted memory allocation" and
  "tee: add TEE_IOC_RSTMEM_FD_INFO"
* Adding "tee: implement restricted DMA-heap",
  "tee: new ioctl to a register tee_shm from a dmabuf file descriptor",
  "tee: add tee_shm_alloc_cma_phys_mem()",
  "optee: pass parent device to tee_device_alloc()", and
  "tee: tee_device_alloc(): copy dma_mask from parent device"
* The two TEE driver OPs "rstmem_alloc()" and "rstmem_free()" are replaced
  with a struct tee_rstmem_pool abstraction.
* Replaced the the TEE_IOC_RSTMEM_ALLOC user space API with the DMA-heap API

Changes since V4:
* Adding the patch "tee: add TEE_IOC_RSTMEM_FD_INFO" needed by the
  GStreamer demo
* Removing the dummy CPU access and mmap functions from the dma_buf_ops
* Fixing a compile error in "optee: FF-A: dynamic restricted memory allocation"
  reported by kernel test robot <lkp@intel.com>

Changes since V3:
* Make the use_case and flags field in struct tee_shm u32's instead of
  u16's
* Add more description for TEE_IOC_RSTMEM_ALLOC in the header file
* Import namespace DMA_BUF in module tee, reported by lkp@intel.com
* Added a note in the commit message for "optee: account for direction
  while converting parameters" why it's needed
* Factor out dynamic restricted memory allocation from
  "optee: support restricted memory allocation" into two new commits
  "optee: FF-A: dynamic restricted memory allocation" and
  "optee: smc abi: dynamic restricted memory allocation"
* Guard CMA usage with #ifdef CONFIG_CMA, effectively disabling dynamic
  restricted memory allocate if CMA isn't configured

Changes since the V2 RFC:
* Based on v6.12
* Replaced the flags for SVP and Trusted UID memory with a u32 field with
  unique id for each use case
* Added dynamic allocation of restricted memory pools
* Added OP-TEE ABI both with and without FF-A for dynamic restricted memory
* Added support for FF-A with FFA_LEND

Changes since the V1 RFC:
* Based on v6.11
* Complete rewrite, replacing the restricted heap with TEE_IOC_RSTMEM_ALLOC

Changes since Olivier's post [2]:
* Based on Yong Wu's post [1] where much of dma-buf handling is done in
  the generic restricted heap
* Simplifications and cleanup
* New commit message for "dma-buf: heaps: add Linaro restricted dmabuf heap
  support"
* Replaced the word "secure" with "restricted" where applicable

Etienne Carriere (1):
  tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Jens Wiklander (9):
  tee: tee_device_alloc(): copy dma_mask from parent device
  optee: pass parent device to tee_device_alloc()
  optee: account for direction while converting parameters
  optee: sync secure world ABI headers
  tee: implement restricted DMA-heap
  tee: add tee_shm_alloc_cma_phys_mem()
  optee: support restricted memory allocation
  optee: FF-A: dynamic restricted memory allocation
  optee: smc abi: dynamic restricted memory allocation

 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          |  10 +-
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       | 194 +++++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 +-
 drivers/tee/optee/optee_msg.h     |  65 ++++-
 drivers/tee/optee/optee_private.h |  55 +++-
 drivers/tee/optee/optee_smc.h     |  71 ++++-
 drivers/tee/optee/rpc.c           |  31 +-
 drivers/tee/optee/rstmem.c        | 329 +++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 190 ++++++++++--
 drivers/tee/tee_core.c            | 147 +++++++---
 drivers/tee/tee_heap.c            | 470 ++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h         |   7 +
 drivers/tee/tee_shm.c             | 199 ++++++++++++-
 include/linux/tee_core.h          |  67 +++++
 include/linux/tee_drv.h           |  10 +
 include/uapi/linux/tee.h          |  29 ++
 19 files changed, 1781 insertions(+), 123 deletions(-)
 create mode 100644 drivers/tee/optee/rstmem.c
 create mode 100644 drivers/tee/tee_heap.c


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.43.0


