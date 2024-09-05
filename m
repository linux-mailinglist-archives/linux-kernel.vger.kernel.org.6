Return-Path: <linux-kernel+bounces-316864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7A996D65C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C3B213FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF241990DB;
	Thu,  5 Sep 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTGbmGDZ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C183CDB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533298; cv=none; b=XqYYV5wi1d9PdVJRoFWihmG6E3Px7jCVGHmCmOWcieN2plYW0JdK+dYMef3SrJTJLxobGow6Kjt/vQAEeKhKPzNIz4Br9VfkjS0/sS1tFM48Gn13zboWbMb06PglPslaw8/gW3KtMw0nFWfN1CQdH88QMjnI+9ln1TkzT2Klm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533298; c=relaxed/simple;
	bh=DO9D/HmmhJ+O7uZDv2XbBgjZhz4HCv4rtuU0w6lIwA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+c8bP8tcuqTA6yNtJxcSD9HFgpanYWzr4FHoI3tIxQjnAJqpLD+1hzXM1StVknly52+hg4JW8jC3y9C8sCbzovzqzf/vpgXnr3L/Xev/MFggQr/v3grcr7S0tpRm83NrarJzJGtB567o98GPp40HHgD6BRm2dNan8tOMvk1Yqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTGbmGDZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715c160e231so494897b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725533297; x=1726138097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5JosH/TSZ+3z0V86f0XRHzDYZAZDYK98WtJ6SVh/pU=;
        b=lTGbmGDZCmRuWUPl6cLDgQd77omnrBr2SfQXMWFgD3CId5PM286IMWmHk6wziJIgqS
         9cHrHY4TdbZFJerxm/v2qsK8yejEulvgjtWscv/Uvys1h5gcb2DMfzuEUU2bHuQUaflI
         OTYS2at91GtEwZDUg19++3g4kCswODacT4CP1rFiBLQsCcT0YK/uXOOOI0xfPJom+YiJ
         vWF1CAiCUgfn4YeseU4DF4YiWNUno0y1GDUoZ+PYZDGiHOx2xgTpS1QqYUg4OTbVuSo0
         aYK4YC/wj9N/W8eD6IcQ7jmMDeehxklrw9LQrOu43y3mzngASHfP875eV61TT+trPzgA
         62eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533297; x=1726138097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5JosH/TSZ+3z0V86f0XRHzDYZAZDYK98WtJ6SVh/pU=;
        b=rjFRlPgO7oiW3GO1VQkhf+KNTWpJ24vkKm+hxUyp+RD71MPK/KhWX0HYuAxrASHCJh
         rAijzWxNY7s63uxPbaif8Xr5Cs/Bmq9nE+LBoV+sds9jF0Fd52hwItv1skSZTLcSdH7S
         tNMVzCg65Fbm7n6XF/Xtxue2ag3OTcjkn4CAvMawYz2RImG5afVIk7G7ujnRTm8vdbY2
         w3fFsfsY1LPY/hrqA8FrBq0GxRb81ME4pQ9HF2rT1ZSWAYnf2vbjzkIOXQUkiKn6JED2
         BCRMYZzVPAgxztTh9CiGKvyOALgFXQLAZO40cCLqOvhcIl339IBy3Z2aoYQgrZ32zMcI
         p2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWCo8YWKaJ+4LkF95QrTtrzXF7Ge4wCinw2jRFLQc9rFrDduFlhhbKXWZMDGSat+mWejxUlULsvdVSwAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGiWifhiyQRYBpsdlfj0fRifKgPDgsWzwMiwtQam0CzE1ivDO
	f7ImtSD5kDthGE12Qq9dsVFdRqleSce5K2440qi9EqUZi40MnJyu
X-Google-Smtp-Source: AGHT+IGYmeg+4H/omJ8PsGV3QMhUTQ+JAfAHbF0G5LI1fc+8R87Zg42A5ahkw0md8zVte5a/+X5vJw==
X-Received: by 2002:a05:6a21:6802:b0:1cc:da14:316a with SMTP id adf61e73a8af0-1cce1011e17mr24686188637.20.1725533296751;
        Thu, 05 Sep 2024 03:48:16 -0700 (PDT)
Received: from localhost.localdomain ([123.124.208.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858be84sm2976947b3a.110.2024.09.05.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:48:16 -0700 (PDT)
From: Wang Yibo <lcnwed@gmail.com>
X-Google-Original-From: Wang Yibo <wangyibo@uniontech.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	lcnwed@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	trivial@kernel.org,
	wangyibo@uniontech.com
Subject: [PATCH v2 1/1] mm: move bad zone checking in gfp_zone()
Date: Thu,  5 Sep 2024 18:48:08 +0800
Message-Id: <20240905104808.27528-1-wangyibo@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
References: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flags in gfp_zone() has an error combination,
VM_BUG_ON() should first know it before use it.

Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
---
 include/linux/gfp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f53f76e0b17e..ca61b2440ab3 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags)
 {
 	enum zone_type z;
 	int bit = (__force int) (flags & GFP_ZONEMASK);
+	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
 
 	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
 					 ((1 << GFP_ZONES_SHIFT) - 1);
-	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
+
 	return z;
 }
 
-- 
2.20.1


