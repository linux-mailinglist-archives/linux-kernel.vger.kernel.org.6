Return-Path: <linux-kernel+bounces-179432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9478C5FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028431F25B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E786E5E8;
	Wed, 15 May 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Jd7A7vHO"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4893B1AC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748775; cv=none; b=Mvy9cJp2V4ADTGYbJrmEhjfPUmgniS8W3oIjkcGEWm6IRGLB6ZgQv/jDKb5wo5XkjDq3l/bK56Y080BoJMrgnenSSGzje8+cT2Bg/DlfZdOJRjLaGd9TAdZektsiiof4y2TzVha6PNAjChlObVBaakgxO4btu5ovkqxe5JNb4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748775; c=relaxed/simple;
	bh=lsM+ZQowe+rsl+rWKUkQhSYNrTZ45i/m86XkMVVCpfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLV1FgvwFQ0JtToUq3Ea0G7ERsPgDannEmYSytgfThIeC6s6aySM/hseha0CuVJA9HmuzvBVeKmZ6CcXnBt343vFtf/HKImbFI/Ci7PpN9YbK+0RMxjHC3oJVBe2l3w7Ih+4KDadJftPKbiqqNw6buA9JTAYIR0Ci5WE8RSIW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Jd7A7vHO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-64e93d9b14bso908083a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748773; x=1716353573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11MP8Alwq/xW6QpxNU4+RBkBTJftX5h6ydB0LOzhUSE=;
        b=Jd7A7vHOZHDJaITXle9+wF7bV5W/Y3wcVQ2s1F9/4Zv2clxq0kKauz8lE2d398RFI0
         0u1vrS8mlDECEulft97e/ND354Fw4qeXjB+/ZEB4nZDVE7yibBZvUPLOGWTYjx9BYDOa
         +TUbBcTvAaMIP621UW1obr37F1QpJoU/q8H0QjnpOitwsMVplUBtmDxZISk7HqGelF0A
         nGhfr9n9bNS7ARtm1YCNl1nhHvPMuuXdzB6D4JFTVvIaQnlMBi6BuyKBJiLB/UMvV+R0
         Dt+/SFnr985wl4AQtyLtqr2e+v5NtQBja2KljH9ccgcOm8nMbvNwfO8MDHOb8lJf3Omn
         /yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748773; x=1716353573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11MP8Alwq/xW6QpxNU4+RBkBTJftX5h6ydB0LOzhUSE=;
        b=ZL9+HMeizowgAbDEmEgNWk4v4PFqbSYf/7K6gVytAHyeKi+5ejaO+2qFwfu6mdo/+2
         m2DX+cGNDViqmvyVPosRnmPVBj5IhC52BgL0fNIJCoDZg6QcTyBDVKyWKgeMCAlGUXwx
         WfEdOZhgqLo0TjrzJfVKt0x/DiQJgP8Xm5aJMxw2jHC5UWw9yYtoSRpUhtbpMCRDYY4B
         7/BzNDLltHxZ4ti5BLKKz7HfGODXZ860+9vquKc0GkoTSQ4nmgI3TX3i6knDkVtnFK5+
         HnUIbD2L+zf+EBF+Ih9mR1KEVpmM4/xAnGIQnHiQFsZSHGI84BcbDFQDfuGHWqihKSD4
         krFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ihO+1kXFAOYj99nJ6+tJf7ym9Oiak7r/5sSdC1zYyNEK0n+lL2u4BKQwyBFxrf5vT7ibB45L+brjRFRhDy1EMJOuFkCr8+Wj5q2L
X-Gm-Message-State: AOJu0YwCroz2kA1q/rLdxYZlhdgjstZUJKmc7QPFKCqjSmkeZAXHgblm
	OzAor8os9lQq+vmpaWSToF1eTBLFGV8WyZQdh8859ADZwElrMe0OJJ/4rl04Bmio1NHOJT7Zl+u
	w
X-Google-Smtp-Source: AGHT+IH1vMAWtTmaD+ju68xRIOdV0x6M6MQx+zRFjzS2mm8lKrYLLrNzqMXVXkeUtMrSiKT2Yidkqw==
X-Received: by 2002:a05:6a20:748e:b0:1aa:5b05:7926 with SMTP id adf61e73a8af0-1afde1b0209mr16415956637.39.1715748773321;
        Tue, 14 May 2024 21:52:53 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:53 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 27/31] Staging: rtl8192e: Rename variable CcxRmState
Date: Tue, 14 May 2024 21:52:24 -0700
Message-Id: <20240515045228.35928-28-tdavies@darkphysics.net>
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

Rename variable CcxRmState to ccx_rm_state
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b88c7cd399fb..ca69bb0965ba 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -913,7 +913,7 @@ struct rtllib_network {
 	bool	with_aironet_ie;
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
-	u8	CcxRmState[2];
+	u8	ccx_rm_state[2];
 	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 95dde1938874..fe72149aa81c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1813,12 +1813,12 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96 &&
 	    info_element->data[3] == 0x01) {
 		if (info_element->len == 6) {
-			memcpy(network->CcxRmState, &info_element->data[4], 2);
-			if (network->CcxRmState[0] != 0)
+			memcpy(network->ccx_rm_state, &info_element->data[4], 2);
+			if (network->ccx_rm_state[0] != 0)
 				network->ccx_rm_enable = true;
 			else
 				network->ccx_rm_enable = false;
-			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
+			network->mb_ssid_mask = network->ccx_rm_state[1] & 0x07;
 			if (network->mb_ssid_mask != 0) {
 				network->mb_ssid_valid = true;
 				network->mb_ssid_mask = 0xff <<
@@ -2347,7 +2347,7 @@ static inline void update_network(struct rtllib_device *ieee,
 
 	dst->with_aironet_ie = src->with_aironet_ie;
 	dst->ckip_supported = src->ckip_supported;
-	memcpy(dst->CcxRmState, src->CcxRmState, 2);
+	memcpy(dst->ccx_rm_state, src->ccx_rm_state, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->mb_ssid_valid = src->mb_ssid_valid;
-- 
2.30.2


