Return-Path: <linux-kernel+bounces-399575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72459C0100
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE4B1C21415
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E681DF273;
	Thu,  7 Nov 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbmskvcb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA63192B73;
	Thu,  7 Nov 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971219; cv=none; b=IFqiI3mnt73dtuc7cKtWBUt8v8yAjbpf0Xl/VSlQX3EFJZAKoBNkY/8jZkxO7hRxRhMjN5Z+uXzD4HnyFdnA++fnuM5MzJr3xM5tdkC9ut2JF0ZoWDEkyraZ/hMz708AUcx1Vz591AK7shIFN0WENb4EPIIp+0+z1dkP1rwA2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971219; c=relaxed/simple;
	bh=5jlkJyomE6DfZDoE1w6hrt0hHvrFRjvdP6lxVp7uq8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rkyapCEWaUko38Rani+daeGORjbMuSnchzmDtx0Pr44qitSoevxLGkouYMfXsTM6HVi06HlIflK/edmrkHDndW9MyuQs9+h7QLv9uaY9CA9dgrAoB/A3ik3vG0nf94zbAuMB2iArLifOy5XW6qt69tKEYBHixG8LTdjCBircFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbmskvcb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e6c754bdso553111e87.2;
        Thu, 07 Nov 2024 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730971215; x=1731576015; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3651cek48NeZz9A/pb2JfiUOC/sc5HtWdmGHZb/MRSQ=;
        b=Sbmskvcb5D5qAlDFWYmVGW4AcTfbVBCxNtFi2oAX9bCdFoWVsXvpIWMKmDwNnVEQkt
         v1zuSajDTaV9czKh0PKL9zOjHJN8ZgPeNbXayWdjaSqj5Gkx6KqPzLnd/oPyJBtgFI1w
         McBXE+vqTzFPXgBcpFt2BmVlj1I5gVzh3MOkmXtI5q7BVyrOy7+OCAL2ztr66pwaVtU6
         ROhyGAFdGMOfPX9kU1Q4yX5PaDcC1LNaRVcUZS79MOSbRQlJpgLBBJ/BzdxvFaqr5nY8
         A6buvvxsojfEIfWcQXy1CsX4hK3ArFHXj0sz6WjFOEpzUxnKJlmO+VOrwoWe7omlJv5y
         Jo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971215; x=1731576015;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3651cek48NeZz9A/pb2JfiUOC/sc5HtWdmGHZb/MRSQ=;
        b=TKHOr/eiJo5IosNBtTpZ9+DINa6dFgbT15gquqlWyk/8Fsok/RQcK7Orxu7sqd5PxY
         cSTKnEadb9lPzx9+5SZFkceXyAcpQ4I+RuWsIhspNu9P9po9GWbgWiXj4viqPf7G4wQ5
         SS07OmnlAV6oh7paXhn7vo+YDOt0Q12yG2IDGcC4q5wKsG1BlRyG/G+M+91ixxSLI5oK
         so2FB4bmIdbDw4HZF4wCtYM7JHSTUxCg5Ko9PzCEKuZw+Z/zeeBoLPIbtKZU1bwFDRvv
         z5I77SxrMEg4GnoQUsa3stjMkOf6qFVdBCJwELXAyBK9bk8528g6CDG/jLQXzBa7dDjT
         i+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWd0TGhvA/528454cbb/uTjNGrw/C5ReX95/N+ZWGlWpBE6xtPPN6w1k7gkYX8WTYBnL2F/eV+57ZnHrOoE@vger.kernel.org, AJvYcCWoIIbfZ/eoTbj/1ICSgG1NBwv66tYm7QBXIWw5bkcZ2YaOOfEDt9oOBYO8ukpbw5bX1pDY9xiCre1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+hRfXa5Rab9UmGwcdfL9xX2V6kgSo2ozttfKxcNIMxreUR6n
	UKViDj6/S0P5+WyIWXJ9yTJABJu+5xxVjHJYt2bdGPOO5Jn/enHFLHBp9qbY
X-Google-Smtp-Source: AGHT+IGMz/+uze56D22bk4S6NEoAUjQkOYYD4ynOIKx/3GTeCzY4+lzBKIqEvvNJaSoYLinRiOM5VQ==
X-Received: by 2002:a05:6512:3988:b0:536:9f72:c427 with SMTP id 2adb3069b0e04-53d84085e5dmr189216e87.28.1730971214867;
        Thu, 07 Nov 2024 01:20:14 -0800 (PST)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9b50sm139509e87.182.2024.11.07.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:20:13 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v6 0/2] Add support for "on-die" ECC on Davinci.
Date: Thu, 07 Nov 2024 10:19:52 +0100
Message-Id: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiGLGcC/2XOwQoCIRDG8VcJzxnOqJt26j2ig41jCbUbu7EUs
 e+eBQuyHb/B3x/fYuA+8yB2q7foecxD7toymvVK0CW0Z5Y5li1QoQGlQHZtzCyD4kgJXXKmEeX
 tveeUn7/O4Vj2JQ+Prn/9siN8r8vCCFLJoGMIDJacj/vzLeTrhrqb+BZGrBXOCovS4MA20dH2Z
 JZK18rOShdlrI+eNCJaWipTq2ZWpqiU/Mmn6IODvx/aWrlZ2aKUAQqGiCxzraZp+gDQ/oUJcgE
 AAA==
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=5jlkJyomE6DfZDoE1w6hrt0hHvrFRjvdP6lxVp7uq8k=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnLIY6G6Nlk3NfPIe9Hidmf95exOo1gFpPgkgjm
 wfk4xGjA4mJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZyyGOgAKCRCIgE5vWV1S
 MgntEADZC8TWSRg567xCulsZBgj0w6oebflUeUlV6l96cFLfiIHaaavU5YqyuUAo8im1ntHu6cZ
 UyK2XSlUeOgYKa2Muj3snCI38SNswIthKxQaH9uYACSY5cQ1DbCznONSp0lFiYpKgWVz0sGXbIw
 I+g4ojK56WzdOg0GKkct8ARwOa8Ji6Vzts6VrU54OQOchXT9zTEaMshiTXgUx3mRqcU4SOXUkZu
 Ya2gzETCwdUAbmnS9CCSAexlCKRbMGA430RrWiYUGpKrmSqmDEvi7E8hieBcYZpngOeXn1e5Xf1
 Lsie7Qv+6ae/E1CD05onUOrjY/NlKTeM9d88BzQU8AOPeCG5OeJlgm6wIovu6Vmt2oM6llxItKO
 5tTV1/BR2QQPKcCrzMKOv6ugOWuDfs+K2tQ1Ung/7F7pC32lzKZAK+4/GPpkSR1z1K29NoRNYwA
 JAB+USBaHIbxSA5w7V2esDFvFFkP4PURM9oWdYV4YuSnBh3lbzpSyRLpwFMT0UVd20G+ckYo+HA
 MRE7qvW2DwVG7YJyDyPyzkFQx6jkgnOiMXCDqsLW52eFmF1w5tnnCpM8E42ms4whrckpoqifems
 2Xq7OxjaYhpr/cPTK3BhfSfXLvJhcAQNHqdo+iRRxuoDxM64vW7sDbyvpCQ48qUyUrYOU38LSzn
 uHfuH/ssgw+dNIQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v6:
- Rework the example snippet
- Link to v5: https://lore.kernel.org/r/20241008-ondie-v5-0-041ca4ccc5ee@gmail.com

Changes in v5:
- change "additionalProperties: true" to "unevaluatedProperties: false"
- Link to v4: https://lore.kernel.org/r/20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com

Changes in v4:
- Silent errors in `make  dt_binding_check  DT_SCHEMA_FILES=ti,davinci-nand.yaml`
- Link to v3: https://lore.kernel.org/r/20241005-ondie-v3-0-459d9c32225c@gmail.com

Changes in v3:
- Fix formatting issues in yaml file
- Link to v2: https://lore.kernel.org/r/20241002-ondie-v2-0-318156d8c7b4@gmail.com

Changes in v2:
- Convert dt-bindings file to yaml
- Link to v1: https://lore.kernel.org/r/20241001-ondie-v1-0-a3daae15c89d@gmail.com

---
Marcus Folkesson (2):
      mtd: nand: davinci: add support for on-die ECC engine type
      dt-bindings: mtd: davinci: convert to yaml

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ---------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 134 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 138 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


