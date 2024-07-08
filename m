Return-Path: <linux-kernel+bounces-244525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363E92A580
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089AB283944
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120013EFEF;
	Mon,  8 Jul 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKmCIaXj"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C313F426;
	Mon,  8 Jul 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451942; cv=none; b=iZ4ZHtU/nLEaMUKyGVhPhjdIjEYKRsrtHZ1AVz+bldAzcXBOFQvNd2ezqIHOOpuxdlkJV525FlqesGCvje+Rq0ZyO6or6T4ahjVxBJXu44jQsBDI1sEkFK/bWj9GpgQAPk7D3dP3vcKe2wNhpWAYE1dyHAVSLQNRl+iFy5UJSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451942; c=relaxed/simple;
	bh=S4wdFE5mYwdlzL98v6PKiIlzLusgf9RSFez0pzc7VpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2c/aaRes4W+qyARkgtcrwjFnOpE3kWmCHbBN3/DAoqIvttDJqQexbSIEt4UsKTGLA7JEW/fj5kZCmvdwctu3oewsthSbUMOKOgGKtZYtOlGfBcgRX3iWRyD7vWONz99uop2MGlUkbhK0mVvCPah8iXLNFlZGgdhxDLTujDAZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKmCIaXj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso40148201fa.3;
        Mon, 08 Jul 2024 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451939; x=1721056739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSBUSiGrKda6Rclc8JKjTu2mlczLCGQS71CjDrMpfKo=;
        b=hKmCIaXjeybNMkJwvAg9cv4JJH9DxKnUh48bvUDGSrmL/n4IVtISFfsZLtDMT+EEp+
         Ycmk0h0UlRKchD2tVjG3fd029+Msii7T5CVOIe+N3aAcdctY7NIRt06ncxWmwg7yjeyJ
         XC1fC+e/wsYP5+0ecRf261FUnN1UcMWquX1WXRIu3Djp7q8mmaxL3dtctfeqlaUd/Vln
         KHQlPgCqsN9namqFjrzYcQ0ySdWv8dvyTeU4n1C4BB6Tt21M9Cv7OxWXu267HBYE1qrZ
         1VhbpTLjcW5QCZxiKGvWQAMx7kTjTDmyrjneQVN110wNbMAIEJVqxc3NfhO/iSiPCbm0
         0+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451939; x=1721056739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSBUSiGrKda6Rclc8JKjTu2mlczLCGQS71CjDrMpfKo=;
        b=rfn9dc7hcrIe6MnRWlVgcVX60SKTnQktIRCXujs9RcEfdl0TQhXh6cNkYrrsc46XMv
         MSKock91bUCHpPEanC9cvE/Q4pOsz0ERPU7OPhsc2N+2lQHzPDVz2VvPDghPopdcsLT7
         8vYz7TF8ixvDdoc9FU7cIDrKf+glbxI8c8XbQywHnJ7pLnZaM78z8/7FRX42vodBj3Oj
         Z55q8bnyrACq9UJPiQgoR6surKjUdYdjAiUL3APl7cd0PUS+kQLwSHIz0M+Rw/55koQ0
         x57woM5ZoP4m1wJ77WNafALOVj6uF2vUWpZPga39ZQ6Wq27YAgowSdK+BUHTkQJCCRSl
         MTkg==
X-Forwarded-Encrypted: i=1; AJvYcCWa0A3zuktjFT5wHUorCWACdlRyX9wCdUcS4ENai58Y1EzSTBC/hvWhT+VgVwsJR7z/faQWnTaDhbEBK4A4ETPJ1gOpFv0WNJIDVByB6jp5XRwWmo/M8ichUdZh9u+/Gy8/iTkxc4PUmA==
X-Gm-Message-State: AOJu0Yzyl43/rHfQK8VArgdh7PfgiAHytCkrgPXk0A8GjiY8y7D1PPBK
	yCupnkZsMdELNjidkWbkGEtPDhJhtc/G5N1piZey2i0eUA2F70uc
X-Google-Smtp-Source: AGHT+IHBOpU2TpGoqEtMyb1uE3hxIskr/IILSBqTmPyQ+zwbgIxWLN7Nwf+BZwShchhySLprAWHYaw==
X-Received: by 2002:a2e:86cc:0:b0:2ed:275d:aa44 with SMTP id 38308e7fff4ca-2eeb30fcd17mr242501fa.28.1720451939038;
        Mon, 08 Jul 2024 08:18:59 -0700 (PDT)
Received: from GLaDOS.tastitalia.local ([37.77.97.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58e113d1c45sm5537837a12.64.2024.07.08.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:18:58 -0700 (PDT)
From: stefano.radaelli21@gmail.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	"Noah J . Rosa" <noahj.rosa@gmail.com>
Subject: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add burst-mode-disabled
Date: Mon,  8 Jul 2024 17:18:56 +0200
Message-Id: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Stefano Radaelli <stefano.radaelli21@gmail.com>

It allows to disable Burst video mode

Co-developed-by: Noah J. Rosa <noahj.rosa@gmail.com>
Signed-off-by: Noah J. Rosa <noahj.rosa@gmail.com>
Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index 48a97bb3e2e0..eb9c8b6b6813 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -35,6 +35,9 @@ properties:
   vcc-supply:
     description: A 1.8V power supply (see regulator/regulator.yaml).
 
+  burst-mode-disabled:
+    description: Set Video Mode in Non-Burst Mode
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.34.1


