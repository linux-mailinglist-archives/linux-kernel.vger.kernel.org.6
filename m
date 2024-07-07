Return-Path: <linux-kernel+bounces-243496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678C9296E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02983B213D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F545E54C;
	Sun,  7 Jul 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOIq+nqi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB2CA62
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335172; cv=none; b=dKbu0LYPwlHSGTZQ5jZQWpWHJlR63Bu11FyyWJmXPSTifzeAMVb2iDpLeOT4dX8yL+UVQXQ82iAjfwVQrqn/9F9HjgoGMngjruVwS0WlBzeZDwS0l4mwXvRnQ+ACetiZ39WyN/9SAJGHfilDDeJKNBD23jitUFjfPlVGuBlkLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335172; c=relaxed/simple;
	bh=eTcdbviIPXnaBScX/lCwCkx4UwxG0OeM942lVs5Y1aA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar5XYd2i5PPPchhLQKm9HLAkKRt7BsZcCFaxA/0Xhu0GXh5W9huUJYz4xCBvyE4XdrdHCa0Zv9DNL195dtUGczzvjNhMc2c5bVGx1fKmm7hkeyjAMZJM+17ju5dTTaug93HiZW+O/lq+uh+r+822QNPkx3NLfH8iModWEl++Ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOIq+nqi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-426659ff58bso323105e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335170; x=1720939970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGTpNzNmztcyPOmCQQUHGh9qBBEQhne1jUpgHqVUc4=;
        b=fOIq+nqih1muse871PKVaHtDAPbzPtbThQmgWv2iAYzxpKRwzFNTEA3Ixi0s9M1sfT
         1x2LZC8pGsShga5HFDbDv7k0Wj0Y1f4SHebSpOOaoPnm+r/eto49rgo77xjX39ybPZ3J
         gXlZtb0KkpPn8bBzMa9SfTJcwKhb0r1KDSiCmfS5eRACpT41A/veCcqH1LHJKuzA0LuY
         hUS4BrAnD3MyAxiHlg8GwMXvnssB1tpEY3Ui350RDdsqCyfk3y4Oonx9slamitvel4aM
         qjfykR3jpqcR1azn7l3cXS38j5HiylHZ7aurxDflHawI78PusDBUDvijuoEYtFT36Gz2
         MP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335170; x=1720939970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilGTpNzNmztcyPOmCQQUHGh9qBBEQhne1jUpgHqVUc4=;
        b=UqtVWfDJwXXsmNd/6des740GPpDJbI2ZwRg49jNaN4nlaAfMZ033yNX820RAnfZ9R7
         qR22gqIiiVzQcr4JTXt73rBNHq0l5UKbJQDcpzD5Oe1BUunJGlws12qw1vQnG9mq6qRl
         VxydK71jMWB9TlDj6mhqmqhQ8pZsClSx+x6KUL+YovJoylADFlXmUfKDkLJVx1Zl1Pxr
         eswKMFaRJ8Pu6xjZWqwTpd2ntnZxbqJa/R5BQ/zXjtyvZJU2jrcKPmkWftxedkKRPxbe
         hq+NGtvPZKFXQGGuBG/CCs1q2eGPjPLRC++bprysM9tMtHma06oyAYbmrJqG/hjQlcab
         eXMA==
X-Forwarded-Encrypted: i=1; AJvYcCV6S8ZeCO4PjQaMIi6CJEzMGqX9SJiL3kM3sUfg7rGis0ZUiL/AX/TddFuCyErLPXk1EurL0uEjE6Y+X3CpMReRtRySsgv9/i/nRJ1W
X-Gm-Message-State: AOJu0YwEC998DU+sdit5BBmjUUbbfTstbVq/kdv9U9aZ/JRbiXeTJjU/
	Z9u/S0bx8rAFJwXsSn8QBrZRifq/MExNdlFErDDRfU2CrnT12mld
X-Google-Smtp-Source: AGHT+IExqykmCMe6GXQZ7zesU7eaEDbMJuHK4G7VD3P5t8/8k+npWYx4FTyVgA1r/OC/yRGdjBMOnw==
X-Received: by 2002:a05:600c:4f03:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-4266358805emr10599065e9.4.1720335169931;
        Sat, 06 Jul 2024 23:52:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367b164799csm4214321f8f.56.2024.07.06.23.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:52:49 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:52:47 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] staging: rtl8723bs: Move last macro from
 hal_phy_reg_8723b.h
Message-ID: <7e1e5591af85a452415fb137767e21d0d1d163a1.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Move last macro from hal_phy_reg_8723b.h to Hal8192CPhyReg.h to prepare
removal of hal_phy_reg_8723b.h.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h    | 1 +
 drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
index 586a3dabc5ca..292c18b62537 100644
--- a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
+++ b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
@@ -1108,5 +1108,6 @@
 
 /*--------------------------Define Parameters-------------------------------*/
 
+#define rDPDT_control				0x92c
 
 #endif	/* __INC_HAL8192SPHYREG_H */
diff --git a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
index 0791b85b7c57..da549b773243 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
@@ -9,10 +9,5 @@
 
 #include <Hal8192CPhyReg.h>
 
-/*  BB Register Definition */
-/*  */
-/*  4. Page9(0x900) */
-/*  */
-#define rDPDT_control				0x92c
 
 #endif
-- 
2.45.2


