Return-Path: <linux-kernel+bounces-210865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F15904988
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5724228250C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6544204B;
	Wed, 12 Jun 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gXd9H+SV"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CB2C697
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162560; cv=none; b=aU5KHbtJqZ1X4QlnWXvRS4O4M6XwuFUE118lD2O2yx0rFl2yREuUXoCm2E/KrbT0VKxjRGC972jnobJOIDNAyRE0RuN1P1NXzU35nEsbY+jZk7UpTe7tlj7MLZMXMqEwY8BRGzj3xUsvRbhV9ttLNw92LmsJ6TWHFKf2EZjwcQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162560; c=relaxed/simple;
	bh=jZscMWxL7wrIFx2GZ4mN7wJ5/mjd6vwOTRZBjWSLoBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lvh+y2ubFiCS9Qm36zwqhGuh45g050kWrr+oLPrugprEznGMihWpiteWHkPXC8PJcDxYdKFf3BNbwdnzbxLUqGCDQru6cFND0TB2b4D7EhJVw6ZfjH9NIEoXGp0KnPFSoV4JhAu8ndi3fc28yg7mvOAoCy1vmzJlHT/D47gt20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gXd9H+SV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bad217c51aso2198332eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162558; x=1718767358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3pqpAJUhbdkefnBX1dLZjdOSci96N6yUXA1/JKUCTg=;
        b=gXd9H+SVQzqHpXGiiajNlcDITetXqdpuIC28wpqcM3L+atNk0PDdEDP6PRb+3pnaYc
         uwQcwbju3bCFUQI1ichJbvGUV+0E1rE6P03yfzdoSqbOOXfPOHu1W+WyzknqNUMKonG8
         tHccd/gwGzbV0cldHDUAzaFKaZ5JttsjE9SSov2NNyOHI3XcNHmYfZ1Bq8AXot4FkMJ6
         yLCvbEJ+1pquJrPRDqKZaR+givTFXPNmeh15uvgyePa64KDp5kWWJdnNrFJQXGRCXpds
         clcAgvvL6HCygC+s9Q9y71BgPAqu/u9L+3/9GBXjAyB8uNcfF2i0y3C3iZQhjPLly3ma
         ECJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162558; x=1718767358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3pqpAJUhbdkefnBX1dLZjdOSci96N6yUXA1/JKUCTg=;
        b=cApQ57jqvLUcDTpOLkeP3qLPeQ7Z5NkVkTDz49SaQLJx88C574O084RfHM6fe+MO0Q
         mqLJTDiugGwISwdxHqMTHAQwjqv+hf4YWvtYxBY4GJXQrsxziOUeLpHsFJh2mi65K+3P
         G/gMljtZQJJDhOcBfJO/wHH4q1m4nZ6Z5Gmng0FGUPnB56Ud4OEITSWFxPvH48R2huyz
         C8rNjurfZ0JW5KDVuZ3UW/q7rbrjNfY1cCTRvgoRVNIGXbSWz93YVJY6xjyMGXpkbHx0
         hcJC9gxQ2epqo1M3SkDGqdO+3GaO0hYs1x4AtKh7hymR/vTPW6+rBtc1hYZZuuu9rnhq
         wzNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQsp7h1+YBtORnM0xT9rZqJBw/StiomyFkcdk70Ex1k7hKVUvqSdF10V+t6MZdV310c027uHwkHUer4ln0YZuQiRrT/qdls3TTNXbj
X-Gm-Message-State: AOJu0Yw7CVZ1yrvMkauOFBKidggF7x+UPuhy9TL+jLBrE4IwwrlQoTv2
	JVI9m7KluLUnh40AJOKgZsUB7QKgf46yV9ZjcTQYB61ZmesnrLm0U/Jk0iXvB3g=
X-Google-Smtp-Source: AGHT+IGqui4QJBWV32iB7YGIW6z2TauZoN4z1bETO7wduWaByH9ah0NJvmU1zTHqXN4T1LrZQN3/jA==
X-Received: by 2002:a05:6358:8419:b0:19f:3ade:eb78 with SMTP id e5c5f4694b2df-19f69d866c3mr93468055d.28.1718162558054;
        Tue, 11 Jun 2024 20:22:38 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:37 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 06/24] Staging: rtl8192e: Rename variable bRTSBW
Date: Tue, 11 Jun 2024 20:22:12 -0700
Message-Id: <20240612032230.9738-7-tdavies@darkphysics.net>
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

Rename variable bRTSBW to rts_bw
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a305848dabd5..0131765e451e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -119,7 +119,7 @@ struct cb_desc {
 	u8 bRTSSTBC:1;
 	u8 RTSSC:1;
 
-	u8 bRTSBW:1;
+	u8 rts_bw:1;
 	u8 bPacketBW:1;
 	u8 rts_use_short_preamble:1;
 	u8 bRTSUseShortGI:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index be8de6703e5d..8c9072538688 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -376,7 +376,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->bRTSUseShortGI		= false;
 	tcb_desc->bCTSEnable			= false;
 	tcb_desc->RTSSC				= 0;
-	tcb_desc->bRTSBW			= false;
+	tcb_desc->rts_bw			= false;
 
 	if (tcb_desc->bBroadcast || tcb_desc->multicast)
 		return;
@@ -447,7 +447,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->bCTSEnable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
-	tcb_desc->bRTSBW	= false;
+	tcb_desc->rts_bw	= false;
 }
 
 static void rtllib_txrate_selectmode(struct rtllib_device *ieee,
-- 
2.30.2


