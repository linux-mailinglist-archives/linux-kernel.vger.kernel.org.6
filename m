Return-Path: <linux-kernel+bounces-243504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3039296EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445611C20DF0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69DDDC0;
	Sun,  7 Jul 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSnFjA19"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CFF51B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335293; cv=none; b=bDv4UlEY9xbTsFmPGlcx1Zi72W8Q9rP5kAaZCVyLmzVIaRATCrvgrArCPPZhfBgVHxIxM37DedNpSDuiH+uPSRS5+ouHx7UaPs4l4KSzejrA2vPA6W+8Dd7iTNTxKyEophAsaqUSyUlWvRxDrQCPxXsm+YRDDOURbvzHQPBqWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335293; c=relaxed/simple;
	bh=A1cc6R4ADsw7Wfs8/3cko5o9FF7u3hr5aar0YIWXslA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihf8rHMuq6LfAqdACNKBZMPUns7sgcIz9cGAMtFn6iCK0N41tXpYpHi/n50C7pdD6zSaEprqOy/0X1KYl5dD6YRgeVGXdbvncePBN4At2jr4QbbAQzVKFyrp02rSPI2lUIZsBrOPtWkdnLPH4U4GX8uz8NO+p3BUnmxae72JSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSnFjA19; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4265d1b9e2aso1100215e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335291; x=1720940091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neca6wdATA/qL53v1wSvPrAx8UxyZGmOCNXgkW2DPX8=;
        b=iSnFjA19kOZGQcK7AAa87yXZz/N61HaK9z1foriVkOXAULqqyjcVbif4eWug1Nbxx8
         RKnFlcdnm9hDrivMCYFE11qoFVD7ytI5vNlsyYdDCNDVpfSiav4afTshYt3vjPETcOQT
         LsAMzM7Zu/8T62NgVOqwgj/nHbObs57PWNGU/vIzj1vXUsqUDC6rgohCc/LRQ7WvVOWc
         i1oXhAXZPtKtSYL+PrlpVysp1ewzmqFBo42xunbW0+M0lPnumbg1RIzrdub8wgN9ifDZ
         3P1+NGpi4A+L4uONxo81NfzGNzdVEJvrwjIxV7D0SY9p0NAIcu/tDmAKKRNnaU4f/dLw
         PIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335291; x=1720940091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neca6wdATA/qL53v1wSvPrAx8UxyZGmOCNXgkW2DPX8=;
        b=PINjSCaORmVbqjCwHmOyuy+9L61ho98VgsQYx/P37TfNcvIx8bD5s1ilgX9tWZW1tN
         tIZghSk2ZXq7A6Cpl+WhcTUybeiQvHPYk/ooptrC7fEzCcHCTHnF/4+pFxlGerSH0BJj
         qe32O2Z8fbPeHTGGfyjQnLy8dG7AsUFKsCmcB7tcXTxYcOPF7pHTTKsrUPoyjiEX18rd
         nbHrwBdERixHVM1d+JMsspKacF7ezPpsVNcQSAAjjbJTTsNStnu6O/SgJLsIcdMfDnsd
         yajtlYpB9o8rhH1h3GEdfqGe/Zo7J47UiKIlsMhUJtxhVshOH9TelkKQvBCeZ91o5vql
         uhiw==
X-Forwarded-Encrypted: i=1; AJvYcCW8EIxM3hxXcqfC8OvtYgLvM0/eVgMfiYk7QneWppo33RhyLTeWukH4mVsua20jpgnB7buRn0K0PXalMvhpQMyDkU3F46lIPV21xpwv
X-Gm-Message-State: AOJu0YxX/Bp3iyXLnWT/HOs8SWqPF5HEQjwpCqG+v8+rh28gwMEx8dNu
	/TsZDLZAy7izpzLfBT92CW6GQgBUlF7E/46fWnQ4cTqOyiZbnQb+
X-Google-Smtp-Source: AGHT+IH9Eb/Qu91B8CjT4rzxtXg/HmkHAxzNby7iusjNQENI/NuK+KG1HSlyYpzjEpFx/SPoGqd+Rg==
X-Received: by 2002:a5d:5988:0:b0:367:9505:73e2 with SMTP id ffacd0b85a97d-3679dd62d9emr6402606f8f.4.1720335290716;
        Sat, 06 Jul 2024 23:54:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36797718618sm9333795f8f.31.2024.07.06.23.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:54:50 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:54:48 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] staging: rtl8723bs: Remove unused macros in
 hal_pwr_seq.h
Message-ID: <7e8117fe3d3f82d69897675c36dc9ee229b9f2ad.1720245061.git.philipp.g.hortmann@gmail.com>
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
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
index 0a2e60770668..5e43cc89f535 100644
--- a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
+++ b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
@@ -28,9 +28,7 @@
 #define	RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS	26
 #define	RTL8723B_TRANS_ACT_TO_CARDEMU_STEPS	15
 #define	RTL8723B_TRANS_CARDEMU_TO_SUS_STEPS	15
-#define	RTL8723B_TRANS_SUS_TO_CARDEMU_STEPS	15
 #define	RTL8723B_TRANS_CARDEMU_TO_PDN_STEPS	15
-#define	RTL8723B_TRANS_PDN_TO_CARDEMU_STEPS	15
 #define	RTL8723B_TRANS_ACT_TO_LPS_STEPS		15
 #define	RTL8723B_TRANS_LPS_TO_ACT_STEPS		15
 #define	RTL8723B_TRANS_ACT_TO_SWLPS_STEPS		22
@@ -128,11 +126,6 @@
 	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0},/* 0x04[16] = 0*/\
 	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7},/* 0x04[15] = 1*/
 
-#define RTL8723B_TRANS_PDN_TO_CARDEMU												\
-	/* format */																\
-	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, 0},/* 0x04[15] = 0*/
-
 #define RTL8723B_TRANS_ACT_TO_LPS														\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-- 
2.45.2


