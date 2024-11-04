Return-Path: <linux-kernel+bounces-395329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA569BBC64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B813282A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA4E1D0E11;
	Mon,  4 Nov 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNlEqa+P"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BA1CACDE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742642; cv=none; b=Rei2lfn1w7IJa13eYyghHdIHkEsVI6/clxE4sdndAjYnVYtfUgBz2QVywRRuQdwYcQR4VfszGwSq34Ize/i1fspbsh8Mvps+o1Coci1pfaTax0zKyrwE4KvyZDiE64UPT5OPpiuHeYz0DnwrNJWZBTs1i0IZr0GWsmVMxCffYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742642; c=relaxed/simple;
	bh=r8oDawuzwrCTjMJNkuzF+kmtf/cLqFGhI9bi3b/8YqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzp4phsYZsZawQ0CHw9anufl8Hp5+1hF26iKd1Fll5a24YZ+udzoWM+EIxWVHAt1Gi8Mt1ByKAuz14/DO2VXLgCxLprciUdsGGaVthvFnfcST6kwzXaHtDATMuLdPqHQeheFji6pcsBAhtAoUJOr5HS20/sIHmiyf909OLDb8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNlEqa+P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso38513115e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742639; x=1731347439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnCRniz6rwW4FxyVUqUDwT3HfYK1tMoSQehysVO/b1w=;
        b=gNlEqa+P5NOuKVN7sXJbQwKNfj/qQsZKODWyR0YQUQN5UnoX1YfevjDdMpGcpK+Wtg
         tHniFlskkquH5aELCAGiymKjG38WWyZVzczvCtZKA0IpKNzUBeSZzfh0d/hkDAjyeTTC
         l3UDzdqopC2SUWNyMRyH5xkPs0vt/Nt/qM2+9kgGxpT01N4esiKTFhFv3LZ8POKaSnb4
         cJsRdWgwB+mzzAGGbSBhPaSDl49yVCrIFRWKcCU3sPbzs8ytWQm0+7mHWX+MyKUr3zMp
         +6tHmQlz5BjpxCMfpzvFlT66N1zw45qSIfRZtRjbpDy1boUZBAIPeqc4BWi8osRMBZEo
         pn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742639; x=1731347439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnCRniz6rwW4FxyVUqUDwT3HfYK1tMoSQehysVO/b1w=;
        b=lD1MOj2Q+oT0hmCa3kfw42W3haIz1DdPBNdbXjWE7SwWXIlxCxceVhq0AmXa7uuQI6
         46tPZVw7VKkZdkXrbDdaZXsyhlBkcnH5NTNhjCLQh4BjVCxGRBz4SLM6j0VjfXt5OMK+
         VhYKtuMRtHV1vws0iT7FNLyeCtsSKU3OnvDkRFFbTHX64SOSaeMlHVflPiIBQMelMKXR
         5oCWmphuoOtH+GHqxo2WJngz9rQJVAef09Dl3lmct5ZetMtnD38rF1DmbtEceZfUSKTs
         9WrnXQaYeaUsXJUBrhRcnXpUfrPdQ+CAQnGqtlnM23D0E7tBfRMLRokFS7q3YRj8x+eH
         DMlg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQtdb1E0G3dP1//WeIZY8GwkEy5kxiJdquOCVd0GV0sOL8vYWu+Y78DNCbHO95nz/K+DQqMr3wMMf2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroZ6mWl4T1zj2Yve4fFuyngzIXnfemiaJUIVrq6pKn2y8M0yt
	cwsTjCp82o/UOu+Dbs5LQzKQExgaKEYYm/fZU9phKqKfjmfdIKz3XVkRurf5
X-Google-Smtp-Source: AGHT+IGNRKQXMXIFktTsqSu5Cqzlhbz5LhgCV8zs8OBKycVfuNRvFw3mF9TjCqlV/c3pcFyFe6H3dw==
X-Received: by 2002:a05:600c:3587:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-4327b6f464amr133648605e9.6.1730742638570;
        Mon, 04 Nov 2024 09:50:38 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:37 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 12/12] staging: gpib: Correct check for max secondary address
Date: Mon,  4 Nov 2024 18:50:13 +0100
Message-ID: <20241104175014.12317-13-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIB secondary addresses can be between 0 and 31 inclusive
unlike primary addresses where address 31 is not a valid device
address.  When 31 is used as a primary talk address it
forms the UNT (Untalk) command and when used as a listener address it
forms the UNL (Unlisten) commmand.
The library was incorrectly not allowing a secondary address
with a value of 31 to be used.

Fixes: 9dde4559e939 ("staging: gpib: Add GPIB common core driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 4 +---
 drivers/staging/gpib/common/iblib.c   | 6 +++---
 drivers/staging/gpib/common/ibsys.h   | 3 +++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index e84097ac8f69..0285180ae1f0 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -525,8 +525,6 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
  * SPD and UNT are sent at the completion of the poll.
  */
 
-static const int gpib_addr_max = 30;	/* max address for primary/secondary gpib addresses */
-
 int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 	  unsigned int usec_timeout, uint8_t *result)
 {
@@ -538,7 +536,7 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 		return -1;
 	}
 
-	if (pad > gpib_addr_max || sad > gpib_addr_max) {
+	if (pad > MAX_GPIB_PRIMARY_ADDRESS || sad > MAX_GPIB_SECONDARY_ADDRESS) {
 		pr_err("gpib: bad address for serial poll");
 		return -1;
 	}
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index fc57e760c144..db1911cc1b26 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -479,7 +479,7 @@ int ibsre(gpib_board_t *board, int enable)
  */
 int ibpad(gpib_board_t *board, unsigned int addr)
 {
-	if (addr > 30) {
+	if (addr > MAX_GPIB_PRIMARY_ADDRESS) {
 		pr_err("gpib: invalid primary address %u\n", addr);
 		return -1;
 	}
@@ -498,8 +498,8 @@ int ibpad(gpib_board_t *board, unsigned int addr)
  */
 int ibsad(gpib_board_t *board, int addr)
 {
-	if (addr > 30) {
-		pr_err("gpib: invalid secondary address %i, must be 0-30\n", addr);
+	if (addr > MAX_GPIB_SECONDARY_ADDRESS) {
+		pr_err("gpib: invalid secondary address %i\n", addr);
 		return -1;
 	}
 	board->sad = addr;
diff --git a/drivers/staging/gpib/common/ibsys.h b/drivers/staging/gpib/common/ibsys.h
index b78ca5ea4da1..da20971e9c7e 100644
--- a/drivers/staging/gpib/common/ibsys.h
+++ b/drivers/staging/gpib/common/ibsys.h
@@ -16,6 +16,9 @@
 #include <asm/irq.h>
 #include <asm/dma.h>
 
+#define MAX_GPIB_PRIMARY_ADDRESS 30
+#define MAX_GPIB_SECONDARY_ADDRESS 31
+
 int gpib_allocate_board(gpib_board_t *board);
 void gpib_deallocate_board(gpib_board_t *board);
 
-- 
2.46.2


