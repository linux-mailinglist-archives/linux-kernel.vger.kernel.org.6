Return-Path: <linux-kernel+bounces-404340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84D9C4296
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E8E2852BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F281A4AB3;
	Mon, 11 Nov 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAi7xRf0"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81519D093;
	Mon, 11 Nov 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342332; cv=none; b=VcKKCzaPU7f+4CC3cEz91k0R27m26tMp9WM6cy2C9njtb18m6qEwbtStHUcqEFnsNb7u8y1x5Lp+4qrTf/MnWCI//YQc8UlH/9pFkH+xDTLRCsEjDlEjPp1MBdTOB+DbK/HD2dySLJBElIVVbJ4/vWr+9f5oLGVLzgInmr35E7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342332; c=relaxed/simple;
	bh=DJ313fDENl0JgB5FAz3WnAA5Duu1nh+i9fiImloQmyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUI8E/dWYHPKBfM5gSnzeVxAZu2UT2Qib5oVYSBeT2MneqhCQ/vdxQ29cPrWl0cBPY3O4dss0K7L7b2h4rHzJtMEUd1u5bjdiddT43EXDBw3R+Y+zAD4WhwRoX57oWoJsfutbzAQu3tLVYoO2wZa3OLLhew8yUCwElNW2IaT008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAi7xRf0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so4724646e87.2;
        Mon, 11 Nov 2024 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731342328; x=1731947128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhXjNqSXoRdIfCPBb/HfVY/vAkKO6vctDzwv5YqBTt0=;
        b=QAi7xRf07YHf8yaTDNhyJK+cfxA3LXKmV9unVTdErvT3ry+ugmgtlYUIilaHv65nL3
         wZRD8SZqBFR2aTnUzG/0B8WlUv5SC1GiUHg8jFlhaijC4wGcwusWgwLXMFZxy/Xo5jsx
         sVgbCRkBgMpq18Q7VEJZzlskWhZFQILpkPz6yxNO7SzAHDkp8rF/TOrRdM+AeBzm9OVz
         082sku9jd+h9L0nE/uHFDXQqS4Iem5U/hsq2OPU27Z6Itc19HLPA8OoqIc9V0oeH0Heh
         w1vP7OVfBRo+gLRhG7KwDEpnrqvZJHrNe4ySbF43orygTYFmeXbv4VQkWb9Ta46MbFEJ
         q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342328; x=1731947128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhXjNqSXoRdIfCPBb/HfVY/vAkKO6vctDzwv5YqBTt0=;
        b=qUvz/kanZKb3+euvxT51P0vQM53GSVG6JjsoM7oWuRAbKhXeHW0kxfQryo3NODdEoh
         KyJa6Gzx+5fN3C4Mo7I8pzU1PWjNvu2zfVY7PjW7xt/ezeMU2r+0n/TcUlzrxXYYXgle
         76XnQ7cHCsFq5jlrcNjNYz2RQIRHS+MWNMG7/Z9cRU0lAtmO5rI1oDwscoiDl9uLpqvY
         CTXnsLeB8r4YDc8y1NxLdcrL+12wwr+Iwa6zfavfhVifwX6uH+UMkC2Ntt+Bcnom3grg
         4LSgmYWDKocE5I+6Zh6b+AawrUPpehjPTVjQd5CRVhGDf0+rp5KztKYFEUHDeymzmf87
         5gng==
X-Forwarded-Encrypted: i=1; AJvYcCUoIOyFUQGjyQFTptXhDa9xCiwBlnh/goMN9gD9K6Qx8z9BpB+O3ZM5wQcwH1uNIq3atybERSm3EIKeE4r2WQ/eJA==@vger.kernel.org, AJvYcCXuM9/yfeuwHmB+lAiKJ4DO7v1xLniNmpC7gyFOcCklFuxAm5TJO9xVbUKxQIe9862WB0et1G0gizn1@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJ7TNJe0SlyAVNnwHPPD4EE5A6+zvvfUXa/Vmt8ibcMul1FBU
	+0QQJ1vfjgrc3TfcK+AUpNY7XMZr+KEBLpnDVXz1SGopqqD8A0/QdqINzd75
X-Google-Smtp-Source: AGHT+IE8lADm3Koa8wSOM2pmOJkyhFbfA+291g3DqJ1bGrffuE46v3znJyw708eMa+G1yTH10ozkPw==
X-Received: by 2002:a05:6512:3ca5:b0:539:fcb7:8d53 with SMTP id 2adb3069b0e04-53d862ebe27mr7026301e87.46.1731342328261;
        Mon, 11 Nov 2024 08:25:28 -0800 (PST)
Received: from localhost.localdomain (c90-142-33-119.bredband.tele2.se. [90.142.33.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826786acsm1622926e87.30.2024.11.11.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:25:27 -0800 (PST)
From: codekipper@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	wens@csie.org,
	macromorgan@hotmail.com,
	jszhang@kernel.org,
	uwu@icenowy.me,
	ryan@testtoast.com,
	dsimic@manjaro.org,
	mripard@kernel.org,
	Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add the X96Q Pro board name
Date: Mon, 11 Nov 2024 17:25:05 +0100
Message-ID: <20241111162524.46812-2-codekipper@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111162524.46812-1-codekipper@gmail.com>
References: <20241111162524.46812-1-codekipper@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Cooper <codekipper@gmail.com>

The X96Q-Pro TV box is a Chinese Android TV box, using the
Allwinner H313 SoC. It is sold under the X96mini brand which
is a subsidiary of the Shenzhen Amedia Technology Co., Ltd

Add the board/SoC compatible string pair to the list of known
boards. Since the H313 does not look different from a software
point of view, we keep the H616 compatible string.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 046536d02706f..8905e51deb0e6 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -51,6 +51,11 @@ properties:
           - const: allwinner,parrot
           - const: allwinner,sun8i-a33
 
+      - description: Amediatech X96Q Pro
+        items:
+          - const: amediatech,x96q-pro
+          - const: allwinner,sun50i-h616
+
       - description: Anbernic RG-Nano
         items:
           - const: anbernic,rg-nano
-- 
2.47.0


