Return-Path: <linux-kernel+bounces-347172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4398CF08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415041F22EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B01195FD5;
	Wed,  2 Oct 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gWI7yF/k"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD079194A75
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858488; cv=none; b=pveDN53eYj0/BFF/OVAz5KpXCyB7WeNJkgYIs2B2BZ1fClgnenLCQpkFXIO0OrUQfohQNvI7o23CSdp99g0JI4a7NKRBEZzSGXBwK4C/fozEzoCkObIJATJLQOh4HqxXgwxPXhS6rjMqjUzuSYooyJMWV2kSX6iMiQAFiAy6tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858488; c=relaxed/simple;
	bh=z9ZlyGoBluNc6PapcN8LPx9sVuMjeiJH4IUyl+2i3UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6fyRSfoMECdn6IS4tLWZyd88E9KnUwXiP47P2a+keBQ2FCpauFYNwjpgom9Wkep8HeS3RpfWRYWeC5F2vqiwCNt8q/X0aL05wUBsYMPZZNJOoT0E0bYHy8nOuRN7YGOJIfLfxeJh5ic9jIqbRtuP9SPXVTg+tICJoyWvimD3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gWI7yF/k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cdac05af9so4044156f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727858484; x=1728463284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkdLBGm1XB365GQZ5F1KffCkGtsoV8P41FFkFvqweKw=;
        b=gWI7yF/kXYPYGlviafZV9WX7LVOm4AeCxCFXbBE8+L90SysZM3R9IWbebSxMmNcb7t
         fjR4uCXdj1NXm9HaHKyxDn3pnvmYx57HsinhlL9+Icq7PD2ZNEGFI+x1Vxqw2xgnvWAm
         27uYbx8bcLobs4zfQn7zqZvRqv3ukHaxfLOioonZLNp1IO9+SwxMU+VcYxaea6dKsCWy
         BSi3h1NSYV4Bt2WgCN0qco3nLepoH50eqlT/9XCxGAYIR9AC/hGvkQadcjL555GtA+Wv
         i/xJjt+W3iqqZ/t1jJYIv7CLkrT0NbUJ10gYRC2fzVtJVM3OZp2MuT21Xi/oESYHVIGr
         xmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858484; x=1728463284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkdLBGm1XB365GQZ5F1KffCkGtsoV8P41FFkFvqweKw=;
        b=Li60wAN5mrcPk6qzA/UudeJauGQVaAro62afI0aSgBKEd+7xeJ8BivrlutcI91K7qJ
         wlK3wf5LzWR1cMUG1s2zTWerysl5EtO4UCD4UU/U5EmEmT4rimzdRnuz6fTrLn9oeiYp
         15YEhlioq+ZnkPxTQRTSAEJ48solUKtFrQHC85IdPHj/2TprlTdCqSU5e3tACa8q2gGF
         0fX9m9klMgdTzXHrbqzFFdVslACNaT/EArJt4E4Qz+xORMr6FZCtKy8+21DvMCJ4SUrx
         qoPUm+MhRt+Azx+ZWB+ahu28hdzyIieVfetwHe5IDyrxtS3lZBP4Cu4sy4Ai4zqGgoj8
         0KsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQT/f+Zg8f6y+scnV1ICKR1xz+7fZWQm3jQwyxTTq2S4wMQYrM6+KrNO/8CyN3aG14tEIGcELm+WEwbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntOLgbjFy7WwtqFVqqAmd6Bgk3BCHOD3Th+DA4+McfbkyGrvU
	wc/QmcHuUXalIjGu8HMetqh/vb9ZsaEZBNJvIKEU3jSMkab03g6q6mxjjjUvhWs=
X-Google-Smtp-Source: AGHT+IHHxXmbuR4b6X50HxVTK9A11o7DnmYPeKR05fGwinleKUdREqTk7ARPSItbcf2SaeVHMsEhLw==
X-Received: by 2002:adf:f04b:0:b0:374:c616:54b2 with SMTP id ffacd0b85a97d-37cfb8cf2d8mr2169854f8f.19.1727858484028;
        Wed, 02 Oct 2024 01:41:24 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ead833sm12332645e9.13.2024.10.02.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:41:23 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Wed,  2 Oct 2024 14:10:17 +0530
Message-ID: <20241002084023.467383-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 95113df178cc..8c04d6eaec08 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -89,6 +89,7 @@ properties:
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,system1-bmc
+              - ibm,sbp1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
-- 
2.42.0


