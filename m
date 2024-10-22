Return-Path: <linux-kernel+bounces-375448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18069A9611
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D21C283E58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71B12FF72;
	Tue, 22 Oct 2024 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch9PbRXa"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5FC49652;
	Tue, 22 Oct 2024 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563280; cv=none; b=BCFYL2KNd91bIGukZdzSfehlG5/BbqW1zNiC12P1qaf9Os/CNjOXjoxbLvXc2JndeM82WluMgVN4wN03Pr0CV2Z1/staEyJKz7Dxx/O4xbs68q5Khw5ZXANi5Zbb5cLnbfT+dsDYyfnFL7l1llh2FdmLMEyGlaxIG16bSQ2AjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563280; c=relaxed/simple;
	bh=lmRdN/NfQRYrVoPPLNnnXG+7LtgKBJzlYQa493VKy3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RVuDcRkOccCmdFK5qebi124yVGccaqdSZ7UvozCOQ+34o04E/0d91c8L4RysAhYvr6v+gUk/yxzwZdeNVhHnyJT07BewT760BBCobfVPtf2N3wNaUNOqNiwYdDUA9+vJ93ptE5+IALbTreBjNeUCaf23KvLLh3xH3qpE1O+8NSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch9PbRXa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso3368083a91.3;
        Mon, 21 Oct 2024 19:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563278; x=1730168078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9BnD0Rp2EiJr3bIO3c5HrB43O9e3c0LIaoQOsYv1uKg=;
        b=ch9PbRXaG8Zh/E9lrvSzRYpvtsVXPhfpOSi3Ko9KMTgEdXAFfKC/fBXXowC8XVWTw+
         otrortonBbLNFvH4rMsp0AZR8jg6LTrlEYtXJdU2oK0s/gm383kHVyqPInX15Tm/i5sc
         KqnjRcstJDPYvKLJ4FcqMJzOqDZOAPkgxm0Qvwe9koxcZdCux2Ssd+JStvzYA5v7uj9X
         +67dw0V+XJExL9lLYUgrDffcFwWtgRQBREG8g4GK3MI8HzZsqg4IPrFJudBn2ktVWrUg
         mlMIiy5sAdH5r0ctnuII4h0atRbCgHVqJDaZGt5OP2kCwmQ/5snG1oT7LudrwN7wiVGc
         vaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563278; x=1730168078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BnD0Rp2EiJr3bIO3c5HrB43O9e3c0LIaoQOsYv1uKg=;
        b=tpE42CXyHKAA8APlHjGATYhiN2YAA9U19Gmb+GkLutQeVgzdx993eB9WIoTPAuntvY
         khDW/Mq3RJT2OMcYTtOEYKvkFe+aWVDLcFSu+a1qjVnvIy93HKcw2y4Q9ijJuFZ8R4MD
         nQqVKwlQDuuObfkLKeJ8oiN0C5StrHhHJe9yIWdUfVa2MbfO1s98Ge4fZ09nm7ksCkuE
         oRbZP6aF0QLqCyk65oQ1GozlCnSLm7rY3FDqf7Z47Was9Fi0Vdsr+wt/OYgpHjttc/v3
         4gJLXbkX4FXpSkoYZUR1I96vFRFr3hi2h4rRLjo+HVDdSKVxjtwPgCw5VJDT2aGS2w5o
         +hBA==
X-Forwarded-Encrypted: i=1; AJvYcCUKISoozhxQZ++RxENH7ELz2iaEiJhQCaN7gtW+tp4cKrjfEnQ+hj+r15i+B5ZWBITFcSZhXTtODTaxjCec@vger.kernel.org, AJvYcCUrZBgB5C28BrvahKTtT5Ibd0epDtKlMhyMVBiq/cSFYuKEcpdph8ogEYasXlDiS4fbYfmdMtIQEU9q@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCBMd5rlBuFaR9wfAx6b179mRrTIB/llh/yUj+0knOkoLdzcd
	D+F5ckjNqGtMU9KqpUyKJ0o2oGo1V5OxTil3NR2Wfv6bEJ5Ov1SK
X-Google-Smtp-Source: AGHT+IFKdGNEL9MsGDSC8rfEYNn+2FbX+ZohTl+p1qz2cYMHSc5oQ89mXhEWdJb1iKLNT9Im0tf9zQ==
X-Received: by 2002:a17:90b:33c2:b0:2e2:bb17:a322 with SMTP id 98e67ed59e1d1-2e56172b2e3mr14874260a91.35.1729563278091;
        Mon, 21 Oct 2024 19:14:38 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad512226sm4706537a91.54.2024.10.21.19.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 19:14:37 -0700 (PDT)
From: Jason-Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Tue, 22 Oct 2024 10:12:30 +0800
Message-Id: <20241022021230.2322132-1-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
Jason-Hsu (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 884 ++++++++++++++++++
 3 files changed, 886 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.34.1


