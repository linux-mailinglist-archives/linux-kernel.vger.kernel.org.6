Return-Path: <linux-kernel+bounces-523011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AEA3D0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCA7A7A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFE1E32DB;
	Thu, 20 Feb 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoeT73D7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEB1D5AC2;
	Thu, 20 Feb 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030224; cv=none; b=AwSqSzVl3hActrGWwV7P+cbe/mioxyDTvgN6WyxjZrF8qE0oU9Klp4LL7DMYDwF45I4nSHtmNy3jJ/Rc3sbIEp72kmXa4KcKJsl2q2y9HEmFiCN0u0RyEhq5IJq/jWtjWdTM+YNYJRNPUsNndAYtiUtinabWfccZxwFnkQWMfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030224; c=relaxed/simple;
	bh=Soe1paClsXr97ESMLlXDmT4qTYNBUNJwcL8thnWLQ64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clo6svZPWiUWprIKuBcCDteVHHdsg6vzxe3SFO+ktPTZjsVu7aMiMY/qzs2UGSOPhtx3UkLqADSFg1wC3NDdDKaIRPLDRe7YhXxy1TrfZT80WkhA845CMY3BBdKIi5q+EaQbF6xtVJ4YbFvpgI98bxYdzG07UM9nMNbn0YoOOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoeT73D7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d132f16dso7797865ad.0;
        Wed, 19 Feb 2025 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030223; x=1740635023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgZldDq/yO5VWimSLneZAx8qBmg/WC4f9EIjy2qwa9M=;
        b=PoeT73D7izhJy50vdb3kbHUAgQtiLk2HZNBwTzcVXi23k4jNRlcvG3ThA87+bLLuL3
         trvoZZFpR8nfGVNujLIiypuo0HMxloPMrp9pfcAfSJm8aQ8TQPjl6c0DSBqfCcmD3HGE
         BSVWT5Zq3QlvO609d//ghGP31jhkVE+/20yO6INjnXfMOPUo0j4Az86/HuoulbgVHS1m
         AulGFrm1pwdnbyxw1l8tQ+nhmeRp2ZFHLBI1GIxw07ptlSBPB1Lu5vgDqGUBjBAF5waX
         fuQMzAT/yGBujqcLRiP1lDTDhhjjyrEwWwssm8Urw5PWDDuzvmAY9/yJXgG3rWoD6h8Y
         AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030223; x=1740635023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgZldDq/yO5VWimSLneZAx8qBmg/WC4f9EIjy2qwa9M=;
        b=XI2oTJlA1Y1WB+9dcnbp39qB6PD7gOIqXHXVQDQ8m2UQ46XdOvzyqLFcVxpRy5QXRR
         RMm3jNjUJ15TmM5fyGEGI3OQ6OG40fyw5QJraK4EL6G+5TeqAoiCFrgMnwbMEpcucgvJ
         48ZDJgfjDl+Xsd+XWmnQHY190l7YMYIwXFpsGvuy1DCbWSqccWkvIvRZ8nMZeDNCC0nW
         TnZ7rJqegIKBb8GAaQzdrHcJHRVUyyYbbZXhM1luGM6SNcvTH9ESL7enPjtuVPFBIWw7
         sqV06/SEO/qjPyqjJev58xD7nq3FQj/8OgwonADe0Jv5jkiXGmt4TWQj7EqmLN3saB2q
         aGfg==
X-Forwarded-Encrypted: i=1; AJvYcCVU9CS0tDHkKU+G+6JIboKjni/P95qqniLArum24UZZD5aXDK40P79kDr7HbriLsRV9hhpkBeMe4nww@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUc0orN1cvWY53HOeOhS/eIg35Piw5XjqUPBk5DCqN0omKq8n
	SjbVYuCnJF4Gr6rXU+BsSPmHbKMmKJwjAx1665TcIbtsfbIvdQn+
X-Gm-Gg: ASbGncsHf40NAo4yE9ZXh3opZrs6cG8BwIL1hrwDoLPoeszycCDAO0JYAbIllDnJPfX
	R0VQJ6QYYsOQ9mQZpk/Bbk9+m8Ula4w0JN1JP8XYBWkmG54mIp7Or/YtDn/CYj7G2c6UnUyj60V
	QlkM5VUY9Zetk9Sdtwu90UCyPK1NxEG80UHcsGz3FMk3lXLE/waHmARtq+9hJYgb/ZuFlW6AahD
	sSjXdHUb/L6M6yqRvjk5p/3zLa3doSgTsWLeFkoWIWqhNYBd37Ign+FqDLHTgSS3VMyCHTtt/76
	jH2mcPGXUbzRtRxFMIIBWTjwXg==
X-Google-Smtp-Source: AGHT+IGOuexKVK1tbntilKykXaiulzDeL4fR6GsXUklJqCXs1Z6nh+tCq7/cp3Zmnlk6wCOHB/ZbHg==
X-Received: by 2002:a17:902:ea0d:b0:220:fae9:8a4 with SMTP id d9443c01a7336-2217055dda9mr81177595ad.6.1740030222489;
        Wed, 19 Feb 2025 21:43:42 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534951fsm114415335ad.25.2025.02.19.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:43:42 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 0/4] Add support for Nuvoton npcm845 i3c controller
Date: Thu, 20 Feb 2025 13:43:26 +0800
Message-Id: <20250220054330.1711979-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the Nuvoton npcm845
Board Management controller (BMC) SoC family.

The Nuvoton npcm845 uses the same Silvico IP but an older version.
This patchset adds fixes for the npcm845 specific hardware issues.

---
v2:
 - Add a new compatible string in dt-binding doc.
 - Add driver data for npcm845 to address the quirks.
 - Modify svc_i3c_master_write to be reused by SVC_I3C_QUIRK_FIFO_EMPTY fix.
 - Fix typo of SVC_I3C_QUIRK_FALSE_SLVSTART fix.
 - Remove the code changes in svc_i3c_master_do_daa_locked, will add it in
   another patch series for common improvement.
---

Stanley Chu (4):
  dt-bindings: i3c: silvaco: Add npcm845 compatible string
  i3c: master: svc: Add support for Nuvoton npcm845 i3c
  i3c: master: svc: Fix npcm845 FIFO empty issue
  i3c: master: svc: Fix npcm845 invalid slvstart event

 .../bindings/i3c/silvaco,i3c-master.yaml      |  4 +-
 drivers/i3c/master/svc-i3c-master.c           | 57 +++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.34.1


