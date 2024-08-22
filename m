Return-Path: <linux-kernel+bounces-296299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF495A8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82B72827E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585285661;
	Thu, 22 Aug 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCa0XZSn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC94C81
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286425; cv=none; b=aDXLYdAuQCGP17ljoq13SJuHilFy/j155zf9mNs8hFYjw3sOPY1b+oUFRfLOx2awM2H6V1kBib+DAfJO4NvC9k9rmqXzBiWSnLwGvXojB1ISl+E1M4pJA2dmCBsBEG9CNBxOfNBEFaWLfP1VUx9wI6fgGEa4wJ+jMfEhkyow4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286425; c=relaxed/simple;
	bh=meburOTuZMLHPYgqfoHfd6vrVObsNhzhsmWmRE5ijQA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IjcOxOVhmj6v/Y8RjNXmOJoqxCc9Gcl2kebnsEoDBb7zy26EBYuDWlQpB9xsBY+PYe8+NUIEVRBdeOvNg0u6qm0BmzaGrYo+EXBkZI7YvrOuZvUp+uOfIxYJyaTo7u632gzu+KC8Tvu8E0ouqNyGFaQstUdoNBn8EvYJ78jAYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCa0XZSn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20203988f37so2291545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286424; x=1724891224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTe8UZvf5x/OVSuUip0xn9D9/lWdiUo1j0pjYyI1a7U=;
        b=TCa0XZSn+4gUM0yZeoSmzESMWXIDK2IkQsEAkfjWNfwwxCrCVcnrzVoqPHvsohgwJ0
         GyIbGG43nS/ec5MB5P1YwQv2Bz9nH62DNSlXSRxM2/g3SZTov7zjYRpJwhw9olQQ4tzD
         KtRMAddiw1vf8J/Diahiq4dTnRKqtVyjNbOj2SvatcNmSP1CmQiMrq2+DKaIFUmXEY9Y
         95ALwkwWBB0L3fjBjKyD48e85PMy3HXjK5J1lHpjLstNOoV5rqwACj4D1W+PIecYqL66
         Qs77pb6jXUlyMWeeO+Q7Hpd6RDWelNztVCo/sp2/oVjWp1/RnYPfaZU4Pu2yj8mHU59M
         1CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286424; x=1724891224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTe8UZvf5x/OVSuUip0xn9D9/lWdiUo1j0pjYyI1a7U=;
        b=VJGc3Tt98Iz9yxG5wRa264PuSItskQ4hW3yb9q9gbCi/8zOXQYAHHX9Lff5Irk+iRD
         VkwgMpbec77VwcXvFrqkjaqas8k/Op9KNlibdwGtgJA7n3tBgot89c9Q82ZdlLZK67Uf
         fENecpGET+5SeUQL6pM5gP5veMnKUHRZlEMGcYuEjobo+2UaHocb38YmlUPRwk5AqbEt
         uP/GP9mHB/PWWAEL+wefkG6smKE/VD96wChLM6QZ1AqQThimBCQDOr8D2CcAq0y2K3rL
         qX2c28tkWLHrfMaYlofJNrkatmoi+BwZtO/hIkIXlgzSAvvFQKj0qnlWtOXRuo+aQiBi
         /BKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfyPjoL13qyz4Jrw5miMCtFW5ca9fGxD0SE7juooyJ0QHO1aTHYLCs+foSArjwMIrXItIpaMVGqwDXh1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HML6YwBzqOG8ZUO9eD3HHCSU1oXYcPeT9nsCQsUw1X5pcDD4
	7XAahs3HVQZtaiMePWj/0nLXwsYk8NLa9KkWqWDiYS5RY0ao9sBzZX7aLZM/jcY=
X-Google-Smtp-Source: AGHT+IE4cVQNQLgPRErKli0tV7ew+G/AvDBgEaurVCpADHbCSbXxyBOdFms2vuWw+LxZLQNae3SUpQ==
X-Received: by 2002:a17:902:d2c1:b0:202:708:343b with SMTP id d9443c01a7336-2036821e1c6mr44870925ad.65.1724286423670;
        Wed, 21 Aug 2024 17:27:03 -0700 (PDT)
Received: from orlandobook.unicamp.br ([2801:8a:c811:1:5276:8462:6a5a:930b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855664d5sm1725915ad.31.2024.08.21.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:27:03 -0700 (PDT)
From: Pedro Orlando <scramblerdoodle@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:26:58 -0300
Message-Id: <20240822002658.33672-1-scramblerdoodle@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix parenthesis alignment in _rtl92e_wx_set_encode_ext to fix
checkpatch warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Pedro Orlando <scramblerdoodle@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index c21a0560410a..fc8e7f73b2a4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -675,7 +675,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 		u8 idx = 0, alg = 0, group = 0;
 
 		if ((encoding->flags & IW_ENCODE_DISABLED) ||
-		     ext->alg == IW_ENCODE_ALG_NONE) {
+		    ext->alg == IW_ENCODE_ALG_NONE) {
 			ieee->pairwise_key_type = ieee->group_key_type
 						= KEY_TYPE_NA;
 			rtl92e_cam_reset(dev);
@@ -710,7 +710,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 			rtl92e_set_swcam(dev, idx, idx, alg, broadcast_addr, key);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->ht_info->current_ht_support)
+			    ieee->ht_info->current_ht_support)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
-- 
2.34.1


