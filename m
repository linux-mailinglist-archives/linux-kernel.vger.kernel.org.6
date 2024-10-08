Return-Path: <linux-kernel+bounces-354620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6099405B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC08E1F2686D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981D1F8934;
	Tue,  8 Oct 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHFRLXh6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9401531F8;
	Tue,  8 Oct 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370998; cv=none; b=alqO7I0L7xZcy0WULATCif69aeSmgkDJ3bB8wbkySuALnrUdvcR+E8mO35YPr1vVM7PKeRLIeaNyRyZa8+B7zjY4RJSzEZXMUJFTexX2cSgLSuvGdMQ5/3gExoNVRPlJr2murRTCKkOYsP612WVn215stVJu8po0FDB8wNtsSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370998; c=relaxed/simple;
	bh=v1ryDfcLRmbqFdjGYQserfXxFAXhoyLUU4PAJa6uujk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J9hqDISPIx2PalcDwlfXcPXP7BlfQN72Luahd0V7LVM0uv4uhw51HFOiz15um3FqwNAxxwSDCXqfcGQLbIWbKkX+oGG9LtSciYpZzpy67sKQ0ynteIRIS60/kyqwu0XdoPGrYmAt9icmvnwY8gd5vjLqPjT7kkhxrSESm6pnLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHFRLXh6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso71317051fa.1;
        Tue, 08 Oct 2024 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370995; x=1728975795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3odNuYZMIed7GPFFvu+8iyQutKfD23rD48CKfcifKo4=;
        b=YHFRLXh6yO6BfeQu5GveEcCyOe13zFNdZPPkmxXd9yklCM4qmSvA0ML4wgHTa+W9pn
         GWBFCSpSYjQEuybQ5PcwfzOgMz7QmNPyGQCM+ZXTSypYLpOVztnhnUHfP5ndNRAtS1Fx
         EkqxWhnWOzzn0nley+aVWCy3cUOZd1olh5DEQ/PZNNak/0TipIQRrbENnwlN++CMemo1
         lXI25CSwOgbkKoABbdlqsuVfNFhWIueXYw8h4nuAjiQVFaWwe75Pkh/MEf+7hq0bCzlv
         AdzkN4rM7Vi5O+SzxzDxq4UazAT3V/W6sto8YLz0RBpaYV2XvPzIORea+X+sYBvWaPzs
         G8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370995; x=1728975795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3odNuYZMIed7GPFFvu+8iyQutKfD23rD48CKfcifKo4=;
        b=mx0HIvVPW339d+nkBIHbAESFpFzQ5FTRIlADxm7+jbTE6brb3EVlg0FobcB4g7AEBY
         9eiTttwVm/gBCFrLWpYgjPkyR5u76SVNXT6Ckewzrja4luYKXneXWt20EWBRACY0eiil
         mk9pYXhfemZpKEQMXNNUCLiSP8HwD30rHDEVnjHwHeY4nQ0MHnVCKNcXw8GVuBTKcB/+
         9xhHoSnX9O2qhnjp9o1J3pXrggm2Qn4rI1G696ToLOIFFYIzRYIyYpZVMQ4eI5jQsCjM
         t5+NF8Urm002acKm6GRvEfYPFcn7kBLEiTvALIecv7j4YDdgfZNx7L+pSTQHP2XnWcVX
         rVqw==
X-Forwarded-Encrypted: i=1; AJvYcCU+7slFX/r5yr57RJA1gNK22xfX/5szu8edVmn2H3bXsGwmIJk55XIVhD0D0lq/5VBJrC3nB0g/Ya7o@vger.kernel.org, AJvYcCXvUWe1fPitZG1ItRx8OkXAln9RA5tOxWy8samJBCPBBlUqEvbUwCmGBb7WqjsT8AB22pGopRODDKZ99fTW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfKo1DjeE7XeU5i6tZfWRDeJfRoAsfKMyW9YExZ9x9o79aSTE
	1FQt83u7LQshxc0xeExd1iOzLfMJHikQMeIpgyaYKWGG+Fi2OuDlwTgxTGh7
X-Google-Smtp-Source: AGHT+IEfNLkriaz7+/4s5VSk0K+230xqJBPz5JzlUF4SD1mzhZtYMEhqghlhFXeJ3pXae7VqHj1GWg==
X-Received: by 2002:a2e:d11:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2faf3d728a6mr70396921fa.36.1728370994290;
        Tue, 08 Oct 2024 00:03:14 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab1564sm10972441fa.7.2024.10.08.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:03:12 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v5 0/2] Add support for "on-die" ECC on Davinci.
Date: Tue, 08 Oct 2024 09:02:43 +0200
Message-Id: <20241008-ondie-v5-0-041ca4ccc5ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPZBGcC/13O3wqDIBiH4VsJj+fQT226o93H2IH5p4SVQ0dsR
 Pc+C4LW4e/D58UJZZeCy+haTSi5MeQQhzLEqUKm00PrcLBlIyDAKSEUx8EGhzVx1niQXvIalbe
 v5Hz4rJ37o+wu5HdM3zU70uV6LIwUE6yZ1dpRYaSyt7bX4Xk2sUdLYYS9gk1BUYxKKmorzaXhR
 8X2SmyKFcWFssowABDmqPhe1ZviRXmvGuWt0pL+/XCe5x+s1i4jPAEAAA==
X-Change-ID: 20241001-ondie-a0edcf28f846
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=v1ryDfcLRmbqFdjGYQserfXxFAXhoyLUU4PAJa6uujk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnBNkYO4fNCiJWIun0WJ4yoyLNkBfPwNopdcJXH
 C1z8bQmHzeJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZwTZGAAKCRCIgE5vWV1S
 MkT4D/4oMThEmNMRBinGponXs8SS8C4WemPlMSCOlJByVJS9uSrmfMOXeIbLF2AIWVknh0/Cx2m
 ao0bhsEQU5qyM0l9UayNM4aXc5NTlQMwK4zWhWR2RX2tfrypaTTkWyu7jQyWqH/nkHKolZ+MENT
 3+epYzHGEFNTrkVReJk4xprZXSwmVK49cRxQNdfwH9rBaz/SKZFebf+rvVWHlL0AAdYzO2Wt4Z5
 xroLG5c+HYYxwJyZcP4FjkeEjRxX9GYNOU6+V/UP9FKdw5+1mHHWUEFuNghH2sADFRrdtWDZIZt
 qhoEGpDl5f4OYCvD+TyAsYE8FfXGJemMZTuPEmT2liGLZSFq7lKnTGNo7ERf27+P8M5YKZ1vmvK
 3LtWVxXKrFF4NcqbE39a0wwaey+wlDig/Pd08nxotzR9ojg6snvBHqVI44ClYcSK83fPo4apUY0
 VQEuDm7+S5q1lSwlmb1WuLnvitusM+pHVMT7BF5li5ZZoR9OkmVf2tNcPHCokFCGKDTKyllFH+a
 0Vy2hkJh8fKH038yxQVZPXrQj9veF+cZR12Suc8tE/wl/X4czzU5i9ZCNgGtPwNAnarSs36vmR/
 dHMjRigHtu3AbogwNtULF3XIVlC4Xm/77Z3U3Fdjsl2tjKpEacW7K4VYSTsYFLtcsoBylqCaE0d
 pmX49IGcKTkiq6Q==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
Add "on-die" as ECC engine type in order to be compatible with those.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
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

 .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -----------------
 .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 115 +++++++++++++++++++++
 drivers/mtd/nand/raw/davinci_nand.c                |   5 +-
 3 files changed, 119 insertions(+), 95 deletions(-)
---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241001-ondie-a0edcf28f846

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


