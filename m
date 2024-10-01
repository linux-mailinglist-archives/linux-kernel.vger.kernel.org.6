Return-Path: <linux-kernel+bounces-345702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027BA98B9FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75E6282409
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A831A08CE;
	Tue,  1 Oct 2024 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S78t62yF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E61BC9F0;
	Tue,  1 Oct 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779385; cv=none; b=CfGr26Fzfk4FmCWvH2gYaF2rR09qsMyI1eN0lUZ3hxUMRcDks/D4YOottrLdaPJus/paT3bS1PYQSgpTcCgOq21elloW5DaWvS8IZLYOZo5pexI3AR/AASZMnm7BrRE3JxQ3Jmh85MA0zdZuEK3fUGHyzNnrXUxRlJXKEiiI3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779385; c=relaxed/simple;
	bh=DIJd3A+pL3pwCvVpZYZHLv8qgZCCLKHcPaV5BNsBVZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/q80KGyCB/D6MWoxXN9LMCVNzms8M817kBGRwHCausLfUzoxrwpW5Ao03xOjP0vILeXDR35VYH0IK9hj9Xq6TpXRJ39+Y7OA6IMufpFcKfMa6UYskbcZKKPW2cpVybiUCYHDMkZAwRyQ87K1o34mAB0jN3pa2mfsgwyZsXO8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S78t62yF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso25438851fa.3;
        Tue, 01 Oct 2024 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727779382; x=1728384182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gTlEHj9Q71TsTr8MnAWDk5krfAyH76L06aPqx8tAa8=;
        b=S78t62yFLQLOe1uaSgoq/FBRjEmmka+nSHZthZik+QmDDMBEYwHVOacyZrwA4cQmDG
         m12uQn5DF6ezd31KQQuIwHtHA0DQ3gAJfy3g4hLTJ69pdEQPjFWo3A0wL9hlmKwezfzR
         9zFeOcJls9Tb0aLIJMS6lGWLs57J6IHIrc7h2wnA8A9rh0nXlBd7cTxfLv618iiLroUq
         jE7R+xrQCzdXO+nB8kkVoYZiOEvUWKGqq2BqfNZk2Koz3EdxP7lRbdynG7jtstTNqAc6
         2kBs2oSg7QF0QUjAzwHvmCoVu1ZPvnEsscF4iEVpJVDcg/Fga4yRJorSyaODPqoWiztp
         JI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779382; x=1728384182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gTlEHj9Q71TsTr8MnAWDk5krfAyH76L06aPqx8tAa8=;
        b=vpY3lvCE/1qDPAwACmE4J2Zed7IxDhSNVQw//7wD5WlJSeiYCEr2e8Wrm0x6sBHsQN
         HiMNSLcnSQc8M9hZ477n5n0H755D5Dm8x1yvSkAPmUv/j6hZXxOUXIW/1xM+Fr8PSkp8
         Zdmmdf4NLVilkcCxc4EjLLHPSJFYWpqoz/6fKcIOTnPDRm+050mw8mnpS8xcXaHGLB0c
         NLlCO114c8nWb8HrV+TXv9EhqFt4ZxN0gkZvP2eICqogPS5w/br/rjPYQylTMzmwrJNT
         6xBNlTqL9yrTgywgrESqTEjui/Eu2qGuGsq602u7Q/ZhvtChi/6OeaZunr+KdTWlK9Ki
         X0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUygHPTgwImw8LX/OLRBubJ+CRzuXXiVFa/seYR1XI6pBX3i/OLk1orEZuU+asDH/LgEmLU1qa1KK5u@vger.kernel.org, AJvYcCWLTeQaXHpJ5/EIallw0OXqCMv6imDbKTwp2w1/Jwt9bEzQq868ksz7RiGAQtxG7Cf/yDgXZpWqFCejTRg3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+9rwOK+pyqLInlu6nhH7mNKbppN57uAQWeB2vbmLzjlW/hNN
	ZzMFUedI9mBljW5XVEfgLKGtLZrCDiVRv7PIDF3SqO4+UvclCNwS
X-Google-Smtp-Source: AGHT+IHX8+dV27BgFxvhe7PgklGbWFHUwtV8QZVgBSzLO1UxzH6RYRRuhcBk2foBeqx2XCgYXnpEPg==
X-Received: by 2002:a05:6512:220a:b0:539:9155:e8c1 with SMTP id 2adb3069b0e04-5399155ebcbmr5899268e87.8.1727779381471;
        Tue, 01 Oct 2024 03:43:01 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd53a02sm1549026e87.31.2024.10.01.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:43:00 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 01 Oct 2024 12:42:27 +0200
Subject: [PATCH 2/2] dt-bindings: mtd: davinci: add support for on-die ECC
 engine type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-ondie-v1-2-a3daae15c89d@gmail.com>
References: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
In-Reply-To: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=850;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=DIJd3A+pL3pwCvVpZYZHLv8qgZCCLKHcPaV5BNsBVZk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm+9InEINnOwjIHtlMxxzHGWORqR+nk3f8q/rL8
 0qVC7qXfzqJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZvvSJwAKCRCIgE5vWV1S
 MvuKD/0bJQJF5QZD7y7FYMLNQFq8G5Hv0kKNNl6Lcvtglhj638zTGcP+Gr0sSYK8vfY3aFZKt2G
 2OWmJW+3v7c2EscvBkvAASkpA5nr2lRmREjXZ3muAB9iSRLj6tohbH/Y9RvxDUuB9VkEpim4XaE
 hO0pYLGx+LdcuxAKRL6Ma/11wxHSylgMeReeWTElr+RK1dv/5B/PCV+a+EyA0THAGPEAC5gkZe2
 iqJ3u1H8+Q01v3hQ38ZOFcQChUS5EKdmI2BSnXWTGJ2Jb/siIWuqhgp9lvpxOuWZejqMyZdlnR/
 1r8KQPfZJdGdwBVF16YsKYP6d69jesXT3aB+hzBAJA1+k3P56JJEc+M2wT6Bz/MjWLsaOEGAoX9
 9EjYwNxE4qCuKxpQYcgJ4+ltx6Ptt1ZvM5WtYV2FuOX5yDHCTvHD5b82TM11fUHWyMT7BC9Z8PD
 HpXP22b18gYGOByVvEK17MtB4DHfOgPY5nJJmhAVZ/ddUnHjT0fpHkIRBqR1cE01uTx2UiAIaNh
 V+4ZYUg6LPjvmV78Ju/3SYBEsII9gfRuu2ge8RT2if8A3MSWjtSLbmu2ES14LtDDqirZb5x02SH
 YKBp4gB64ZQjkOcUmDkazt7IATGcRjImYM3Gxd1tWDt9oJ2+bPPf/rnjqendWs2IN/1STmgdLJl
 /jgofbW5aCEE1zQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
index eb8e2ff4dbd2901b3c396f2e66c1f590a32dcf67..9afda5cd956494c6b3171bdbaecaeb289acd64ea 100644
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
@@ -44,6 +44,7 @@ Recommended properties :
 				- "none"
 				- "soft"
 				- "hw"
+				- "on-die"
 
 - ti,davinci-ecc-bits:		used ECC bits, currently supported 1 or 4.
 

-- 
2.46.0


