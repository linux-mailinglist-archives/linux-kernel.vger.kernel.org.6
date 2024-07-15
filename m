Return-Path: <linux-kernel+bounces-252001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A7930CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728431C20D85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30476BE4F;
	Mon, 15 Jul 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U1XH4M67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668D847A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012067; cv=none; b=HnQRqMWnQ5Kg6iFYx+VLhKNApFyn5rjEG/Vptqd7x4/rdZKsW+Z0PW4tdgyt08HXXTiQsBvDA89kpcQRmg4NP3/IIx+WOWahE0v4HpOQXqPMK8IHP25r04vjadh3rQeLkBFHT/rcsNdMtCyGMXnvv/GStxsIp99QbHP3MvYs7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012067; c=relaxed/simple;
	bh=BmRSDKT7ou42fGkk8L5G6sX38GNr856BrYqx3ptze7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNaDfDBzmXNh7S7DlkvgJyzhaLsZOpoCukecclyLh98ozS0JdLi0e/Cyu+DIT2zR7QFHg11vl/IMjP6B9hoMZ3bUNinHe8bKJMdz27yYSuPY1W4j3vG9tHUXwzuiXpT7TyT1xgB8SGRWaq98WrymRkI3QkZ0ADdIMHoHLR/UWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=U1XH4M67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BA1C116B1;
	Mon, 15 Jul 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U1XH4M67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1721012063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJbzhxYB1PXAMl1si/1jzAy52eN+LVpC0eVJ3ejtru4=;
	b=U1XH4M67Y/tozyWc1LMA7JA8h7QEoyqgRKK7mYQvOlgoYI/3f2vX3TQeofx7XaOtloQdtX
	+PbGuKMBfe7g47Nmbb7lsr7ZnvHNmLtDNcm7oF1HE/O7VUBb34wOXreYE6uHrAiyYjEdZq
	Ykto7zivxJwnOD79JUnyV/Ck0TLL1PM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 85dce8b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jul 2024 02:54:22 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: note that RNDGETPOOL was removed in 2.6.9-rc2
Date: Mon, 15 Jul 2024 04:54:15 +0200
Message-ID: <20240715025415.910243-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RNDGETPOOL was thankfully removed twenty years ago, but it's stuck
around in headers. Probably removing it from uapi headers isn't great in
case there are some weird users out there, but we should at least mark
this as having been removed.

Link: https://lore.kernel.org/all/E1By1St-0001TS-Qj@thunk.org/
Link: https://lore.kernel.org/all/Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/uapi/linux/random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 2a3fe4c2cdc9..1dd047ec98a1 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -20,7 +20,7 @@
 /* Add to (or subtract from) the entropy count.  (Superuser only.) */
 #define RNDADDTOENTCNT	_IOW( 'R', 0x01, int )
 
-/* Get the contents of the entropy pool.  (Superuser only.) */
+/* Get the contents of the entropy pool.  (Superuser only.) (Removed in 2.6.9-rc2.) */
 #define RNDGETPOOL	_IOR( 'R', 0x02, int [2] )
 
 /* 
-- 
2.45.2


