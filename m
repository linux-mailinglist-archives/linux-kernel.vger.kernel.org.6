Return-Path: <linux-kernel+bounces-514243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BBA35491
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DB43ABDEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDD14F104;
	Fri, 14 Feb 2025 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrABkyUP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF51768FD;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499223; cv=none; b=iGUPto+JLcwx6HLJkVVHy+HgBRPy264qe5c3M3aqCz4uJBrVeJxaDRz+eME6YIGpFblOnm4DW0jEfboDJXsSgsMhvGFjkiQO8oJ0nULbhdmePDJ6xk1fzJBeTyJb959Ox6SwvAv7FpedqUZS0GzIJF/e0WNw1J8WCyF2QeORMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499223; c=relaxed/simple;
	bh=ODJBeAyu7yG9wfg1tMx7ifensJoaGn0MRyzsb8NOKTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aduNVuFyTAk4DYBYQAbpT0u21Y51HJIzvYo5Luly+LXoyChasnUIaFArFh62StsIfFxR4DX28thcb8c3p9et8+BhHW4m4UcKkzagRdAh1iE3HcUdm4VSkir8dNjXRhLyJ3mMJ+FP0kHKjcs1tkCbCA7YDv/RU59lulg61k3KIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrABkyUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41CF1C4CED1;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739499223;
	bh=ODJBeAyu7yG9wfg1tMx7ifensJoaGn0MRyzsb8NOKTs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lrABkyUPohJ7Xv2Hzb2tmHYKBu0Z8Q55WtJqrcMQ6X8E+W8cqVBKIkhVwDdzY5lzX
	 IGoZ1aXzL5/65FQExBtHXqqLq5qyoD2BBozd1pJoCRo92vZJROq078UHdNH/n/dGvo
	 mSOFnJjyy3kaIXQ1viaZ45jozeN3JRPtLHVlzFYLuDSaBGq3axnYFc0bDi4HKp6z7n
	 wUEiHNxPCUUgLBhZHHx3EZWAZIicpHvwE0SKm+lyj+cEQMtLwwtUfIhBNrqJAfzcfb
	 OVcTvsK37RuH/IMTZOTivAAFYTeeizQ0VWuw4MGECnqQcwkjlb3D0PIhSV0glPtVL5
	 EYggi3uIEqDbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6EDC021A0;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Subject: [PATCH v2 0/5] Add support for S4 audio
Date: Fri, 14 Feb 2025 10:13:39 +0800
Message-Id: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANOmrmcC/1XM0QrCIBTG8VcZ5zrjqBtaV71HjDB124E2Q0uK4
 btngy66/H/w/VZIPpJPcGxWiD5TorDUELsG7GSW0TNytUGg6JBzZObpKFxczOQjQ2U6qbltD+0
 V6uUe/UCvjTv3tSdKjxDfm575d/1B8h/KnCHTlrdK4SC1wZOZb2Eku7dhhr6U8gGrkwkdqgAAA
 A==
X-Change-ID: 20250110-audio_drvier-07a5381c494b
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739499221; l=1437;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=ODJBeAyu7yG9wfg1tMx7ifensJoaGn0MRyzsb8NOKTs=;
 b=IrYG6+tVk3zdh0UgKNgdgxRY+xWdt28tefwfjiNO5BANQ+TJ21Qx+JAznmInNJ7kI3fsjNZfz
 IWlwUx5kJtmA4NHvM8XL6TIpzmiiJ1CRbtjSwHivS4etqDvXEIsuYMa
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

Add s4 audio base driver. 

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
Changes in v2:
- remove tdm pad control and change tocodec base on g12a
- change hifipll rate to support 24bit
- add s4 audio clock
- Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com

---
jiebing chen (5):
      dt-bindings: clock: axg-audio: Add mclk and sclk pad for s4
      dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
      ASoC: meson: s4:support the audio clk
      ASoC: meson: s4:support audio tocodec
      arm64: dts: amlogic: Add Amlogic S4 Audio

 .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  18 +
 .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
 .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 219 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 370 ++++++++++++++++++-
 drivers/clk/meson/axg-audio.c                      | 410 ++++++++++++++++++++-
 drivers/clk/meson/axg-audio.h                      |   4 +
 include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
 sound/soc/meson/axg-card.c                         |   3 +-
 sound/soc/meson/g12a-toacodec.c                    |  64 ++++
 9 files changed, 1095 insertions(+), 5 deletions(-)
---
base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
change-id: 20250110-audio_drvier-07a5381c494b

Best regards,
-- 
jiebing chen <jiebing.chen@amlogic.com>



