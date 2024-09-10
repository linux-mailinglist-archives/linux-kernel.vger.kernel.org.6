Return-Path: <linux-kernel+bounces-322452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CEA972922
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D7B24461
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BC176252;
	Tue, 10 Sep 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/K/drWs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45916DEA7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947862; cv=none; b=pnFRcO91J5E1dkJ67jqquyqojekXy+ZxEuvArkXsYBW4VVvj8zUl/YSR6Xorw0BekQVEYjR1yeHyhvlbqxH8+OStmMSQMocgDW0IxsrISlD87Bg135rCWasZYiTp4fz2HrAF4Hcj/Fcfn32neE4W873NZWq3hUBDYZ/sk0px/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947862; c=relaxed/simple;
	bh=88MdzK35pF009HwgTk+vpadotNtn2mweeut5kECOrTU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKN494jpQYGvVeiZHNiFMo79rYWxhPJr+wMQi5eIDYK4gGBry4orBaPSOXyL5cQez6SjUCm2l7UkG0z/RpYnVEuNth1m3r36HgGE7t123WAWZqiJfLQtXydTsXkF4Y+Pil/fQk64RF8BdZtccjmCNpN0k00zLYCKfs4Lepx29u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/K/drWs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4979b843so308061166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947859; x=1726552659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qZhPDdZQMhy2lcFy03oOkPowW/yGJnrN+PDGUtF53A=;
        b=P/K/drWsZjDiCKMPQnralsKP8SaoRFb/92LSevIHw6FfT9SGnAoNV3JIqFsWxcgWoD
         M9JF7yODTRkSjDGVt7fNeG+GXiLEFSfRGLsAXk6KXUk5VbbYewA2n9ZFHQMdXZYasg5x
         QXYSYWHVI/VC2zjsMYnrlhK4C5vmTRVABEyj63o6dvpgusZPCn2CjoKfgoBJnh8EkF6R
         qtpHmWD2UylyCEEpBecE19G18XH+HSOBh7/vi8mimGIoAftGJUlbUlDZNGy8FWlvUoZc
         5LCeoxuWWo4OeQkd0JQAUZWQ4X04Odz2vXLA2lioZtpdf0iFfxNFer0/8pZu/CTcOrB9
         9vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947859; x=1726552659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qZhPDdZQMhy2lcFy03oOkPowW/yGJnrN+PDGUtF53A=;
        b=AKquXJcwdtcObzVGSZ7ZDlYCCwb0LtX6nAboa6p6ewmGOnHsPCLJu8zbHn1PETEYog
         jiAFt4Prx+gbjoNhMHrQuBI7OO5OUPyB0qENQJUNqf5Oaxi6Lfa8372drGC1U05AQ5BI
         NcbkeUP+D/EPVyAlXhWQSFX3jBLTGQTGXwnSPEipgWKtsSdWpB+UR4F/BmCCyNNb2ajj
         U48SgVOtOGUexmUkLBYUvmSbNR5qEm5hqPAm+7e1zsdJQiVP8mYpKgjECrxK2KOu3RkF
         vus36bw7NVRz7TS60f95lQsxWqVBw0Gof2WtycvxZd3BcuPMdaVMAmx0jbhSzRpA+6ke
         n5rg==
X-Forwarded-Encrypted: i=1; AJvYcCV+H8SkHfzwBhMcYRMqRQ4mRHpYIxEHngsRRIqzFNe8nGJrPA6INkmBjibgqs1vAb4VODYOC9ItfFfTAFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5C1cExBD95S0JffJCqAGaKGFmFMVUmJvg+u7MtKnq3vQ3+WgG
	C+bd/RUHDIH6nZmDF22ZRDLU3nJCZ0DxlmG98FqYWHksl27QL3gU
X-Google-Smtp-Source: AGHT+IFxP7HYZREKwbvwJ28zJ8beb/6B356d4GuWn2Cr0EUFv/Zb6zwv3IHC7ygQmOWDa/AnGqjKAg==
X-Received: by 2002:a17:907:5cd:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a8a885fb74dmr1484410066b.14.1725947859185;
        Mon, 09 Sep 2024 22:57:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e7fsm431020066b.109.2024.09.09.22.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:37 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8723bs: Remove unused function mac_reg_dump
Message-ID: <80e89052b30d8c495f375e43fc4c1deeea75a624.1725826273.git.philipp.g.hortmann@gmail.com>
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

Remove unused function mac_reg_dump.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 10 ----------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index e5a4baf1b78b..bfce632e037e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -22,13 +22,3 @@ static void dump_4_regs(struct adapter *adapter, int offset)
 	netdev_dbg(adapter->pnetdev, "0x%03x 0x%08x 0x%08x 0x%08x 0x%08x\n",
 		   i, reg[0], reg[1], reg[2], reg[3]);
 }
-
-void mac_reg_dump(struct adapter *adapter)
-{
-	int i;
-
-	netdev_dbg(adapter->pnetdev, "======= MAC REG =======\n");
-
-	for (i = 0x0; i < 0x800; i += 4)
-		dump_4_regs(adapter, i);
-}
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 9948fd0f7e91..c417a26de166 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,6 +7,4 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-void mac_reg_dump(struct adapter *adapter);
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.46.0


