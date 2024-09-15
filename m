Return-Path: <linux-kernel+bounces-329648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197CD979448
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AB82870BB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDCA53A7;
	Sun, 15 Sep 2024 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="eHFH5Vv/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892111FAA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726364233; cv=none; b=ZtxGKE1MqottZZki4CtJW7JueMJIoeoMl+ePM4cM1yvve70WeOvXV/1YpTtToUBCBCve+5UgccrztgBhdT3s0TN1eWPF5S00kVNRs7l2cCAbQ6c9E476vWTmWO4yfxi332oYV2lOXyFkytp6J2VM2jZmYE5cnC1bDagwPVNzO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726364233; c=relaxed/simple;
	bh=e2DB0jY7CI7g9yMhLJrXFiC12wUCmyurX80yXHI+8ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aSMEhcsadTRJKYY/9RraQkAHnNOtjNt8bafAibD+lKzz0XLdHCQhjTJrS6tbZc2ZThG2rKeQ57QlzLbFRFYGMPOe0LPhZxIUwyI/i3OUkmpbkRTPBkuVB89XlP4Q+JGczcT7It3fYnS0d0POul6x4oyxeH0ElQfxzg9fRzHJgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=eHFH5Vv/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso1509950a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726364231; x=1726969031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qd+n/+pRJnLuOWSZ4DY2fGdQOZIdYewseGE889SHmks=;
        b=eHFH5Vv/ej3b+HbyGqFufdbn2lWFX9udp1iJPBgwlA0SFYqx4XTSyIf4+qbJpm9cx/
         G++AnBvpQnzph/mT5v90bXs69sPHbZ57peiOxVXpcuexhwq7jSFgpLchg7S4kJN8ZBSR
         +ctNUoO/VCSSy+HTPmBWd8TcwzcysklDZFIaMEA9vMDE27HVKjecaKggw6rHp5DrHRj+
         3P5QyKX4XykCN+SR3Nv/rI2qt+PrntaIoQ0S1/g6XCRiDxyY/7rLRlQH/rXFUNd7tL7i
         eGgOhhbKII84JGaAa9tiRLfw9QMvQbmZhL0o+7lird2KILuZ/8CLfjBynn8+Rz3UiXFV
         04eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726364231; x=1726969031;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd+n/+pRJnLuOWSZ4DY2fGdQOZIdYewseGE889SHmks=;
        b=WMXhzjSukIM2rXEc5kiN0pIaWUzUjMWw1ybzbo5Qarh1V4do5PWWAq71L8wmWCpl04
         6MpF3P2DJEynpMp0PFloyYiqmhkPuph52KHSjePYJmdlicyGuMo9hjiqlrlgmEIymcH5
         kx4xfsvPrxfMMQqRfrn1OCKg84NpGyoBVxTT1ohT+KITP0WawvVbdzk1Ut6o8Qxmk1Yj
         IyFfoUUYDr6yIJply0LHDppmWO9aKg5O5stM4lbaRvDcFxg/QXb1aI7zzED1RHRgcDpa
         PtARnYb9GzqRsajpGyYbr82ppe21pgw3gZdsjejX+5vj/BbWX5+CCtlexqWOv84qfIGf
         o7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDwfCy0fU0e4qtz9TbgtILsycwSAs6OBQ6cizq/12bBe9oioluj47scr35T5G3TmNsslU6ZBE8VnW2B4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4g75C6eIf2W9YqIxBMLcW1oGzbqpnaGwkgn7YVvKHovunzgDc
	wMOKGzq2HPWWRdNAWrG5A+/7oxathJCTr3MBmD9MAeLK2GFugmLf1y98eG9T4vM=
X-Google-Smtp-Source: AGHT+IGBzYZA6aqxcO/jlga0x7/3lidt29yrIn+ISrJpxc+g6woAA3sheKe9inzHSihEaDrpdgpEFQ==
X-Received: by 2002:a17:90b:2249:b0:2cf:2bf6:b030 with SMTP id 98e67ed59e1d1-2dbb9f057a9mr10878850a91.33.1726364230768;
        Sat, 14 Sep 2024 18:37:10 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbb9c3f21esm4431154a91.6.2024.09.14.18.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:37:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:36:58 +0900
Subject: [PATCH] Documentation: Fix config_acs= example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>
X-B4-Tracking: v=1; b=H4sIADk65mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ND3cTkYl1jAxPjRCNzY/PkZEsloMqCotS0zAqwKdGxtbUAZEX2xlU
 AAAA=
To: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

The documentation used to say:
> For example,
>   pci=config_acs=10x
> would configure all devices that support ACS to enable P2P Request
> Redirect, disable Translation Blocking, and leave Source Validation
> unchanged from whatever power-up or firmware set it to.

However, a flag specification always needs to be suffixed with "@" and a
PCI device string, which is missing in this example. It needs to be
suffixed with "@pci:0:0" to configure all devices that support ACS in
particular.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ee2984e46c06..5611903c27a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4604,7 +4604,7 @@
 				  '1' – force enabled
 				  'x' – unchanged
 				For example,
-				  pci=config_acs=10x
+				  pci=config_acs=10x@pci:0:0
 				would configure all devices that support
 				ACS to enable P2P Request Redirect, disable
 				Translation Blocking, and leave Source

---
base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
change-id: 20240911-acs-3043a2737cc9

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


