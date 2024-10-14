Return-Path: <linux-kernel+bounces-363669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2D99C573
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631461F24582
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A615820C;
	Mon, 14 Oct 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNZqVbGx"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520C149011
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897566; cv=none; b=pex6sHGfYN2npmtwLDDwnr9qFKkWFiAB0Vvlny6Iu+oEFTYF1NAdRq4sbHXxI4EpXwGvHiXNtLiVFrnjG2GsKdF12hbucpOERj2FFM2uP0jp6ZsN37qf5XZ66qaEKTwvuIj6TAPNSEWTqkjsz+Rpfn6iNjIViOgXTD2vKS1m88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897566; c=relaxed/simple;
	bh=wVNYUbvUl3sPG53le+WJDckMtDV+JM8zWMYsaYz1umk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm0IdmnsZFsuPRAZxJAK7313UqwWX0Yu/QyfOcgbe0kIkZBh+H9jxPni+5KH0wdyaJZYwF27FyxH2dbJeKqBl3F12lW4IR8iUhxi3FmjX20r9JiWF2MafxCnqIf4jkQipgmVFG4DalxBqwQxbFYI/S8ifjRhdUxzUgMKmgMlFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNZqVbGx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728897560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dj7fxHIiOkLjML343LBKlVwG31MU/qAIpzhZyO5s5uo=;
	b=XNZqVbGxPAt4UpWQJEvW9S6vOheuiEE+d+ckHEJ4Dkn0nJ7iFM5gbzGHS7oVKxebT+Jm8e
	v2r2JQHQFi9t+gamFt0DGppufz9iJZIM0gcBrUB72qlywyg0N8gIFjQyG1Bg4nFNwHxXa6
	6BFmFUv4Q9+At1ZRicReL7Zj9QvROPE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: nconf: Use TAB to cycle thru dialog buttons
Date: Mon, 14 Oct 2024 11:18:28 +0200
Message-ID: <20241014091828.23446-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the ability to cycle through dialog buttons with the TAB key.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/kconfig/nconf.gui.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 72b605efe549..aeac9e5b06ee 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -277,6 +277,15 @@ int btn_dialog(WINDOW *main_window, const char *msg, int btn_num, ...)
 		case KEY_RIGHT:
 			menu_driver(menu, REQ_RIGHT_ITEM);
 			break;
+		case 9: /* TAB */
+			if (btn_num > 1) {
+				/* cycle through buttons */
+				if (item_index(current_item(menu)) == btn_num-1)
+					menu_driver(menu, REQ_FIRST_ITEM);
+				else
+					menu_driver(menu, REQ_NEXT_ITEM);
+			}
+			break;
 		case 10: /* ENTER */
 		case 27: /* ESCAPE */
 		case ' ':
-- 
2.47.0


