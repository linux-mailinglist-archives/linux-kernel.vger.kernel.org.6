Return-Path: <linux-kernel+bounces-523035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F7A3D130
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E5E1895954
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408971E5B62;
	Thu, 20 Feb 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ5kv87M"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AF1E47D9;
	Thu, 20 Feb 2025 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031878; cv=none; b=t7oIiTG1jQnDtXdwEmXoqTmfkDy9sPZcmJNSQ8d5lXaxIhvbkn5U6G7DAoB4RRq8nfvHhkm5C8le/syOrvtFnwau6sq/M4XzkJ7CIEzua7vQpq9cjQfVjA7jXxBQZFwRxM8wTeMtPk+W41XAtm+TTJT6dFnOZ2X+40lE/RPEZbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031878; c=relaxed/simple;
	bh=Se7UNv3ruOOB1Cq1f+jNbn90MdBdBHCtIaot8MDzR7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFRI+weDmVBbC1LnJ3dgqjpJ1iAG0B9r9rIRGfFg+l3xkZvUoQwTT+hA21irB0MlxpyzSgfY9Dh3dnnnT5UvhltsZPisgcVd4z7O2ySGedzIROsF0jsbRvQJGCF/M50cN7++tTmJ8Wilen84dp7W5JHbk4OY4rWj3WDEq2rIooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ5kv87M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2211cd4463cso9351895ad.2;
        Wed, 19 Feb 2025 22:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031875; x=1740636675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NhZRYUnG3q+UctqXkfGAttcdIouM3jfXXmawCdJWIU=;
        b=AQ5kv87MXdVuKg4OToyN7jF0TZfC0dLLiMnOzj/7T2z8nl1H0YlukKHoJq468k3vCQ
         JORINXtDTbtQ0CX66MxADB+zubhhtwk9TBZKGmEJMX2pyZt0MfoNcmCVe9GIuR25sV4C
         C14S4SfJBtPhcG2AGKXBbI1yD0z7UVRMCb+hpI0CnNURU0IXIQcmp2FsFoXpPKASWvkx
         onKBINts3Lmpn8Db0abseSK7OyDqDS+q4xxeSP4+CZa4aVtwafhPiVH8kWxH0I2zKrok
         L9JqRFI2Y+OGW4aFqIWDu0QQ//R6aA/FDOuYHkAZAtbC1LuFom9XXOFqZujIjyKuR5g/
         eExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031875; x=1740636675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NhZRYUnG3q+UctqXkfGAttcdIouM3jfXXmawCdJWIU=;
        b=jXU/127DrHe+B9sxGUSq0u97ODRDWg1fFvQkTZTeCEG3yT/XWoPTSlKA9R9jb0vpnn
         XgKfqEAgVI6YRDaVEvJPjNPMFDP9L9T8I+Tyk7MsOuNyxEM4IFExyL8pnPznOxlcwIU5
         kDN+DjzFFTiIClofwME6bCD4G+EI0Nc1GeP9NC74OmLr/pNVMYh6bJU9+7ueA+Sd/eP5
         3FPdbiVJdkstYgb0ht74jyMaMOTDOZvahFkzEJzEa8VvakACrv1GVPccspcDe53xOv+5
         tc6xh3iUm2gEc6iLgXYjK/UWu+/bU0di4sU0De0FDGkC6bqs4gPwq/WoSxRl+octozX4
         sERw==
X-Forwarded-Encrypted: i=1; AJvYcCVldfFzEHHA4BK8h2xI3zuwCIh+k3Mt8wAxUlYK7axyXpfUeJSMtF5hNfanI+ocTvd66Dy4D1ZOin8J@vger.kernel.org
X-Gm-Message-State: AOJu0YzO20JmiAtau3J5HBk3DfxngHDE92UeXcRp57ewfIOd/cPoWQuq
	+Fkc1Hpn94UQhB3df7v1JHKNoPgTRvCfW99Gj7FyfW6An38wsUgpHrLr0w==
X-Gm-Gg: ASbGncs3czQe5Cvc6j/MqLTuIVe6ojxrL3MfZpoRoWgmvV7pi119uIrpIRHd73jc/Cm
	ipQkCR3T07+t3F7jUd1tNyUy38/zJbVcyu+dIOXdy+gsghXJM2THazxoh/3TnpUapv6qof9haSY
	DhrAZychz9ySzdO3mu+h1m/xVzj+nPrGBYN0zrfXQFUtaGYDltzAb/Q04Z70UNqWI6pBlQG7qFx
	jrIeLz8eMHoduSCpFgHlFEnadC6RFmWdZ37DrbB9423Mg9+QIdhO+3YnG4n5Nzaa48V+tkrFrFB
	2NIeLpZDhAUWLObAzyt5UFwQeQ==
X-Google-Smtp-Source: AGHT+IErgDPvFbaPdYnyJfTUCqNxawOLeaE4X04U0/a/Og9Fxydety9DBz1/dgpY50LkVuvvq0M0oQ==
X-Received: by 2002:a05:6a21:32a3:b0:1ee:c75c:beda with SMTP id adf61e73a8af0-1eec75cc2c3mr18787100637.35.1740031875401;
        Wed, 19 Feb 2025 22:11:15 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8226823b3a.107.2025.02.19.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:11:15 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH RESEND v2 1/4] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Thu, 20 Feb 2025 14:11:04 +0800
Message-Id: <20250220061107.1718239-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061107.1718239-1-yschu@nuvoton.com>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Add a compatible string for Nuvoton BMC NPCM845 i3c controller.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..9be4bc4cc482 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - silvaco,i3c-master-v1
+      - nuvoton,npcm845-i3c
 
   reg:
     maxItems: 1
-- 
2.34.1


