Return-Path: <linux-kernel+bounces-174034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557048C0967
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A8E1F223D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F913D535;
	Thu,  9 May 2024 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="OEyUVNbe"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272013D29C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219606; cv=none; b=obzmyCYXXV1nJPjg7/HepFGY0JhfkGF6uZAdnTErZGQDqLpLCQyWJ6iyg1wIxM44MNelvuWi5x4jMoWSaG93Ve2q4px2weaPO7I2sM61gysO19CrRxJn62/eWFJugZVS1S839VGureZepZ1lwE2hgoFqO3HxPFaCtFD87isXsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219606; c=relaxed/simple;
	bh=wWc10zoCDVN8UkfWeHq9Syg1LnfqQTqJyi5bEAWpAkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNZr+vRMyRHR4qZCAHe7Htz7MJ8YXf0A1/71PSo79u2xb6+fKN1xJ+vhjXT3QnH7IGDwq6Qg9tPFUuNom5/JmfpFAeedd04RKbJY0wqm0XPv8WxGzltEI+6rbti8whZDZ4Bg9bYI8uNyN7xXU52hW6yKge+SuAGgd2/UO8hwBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=OEyUVNbe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so2767065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715219598; x=1715824398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHqHiQyAVeHyVJ0K9DBhYgyNwQ4VRoYKxLN88oizGgE=;
        b=OEyUVNbeDjrItW/VDEmtwSRJ62qQyjfEkiyTrsR4je4NKjv8kE9/0l8AHZWsX8WWgJ
         oGjDWRCV9+3VHmm6ib61tcI0YvA3IIqG0FM7Y6sb5Et1L0GHeECHT6lK14gzPLu9uN21
         Gj0/ueUUl8nWiNt4tuEcBB5DFlULUiWtfPhogGbrWanj8Vf191lDmORBSBWsxbT8llE0
         CGsISfpglmXjwZAaUDvrvP3wBrmfauR1k5s9QF0cnyFjriYX1bTtWKdUTwsHPHdI2ZyZ
         yjWxOu601LyRCJgWdVhPRIfduP3LZ2T4fHGp3bJwkbGilgSqbx7xFpU8GdykjFNpDfKp
         c01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219598; x=1715824398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHqHiQyAVeHyVJ0K9DBhYgyNwQ4VRoYKxLN88oizGgE=;
        b=EiF1s8YEh1h0OAUVJyTGcA8h29fDbc8rV/hGRfSbdGSnRm24WR015/DVvI0lxYcsTB
         RDpuY7nrYL/oqGaYUI+KEVz5ITRy8G9/lwAGUeRCchCoKdbnLDyxY2/RLfbxLOAOewro
         RurimMIRomTfivqtq+6CDSxn/Wyxdkclg9LdISqmW+10KdZPlT30jHrUp+0/k7ZAn2vd
         G4PCZ6sk1OsLYz65xwXixMORln3vIc9zRLojOW7nO5UQMt8Y7lJxnIEUZ1RQZB0+EM2I
         aTGjRwp8NNzWyV6Kl0nB/Pm1nvgEBvbv1LPYhNAPG/yg80ot8kJP42x5g+h3UJ1/pxcd
         SLHw==
X-Forwarded-Encrypted: i=1; AJvYcCUakuOJ4vVkhaCcG5mO/k1nQTYGG0M0sHn1jfwIB0NOc61rEwCrhzenHt47LrvPxzHQOC/04953dJq8xbkzQiWIwMivOBcPrOik/rdd
X-Gm-Message-State: AOJu0YzYv7gaVVijKuj7cNLw6XP+ZEWgq7zZ3SYinttDR2UdU88XmJSu
	Ca61M9+ytQFre/PgOUt5MrREhubstg/sVMeuvqoKz0gKcs+63i2DcCcAIr9EA6g=
X-Google-Smtp-Source: AGHT+IEhZ2pJBCfl1DKT6ud+R8/fivFjIpNW18fFmRukQkFcf5Rle+Flry48GAdfWk+93kBhW++3Ng==
X-Received: by 2002:a17:902:ce8b:b0:1e6:7732:a180 with SMTP id d9443c01a7336-1eeb078ffb8mr55322735ad.50.1715219597814;
        Wed, 08 May 2024 18:53:17 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d15dfsm2117465ad.62.2024.05.08.18.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:53:17 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 6/7] dt-bindings: display: panel: Add compatible for IVO t109nw41
Date: Thu,  9 May 2024 09:52:06 +0800
Message-Id: <20240509015207.3271370-7-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Chage since V5:

- No change.

V4: https://lore.kernel.org/all/20240507135234.1356855-7-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- No change.

V3: https://lore.kernel.org/all/20240424023010.2099949-7-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-7-yangcong5@huaqin.corp-partner.google.com/

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index baf8b053e375..c649fb085833 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -18,6 +18,8 @@ properties:
       - enum:
           # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
           - boe,nv110wum-l60
+          # IVO t109nw41 11.0" WUXGA TFT LCD panel
+          - ivo,t109nw41
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
       - const: himax,hx83102
-- 
2.25.1


