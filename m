Return-Path: <linux-kernel+bounces-336575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048D983CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280591F22ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC353370;
	Tue, 24 Sep 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6PaH+q4"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B051B85F1;
	Tue, 24 Sep 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157909; cv=none; b=eD++/dK+GwiPKGK9ahAhxn0O3ouYOOp3/qBNU4TvbTtdMaptbXXyoyDvWJ5P2buy6twFciXv18fWa7QCoRZDQNGFxLDtk4OzPu7yJbqwIA7NXKm7a+NqJsDmibN/pGIbWDZGMRmiGfj+hz6hoeHRPqm6e+q14oygbdgT455h08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157909; c=relaxed/simple;
	bh=7Bju4tPN08sK/lIov1ISdks7vzglYBiJ5e6Upqyixn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E20ozxafluy7hC9t6rxa6woW3XGIpjLomrdZQKBTWNOA8NnlrBDerQnv/e6nAGZVSvpg/TknbLXpk+lTLkUl9Xq1G1oitBqV1cVWasgA6Nq5Nrw5aCuQ0Dr26j+6UcynliTEsNASpWfdmsGS/NM/sdFkKzKpjSmeb5EgSZGoW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6PaH+q4; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a1a3090f93so2291885ab.1;
        Mon, 23 Sep 2024 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727157907; x=1727762707; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvw3LV/Oa053/HRs5YyoBZtjEvrfytLSA0lSFHvT0vU=;
        b=F6PaH+q4OaaGP7HqF48IqQuK7o9EhEKqHryc9udwwiIRxSlHmn0rF1wT+QUyDrLSIT
         Abo0oiPl1VPtXTI4X/qhZG0OAI0PkktpbBo0DkpbAxgXxUylNIofpFe1NEVy+2JlztL9
         2NPL8Adp5XqevImQNK+xIlmpWl888K4g/pehpQIOPwPTHbT6XaOpKaX/X8K+mmhFNvbh
         Lc7qSzKJn1Ud4T1rwoubJNT5eKy5lssoWno/UhdNEUQ9iZn3EbEHK15DUmxmFHYlvzf9
         W5T8ZiB+jg5ay3AwVrK0K0Xy+hf+WT7NAnupmA8gtf+u9/E7ux5RPr39uyUZDrGqpAQs
         TDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727157907; x=1727762707;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvw3LV/Oa053/HRs5YyoBZtjEvrfytLSA0lSFHvT0vU=;
        b=wI+l2GqiB+Gm4zbbsxyUYf/qi4oX+lRc29bXVy+eOLsYVfpanDgWjm3wvOKwuqsWnU
         lbYcknjY19KzJs9qXSyE1LyAZLjrK2Y64/6T7b3ChMHOH+LG26naP2oQRZqdl4PRFPah
         t2nw4mBUTriwBKC1tBhN0gUPxynT9v14+zX+ui76EW+LCv9QkoKCYTYHcSPv0dMN73nv
         LzCRcADd+eJcCjnzpdLeATaY8rY1IxI7J9I3eTkqJvColTFRCECWlhQDCimIC0d8Eeuk
         Zhww/3MVxRXX+swnMA+EEPqXPRAxlIV72YxE+7LvycQuRTExL3PxSwT3VaqahVdHqNAm
         VSVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJxSf4k2Lkxpbshh9ebKGssVvxs7cDG/EACBMGbrkSgblfcfkDlQlZTyjx+iqauhJ+tsUBY4VMKB6HrXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ch8Jad8zTVyecvKCCO4fsviCZ9FmW+G9baPBNdE3FjPW7ZZ7
	Yh1w92lvZC0YjbS32JCds8DyMpcXCYltmjfLdyJHfsadtdYEniZG
X-Google-Smtp-Source: AGHT+IGpCNLo4QJ6irXwU5HSoyr7g5Dv9bZbIL8M1SDI74S0+MW58suHrJ1F4gQLr4eJvuE7YImsLw==
X-Received: by 2002:a05:6e02:1c04:b0:3a0:a0bd:f92b with SMTP id e9e14a558f8ab-3a0c9d251e7mr126778945ab.10.1727157906782;
        Mon, 23 Sep 2024 23:05:06 -0700 (PDT)
Received: from localhost ([188.253.115.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c7bcf2sm479624a12.84.2024.09.23.23.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:05:06 -0700 (PDT)
From: Junhui Liu <liujh2818@gmail.com>
X-Google-Original-From: Junhui Liu <liujh2818@outlook.com>
Subject: [PATCH 0/2] Add initial support for Canaan Kendryte K230 reset
 controller
Date: Tue, 24 Sep 2024 14:00:39 +0800
Message-Id: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdV8mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Nz3WwjYwPdotTi1BLdVItkU4sUkyTLZCMLJaCGgqLUtMwKsGHRsbW
 1ALFe0xlcAAAA
X-Change-ID: 20240917-k230-reset-e8c58d4b9c28
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <liujh2818@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727157904; l=793;
 i=liujh2818@outlook.com; s=20240831; h=from:subject:message-id;
 bh=7Bju4tPN08sK/lIov1ISdks7vzglYBiJ5e6Upqyixn4=;
 b=rqfaagOttMhupkn9HS8faJChX+Cedq+xMMDSoqNzCxRnRgQ5UrkJx2vU0QYF/y04JD8OCl7LY
 2Ln/MCdaITuD3LOiqhepTMbGZGHSejMadxQjueTFXNZm6p8c1hr4cOK
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=UPJ4WEhX1Oe+1ABSe4UlisQyfljdECO+XeTLv1VxTuY=

This patch series add reset controller support for the Canaan Kendryte
K230 SoC.

Tested on CanMV-K230-V1.1 board.

---
Junhui Liu (2):
      dt-bindings: reset: Add support for canaan,k230-rst
      reset: canaan: Add reset driver for Kendryte K230

 .../devicetree/bindings/reset/canaan,k230-rst.yaml |  39 +++
 drivers/reset/Kconfig                              |   8 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-k230.c                         | 321 +++++++++++++++++++++
 include/dt-bindings/reset/canaan,k230-rst.h        |  90 ++++++
 5 files changed, 459 insertions(+)
---
base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
change-id: 20240917-k230-reset-e8c58d4b9c28

Best regards,
-- 
Junhui Liu <liujh2818@outlook.com>


