Return-Path: <linux-kernel+bounces-266914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29255940963
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C84285505
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A9186E2E;
	Tue, 30 Jul 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba/oTxQL"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58416132B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323904; cv=none; b=hvKBrcfoAIOH33ldMTAUtTBzucVMmeWcHelpsVOx6doK5nyVD2Q86CAA37q0fgsve+5L8wljLfJw6FgEOEXxzt8jBvWXWnT+VgZ0P4l7xAzERtOJznL/xXZtBKcsIc8wwyfbdqmGKvsi3F09C1iKvq/A98cGjEC4xcIhd1EI+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323904; c=relaxed/simple;
	bh=Ah3ly8T85JxSSei9ejujSo5WDUEt8TJpdcnUKYD7Ek4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHbY9kOS4cEBBhqYZqaZyZIc/YoFG54/DkrdrSDueECt5AaiT0bpdU+og1O/Z9IIL9xQn3KveKWqRBAw3KIvVo1DWw9/sHyLZaHbAgwtSL6/9hyHRTreKhVfxdZYKXg0JEtdJ0D065AmxxpO/tmnoEpOMsuiee/bq8Xg+K7ZQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba/oTxQL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db23a608eeso2420041b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722323902; x=1722928702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk6LUBEjtLHTIduKacIJh9oql79dyF9GO+WNx7nf4wE=;
        b=Ba/oTxQLVOLs2G7OqTb29Hgm4veIHKMyI6IrykBewSdPoZtJG8tBc5COcJXWTvKg6+
         PCeztgmBWSpMpHDLDQ2M9Xu7/rb6MRk6s1GocljAHHoDFGd4TRf2JjbJQmrOXPk5Opjg
         JPa7qEND2P9dWwmHO9pYbTfNXs0rgI31bdGByrs/NrPFc76proMVOTseViM42gOR8bD0
         zMTGjL3nQwF3uQEMpmd1RW+/gcCN5ADoA0CrVoFGqINgmLdFaWSoXjRqk+VrQonXAccd
         tUCUUfQ9ilRN519X3zGPeDcEHkJzSwGpkGzR/S0YDtbz0d+japWOricsf8EdPVIh/gt9
         Eixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323902; x=1722928702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fk6LUBEjtLHTIduKacIJh9oql79dyF9GO+WNx7nf4wE=;
        b=HdclgZ54TrQGwgZBHb5RqM9vhgzpfofwioAjoGlHtLNreFGzwZ6TQ6TgtzLJ7cLmJ5
         jJYduKRX2eToEbRUBBtU1nvUfwdRxSs+EYWVisENfB8PEwQonCjKvCPAd9JRvCsmNQSA
         Q9b+xLsxhCMJmJsYEmusJqYuv7OCxDc4itdBVTushNfiB3RB8vPjF0iYDiUb0/ykBgya
         ZNaQlG0dnf8uh9fu/B4r6ITfylmt+Huj2CWhb+R2W8G+2A/T2nrQBa37EXbzMd5Uqc4D
         PQI7gGnUNfedbSGqS3zev4s/o6kR4NLoDxVuXM3q8hpC66THsIDQuLXWhSDtpoQz5TVy
         7P5A==
X-Forwarded-Encrypted: i=1; AJvYcCWeqTBf9hkl5xSYa3au2Cuzw1rAMHm2IDrbsbJPzqUjKd01ll8AAUe3xaRh+EH7mcBbTWgJ6eAG/YTRAY/zoH4ljocpnPPMlZe2M28+
X-Gm-Message-State: AOJu0Yy/pX2j8ICfYd/FIwTnqJVNdFRIjA5XPO//GNpCzQvktGG3Gfno
	kFW6+Rwro8k5gj7AvyPuK5yK5UDnZvX5DNOGnq6on5EG+cEA8z4o
X-Google-Smtp-Source: AGHT+IGmGRJKTI7i09idErMvGq6qRxMX69ng5CF0tGr/n/LAIqITHHgS+LvAQsIoWl8XEC+eqfHmYw==
X-Received: by 2002:a05:6808:bca:b0:3d5:600c:682 with SMTP id 5614622812f47-3db23a67592mr11868389b6e.13.1722323902089;
        Tue, 30 Jul 2024 00:18:22 -0700 (PDT)
Received: from 3a25d514abef.debconf24.debconf.org ([116.89.172.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa6987dasm7103703a12.86.2024.07.30.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:18:21 -0700 (PDT)
From: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: media: atomisp: remove trailing statement
Date: Tue, 30 Jul 2024 07:18:08 +0000
Message-Id: <20240730071808.35591-1-sskartheekadivi@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this patch fixes the following checkpatch.pl error..
ERROR: trailing statements should be on next line
#48: FILE: drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c:48:
+	if (!anr) return;

Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
---
Just started contributing to the kernel. please help me understand my
mistakes if any.

 .../atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
index 3f079c954..73364a65f 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
@@ -45,7 +45,8 @@ ia_css_anr_dump(
     const struct sh_css_isp_anr_params *anr,
     unsigned int level)
 {
-	if (!anr) return;
+	if (!anr)
+		return;
 	ia_css_debug_dtrace(level, "Advance Noise Reduction:\n");
 	ia_css_debug_dtrace(level, "\t%-32s = %d\n",
 			    "anr_threshold", anr->threshold);
-- 
2.20.1


