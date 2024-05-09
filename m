Return-Path: <linux-kernel+bounces-174206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D98C0BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EC2284719
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D886AE7;
	Thu,  9 May 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="cH7j8QJ8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984C7C0AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237028; cv=none; b=uKGZZvwEJyg1RU/mfKFhD0uzK3ZY7N1NFM+hxKS9NH4K3MPb5gWEOF7zYhu+gyn+JgVOeE0GSkaM/s0EdQ43r+z7iJvwODy9o0kez+sJp88EOc+x6fABkZh0JI2n+QulAPyFwjNMuYiK/PtVIw+lNt4dPvrMSvGRcOYUHP69V9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237028; c=relaxed/simple;
	bh=T5KijSbEN2MNYbsPdgUcqh/8TOeK5cr6vlHWiz3L6jI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PWl6JwmVTyqB0m471y+vp+OaxiWJ/c18B77mzL+eJvkPmpeebg5uddK9O7HuxSnDmVY2SLBt6QElaLnsjpIe39RoYcX2447JcF9vxK2I+wpVKwsK08arlfC/sB2kLS68w7yWMiHeFqG71I1/okNlHRQ7qL03i3aAze2vteal/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=cH7j8QJ8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f447260f9dso519747b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715237026; x=1715841826; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZP8vuwqcYibUQ8arS+ZFPZGUpG90sM0PAkwSsCd8m8=;
        b=cH7j8QJ8aefYyeLvzfIo0TXKsN116S9ZsPeeb4bxvePGXalpHbFTN0ps8ssd0BMwqw
         /YRUAJ+/k1zYDCAmoJwxTvlOXQmcfjOgtvGGCjwWxvZFcYVm2nc/WWHGawznt1jgh2VI
         9wn7JhbDRbcvokc3ykCihqtCH47TbwoszBNN7lf8Ry/YvGEMBzaYPCr9Vji74es5DdlO
         nB5xLYhBTidrcjpe9SHlsNgj2aIZ/FIShqR3yXgYp07EbuaArCSFyd+lTyQJSWR8CrmP
         xFg9130hhIYXx9df5fpifp5yRqvBuGRhGkouvYamV4MfXULFo3k9CGQGRDgmg5DhAeDg
         VcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237026; x=1715841826;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZP8vuwqcYibUQ8arS+ZFPZGUpG90sM0PAkwSsCd8m8=;
        b=kXCCdYlcYp05wuuQ0771n4Ns+4vlvIYUCxbmugmOdxCFQwT8k3bqluHP85TzbH7eT/
         YkveTsedht644xAXFTSB0MMNZUDT2Nnqc32DjVScyuUMyT+vyAVZGQ/kPr0TUmTfrm8z
         F7+ITYdrrgs+safrj5NjxH6EAQwqidkOe9psTBbjD/4Wi6Y8L0gIJhto8YsHibaTJIfC
         TpeH1XPE2kvef2vYWW8BzG3hbEQSrMCwh2PQW9L09BPxTkUOjI1K/YLzz1O79c8g2U4B
         AgsIuvazD7bbhEuZ1PeVKzAO2uF9sSpL+Qis9x0wnEsUb/bp2qVmMsIj0p5EpPwWfmqW
         7pzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7X+UTR+19/Kckp4WZkECi+DInEPx7HdL8cy4ZXsPHuttHERaCJ+SxQ6qpYI72zCqeno0M4QuqbCShpJltEMyyE+hFAoXqP45W6MRc
X-Gm-Message-State: AOJu0YyhGGXs6TzsBfTBeOz3Bjs4hfkBPFGGZvu/7DKEEdJqWxwwAcKB
	jIvIsDSJPBrkLqlMs/nhNx2Q1BOcliPLyw76vRp4YM+YEgh9Y351vo88mAqmNE4=
X-Google-Smtp-Source: AGHT+IH2e92mWa+Ee26OZVg7GLAYUFnsK02ab7TTviHRZ+fbVid3mBljDBESNTHh0xXoRwh9tqj7Cw==
X-Received: by 2002:a05:6a00:9295:b0:6ec:fe38:d94 with SMTP id d2e1a72fcca58-6f49c2a6840mr6617887b3a.33.1715237026094;
        Wed, 08 May 2024 23:43:46 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f7237sm597394a12.71.2024.05.08.23.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:43:45 -0700 (PDT)
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
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili2900
Date: Thu,  9 May 2024 14:43:35 +0800
Message-Id: <20240509064336.9803-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>

The ili2900 touch screen chip same as ilitek ili9882t controller
has a reset gpio.

Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
index c5d9e0e919f9..5063ea2c8375 100644
--- a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
+++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     const: ilitek,ili9882t
+    const: ilitek,ili2900
 
   reg:
     const: 0x41
-- 
2.17.1


