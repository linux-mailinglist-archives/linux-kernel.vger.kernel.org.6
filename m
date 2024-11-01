Return-Path: <linux-kernel+bounces-392118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D89B8FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E39D1F22AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31829185E53;
	Fri,  1 Nov 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+/Bp2HH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962ED2A1B2;
	Fri,  1 Nov 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458956; cv=none; b=t0IaTDs1OSoTd6FmiaMvL7CnMihr9p9tx0XdqGR1vNimkG9VtLJgTatPokbRZPNvN0MD8NZs9h1bK51c8DRt2fdLsaZQfT649/dUtqcb/3lu49Zvr8daXY/rwcsKCl8njRXX7P2f2yjLCCY6AZoAU63UMuW1NF3+1Qzl36tirYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458956; c=relaxed/simple;
	bh=SL1acbncjPLxtjg0ZmvMhHjeJZVn1j5RtS+TyX6Deks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hkZC78je5lImq2WLFRhjUCiKq0oBFHSXvC9sg88QQn5WBmFoMqJaGYblp+3qniRxzZdD8FRVCk8JvuKCEzxqDCWM1ltFDuMr8h0fHWZJw9GjZSOz/2dUzMmGd6hH1drz6eWLfBLjmJNoFmvPW/bjj0C5WMtmG96XBHXId+xnYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+/Bp2HH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso20161385e9.0;
        Fri, 01 Nov 2024 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730458952; x=1731063752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwPYMRGElaeiG6JSq5bTqnaG3KidHyWvWEm+AiFn5jM=;
        b=k+/Bp2HHyPs98e8+CmpvLYZNUEtk9AbAFa1+ct0ddL/3kgMFUN52ReNwvEAXkAPza8
         CGwbCDOSGlks986zDaGNJzV7evh2MvxBcsRkTqhNw/haXb01209vWh/mEoDQ2Y8n7bmg
         iG0SzzfeuaHBDmbgtVBa4E6JooQ+flugtWuy4oG6e5Ura+5wORXVYs/dickn2E6ep1SM
         mz3IkY8Y7Wxe28lSPI6Sz7SeHsPn3Fidmg948LJHKOmGaE22PmT+XDameGFMI50jGnBk
         6rr1VVKp98F4gFpZfPQ8LdK84J5wOnDmH/3TBgNXjxsiAYIjhVlbvyfKpyrXKSugpbXG
         5KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730458952; x=1731063752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwPYMRGElaeiG6JSq5bTqnaG3KidHyWvWEm+AiFn5jM=;
        b=byeX1/eRVz352w/+Y2Eu3c5yfCIYOPpWzcHR6Nwqw38mdjmpdL9lkp8UjJEJGCfekZ
         mbJHvOWYUvyqfGeT5Pesv2XthBSBT5QgaBjUl6wfa+eb0hPb0eWXMrT+wP/ShDh4m3UE
         rmr3FuDGZs0MSYCGz9oSv+UQfd0TIoXiCf51jfzF20RCRbmB2KoDZyC/MqfoeqgcQNAY
         hmMTCwkbGutzr8mfPYXOKAr7p3aIkMsUyi4d4ctF4OP2oEb/wZnEU9FuSUEAFDId4y7N
         Th5ulKyYOLtKGyYgX2/XisuGH3wlSbiGqEm9DLqmQ9TiA7Op3warZCRb8h4dt/A3PG8I
         iAhg==
X-Forwarded-Encrypted: i=1; AJvYcCU+8K8lYd96pdkAk5qwoGVuoo7EmEJMAGHy3OF+Okf0EQK3Lukko8qPhIw+6lt+pH9HV4wguW0/WUjP3KI=@vger.kernel.org, AJvYcCWsTgkkZhYqB/oJuOg/5mZS7vqSKMqL600v0vGOCu/2u4/IS7mVGax0OrLemssMHNgViDYKcB//WzBDiTI5AQLA5XOKNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdgu1hf1uwkHrbvtz2x8BhJnqTqGwYZbBoY0hHGCIAxRjGjeP
	KRQoyVSdVf11nCpl4NCtgMZts5Pcay+tf7iChoRUpoRA+0JuxJiL
X-Google-Smtp-Source: AGHT+IGPpN1k7U8dhuPazlyTNVRyQKtUMxHMlMvnkH+Bz9BObQigNk4a5upkXSy7J090IGXyvmqNfg==
X-Received: by 2002:a05:600c:3b22:b0:42c:a387:6a6f with SMTP id 5b1f17b1804b1-4328325638emr27908205e9.20.1730458952168;
        Fri, 01 Nov 2024 04:02:32 -0700 (PDT)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8471sm88708965e9.4.2024.11.01.04.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:02:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Kurt Borja <kuurtb@gmail.com>,
	Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] alienware-wmi: Fix spelling mistake "requieres" -> "requires"
Date: Fri,  1 Nov 2024 11:02:30 +0000
Message-Id: <20241101110230.3303197-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 62cb81750573..a800c28bb4d5 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1090,7 +1090,7 @@ static int __init alienware_wmi_init(void)
 		if (quirks->thermal)
 			quirks->gmode = true;
 		else
-			pr_warn("force_gmode requieres platform profile support\n");
+			pr_warn("force_gmode requires platform profile support\n");
 	}
 
 	ret = platform_driver_register(&platform_driver);
-- 
2.39.5


