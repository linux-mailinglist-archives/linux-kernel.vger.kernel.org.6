Return-Path: <linux-kernel+bounces-253471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A82A9321D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162F8282604
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F35145345;
	Tue, 16 Jul 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="RWHUsHg0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98A13B293
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118551; cv=none; b=Qmn3ztE5UfOiFRaUivGZD2zMl/XdU670ZXW75QO5OxvON8zgZg8hTh52lj1yUBoA89bFYjIr+RE1/z8KvFEBaRhqlwUI9ixoUG/BtPPx1JS3T/FJVTdq5WNjh3fDmgqlqZrN5ZzVHC5YJ+IsZs/O9FKa2OBC4NDKT0xSwRIsumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118551; c=relaxed/simple;
	bh=sMB82OguDZsIsb9IELWDCVXbHCAu/5+FMCSt1zJ5C3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NdN+g0emggA6U2O5uLT8Vu32LPZdi8DeTKs9OgDyFjnqZEuh4JnNkYXr5IAA1qn/eYGzpLWzSO9smzwp5zkNlMxzE0uXm1UpNuNIJJ0noJK49SVizyJOjUt+bbvMNOB3RdlAOaL5azyvA8Pqq7DRAK67ugxz+IV9fhOfiYz0J9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=RWHUsHg0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b31272a04so3935231b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721118549; x=1721723349; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0cHEfw05PzIXTBho9roSLu3dox3EYU5nHarCYBHiFzg=;
        b=RWHUsHg0lMXMRaYFzyjv+GOl1spBu0kApgGsmRneAVCz14jSZVUSTR1CJMWQqRzFOS
         Spt1jLgEZouVJ4foez2VKY4isDqS0zwB3gez3BoM8ZuCBLgk7+396N9jc688s6oeGxEf
         BZl27yEFbw8HueHNEP1qDWHQCOVVp1WSPsXQ5SGAJdtlV2x7u501gGklAWqDcLebcuce
         ovtJoRS6Fshu6iX5gUtHVNU3NTQwP9wT1IZBq+49Nluj4czffUrTPH6WU/XYQRs5UFvs
         Vm5lJf6YnLRI0WDMn079WE9cww/egclnMbjFvgDKKVAghDX8t2xpo4H86jNxGhhLMm6L
         JN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721118549; x=1721723349;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cHEfw05PzIXTBho9roSLu3dox3EYU5nHarCYBHiFzg=;
        b=PY3lDKKnhW39vyWOQIm7vtSa7pA/5ZG/OchzFWxAhS4hI97p1mNE9Vf+jIOsSUqzZB
         z8DLoSQrvqde/+c4EUWbdH5/qOlnWA5qMv13Z6c6ZdSq4P91PIuRkZxKOE8kWwpM80Zj
         6dWybrq6/WYYrVK8C41XvBcpVH88JjDWPi4FZuUWrBhmO8S9dGzRsxsJNgtROnv656Zp
         jGw1i4kwGrnMfsDanQvc3g5GPNa0PaLIHyurg9lXytfREkmulz5XspzyJXXqePDE99xv
         rbWMu4jPSPE2kqmDDoumIKvopuVvCDJPWEXbacd/czyBEY3Ung2FnFIYGAn622ZHP92e
         MMzA==
X-Forwarded-Encrypted: i=1; AJvYcCX05vBtoTwft9IHjVCoRSeq7buZllAYZ3mxgvkeI9s/y436+nMS0B8/jxWdT+CeoMHW6i3rMsBSNyumKrf6uA7hUxDIiq5b7fSfdLz9
X-Gm-Message-State: AOJu0YxlOIjZmy8anu+f1JsmIjoEPKxi1vL6gAaYnO9E3YxLOsK8O5PW
	kIy3leRKsueS9DRdzi3+w9RfbUF+K0Q/g61MLPrdnEOuwxiaBjpcb2Prmjdaato=
X-Google-Smtp-Source: AGHT+IE3qUg41F90doDcsAXrAz8l7EtcoFuvjXP3rjxDD5uv2FyCzJPVH1EglS0lBSr/iPxY4WEPfg==
X-Received: by 2002:a05:6a20:8427:b0:1c0:ebca:963d with SMTP id adf61e73a8af0-1c3f1e73544mr1985199637.4.1721118549100;
        Tue, 16 Jul 2024 01:29:09 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e110sm5714347b3a.121.2024.07.16.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:29:08 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linus.walleij@linaro.org,
	dianders@chromium.org,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
Date: Tue, 16 Jul 2024 16:28:50 +0800
Message-Id: <20240716082851.18173-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716082851.18173-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240716082851.18173-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1.  "ekth6915" isn't a fallback, modify it.
v2: https://lore.kernel.org/all/20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1.  Respin the series on top of v6.10.
v1: https://lore.kernel.org/all/20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index a62916d07a08..f683048fd0c4 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -24,6 +24,7 @@ properties:
               - elan,ekth5015m
           - const: elan,ekth6915
       - const: elan,ekth6915
+      - const: elan,ekth6a12nay
 
   reg:
     const: 0x10
-- 
2.17.1


