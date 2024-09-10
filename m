Return-Path: <linux-kernel+bounces-322451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275B972921
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E011C225B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A7176AD0;
	Tue, 10 Sep 2024 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsCiOGZ/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3C17332A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947851; cv=none; b=aNxG0hTurE/ic54SuC8nkacA6zVMES3onuXP5AG5sQBi0C5s4S02lyn+W9cjWlxR8XvggLIUT/kz+2ZkD/vMzDdS2UX1esD/7PX2snkcNRrYGCLCwOfFpHdfuOqfYOZtTJCVr87IGtTs3msP57amPMWw7e+61900L9Tc+v3Ymjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947851; c=relaxed/simple;
	bh=rFTsmu66W2cqMwlMZm+VZUMWyz1m8yIGCc3H6gMc4sQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxQFBtHv6aK0cGe8sCor/K6Uk3pUzevG8jIntAN8M9ELHpGy7NwoaYI5IqplDdhPO4FZqcD2zaUcoAc58I+IyuG75TZBzZUpXw+38IbyvnO+/B+WijZy+U7h5udc65kTglYLr6h7bHbmaRM0WC6YgDZHLiCy4sgu3fjfScayCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsCiOGZ/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so5708779a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947849; x=1726552649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JenHvR0jRUJvf+xKQyKoB5pvp6Qm0Xj5l28apEXo82Y=;
        b=bsCiOGZ/mNZJybxaUL2czbOyrGiNm6//ihug7fVnH9ubVoVEjWfXd7/9cFi7bv9z+r
         UdIcWCIw+hjwgsCH4wjZXGWOckaPGwJDWbXGRYZ5Tw6lJZ9k7greu4dp2p07eagJWsKC
         08U0g8ZEuGc4SNsLoXG+AfWmLeDVZRNG/q8PWqOubUQXSpSKGorzASauzXKn5FOjhORD
         Kx9pcdKeae+R0btCwMt9hs6pvVkgGE4z8YXrHTq7cCEcgNIDpyrvo4rfQiz4RcI2aHSK
         Bn+cSOD6d0+FAM1a+A2gCAAGtyXUNwNYshsGOwS0iRLpKqwEKXvNNeqlEzRfWgUpZNQb
         M87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947849; x=1726552649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JenHvR0jRUJvf+xKQyKoB5pvp6Qm0Xj5l28apEXo82Y=;
        b=DZR9OgtVrQ2NK86M9Vhc+HvKUifmjim2mwhydbmOzRxLY0lEWLk0CT6u9x1VHrsuYt
         7iXlsTYu8lNvLNfM9BMfGisie8B75/CENLRYNXGO7NA7ejbPaTIuNJyrGQFdyNpstQNr
         j0xDri9tKuysMgVEHCCR11/6fIN2W8L7KLEAeBhhzkidzYdOgeS9bu+qeNO57fZ43USm
         /2YuwaaTdaVZykuDOMivRddkRDZt84L4skwq5TKhNpMT96LfzbJWVbXh9xKwOJ/BzYQH
         neGN0JLTQoHZ2hFPD83C88i977ll26P0WgzbqEmxmbQDN3bDto5xqPPnmBHQ5IhyZ9LD
         8cbA==
X-Forwarded-Encrypted: i=1; AJvYcCWkUD6gbNfaK2U6GgNJ8B6vuLEHPtH4aNCx9u92wdCN9VnvVOfYNH5fq6f7VQ8hZ5o2RgHnVkRsMufGBMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqcQlGePWRJSRqg5fz16VsxjKEnb16KgyVYXMmgJoN8qC1ZZr
	QhtGYA0XjXG546EG3JhINa9DhVNZpNu/42QPQFyrA9ltupRJoce759I0n5+O
X-Google-Smtp-Source: AGHT+IHIMKip8upzlZGqt7QrER3Dr1PwTFF7DwidiZZOaZeCbrp21Lq2EdYqhnyTfvtp91TXDHgY4Q==
X-Received: by 2002:a17:907:782:b0:a7a:acae:3415 with SMTP id a640c23a62f3a-a8a885c3a7bmr1105740966b.10.1725947848806;
        Mon, 09 Sep 2024 22:57:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2592647esm432513666b.48.2024.09.09.22.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:28 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:27 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8723bs: Remove unused function bb_reg_dump
Message-ID: <e0372c46a62df20ecce9a9e66846cbd3484eb85d.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function bb_reg_dump.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 10 ----------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 0edd7b6e4f21..e5a4baf1b78b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -32,13 +32,3 @@ void mac_reg_dump(struct adapter *adapter)
 	for (i = 0x0; i < 0x800; i += 4)
 		dump_4_regs(adapter, i);
 }
-
-void bb_reg_dump(struct adapter *adapter)
-{
-	int i;
-
-	netdev_dbg(adapter->pnetdev, "======= BB REG =======\n");
-
-	for (i = 0x800; i < 0x1000 ; i += 4)
-		dump_4_regs(adapter, i);
-}
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index f70da9cc66f8..9948fd0f7e91 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -8,6 +8,5 @@
 #define __RTW_DEBUG_H__
 
 void mac_reg_dump(struct adapter *adapter);
-void bb_reg_dump(struct adapter *adapter);
 
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.46.0


