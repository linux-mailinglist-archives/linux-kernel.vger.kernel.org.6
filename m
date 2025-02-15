Return-Path: <linux-kernel+bounces-516109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1FA36D07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F223B13EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBD1C5F13;
	Sat, 15 Feb 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1AaPquw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB51AB531;
	Sat, 15 Feb 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612400; cv=none; b=KzMbFZqKGJytBZOGtyjc0EqwhtkLcTAohB4SwbVtTvlJEsolbkRxMhSn2UEWPgvRedAeQS2dWQC6gOSQkxc/47LmPX/1cPURlKZeuAew/kst1uyLGFrjxpOIodX5PWOf0Yi+RzPXDYcyUdIcDCtYQmB/F6Vmeh2FLC/isp20CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612400; c=relaxed/simple;
	bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRv7WT5+JYBRVtFlZmqAN1LArQ8HT6t6Kc9u0u2r1rS8BeU6NYp/ZHBx8oiOqs5q4FxvDZgsV5+PQVqBwDPFzxXdw7D81+R/ZzBuCcOAuLLkknpSQ2F8TkY3oIiK+kURD1xipUiqTDER3iWSPzOANYMcoV0zJizTwr46sKnxc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1AaPquw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so4015650a12.2;
        Sat, 15 Feb 2025 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612397; x=1740217197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=V1AaPquwvpa/0nIg79JJKSY9eYDR58micFQbk/MG14QTrsPDX+zVVIVbPm/QBCNaaW
         82ATiCPceX3LYqyEhdYXBBROd1XqGYkCpSuS7EdpX46/McHcI5tVrW3nOKyuiDgZOe6Q
         +WnVy05YWC4Enp9QXhZWan/rV2WS+AQofck3qncNPFMfPb47ayNnd8h8zOwkZOAJWYo9
         9g+Ur02GxkH2qC3eZS5RPtKH0r4+9l+go/hYawSTDaSsfv7vFgEJpB0WSGHbUKWeQTo4
         uk5BPSHlGV9Wrdh2GCckq6CTZC5M1LBvVx2fmKBAVa1pOxkc8eMTiiBnrvJY1E1I15MW
         FOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612397; x=1740217197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8i2lzKiQXFgJCM32Stuyrr5VV9AUaCS/hseyM/SiD4=;
        b=eT5uKtAFbLZkzU0Fiud0Oca/JCfhE3LDQ73Z2rVCEN3Vx1QwAoxhOLUxs+oFZgXLSM
         POnQnOHY3qP50gSmaSYHbKIFl0j/5Lh0ol9GlA0HqvzG2qbGbUvGuoz05fp03gr4xbpZ
         9Ih3vhbGyHhOYpW45jW/hp2W2JkC6GkO38XEmOcjIIyVGfoDQPXFbQjUHE3oxeMqw+XM
         W1uHAzm8CSkwSg1PqzFRfn4Rr7wbsPu7ZW7nAJMDNS9mdnmiLsn1sgTl2xTXDTSx+zdD
         Ui/IiVIsuy7hJ1hHGTSu7dqtlFC2n15mnX3SFk5xYlpcMH36rlkJIgjhftjqMDcM3gce
         7mng==
X-Forwarded-Encrypted: i=1; AJvYcCW9YGF1q1XWkZkpuqe5X/4/281vOusMUQb8gK/hWRwdMNhHH6F3meFBeSp6xukIfxQ8L0e72Js8N0ZDGMcl@vger.kernel.org, AJvYcCWpOGZ30Dkhaypt1KiaWVSOSA4Q89UFwovBPpCByik/fdUXnboAwSF53SMRzvQMgKOBT3CUF+xKM+x1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HN+s/jt1YcyviDk89nySuB8XszGR5KiwnxfB43IPG4c6b08q
	oBffh4eQBc1oR3o9TFxUApRXLwJU9Sq2wejwt26XQt8M4EJCDFHC
X-Gm-Gg: ASbGncsMpKLGU9ypStlxPuMi8MR+J/xla2NlabMhye/xoK+5h98TTjJnnmTA1Yiozie
	imVJi9M0Lv3Um/RNsOb2MTQf4o4I8WdvMZlvuo+Y/8v48lXfx+WG0Xyw09P1mXOWgaGQdBPMj4c
	CuXyFzt5PAZg17gKXqUFWGRfco8v1+oqKq1ucQzxa3lKkczYlUGMGiWzLz0bfhcUy+chUq/9hn6
	Fua9coUmd0M44QY8E5ZGNNrG5tnO4o0perEjPFCR5eXgJJC3z9dJ3ipByyzUgAdojEyogw/qWwy
	BOcORIcqeAhOSOgKbo8SMxd+CjOjJ06NAbWQqtEoIiS/nVJRtUfV/scs230wbg==
X-Google-Smtp-Source: AGHT+IGBNxf7QRukB9YNTcF9z5UPDHR1Qg0t+NZS7yEeq1ag8nojEeZW3mk830V/Fks54naT61DK8g==
X-Received: by 2002:a17:906:4fd5:b0:ab3:4b0c:ea44 with SMTP id a640c23a62f3a-abb7091d9e1mr203583866b.9.1739612396772;
        Sat, 15 Feb 2025 01:39:56 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:55 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:41 +0100
Subject: [PATCH v4 6/9] regulator: bcm590xx: Use dev_err_probe for
 regulator register error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-6-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=1115;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=By/MtmZFNRfjDngs4ERybGWRLb6s1X3+TidkVsSq1AQ=;
 b=R9XvjJGcaWdPCm6Jdi9wNLsTkzSlSOR4omPAt1XaPtxtdvO3uQoccX9JuyxahL3oA/jBwN4Rk
 NCdbNz82H/jDmOxvkm41aGcQgATe0Pgy0S1fpbbPs3Z17eLzSk27nG1
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Instead of calling dev_err() and returning PTR_ERR(...) separately, use
a single "return dev_err_probe" statement.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Added this commit
---
 drivers/regulator/bcm590xx-regulator.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 9f0cda46b01506080ae5fa709104a8df4d174a8d..a17311fa30e4d48c0a4925778d7bed486ac7a982 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -340,12 +340,10 @@ static int bcm590xx_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, &pmu->desc[i],
 					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(bcm590xx->dev,
-				"failed to register %s regulator\n",
-				pdev->name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(bcm590xx->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     pdev->name);
 	}
 
 	return 0;

-- 
2.48.1


