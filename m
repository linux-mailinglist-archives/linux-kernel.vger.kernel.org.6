Return-Path: <linux-kernel+bounces-261291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75793B545
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5701C2389E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985315F330;
	Wed, 24 Jul 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOKjZ3WT"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2E15EFC8;
	Wed, 24 Jul 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839851; cv=none; b=Tq+iESvwbKEUHWcP6DlCFwt+DOi/3pUMl+cQt4cT2U1cuwSPzNv0349MQNZa6/IWH9y5vBkj7Y6IvFlh0hNAmHmREZEGuI8Nl/Xf2l8ObwdNK2k7l2a1xjbRYyTYyfM1c7BhpOXLtkCodBEXGKuxAZR0gZwhl6BvOe02iDdNxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839851; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTCTyGVPH7yahouEuVGmsNHZIr9YLTg/1uXxKGK/oKZlt9jXM4uSormf9vSB3Orq1zD23hm4ahWqyP958CoRlE0v1tE+KMky4Slkq33edbiTtQqpgBpEPTlMh2Bl5JCmJ32japLHKTGzcRM3XYI1hdFxZO3LQXOPmIZFwycH9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOKjZ3WT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1c8d7d95so2504208b3a.2;
        Wed, 24 Jul 2024 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721839850; x=1722444650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=ZOKjZ3WThJ+9CM/08nfkKTu+6fLa1C5fYRQbA0EFBM3CAenR2s/BWgCdSj3S75E5Gr
         uY1HEPwPJ/TJninBcjRtP6FVtb7sPUmXHEXooabeisEfn5bE862EPgja0l5Uuj4sO0EE
         mgRBprtkxSv7KT+vSZKVo419N9gkBv/o+Fu0R8rQBXYC2FxxGA9Q/ubLyUhb/4l+rhbV
         wTb/5GxoAzvrgeq6680+AHN3DPnNbxX7g54VKXiuE68kUPM1RnDYOWABl9HYJTF7o9Fs
         lwJmuhOiUeGltVLvYhxxiW6ItYFNzSjs22HqX0nvdSjiL++t1NA1Qa+YShMzxsVNUNmo
         +AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721839850; x=1722444650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=rrF1a8PNCwjhYQ2QcXi2WoEs2/xFScTea9nj5J3E5KP/Y2K04VZLjDlxpqGIqyFqSC
         afAU280JzDNhcHkdTyo26IM8dHanIp/FDTVItBDGKla5iY/I6CYAwBDEZLyhgv2wt1Wd
         Xcf2HURwTIkNhreqAgE0J86Iznr3D3dCW4DX23hDPEAWNGfGpzoZjns8JhYamGD7JHkn
         ZUY8sE/p3ceNrB/hDwa/CjhlDUjs6xG2rq9GGqs7SKY8nvJyO3BCobytY9qSX1aKE7ZO
         ZrFf4tMk6ODZsIjW9VRYBo50Sr+OukHtpYCfakVEwnoQBRE5wv2BOFxXeoziGKF/P7Lv
         cAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUym9f/duKNx712ia4WJUKyKf/HhdCKO7v1yzJOIZwuzcNI5+b7NEVb/50XL4nhemn9aEk2Y9kGylpxsOoTJgNo27Kb+0QItFw0BRIz
X-Gm-Message-State: AOJu0Yxxxi2uSNHGxtyU4Bt12wwhycZdZ86r/eEeOLf3bvuHo3M64b4W
	BaAhc1xEy4sc6CTgV+K6MJqNSIIe8/Oyed+3AMGPUrRS4UCwuQv0
X-Google-Smtp-Source: AGHT+IEpjLX6VKacK3ty02j3t9wkX4X3oc6gowuWunqvt8WcKyw2oY/PJBPLvXyD3bOF/ChUp144BA==
X-Received: by 2002:a05:6a00:1881:b0:70e:98e2:fe3c with SMTP id d2e1a72fcca58-70eaa831b6amr138533b3a.2.1721839849641;
        Wed, 24 Jul 2024 09:50:49 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2f485c5csm4579942b3a.88.2024.07.24.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:50:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 25 Jul 2024 00:48:17 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-potin-catalina-dts-v4-1-aa6f235a2e78@gmail.com>
References: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
In-Reply-To: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721839844; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=/5fMQLxXc+LmBfipSSbq7LI5av5gqcHxlab9BDiRcDmWXBI5HhNrwTMgkeF93+Yiq25eO4ybg
 zAL4ckrDfvjCmRxejgkz/GYNvc0RHyBohJpaII1Vc3XIux9li83Bn9N
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Document the new compatibles used on Meta Catalina.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 95113df178cc..f1bc2bb7b670 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
+              - facebook,catalina-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.31.1


