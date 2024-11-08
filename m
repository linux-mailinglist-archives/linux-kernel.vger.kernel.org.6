Return-Path: <linux-kernel+bounces-402421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DF9C2755
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D412B1C2265B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01F1E1029;
	Fri,  8 Nov 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="CJaoYnIS"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185621C1F02
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103884; cv=none; b=EVjIwyXugFDY7AoHm8CrO4HpwSLf20yPJmG528FcqdG0oP/l5R4GXVqnU09zeMsE1ZmPXGslsZgowKC1inPUPuELIuRNbjYGH5nI3T/S7jrSIiQ3uIgyS+6vCp0+xbNQyVu1+wr/5Nf9GpX69FLBgJZ+rX3Dx1ZHvtHiV+3e1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103884; c=relaxed/simple;
	bh=SJMtjG50/Wsd+6SxZD/YO2TSTG7gXZRY4AyacGsVwU0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=twJgPuKhF79vYJEa+cQ+kzB0+uD33BaOIhHUzTY8Pg8xjMMTH1y0VwUft/w2fYKPT9btfa7oNw2P+vfz9Ji3JHExxxoXkz9wnj1kqq2BxaEqDrTrzayUKSPCVLWkbH/QAA8K+9oYc7Evs4qg+ekfD++Qf8uicr6qh/F2a4wBnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=CJaoYnIS; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id BEBDF1770C8; Fri,  8 Nov 2024 22:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731103876; bh=SJMtjG50/Wsd+6SxZD/YO2TSTG7gXZRY4AyacGsVwU0=;
	h=Date:From:To:Subject:From;
	b=CJaoYnIS/Ejp7gUfS97yeusNTO/SUejiU5fciTYSQU5J6G+2xjvu05DbdiS9xuuLz
	 4AQ28S5kbZZIRsCy+zmnRYKuX7EgAdPFbV5suCL0lBCfVl79D4iJuQqZ04x70oO0Lo
	 3v2QBV8sskFXd+iLHqBsxnIQJ5/QbGM1Pbe8mUHvhxjYN7aq3kFCubVeFUSoKIXOcU
	 d3ZGge557uR0hhhxFaGy7QPTm5f7Snu/CzMdbzhiTXreu1m5RQp7Sj1+NnOLdpq5zV
	 VnX/Kb7B41moko80MeZSTpfpmn5ayh6rWq5ebYweY4f6KFtxdojc475iVl5u3sMD6j
	 MO9LWHngBecwg==
Date: Fri, 8 Nov 2024 22:11:16 +0000
From: Nir Lichtman <nir@lichtman.org>
To: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
Message-ID: <20241108221116.GA123748@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: When using KDB via keyboard it does not react to control
characters which are supported in serial mode.

Example: Chords such as CTRL+A/E/D/P do not work in keyboard mode

Solution: Before disregarding a non-printable key character, check if it
is one of the supported control characters, I have took the control
characters from the switch case upwards in this function that translates
scan codes of arrow keys/backspace/home/.. to the control characters.
I have took them all besides the TAB control character translation (I am
not sure what that maps to on the keyboard)

---
 kernel/debug/kdb/kdb_keyboard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index 3c2987f46f6e..2c004abd5375 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -172,6 +172,9 @@ int kdb_get_kbd_char(void)
 	switch (KTYP(keychar)) {
 	case KT_LETTER:
 	case KT_LATIN:
+		if (keychar == 4 || keychar == 1 || keychar == 5 || keychar == 2 ||
+		    keychar == 16 || keychar == 14 || keychar == 6)
+			return keychar;		/* non-printable supported control characters (e.g. CTRL+A) */
 		if (isprint(keychar))
 			break;		/* printable characters */
 		fallthrough;
-- 
2.39.2


