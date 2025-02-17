Return-Path: <linux-kernel+bounces-517394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7DA3803D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F90188DFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5A216E08;
	Mon, 17 Feb 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngv0iyS0"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176C21770B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788282; cv=none; b=YPKp2HdnuD2mSEI+TmN2JMJx99WRH4GYEOi3SCKNUrc9wrEHV84eSZ9+h5ZHkhIDiuxRE02P8ZrnDp/CTg82OgcJqEqHl0bRnrgRZcSbgip0jpTFgy96OM/x4L8qsbBkk/AqMG03nENlsdFOVXtkTW6jGE1/CwugppPx0JAYrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788282; c=relaxed/simple;
	bh=XO6uPpFukGBucmrCA20btnJlN/3eEn2EL2uIuT8mRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUvFyVNMidlqSt0sLVBi6bBsodc05d0ifdBwbSoSb0TEJGVSIfJ6uzGEJYF8K3IU/0ZFTMbFPbSpN8aWs+j1mb5letcsDlsR+cOImqYJbbyh2cdsiZTS3aWqlncW12wJYz/XLGW9Kg35sKxWk/zKEOWAorr8Sg/R2NQUN6FM7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngv0iyS0; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220bfdfb3f4so86632385ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739788280; x=1740393080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=Ngv0iyS0s6R9QzQiwuBmXa82OnrKfZyCw4hLURJj6oX5K2A4NSR0t5NjluW6wTvYZR
         0yfN45T7PX5jtorGidkj36Y3ML24SXdsz8ux1frb0RK+l12SWYZO00d+L3ATeZiIBOXe
         kaxdh+3IVygjqq5EGyeGl/4pF+2XxxD1u/nPzNmT+pL8NiBMEBFeqclLWXraJOj3CNwz
         JyBJ/QeclyfLp3cgDM0tJFvPvM3uptK1FLx67mcrN5wmcY+rYG1qCaLlKfHhX6T3q3Af
         qNzEorTdQ3VAicG8gdrpF0fyoYGVqe3cPuRNuChZGv3QiO82x+qNkm0Hr7Lx+/RWU9UK
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788280; x=1740393080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6ix2sWH7fK+O3pMFw+ar4SRdhAMLkYoHd95tZujCUw=;
        b=AyFm24H2Zf/UsgWaQCYRNnVh79PItDs0yDMFaMzuhU+YwwTKeiCibQkar331tbtTyC
         QV/TZfxFjQocsm1p2qzHMoOfNQieIVVxt5HdHJi0e3xniGWfvsdvpZTpjldvecKG3zdW
         GRfgYjJhzVLpw8AocBMLTuCKLGgPfokzj6wkPku+IDQ6/l5er0i1RAWWaq5n5oXKxWtp
         rSgKqiBVQuCdItPREWIitoRR534rcUF/lj7X78uiT9ICUn+S5QhzpZpoRpbMYGNvvAg5
         i/xbyPlLADqbNrB5SaWpdP3VZCO/HWM4DwjFWX76h4BHdQzyqE4gn3lNH93xFauoQocN
         iD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUI6VNGyiVOT0Y763SY0aFIeoOwvVV7262woPi9mboo81aO/lACTQNOOA8LvEhB6p66Y9r4lUBrcYM9YGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMtrxQSye7u/T/evj0f/l3nBRveNl5Skd9cRc8OknpIF23R1j
	j6wbG970d5iMmbLEmixsV68+/Yo3UnZyNvqpmkmMPQwpn8txi73Z
X-Gm-Gg: ASbGnctfVpjNlHj2JaHJ8DU+KXxNGvI4KrTleJFRiZeBM3jWJDuX9AiHNdZq4QzMLIc
	wUaH/3yB5ky26qpLJuR1kuT6+Y2ryGA0xr02GZKsTQrLNTQEBZS/qrO6cwqMfpRTwtQl7jle4Zo
	Y5uROxQFoapwwA10KfrfAxemTdHJLj4mkmZuBUAaLi9SsoZpQKyv4DYyG0W982hOph3zwzA0Wzp
	CzdyFnbrFq1XakbjJBDKPI0vHmu6rngXIWZJeOm+ihMiNUtpppQSVCUXFJr0uKmqe68i652ru+P
	cI925XKKJNOfmhtUnBvW
X-Google-Smtp-Source: AGHT+IEPOHcTF6hyyEmXMlteolNIm5KtdB7tzEBsHZ2kU7maGDRQ+x6WWVlf11YGDM9J+5Z0UGFesg==
X-Received: by 2002:a17:903:41c6:b0:21d:dfae:300c with SMTP id d9443c01a7336-22103efc10cmr136496685ad.3.1739788280168;
        Mon, 17 Feb 2025 02:31:20 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491ecsm68412705ad.9.2025.02.17.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:31:19 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v3 3/4] [PATCH V2 3/4] staging:gpib:agilent_82350b:Removed blank line
Date: Mon, 17 Feb 2025 16:00:37 +0530
Message-ID: <20250217103046.54294-4-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217103046.54294-1-kumarkairiravi@gmail.com>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

removed few empty lines that were causing checkpatch script warnings

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 7936c7285d..b6871eb3c8 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 
 	event_status = read_and_clear_event_status(board);
 
-
 #ifdef EXPERIMENTAL
 	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
 	retval = wait_event_interruptible(board->wait,
@@ -193,8 +192,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 	*bytes_written += num_bytes;
 	if (retval < 0)
 		return retval;
-
-
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
@@ -207,7 +204,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-
 		if (agilent_82350b_fifo_is_halted(a_priv)) {
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
 			//	pr_info("ag_ac_wr: needed restart\n");
-- 
2.48.1


