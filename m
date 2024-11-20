Return-Path: <linux-kernel+bounces-416009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D09D3F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BF71F2528C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553713BC02;
	Wed, 20 Nov 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHZc/rJR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D81411DE;
	Wed, 20 Nov 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116632; cv=none; b=rbAcGCTIWfziRXZV0mcKf6xXoyd/rb0wdNQlQ5jUk6Edrrrmwcw2FmYqlNXrA5v0r+PdUVpvwFlJ+epRogmy8LKIMPxC8y5DIWdDiyg/fLQiG+YcaUxNMxNehr6vTRiwhvv9Xi4EJ9VKhkPyIthk3aGEU4tE+UyYcrc4SwUUJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116632; c=relaxed/simple;
	bh=uLtt5MxCnZc3LrqLmXMsfjRlv6annu5HmBkFeTUWKJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGFLKH1VWN/+EtbYAmzfoJh350Fke//kuizYjSqVHPjvNsHoxst3nZ35twaJixaVvDxlUC4weI3WeaAa0d+MTgnUGg7oRNLmp5rYWMb3FlKQawti+oO4HQE+kCtT7P06RJxCpdFfh2rmW+iDAnLi0yUDBcWc3pgCmM8VKE3/oeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHZc/rJR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so796057b3a.1;
        Wed, 20 Nov 2024 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732116630; x=1732721430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5L65oFA7Hr6p1e1Vf7tY+IoMKLU/ostYPIDUROVpeM=;
        b=dHZc/rJRRq1KBJ2X7tALeqmRVAz8dezNLIv3YoHmyFIcL+88+nNrT2+dQFgC2ueiMP
         N7o9u8xKW69sgZ1nUZdB2l4kzYPGiwgJuP+wIjGp68tW9vzz47miqui548hC5jsaln62
         EUjcCAeMHeTRuWvDaCSbYM89oSQKxFfKfaTh5cMzSczBNb7WnIQCYG3Y+hNulPNAza1R
         dKGKjzrqd3i4sX96wrbBQkeiUWTbpQom7P4yo1NtBYDjhzLcy4wPL0j6LnZ0kwv7QOLg
         sdr/ppIxKpsrLjIeBtxXC2Dv/JgGFFzZ5t0mm+BC3KVDkIVo4jvWaNlNnJlOzzXW3rIg
         QfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116630; x=1732721430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5L65oFA7Hr6p1e1Vf7tY+IoMKLU/ostYPIDUROVpeM=;
        b=aUxI82xreZxxc/+Pijp+o8YucQ2skJe0biOI8GD0icTd9aQGt3dnQ5DiUDs+W/XKXc
         hARcnHHbCakEXabzUeBBcBCYvKkCjjYaLE0CTRFqn5h30vJfEV1y601A3mdZxsVe3YoG
         xVtFZrt7XTLPZtUvrbq5jHk7gD+MbbCw1928WcbodqcyTlSW0XHSUT8Skjd89z1dXC0H
         rOVci2AXdbNHvaosRffhfOj08dTNEs5yf//XC/f8NeUHu7zJ0ChoHWAoUZ/GAVT1KZQJ
         Fe+P1ISslw8RV6TUeuWYypVq4maB5SmEZPREuAxm4d+Z/kjB26BYEm0EybI5SBCmswEb
         u58w==
X-Forwarded-Encrypted: i=1; AJvYcCUyfhWWwdQLKn0k2Ut7u9eovrsuBE+/gIdHIE1DXEOuCJXD9dozQH8Oa/cqbmdSXRTMU8po5C+Lzh1lfn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk70owH7AD8E30aTBg9xBP9gP4fXYPuOwCtB1X99iMs2D9Y69U
	nXiouH7W+EWH3/yl98qGYyXctiE+qzO/GSMOs6yK3j6dZYQ1S5ty3YR/Zw==
X-Google-Smtp-Source: AGHT+IH45QDCzfrJB3uH/9sVQ5Sb8OviHDwmqKSMSfMLOk5nQf8oHmZAF75gjqlvLQ+Sx0yXa9+qjA==
X-Received: by 2002:aa7:8e06:0:b0:724:6702:faa4 with SMTP id d2e1a72fcca58-724af94dd23mr9328641b3a.10.1732116629527;
        Wed, 20 Nov 2024 07:30:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befb27bfsm1754558b3a.169.2024.11.20.07.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:30:29 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 20 Nov 2024 23:28:07 +0800
Subject: [PATCH 2/2] dt-bindings: trivial-devices: add ipmb-dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-trivial-devices-v1-2-1f7cb48ee21b@gmail.com>
References: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
In-Reply-To: <20241120-trivial-devices-v1-0-1f7cb48ee21b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732116623; l=900;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=uLtt5MxCnZc3LrqLmXMsfjRlv6annu5HmBkFeTUWKJM=;
 b=2DsSsvY1TPcGE1itvrqDzTcZU84wo6ZBP6R+vVT+H97CfQO2iiRhCyIXyh0TEVotvoYw1fPj8
 f119Z3943NeCaDQASTVE9z3SQ5VV7F8RTC+l0YMeVxoNyjMhCQCzcDF
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add ipmb-dev into trivial-devices to support IPMB device node.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index aa09dc51dab7..89dfac9b6a9e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -149,6 +149,8 @@ properties:
           - injoinic,ip5209
             # Inspur Power System power supply unit version 1
           - inspur,ipsps1
+            # IPMB Device
+          - ipmb-dev
             # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
             # Intersil ISL29030 Ambient Light and Proximity Sensor

-- 
2.31.1


