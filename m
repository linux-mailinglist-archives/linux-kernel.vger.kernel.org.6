Return-Path: <linux-kernel+bounces-570648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30437A6B2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D08A33E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED791E260C;
	Fri, 21 Mar 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF3V/3cK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157346A009;
	Fri, 21 Mar 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524245; cv=none; b=rFhV+JkjHTxxCI5WCiOtVaQ5/dK34eKauPk+malKl7NGtZbapTASh9qLMuhOi4OR5Qxtxn/ZTqlFTB6upIN1PpJ7pK2DueyTM+2xpPRk369JfhEoY6oX57YG/eSbiCaD/+Ord5MNmxWZYgCI4V7XCg4zpurCS0PoxYJMlK8C4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524245; c=relaxed/simple;
	bh=Bdl3LjsTA4541sxA9ALb4rJZsub2w3PPESpVa+kPZuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ou1y44IliPU0qgiUi9oUpRqjN0p7bDkuI+07pU6mhUnusga4QdU9UsGZNrT9ZwkXReqj4V3HlMV/bXulVhX/DNsPlX+94KQZ4EU/tnh9rH+HOEcUlMvxjKXC9exUeQ24Zmi/dnlA8RL/XNofptKP0oa7oHm7L9gnA1hPGmgtjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF3V/3cK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742524244; x=1774060244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bdl3LjsTA4541sxA9ALb4rJZsub2w3PPESpVa+kPZuo=;
  b=OF3V/3cKoEJTc7NO1Gx1KkEXVi+OyKFVmgk6Qf4aLSdsUTHjM+Ngi25j
   MpJEhtkJc7LolerlSjgRI22eg6VbpdX9iKDwoX1f21M26qz+fztALxY0k
   r+KHvkeHNjPAvRp3HGp/sC3Pu3jP4kBH2+d00TCJDWWwKS2yvDQw4VF5C
   hBTPLbiDJ47eObvzFuXF0jWGsefBaf20LOI/hTNmhIssvQ8lrzBt6vANZ
   jNxZs6BebPlPZZ9fHeK9dy2JtAj0o5ZtYqtToArxxIHLCzdAaGti2u+EH
   7Jf6lmkNhL4THxj7P2vKr3PHgW1YJM2Yp0LjpFupJ0BVP7c4hL/RGllNE
   g==;
X-CSE-ConnectionGUID: A0n+ebEoTY6XoJxPGQUULQ==
X-CSE-MsgGUID: 39KBnDTSR9SncjvMV2J1ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47557523"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="47557523"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:30:43 -0700
X-CSE-ConnectionGUID: NbUJDfzSTsCyineqJ/DSUw==
X-CSE-MsgGUID: RQHAAdD4QbKfA9F+WiVguw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123446135"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.252])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:30:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 0/1] SoundWire/ASoC: SOF: Intel: Let SND_SOF_SOF_HDA_SDW_BPT select SND_HDA_EXT_CORE
Date: Fri, 21 Mar 2025 10:30:31 +0800
Message-ID: <20250321023032.7420-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_SND_HDA_EXT_CORE is required for CONFIG_SND_SOF_SOF_HDA_SDW_BPT.

Vinod/Mark,

The patch doesn't apply to the ASoC tree as the SoundWire BRA series has
not been apply to the ASoC tree yet. Could you help to apply this patch
to the SoundWire tree if it looks good to you?
Adding "SoundWire" tag to the subjuct to make sure it will not be filtered
out by Vinod's email filter.

Bard Liao (1):
  ASoC: SOF: Intel: Let SND_SOF_SOF_HDA_SDW_BPT select SND_HDA_EXT_CORE

 sound/soc/sof/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0


