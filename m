Return-Path: <linux-kernel+bounces-319572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6F96FECA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91251C2218B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF778836;
	Sat,  7 Sep 2024 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txbaz/S0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3214C9A;
	Sat,  7 Sep 2024 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670534; cv=none; b=Bu7Xb8vegIYu9rYG3JakAjeuFYPwavvYvU/OvWBMpCIFgMg1J9EYk5gjqZ9KysXQ1Slc4+yhRnTtlklvVQ0f9LiwQzm/NFm4iv98GYvGXqGk7wf8dFd7CPgxED8SQXUwW4EPiVOhntwvJoTFIn5vlPLol/Sh81C/ILyjoovT0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670534; c=relaxed/simple;
	bh=wxD7YWuOg77zkgGePiidkzZ2id3XVXVfSV/B0CWo3fs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nI3D0u9TfQOoUSoeygBxRbDdkss32iq5UiF/CBTH3j7saiNsIt4AYbfqKM/Ab/FjuOt5nzBpWra4bO6fp+olei1g5VP7Df2FMKVGiVmHTSmOZ9pvLlRZGkxBfCx7V5t1tZS4Xm7oAlLdWLEE7xQaHs3RgiYZ+JibEW76eQqI38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txbaz/S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DEBC4CEC4;
	Sat,  7 Sep 2024 00:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670533;
	bh=wxD7YWuOg77zkgGePiidkzZ2id3XVXVfSV/B0CWo3fs=;
	h=From:Subject:Date:To:Cc:From;
	b=txbaz/S0DzOqrP7Srj0uHP5NwxJ61ZeyK08ZfBcewUFksEwOYFOUa0Foy7TOBnZvo
	 wPHq+o3OGG47gBV9QPJ7h4DoE5rjnrSVk/Qqwv8nWYyyIHOYO/oxkf5GU741tZgH6N
	 UDVV09gFMXI8gml+xjjoeTll5SK7jZ2nurK4MywL07sJIjMEpwCMzIb8hV5FxwPn0n
	 TDLFNCxFFkSTWbwANTqX1QZquIamCMZHMLAUvHwixZXrvAV9lE4V+knRFZJUgravGE
	 rgAEFJwiRki76V5OwHhOifDSlQdjAZqh0JAMW8BSisCP22F2GKn86uEJyFbJpcsLv9
	 kL/KiUW32FphQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/7] ASoC: mt8365: Fix -Werror builds
Date: Sat, 07 Sep 2024 01:53:25 +0100
Message-Id: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAak22YC/x2MWwqAIBAArxL73YKaPa8SfViutdALrQiiuyd9D
 szMA4E8U4AmecDTxYG3NYJMExgms46EbCODEkqLWhRowjag4xuXo8qKHPuTZ4t1qaUse6mcMBD
 b3VN0/m/bve8HFLDYaWcAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wxD7YWuOg77zkgGePiidkzZ2id3XVXVfSV/B0CWo3fs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26R8iUKAFPl5RrLULFN0jg3emwaq07m5JyXWp
 stS2I2P9gWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukfAAKCRAk1otyXVSH
 0Hv2B/0SdQwOpPUm0EC+oUW/2mBA+W5rI22n4xAN2Vfq3mvmNfMYxZvvtj6ESUy7aLMufxHWqZP
 MXwu8DuzxgbtZPfXDU8Z0HM6esGQH78MOSlNLG+hosmwwo8Yv/98YCER0QTAiyZnEDhzregE2qm
 LyqdtQ87iWeDy2AfUfxP2nrPau3Qf4qcEqgpoggmi8cOt34Dfyw8Z41dVgbDFkjXXCEITLc+uJz
 pd3UFpDib5MbDflmwnc9+iIYwsNhm0Hf7JRE18vbLJLlzStQL7o8djFMJhfx7UOkv6UTdZ657Oz
 ccBGhg4nKajdTOnPlWveLoBNGkVZLXWOfKogXKKyUIwvoyVr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Nathan reported that the newly added mt8365 drivers were causing a
number of warnings which break -Werror builds, these were only visible
on arm64 since the drivers did not have COMPILE_TEST enabled.  Fix this
and some other minor stuff I noticed while doing so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (7):
      ASoC: mt8365: Open code BIT() to avoid spurious warnings
      ASoC: mt8365: Remove spurious unsigned long casts
      ASoC: mt8365: Remove unused prototype for mt8365_afe_clk_group_48k()
      ASoC: mt8365: Make non-exported functions static
      ASoC: mt8365: Remove unused variables
      ASoC: mt8365: Remove unused DMIC IIR coefficient configuration
      ASoC: mt8365: Allow build coverage

 sound/soc/mediatek/Kconfig                    |   2 +-
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c    |   4 +-
 sound/soc/mediatek/mt8365/mt8365-afe-common.h |   1 -
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c    |  13 +-
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c   |  30 ----
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c    |   6 +-
 sound/soc/mediatek/mt8365/mt8365-mt6357.c     |   3 +-
 sound/soc/mediatek/mt8365/mt8365-reg.h        | 214 +++++++++++++-------------
 8 files changed, 120 insertions(+), 153 deletions(-)
---
base-commit: 813751eaec93bfeb6236aaed99607a44c01b3110
change-id: 20240906-asoc-fix-mt8365-build-974117b12f0a

Best regards,
-- 
Mark Brown <broonie@kernel.org>


