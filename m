Return-Path: <linux-kernel+bounces-275415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DC948555
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB91B22A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5F16DED9;
	Mon,  5 Aug 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="HGhuwseE"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6016C696
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895957; cv=none; b=L+ypCQqZF4vRjprc+tI5DQmiRMWl3WCyCLxRsfVFVIm1mc2D0dkDhYM5Cka5Mj4FSujM61hyIvmZhj/acEqZpyMBo8DZIOYEM8O08gr+hrvcTsmfsHZ0vI9tOoaZKcTWskav20ApRxRTxOY4IDKm0MYP76X4+odDjzjp+t2+2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895957; c=relaxed/simple;
	bh=GMMQ/BSSoja6QdzkOekqjoODSmfp1vm+ibzeOFuYkao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifNZmtiDd968SwSWyPPamWhxFbIxvSMY40n3yKBr9bnrt6wGZIG4MkY8qm0ucYYiOoWY+kiGrgPX5DLHdpfujm9dbIwo5N0V76ShVxsrnJIxyo7BHfhHZngocleUNA49vozmEUAPvW78mEbgpMOxr8q+hc984UDCI0tZrCHXy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=HGhuwseE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso325731fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722895953; x=1723500753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjktkTxw/Pi+sq69hQv/6e2Ff6RBaiaqpdpd0sush00=;
        b=HGhuwseEm9/CYF+OrEExQ8aUOWBcveUkaVLpJt8v36yEa/FHSUaeTFr7eVeG5NUfDb
         sXwUHDlaLiZG0uYxxIHl9Y9LP+LSOJsZAjgaHgZ14wCW7ILupd1JaLxfnLfebTOPXgty
         MC0si0m9F2T89RXQNoAZZKCquSnnEFoYizqXcVd7AVDhh7lhjwG1FAe79RkqMLPZNrYf
         YUXk7npWr3QvZlM+H41kYskMX5XZV/rD/NCzO3Cz+Rrw1lRX+aeMmMn45MmIrViEAJYU
         IufUFSeDwjCZgjhN1+w9yNTCd20SiZbTqWoXGKRbciNxIXPUqtiTcETwkK2xUxfbiWPs
         zp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895953; x=1723500753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjktkTxw/Pi+sq69hQv/6e2Ff6RBaiaqpdpd0sush00=;
        b=FKFre9isMD2/Jmh4x+V/Z5wJzrzteNdRalRBLITkrwimeXuHi00/MhCC8lPFvE3oZC
         mBDo7Q549pWtTaf7cwNCzlLeGf+9/eY+L+q7NohEcMHQf4qeGAlm+SVaIOSKIyCkW/tj
         2R554ExLyiVCGfx55g+k16AdaavhvPNGBU5/nQnayDH+0AB4om2eAQI5c1tuQoy9yzua
         RQYEO/q3bDE8LnMT8XWs6TneUpho7DNXdKrK5LFrJuWl6giOBM3qLXdF2jYYFO52B1t4
         awHrvUusq9Pn5hfpc2vjtBXP7++TO5nc0NEn27mfKJzgF8kGUaXAdPmPe1FJNQ/Ysdr9
         EfLg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdg1K+pyPKSZmzKqRMTTxDO6N4fR1F2PoI9xdTbSIcop8AcwVuEONQDx4SuM/jDdn7vvzSDlEnZFMsqj7KUDXbSXA4vAoXNVOKGTz
X-Gm-Message-State: AOJu0Yy0D8xQsD23aJKgE2TxOe5pC1bvaeEth0TnDp+n9Y2ZKYsLCKd6
	YXryOvlqtM+3VsWGc25wB/AS3Txkr92VsIEfRKYsQ7U3XdQdfmXhBEape1gTAmY=
X-Google-Smtp-Source: AGHT+IFs0Uy29mB1j2MnwxM05txW4e7pmKV5MgDq485zBDkbVZk2z/Q53EtTBT/oEK9MOwwMhGcJrQ==
X-Received: by 2002:a2e:98cd:0:b0:2ef:23ec:9356 with SMTP id 38308e7fff4ca-2f15aa870dfmr86996511fa.8.1722895953040;
        Mon, 05 Aug 2024 15:12:33 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428fecea453sm12355e9.1.2024.08.05.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:12:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] crypto: chacha20poly1305 - Annotate struct chachapoly_ctx with __counted_by()
Date: Tue,  6 Aug 2024 00:11:30 +0200
Message-ID: <20240805221129.2644-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
salt to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Drop using struct_size_t() as suggested by Eric Biggers and Kees Cook
- Link to v1: https://lore.kernel.org/linux-kernel/20240805175237.63098-2-thorsten.blum@toblux.com/
---
 crypto/chacha20poly1305.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
index 9e4651330852..d740849f1c19 100644
--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -27,7 +27,7 @@ struct chachapoly_ctx {
 	struct crypto_ahash *poly;
 	/* key bytes we use for the ChaCha20 IV */
 	unsigned int saltlen;
-	u8 salt[];
+	u8 salt[] __counted_by(saltlen);
 };
 
 struct poly_req {
-- 
2.45.2


