Return-Path: <linux-kernel+bounces-179334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B38C5EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB89281DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCF36120;
	Wed, 15 May 2024 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="f0A3XT3/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837C2C1B8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737634; cv=none; b=dP1/MnrrgQuUfD8G3HwUA6M8Niws1sDjEISI7/Q67vBIf3tPbGPoaCezf+CFo+lIYuM8aRP2kb4gc4o4eLhxqTO6GER7u1tOOCszleT1ZsIR1VymldI/Z2KiFpUXeKCHSJ0fUxnNCkufJmRWN3Ocv70Gpv4HxTXETQ7EvFMURQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737634; c=relaxed/simple;
	bh=m8Izs/dC0mzqS1r91F1GUsRMXP8o6mG9BZCsgr5nR/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQqrcbWWra4I/0rwI9ddxAHCiR6g5qaKy4bHaeB8Es5PqZ6xB05DPTx/VeWpdaYnre72QJG/3aTvIkmY2oADmodcAV9QtWw1a6LGBgAmhq7oCt8U7LQqn1KpgwzSNXnsRkr5rcRP9haxvElEMQ1fmMEqTxjKKZyHqHGtkZ0Uu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=f0A3XT3/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecddf96313so53716055ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715737627; x=1716342427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY2J/IHNT9VBahxPZDvJ2CAQ+h9iFMMF2YRGy2pIyWc=;
        b=f0A3XT3/pfLE4e/7PMuKXc4Y9Ygb0M4c7PgDhFSAGwhBgRofXh5zV32GF1u0qykq5m
         r3hThXnsxB8XeAdjfS9GSi5h5w/cVaOe6TjGaltJv5gh8XpPSLXNlBZGW0yT/lisqBRR
         4cqils2RlHxJnpPUeMOy85P9PR21hw3YH7kA3DbIVDFUFm0r4SnQL5ub8Z24xpsiXTQ3
         ZjJQNp0aPI+7Q0gQgvUTH1c+DkjL2GrelNGgyFEPBYpHvZQ6khD3jLf2wj4AZgcky7wm
         5QgQDjXdxcLTNSVvZjyXsRqUdT2QEvzcQofm+6XuelxCviozC0FqTP4/rRatfa8wN3CX
         GbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715737627; x=1716342427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY2J/IHNT9VBahxPZDvJ2CAQ+h9iFMMF2YRGy2pIyWc=;
        b=PdPNV4tcSDdmUA9XhIY/JwzNn8HlOvdaIJ8T7nduF/JxHrXKM9jzptJOnXlzrKJI3N
         ZfWUjtinaEDXkujOnmz91MEgYpmTijiyPCw4dp027JAzYe9Z49RFLzzEjTi/a34hkttP
         6N7TI8FFY88smVFXmib3kEfEnGaEr2V2rdYoKAlaxLP/cz8hW+cz4U7UpPUSrfmGhqVo
         OF9Shzi/wa9bfd4BzeGm/FkIA4JaRg2tYTU1ggR9cmowF2CoJQRUNiVv0M9JmiVg3owq
         W2yGFdre4rYUuTjCj5H14d2XKceyfwOSYFkEb6/lXf67xcyPQ3cc5ajA8+zdziyenBF9
         npew==
X-Forwarded-Encrypted: i=1; AJvYcCXI/aO2X0Sg43soMbDWpet3ZdkOdY4Eiwb+Tp+nFn83SDNgQbVjdcCRzh/H368xsvqR+9yzB8M0G8NO50eemGPuUo0Yg2gv5gKIPcrA
X-Gm-Message-State: AOJu0Yz0qkJFY0mOD5HLcIllD8bxrXktQQjVt83XgMJRgkmKe496aYbH
	5DncE5OZBXbWZxbj0uTmmtvCVS/j/ifXPa+IbK9TbIki2ANA9Q7MIUPpoNGtR28=
X-Google-Smtp-Source: AGHT+IHJXcRyQL6x73F2cBO7BZMI3F1AWn3WWlR71b6YQqfpI0410xlRBcxMXjI21oAZuo2Mb4BDQA==
X-Received: by 2002:a17:902:e843:b0:1f0:82b7:71a7 with SMTP id d9443c01a7336-1f082b772camr65259705ad.22.1715737627355;
        Tue, 14 May 2024 18:47:07 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c1368desm105582145ad.233.2024.05.14.18.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:47:07 -0700 (PDT)
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
Cc: dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [v7 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Wed, 15 May 2024 09:46:40 +0800
Message-Id: <20240515014643.2715010-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Chage since V7:

- No change.

V6: https://lore.kernel.org/all/20240511021326.288728-5-yangcong5@huaqin.corp-partner.google.com

Chage since V6:

- No change.

V5: https://lore.kernel.org/all/20240509015207.3271370-5-yangcong5@huaqin.corp-partner.google.com

Chage since V5:

- No change.

V4: https://lore.kernel.org/all/20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- No change.

V3: https://lore.kernel.org/all/20240424023010.2099949-5-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index fc584b5088ff..baf8b053e375 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -16,6 +16,8 @@ properties:
   compatible:
     items:
       - enum:
+          # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
+          - boe,nv110wum-l60
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
       - const: himax,hx83102
-- 
2.25.1


