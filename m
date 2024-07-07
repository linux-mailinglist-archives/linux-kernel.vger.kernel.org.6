Return-Path: <linux-kernel+bounces-243503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02E9296EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C543281ADE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA815D27E;
	Sun,  7 Jul 2024 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTNJ9uFH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B1AD4B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335283; cv=none; b=TpOETHFLvJFZOOfcfeVfQvN8YzKKmceysQuop6wyPnw4qkcGlk/F5AIZIS2A8DO3N5V0yKQ2gZYS1Qkl7jx9bJAVHUf+hut4M2mNbZCdKtb014i/BNR8TXuoQ0IedmRudRKB/oqZpI8uOZwMNEIo4tqFbqCsUoA+GEQrtIucvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335283; c=relaxed/simple;
	bh=fl5JDEwJz6N1kP/kziK/6oStTJRXgZqlJ4YZD7FPgcA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnIMlzq57/Yz0zvgBFFS/llr64XheKCQsWAgnnwk1U4lt8JHSw3gGEbojs/wCBzTp2bzkragyOiamYGIRm46RFLM5D83hVAFvKJG00TeLvhoDvJM4+4WOr5OxytCgYMaRVbL8/F3StRVlcOanFaK9oyFapHEEauzz3qRu+VNBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTNJ9uFH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426607d4eb7so881755e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335280; x=1720940080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wa19O5pYQt2ewjnjIco7NcYsEERZusPgocEP5T3ISE=;
        b=OTNJ9uFHTxXclPhPIv8tz4Td1a/ZQOoeptLftv5i7xmP5jGxZD8O4bYk0wQmR1HMi/
         QXhwUinjUXgCdtF+3bqxitAQeKQqVHyBjJc85jwfB8SRfqtw6hnKwcFnCyrh0qTv/D9T
         zceCAdySje8Ssd9NckSG9w4BL4YLme+Vi+8r/zx/AaopQpvfnZa1jKyayO3yJpXO0KED
         nwybobI50mxmniG6UD1a1tiwuYAIerYygRd31ZpDqZqwnggIE4r9y5vAs0twJWw1UNsL
         Gh+6jUIVxmobV8kqlpJLJYskmLfvc9ZqdXK3somb5/hGTnRiIAkqdWWalug42RLO40W2
         BTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335280; x=1720940080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wa19O5pYQt2ewjnjIco7NcYsEERZusPgocEP5T3ISE=;
        b=VdSyb/SM4I1Ch27/b2sPd/eVUsgrFDKSfGwrpJgpbDmDxY39Q50H3GT4cT6rkdjjrs
         5MzkumM+eHsLwmmK789c7A/QZ4hOsyghUDe48XmshhfevE8lmTWI/rxbQ74++Amy1Vou
         0E63ef8rh/gK+MHwdDPozFd0ukUnxk3vrlHP9mk7ER5EkOHAHDqyooJR8XtchD98fjEe
         8xJ8Neo8JZ7mQWWpCJMh8BN6KcDwIoJ0QkOI/jSp5pFBIro78RO+bhDXFkS1gPXQl3H6
         QRzF76cVTKNDoY7kMC0VoH2pZSQhS2fnW0NiSOG65jWdmv+QYrLhtNyge8AdILMFvwKv
         /9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoRt7HO0/GTXFe3x6QxenO9xEey3iXyhPutZkBPvtO5RZEpbxPZtDrE9u8PY/y5CTa4h0Af07HbfbzKkieZgP2XV068Xb2vfj3RXty
X-Gm-Message-State: AOJu0YzDbRCEX2OVbPVe2DYOo/nwqCC/QepYRBCecKRjxFcEFclDA1mX
	dePlIEnKUarpy/W+YEta7Hb+6++OoLU3xemvzzhJ0cP60X2KgDuU
X-Google-Smtp-Source: AGHT+IFZEFK5H9qIKoi9/OUccxTTbshTz8ItyAVXK597dCah3k1qm+x1YCXH72JiXf+cgUyN2PSzaA==
X-Received: by 2002:a05:6000:1788:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-3679dd73a60mr6145353f8f.6.1720335279920;
        Sat, 06 Jul 2024 23:54:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1ee57d8sm6986005f8f.47.2024.07.06.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:54:39 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:54:37 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] staging: rtl8723bs: Remove unused macros in rtw_efuse.h
Message-ID: <dda48a640142abbddb846bddf656ac5adada2971.1720245061.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_efuse.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 5938a6bfb573..0cb8c6f6d34d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -7,19 +7,6 @@
 #ifndef __RTW_EFUSE_H__
 #define __RTW_EFUSE_H__
 
-
-#define	EFUSE_ERROE_HANDLE		1
-
-#define	PG_STATE_HEADER			0x01
-#define	PG_STATE_WORD_0		0x02
-#define	PG_STATE_WORD_1		0x04
-#define	PG_STATE_WORD_2		0x08
-#define	PG_STATE_WORD_3		0x10
-#define	PG_STATE_DATA			0x20
-
-#define	PG_SWBYTE_H			0x01
-#define	PG_SWBYTE_L			0x02
-
 #define	PGPKT_DATA_SIZE		8
 
 #define	EFUSE_WIFI				0
-- 
2.45.2


