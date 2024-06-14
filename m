Return-Path: <linux-kernel+bounces-215062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFC908E02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640BBB25B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A515FA63;
	Fri, 14 Jun 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="b7+CNIf7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65915B562
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377005; cv=none; b=hHtSiBXCEjsGJo41re5bAWlSKSP9mKMKYGr1IBHclSXlHcT/qaUhTx+tVvhPjWvykkDu/QtLAd3BU1Eouz0IGPj8t72la7a6SDQ4utkgem6PjB9pob8Yyz/cFa2MjM4UE0h4oBI1NrC7XXIg07RU+3OWtRm635/4H7mgMtWO/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377005; c=relaxed/simple;
	bh=Imc1ZC8wdBF7tQ5sezWssucdy/my4+uQ6epKE2jjlKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H1TBb6NXnOtzmZxMuqR6Y+fC5nIQkeI36flGKuRn2Bu9CipRMdCWGX2kqhpReuFz0lRN6hoWvEdsk+vuHwLaxcI4E8TXHM/nXO6vJ0qYB/h2EqZ46Y+TblOt7qh2SdBLy7SA4RwNzC9ybQU+I/JeWJ1IDoGO2rjR6/khklUXggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=b7+CNIf7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c3051aee3fso1925013a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718376987; x=1718981787; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwvUq+bFsQM3xrcbj1WxFnxCDtbNpy9qSWYJxJxGyfQ=;
        b=b7+CNIf7kiL7mNflu7oEQQ31y1M/ITPXikFzL2MmfW69hAPggQmcwNZfLX7lV7D6rY
         R96ULMSviTtO2mBm5d/peAC75CsDdvPW7BolOHcewmAvj+KghNBmN2ks9S6k3U2AnKzZ
         G5LpguQeOGYOvJxikeUSnkuC8N2L+LFdNgu5OJtz7lwa3PSl6JqyJ54BRtxJwhCOMLuJ
         5USvFtOcc/djF/VYSmIImUv0pDz/+8FheOVhqAf7P2WLk92EJfs6+DANpIAC6sN1enm9
         8c2mJYN4zwWl4t1x/WAO9GcOcbVet+iO3f5VVNrV0OEcEnU5xAs9zrmasK7fA9elVQJi
         q4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376987; x=1718981787;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwvUq+bFsQM3xrcbj1WxFnxCDtbNpy9qSWYJxJxGyfQ=;
        b=eEPVU6dmSRhQq2lQdRzAOE2lFl7AnhKk7jj50j47vIrJeaL6eiWVP3beXLqgvxbdB9
         XJ4iFzHK/3CbHktPiUrDB/o+XqY1WrC3UWJx6t7+vnE+3qhq5cLgXvkQRGM7yZtGrT3d
         pPz/4SldrPc8l+87K1Z9rCk0l+eWxcP4dr8GifXz7S3tex6qvE1IqgVssFhSZaVE6VSv
         7B+dOPn5RpX3tiWKiYvR3piJjxpq03FNtWCKMu0AeHPr9L/kLkPMY+YzgV7GXUkwMMDv
         PEjU7wkksXmWO45CrAcpOvR+C62bTJw7BEUOCSnunQoo2OQJVIs9xmwYehzYgtQTTXWU
         B2TA==
X-Forwarded-Encrypted: i=1; AJvYcCUmyefkIPFsKtLD5UYkPV8KzbYYxAXPe4aqBPYvst2APx4SQWMa3OeWFSjflSaaPz1nEHxiwaVBD+PUfTWtOd6WC1/3XWARwK8w+MPt
X-Gm-Message-State: AOJu0Yz17n1F9UsWjJKk1/laOVQ2WcdqX2k5D7M/UJotVZe4x85ZE4vW
	pbcVg6k4AxPsJnfp0AviT/4bdb5OLBMjqOcym0A8+mGiao6VCKTwV6uEvG5Tqqg=
X-Google-Smtp-Source: AGHT+IFsV5sgy7hyN2DHEA1XPsRcjaveUHUD2OKyasTaSs7h5S8bOv8+lGvy2k3pyCIj6KfwMvj3gQ==
X-Received: by 2002:a17:90a:17ad:b0:2c2:c79f:944 with SMTP id 98e67ed59e1d1-2c4db241e4amr3288257a91.14.1718376987343;
        Fri, 14 Jun 2024 07:56:27 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c60fsm3985913a91.53.2024.06.14.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:56:26 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel-simple-dsi: add Starry-er88577 DSI panel bindings
Date: Fri, 14 Jun 2024 22:56:08 +0800
Message-Id: <20240614145609.25432-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This add the bindings for the 1280x800 TFT LCD Starry-er88577 DSI panel
to panel-simple-dsi.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---

Chage since V3:

-  Separate the Starry bindings from kingdisplay, and add it to panel-simple-dsi.yaml

v2: https://lore.kernel.org/all/20240601084528.22502-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Chage since V2:

-  Add compatible for Starry er88577 in Kingdisplay kd101ne3 dt-bindings.
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index db5acd2807ed..1f04acefba4e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -60,6 +60,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
+      - starry,er88577
 
   reg:
     maxItems: 1
-- 
2.17.1


