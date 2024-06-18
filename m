Return-Path: <linux-kernel+bounces-218482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC7B90C06D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376BB1F21BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19FD79D1;
	Tue, 18 Jun 2024 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKoK54fy"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18362C87C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670987; cv=none; b=G6/siEE+tS92dTxJL6mVB8nPdraPOLW4n96XKsGBWA/5bSi4nLmFGwgKNbs3KdyzGhcI28ukdQiCY79dL8bYVSJgp32yDlsjHnsE/+jdTs9yece/vj4YoxtEjPjU3JyDoGhQ7bLMa3CY5XP9oe98AvcqaSh5UU43x0VlnbMbstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670987; c=relaxed/simple;
	bh=ZUjls29bJSFNoK5TjauO3l5FflPuSIYtQbZwf169FWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mehdm7nqWaivQ1xZNsg/SrJRoOZXn02VUxgwXfu1cYzeMqaNZbcFolx59Tt+AviEhMUBK9mQX0lnGST+WCLc2UllOHY8J/k5KiIUGL9sEerviLSAKsfqZyj0OTipiZLqYmONYClVZfamNdMryobdlhRE86QgfNJDHjYKTqin7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lKoK54fy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-709423bc2e5so1290259a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670985; x=1719275785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWRveTj7gNOiUWOxLfGonpPzYeI6GUmJM4srwsOzQy8=;
        b=lKoK54fyQRXJgQDfT33YaKvEMKCUxe5sxsAUuUbMb0DSl/Zvbvzy26L3s/jx0yawnd
         bh+boouZNSvfg7yLLCgrmYcH89CSCrxxtrWin05ufq8zCEtev2Bp2Gqmo6NdgQVJ0Xz+
         g0feLBgAT32fQczW9n4BL+/zZYKLawIDO5Bjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670985; x=1719275785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWRveTj7gNOiUWOxLfGonpPzYeI6GUmJM4srwsOzQy8=;
        b=wgXUaat301Hr9EZlSEoDc1aM0PWb3lXuDoJM9fQN4mLSVDkCvteOF20Cmllgb/8jt6
         rygBGWJYmibltfIHLrI+zAOjqCW8MoHP4JR6SVgHJeWXBETAtJ2K1ai6hvk/jvlRIoXs
         wbhLAzfwkWcqKZyTeFg7I5pjPtRbRtI7QnhNzkXbL/0Lv/wJelwJ6zbICK68td50QlyB
         AkjvLFfRamqiHnF94xceA5rjjXjN1WSWvAaYFraAfvPPfyd+bzCt6jj+fG/Xlawuy4Gs
         tk69bIS0IwNxdM/WKfHmYMwgi4cqHfy59kJHaN45UmxX8NGL6lCBIZEFyuKCTrfmmlQN
         0n2A==
X-Forwarded-Encrypted: i=1; AJvYcCWxN3dV03gekWiIZY7kVRTDGWVoOJ3+XETFmVe+igGGxRmC7/QrHiIAC57M81K9qICHBItLwKItUaFKCYbBgvQQVhNhLDX71UnkDhLl
X-Gm-Message-State: AOJu0Yw5hSLcdip+h41f37Tu6/ntFyChA1mbNdighK/HKto2YJxs85YI
	6alJ+g5vS8DKKRXk1s+QWWpvB7VqNAVvGfX0QBUebQauBktW6QkfSzsnJp63iw==
X-Google-Smtp-Source: AGHT+IGI3mseEIj5mmCReMXbnQOFETM6xmfqcgkzTut3mANpur+xZ3fiAWl2XLNVez9BwZAzKsdtAw==
X-Received: by 2002:a05:6a20:a123:b0:1af:cfca:e515 with SMTP id adf61e73a8af0-1bae7d8538dmr15672555637.12.1718670984976;
        Mon, 17 Jun 2024 17:36:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:23 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] kdb: Use 'unsigned int' in kdb_md() where appropriate
Date: Mon, 17 Jun 2024 17:34:43 -0700
Message-ID: <20240617173426.9.I95a99321878631c9ed6a520feba65b949f948529@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several of the integers in kdb_md() should be marked unsigned. Mark
them as such. When doing this, we need to add an explicit cast to the
address masking or it ends up getting truncated down to "int" size.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index fcd5292351a7..c064ff093670 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1594,8 +1594,8 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 static int kdb_md(int argc, const char **argv)
 {
 	static unsigned long last_addr;
-	static int last_radix, last_bytesperword, last_repeat;
-	int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat = 0;
+	static unsigned int last_radix, last_bytesperword, last_repeat;
+	unsigned int radix = 16, mdcount = 8, bytesperword = KDB_WORD_SIZE, repeat = 0;
 	char fmtchar, fmtstr[64];
 	unsigned long addr;
 	unsigned long word;
@@ -1722,11 +1722,11 @@ static int kdb_md(int argc, const char **argv)
 
 	/* Round address down modulo BYTESPERWORD */
 
-	addr &= ~(bytesperword-1);
+	addr &= ~((unsigned long)bytesperword - 1);
 
 	while (repeat > 0) {
 		unsigned long a;
-		int n, z, num = (symbolic ? 1 : (16 / bytesperword));
+		unsigned int n, z, num = (symbolic ? 1 : (16 / bytesperword));
 
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
@@ -1745,7 +1745,7 @@ static int kdb_md(int argc, const char **argv)
 		repeat -= n;
 		z = (z + num - 1) / num;
 		if (z > 2) {
-			int s = num * (z-2);
+			unsigned int s = num * (z-2);
 			kdb_printf(kdb_machreg_fmt0 "-" kdb_machreg_fmt0
 				   " zero suppressed\n",
 				addr, addr + bytesperword * s - 1);
-- 
2.45.2.627.g7a2c4fd464-goog


