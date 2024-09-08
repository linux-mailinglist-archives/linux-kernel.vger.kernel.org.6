Return-Path: <linux-kernel+bounces-320382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F13897097B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B131F21488
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955418785D;
	Sun,  8 Sep 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RguVAjEY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C95183CDB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823608; cv=none; b=uSJqdmTwV4kLLxvn2/Kry0z54Il9zCK/Ggb4Sl70LKLNO1BXZptY+AF4lUUOTXGQZgwcdVxUXIEx8m5oZuEE88w5zuBoFqw+vkRTM8ZELOtMC4InzNEnOAtWvRY23xH2rUsuXIX/gQojasD34pt1MSscLvLWyhXJ/tTo7rDKuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823608; c=relaxed/simple;
	bh=GNDbS0umag34Ow3QhNqy860zt7/gRMadMUGvB79LHYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvLhiVQBcfSEZ+wignWBKsZ+/ZP5KhiWuJknjMsPOQvmZfv7A7FkggR2qIsfYfVarulbCD9KsRsiLHpwSaFPqTTBpo9p6qRJO4q9PPQF1cW3oGkQapzC3urHc+7C2Gg2g2DcKfvGo4TrtnA783XP4GL+43a7Sa4rpSHOgqsCSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RguVAjEY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2054feabfc3so31164535ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823606; x=1726428406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqCCIR0Jh0d9TyP+sguj0pDsMoKfiPe8e6/V/reMWic=;
        b=RguVAjEYHd/7hNTASr46l2d5X+SGRvRrqNxe4rGKhdixnjhY1mk9+E2hnxZymplW4i
         vMITc/JzG4gAmq6iEVWlFgZ6NOQVnst/OEdTcnxK8skq4xpL+9fvE5eu4bx29F/X1fTF
         sweL6QEVV0FVHZPNwtoIhWYMWqhHR5BRlYmQhrovQmojRPuUoUqwyR6YWgx2eb1X9lbS
         /wYsQ1LwVv308pTcdZdLLWccDdVVmlb0ThfVX3RC+NHlZcSpvAVdRpw3W3YkNCnopjbU
         BskLeIrBczq7RYfwJhkJEXd3KjOIYATAVXBuBykZ9R4I5GUhRN8AA9iJ0g9UvRbVcyjN
         6UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823606; x=1726428406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqCCIR0Jh0d9TyP+sguj0pDsMoKfiPe8e6/V/reMWic=;
        b=X43b7WxoNWsYJrFpzBz8A84UJvLGU3/IWK5wRHu3KjqqEUYkxAHeuhAc/DX72yjBn0
         P4D3PiMMkr8y6psXriWDEvJN/pn16Hik41mr+TeernszR56Ot8BgoNKA5Z/QnRTF7TxE
         +WoaE7VcjKuReJXSDjOA7jZlx00bW7jKoSpW4nDjPBng1aOPYVF8dzwK1QuQ7+12ra+H
         vQNBXqweeLU2+kO3Zv+n7sKwvyu4/JAM+542rUTnBwdTbbZnx2KPv4jt/0esKa/MIG6E
         Y1xxyKRf00l2xBWFrMwVBFFrnPa3ZICggAMVBPZqQT3+nSjT5GFtSyTFAR83aHv7daMk
         tQUA==
X-Forwarded-Encrypted: i=1; AJvYcCVatvo/ljI3Nb2FXMuvxN/xXds1V0WJeliEySPfxJy38mQBuRlVbaEYNiT54FQ9F5f35LRaa0c2IbTTY2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbBP+6FmIZgPW1RPNiCaFHXfJ85wX6Lg6elNmNnPgMjRxICmm
	Bymf7TEzCWCyW0TNn+/fLduCSRSeasTaGKxji518JdbyOPXi/i+S1+21TOIu3z8=
X-Google-Smtp-Source: AGHT+IFf+CJ+L/oMeqQ3S4xbOCAFT6SydeZF6Pq1lh9SCPpH4CJrBlA3KlPQrllXs236WcvdDi8ryQ==
X-Received: by 2002:a17:902:e543:b0:1fd:8c25:415d with SMTP id d9443c01a7336-206f058c6bbmr148199455ad.36.1725823606155;
        Sun, 08 Sep 2024 12:26:46 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:45 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/16] Staging: rtl8192e: Rename variable isEncrypt
Date: Sun,  8 Sep 2024 12:26:29 -0700
Message-Id: <20240908192633.94144-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable isEncrypt to is_encrypt
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 76792268629d..5ff3fab72589 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1726,7 +1726,7 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 void ht_update_default_setting(struct rtllib_device *ieee);
 void ht_construct_capability_element(struct rtllib_device *ieee,
 				  u8 *pos_ht_cap, u8 *len,
-				  u8 isEncrypt, bool assoc);
+				  u8 is_encrypt, bool assoc);
 void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
-- 
2.30.2


