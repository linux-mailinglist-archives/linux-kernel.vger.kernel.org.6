Return-Path: <linux-kernel+bounces-519633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8753A3A01E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165D917448B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58B26A1CE;
	Tue, 18 Feb 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/BdXIxU"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F326A0CF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889340; cv=none; b=cudQ2wWWE2LAYFGyIRLmTCNRrynL2ehyfdV0zSB16/2DMyhGw4fH47lec5HN1sYVPHzB+/+8wcJ0P49PGVQYlAiFCq296PaVtbj4Vz2fh8lZcV4IozT19O0kj62C/mI3pRx6/Bbg8kJ/1VR+V4uGE9VYh2jXgnXhA18qc/Od/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889340; c=relaxed/simple;
	bh=DLOTCTjf45nQqFcmb7h5CGPAeoemenMqu1PjlYG9EIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PQftYIo7CZ5Rdk9dP16KWAoqaFceOEK0X+KKZ92hxdLGkISqO80AwcXiKIDz1Bf8vIZDoJNEb5Wp+5vsS8/YMyCzAsUaQ3iU+x9AeWooz/oQwBtddz7+4IYMnL5S8ZUtSseqIf1BV2ekjj2efUx1OV1epuaDPDR+yTyJt8WUOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/BdXIxU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so23306761fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739889336; x=1740494136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWFT9m6GN4GxrZYX8Rpent2wFQfA0PjR3otNOfevNYU=;
        b=n/BdXIxUvlmP98v3IhgoT0V5JEEl7vJ+OOWYqFjI6FFsN2ToRQX/sCTCh7vzZeMSbt
         uH0mt2muhx3UNYDuLs8WNz/16uhYb8UIJ4jxkoQqkYJQ331nSPZ7Rx2xuc4uTCYCPiB+
         Qnp/o2gjthukhr3iPxVRRox8WkxWSU0qP8+HZi82gy9VBJg7YdGHswE0VRxkGR5m0MlP
         +JbXHqf2MEtTu5nekIzYzIA6O8ZuBx/+iEupr4UfChksc8kt1xFU8KRn88B8hYJdZ0RR
         dHY5neFTWRkLwP7A+YeqwcaxfXvE9jeQA2Bw8XDkT7QvhLKmvXg4NyYhZwyhohYOp1ff
         BKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889336; x=1740494136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWFT9m6GN4GxrZYX8Rpent2wFQfA0PjR3otNOfevNYU=;
        b=P+DFpAKuX32zy7JRndb3CsLl9kKUHMi+9Xw6/z2zHqX4U6TKa1YuB2fO/kr2DF2aFz
         2pddZkK04xE9xP8vYMN9kX8wpeZ29VVZNIv1qklzxsv6FuMvfAb4kMfLoguRWzeYnDgn
         H2Kb21XPZaoBMnonDvdCklCBrw+CMEvUn7LDv51u/Zznyx5CWunnu7WcWPmGvmKL6F4E
         hJMI2B75vKHWTgae8KIE3zMCg9e85bcq7dqJRljzjYlkC8Q+7QHvLdjQmSxjb1VUDMrQ
         nfTGEGaUQpObufzwDhw6UyCi+N0R1HNgzBqS6FMGVYSsgvS1i3QJDQOHdDzYevlX6IOD
         sc5Q==
X-Gm-Message-State: AOJu0Yz4vTe2O1vyLu/t6CHwd3R0L4UyVytl+mSicxaJU/n2YKRIpNsu
	O34tZbnOHV6TZphtXhoKSv6rgxbfU9UdTNHY2Kp5xduXm30Q0OVUAqOcx3eoj7m2O5VDH3RLcyg
	B
X-Gm-Gg: ASbGncsLf8b5f9pMuZam85pmKmDeFdE9EQUjJ7BPKH8YBlQw0ou9Sgk9re4iCNicIwA
	tOs5AmnH7OtyIHzEIXyo1XRT4Tv0v/QSk1YFJQsG3iHyYcxaGNDjm9a4k+XdjwDvGMw3xslE5VC
	uUx+bHDyInepeTX5BFeC85nyzJpgKOExIZWd/nIEqlE60Xx95glHnvB9e0rBFLZtXf/dJknJ5Or
	MO3jnw9nAQzno64KtND0YzveticlYGKAoBXmsLE0ORJ/gNUWmvnNmZaeK3pxAbQLpjo95sH1jNl
	EP12hu80tNJcO51Erb7wmiDYIzS7LcA58zMZArXS99VPdEpZT2KAa0ry9OdUjZyBC0Od
X-Google-Smtp-Source: AGHT+IGRQRyenVlztaodJXNdRWoqSHnEiV6CAyLZN/0VHpW+LYtybqKnx2XoHGvKGUJTmzr2eF8qRg==
X-Received: by 2002:a2e:885a:0:b0:309:251a:df12 with SMTP id 38308e7fff4ca-30927aa59ecmr37278251fa.19.1739889336018;
        Tue, 18 Feb 2025 06:35:36 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309311777a8sm12360831fa.25.2025.02.18.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:35:34 -0800 (PST)
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
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v5 0/7] TEE subsystem for restricted dma-buf allocations
Date: Tue, 18 Feb 2025 15:34:49 +0100
Message-ID: <20250218143527.1236668-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

[Now with a Gstreamer demo, see below.]

This patch set allocates the restricted DMA-bufs via the TEE subsystem.

The TEE subsystem handles the DMA-buf allocations since it is the TEE
(OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
restrictions for the memory used for the DMA-bufs.

I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to choose
how to allocate the restricted physical memory.

TEE_IOC_RSTMEM_ALLOC takes in addition to a size and flags parameters also
a use-case parameter. This is used by the backend TEE driver to decide on
allocation policy and which devices should be able to access the memory.

Three use-cases (Secure Video Playback, Trusted UI, and Secure Video
Recording) has been identified so far to serve as examples of what can be
expected. More use-cases can be added in userspace ABI, but it's up to the
backend TEE drivers to provide the implementation.

Each use-case has it's own restricted memory pool since different use-cases
requires isolation from different parts of the system. A restricted memory
pool can be based on a static carveout instantiated while probing the TEE
backend driver, or dynamically allocated from CMA and made restricted as
needed by the TEE.

This can be tested on a RockPi 4B+ with the following steps:
repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml \
        -b prototype/sdp-v5
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
        -b prototype/sdp-v5
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

Jens Wiklander (7):
  tee: add restricted memory allocation
  tee: add TEE_IOC_RSTMEM_FD_INFO
  optee: account for direction while converting parameters
  optee: sync secure world ABI headers
  optee: support restricted memory allocation
  optee: FF-A: dynamic restricted memory allocation
  optee: smc abi: dynamic restricted memory allocation

 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          |  10 +-
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       | 179 +++++++++++++-
 drivers/tee/optee/optee_ffa.h     |  27 ++-
 drivers/tee/optee/optee_msg.h     |  65 ++++-
 drivers/tee/optee/optee_private.h |  75 ++++--
 drivers/tee/optee/optee_smc.h     |  71 +++++-
 drivers/tee/optee/rpc.c           |  31 ++-
 drivers/tee/optee/rstmem.c        | 389 ++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 215 +++++++++++++++--
 drivers/tee/tee_core.c            |  69 +++++-
 drivers/tee/tee_private.h         |   4 +
 drivers/tee/tee_rstmem.c          | 188 +++++++++++++++
 drivers/tee/tee_shm.c             |   2 +
 drivers/tee/tee_shm_pool.c        |  69 +++++-
 include/linux/tee_core.h          |  15 ++
 include/linux/tee_drv.h           |   2 +
 include/uapi/linux/tee.h          |  71 +++++-
 20 files changed, 1409 insertions(+), 76 deletions(-)
 create mode 100644 drivers/tee/optee/rstmem.c
 create mode 100644 drivers/tee/tee_rstmem.c


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.43.0


