Return-Path: <linux-kernel+bounces-345700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A998B9F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E25B234AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB01A0AF4;
	Tue,  1 Oct 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebJ2GFuD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338C1AF4E9;
	Tue,  1 Oct 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779380; cv=none; b=hFx3vNsjJUxhYpWqssosPi8UO0MoJ5lYApFCw+nGSmRvZcLmHULeR38OyCIrvIa7QNZutMdwZJAPPsxRbVbV820RDOT7IZpS2kg+MDXcjGIjPGNzseYsUvnc/eQiiNSwB2tVvxAj7qrGiH/dkVV1dP1no6N8BpdtukHljHSr/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779380; c=relaxed/simple;
	bh=d1PQK289BSU35xE6WGSlFhMFQXuGtUy07ku8cjE5FcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=itLNw3VpEdqTWG7nuBEzr1lZvlNx/R2FwDi/A3PrwwHOL2QP67GRj/3cP2Jtv2vXsh2JCAYWn4aOeqzAxgcIwdvBMKWjwFnfEBeWdFrbbv/8BCY9z9zBKUOZDUcP7pZYcVc7REkLi284pdiaCY6Go0KNSDyW0CGaBxt+XvD2URM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebJ2GFuD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so3033175e87.1;
        Tue, 01 Oct 2024 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727779377; x=1728384177; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naMF/l/IHSW+to8I1m3VaAoTJMDALGQmSCST6CPFt1A=;
        b=ebJ2GFuDVrYyqM+p1ubqMX98i19ZHcItpqOanGl394fWuhAfbCRJ36JBOxCGM08JC/
         zM1+GxX5/xhhHi7kN0nQZT27I51udNPgdUKF2It2kPcoEGqILBQwMuQcNoIzeh+WIYXw
         aAzkkQSH+Q/jqfZ/DWKS4zjUQ8EoXtcfyw9EZUKl6sWckt+HanTr+UCurnodCO1/MI76
         MIJMqGA0UisxqIZMAfLrDcdaY9UcOAiWanIqsD6P2i04CebmAh9kjQhVcV+QKkEQeFW/
         VYwWfheb+ZqiDwF9X/kyK8R5hN7nZ/4+8k3Xk/Dw4cXaffkPfk7seEAx79jW9hJLDycH
         zowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779377; x=1728384177;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naMF/l/IHSW+to8I1m3VaAoTJMDALGQmSCST6CPFt1A=;
        b=tX745NSiF+hv2vd2KNXzpxteCPGzkd5cThu5TOPOSQGsdj2p8g3dxxnxooewWsqdY5
         r1ROIgvsRKccYDEHgxQxsQZmjW9V6cAE6KXOSqm7PuTJRajsdgyX+QBMf75faIGA6y39
         FJWLrII2aHIV6kIqTg+79DsQ4p1lseWKjfpmgJQgMz4yZk6jkuhSgpPTsAFldAKBAg7l
         zkaOG0vPFgNdYXv4fFv1umJ2GphE6eNyxNGNQWE7zgauY9WWYKBpe/KHKuYi7r3gCbgr
         nPdgWtuTiWn2bnc1bxFmu6DhQpVirsvRdnMhVuTNR8+QdVxLyv/UMYB7VkDNK2W00boB
         Hc0A==
X-Forwarded-Encrypted: i=1; AJvYcCVl6g92IocPvMGGUK3BzCVDj8paKKGD4NgXiH0pOtJ/B5TUeJiynTPJsm7OXpW89OdGMmouhdJaIpQC@vger.kernel.org, AJvYcCXY2k9QTt6NNPF+VZun4r/HLsy/BPz6SK/xCAPjxOrKH7n8FAL1lwqEV+UYUD4zcAwX1fUjLIicy3EOnPmm@vger.kernel.org
X-Gm-Message-State: AOJu0YxWakVRtxn2WodqnINu7pniwRyYjC8+tgrfBKJ6vg5PQBUtY31q
	5S+vr6z7psig+pi8hhCVoXOrS5Fmj4b1GAdx9TLgcgSujxY5ccls
X-Google-Smtp-Source: AGHT+IEJklcMNhmdyHGs+kK14TKBk2cy/xU8EIYfUzkf44jpkUKK+rCmwUXC/2cf7Ms+RFK4D8Gm5Q==
X-Received: by 2002:a05:6512:114c:b0:536:a68e:86f0 with SMTP id 2adb3069b0e04-5389fc46c8bmr7113967e87.27.1727779376484;
        Tue, 01 Oct 2024 03:42:56 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd53a02sm1549026e87.31.2024.10.01.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:42:54 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 0/2] Add support for "on-die" ECC on Davinci.
Date: Tue, 01 Oct 2024 12:42:25 +0200
Message-Id: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABHS+2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwND3fy8lMxU3USD1JTkNCOLNAsTMyWg2oKi1LTMCrA50bG1tQDlFzi
 LVwAAAA==
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=d1PQK289BSU35xE6WGSlFhMFQXuGtUy07ku8cjE5FcU=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm+9IcNG/eVdtK/HlUY2IBtqrRx9j5f0LiUVFka
 uDp6wR/34mJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZvvSHAAKCRCIgE5vWV1S
 MqygD/9eX5rX2CUkf3yHMoYszRbKf4x0nXtEPBSLF5doPyfVY1shV6g3sq5kwwhVU6ymmnpsPCS
 2jbd8xw1fiQEZo0dSGAgjDzDaZs8lcJX3FactcBHdDFHyfccGEy/tuDLW3f+IZeN531cdfLk/MY
 9aYlxCst1rdfS92twXs1zaax4JEvK7KEgVFVoJXf/ZSbRWT5C6DAkLeJHYQEjtJFz9p9q3ra4Yw
 ReFMsp3IPkgOp2NoApAHFj7QZ47Md75tNHdd93AgM0w7zSqiFa/m4F0+kZQzBb3F95ThusrSZ1X
 wqRj3zhoNNS/RvtGUoF1LoY47PufVrhqNDC6tMOiGgKeriILxYZ8QdM2uKJMbj5LIT3gyjN+4O4
 rbzwMCgJFpQbuoRpOahuB5IQf0oN19nF8crfAA9fK2uuZfQos514PwdFVQ+OahBTmaJyswMWMTo
 VfhhAjaGgmctKeAJIcfjXhAbldwoqgGyX1m+JDnm6kfTKyk0JTrVtnjzhf3df69Ds/TQqIe9ZbX
 2LUD2PQPWlzUiLc2uUcHoQ7NW+LJKrlbFpcExDrWUDJSGuYSexXx6gMFqu6Lq+mplMm1bwC59+G
 /wXuzEtAJ6DSCqjJLO9+XKcuI+5tVMsAq+pID4mW8w5aGjsx5QDqN/ttL2PLVESRQQBOImgAGNk
 Q0XkOTcB0FA5wQQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Marcus Folkesson (2):
      mtd: nand: davinci: add support for on-die ECC engine type
      dt-bindings: mtd: davinci: add support for on-die ECC engine type

 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 1 +
 drivers/mtd/nand/raw/davinci_nand.c                    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


