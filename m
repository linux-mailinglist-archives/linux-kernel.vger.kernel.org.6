Return-Path: <linux-kernel+bounces-243501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214AE9296E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC1281A65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20DFBEA;
	Sun,  7 Jul 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfkU9jnG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D5101CA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335246; cv=none; b=YpoUi4notRhr5MYfCaN841HpKt5WPH1HW8RYiDuwLUej67JUPAuB6qdM39tmaLC7fwd8YVoPwZHI/uORG6xQSi+W479DZWFibXQEsUoUKI3SEYiLZHfp1/nX9tCYCg/gYfaeizagQlxgr8n/xq7VbdrAC7vbGN1DTQ4v6DOFY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335246; c=relaxed/simple;
	bh=vzhS4eOdB3JVBmGj6GZR41u0035kWUjZHf2QmYjBHj0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOh0V6OFEuO2zTxsHAm8q/qg7+o02orv1xK+MOgySoAXVFf45rHLJSuSxSyJ0BRFojYddyvFj+LX62YMu6utiZ9UOpInE4de2JunPyNihhRlyaFd78hboth98inl7cnkvdT3sP/BgRyLKPGxbv71MDvs5rWnMmsbRK+JfI7qV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfkU9jnG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4265dd11476so1415575e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335243; x=1720940043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L17bu5yX3ssgKrMTsiZwMgl58vpmJ1s2WNn54DauvtI=;
        b=GfkU9jnGK6Q5aeYF3VTDdEd2JbfhN7AOMO7QESGe5nasd+x8Nb82Ekd8mjerrH0OVD
         tQ6pgk5RP0/AUjPfkQAHHzybn3IfCKp587MPxantzJnV49drrPHRjbgHJ24rVOU1VJM+
         NyeWQp7ThAtY0rCsP1CkPuK/BD5/2gmQEbfO48Toxh19m7SOCq2BwNRdVbIN5593K/rZ
         TNy3F+k4Tf37xUX6m/TlC+45QaC7OvesPuaF8wHJMEDYMI3U3L6R/sQYByiwgZChkvGo
         SfAMZgBRyChujXVvKzJNxz3UPKj+xb1DA1VaX4QMP0YxDjWXH9+EudF2nOubyIsAVNZJ
         52IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335243; x=1720940043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L17bu5yX3ssgKrMTsiZwMgl58vpmJ1s2WNn54DauvtI=;
        b=i8d410BVeTcKrWjSLICfVV5pPdAhy99uSyTyORzcsmTnUNbxbPKtfaSDgKfGLJW2Zs
         ciijs0Hvn4F1wRXipT0jeny3X/Z6W6N2I2nco7CmkFHgB+hXi4Xl490jbtMhScGzsoOR
         XcK72OtUEXy1sYM/gXqlbeDfHNRhqOMm7bo8mW6dEVvIBeWkZL0S6nrwFvXAwAQTBiyK
         M1+ZkV0G+QStj2rieXoWtZLYLXwi3A976n63QIiMkWCytx1xhqakxIy0SX73p1GJFJuw
         cDmAI7TPEP9fRkT2ruNk7TuwVS3p97L4p6QMfvhhsQWziYaubRpc6Yq1BhWSXlAW+pRf
         ZX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBKNBg92+ADVrMK2S3QobrUCe7Nok8EJwkhJY3jNDi8t9dUM7Do8zPLYnqWn6BEZXQ0Y7hXVTCcb2P75c8aLDGWOKI25OsiShvjS1g
X-Gm-Message-State: AOJu0YyoobG5pLrh6ikW3VzyK4eJ1fim+wme4Dn9e5nAQ3cqRVlezwGT
	Yldp8OU0rPIyBCF1Qd/WiOdI6CB/CG1X3QiEDCkgaoAVpGoG3BXJcKAa3w==
X-Google-Smtp-Source: AGHT+IEQVNF8CLloFDHw1LG1lFShBIaHRdILEu+du4X3fMXKOpjm5yvzkkVqU6oMCYCFgqaXvqKjoQ==
X-Received: by 2002:a05:600c:4c0a:b0:426:5fd1:281 with SMTP id 5b1f17b1804b1-4265fd10561mr19771895e9.1.1720335242564;
        Sat, 06 Jul 2024 23:54:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42662a21066sm29644725e9.22.2024.07.06.23.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:54:01 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:54:00 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] staging: rtl8723bs: Remove unused macros in
 HalPwrSeqCmd.h
Message-ID: <ac52d73666090a70e8c1edc87e511f1ea2c139e4.1720245061.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h b/drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h
index e30071935d27..b81252d374ef 100644
--- a/drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h
+++ b/drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h
@@ -49,8 +49,6 @@
 /*---------------------------------------------*/
    /*  define the base address of each block */
 #define PWR_BASEADDR_MAC		0x00
-#define PWR_BASEADDR_USB		0x01
-#define PWR_BASEADDR_PCIE		0x02
 #define PWR_BASEADDR_SDIO		0x03
 
 /*---------------------------------------------*/
@@ -64,21 +62,12 @@
 /*---------------------------------------------*/
 /* 3 The value of fab_msk: 4 bits */
 /*---------------------------------------------*/
-#define	PWR_FAB_TSMC_MSK		BIT(0)
-#define	PWR_FAB_UMC_MSK			BIT(1)
 #define	PWR_FAB_ALL_MSK			(BIT(0)|BIT(1)|BIT(2)|BIT(3))
 
 /*---------------------------------------------*/
 /* 3 The value of cut_msk: 8 bits */
 /*---------------------------------------------*/
 #define	PWR_CUT_TESTCHIP_MSK	BIT(0)
-#define	PWR_CUT_A_MSK			BIT(1)
-#define	PWR_CUT_B_MSK			BIT(2)
-#define	PWR_CUT_C_MSK			BIT(3)
-#define	PWR_CUT_D_MSK			BIT(4)
-#define	PWR_CUT_E_MSK			BIT(5)
-#define	PWR_CUT_F_MSK			BIT(6)
-#define	PWR_CUT_G_MSK			BIT(7)
 #define	PWR_CUT_ALL_MSK			0xFF
 
 
-- 
2.45.2


