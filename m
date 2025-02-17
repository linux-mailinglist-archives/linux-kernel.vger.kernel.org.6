Return-Path: <linux-kernel+bounces-518459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BBA38F85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B43A3C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69A1AA7BF;
	Mon, 17 Feb 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZfxDxxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260C14D444;
	Mon, 17 Feb 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834281; cv=none; b=I/9S0ay+jnaj48SmNIvPw6XS40CoKhQboBsCyI8DDGw0reKN54ZPMlabgaEzwNh9Tn0r7+iiBtS+UhLbGbwi/qR1SK0/5xRtfL0+lpEbw46VSVJ4XH+/OntAABuVus3MXhN/hdGdvXAUyIrd6ImV0KltCRNKzyb2RgBr8TNLV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834281; c=relaxed/simple;
	bh=PFvuxIr1vWu9pP8bDpdeRzEuWX7y0upOpdKJIbnwMFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNceHCaPhEojnc7YqqudzcEdoMEBYdaiDZmuby8MiloMzsRO67eMqJrZgQ3/WNBJ5WyqoIThS+IleeNJPxb8rYcUy+0azLzceK3vwVrrlL8K39odLIb0KbczgvU+u6m/0Vf9I63R2k6xu3M8gI2S/r8GO7UtAq3O57Gh8zx9pVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZfxDxxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C01C4CED1;
	Mon, 17 Feb 2025 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834280;
	bh=PFvuxIr1vWu9pP8bDpdeRzEuWX7y0upOpdKJIbnwMFM=;
	h=From:To:Cc:Subject:Date:From;
	b=MZfxDxxqyTb5gZfUDui9DIGSnlnjwZWUUp9oWmiFXirMYBVqxeV4SFyoHtvdZuaoT
	 RtABLjsQ6GNoZHx8JMV4D9vShoj5dgNnI6dZp6AyTzlxwdjMp1QD/mNf1mNIG5okNj
	 KX1mmVmJlH3el/cFlMXNbuTP5MxOM0G9N6F46LDe2mYaFMKVQpftEb2wWMMh9OBFcZ
	 V1qtEZP0/hvtAvwYVhWBgrrNnevmFgGM/vHO8WrVLFSZvy/PKJGSD8jPrB3W0z62/i
	 QT71KAia+yJ5KJYDFEjOM3M2rIrqDhFIpFs9piHyjv5fOH0qjcbsKZqJOHTAPPsflt
	 StVRlmEAVUNsg==
From: Mario Limonciello <superm1@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org (open list:AMD NODE DRIVER),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS)
Subject: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
Date: Mon, 17 Feb 2025 17:17:40 -0600
Message-ID: <20250217231747.1656228-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The various AMD audio drivers have self contained implementations
for SMN router communication that require hardcoding the bridge ID.

These implementations also don't prevent race conditions with other
drivers performing SMN communication.

A new centralized driver AMD_NODE is introduced and all drivers in
the kernel should use this instead. Adjust all AMD audio drivers to
use it.
Mario Limonciello (7):
  x86/amd_node: Add a helper for use with `read_poll_timeout`
  ASoC: amd: acp: rembrandt: Use AMD_NODE
  ASoC: amd: acp: acp70: Use AMD_NODE
  ASoC: amd: acp: acp63: Use AMD_NODE
  ASoC: SOF: amd: Use AMD_NODE
  ASoC: amd: acp: Drop local symbols for smn read/write
  ASoC: SOF: amd: Drop host bridge ID from struct

 arch/x86/include/asm/amd_node.h       | 11 +++++
 sound/soc/amd/acp/Kconfig             |  3 ++
 sound/soc/amd/acp/acp-legacy-common.c | 18 --------
 sound/soc/amd/acp/acp-rembrandt.c     | 28 ++++++------
 sound/soc/amd/acp/acp63.c             | 63 +++++++++++++++++----------
 sound/soc/amd/acp/acp70.c             | 28 ++----------
 sound/soc/amd/acp/amd.h               |  3 --
 sound/soc/sof/amd/Kconfig             |  1 +
 sound/soc/sof/amd/acp.c               | 56 +++++++-----------------
 sound/soc/sof/amd/acp.h               |  2 -
 sound/soc/sof/amd/pci-acp63.c         |  1 -
 sound/soc/sof/amd/pci-acp70.c         |  1 -
 sound/soc/sof/amd/pci-rmb.c           |  1 -
 sound/soc/sof/amd/pci-rn.c            |  1 -
 sound/soc/sof/amd/pci-vangogh.c       |  1 -
 15 files changed, 90 insertions(+), 128 deletions(-)

-- 
2.43.0


