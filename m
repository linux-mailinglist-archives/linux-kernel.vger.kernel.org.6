Return-Path: <linux-kernel+bounces-565491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EDA6697C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DDB3B9787
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB461D90C5;
	Tue, 18 Mar 2025 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvWx5BAz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83986198823
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276198; cv=none; b=Qiqlt+MzykTGntExyjvBsm0YGGL5zGD+VgfcYI+SOQlzgSqi6p/M4hnItKhFrOn1hSW+WxwlTVmAe/mDV9LlRlseuelgiQue4h7g/kHDQuVkKms4ktKXIL3aYwSN7+wqtYH/QLQprBSa3SHzhHCr8/4r9e5pipi0/8G1kuJCAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276198; c=relaxed/simple;
	bh=QIF4KUSFHzWAgGYaR66ayatH3tkKk6gzz62eiEOD8nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2Ss4be2TmVLJD8D6cSJatB5BgNfrvcfBRjWH2mo7shPy//YNrZczShb5BU2K5hlURTReookZNNdD2dSSMBVs4RKDfJVbjKbydj5TNIutaOzUR/Is3d5tDAUxfiHsN1gvahItH67EhlZAkrI+SgcOWL4tsfIHuhN5Anw6aZ4o/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvWx5BAz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224100e9a5cso99471375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276197; x=1742880997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAXz5zFV/dNZck8AAhHpDywdjolmlMduTc9D2SMrXCY=;
        b=dvWx5BAzlV3/+UKXRlknjw1qGgTAIqy/fyW109+YbDh7soTSoi7twqNDutmH9Opg61
         rYqoq0Oobx5UNm1gQmBjBBOuYuuiBGYZxaRFhyugyi4GR+HZ/LKwiqBmnZHr7b2XqgRM
         +TqAssJQvFoz2qjN4fsbhc482nRRoOVu0aJtWciYdGi0vcYa8Enh4Yj4fQMy7ykvoEmO
         908TpXQji7LTkpvJfb4Egg/Sh0/VeuBB5OpcZPMWnlfun9OSlbbjRucIhOL0keS4yyV9
         MrxMAJ98LBUDVCVzhpzqJZeYhcpr4XagiDB8VhnhseW7T/igl9968plm3y3RMJTRp3PR
         zNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276197; x=1742880997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAXz5zFV/dNZck8AAhHpDywdjolmlMduTc9D2SMrXCY=;
        b=Rfo4j5o3gidPP9r9/q6lqCmTC7C0BeKrF6o4fWEjG59UnoA2jyCorj2+qgDLOcZgeo
         /LmXSce0+GAjb0/o2P3l4vu2nH0Nj/+fYf0WrzLCqyedqOGpe/WyVx+IP5syPPLLegWk
         2NK1BFeWsF4Fq9Qq+fG5Gb8Dah2Eb0PWcojtRzX9JinPan0hZS3jdTsl3cNFkBUQcIiT
         iMKOlWuEtWxc+R+g0gkgJl1rOZEvzhwQzAhYogNunxKvNuGxPdDuf2QHEcZnuXvHLt0c
         UqRkHEqjtZS1BykpT7RJ1eTLjpWaETDKbsQ1KT/vNW6Wb7Atk3rAhBxHLyzwEBNF8gGh
         zg+w==
X-Gm-Message-State: AOJu0YxiQUp+xj2HEnlbFo1yYgN4A2Cshzg2Ni/KZX6NaF7OayX7CrLW
	6FfYgISd66mK/dLQ3kQtZ9qLEkUI/SWyLUH5Gj0a60dEag78o/Xs
X-Gm-Gg: ASbGncsL/r6SRADS50kM02Fn4UAv4YMTg39rc7W95M4GiPQIzmF7EV0Zs2uWp++pa81
	GsjRa3l93Q48Wca50nOzUA2lY5XlJ1AGaVeMdl331s4/rG4psm/ckNOrE/fFMDyv7qoJRROVXKs
	ay0sIwFecoF1ueVjV2da/uWjki+tLJDPNmnsAjAts4RdT+EjkjpWGvjY6mmTPfA2wdyO6AjzJSY
	pLh1LyzNqRArfR2gt/8ZZ+sQwOB3gSN6At0SY88sCrYNC+y863d6G4Vev7HndWIA6OohrP13DlQ
	Gv0MzmJNll41OcjLYe/mrtk5sOf9Kv5Ln+AKxy0l5fW6xWfkd972OFA=
X-Google-Smtp-Source: AGHT+IH8K71L41KaQuidRb124ubL5NH0GzYCl4FWRdtxSZGd+wGA+J5yLIlXt4vfeFTUswsRyFIAtg==
X-Received: by 2002:a17:902:ce8d:b0:224:721:ed9 with SMTP id d9443c01a7336-225e0b118ebmr195585385ad.44.1742276196636;
        Mon, 17 Mar 2025 22:36:36 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:dc02:2d2e:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f09sm85299905ad.133.2025.03.17.22.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:36:36 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 1/3] i3c: master: svc: Fix missing the IBI rules
Date: Tue, 18 Mar 2025 13:36:04 +0800
Message-Id: <20250318053606.3087121-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318053606.3087121-1-yschu@nuvoton.com>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The code does not add IBI rules for devices with controller capability.
However, the secondary controller has the controller capability and works
at target mode when the device is probed. Therefore, add IBI rules for
such devices.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1d1f351b9a85..a72ba5a7edd4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1106,7 +1106,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
 
 	/* Create the IBIRULES register for both cases */
 	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
-		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
+		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
 			continue;
 
 		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
-- 
2.34.1


