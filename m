Return-Path: <linux-kernel+bounces-322449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBA97291F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD151F252D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A317B4FE;
	Tue, 10 Sep 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygb64N7Q"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E6170A22
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947830; cv=none; b=Bd6ciG0fvTr3tVWuB8wfvUFwzPMCpife6h4i1hHKrYjnYbAsR3E7AdzZJz8qxSYFN2djqOe31i8v5pWPP+EYzisYBWvfg07twviGENXajllekd3ueCTbzJaaAKuUMm4CLK8hhcZRDywz8Kkym3CrMMvC68DyLuyfvmjERbCUhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947830; c=relaxed/simple;
	bh=harbIYjXIZwZ3f9EI2mZbHpqQsWOwp5H5uP9TKWqfmY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHWkOvTBTqTGXDLIuD5pJ13TAkFz6IRYi/G2qfkWgL1mzUyw19L1b0uIQ4h1YDNGP2wmVpbVQtIq0Nfmka03wYh8TxGqeAhUyPbE4uIgUju/o2moY45ch/NenQmFOpIONafzaswP3VTMIJRlGd76dz3GtnaUUilWtQ80ORgPp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygb64N7Q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso5151675a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947827; x=1726552627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkRMGz03AT/YTFzfsR/jm+HeaG3fV/KjabHJTPqNwHA=;
        b=Ygb64N7QgWVk/trjPMHI/JYVfisY11kVKCnQjhYBJqhMBvRdbYU8Ahzl68a3xwtwQc
         Wr6Oxiidwb/KHoWrmNRZPs8Z6+mpb4k/jBm8pyKaDBz0B4u3eBM80ZMj1OgT1COCSaPR
         R8v0WyYhonGEmS0KtwlvbQ4Lnpsd9aufV24tek4LqKFuV2CdWYlJcrxraCDOYc1bs+Sv
         wRJrYaRV8DJn+Z6fLMcspbJGxNsWbuoagTSjkWdAbeUmpZTxls0AsVywnem/5pc1NKKD
         HfeBhbuDagUr52/ScClIQBtpSMIcgcFMEl3DcmdXPOU3uMhYfXxxUQ/JErmT5IuhQ6zs
         JWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947827; x=1726552627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkRMGz03AT/YTFzfsR/jm+HeaG3fV/KjabHJTPqNwHA=;
        b=AAhnAi/W8NzGgs4Fw7pewy5GVuXg2edXP9xsNdb2+e5ZimPHsyRwFHXZzb1l0khyKL
         qsjY/v+4IPk2r3bF+oCH3mMzXoXaeKV5rbF5W0fQkJ1aXWbY0QFvOx+3icmrO7D1eZ9S
         oUXl0uTwweLEjUkV2t6r7y/iciYGYOhbWiRnK8zb6ngycaS9OY3vEQvFOh2TBNxDmfD6
         XvxYhObsQ/RdTBl76r0GL5jkO5g5sAOATUBUwt8kAvwSTTkanwdiz/3awxRId23COcd1
         OuE0UV52JDiWceQXmDIcp74odK8TSDim8kFYrBRNasiw4wHTyDOBRSxYCbSMm7DbG2Zw
         sWKA==
X-Forwarded-Encrypted: i=1; AJvYcCWri5ap4uG6pqckd2pcOKmhEoWoBdoMq3oZsgoP8NXVp9EmUWh+lHU5fr80ILrNT8UTW2zAkstQ5sQ7aEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUPnox6vXZzNPFYpu3Zl1Zjigo7ZS7DFk4EtrrqpoCqHQygTh
	tBU0PV7LmCCuImUaUnTgU31myOLpxzVMRPCrGRI0FOwu6fhSi2Sg
X-Google-Smtp-Source: AGHT+IELoHCk2IUFrT/OdX5Le88nXVMstZNV1Q3L4CqyFVIMScSVaRJU0d8a2Tkg2j9qkRsHdOuEQA==
X-Received: by 2002:a05:6402:35c4:b0:5be:e01c:6b5c with SMTP id 4fb4d7f45d1cf-5c3eabff535mr5954007a12.4.1725947827522;
        Mon, 09 Sep 2024 22:57:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd468fesm3851492a12.39.2024.09.09.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:07 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:05 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8723bs: Remove unused function rf_reg_dump
Message-ID: <b66d915668366258523095adf388acef945dc0fa.1725826273.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rf_reg_dump.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 11 -----------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 5354fdd11c9b..33d27680a276 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -55,14 +55,3 @@ static void dump_4_rf_regs(struct adapter *adapter, int path, int offset)
 	netdev_dbg(adapter->pnetdev, "0x%02x 0x%08x 0x%08x 0x%08x 0x%08x\n",
 		   i, reg[0], reg[1], reg[2], reg[3]);
 }
-
-void rf_reg_dump(struct adapter *adapter)
-{
-	int i, path = 0;
-
-	netdev_dbg(adapter->pnetdev, "======= RF REG =======\n");
-
-	netdev_dbg(adapter->pnetdev, "RF_Path(%x)\n", path);
-	for (i = 0; i < 0x100; i++)
-		dump_4_rf_regs(adapter, path, i);
-}
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7f96ff66915f..f70da9cc66f8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -9,6 +9,5 @@
 
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
-void rf_reg_dump(struct adapter *adapter);
 
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.46.0


