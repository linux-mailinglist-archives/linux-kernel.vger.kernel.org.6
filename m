Return-Path: <linux-kernel+bounces-291629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE99564EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B49280FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C875158D8F;
	Mon, 19 Aug 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1a2+qy7b"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893D158A18
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053689; cv=none; b=Z8MnIGGiifh0Q/gxMaITKZ+qpQZJInL9VVAxBaijxNX4YqSjhErcQPkn52GNhPEIc3o0Ucfh0c4Ff1OsR/5z3ns977Lhs1b/DL4ly5v9qRTQstwusxbHdYV19tGf80ayX6UvanhI9GH0vExGw4x+PvMZ0JgZrS+vk+/l4O5VM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053689; c=relaxed/simple;
	bh=qROjoIoMrt4R1WOlmAxW0yXUSxg6KqlCiq2LI02w0ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbWuN63PyvFenBh8KUpH82wlK5MKsNPxU8cn9K1eUwmAQIFm5YwppHCwGuft6V3G3UaddQ8S7JxRkWeBaClUwBmzTisViLbH8xXgTacTjMpApPUJ59ypYd+DNnrHLs3aQ+vWCpBfru8HBph4pWF7Dzu1tzV32pf5TU9YKI0sgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1a2+qy7b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428119da952so31893785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724053686; x=1724658486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HWnOPtVtuFtQfkeUhsNP4qLdCJ3F+/lPmb7Sa/yyx8=;
        b=1a2+qy7b94VW7gG1ggGdOyohvLzUp/tXL7VU7xQAy7iMRKyG4FNI0v8p1erY0zsmEy
         BhNnJxoCrl9jqDrp1zPo2kM7L0yw8kxhXXtcLOWqcc5n9adNOXUWk5zx//DablFU1WAn
         JtqCceIWjjzgGmt818Ye/xzaZjXxLuwbAVPvQelrPtCZTIu3igCUseWVoX3FzvispNCx
         gPNY/OlJvzza4tB57Vy1ltGLevec7lVurExjp2R0meuMzcWKPD/oCxp9jLaX1qSGRHyv
         I28/+uwIYbdULcQH19XT5uLDibC4N18jQaIhqSygGn2jv0h3zjXHMf4rbNS04tHsvn+P
         Uq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053686; x=1724658486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HWnOPtVtuFtQfkeUhsNP4qLdCJ3F+/lPmb7Sa/yyx8=;
        b=s94K7qpxL9sSntMQxlvKsPKAKEasYMUHSpvnT+dAL5hVjpKWg0wGy0s8Tk2KUMCUhP
         ViD8SQNqETBA6TqG4SRyrxa79FuD3jS4DKTnZTGXMK7Ld06RH847sV3QfFMolSTqP3wk
         OTwSDwuSlyoLhq5y33TOCtqFA+XBLQgr4A9r5V9HYZO4YNnFzoFR2ekdUGVvTauxBsSo
         EkezJSJdEttQcezPWAu5vpbkw3sETTkXLMPGE5wls08sy1Lm3TsUFBjmd7nu9FAJ6LNN
         qQppbWOz40fazDbmNlxRWth34DzXksxxjwJv0nCLYClH9RRMo0/GJj06QzTnTrKQXHy9
         neXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXesYx0Ir2vBivpfyi+21hS1MmZoAVq2NG0Ok5Xn0BIsxeEFKrC7iF0tsfVWvyGiIkZMaDYATxOW70O9eoigK61mN0HqbMzjQblehGs
X-Gm-Message-State: AOJu0YzmQQ73ErpS7Mofw2PF5JdLL01OlDGhPxn8dpDplwRT3v3lGzPk
	G/OEn9qVWB7WfGL+ZXxfue85w0viFAg3BSj+hzriwb5Jw30Eco1olf7zcEkf/7k=
X-Google-Smtp-Source: AGHT+IF5+NmG/osEaez8cWnAT2V4UFMonJgBv34yRRnSlNXOvRHs+XPDKZYPhylL9pZOmbRdHsC0Qg==
X-Received: by 2002:a05:600c:4e8c:b0:428:31c:5a52 with SMTP id 5b1f17b1804b1-429ed7cc764mr88524045e9.29.1724053685880;
        Mon, 19 Aug 2024 00:48:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650e21sm98881025e9.20.2024.08.19.00.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:48:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855
Date: Mon, 19 Aug 2024 09:48:01 +0200
Message-ID: <20240819074802.7385-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the inputs from the PMU that the Bluetooth module on wcn6855
consumes and drop the ones from the host. This breaks the current
contract but the only two users of wcn6855 upstream - sc8280xp based
boards - will be updated in DTS patches sent separately while the
hci_qca driver will remain backwards compatible with older DT sources.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- extend the commit message
- pick up Rob's Ack

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 68c5ed111417..64a5c5004862 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -172,14 +172,14 @@ allOf:
               - qcom,wcn6855-bt
     then:
       required:
-        - enable-gpios
-        - swctrl-gpios
-        - vddio-supply
-        - vddbtcxmx-supply
         - vddrfacmn-supply
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddbtcmx-supply
         - vddrfa0p8-supply
         - vddrfa1p2-supply
-        - vddrfa1p7-supply
+        - vddrfa1p8-supply
   - if:
       properties:
         compatible:
-- 
2.43.0


