Return-Path: <linux-kernel+bounces-574504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B12A6E60B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A41887FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884611F4CA2;
	Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1TnlNEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14711F2BB8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853390; cv=none; b=USi3AsECaYMYQkDBtxU7B00g08eSzbTu8IW7S5HvZNnU+2aVdjTxJG4wTxRTXbSAfzwjTO4CVDpgknGfEzaY552mHXPhui4IwBvasy7g3vE8f/MspUSgdXWkSFVef5ezePP8LtCm8jbOlbl/MlVH9L/6Ri7OCqYGdWVHHOzDSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853390; c=relaxed/simple;
	bh=xVODsZWMExesxu8RVLgFgw7b8qaLdHIil2gMTtc+l8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asYUVdHCy+xkIzZGYDVPzPvFNYqsin0w1k1FTzIc+nJ9MU2Xj7N5/GErXV6IflS404YdD3Tl5abK0TGt03qj2fVVTn12EGJEEB+g/hGsklkuuM8Comk5t1uFVLu/eQKhIGvUBqdp3cQnbfNi3nc6aEQXFI5qrs4jxaY1GFbrnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1TnlNEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01449C4CEEF;
	Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853390;
	bh=xVODsZWMExesxu8RVLgFgw7b8qaLdHIil2gMTtc+l8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1TnlNEyBvXpwEYZbbxtCYnVtDWS0hJVuMIdqYmVL3S+1/yIozkLl6KqRHpHRu1IL
	 WXXJ2DBk0UwE5GBxDLYEA5rAllJWMxhjZD8688HPech0MYqp0YweS0FVRGwvWZ6Ao/
	 /FHaiRlh+WY7XiGe3qmOIsYox5x+hkL/qF9NLrMFoS0CejSfd3qR3gFDHDx6sgTcDx
	 NhBuRkv0teIPpKqdK0jGxy3A0I8CsP1Sa8SSRmSC/AjYDKTU8A3ST+xy/04yblqhCD
	 tiEmSYRhwCn3HjbTHZ0RRySXKCSJ/mShRhKHL7+AAhfYjW4hW2NAaQNFrKfgnsLdzL
	 YF+cTRXWD6Pxw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 19/22] ASoC: codecs: wcd934x: Remove undefined behavior in wcd934x_slim_irq_handler()
Date: Mon, 24 Mar 2025 14:56:09 -0700
Message-ID: <7e863839ec7301bf9c0f429a03873d44e484c31c.1742852847.git.jpoimboe@kernel.org>
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

If port_id is negative, the shift counts in wcd934x_slim_irq_handler()
also become negative, resulting in undefined behavior due to shift out
of bounds.

If I'm reading the code correctly, that appears to be not possible, but
with KCOV enabled, Clang's range analysis isn't always able to determine
that and generates undefined behavior.

As a result the code generation isn't optimal, and undefined behavior
should be avoided regardless.  Improve code generation and remove the
undefined behavior by converting the signed variables to unsigned.

Fixes the following warning with UBSAN:

  sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 910852eb9698..c7f1b28f3b23 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2273,7 +2273,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
-- 
2.48.1


