Return-Path: <linux-kernel+bounces-263111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0793D130
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F137282503
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B969E17B418;
	Fri, 26 Jul 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTr8qRLQ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44BA179953;
	Fri, 26 Jul 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989756; cv=none; b=ishXW++j8fI6Wyr6CHVgghqxfzFy+eA8/8cUhVzHGq2PSiwvDdvnDPW8TuPEYaZ2QV+GPOTfYmHIJjQuCbRqw5vncnyp8KUr2pOg3QVWrEi3jbrseSk9znXOMEQAdOtqf81R1Fcxj8zidkuHiDiWxUZFsQD2ptnn/L6FLFx3J+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989756; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvFFW4FSriOGf4rWf+d4px2kTD4MxxEeOLMdqE94z83s0ccpsX4LJ3nOZgR3O/eC1ya+1flNvkkVWS177Qh3JskiDZPnJjcpwcVS5zDghfPALSoNbeh4zJGR6DkkBPW5vymTD6Wm74kiQ2uLDqJUUtHNo/OW1f8+m9659JvuStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTr8qRLQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-397ba4f7387so7439005ab.0;
        Fri, 26 Jul 2024 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989754; x=1722594554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=YTr8qRLQ5OLzJd1vBt3i8WlxCzcsxYkiB/pqRbSF0HbHu0fUhqo2+s5EFuNEdEK7+9
         7ocyukXnyC/b5agHy3i8mWTGhFwvP08BbxKMVIcp2Mki0xd5fxNG571RFyCIQNwqdPDd
         rcJE7F6mLEGyfp6oxVmaI14uKoheyDVFINUssRRioHCu4wKxEJTImWowlNEKj1y51Kej
         zKsP8JfW6NAz2iJUx3w4Afuz6wt1W7+CBuuE0Dhwh9nB5bvHT7gNNXKQNlTqS+TmoWIM
         IHr/rrr5QfhLgunYPC3Ws6vJOaK3YuzxETkWUNT6LzPmRLv/I/Dz6ZHNhcs51h1m/fMx
         Ly1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989754; x=1722594554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=o6uCoFDJMRX6MMf4BxbWP7V5xkzJe47BSKwjqfXeGmWnPObWOpmBDd9rO9KTjs/JTe
         6kmn3ybCgEr4McAB7PCHts6hDhvCfhzFZv2ycsBp5lFqs+rWjffzapcruZRsKy9bgcjv
         uW2+Scy/K0GaLPAwcihW1qga/q+loyWv46TPbVOc+AqJ5wTPwAL/g1/CSbJLc7lY9kAG
         q5qwr3Wq+JAdd4KvMppVKYBz7kM30ZwexL84d1qY32ptACYNgAk2eYbrCJs7Yv/p7Nf+
         ZJY70svrZpMLix6YNGzC5YsPJ/wHErzSn36GwdTofxvaehUw27FazesFvvOOsUA5S0PM
         UCMw==
X-Forwarded-Encrypted: i=1; AJvYcCUPOepdV5b/dob0oPv98zAt5P0VRMAPMzQ8v1ea/iZJVmtjjkTO+x6yyc0fVtYa7gIwK7K4OGdrfF7FzNd7IUrOuwMo04n9Oa9PDKve
X-Gm-Message-State: AOJu0Yylw/tIy+WEomTTqqUxV+16345AdLybU/ePsU3RHudttFCI+03d
	a0jRCnVIRDOALYOAQvj1ebWCKOeJ38xiypjSpMUp7dAUInBVqcZj
X-Google-Smtp-Source: AGHT+IGL5Wz7SK5HnNaFxr4tWNWoZyb/iwi8Is28PgzJgfNiyQ2NMPaFHSayXINvdntswaZhn5+2ug==
X-Received: by 2002:a92:cda6:0:b0:39a:e984:1caa with SMTP id e9e14a558f8ab-39ae9841e03mr8473545ab.21.1721989753838;
        Fri, 26 Jul 2024 03:29:13 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8116a4sm2406545b3a.130.2024.07.26.03.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:29:13 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 26 Jul 2024 18:26:49 +0800
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-potin-catalina-dts-v5-1-8f02305af527@gmail.com>
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
In-Reply-To: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721989748; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=5QKNyRNZt9BW6GvgGUgynM1cwzH/rsy/7kmWy8JPZpgpt3jKvQhpuHdYSk/z5KT6XLQVKGcqP
 tFWXYBe5xlvDWJzEs0+3Qg+qyAeObNJJDMpdoXciLeeqpAhq8WAG21a
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


