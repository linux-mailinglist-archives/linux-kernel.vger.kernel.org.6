Return-Path: <linux-kernel+bounces-546044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D8A4F582
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F91188F9B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544018CBEC;
	Wed,  5 Mar 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnbeATC2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32B189BBB;
	Wed,  5 Mar 2025 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146282; cv=none; b=hw6RT9nXzhA2ANkPwYY65HPbiw1of5GRTnc2gN8XegCi2rnwskSqHXhEpn6ST3+AIuaJnRk0vktSEVqFOaF8eCwaMHxmf03gj0niuUV1ZcRc4pJNyzyxnjMyUitw3Trs53A6PVOdEH/AQfvS8+reGyTNzZJl3j/yFDFzh0rrBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146282; c=relaxed/simple;
	bh=KC3evV8+E4TMmXJsaHaV+xF+Zlwo3/sRwLFbnpUYLeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXOXlg6SkDK5Qm/BNTzAxr+gVPvqNVXIUW1nmnTscLn8cjnZi46OZlM5f2XWuBcZ3y3ed7h5HftqrmTUw3Z6nVd8XvhLlrLO+Nrxod6AL/mBEZH6wYZIAqiA+1oJLGGpiGhJvgDWagjRtjtysU9c4UrAiH3hdIsjNFb6rsYoJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnbeATC2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2233622fdffso119430735ad.2;
        Tue, 04 Mar 2025 19:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146280; x=1741751080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=LnbeATC2RRqM6hf/Su7vMiom9zxS7u8gBjYWbLYBDYxhIi9CNdYWvsczXjn3AIheO7
         tWqTVyFWTbVAVdl5FS7agyhrTPl5E+jra3SvxC4onija+CoG1k1Xi8nuWW4WCdLxjtHb
         TMf5APyjQ8mgekR46rvJhuF5hKI3EHMguHDN+WVUXDtGdBXdcNs0036ujQB8fTvgKA8N
         7D7jE5RNm00aXqhKjkI1qX1ZfTmIipszKGhhwLCuQdPK8gyTi3AFfAOPiUK2JyTzJBHU
         fuplOqo4NjrXGiGAk8ENo9O5JdJ8A11PvMNlqi0DbTj1cgIKDSWLudy3Q4VeJVXa9XNZ
         NbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146280; x=1741751080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=Xzrn5mlBTrW/GqkxhZdzf/dffjzurZm6aY6xcmormJl/FT19AEknFEhj4/0LypkDoc
         J+4LKQQZBrPaoFlK1Zqh0fHDS4S/vpbwz5MLJLnQd3gvcUgkIl3DdjiGrEhwXGMsU8dw
         HmfjI0sJZU3c1ozbgVxzVMOOGuIfuYOrps33VbmHizo1UF0GmJo48Tl9qeZapNVqemca
         enHzXnAtTNvLhOOOTS5mb0tVgM9gcw+NcVqIdHzuYKZs8pij0eV6kDCzh7/IGr1JdoTy
         E2XG/aszYloDHCYKyxZ04/5GriI1n3Pr9rJOPLZCr3HcenRxcoVtceoxZvmRSng1lnss
         OXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXNKOCgWGJTPAP+is1ItOC3H8fah9CCd3bBAPQwZZmgetMvf5wU9l0d9HisXPGsdYx8wlpVyYQj3Phc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Kk+KfNwU5dm34iGKQlG479fpUeVQ5tbKBZhHRTHYFox8Hyi6
	uEedMukCYiHTWc2YKRhpl2y4SzIbjOHPKJjMbUbjZxD07khWfP0c
X-Gm-Gg: ASbGncsk3rQCknj/Nn8IdgMn5u3bNRtkSjQW705FizmsTgL0PCH0GJcesmNOHSQGul4
	D04csK5yPpk6PgteumBTajGqbZC22RvjeYPf4gz9MiH1P2Xz8qN+AgTclQUXphjBFPye1BrJu/V
	ciQVEQbTWbvaN/eAUogpUc2fd2J3WcN2mEOW8JSSW/0dqEHIYtALGWibJsLMn0ki+/ygjAE9qD0
	e4BZjdTxCxATPuJIxm+vNkdRxG0SHI+jAnchXhIkoLlAGLJlsQVwLg12qhX4B4oavvG6M2rmJO6
	SV6UWwYKos3jbDXsVzblYz+G2JRVUySWX3aEviOwt7AufAx0ThXsNcc=
X-Google-Smtp-Source: AGHT+IEtVqtQQnVo8PHaSXN1K3Sc2Cf8P+sKm3QdUVwoE0JuCrOF0cXwevOrjax0u+LApJLfkKso+w==
X-Received: by 2002:a17:902:ec82:b0:223:5c33:56a8 with SMTP id d9443c01a7336-223f1d26109mr25099565ad.35.1741146280016;
        Tue, 04 Mar 2025 19:44:40 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:39 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v6 1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Wed,  5 Mar 2025 11:44:10 +0800
Message-Id: <20250305034414.2246870-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305034414.2246870-1-yschu@nuvoton.com>
References: <20250305034414.2246870-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Need to add a new compatible string to distinguish between different
hardware versions.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..4fbdcdac0aee 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - nuvoton,npcm845-i3c
+      - silvaco,i3c-master-v1
 
   reg:
     maxItems: 1
-- 
2.34.1


