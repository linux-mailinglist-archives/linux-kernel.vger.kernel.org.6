Return-Path: <linux-kernel+bounces-302054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AF95F939
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FE61C2206E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499F8248C;
	Mon, 26 Aug 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDTKZBEP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8A768FD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698373; cv=none; b=g1MeQ/xvtPdgh6TYYplGR7vfjoV4h7o8WH14QUkjgGw08bCIUPZ1nMhoBFIwFGfXvxU7e3ZReojdwkQ9dMEID1OIrMyzhGJ5pHoSvbi6yxFS3Ili9MtBYQNrllETUWUjkKNVnvR/m555dkmVoiNm7rAw3jyZC/KjWd/2MdlW2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698373; c=relaxed/simple;
	bh=vzEkV0fc1prvK5DIabDiJ0kU3ZJOr9l9vPx3nu33+Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAJOFa/eYyHgf3ao4C4SjW4OV9aMXte+0X5M5ki9EZz3NghgLCGwXcO31bVvKx9GS2e1zZhawHEt+u0WlOPH/N1Ev/IJbJmu//z0dqifT4/FjJC+LZ4r3uxBvZG06wzCEBAQ1BJroN6XiGnDD96FBy384hRtL2bsXZ5EwQV1Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDTKZBEP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201fba05363so36237335ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724698371; x=1725303171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwJGUsNOEwsmpVGk46dDj18VF13y1ysRC97a7FWC1j4=;
        b=DDTKZBEPPn/HuljQPpBhM219IBOI0LQ4O8h0Ineb5meoJvwHo24f4KK5YB5FU0U94p
         qmnhrYIb1kd0ylkJ/W87fwXoNr/nBKwZtS3bIOaCNGlO1VJXIqRL32fygcW0GBx67Ygd
         2HAjmoBwSb5G1bVF50J94WUvDfdxZZMzUNM0M4bnESD1jwD8QU/ikTPs3iSKcnARIJod
         lTyo8SF1kFKFuB5hKW1ugXtT80wl22pPCgpmdMhfv8c2BPIB4OGXbhpfdNYoWL0mfwwW
         0LhtfrYRCLfO35CsMPZNbW2tLV+4AcrDL6MOfBaInaX9PjHvzEP6v0gVp1XuoF7UcgDn
         /Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724698371; x=1725303171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwJGUsNOEwsmpVGk46dDj18VF13y1ysRC97a7FWC1j4=;
        b=fiS0ZFbnPu24ub/8HEtzmtyKS0b0CEbdXtzVh1UhA2/hqII6piJ9eQ9X9a09f3zRfv
         0GxCW7ZuOvGoLIpXsYCJMcNF57DvxD2R0jMh1Uv1KmzCIGzF1BKUnA1HNXWGAplP9nYV
         uhr13IdofSuoIRjqR5/erVOFH6NXDm5nK8yrX8lFwHHkD8QvWG3TCoJQGTgHAXG0ZjJp
         ndy4lquhlV55vT/yHDVRij4fc5ByLeWcGOuTWhQpE6+Amdr7AIaBPb7NA2GyshKG7RH2
         DbspGlnlg3szYlxCeZVvup9IZUCIDQMhP15UIiZWWjKeqsIRLWu7TAY88IywKutFi00f
         4XGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDqWt3kOcjg5FqxAECtvcBZSSHbpPiA0bDIUS3fnU45tTd/NU6FBaGUuQM8QlIHw9NyFKmTy40isinhns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwv7wg+huuQ4xcFjzY+/yhcDI3GiXgo5mKbGNOhe9IjqlWpjO
	WMIDW9YqQvld/X/EvqOJcwUWMxRSz2i+WoZxBIYKyZj8YovG6+s1
X-Google-Smtp-Source: AGHT+IEBe1CP2CQogtHDQSIjYX1OcTMmHdfgt55Gdb3pgGa/ZsEDgfcBfduS/zyNGyKqwEcpY3TGXA==
X-Received: by 2002:a17:903:11c7:b0:202:4d05:a24a with SMTP id d9443c01a7336-204df13ee41mr5432255ad.16.1724698371124;
        Mon, 26 Aug 2024 11:52:51 -0700 (PDT)
Received: from masingh-thinkpad.. ([49.207.52.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859ef0fdsm70377565ad.248.2024.08.26.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:52:50 -0700 (PDT)
From: Manisha Singh <masingh.linux@gmail.com>
To: florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Manisha Singh <masingh.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix style issues in rtl871x_io.c
Date: Tue, 27 Aug 2024 00:22:13 +0530
Message-ID: <20240826185213.9445-2-masingh.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses style issues reported by checkpatch.pl in
drivers/staging/rtl8712/rtl871x_io.c:

1. Avoid Multiple Assignments: The original line had multiple
   assignments in a single statement. This is generally discouraged
   for clarity and maintainability. The code has been refactored to
   use separate statements for each assignment.

2. Prefer `sizeof(*pintf_hdl->pintfpriv)` Over
   `sizeof(struct intf_priv)`: Updated the memory allocation call to
   use `sizeof(*pintf_hdl->pintfpriv)` instead of
   `sizeof(struct intf_priv)`. This is considered better practice as it
   automatically adjusts if the type of `pintf_hdl->pintfpriv` changes,
   reducing the risk of mismatches and improving maintainability.

Changes made:
- Replaced the original line with two separate lines for allocation and
  assignment.
- Updated `kmalloc` to use `sizeof(*pintf_hdl->pintfpriv)` for the
  allocation size.

These changes improve code readability and maintain consistency with
coding standards.

Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 6789a4c98564..b81e9b06725c 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -48,8 +48,8 @@ static uint _init_intf_hdl(struct _adapter *padapter,
 	set_intf_funs = &(r8712_usb_set_intf_funs);
 	set_intf_ops = &r8712_usb_set_intf_ops;
 	init_intf_priv = &r8712_usb_init_intf_priv;
-	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
-						    GFP_ATOMIC);
+	pintf_priv = kmalloc(sizeof(*pintf_hdl->pintfpriv), GFP_ATOMIC);
+	pintf_hdl->pintfpriv = pintf_priv;
 	if (!pintf_priv)
 		goto _init_intf_hdl_fail;
 	pintf_hdl->adapter = (u8 *)padapter;
-- 
2.43.0


