Return-Path: <linux-kernel+bounces-294830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED495932D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066D31F23E48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363A15C129;
	Wed, 21 Aug 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="keSJsf8x"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390522619
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209745; cv=none; b=ZcGvpGmpDcyTs9tBvBTXSMwWycoyjnqdV2XzM1q9wb941+JqfUjzskUBVEKr08Kh3N9eUrnIoeiliUgqyt70A+nh1mr2pOmtZ90nkOt1+27H6JAcfKow82UDLUGunN3fVSmxcOHN3+cYnfRqhHJRDlWNM5hqQrR3v7TSyLfNExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209745; c=relaxed/simple;
	bh=1Av+PuZOoDYh2k4NZ6QZDE4Eke1SlZ91iumF9rXODRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMQFylwkXYPtn/5uc4fXyuDkSR2RL8jNxnAfnaJnGMelSJ2J5mtimIYOL23WQu1dakyohSmPBuVBWgETeUJvfV8dVJOxJQuaMMrYim0hkYDqrwwRHfue4pWnNUqnOpAeAoZdlmcbk9KlwuXJpNie/6USopFGKku4hT8OBHwol4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=keSJsf8x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7141d7b270dso758990b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209743; x=1724814543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+piblWHiJyw3dOHLH5I47bMeAehXIK9gihiM+97PvQ=;
        b=keSJsf8x4xE2TtcVuDkiu5UTOD5bumeZ9f3zUAAQeLiJL1NHtOYxgSiE8H5sV8+XKY
         flsg9b3u/2gGkD3pkBb9WkWz1xnTiXED2+tSZlUXZXHagf4MuB2BbtH76tDUPowH6PbK
         N8uZvqqxbfT8zIq5AIES93HdyStxy4E1yoLEK5OBmPotARkCkdSNFRPqkT+KO71czLxC
         s9/ClGitsmFSfhosEi2eBGb+cNfNSpVEi9xnEGcdvq9UGQSKlEuWwAe5dWLnLVWfYWmM
         lGcILlpwKMZnIUA1gO1iMss/gPxmbOpo4aMatR+jPmI5ZEd6HgfaanyEPZPstJ4Pl5Mq
         b56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209743; x=1724814543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+piblWHiJyw3dOHLH5I47bMeAehXIK9gihiM+97PvQ=;
        b=vmz1DCBjl0q/DpyYNY96+Y2lYOlDjIKmzUu703Fd8Hyqbdl509gusUqAHLK+I3Xfj1
         w8nOaO9T/8z8/YMLQgtlu+RCMeKPOrI6wZj+PtYQq3W4OXmTfwY4YkidOsFx5Sx10BTz
         NBfjsX2yrQdZEuMcPstjLJwAeWNHH132uZ8ayuqJXK/0ujWZn8uhByI+GKN5CKbOMPBG
         yYmsmQEdliE2zJ6YO9MlYZx0X2vODoeBuaNgdw7wZlyyvrl3EmIb6i4VrecYHk1i9B8+
         Zvjio/gGS8o+5GMtkGWnzXOoPYND8H7f/bUZeV/uE0aPSBE0f1czEddDM4k0bWKHGy1O
         T+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAXaORHxLw5roMFadM94dybWcOvTdkV2d0DU3erdIa9FOKS9vsIs5pw+mE37itdjxUmHV/lSGME8VW3W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4n0yoMSRD1P94orSntxEFHxNO7mpu/Ysc8u5slU+Z7hFvYpH
	EUMFK1yH82dI8E6mnxvFzdOyk+AxFVBv4sCK8XOZCw5G7qlk0Uqhrf2hjcULm63R+F2/ZJCfi+R
	N5mA=
X-Google-Smtp-Source: AGHT+IERATv4xTSL7nRdoVV4/H1PTZtwyK+OCOJ0PcafPc7TTidobAkmmCzgLuMsLDVSxSx7EP4pYQ==
X-Received: by 2002:a05:6a00:91ce:b0:714:1c0e:1336 with SMTP id d2e1a72fcca58-7142344325emr1300505b3a.4.1724209742849;
        Tue, 20 Aug 2024 20:09:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:02 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/6] Staging: rtl8192e: Rename variable CmdID_BBRegWrite10
Date: Tue, 20 Aug 2024 20:08:53 -0700
Message-Id: <20240821030856.57423-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240821030856.57423-1-tdavies@darkphysics.net>
References: <20240821030856.57423-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CmdID_BBRegWrite10 to cmd_id_bbreg_write10
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 19afb056520e..0eaca4be4f15 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -155,7 +155,7 @@ struct cb_desc {
 enum sw_chnl_cmd_id {
 	cmd_id_end,
 	cmd_id_set_tx_power_level,
-	CmdID_BBRegWrite10,
+	cmd_id_bbreg_write10,
 	CmdID_WritePortUlong,
 	CmdID_WritePortUshort,
 	CmdID_WritePortUchar,
-- 
2.30.2


