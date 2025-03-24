Return-Path: <linux-kernel+bounces-574499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F832A6E60A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D23B7A99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183F1F3FEC;
	Mon, 24 Mar 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5l5S5+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554231F3BB2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853388; cv=none; b=MPV4037355fw9qqlFBHXgrqZUZaQE6afHC4JlqdjIaz0YkYwjyZrYE7+Os9cfRf2jDe3CTJyr/L2CbSlki59yabNTU3vsC8bzX+l07Z46H2AWGUgjULc/LH98GFcom60qVsIxdLMWOUSVVDjsC+gh2YEFm64wEG/fk76GB5vPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853388; c=relaxed/simple;
	bh=9LaUKcsJYxwa9715jUtaKqGsyMaRbvFl48Eo6fa7xDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKhPuGCRT+tS1CV3qSF6itSAX4Xb0PiRvkaYTKhj6ad1Hz6RuIaeFp/VrUjGy5h5SwfvhCRcLaHdMV2JYgdCF3bv7d+A23pquA6f0mBBy5SYMuN9Of/8pNtrOyCisIQoHHcUgsPunuWxSx2eHM2MWHiD1596i6JZBaKIkZOyZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5l5S5+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB5EC4CEEE;
	Mon, 24 Mar 2025 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853387;
	bh=9LaUKcsJYxwa9715jUtaKqGsyMaRbvFl48Eo6fa7xDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5l5S5+k17TQugmd/qBSepmqaPKieLSprKxotZAOVvbvWqJ6NzowfpTF3YH7AW0ko
	 WSZgweHUjW9DpeSJ0bykWhkxrDRDVEDz4WaZCXYDE7Uf33wOJYW6rnf2eelis31QnF
	 5CKyCRZtifC69TOglxNQtV1Xz129XzOtajutMUYveUeiFzLp6x9J5F79tU35vxniid
	 BYYkV0wiuYKoxhcglyDkq28FZnvcdrg+duNw0gLpjwzQgZw8757j244sg5PM5Q/FIu
	 b6bD36K7O0J8H/P4leifLYI7GA9BMaQIXhEDrGWeWgdj3XgNgZvYoxVoVoJlE95YGZ
	 rowGbEA9hOcCQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Mark Brown <broonie@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 14/22] spi: amd: Fix out-of-bounds stack access in amd_set_spi_freq()
Date: Mon, 24 Mar 2025 14:56:04 -0700
Message-ID: <78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If speed_hz < AMD_SPI_MIN_HZ, amd_set_spi_freq() iterates over the
entire amd_spi_freq array without breaking out early, causing 'i' to go
beyond the array bounds.

Fix that by stopping the loop when it gets to the last entry, so the low
speed_hz value gets clamped up to AMD_SPI_MIN_HZ.

Fixes the following warning with an UBSAN kernel:

  drivers/spi/spi-amd.o: error: objtool: amd_set_spi_freq() falls through to next function amd_spi_set_opcode()

Cc: Raju Rangoju <Raju.Rangoju@amd.com>
CC: Mark Brown <broonie@kernel.org>
Fixes: 3fe26121dc3a ("spi: amd: Configure device speed")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202503161828.RUk9EhWx-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c85997478b81..17fc0b17e756 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -302,7 +302,7 @@ static void amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 {
 	unsigned int i, spd7_val, alt_spd;
 
-	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
+	for (i = 0; i < ARRAY_SIZE(amd_spi_freq)-1; i++)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 
-- 
2.48.1


