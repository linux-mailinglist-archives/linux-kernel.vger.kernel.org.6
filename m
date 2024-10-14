Return-Path: <linux-kernel+bounces-363867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515599C804
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEA287520
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4341A071E;
	Mon, 14 Oct 2024 11:00:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161B1AC444;
	Mon, 14 Oct 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903636; cv=none; b=tdBMDBwBvslljHYQylE3rApYZmAC+K3Huf691vQelKlVoaWuCbANcs56BjTwdbdo0Qv9Fq3XZ0i47G6+MSdrJV9FVUXwqv0zT3z7UkIOYSKhKr4uljGqOuMeFaaBe9CYmvJat4J/dfbUIglxift4vYTIeSzQmqiIVOEhUxOZ3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903636; c=relaxed/simple;
	bh=FcM7fKKo2HWCTYaccbwaa3xgX3AIhVCd/YNKcH7yqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIQISzuEPaWYExXt4MzuQ6+kHEua5xnweku1+BqiWOmdNLiBQRyMC7PxAIgFbgqt+RNhZZcIKV284NM7iQa5+LdoaYd3JnDZEahc3T6aX1NECXo55xUG59oOMyqO+Vj7LH7aAgQUiUvmqlrSS7k/FeOKfBr7CYx5JuxDqoSYmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C133168F;
	Mon, 14 Oct 2024 04:01:04 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201A53F51B;
	Mon, 14 Oct 2024 04:00:32 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH v1 22/57] sound: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:29 +0100
Message-ID: <20241014105912.3207374-22-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 303823dc45d7a..74e1bc1087de4 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -98,7 +98,7 @@ int snd_soc_tdm_params_to_bclk(const struct snd_pcm_hw_params *params,
 }
 EXPORT_SYMBOL_GPL(snd_soc_tdm_params_to_bclk);
 
-static const struct snd_pcm_hardware dummy_dma_hardware = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct snd_pcm_hardware, dummy_dma_hardware, {
 	/* Random values to keep userspace happy when checking constraints */
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
@@ -107,7 +107,7 @@ static const struct snd_pcm_hardware dummy_dma_hardware = {
 	.period_bytes_max	= PAGE_SIZE*2,
 	.periods_min		= 2,
 	.periods_max		= 128,
-};
+});
 
 
 static const struct snd_soc_component_driver dummy_platform;
-- 
2.43.0


