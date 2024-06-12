Return-Path: <linux-kernel+bounces-210863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B8904986
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F0F1F22E31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2EA37708;
	Wed, 12 Jun 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="VuTI85gv"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF320DF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162559; cv=none; b=WacYc+JA9ubRjjJmX7VoQH5C7dhE/U0PsEifUJ8Awx5cXjfx+aUfK17w/p+X9aT72gLls28l04gZgbMrl4s2bQmxj1VQd+RvW0E/zKdkhAVrrd3wYFF/JeHJ86uKVYDH8fbOT/3lg4FsWQvAM2ZMJfjlHoAAV/1uKix/8rVTuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162559; c=relaxed/simple;
	bh=MNGZfx/m8G/rOwnxNGd4tIVSOsIacMXC8rkJWcI6FKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=embuu/CaPf3QgshlEzvdAdrv7/w4xYfogvRCGbn22cd/WigQl9w1/2cBY2ytoGj7cLxj9b/o65pBTVQP4flwrzgq1Lua+SHhMSDLE+XqewIt7L0a7B//KORORxg4bUqtTowSMVQJ7Nvq4gdhFBN1HQLRjfxK9pRsMwpMgMGCHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=VuTI85gv; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2ed25b337so952207eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162556; x=1718767356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ih+jocFy4KluPcELXVg85YttXvFxOSqGBEasMdYF/eA=;
        b=VuTI85gvQz8Tu3n5JeqgvkSpuwwPDwHnhGvOoNqmcCqaFopsKMgv/4pDKAuZLfE//l
         3dOXNDPaI1MXqlJt2IiVufrYI12WtOgZ+AZk1VPnNTvcmemYO4ueNRrnGlwg9cjg0Q7X
         fR9SpziRyBs+wVXGyuXksTGBIISP/Wv9y4gk3B4h0NOtlCeUVnxm7SOxH97Dnu0i1uXn
         z/x/lQGfRuoSSMPZtOTkJ3t6GSCbRKamm69CRK36kE7GabFd0mNkQlqQO0lhgZHyu1GZ
         N88IVe6ElH1SlIA7Irb3KA5+j7x0UkFc0WQLIf5JbW4WO/mp5wbnf7umhu9N8KwlVxAv
         nImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162556; x=1718767356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ih+jocFy4KluPcELXVg85YttXvFxOSqGBEasMdYF/eA=;
        b=bDOVB1I/dbA7/yRyoTma/ynHLlSxXphuv/tFE3KDUa6/U3ylM9eco94JxNA6txsRIt
         UIMwvrYSnziesjX0OW031AQfYY7WKog2h8iVNe3Mlz6bKwVQS+I7DmNRtrV+OOE+E9rp
         0rZFAAf0BBDAsz3fTV6OOl2U5fo5eRhtEzKEexrozocYmrzeReWCm6WHhm4jO7dFiFwK
         2YjkJ1jJLVQkc84f2k7XwAbpvcaFPVR4zwAOXT2DDRJEARna4jQgGZQqPYVSiTDxEqSM
         J9HRFM4o6ezM5WuFmIb4jodED1qbthiA83aILSUlt9aZoRpv57TAHbqldeeapTrJjfRx
         casw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6r2fCI3K43GnrRHWw+6kgASWvfrhmT8pSqF7brmN4/lyUTmYwrG4eZfCmvuy43ROv3juBEfX/Rwfp3F2knLzc/fi1AE+9YUe5a7A
X-Gm-Message-State: AOJu0YxRPYDbM8lHv5XzdzIKKUxI/EqmoyPBntquXCpC8oiMs7W/ee3p
	JUnckwuF2bnb2uSRGSmntwzTz0IzC9WjfOT3wV3/QTwitAOODe4KRg5WKHTLjdY=
X-Google-Smtp-Source: AGHT+IHBuiTxrdPRHM4jtIqD5RsNI+BOh+MI67NlK2/uiXzoHG78x2okPV55dQLCkk6gbMYYzfFfhw==
X-Received: by 2002:a05:6358:e4a3:b0:19f:5550:84b2 with SMTP id e5c5f4694b2df-19f69d9a729mr92606055d.22.1718162556481;
        Tue, 11 Jun 2024 20:22:36 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:36 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 04/24] Staging: rtl8192e: Rename variable HTOpMode
Date: Tue, 11 Jun 2024 20:22:10 -0700
Message-Id: <20240612032230.9738-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable HTOpMode to ht_op_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 360d1cc446d0..83082a990fbd 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -417,11 +417,11 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			break;
 		}
 		if (ht_info->current_ht_support && ht_info->enable_ht) {
-			u8 HTOpMode = ht_info->current_op_mode;
+			u8 ht_op_mode = ht_info->current_op_mode;
 
-			if ((ht_info->cur_bw_40mhz && (HTOpMode == 2 ||
-						      HTOpMode == 3)) ||
-			     (!ht_info->cur_bw_40mhz && HTOpMode == 3)) {
+			if ((ht_info->cur_bw_40mhz && (ht_op_mode == 2 ||
+						      ht_op_mode == 3)) ||
+			     (!ht_info->cur_bw_40mhz && ht_op_mode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
-- 
2.30.2


