Return-Path: <linux-kernel+bounces-237802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D261923E56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE0F1C21D87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E647174ED1;
	Tue,  2 Jul 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Ri4j9Pvd"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B71741C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925332; cv=none; b=eqsYHh3au88h19d5DIHFOdTeYyUcngN151W1mam2K5XYLN+ona/ta4Nqj+XAx4T/bNKZgy3ppIA+xdxPS5CAXNinHZRXtTBnmapg0I2NXTxlCKA0Ov+vnUbCrIHCBOcgrcjpHqDEJBn4Kh6N+0tYS+uKNvPsfJ9mE4/E/08lWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925332; c=relaxed/simple;
	bh=yCW10eKLB1S1uilKQaaPtfs8HOSLUFpoC8/AtoY5zWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmBt3x4F2NyXiOIYbYU9mEyYknO+puVgGBD4JFclGSd6pOxwNfEMQAxh5p00FFd9KieVVf907IhEzEAYGpyKBfX9DLPFmNy+ZISnfBCPdEa3qvkHPVULWuwwBRpIpmtzQpTE+21eXtbFPlEHV54u32e07I8kVdHjwRa2lTDJ6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Ri4j9Pvd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7065a2f4573so2792728b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719925330; x=1720530130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEarth7Zvjah/4aEloYMlgeIzn5JDGZaQzKTKVskKkc=;
        b=Ri4j9PvdAmCG7oaZOFlPL5EpF2ws06bMt0FX82PjIOjTbLsgPXs/yKq4x+hXNnMWtD
         /PW7WvKlKZ524Bp+4OEs0VAXT5I+22p2Q29aB5XvdajrAoPiov14xw8w3PkdqdefIizh
         ilsXw8raDGCJMjZlKGLGhj4YPTT/Jt6d47QeDTF52Zz3EjgtMTAAVxGh/wZanz6EqqIx
         LCH5dNJ7WOFFDpG9f2+FU2Y7Bu0hI7KEYXuMUcn4tvp7VIoBPpsJ2IzPQ4OjD0P21OyI
         IusIaYd5yR5C1NlAvkj8f9Q/bgH0UzMlieMumIAzRg4lEi5IjruzJSWrP2DOFjw8OF8O
         hzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925330; x=1720530130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEarth7Zvjah/4aEloYMlgeIzn5JDGZaQzKTKVskKkc=;
        b=NKHs66RHhyHaO2s7dackCXdKeLFPdubyqM2bgfaPDLIfHIr2R16n1zMdWbrYxNijQJ
         w6QrxEke5/aQN+08K3hpRF6xcbUgzkqtVEoCMEkdQwLCbkgwT0jUfMokepGrEXdnhpmO
         +UBBJ2t5g4krouGmeOy8MntmM77mDruvKj7X6Z/ZB8g4umxDLvUvU2dV6jqZ+uOLJ1Mx
         nbcp6s5DX+/6LZc5u0wozsYrOBaJ3nA9WXdQs3ttL1RK+4NCKxmf0l0naNVqG+bG6o2U
         NeKlesLQw5lGsaywkYLwT31mAqdf/DYE7NKEuROOV6cAji+jYYSR2zIRR5/iYrWeGP6O
         HgEA==
X-Forwarded-Encrypted: i=1; AJvYcCU9VRMm00LnPbNEWk7GI8oCyi7gP+plI1LF7xR6lOCrbcw1JCNBcx8PDRk0dzFNlNeCUOmi1T9YZnSH3xzQ2AeWWtfJC1K1XgngDyBo
X-Gm-Message-State: AOJu0YytaJS6a5pl1wWi7LYl7y0LaTMTKYWk/yf9Vbam0cmjGPw87FTo
	Sbd1xVCy47zexoNwlqs/9QTodWkUoyujIXNh+nP4IvVSi/2by/6FfoYdbspM3Y8=
X-Google-Smtp-Source: AGHT+IG5SAPwAceG5TK6MQ0BWXKUM4tQCTZWen4CjFJAF4c/+bQPO1zJUXNeuDD/lwi/4iugDsvixw==
X-Received: by 2002:a05:6a20:3948:b0:1bd:deac:c052 with SMTP id adf61e73a8af0-1bef60e3be5mr7899722637.1.1719925328953;
        Tue, 02 Jul 2024 06:02:08 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec50csm6233111a12.59.2024.07.02.06.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:02:07 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	swboyd@chromium.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Add compatible for melfas lmfbx101117480
Date: Tue,  2 Jul 2024 21:01:37 +0800
Message-Id: <20240702130138.2543711-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Melfas lmfbx101117480 is a 10.1" WXGA TFT LCD panel with jadard-jd9365da
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index 3d5bede98cf1..b8783eba3ddc 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - chongzhou,cz101b4001
           - kingdisplay,kd101ne3-40ti
+          - melfas,lmfbx101117480
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
       - const: jadard,jd9365da-h3
-- 
2.25.1


