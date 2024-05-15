Return-Path: <linux-kernel+bounces-179409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAA8C5FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792BB1F22354
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BB381DE;
	Wed, 15 May 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="UZ0+/P2I"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557639FE9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748759; cv=none; b=be0ZeNDDlxAO5aBxcwpRTbKdfPGLPT1cbnJbjoMXGs7hV7XGVOGsVnxkD+ok6fljMETIIBBKykxccI/ZF0BlA0XqufjvFghGVGp6RKDShXkedqZMW/vLb339ZVi39LCXEa8hsMRduH7n+RXlQXPtF1OYysRkdwVLErOCq9PwMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748759; c=relaxed/simple;
	bh=TEU9avpaX/N43LfNkZJD36hkEcVzdowUram2d7CoU3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MezKarY+4PgO06m3kUQczfqprgs0kXplK8HnwBl5KTiwHNKN17tpsWeJlRnlukwZ17jGm4ucmN3fl9M/5j1LgotGICHm9kfXkSnWg3yqWVyfnF+XByjxpCGma3SUuo2MBO8YiPXBmqFbmhnPro43XFKaE/GZhtOAA06D+L7ygGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=UZ0+/P2I; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c99aec9598so2694830b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748757; x=1716353557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvjRAcugX4Y+qbTFQbTgqGMibulX1uDB5tb1Q6bCIzE=;
        b=UZ0+/P2Ivj6/5BLBWD0aqZheVJVottKy55vyRIdpfjCiloM3ber5wskHRa1CeSo5Dl
         lNw5fovzY3rhpPop2xhDgvv6YaC+1zLrPQJYs6if3UTfZSCkQO+ngAk2wM4QzQaAicBu
         bUvIpvt7Uh+6EDfFflUyYj8jVnMgdZFi7o1gRnnUOs8PERScwtsrH7sDh1IQ3/KJaqRm
         A4uWS9uF6AR8kqd9rRwcVGfKHbG43UI5MEVny0iQCP9f8bUEeq63NgjQb7PEKfV1Movw
         v3oz78J6wURKL+nasdWJHT6EzpxCPj/gVVAnzL/9U47bBECX2PziWzfo3kbXBjHPWgpS
         B75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748757; x=1716353557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvjRAcugX4Y+qbTFQbTgqGMibulX1uDB5tb1Q6bCIzE=;
        b=vdN4HrmsoeTnd6iQouHaU58HSZJVrnDMx6oNO4xSKefL22+HTJiOUGrEo3xmDp/KWE
         ansGK7RpeoTsVCuxdLpcHCPNxNYYNJkLSQaG6f2QljnTcAQQN1P/M7s23O460b4kJYGG
         2tc5BUqF0+TPDxRDQzM+46RW9ss1dDaS9Hk4mI1McrEPT6YZNMRuTFKizv0CgQGKRw8I
         EofbwkP1G2s9zh4hMYhqve88yZ0P1/5U/FvbQH7Ad6zuMJiqcpnoFRka3AcZYLhJii+M
         7vjMYnhcKvM78omwJ5KfGR/ckPrUkYqL9WlhyHY7zNGoJSFYQu/sRlHj9Q4N3HzaD+iC
         B3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Ei+poVqtcnWY74XeJk+q0usganXALDEZrTcOX0VsKh+L11rH4+XhW3kr1QVkPFTYGRwYMkgbJ8LrjKdV6TxHY56s8V1NGOlyYBZX
X-Gm-Message-State: AOJu0YyJckEBEoCuNjOJnN4laSexAw1kK1FUBPngSRGUEl6xQzoB3/M+
	+otJYMarpiHKAZaLOoPhfUqCrDuOR+MYJrDIa0ZXbWtj8bW2SU09VVw6Ncb/IuM=
X-Google-Smtp-Source: AGHT+IHXSKVG6OpQmEqKTMNFvcpSpKH2NcFI8y8VYcx2Qr+CVyvglrb+pY8R0r6g03tt0VQww6xQKw==
X-Received: by 2002:a05:6808:f03:b0:3c9:714d:cc7b with SMTP id 5614622812f47-3c997039622mr18101556b6e.9.1715748757124;
        Tue, 14 May 2024 21:52:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:36 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/31] Staging: rtl8192e: Rename variable bWithAironetIE
Date: Tue, 14 May 2024 21:52:01 -0700
Message-Id: <20240515045228.35928-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bWithAironetIE to with_aironet_ie
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cae4df481397..40ec29434d68 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -910,7 +910,7 @@ struct rtllib_network {
 	u8 hidden_ssid_len;
 	struct rtllib_qos_data qos_data;
 
-	bool	bWithAironetIE;
+	bool	with_aironet_ie;
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 1cae6d6efb96..d4dbf8052c30 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2090,7 +2090,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			netdev_dbg(ieee->dev, "MFIE_TYPE_AIRONET: %d bytes\n",
 				   info_element->len);
 			if (info_element->len > IE_CISCO_FLAG_POSITION) {
-				network->bWithAironetIE = true;
+				network->with_aironet_ie = true;
 
 				if ((info_element->data[IE_CISCO_FLAG_POSITION]
 				     & SUPPORT_CKIP_MIC) ||
@@ -2100,7 +2100,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 				else
 					network->ckip_supported = false;
 			} else {
-				network->bWithAironetIE = false;
+				network->with_aironet_ie = false;
 				network->ckip_supported = false;
 			}
 			break;
@@ -2345,7 +2345,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->country_ie_len = src->country_ie_len;
 	memcpy(dst->country_ie_buf, src->country_ie_buf, src->country_ie_len);
 
-	dst->bWithAironetIE = src->bWithAironetIE;
+	dst->with_aironet_ie = src->with_aironet_ie;
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
-- 
2.30.2


